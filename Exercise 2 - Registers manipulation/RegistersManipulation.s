global _start

section .data
    ; Message and its length to be printed at the beginning
    msg db "Practical example of mov, add, sub, and imul instructions: ", 0x0a
    msg_length equ $-msg

section .text

_start:
    ; Print the introductory message
    call printMessage
    
    ; Perform each operation in sequence (addition, subtraction, multiplication)
    call addition
    call soustraction
    call multiplication
    
    ; Exit the program
    call Exit

printMessage:
    ; Print the message stored in the .data section
    mov rax, 1                      ; syscall number for sys_write
    mov rdi, 1                      ; file descriptor 1 (stdout)
    mov rsi, msg                    ; address of message
    mov rdx, msg_length             ; length of message
    syscall                         ; make the syscall
    ret                             ; return to caller

addition:
    ; Example of addition
    mov rax, 15                     ; load first value into rax
    mov rbx, 5                      ; load second value into rbx
    add rax, rbx                    ; add rbx to rax (rax = rax + rbx)
    ret                             ; return to caller

soustraction:
    ; Example of subtraction
    mov rax, 15                     ; load first value into rax
    mov rbx, 5                      ; load second value into rbx
    sub rax, rbx                    ; subtract rbx from rax (rax = rax - rbx)
    ret                             ; return to caller

multiplication:
    ; Example of multiplication
    mov rax, 15                     ; load first value into rax
    mov rbx, 5                      ; load second value into rbx
    imul rax, rbx                   ; multiply rax by rbx (rax = rax * rbx)
    ret                             ; return to caller

Exit:
    ; Exit the program
    mov rax, 60                     ; syscall number for sys_exit
    xor rdi, rdi                    ; set exit code to 0
    syscall                         ; make the syscall to exit