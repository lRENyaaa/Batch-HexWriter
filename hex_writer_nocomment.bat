@echo off
REM ==============================================================================
REM  hex_writer.bat — Pure batch PE executable writer (zero external dependencies)
REM
REM  Copyright (c) 2026 lRENyaaa (https://github.com/lRENyaaa)
REM
REM  Licensed under the Apache License, Version 2.0 (the "License");
REM  you may not use this file except in compliance with the License.
REM  You may obtain a copy of the License at
REM
REM       http://www.apache.org/licenses/LICENSE-2.0
REM
REM  Unless required by applicable law or agreed to in writing, software
REM  distributed under the License is distributed on an "AS IS" BASIS,
REM  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM  See the License for the specific language governing permissions and
REM  limitations under the License.
REM ==============================================================================
setlocal EnableDelayedExpansion
cd /d "%~dp0"
chcp 65001 >nul

:start

echo [%time%] Preparing...

call :prepareHex
call :prepareNulCache
call :prepare0x2000

set "fileName=ByteAppender.exe"
set "targetName=0-255.bin"
type nul > "%fileName%"
type nul > "%targetName%"

echo [%time%] Building %fileName%...

<nul set /p ="%hex:~77,1%%hex:~90,1%%hex:~128,1%%hex:~204,1%%hex:~1,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~4,1%%hex:~204,1%%hex:~16,1%%hex:~204,1%%hex:~255,1%%hex:~255,1%%hex:~204,1%%hex:~204,1%%hex:~64,1%%hex:~1,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~64,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~128,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
cmd /u /c "<nul set /p =%hex000e%">> "%fileName%"
<nul set /p ="%hex:~31,1%%hex:~186,1%%hex:~14,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~180,1%%hex:~9,1%%hex:~205,1%%hex:~33,1%%hex:~184,1%%hex:~1,1%%hex:~76,1%%hex:~205,1%%hex:~33,1%%hex:~84,1%%hex:~104,1%%hex:~105,1%%hex:~115,1%%hex:~32,1%%hex:~112,1%%hex:~114,1%%hex:~111,1%%hex:~103,1%%hex:~114,1%%hex:~97,1%%hex:~109,1%%hex:~32,1%%hex:~99,1%%hex:~97,1%%hex:~110,1%%hex:~110,1%%hex:~111,1%%hex:~116,1%%hex:~32,1%%hex:~98,1%%hex:~101,1%%hex:~32,1%%hex:~114,1%%hex:~117,1%%hex:~110,1%%hex:~32,1%%hex:~105,1%%hex:~110,1%%hex:~32,1%%hex:~68,1%%hex:~79,1%%hex:~83,1%%hex:~32,1%%hex:~109,1%%hex:~111,1%%hex:~100,1%%hex:~101,1%%hex:~46,1%%hex:~13,1%%hex:~10,1%%hex:~36,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~80,1%%hex:~69,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~76,1%%hex:~1,1%">> "%fileName%"
<nul set /p ="%hex:~2,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
<nul set /p ="%hex:~239,1%%hex:~145,1%%hex:~36,1%%hex:~106,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~224,1%">> "%fileName%"
cmd /u /c "<nul set /p =%hex000f%">> "%fileName%"
<nul set /p ="%hex:~1,1%%hex:~11,1%%hex:~1,1%%hex:~1,1%">> "%fileName%"
<nul set /p ="%hex:~73,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
<nul set /p ="%hex:~2,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~2,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%%hex:~204,1%%hex:~204,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~16,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~16,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%">> "%fileName%"
type "nul_cache\nul_4.bin" >> "%fileName%"
<nul set /p ="%hex:~64,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~16,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~2,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~1,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~3,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~48,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~2,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~3,1%">> "%fileName%"
type "nul_cache\nul_4.bin" >> "%fileName%"
<nul set /p ="%hex:~16,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~16,1%">> "%fileName%"
type "nul_cache\nul_4.bin" >> "%fileName%"
<nul set /p ="%hex:~1,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~16,1%">> "%fileName%"
type "nul_cache\nul_12.bin" >> "%fileName%"
type "0x2000.bin" >> "%fileName%"
cmd /u /c "<nul set /p =%hex00aa%">> "%fileName%"
type "nul_cache\nul_114.bin" >> "%fileName%"
cmd /u /c "<nul set /p =%hex002e%">> "%fileName%"
<nul set /p ="%hex:~101,1%%hex:~120,1%%hex:~116,1%">> "%fileName%"
<nul set /p ="%hex:~116,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~224,1%">> "%fileName%"
type "nul_cache\nul_4.bin" >> "%fileName%"
<nul set /p ="%hex:~16,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~2,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~2,1%">> "%fileName%"
type "nul_cache\nul_10.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~96,1%%hex:~46,1%%hex:~105,1%%hex:~100,1%%hex:~97,1%%hex:~116,1%%hex:~97,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~170,1%">> "%fileName%"
type "nul_cache\nul_4.bin" >> "%fileName%"
type "0x2000.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~2,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
cmd /u /c "<nul set /p =%hex0004%">> "%fileName%"
type "nul_cache\nul_10.bin" >> "%fileName%"
<nul set /p ="%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~204,1%%hex:~64,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~192,1%">> "%fileName%"
type "nul_cache\nul_56.bin" >> "%fileName%"
<nul set /p ="%hex:~184,1%%hex:~105,1%%hex:~97,1%%hex:~1,1%%hex:~65,1%%hex:~53,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~139,1%%hex:~16,1%%hex:~255,1%%hex:~210,1%%hex:~137,1%%hex:~199,1%%hex:~49,1%%hex:~192,1%%hex:~138,1%%hex:~15,1%%hex:~71,1%%hex:~128,1%%hex:~249,1%%hex:~32,1%%hex:~116,1%%hex:~4,1%%hex:~132,1%%hex:~201,1%%hex:~117,1%%hex:~244,1%%hex:~128,1%%hex:~63,1%%hex:~32,1%%hex:~117,1%%hex:~3,1%%hex:~71,1%%hex:~235,1%%hex:~248,1%%hex:~137,1%%hex:~254,1%%hex:~138,1%%hex:~15,1%%hex:~71,1%%hex:~128,1%%hex:~249,1%%hex:~32,1%%hex:~116,1%%hex:~4,1%%hex:~132,1%%hex:~201,1%%hex:~117,1%%hex:~244,1%%hex:~136,1%%hex:~71,1%%hex:~255,1%%hex:~128,1%%hex:~63,1%%hex:~32,1%%hex:~117,1%%hex:~3,1%%hex:~71,1%%hex:~235,1%%hex:~248,1%%hex:~80,1%%hex:~106,1%%hex:~127,1%%hex:~255,1%%hex:~4,1%%hex:~36,1%%hex:~106,1%%hex:~4,1%%hex:~80,1%%hex:~80,1%%hex:~106,1%%hex:~4,1%%hex:~86,1%%hex:~184,1%%hex:~109,1%%hex:~97,1%%hex:~1,1%%hex:~65,1%%hex:~53,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~139,1%%hex:~16,1%%hex:~255,1%%hex:~210,1%%hex:~137,1%%hex:~195,1%%hex:~49,1%%hex:~192,1%%hex:~106,1%%hex:~2,1%%hex:~80,1%%hex:~80,1%%hex:~83,1%%hex:~184,1%%hex:~113,1%%hex:~97,1%%hex:~1,1%%hex:~65,1%%hex:~53,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~139,1%%hex:~16,1%%hex:~255,1%%hex:~210,1%%hex:~131,1%%hex:~236,1%%hex:~8,1%%hex:~128,1%%hex:~63,1%%hex:~32,1%%hex:~117,1%%hex:~3,1%%hex:~71,1%%hex:~235,1%%hex:~248,1%%hex:~138,1%%hex:~7,1%%hex:~44,1%%hex:~48,1%%hex:~60,1%%hex:~10,1%%hex:~115,1%%hex:~56,1%%hex:~49,1%%hex:~201,1%%hex:~15,1%%hex:~182,1%%hex:~7,1%%hex:~71,1%%hex:~44,1%%hex:~48,1%%hex:~60,1%%hex:~10,1%%hex:~115,1%%hex:~7,1%%hex:~107,1%%hex:~201,1%%hex:~10,1%%hex:~1,1%%hex:~193,1%%hex:~235,1%%hex:~239,1%%hex:~136,1%%hex:~12,1%%hex:~36,1%%hex:~106,1%%hex:~1,1%%hex:~255,1%%hex:~12,1%%hex:~36,1%%hex:~141,1%%hex:~68,1%%hex:~36,1%%hex:~8,1%%hex:~80,1%%hex:~106,1%%hex:~1,1%%hex:~141,1%%hex:~68,1%%hex:~36,1%%hex:~12,1%%hex:~80,1%%hex:~83,1%%hex:~184,1%%hex:~117,1%%hex:~97,1%%hex:~1,1%%hex:~65,1%%hex:~53,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~139,1%%hex:~16,1%%hex:~255,1%%hex:~210,1%%hex:~235,1%%hex:~184,1%%hex:~49,1%%hex:~192,1%%hex:~83,1%%hex:~184,1%%hex:~121,1%%hex:~97,1%%hex:~1,1%%hex:~65,1%%hex:~53,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~139,1%%hex:~16,1%%hex:~255,1%%hex:~210,1%%hex:~106,1%%hex:~1,1%%hex:~255,1%%hex:~12,1%%hex:~36,1%%hex:~184,1%%hex:~125,1%%hex:~97,1%%hex:~1,1%%hex:~65,1%%hex:~53,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~65,1%%hex:~139,1%%hex:~16,1%%hex:~255,1%%hex:~210,1%">> "%fileName%"
type "nul_cache\nul_300.bin" >> "%fileName%"
<nul set /p ="%hex:~68,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~40,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_22.bin" >> "%fileName%"
<nul set /p ="%hex:~81,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~99,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~113,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~130,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~142,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~156,1%%hex:~32,1%">> "%fileName%"
type "nul_cache\nul_6.bin" >> "%fileName%"
<nul set /p ="%hex:~75,1%%hex:~69,1%%hex:~82,1%%hex:~78,1%%hex:~69,1%%hex:~76,1%%hex:~51,1%%hex:~50,1%%hex:~46,1%%hex:~68,1%%hex:~76,1%">> "%fileName%"
<nul set /p ="%hex:~76,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~71,1%%hex:~101,1%%hex:~116,1%%hex:~67,1%%hex:~111,1%%hex:~109,1%%hex:~109,1%%hex:~97,1%%hex:~110,1%%hex:~100,1%%hex:~76,1%%hex:~105,1%%hex:~110,1%%hex:~101,1%">> "%fileName%"
<nul set /p ="%hex:~65,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~67,1%%hex:~114,1%%hex:~101,1%%hex:~97,1%%hex:~116,1%%hex:~101,1%%hex:~70,1%%hex:~105,1%%hex:~108,1%%hex:~101,1%">> "%fileName%"
<nul set /p ="%hex:~65,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~83,1%%hex:~101,1%%hex:~116,1%%hex:~70,1%%hex:~105,1%%hex:~108,1%%hex:~101,1%%hex:~80,1%%hex:~111,1%%hex:~105,1%%hex:~110,1%%hex:~116,1%%hex:~101,1%">> "%fileName%"
<nul set /p ="%hex:~114,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~87,1%%hex:~114,1%%hex:~105,1%%hex:~116,1%%hex:~101,1%%hex:~70,1%%hex:~105,1%%hex:~108,1%">> "%fileName%"
<nul set /p ="%hex:~101,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~67,1%%hex:~108,1%%hex:~111,1%%hex:~115,1%%hex:~101,1%%hex:~72,1%%hex:~97,1%%hex:~110,1%%hex:~100,1%%hex:~108,1%">> "%fileName%"
<nul set /p ="%hex:~101,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_2.bin" >> "%fileName%"
<nul set /p ="%hex:~69,1%%hex:~120,1%%hex:~105,1%%hex:~116,1%%hex:~80,1%%hex:~114,1%%hex:~111,1%%hex:~99,1%%hex:~101,1%%hex:~115,1%">> "%fileName%"
<nul set /p ="%hex:~115,1%">tmp.bin
cmd /u /c "type tmp.bin" >> "%fileName%"
type "nul_cache\nul_342.bin" >> "%fileName%"

del /f /q tmp.bin >nul 2>&1
del /f /q 0x2000.bin >nul 2>&1
rmdir /s /q nul_cache 2>nul

echo [%time%] %fileName% Built.

for %%I in ("%fileName%") do set "exeSize=%%~zI"
if not "!exeSize!"=="1536" (
    echo [%time%] ERROR: %fileName% size is !exeSize! bytes, expected 1536. Retrying...
    goto :start
)

%fileName% %targetName% 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255

echo [%time%] Write %targetName% Done.
echo [%time%] Press any key to exit...
pause >nul

goto :eof

:prepareHex
chcp 65001 >nul
set "hex=-☺☻♥♦♣♠•◘○◙♂♀♪♫☼►◄↕‼¶§▬↨↑↓→←∟↔▲▼ ！“#$％%&'()*+,-./0123456789：；＜＝＞？@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]＾_`abcdefghijklmnopqrstuvwxyz{｜}~⌂ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥₧ƒáíóúñÑªº¿⌐¬½¼¡«»░▒▓│┤╡╢╖╕╣║╗╝╜╛┐└┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪┘┌█▄▌▐▀αßΓπΣσµτΦΘΩδ∞φε∩≡±≥≤⌠⌡÷≈°∙·√ⁿ²■ "
set "hex000e=฀"
set "hex000f=ༀ"
set "hex002e=⸀"
set "hex001a=ᨀ"
set "hex0004=Ѐ"
set "hex201a=ᨠ"
set "hex00aa=ꨀ"
chcp 437 >nul
goto :eof

:prepareNulCache
mkdir nul_cache 2>nul
pushd nul_cache

cmd /u /c "<nul set /p =%hex001a%">0x001a.bin
cmd /u /c "type 0x001a.bin">nul_2.bin

del /f /q 0x001a.bin >nul 2>&1

copy /b nul_2.bin + nul_2.bin nul_4.bin >nul
copy /b nul_4.bin + nul_4.bin nul_8.bin >nul
copy /b nul_8.bin + nul_8.bin nul_16.bin >nul
copy /b nul_16.bin + nul_16.bin nul_32.bin >nul
copy /b nul_32.bin + nul_32.bin nul_64.bin >nul
copy /b nul_64.bin + nul_64.bin nul_128.bin >nul
copy /b nul_128.bin + nul_128.bin nul_256.bin >nul
copy /b nul_2.bin + nul_8.bin nul_10.bin >nul
copy /b nul_4.bin + nul_8.bin nul_12.bin >nul
copy /b nul_2.bin + nul_2.bin + nul_2.bin nul_6.bin >nul
copy /b nul_16.bin + nul_4.bin + nul_2.bin nul_22.bin >nul
copy /b nul_32.bin + nul_16.bin + nul_8.bin nul_56.bin >nul
copy /b nul_64.bin + nul_32.bin + nul_16.bin + nul_2.bin nul_114.bin >nul
copy /b nul_256.bin + nul_32.bin + nul_8.bin + nul_4.bin nul_300.bin >nul
copy /b nul_256.bin + nul_64.bin + nul_16.bin + nul_4.bin + nul_2.bin  nul_342.bin >nul
popd
goto :eof

:prepare0x2000

cmd /u /c "<nul set /p =%hex201a%">0x201a.bin
cmd /u /c "type 0x201a.bin">0x2000.bin

del /f /q 0x201a.bin >nul 2>&1
goto :eof