# build.ps1 Build append_byte_fasm.exe with maximum zero elimination
# Post-processes FASM output to match the hex_writer.bat reference layout.
#
# Copyright (c) 2026 lRENyaaa (https://github.com/lRENyaaa)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
param([switch]$NoFill)

$ErrorActionPreference = "Stop"
$Fasm = ".\FASM\FASM.EXE"
$Src  = "append_byte_fasm.asm"
$Exe  = "append_byte_fasm.exe"

# 1. Assemble
Write-Host "=== FASM ==="
& $Fasm $Src $Exe
if ($LASTEXITCODE -ne 0) { throw "FASM failed" }

# 2. Post-process: apply byte-level patches to match hex_writer.bat output
if (-not $NoFill) {
    Write-Host "=== Fill zero gaps ==="
    $b = [System.IO.File]::ReadAllBytes((Resolve-Path $Exe))
    $before = ($b | Where-Object { $_ -eq 0 }).Count

    # --- DOS Header: change field values to eliminate embedded 0x00 ---
    $b[0x03] = 0xCC  # e_cblp[1]   (was 0x00 from 0x0080)
    $b[0x09] = 0xCC  # e_cparhdr[1] (was 0x00 from 0x0004)
    $b[0x0B] = 0xCC  # e_minalloc[1](was 0x00 from 0x0010)

    # --- DOS Header: fill reserved regions ---
    for ($i = 0x05; $i -le 0x07; $i++) { $b[$i] = 0xCC }  # e_crlc (3B)
    for ($i = 0x0E; $i -le 0x0F; $i++) { $b[$i] = 0xCC }  # e_ss (2B)
    for ($i = 0x12; $i -le 0x17; $i++) { $b[$i] = 0xCC }  # e_csum+e_ip+e_cs (6B)
    for ($i = 0x1B; $i -le 0x3B; $i++) { $b[$i] = 0xCC }  # e_ovno+e_res2 (0x1A kept as 0x00)

    # --- DOS stub: shift message 1 byte left, fill tail with CC ---
    # hex_writer inserts a NUL at 0x045; FASM starts code at 0x045.
    # Shift 0x045-0x077 right by 1, put 0x00 at 0x045, CC-fill 0x079-0x07F.
    $stubLen = 0x33                                 # 0x077 - 0x045 + 1 = 0x33 bytes
    for ($i = $stubLen - 1; $i -ge 0; $i--) {
        $b[0x046 + $i] = $b[0x045 + $i]
    }
    $b[0x045] = 0x00
    $b[0x078] = 0x24                                # '$' terminator lands here
    for ($i = 0x079; $i -le 0x07F; $i++) { $b[$i] = 0xCC }

    # --- PE FileHeader: deprecated fields ---
    for ($i = 0x8C; $i -le 0x93; $i++) { $b[$i] = 0xCC }  # PtrSymTable+NumSyms (8B)

    # TimeDateStamp: overwrite low 3 bytes with fixed value from hex_writer reference
    $b[0x88] = 0xEF; $b[0x89] = 0x91; $b[0x8A] = 0x24

    # --- PE Optional Header: cosmetic/ignored fields ---
    for ($i = 0xA4; $i -le 0xA6; $i++) { $b[$i] = 0xCC }  # SizeOfUninitData (3B, 0xA7 kept)

    # BaseOfData: 0x20 → 0xCC (field unused for PE executables)
    $b[0xB1] = 0xCC

    for ($i = 0xC3; $i -le 0xC7; $i++) { $b[$i] = 0xCC }  # ImageVersion (5B)
    $b[0xCA] = 0x00                                       # MinorSubsystemVersion (kept 0)
    for ($i = 0xCB; $i -le 0xCE; $i++) { $b[$i] = 0xCC }  # Win32Ver (4B)
    for ($i = 0xD8; $i -le 0xDB; $i++) { $b[$i] = 0xCC }  # CheckSum (4B)
    for ($i = 0xED; $i -le 0xF3; $i++) { $b[$i] = 0xCC }  # HeapCommit+LoaderFlags (7B)

    # --- .text section name: shift "tex" "ext" ---
    # hex_writer has ".extt" name at different offset within section header.
    $b[0x179] = 0x65  # 'e'
    $b[0x17A] = 0x78  # 'x'
    $b[0x17B] = 0x74  # 't'

    # --- Section Table: deprecated fields ---
    for ($i = 0x198; $i -le 0x19B; $i++) { $b[$i] = 0xCC }  # .text NumRelocs+NumLinenos (4B)
    for ($i = 0x1C0; $i -le 0x1C3; $i++) { $b[$i] = 0xCC }  # .idata NumRelocs+NumLinenos (4B)

    [System.IO.File]::WriteAllBytes((Resolve-Path $Exe), $b)

    $after = ($b | Where-Object { $_ -eq 0 }).Count
    Write-Host ("  Filled {0} bytes, zero: {1} -> {2}" -f ($before - $after), $before, $after)
}

Write-Host "`n=== Verify ==="
& ".\$Exe" t.txt 65 66 67
$data = Get-Content t.txt -Enc Byte
if ($data[-3] -eq 65 -and $data[-2] -eq 66 -and $data[-1] -eq 67) {
    Write-Host "  multi-byte OK"
} else {
    Write-Host "  multi-byte FAIL"
}
Remove-Item t.txt

& ".\$Exe" t.txt 33
$data = Get-Content t.txt -Enc Byte
if ($data[-1] -eq 33) {
    Write-Host "  single-byte OK"
} else {
    Write-Host "  single-byte FAIL"
}
Remove-Item t.txt

Write-Host "`nDone: $Exe ($((Get-Item $Exe).Length) bytes)"
