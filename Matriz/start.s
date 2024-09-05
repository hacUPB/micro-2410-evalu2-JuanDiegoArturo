/*********************************************************************
*                    SEGGER Microcontroller GmbH                     *
*                        The Embedded Experts                        *
**********************************************************************
*                                                                    *
*            (c) 2014 - 2022 SEGGER Microcontroller GmbH             *
*                                                                    *
*       www.segger.com     Support: support@segger.com               *
*                                                                    *
**********************************************************************
*                                                                    *
* All rights reserved.                                               *
*                                                                    *
* Redistribution and use in source and binary forms, with or         *
* without modification, are permitted provided that the following    *
* condition is met:                                                  *
*                                                                    *
* - Redistributions of source code must retain the above copyright   *
*   notice, this condition and the following disclaimer.             *
*                                                                    *
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND             *
* CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,        *
* INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF           *
* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE           *
* DISCLAIMED. IN NO EVENT SHALL SEGGER Microcontroller BE LIABLE FOR *
* ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR           *
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT  *
* OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;    *
* OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF      *
* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT          *
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE  *
* USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH   *
* DAMAGE.                                                            *
*                                                                    *
*********************************************************************/

/*********************************************************************
*
*       _start
*
*  Function description
*  Defines entry point for an MKE18F16 assembly code only
*  application.
*
*  Additional information
*    Please note, as this is an assembly code only project, the C/C++
*    runtime library has not been initialised. So do not attempt to call
*    any C/C++ library functions because they probably won't work.
*/

  #include "definitions.h"
 
  .syntax unified
  .global _start
  .extern estado_semaforo  
  .text
 
  .thumb_func
 
_start:
    bl init_clks         
    bl init_ports
    bl init_gpio
    bl crear_tabla_leds       
    bl systick_config   
 
    // Máquina de estados
    ldr r4, =Base_maquina_0
    mov r1, #FILA1                  
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]   
 
    // Bucle principal
loop_principal:
    bl estado_matriz               
    b loop_principal                  
 
 
// Configuraciones iniciales

init_clks:
    ldr     r4, =#PCC_BASE
    ldr     r5, =#PCC_PORTB_OFFSET
    mov     r0, #1
    lsl     r0, #PCC_CGC_BIT
    str     r0, [r4, r5]
    ldr     r5, =#PCC_PORTD_OFFSET
    str     r0, [r4, r5]
    bx      lr

init_gpio:
    ldr     r4, =#GPIOB_BASE
    ldr     r5, =#GPIO_DDR_OFFSET
    ldr     r1, [r4, r5]
    ldr     r0, =#GPIOB
    orr     r0, r1
    str     r0, [r4,r5]
 
 
    ldr     r4, =#GPIOD_BASE
    ldr     r1, [r4, r5]
    ldr     r0, =#GPIOD
    orr     r0, r1
    str     r0, [r4,r5]
    bx      lr
 
init_ports:
    ldr     r4, =#PORTB_BASE
    ldr     r5, =#PORTB_PCB0_OFFSET

    ldr     r6, =#PORTD_BASE
    ldr     r7, =#PORTD_PCD0_OFFSET

    mov     r0, #1
    lsl     r0, #PORT_PCR_MUX_BITS

    
loop_init_portb:
    str     r0, [r4, r5]
    add     r5, r5, #4
    cmp     r5, #PORTB_PCB18_OFFSET
    bne     loop_init_portb

loop_init_portd:
    str     r0, [r6, r7]
    add     r7, r7, #4
    cmp     r7, #PORTD_PCD18_OFFSET
    bne     loop_init_portd
    bx      lr

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
 
systick_config:
   // Configurar SysTick 
    ldr r0, =SYST_RVR
    ldr r1, =SYSTICK_RELOAD_1MS
    str r1, [r0]                      
 
    ldr r0, =SYST_CVR
    mov r1, #0
    str r1, [r0]                      
 
    ldr r0, =SYST_CSR
    mov r1, #(SYSTICK_ENABLE | SYSTICK_TICKINT | SYSTICK_CLKSOURCE)
    str r1, [r0]                      // Habilitar el SysTick, la interrupción y seleccionar el reloj del procesador
    bx  lr

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
