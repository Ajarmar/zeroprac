; STRUCTURE:
; Big open empty area at 0x08386BDC - 0x083A0ADF.
; 08386BE0 - 08386C6F = New area for game state subroutines (z3-stageselect.asm)
; 08386C70 - 08386DFF = Stage select menu stage order and entries (z3-stageselect.asm)
; 08386E00 - 083870FF = Stage select menu subroutine (z3-stageselect.asm)
; 08387100 - 083871FF = Make stage select menu display correctly (z3-stageselect.asm)
; 08387200 - 083874FE = Main/input check code (z3prac.asm)
; 08387A00 - ?        = Stage checkpoints (z3-checkpoints.asm)
; 08389000 - 083891FF = Timer code (z3-timer.asm)
; 08389200 - ?        = Timer lookup table (z3-timer.asm)

    .gba
    .open "Rockman Zero 3 (Japan).gba", "z3prac.gba", 0x08000000
    .include "z3-stageselect.asm"
    .include "z3-cutsceneskips.asm"
    .include "z3-checkpoints.asm"
    .include "z3-timer.asm"
    
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
    b       main_end
@select_pressed:
    ldrh    r1,[r0,#0x4]
    mov     r2,#0x80
    lsl     r3,r2,#0x2
    and     r3,r1
    cmp     r3,#0x0
    beq     @no_L
    bl      check_state
    bl      load_checkpoint           ; Change to load state subroutine (maybe)
    b       main_end
@no_L:
    lsl     r3,r2,#0x1
    and     r3,r1
    cmp     r3,#0x0
    bne     main_end                  ; Change to save state subroutine (maybe)
    mov     r2,#0x40
    and     r2,r1
    cmp     r2,#0x0
    bne     @change_rank
    mov     r2,#0x8
    and     r2,r1
    cmp     r2,#0x0
    beq     main_end
    bl      check_state
    bl      show_menu
    b       main_end
@r_pressed:
    ldrh    r1,[r0,#0x4]
    mov     r2,#0x4
    and     r2,r1
    cmp     r2,#0x0
    bne     main_end                  ; Change to save state subroutine (maybe)
main_end:
    bl      timer
    bl      @maintain_lives
    bl      @set_omega_room
    bl      @store_charge
    pop     {r5-r7}
    mov     r8,r5
    mov     r9,r6
    mov     r10,r7
    pop     {r4-r7}
    mov     r2,#0x80
    lsl     r2,r2,#0x13
    pop     r0
    bx      r0
    
@change_rank:
    bl      check_state
    ldr     r4,=#0x02036F71
    ldrb    r5,[r4]
    cmp     r5,#0x5
    beq     @to_b_rank
    mov     r5,#0x5
    strb    r5,[r4]
    b       main_end
@to_b_rank:
    mov     r5,#0x4
    strb    r5,[r4]
    b       main_end
    
    ; Jumps to subroutine end if the current game state is not 4.
    ; Used to prevent certain functionality from being used while 
    ; the game is paused.
check_state:
    ldr     r4,=#0x02030B61
    ldrb    r4,[r4]
    cmp     r4,#0x4
    bne     main_end
    ; cmp     r4,#0x0
    ; beq     main_end
    ; cmp     r4,#0x1
    ; beq     main_end
    ; cmp     r4,#0x2
    ; beq     main_end
    ; cmp     r4,#0x3
    ; beq     main_end
    bx      r14
    
@maintain_lives:
    ldr     r4,=#0x02036F70
    ldrb    r5,[r4]
    cmp     r5,#0x9
    bge     @@subr_end
    mov     r5,#0x9
    strb    r5,[r4]
@@subr_end:
    bx      r14
    
@set_omega_room:
    ldr     r4,=#0x0202FE60
    ldrb    r5,[r4]
    cmp     r5,#0x10
    bne     @@subr_end
    ldrb    r5,[r4,#0x2]
    cmp     r5,#0xA
    beq     @@omega_1
    cmp     r5,#0xB
    beq     @@omega_2
    cmp     r5,#0xC
    beq     @@omega_zero
    b       @@subr_end
@@omega_1:
    mov     r5,#0x0
    strb    r5,[r4,#0xA]
    b       @@subr_end
@@omega_2:
    mov     r5,#0x3
    strb    r5,[r4,#0xA]
    b       @@subr_end
@@omega_zero:
    mov     r5,#0x7
    strb    r5,[r4,#0xA]
@@subr_end:
    bx      r14
    
@store_charge:
    ldr     r4,=#0x0202FE60
    ldrb    r5,[r4]
    cmp     r5,#0x1
    beq     @@continue
    cmp     r5,#0x6
    beq     @@continue
    cmp     r5,#0xA
    beq     @@continue
    cmp     r5,#0xF
    beq     @@continue
    cmp     r5,#0x10
    beq     @@continue_final
    b       @@subr_end
@@continue:
    mov     r6,#0x30
    add     r5,r4,r6
    ldr     r5,[r5]
    cmp     r5,#0x0
    beq     @@subr_end
    add     r5,#0xA4
    ldrh    r5,[r5]
    lsl     r5,r5,#0x10
    asr     r5,r5,#0x10
    cmp     r5,#0x0
    bgt     @@subr_end
    ldrb    r5,[r4,#0x5]
    lsr     r5,r5,#0x4
    cmp     r5,#0x7
    bne     @@subr_end
    ldr     r5,=#0x02036FE8
    ldrh    r5,[r5]
    add     r4,#0x24
    strh    r5,[r4]
    b       @@subr_end
@@continue_final:
    ldrb    r5,[r4,#0x2]
    cmp     r5,#0x9
    beq     @@continue
@@subr_end:
    bx      r14
    
    .pool
    .endarea
    .close