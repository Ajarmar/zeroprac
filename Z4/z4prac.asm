    .gba
    .open "Rockman Zero 4 (Japan).gba", "z4prac.gba", 0x08000000
    .include "z4-regions.asm"
    .include "z4-constants.asm"
    .include "z4-stageselect.asm"
    .include "z4-timer.asm"
    .include "z4-checkpoints.asm"
    
    .org 0x08000920
    ldr     r1,=#REG_MAIN+1
    .pool
    bl      ADDR_BX_R1
    
    .org REG_MAIN
	.area REG_MAIN_AREA
    push    {r4-r7,r14}
    mov     r7,r10
    mov     r6,r9
    mov     r5,r8
    push    {r5-r7}
    ldr     r0,=#ADDR_KEY
    ldrh    r1,[r0]
    mov     r2,#VAL_KEY_SELECT
    and     r2,r1
    cmp     r2,#0x0
    bne     @select_pressed
    mov     r2,#0x1
    lsl     r2,r2,#OFFSET_KEY_R
    and     r2,r1
    cmp     r2,#0x0
    bne     @r_pressed
    b       main_end
@select_pressed:
    ldrh    r1,[r0,#0x4]
    mov     r2,#0x1
    lsl     r3,r2,#OFFSET_KEY_L
    and     r3,r1
    cmp     r3,#0x0
    beq     @no_L
    bl      check_state                 ; Select+L
    bl      load_checkpoint             ; Fix checkpoint loading
    b       main_end
@no_L:
    lsl     r3,r2,#0x1
    and     r3,r1
    cmp     r3,#0x0
    bne     main_end                    ; Select+R
    ; mov     r2,#VAL_KEY_UP
    ; and     r2,r1
    ; cmp     r2,#0x0
    ; bne     @change_rank              ; Select+Up
    mov     r2,#VAL_KEY_START
    and     r2,r1
    cmp     r2,#0x0
    beq     main_end
    bl      check_state                 ; Select+Start
    bl      show_menu                   ; Fix stage select menu
    b       main_end
@r_pressed:
    ldrh    r1,[r0,#0x4]
    mov     r2,#VAL_KEY_SELECT
    and     r2,r1
    cmp     r2,#0x0
    bne     main_end                    ; R+Select
main_end:
    bl      timer
    bl      @maintain_lives
    pop     {r5-r7}
    mov     r8,r5
    mov     r9,r6
    mov     r10,r7
    pop     {r4-r7}
    mov     r2,#0x80
    lsl     r2,r2,#0x13
    ldrh    r0,[r2]
    ldr     r1,=#0xFF7F
    and     r0,r1
    pop     r3
    bx      r3
    
; @change_rank:
    ; bl      check_state
    ; ldr     r4,=#0x02036F71
    ; ldrb    r5,[r4]
    ; cmp     r5,#0x5
    ; beq     @to_b_rank
    ; mov     r5,#0x5
    ; strb    r5,[r4]
    ; b       main_end
; @to_b_rank:
    ; mov     r5,#0x4
    ; strb    r5,[r4]
    ; b       main_end
    
    ; Jumps to subroutine end if the current game state is not 4.
    ; Used to prevent certain functionality from being used while 
    ; the game is paused.
check_state:
    ldr     r4,=#ADDR_GAMESTATE
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
    ldr     r4,=#ADDR_LIVES
    ldrb    r5,[r4]
    cmp     r5,#0x9
    bge     @@subr_end
    mov     r5,#0x9
    strb    r5,[r4]
@@subr_end:
    bx      r14
    .pool
    .endarea
    .close