# Batch-HexWriter

在纯cmd原生实现自由hex写入, 无certutil/findstr/powershell/fsutil, 测试于Windows 10+

见 [hex_writer](./hex_writer.bat)  
若在Windows 10遇到问题，尝试 [无注释版本](./hex_writer_nocomment.bat)

如需构建 `hex_writer` 释放的exe：

1. 下载 [FASM](https://flatassembler.net/)
2. 将 [FASM](https://flatassembler.net/) 解压到项目根目录
3. 运行 `append_byte_build.ps1`

用法：`ByteAppender.exe <文件名> <字节> [字节 ...]`

## 📜 开源协议

项目使用 Apache License 2.0 协议开源，见 [LICENSE](./LICENSE)

Copyright (c) 2026 lRENyaaa
