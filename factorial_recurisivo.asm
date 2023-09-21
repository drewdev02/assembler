section .data
    msg db "Ingrese un número para calcular su factorial: ", 0
    result db "El factorial es: ", 0

section .bss
    num resb 2

section .text
    global _start

_start:
    ; Mostrar el mensaje para ingresar el número
    mov rax, 0x1         ; syscall number for sys_write
    mov rdi, 0x1         ; file descriptor 1 (stdout)
    mov rsi, msg         ; pointer to the message
    mov rdx, 37          ; message length
    syscall

    ; Leer el número desde la entrada estándar (teclado)
    mov rax, 0           ; syscall number for sys_read
    mov rdi, 0           ; file descriptor 0 (stdin)
    mov rsi, num         ; buffer to store input
    mov rdx, 2           ; maximum number of bytes to read
    syscall

    ; Convertir el número ingresado a entero
    xor rax, rax
    mov rdi, 10
    mov rsi, num
    xor rdx, rdx

convert_loop:
    lodsb
    sub al, '0'
    imul rdx, rdi
    add rdx, rax
    test byte [rsi], rsi
    jnz convert_loop

    ; Calcular el factorial llamando a la función recursiva
    mov rdi, rdx
    call factorial

    ; Mostrar el resultado
    mov rax, 0x1         ; syscall number for sys_write
    mov rdi, 0x1         ; file descriptor 1 (stdout)
    mov rsi, result      ; pointer to the result message
    mov rdx, 16          ; message length
    syscall

    ; Salir del programa
    mov rax, 0x60        ; syscall number for sys_exit
    xor rdi, rdi         ; exit status 0
    syscall

factorial:
    ; Función recursiva para calcular el factorial
    ; Entrada: rdi = número para calcular su factorial
    ; Salida: rax = factorial
    cmp rdi, 1
    jle .done
    dec rdi
    push rdi
    call factorial
    pop rdi
    imul rax, rdi
.done:
    ret
