    .gba
    .open "Rockman Zero 3 (Japan).gba", "z3prac.gba", 0x08000000
    .include "z3-stageselect.asm"
    .include "z3-cutsceneskips.asm"
    .include "z3-checkpoints.asm"
    
    .org 0x080019D0
    bl      0x08387200
    
    .org 0x08387200
	.area 0x2FE
    push    {r4-r7,r14}
    mov     r7,r10
    mov     r6,r9
    mov     r5,r8
    push    {r5-r7}
    ldr     r0,=#0x02001EB0
    ldrh    r1,[r0]
    mov     r2,#0x4
    and     r2,r1
    cmp     r2,#0x0
    bne     @select_pressed
    mov     r2,#0x80
    lsl     r2,r2,#0x1
    and     r2,r1
    cmp     r2,#0x0
    bne     @r_pressed
    b       @subr_end
@select_pressed:
    ldrh    r1,[r0,#0x4]
    mov     r2,#0x80
    lsl     r3,r2,#0x2
    and     r3,r1
    cmp     r3,#0x0
    bne     @load_checkpoint           ; Change to load state subroutine
    lsl     r3,r2,#0x1
    and     r3,r1
    cmp     r3,#0x0
    bne     @subr_end                  ; Change to save state subroutine
    mov     r2,#0x40
    and     r2,r1
    cmp     r2,#0x0
    bne     @change_rank
    mov     r2,#0x8
    and     r2,r1
    cmp     r2,#0x0
    beq     @subr_end
    bl      check_state
    bl      show_menu
    b       @subr_end
@r_pressed:
    ldrh    r1,[r0,#0x4]
    mov     r2,#0x4
    and     r2,r1
    cmp     r2,#0x0
    bne     @subr_end                  ; Change to save state subroutine
@subr_end:
    pop     {r5-r7}
    mov     r8,r5
    mov     r9,r6
    mov     r10,r7
    pop     {r4-r7}
    mov     r2,#0x80
    lsl     r2,r2,#0x13
    pop     r0
    bx      r0
    
@load_checkpoint:
    bl      check_state
    ldr     r4,=#0x02030B61
    mov     r5,#0x3
    strb    r5,[r4]
    ldr     r1,=#0x02036FC0     ; "Saved gameplay settings" section to write to
    ldr     r0,=#0x02037D14     ; Read from control settings
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r4}         ; Load 12 bytes
    stmia   r1!,{r2-r4}         ; Store 12 bytes
    ldrh    r2,[r0]             ; Load another 2 bytes
    strh    r2,[r1]             ; Store another 2 bytes
    ldr     r3,=#0x02036DC0
    ldrb    r4,[r3]
    sub     r4,r4,1
    mov     r5,#0x2
    mul     r4,r5
    ldr     r6,=#0x08387A00
    add     r6,r6,r4
    ldr     r0,=#0x02001EB0
    ldrh    r1,[r0]
    mov     r2,#0x20
    and     r2,r1
    cmp     r2,#0x0
    bne     @left_held
    mov     r2,#0x10
    and     r2,r1
    cmp     r2,#0x0
    beq     @subr_end
    ldr     r7,=#0x0202FE62
    ldrb    r2,[r6,#0x1]
    strb    r2,[r7]
    b       @subr_end
@left_held:
    ldr     r7,=#0x0202FE62
    ldrb    r2,[r6]
    strb    r2,[r7]
    b       @subr_end
    
@change_rank:
    bl      check_state
    ldr     r4,=#0x02036F71
    ldrb    r5,[r4]
    cmp     r5,#0x5
    beq     @to_b_rank
    mov     r5,#0x5
    strb    r5,[r4]
    b       @subr_end
@to_b_rank:
    mov     r5,#0x4
    strb    r5,[r4]
    b       @subr_end
    
    ; Jumps to subroutine end if the current game state is 0, 1, 2 or 3.
    ; Used to prevent certain functionality from being used while 
    ; the game is paused.
check_state:
    ldr     r4,=#0x02030B61
    ldrb    r4,[r4]
    cmp     r4,#0x0
    beq     @subr_end
    cmp     r4,#0x1
    beq     @subr_end
    cmp     r4,#0x2
    beq     @subr_end
    cmp     r4,#0x3
    beq     @subr_end
    bx      r14
    
    .pool
    .endarea
    .close