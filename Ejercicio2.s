.syntax unified
.global _start
.text

.thumb_func
_start:
    bl  init  // Llama a la inicialización // Se puede eliminar porque la subrutina es redundante
    bl  cargar_memoria // Llama a la subrutina cargar_memoria
loop: // Bucle infinito de la subrutina copiar_datos puede ser un error del programa
    bl  copiar_datos 
    b   loop

init: // Guarda 0 en los tres registros y vuelve a _start // Se puede eliminar toda la rutina porque ninguna parte sirve, es redundante
    mov   r0, #0 // Se puede eliminar esta línea porque en la línea 21 le pone otro valor sin usar este
    mov   r1, #0 // Se puede eliminar esta línea porque en la línea 22 le pone otro valor sin usar este
    mov   r2, #0 // Se puede eliminar esta línea porque no se utiliza el registro r2 en nunguna otra parte del código
    bx    lr

cargar_memoria: 
    ldr   r4, =#0x20000000 // Guarda en r4 el valor 
    mov   r0, #1 // Guarda 1 en r0
    mov   r1, #10 // Guarda 10 en r1

loop_carga:
    str   r0, [r4], #4 // Guarda el valor de r0 en la dirección r4 + #4 cada bucle
	adds  r1, #-1 // Resta 1 a r1 y lo guarda en r1, también actualiza la bandera Z
    beq   fin_carga // Cuando el resultado de la resta es 0, se da cuenta por medio de la bandera y salta a fin carga
    b     loop_carga // Si lo anterior no se cumple, vuelve a ejecutar la subrutina loop_carga
fin_carga:
    bx    lr // Salta al valor de LR, en este caso el PC sigue con la subrutina loop

copiar_datos:
    ldr   r4, =#0x20000000 // Guarda en r4 el valor 
loop_copia:
    ldr   r0, [r4] // Guarda en r0 el valor guardado en la dirección r4 de la memoria
    cmp   r0, #0 // Compara r0 con 0 y actualiza la bandera
    beq   fin_copia //si la comparación da 0, salta a la subrutina fin_copia
    str   r0, [r4, #0x100] // Guarda el valor de r0 en la dirección r4 + #0x100 de la memoria
    add   r4, #4 // suma 4 a r4
    b     loop_copia // salta a loop_copia
fin_copia:
    bx    lr // Salta al valor de LR, en este caso el PC sigue con la instrucción de la línea 11 (b loop) y se hace el bucle infinito
