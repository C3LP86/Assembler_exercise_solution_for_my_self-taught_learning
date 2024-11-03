global _start
extern  printf, scanf

section .data
    ; Messages and their lengths for prompts and results
    message_a db 'Please choose your first value : ', 0
    message_a_length equ $-message_a

    message_b db 'Please choose your second value : ', 0
    message_b_length equ $-message_b

    message_addition db 'Here is the answer to your addition : ', 0
    message_addition_length equ $-message_addition

    message_subtraction db 'Here is the answer to your subtraction : ', 0
    message_subtraction_length equ $-message_subtraction  

    message_multiplication db 'Here is the answer to your multiplication : ', 0
    message_multiplication_length equ $-message_multiplication

    message_division db 'Here is the answer to your division : ', 0
    message_division_length equ $-message_division

    error_message_division db 'Error : It is impossible to divide by zero !', 0x0a, 0

    ; Format strings for scanf (input) and printf (output)
    inFormat db  "%d", 0
    outFormat db  "%d", 0x0a, 0

section .bss
    ; Reserve space for user inputs and calculation result
    userInput_1 resq 1
    userInput_2 resq 1
    result resq 1 

section .text

_start:
    ; Save rbx on the stack to use later
    push rbx

    ; Prompt for and get the first user input
    call printMessage_a
    call getInput_a

    ; Prompt for and get the second user input
    call printMessage_b
    call getInput_b

    ; Perform and display the result of each arithmetic operation
    call printMessageAddition
    mov rax, [userInput_1]         ; Load first input into rax
    mov rbx, [userInput_2]         ; Load second input into rbx
    call addition

    call printMessageSubstraction
    mov rax, [userInput_1]
    mov rbx, [userInput_2]
    call subtraction

    call printMessageMultiplication
    mov rax, [userInput_1]
    mov rbx, [userInput_2]
    call multiplication

    call printMessageDivision
    mov rax, [userInput_1]
    mov rbx, [userInput_2]
    call division

    ; Exit program
    call Exit

; Print message functions
printMessage_a:
    mov rax, 1                     ; syscall number for sys_write
    mov rdi, 1                     ; file descriptor 1 (stdout)
    mov rsi, message_a             ; address of message_a
    mov rdx, message_a_length      ; length of message_a
    syscall
    ret

getInput_a:
    ; Get first input using scanf and store in userInput_1
    mov rdi, inFormat
    mov rsi, userInput_1
    call scanf
    ret

printMessage_b:
    mov rax, 1
    mov rdi, 1
    mov rsi, message_b
    mov rdx, message_b_length
    syscall
    ret

getInput_b:
    ; Get second input using scanf and store in userInput_2
    mov rdi, inFormat
    mov rsi, userInput_2
    call scanf
    ret

printMessageAddition:
    ; Display addition message
    mov rax, 1
    mov rdi, 1
    mov rsi, message_addition
    mov rdx, message_addition_length
    syscall
    ret

addition:
    ; Perform addition rax + rbx, store result in `result`
    add rax, rbx
    mov [result], rax              ; Store result in memory

    ; Print result
    mov rdi, outFormat
    mov rsi, [result]
    call printf
    ret

printMessageSubstraction:
    ; Display subtraction message
    mov rax, 1
    mov rdi, 1
    mov rsi, message_subtraction
    mov rdx, message_subtraction_length
    syscall
    ret

subtraction:
    ; Perform subtraction rax - rbx, store result in `result`
    sub rax, rbx
    mov [result], rax              ; Store result in memory

    ; Print result
    mov rdi, outFormat
    mov rsi, [result]
    call printf
    ret

printMessageMultiplication:
    ; Display multiplication message
    mov rax, 1
    mov rdi, 1
    mov rsi, message_multiplication
    mov rdx, message_multiplication_length
    syscall
    ret

multiplication:
    ; Perform multiplication rax * rbx, store result in `result`
    imul rax, rbx
    mov [result], rax              ; Store result in memory

    ; Print result
    mov rdi, outFormat
    mov rsi, [result]
    call printf
    ret

printMessageDivision:
    ; Display division message
    mov rax, 1
    mov rdi, 1
    mov rsi, message_division
    mov rdx, message_division_length
    syscall
    ret

division:
    ; Check for division by zero
    cmp rbx, 0                     ; Compare divisor (rbx) to zero
    je division_by_zero            ; Jump if zero

    ; Perform division rax / rbx, store quotient in `result`
    xor rdx, rdx                   ; Clear rdx for division
    div rbx                        ; Divide rax by rbx (result in rax)
    mov [result], rax              ; Store quotient in result

    ; Print result
    mov rdi, outFormat
    mov rsi, [result]
    call printf
    ret

division_by_zero:
    ; Handle division by zero error
    mov rdi, outFormat
    lea rsi, [error_message_division]
    call printf
    ret

Exit:
    ; Exit the program
    mov rax, 0x3c                  ; syscall number for sys_exit
    xor rdi, rdi                   ; exit code 0
    syscall