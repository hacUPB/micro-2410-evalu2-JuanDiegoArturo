.syntax unified
.global _start
.text

.thumb_func
_start:
    bl  crear_tabla_leds
    bx  lr

crear_tabla_leds:
    ldr   r4, =#0x20000000 // Dirección inicial de memoria para guardar la tabla
    ldr   r1, =leds        // Dirección de la tabla en la memoria de programa
    mov   r2, #8           // Tamaño de la matriz (filas)
    mov   r3, #8           // Tamaño de la matriz (columnas)

loop_filas:
    ldrb  r0, [r1], #1     // Carga el byte actual de la tabla de LED
    strb  r0, [r4], #1     // Guarda el byte en la dirección de memoria y avanza
    subs  r3, r3, #1       // Decrementa el contador de columnas
    bne   loop_filas       // Continúa el bucle si no se han procesado todas las columnas
    bx    lr               // Retorna

.section .rodata
leds:
    .byte 0b01000010 // Representación de la primera fila de LEDs
    .byte 0b00111100 // Representación de la segunda fila de LEDs
    .byte 0b01111110 // Representación de la tercera fila de LEDs
    .byte 0b11011011 // Representación de la cuarta fila de LEDs
    .byte 0b11111111 // Representación de la quinta fila de LEDs
    .byte 0b01100110 // Representación de la sexta fila de LEDs
    .byte 0b10100101 // Representación de la séptima fila de LEDs
    .byte 0b10000001 // Representación de la octava fila de LEDs