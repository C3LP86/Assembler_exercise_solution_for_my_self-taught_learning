; "Hello, World!" en ASM
;
;    Écrivez un programme en assembleur qui affiche "Hello, World!" à l'écran.
;    Utilisez les interruptions (par exemple, int 0x80 pour Linux).

global _start

section .data
    msg db 'Hello World', 0x0a                                          ; char msg[] = 'Hello World\n'
    msg_lenght equ $-msg                                                ; extract msg size

section .text

_start:
    call printHello
    call Exit

printHello:
    ; ssize_t write(int fd, const void buf[.count], size_t count);
    mov rax, 0x1                                                        ; syscall write
    mov rdi, 0x1                                                        ; file descriptor stdout
    mov rsi, msg                                                        ; msg address
    mov rdx, msg_lenght                                                 ; useful size to print the msg
    syscall ; ou int 0x80
    ret

Exit:
    ; void _exit(int status);
    mov rax, 0x3C                                                       ; syscall exit
    xor rdi, rdi                                                        ; status code 0
    syscall ; ou int 0x80