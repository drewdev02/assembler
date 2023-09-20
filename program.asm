section .data
    hello db 'Hola, Mundo!',10,0   ; Agregamos un carácter de salto de línea (10) después de la cadena

section .text
global _start

_start:
    ; Llamada al sistema para escribir en la consola
    mov eax, 4          ; Código de llamada al sistema para escribir (4)
    mov ebx, 1          ; Descriptor de archivo: 1 (salida estándar)
    mov ecx, hello      ; Puntero a la cadena que queremos imprimir
    mov edx, 14         ; Longitud de la cadena (incluyendo el salto de línea)
    int 0x80            ; Interrupción del sistema

    ; Llamada al sistema para salir del programa
    mov eax, 1          ; Código de llamada al sistema para salir (1)
    mov ebx, 0          ; Código de retorno: 0
    int 0x80            ; Interrupción del sistema
