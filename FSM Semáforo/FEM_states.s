#include "definitions.h"
 
  .syntax unified
  .global estado_semaforo
  .text
 
 
  .align 2                // Alinear la tabla de direcciones a 4 bytes (2^2 = 4)
// Lista de direcciones de los estados
dir_tabla_estados:
  .long estado_rojo           //0
  .long estado_rojo_amarillo  //1
  .long estado_verde          //2
  .long estado_amarillo       //3
 
    .thumb_func
 
estado_semaforo:
    push {lr}                 // Guarda el link register al stack porque va a saltar a otra subrutina
    ldr r4, =Base_maquina_0   // Carga en r4 la dirección base de la máquina de estados
    ldr r0, [r4, #var_estado_M0]   // Carga en r0 el estado actual de la máquina usando la dirección base y el offset del estado
    lsl r0, #2                // Multiplica por 4 para obtener el offset de la dirección en la memoria del estado actual
    ldr r4, =dir_tabla_estados // Carga en r4 la dirección de la tabla de estados 
    ldr r1, [r4, r0]           // Guarda en r1 la dirección de la subrutina correspondiente al estado actual del semáforo
    bx r1                      // Salta a la subrutina del estado actual
 
    .thumb_func
estado_rojo:    
    ldr r4, =Base_maquina_0     // Carga en r4 la dirección base de la máquina
    ldr r0, [r4, #entrada_tiempo_M0]   // Guarda en r0 la entrada (medida) de tiempo
    ldr r5, =TIEMPO_AMARILLO              // En r5 guarda el tiempo que debería durar el estado anterior
    cmp r0, r5                        // Compara los tiempos y mientras no transcurra el tiempo del estado anterior, sigue revisando el estado
    blt fin_estado                   
 
    // Salidas
    ldr r0, =GPIOB_PCOR     //PCOR = pone un 1 para clear(0) entonces enciende el LED
    mov r1, #(1 << LED_ROJO) // Pone en r1 un 1 movido a la izquierda la cantidad de veces del offset
    str r1, [r0]             // Guarda en el PCOR del puerto B         
 
    ldr r0, =GPIOB_PSOR     // PSOR = cuando pone un 1 lo pone en 1 entonces apaga los LEDs
    mov r1, #(1 << LED_AMARILLO) // Pone en r1 un 1 movido a la izquierda la cantidad de veces del offset
    str r1, [r0]                // Guarda en el PSOR del puerto B          
    mov r1, #(1 << LED_VERDE) // Pone en r1 un 1 movido a la izquierda la cantidad de veces del offset
    str r1, [r0]             // Guarda en el PSOR del puerto B   
 
    // Cambiar al siguiente estado 
    mov r1, #ROJO_AMARILLO // Mueve a r1 el siguiente estado
    str r1, [r4, #var_estado_M0]  // Le dice a la máquina que el estado es el siguiente
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  // Reinicia el tiempo con el cero
    pop {lr}                            // Vuelve al loop principal y después vuelve a estado semaforo
    bx lr
 
    .thumb_func
estado_rojo_amarillo:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    ldr r5, =TIEMPO_ROJO
    cmp r0, r5
    blt fin_estado                    
 
    // Configura la salida
    ldr r0, =GPIOB_PCOR
    mov r1, #(1 << LED_ROJO) | (1 << LED_AMARILLO)
    str r1, [r0]                      
 
    ldr r0, =GPIOB_PSOR
    mov r1, #(1 << LED_VERDE)
    str r1, [r0]                      
 
    // Cambiar al siguiente estado 
    mov r1, #VERDE
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]   
    pop {lr}
    bx lr
 
    .thumb_func
estado_verde:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    ldr r5, =TIEMPO_ROJO_AMARILLO           
    cmp r0, r5
    blt fin_estado                    
 
    // Configura salida
    ldr r0, =GPIOB_PCOR
    mov r1, #(1 << LED_VERDE)
    str r1, [r0]                      
 
    ldr r0, =GPIOB_PSOR
    mov r1, #(1 << LED_ROJO)
    str r1, [r0]                      
    mov r1, #(1 << LED_AMARILLO)
    str r1, [r0]                      
 
    // Cambiar al siguiente estado 
    mov r1, #AMARILLO
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]   
    pop {lr}
    bx lr
 
    .thumb_func
estado_amarillo:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    ldr r5, =TIEMPO_VERDE          
    cmp r0, r5
    blt fin_estado                    
 
    // Configurar salida
    ldr r0, =GPIOB_PCOR
    mov r1, #(1 << LED_AMARILLO)
    str r1, [r0]                      
 
    ldr r0, =GPIOB_PSOR
    mov r1, #(1 << LED_ROJO)
    str r1, [r0]                      
    mov r1, #(1 << LED_VERDE)
    str r1, [r0]          
    // Cambiar al siguiente estado 
    mov r1, #ROJO
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]   
    pop {lr}
    bx lr
 
fin_estado:
    pop {lr}
    bx lr