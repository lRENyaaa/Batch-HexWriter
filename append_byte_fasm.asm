; append_byte_fasm.asm
; FASM x86 PE — zero-free .text section
; Usage: append_byte_fasm.exe <filename> <byte> [byte ...]
;
; Copyright (c) 2026 lRENyaaa (https://github.com/lRENyaaa)
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
;
; Build: .\FASM\FASM.EXE append_byte_fasm.asm append_byte_fasm.exe
;   then: .\build.ps1 (applies DOS header zero-fill)

format PE console
entry start

section '.text' code readable executable

; =============================================================================
;  Zero-free x86 code.  Every technique below exists to avoid 0x00 in the 
;  instruction stream.  Goal: a PE file whose .text section has exactly zero
;  null bytes in the machine code — useful for batch-based hex writers and
;  any pipeline where NUL is a special delimiter.
; =============================================================================

start:
        ; -- GetCommandLineA via XOR-computed IAT pointer -------------------
        ;    IAT base = 0x402000.  key XOR base = 0x41016169.
        ;    key ^ 0x41414141 = 0x402028 → [0x402028] = GetCommandLineA
        mov     eax, 0x41016169
        xor     eax, 0x41414141
        mov     edx, [eax]
        call    edx
        mov     edi, eax               ; edi = command line string

        ; -- Skip program name token ----------------------------------------
        xor     eax, eax
.skexe: mov     cl, [edi]
        inc     edi
        cmp     cl, 32
        je      .spc1
        test    cl, cl
        jnz     .skexe
.spc1:  cmp     byte [edi], 32
        jne     .fname
        inc     edi
        jmp     .spc1

        ; -- Extract filename (null-terminate in-place) ---------------------
.fname: mov     esi, edi               ; esi = filename start
.fend:  mov     cl, [edi]
        inc     edi
        cmp     cl, 32
        je      .nulltr
        test    cl, cl
        jnz     .fend
.nulltr:mov     [edi-1], al            ; al=0, null-terminates filename
.spc2:  cmp     byte [edi], 32
        jne     .open
        inc     edi
        jmp     .spc2

        ; -- CreateFileA(fname, FILE_APPEND_DATA, 0, 0, OPEN_ALWAYS, 0x80, 0)
        ;    push 127; inc [esp] = 128 — avoids 0x00 in immediate
.open:  push    eax                    ; hTemplateFile = 0 (eax is 0)
        push    127
        inc     dword [esp]            ; 127→128 = FILE_ATTRIBUTE_NORMAL
        push    4                      ; dwCreationDisposition = OPEN_ALWAYS
        push    eax                    ; lpSecurityAttributes = 0
        push    eax                    ; dwShareMode = 0
        push    4                      ; dwDesiredAccess = FILE_APPEND_DATA
        push    esi                    ; lpFileName
        mov     eax, 0x4101616D        ; key → 0x40202C (CreateFileA IAT)
        xor     eax, 0x41414141
        mov     edx, [eax]
        call    edx
        mov     ebx, eax               ; ebx = file handle

        ; -- SetFilePointer(h, 0, 0, FILE_END) → seek to end ---------------
        xor     eax, eax
        push    2                      ; dwMoveMethod = FILE_END
        push    eax                    ; lpDistanceToMoveHigh = 0
        push    eax                    ; lDistanceToMove = 0
        push    ebx                    ; hFile
        mov     eax, 0x41016171        ; key → 0x402030 (SetFilePointer IAT)
        xor     eax, 0x41414141
        mov     edx, [eax]
        call    edx

        ; -- Allocate 8 bytes on stack for WriteFile params + byte buffer ---
        sub     esp, 8

        ; -- Main loop: parse decimal tokens, write each as one byte --------
        ;    Tokens are whitespace-separated; non-digit terminates parsing.
.loop:  cmp     byte [edi], 32
        jne     .chk
        inc     edi
        jmp     .loop
.chk:   mov     al, [edi]
        sub     al, 48                 ; '0'
        cmp     al, 10
        jae     .done                  ; <0 or >9 → done
        xor     ecx, ecx               ; ecx = accumulator
.parse: movzx   eax, byte [edi]
        inc     edi
        sub     al, 48
        cmp     al, 10
        jae     .write
        imul    ecx, ecx, 10
        add     ecx, eax
        jmp     .parse
        ; -- WriteFile(h, &b, 1, &written, 0) --------------------------------
.write: mov     [esp], cl              ; b = byte value
        push    1
        dec     dword [esp]            ; 1→0 (lpOverlapped = 0)
        lea     eax, [esp+8]           ; &written
        push    eax
        push    1                      ; nNumberOfBytesToWrite
        lea     eax, [esp+12]          ; &b
        push    eax
        push    ebx
        mov     eax, 0x41016175        ; key → 0x402034 (WriteFile IAT)
        xor     eax, 0x41414141
        mov     edx, [eax]
        call    edx
        jmp     .loop

        ; -- Cleanup: CloseHandle + ExitProcess -----------------------------
.done:  xor     eax, eax
        push    ebx
        mov     eax, 0x41016179        ; key → 0x402038 (CloseHandle IAT)
        xor     eax, 0x41414141
        mov     edx, [eax]
        call    edx
        push    1
        dec     dword [esp]            ; 1→0 (exit code = 0)
        mov     eax, 0x4101617D        ; key → 0x40203C (ExitProcess IAT)
        xor     eax, 0x41414141
        mov     edx, [eax]
        call    edx

; =============================================================================
;  Import section — manually laid out to minimize zero runs.
;  All RVAs below 0x3000 → high bytes are 0x00, unavoidable in PE32.
; =============================================================================
section '.idata' import data readable writeable

  ; Import Directory Table: one descriptor (KERNEL32.DLL) + null terminator
  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 5 dup(0)

  kernel_table:
    ; Import Name Table / Import Address Table (same content, terminated by null)
    GetCommandLineA  dd RVA _GetCommandLineA
    CreateFileA      dd RVA _CreateFileA
    SetFilePointer   dd RVA _SetFilePointer
    WriteFile        dd RVA _WriteFile
    CloseHandle      dd RVA _CloseHandle
    ExitProcess      dd RVA _ExitProcess
    dd 0                               ; terminator

  kernel_name db 'KERNEL32.DLL',0

  ; Hint/Name table: 2-byte ordinal hint + null-terminated ASCII name
  _GetCommandLineA  dw 0
    db 'GetCommandLineA',0
  _CreateFileA      dw 0
    db 'CreateFileA',0
  _SetFilePointer   dw 0
    db 'SetFilePointer',0
  _WriteFile        dw 0
    db 'WriteFile',0
  _CloseHandle      dw 0
    db 'CloseHandle',0
  _ExitProcess      dw 0
    db 'ExitProcess',0
