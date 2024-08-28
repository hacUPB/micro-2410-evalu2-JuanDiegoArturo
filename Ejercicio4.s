.syntax unified
.global _start
.text

// Se guardan variables simbólicas
.equ v1, 0x20000100 
.equ v2, 0x20000140
.equ vRes, 0x20000200

// Definición de los datos de entrada (vectores)
lista1:
.hword 1,2,3,4,0 // Media palabra -> 16 bits -> 0,001,010,011,100,000

lista2:
.hword 2,3,4,5,0

.thumb_func
_start:
    bl    init      
    bl    vector1  
    bl    vector2   
loop:
    bl    mult_vect  
    b     loop       

// Función de inicialización
init:
  // Retorna, no hace nada
  bx    lr

vector1:
  push  {lr} // Guarda la dirección de LR en el STACK
  ldr   r4, =#lista1 // Guarda la dierección de la lista 1 en R4
  ldr   r5, =#v1 // Guarda la dirección objetivo en R5
  bl    loop_store // Salta a loop_store
  pop   {pc}

vector2: // Lo mismo que la subrutina vector1
  push  {lr}
  ldr   r4, =#lista2
  ldr   r5, =#v2
  bl    loop_store
  pop   {pc}

loop_store:
  ldrh  r0, [r4], #2 // Guarda en R0 la media palabra de la dirección R4 y va sumando #2 con cada iteración
  cmp   r0, #0  // Compara (resta) R0 con 0 y actualiza la bandera
  beq   end_store // Si la comparación dió 0, salta a end_store
  strh  r0, [r5], #2 // Si no dio 0, guarda la media palabra de R0 en la dirección que apunta R5 y suma #2 con cada iteración
  b     loop_store // Incondicionalmente salta a loop_store
end_store:
  // Retorna
  bx    lr

mult_vect:
  ldr   r4, =#v1 // Guarda las direcciones en la que quedaron guardadas las listas
  ldr   r5, =#v2
  ldr   r6, =#vRes // La dirección del resultado
  b     loop_mult

loop_mult:
  ldrh  r0, [r4], #2 // Carga la media palabra del vector 1
  ldrh  r1, [r5], #2 // Carga el vector 2
  cmp   r0, #0 // Compara con 0 para ver si terminó la lista 1
  beq   end_mult // Si acabó, termina la operación
  cmp   r1, #0 // Compara con 0 para ver si terminó la lista 2
  beq   end_mult // Si acabó, termina la operación 
  mul   r0, r1 // Multiplica r0 con r1 y lo guarda en r0
  str   r0, [r6], #4 // En la memoria, guarda el resultado de la multiplicación en la dirección que apunta r6 y va sumando #4 en cada iteración
  b     loop_mult // Incondicionalmente salta a loop_mult
end_mult:
  // Retorna
  bx    lr