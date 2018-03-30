; With "zeroprac" folder in the same folder as ARMIPS:
; compile with "armips z2-stageselect.asm -root zeroprac/Z2"

.gba
.open "Rockman Zero 2 (Japan).gba", "z2-stageselect.gba", 0x08000000

.org 0x080E4862

    mov     r5,#0xC             ; Check for start/select instead of just start
.skip 8
    ldr     r5,=#0x080F90F5     ; New subroutine
    bx      r5
.pool

.org 0x080F90F4

start_or_select:
    mov     r5,#0x8
    and     r0,r5
    cmp     r0,#0x8
    beq     only_start
    push    {r6,r7}
    ldr     r7,=#0x0202F8E1
    mov     r6,#0x9
    strb    r6,[r7]
    pop     {r6,r7}
    ldr     r4,=#0x080E4909
    bx      r4
only_start:
    ldr     r3,=#0x75B8
    add     r0,r7,r3
    ldr     r2,[r0]
    mov     r0,r2
    ldr     r1,=#0x080E4875
    bx      r1
.pool

.close