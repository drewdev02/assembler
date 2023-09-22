section .data
    msg db "Ingrese un número para calcular su factorial: ", 0
    result db "El factorial es: ", 0

section .bss
    num resb 2

section .text
    global _start

_start:
    ; Mostrar el mensaje para ingresar el número
    mov eax, 4           ; syscall number for sys_write
    mov ebx, 1           ; file descriptor 1 (stdout)
    mov ecx, msg         ; pointer to the message
    mov edx, 37          ; message length
    int 0x80

    ; Leer el número desde la entrada estándar (teclado)
    mov eax, 3           ; syscall number for sys_read
    mov ebx, 0           ; file descriptor 0 (stdin)
    mov ecx, num         ; buffer to store input
    mov edx, 2           ; maximum number of bytes to read
    int 0x80

    ; Convertir el número ingresado a entero
    xor eax, eax
    mov ecx, 10
    mov ebx, num
    xor edx, edx

convert_loop:
    lodsb
    sub al, '0'
    imul edx, edx, ecx
    add edx, eax
    test byte [ebx], byte 0x0A
    jnz convert_loop

    ; Calcular el factorial llamando a la función recursiva
    push edx
    call factorial

    ; Mostrar el resultado
    mov eax, 4           ; syscall number for sys_write
    mov ebx, 1           ; file descriptor 1 (stdout)
    mov ecx, result      ; pointer to the result message
    mov edx, 16          ; message length
    int 0x80

    ; Salir del programa
    mov eax, 1           ; syscall number for sys_exit
    xor ebx, ebx         ; exit status 0
    int 0x80

factorial:
    ; Función recursiva para calcular el factorial
    ; Entrada: [esp+4] = número para calcular su factorial
    ; Salida: eax = factorial
    cmp dword [esp+4], 1
    jle .done
    dec dword [esp+4]
    push eax
    call factorial
    pop eax
    imul eax, dword [esp+4]
.done:
    ret

