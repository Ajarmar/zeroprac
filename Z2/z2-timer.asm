    .gba
    .org REG_TIMER
    .area REG_TIMER_AREA
    
div:
    swi     #0x6
    bx      r14
    
timer:
    push    r14
    ldr     r0,=#ADDR_STAGETIME
    ldr     r0,[r0]
    mov     r1,#60
    bl      div
    mov     r4,r1               ; Frames
    mov     r1,#60
    bl      div
    mov     r5,r1               ; Seconds
    mov     r6,r0               ; Minutes
    ldr     r0,=#REG_TIMER_TABLE
    ldr     r3,=#0x3C7          ; Apostrophe
    ldr     r7,=#0x0202F924     ; Probably correct
    cmp     r6,#60
    blt     @store_numbers
    mov     r6,#0x0
@store_numbers:
    lsl     r6,r6,2
    add     r1,r0,r6
    ldr     r1,[r1]
    lsr     r2,r1,#0x10         ; r2 = upper digit
    lsl     r1,r1,#0x10
    lsr     r1,r1,#0x10          ; r1 = lower digit
    strh    r2,[r7]
    strh    r1,[r7,#0x2]
    strh    r3,[r7,#0x4]
    lsl     r5,r5,2
    add     r1,r0,r5
    ldr     r1,[r1]
    lsr     r2,r1,#0x10
    lsl     r1,r1,#0x10
    lsr     r1,r1,#0x10
    strh    r2,[r7,#0x6]
    strh    r1,[r7,#0x8]
    strh    r3,[r7,#0xA]
    lsl     r4,r4,2
    add     r1,r0,r4
    ldr     r1,[r1]
    lsr     r2,r1,#0x10
    lsl     r1,r1,#0x10
    lsr     r1,r1,#0x10
    strh    r2,[r7,#0xC]
    strh    r1,[r7,#0xE]
    pop     r0
    bx      r0
    
    .pool
    .endarea
    
    .org REG_TIMER_TABLE
    .area REG_TIMER_TABLE_AREA
    .dw 0x03D003D0  ; 00
    .dw 0x03D003D1  ; 01
    .dw 0x03D003D2  ; 02
    .dw 0x03D003D3  ; 03
    .dw 0x03D003D4  ; 04
    .dw 0x03D003D5  ; 05
    .dw 0x03D003D6  ; 06
    .dw 0x03D003D7  ; 07
    .dw 0x03D003D8  ; 08
    .dw 0x03D003D9  ; 09
    
    .dw 0x03D103D0  ; 10
    .dw 0x03D103D1  ; 11
    .dw 0x03D103D2  ; 12
    .dw 0x03D103D3  ; 13
    .dw 0x03D103D4  ; 14
    .dw 0x03D103D5  ; 15
    .dw 0x03D103D6  ; 16
    .dw 0x03D103D7  ; 17
    .dw 0x03D103D8  ; 18
    .dw 0x03D103D9  ; 19
    
    .dw 0x03D203D0  ; 20
    .dw 0x03D203D1  ; ...etc
    .dw 0x03D203D2
    .dw 0x03D203D3
    .dw 0x03D203D4
    .dw 0x03D203D5
    .dw 0x03D203D6
    .dw 0x03D203D7
    .dw 0x03D203D8
    .dw 0x03D203D9
    
    .dw 0x03D303D0
    .dw 0x03D303D1
    .dw 0x03D303D2
    .dw 0x03D303D3
    .dw 0x03D303D4
    .dw 0x03D303D5
    .dw 0x03D303D6
    .dw 0x03D303D7
    .dw 0x03D303D8
    .dw 0x03D303D9
    
    .dw 0x03D403D0
    .dw 0x03D403D1
    .dw 0x03D403D2
    .dw 0x03D403D3
    .dw 0x03D403D4
    .dw 0x03D403D5
    .dw 0x03D403D6
    .dw 0x03D403D7
    .dw 0x03D403D8
    .dw 0x03D403D9
    
    .dw 0x03D503D0
    .dw 0x03D503D1
    .dw 0x03D503D2
    .dw 0x03D503D3
    .dw 0x03D503D4
    .dw 0x03D503D5
    .dw 0x03D503D6
    .dw 0x03D503D7
    .dw 0x03D503D8
    .dw 0x03D503D9
    .endarea