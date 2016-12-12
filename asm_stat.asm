section .text                           
global asm_stat

; this just uses a syscall to get stat instead of a library
; int stat(const char *pathname, struct stat *buf);
; int asm_stat(const char *pathname, struct stat *buf);

asm_stat:
  mov rax, 4       ; stat syscall
  syscall
  ret
