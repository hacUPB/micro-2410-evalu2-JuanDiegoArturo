    .text
    // Direcciones de los registros SysTick
    .equ SYSTICK_BASE, 0xE000E010        // Base del SysTick
    .equ SYST_CSR, (SYSTICK_BASE + 0x0)  // SysTick Control and Status Register
    .equ SYST_RVR, (SYSTICK_BASE + 0x4)  // SysTick Reload Value Register
    .equ SYST_CVR, (SYSTICK_BASE + 0x8)  // SysTick Current Value Register
 
    .equ SYSTICK_ENABLE, 0x1             // Bit para habilitar el SysTick
    .equ SYSTICK_TICKINT, 0x2            // Bit para habilitar la interrupción del SysTick
    .equ SYSTICK_CLKSOURCE, 0x4          // Bit para seleccionar el reloj del procesador
 
    .equ SYSTICK_RELOAD_1MS, 48000-1     // Valor para recargar el SysTick cada 1 ms (suponiendo un reloj de 48 MHz)
 
    .equ Base_maquina_0, 0x20001000      // Dirección base compartida
    .equ var_estado_M0, 0                // Offset para la variable de estado
    .equ entrada_tiempo_M0, 4            // Offset para la entrada de tiempo transcurrido

    .equ unos, 0x3FFFF
 
    // Definición de los tiempos en ciclos de reloj (ajustar según la frecuencia del microcontrolador)
    .equ TIEMPO, 1

    // Definición de los estados
    .equ FILA1, 0
    .equ FILA2, 1
    .equ FILA3, 2
    .equ FILA4, 3
    .equ FILA5, 4
    .equ FILA6, 5
    .equ FILA7, 6
    .equ FILA8, 7

    // Clock
    .equ PCC_BASE, 0x40065000   
    .equ PCC_PORTB_OFFSET, 0x128
    .equ PCC_PORTD_OFFSET, 0x130
    .equ PCC_CGC_BIT, 30
    
    .equ PORTB_BASE, 0x4004A000 
    .equ PORTD_BASE, 0x4004C000
    .equ PORT_PCR_MUX_BITS, 0x8

    // B -> Ánodos -> Columnas -> 1
    .equ    PORTB_PCB18_OFFSET, 0x48 
    .equ    PORTB_PCB0_OFFSET, 0x00  
 
    // D -> Cátodos -> Filas -> 0
    .equ    PORTD_PCD18_OFFSET, 0x48
    .equ    PORTD_PCD0_OFFSET, 0x00
   
 
    // Direcciones de los registros GPIO (Ejemplo para Kinetis K64)
    .equ    GPIOB_BASE, 0x400FF040
    .equ    GPIOD_BASE, 0x400FF0c0
    .equ    GPIO_DDR_OFFSET, 0x14

    .equ    GPIOB, 0b1111111111111111111
    .equ    GPIOD, 0b1111111111111111111

    
    .equ GPIOB_PDDR, 0x400FF054          // Registro de dirección de datos del puerto B
    .equ GPIOB_PDOR, 0x400FF040          // Registro de salida de datos del puerto B
    .equ GPIOB_PTOR, 0x400FF04C          // Registro de alternancia de datos del puerto B
    .equ GPIOB_PSOR, 0x400FF044          // Registro de establecer bits de salida en puerto B
    .equ GPIOB_PCOR, 0x400FF048          // Registro de limpiar bits de salida en puerto B

    .equ GPIOD_PDDR, 0x400FF0D4      // Registro de dirección de datos del puerto E
    .equ GPIOD_PDOR, 0x400FF0C0          // Registro de salida de datos del puerto E
    .equ GPIOD_PTOR, 0x400FF0CC          // Registro de alternancia de datos del puerto E
    .equ GPIOD_PSOR, 0x400FF0C4          // Registro de establecer bits de salida en puerto E
    .equ GPIOD_PCOR, 0x400FF0C8          // Registro de limpiar bits de salida en puerto E
    
    .thumb_func


    