#include "definitions.h"
 
  .syntax unified
  .global estado_matriz
  .text
 


 
    .thumb_func
 
estado_matriz:
    push {lr}                 // Guarda el link register al stack porque va a saltar a otra subrutina
    ldr r4, =Base_maquina_0   // Carga en r4 la dirección base de la máquina de estados
    ldr r0, [r4, #var_estado_M0]   // Carga en r0 el estado actual de la máquina usando la dirección base y el offset del estado
    lsl r0, #2                // Multiplica por 4 para obtener el offset de la dirección en la memoria del estado actual
    ldr r4, =dir_tabla_estados // Carga en r4 la dirección de la tabla de estados 
    ldr r1, [r4, r0]           // Guarda en r1 la dirección de la subrutina correspondiente al estado actual del semáforo
    bx r1                      // Salta a la subrutina del estado actual
 
    .thumb_func
fil1:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado             

    // Salida de columnas      
 
    ldr r1, =0x20000000        // Dirección donde se cargó la tabla
    ldrb r0, [r1, FILA1]              // Cargar la primera fila (byte) de la tabla (8 bits) en r0

    ldr r2, =GPIOB_PCOR        //Para limpiar los pines 
    ldr r3, =#unos
    str r3, [r2]    

    ldr r2, =GPIOB_PSOR              // Preparar para establecer el estado de los LEDs
    lsl r0, #10
    str r0, [r2]                     // Escribir el valor de r0 en los pines 10-17 del puerto B (activar LEDs según el valor de la tabla)
 
    //Salida de fila

    ldr r2, =GPIOD_PCOR        //Para limpiar los pines
    ldr r3, =#unos
    str r3, [r2] 

    ldr r2, =GPIOD_PSOR    
    mov r6, #FILA1
    add r6, r6, #10
    mov r0, #1
    lsl r0, r6
    mvn r0, r0
    str r0, [r2]

    // Cambiar al siguiente estado 
    mov r1, #FILA2 // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado matriz
    bx lr
 
    .thumb_func

fil2:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado             

    // Salida de columnas      
 
    ldr r1, =0x20000000        // Dirección donde se cargó la tabla
    ldrb r0, [r1, FILA2]              // Cargar la fila (byte) de la tabla (8 bits) en r0

    ldr r2, =GPIOB_PCOR        //Para limpiar los pines 
    ldr r3, =#unos
    str r3, [r2]    

    ldr r2, =GPIOB_PSOR              // Preparar para establecer el estado de los LEDs
    lsl r0, #10
    str r0, [r2]                     // Escribir el valor de r0 en los pines 10-17 del puerto B (activar LEDs según el valor de la tabla)
 
    //Salida de fila

    ldr r2, =GPIOD_PCOR        //Para limpiar los pines
    ldr r3, =#unos
    str r3, [r2] 

    ldr r2, =GPIOD_PSOR    
    mov r6, #FILA2
    add r6, r6, #10
    mov r0, #1
    lsl r0, r6
    mvn r0, r0
    str r0, [r2]

    // Cambiar al siguiente estado 
    mov r1, #FILA3 // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado matriz
    bx lr
 
    .thumb_func

fil3:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado             

    // Salida de columnas      
 
    ldr r1, =0x20000000        // Dirección donde se cargó la tabla
    ldrb r0, [r1, FILA3]              // Cargar la fila (byte) de la tabla (8 bits) en r0

    ldr r2, =GPIOB_PCOR        //Para limpiar los pines 
    ldr r3, =#unos
    str r3, [r2]    

    ldr r2, =GPIOB_PSOR              // Preparar para establecer el estado de los LEDs
    lsl r0, #10
    str r0, [r2]                     // Escribir el valor de r0 en los pines 10-17 del puerto B (activar LEDs según el valor de la tabla)
 
    //Salida de fila

    ldr r2, =GPIOD_PCOR        //Para limpiar los pines
    ldr r3, =#unos
    str r3, [r2] 

    ldr r2, =GPIOD_PSOR    
    mov r6, #FILA3
    add r6, r6, #10
    mov r0, #1
    lsl r0, r6
    mvn r0, r0
    str r0, [r2]

    // Cambiar al siguiente estado 
    mov r1, #FILA4 // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado matriz
    bx lr
 
    .thumb_func

fil4:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado             

    // Salida de columnas      
 
    ldr r1, =0x20000000        // Dirección donde se cargó la tabla
    ldrb r0, [r1, FILA4]              // Cargar la fila (byte) de la tabla (8 bits) en r0

    ldr r2, =GPIOB_PCOR        //Para limpiar los pines 
    ldr r3, =#unos
    str r3, [r2]    

    ldr r2, =GPIOB_PSOR              // Preparar para establecer el estado de los LEDs
    lsl r0, #10
    str r0, [r2]                     // Escribir el valor de r0 en los pines 10-17 del puerto B (activar LEDs según el valor de la tabla)
 
    //Salida de fila

    ldr r2, =GPIOD_PCOR        //Para limpiar los pines
    ldr r3, =#unos
    str r3, [r2] 

    ldr r2, =GPIOD_PSOR    
    mov r6, #FILA4
    add r6, r6, #10
    mov r0, #1
    lsl r0, r6
    mvn r0, r0
    str r0, [r2]

    // Cambiar al siguiente estado 
    mov r1, #FILA5 // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado matriz
    bx lr
 
    .thumb_func

fil5:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado             

    // Salida de columnas      
 
    ldr r1, =0x20000000        // Dirección donde se cargó la tabla
    ldrb r0, [r1, FILA5]              // Cargar la fila (byte) de la tabla (8 bits) en r0

    ldr r2, =GPIOB_PCOR        //Para limpiar los pines 
    ldr r3, =#unos
    str r3, [r2]    

    ldr r2, =GPIOB_PSOR              // Preparar para establecer el estado de los LEDs
    lsl r0, #10
    str r0, [r2]                     // Escribir el valor de r0 en los pines 10-17 del puerto B (activar LEDs según el valor de la tabla)
 
    //Salida de fila

    ldr r2, =GPIOD_PCOR        //Para limpiar los pines
    ldr r3, =#unos
    str r3, [r2] 

    ldr r2, =GPIOD_PSOR    
    mov r6, #FILA5
    add r6, r6, #10
    mov r0, #1
    lsl r0, r6
    mvn r0, r0
    str r0, [r2]

    // Cambiar al siguiente estado 
    mov r1, #FILA6 // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado matriz
    bx lr
 
    .thumb_func

fil6:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado             

    // Salida de columnas      
 
    ldr r1, =0x20000000        // Dirección donde se cargó la tabla
    ldrb r0, [r1, FILA6]              // Cargar la fila (byte) de la tabla (8 bits) en r0

    ldr r2, =GPIOB_PCOR        //Para limpiar los pines 
    ldr r3, =#unos
    str r3, [r2]    

    ldr r2, =GPIOB_PSOR              // Preparar para establecer el estado de los LEDs
    lsl r0, #10
    str r0, [r2]                     // Escribir el valor de r0 en los pines 10-17 del puerto B (activar LEDs según el valor de la tabla)
 
    //Salida de fila

    ldr r2, =GPIOD_PCOR        //Para limpiar los pines
    ldr r3, =#unos
    str r3, [r2] 

    ldr r2, =GPIOD_PSOR    
    mov r6, #FILA6
    add r6, r6, #10
    mov r0, #1
    lsl r0, r6
    mvn r0, r0
    str r0, [r2]

    // Cambiar al siguiente estado 
    mov r1, #FILA7 // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado matriz
    bx lr
 
    .thumb_func

fil7:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado             

    // Salida de columnas      
 
    ldr r1, =0x20000000        // Dirección donde se cargó la tabla
    ldrb r0, [r1, FILA7]              // Cargar la fila (byte) de la tabla (8 bits) en r0

    ldr r2, =GPIOB_PCOR        //Para limpiar los pines 
    ldr r3, =#unos
    str r3, [r2]    

    ldr r2, =GPIOB_PSOR              // Preparar para establecer el estado de los LEDs
    lsl r0, #10
    str r0, [r2]                     // Escribir el valor de r0 en los pines 10-17 del puerto B (activar LEDs según el valor de la tabla)
 
    //Salida de fila

    ldr r2, =GPIOD_PCOR        //Para limpiar los pines
    ldr r3, =#unos
    str r3, [r2] 

    ldr r2, =GPIOD_PSOR    
    mov r6, #FILA7
    add r6, r6, #10
    mov r0, #1
    lsl r0, r6
    mvn r0, r0
    str r0, [r2]

    // Cambiar al siguiente estado 
    mov r1, #FILA8 // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado matriz
    bx lr
 
    .thumb_func

fil8:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado             

    // Salida de columnas      
 
    ldr r1, =0x20000000        // Dirección donde se cargó la tabla
    ldrb r0, [r1, FILA8]              // Cargar la fila (byte) de la tabla (8 bits) en r0

    ldr r2, =GPIOB_PCOR        //Para limpiar los pines 
    ldr r3, =#unos
    str r3, [r2]    

    ldr r2, =GPIOB_PSOR              // Preparar para establecer el estado de los LEDs
    lsl r0, #10
    str r0, [r2]                     // Escribir el valor de r0 en los pines 10-17 del puerto B (activar LEDs según el valor de la tabla)
 
    //Salida de fila

    ldr r2, =GPIOD_PCOR        //Para limpiar los pines
    ldr r3, =#unos
    str r3, [r2] 

    ldr r2, =GPIOD_PSOR    
    mov r6, #FILA8
    add r6, r6, #10
    mov r0, #1
    lsl r0, r6
    mvn r0, r0
    str r0, [r2]

    // Cambiar al siguiente estado 
    mov r1, #FILA1 // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado matriz
    bx lr
 
    .thumb_func

fin_estado:
    pop {lr}
    bx lr

    .section .rodata
    //  .align 2                // Alinear la tabla de direcciones a 4 bytes (2^2 = 4)
// Lista de direcciones de los estados
dir_tabla_estados:
  .long fil1        
  .long fil2  
  .long fil3         
  .long fil4      
  .long fil5
  .long fil6
  .long fil7
  .long fil8