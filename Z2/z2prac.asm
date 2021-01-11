; With "zeroprac" folder in the same folder as ARMIPS:
; compile with "armips z2prac.asm -root zeroprac/Z2"

; STRUCTURE:
; Big open empty area at 0x0835780C - 0x0836DAFF.
; 0835780E - 08357BC5 = Stage settings (cfg/z2-stageselectcfg.asm)
; 08357BC6 - 083580FF = Stage select code (z2-stageselect.asm)
; 08358100 - 0835819F = Stage progress values for cutscene skips (cfg/z2-cutsceneskipscfg.asm)
; 083581A0 - 0835821F = Cutscene skip code (z2-cutsceneskips.asm)
; 08358220 - 083582FF = Textbox skip code (z2-cutsceneskips.asm)
; 08358300 - 083584FF = Main/input check code (z2prac.asm)
; 08358500 - ?        = "Don't reset RNG" code (z2-cutsceneskips.asm)

    .gba
    .open "Rockman Zero 2 (Japan).gba", "z2prac.gba", 0x08000000
    .include "z2-regions.asm"
    .include "z2-constants.asm"
    .include "z2-stageselect.asm"
    .include "z2-cutsceneskips.asm"
    .include "z2-timer.asm"
    .include "z2-checkpoints.asm"
    .include "z2-savestates.asm"
    
    .org 0x0800078C
    bl      #REG_MAIN
    
    ; Input checking for new functionality.
    ; Checks for Select+Start, Select+L, Select+R, R+Select
    .org REG_MAIN
    .area REG_MAIN_AREA
    push    {r4-r7,r14}
    mov     r7,r10
    mov     r6,r9
    mov     r5,r8
    push    {r5-r7}
    ldr     r0,=#0x02000D10
    ldrh    r1,[r0]
    mov     r2,#0x4
    and     r2,r1
    cmp     r2,#0x0
    bne     @select_pressed
    b       @subr_end
@select_pressed:
    mov     r2,#0x80
    lsl     r2,r2,#0x1
    and     r2,r1
    cmp     r2,#0x0
    bne     @r_pressed
    ldrh    r1,[r0,#0x4]
    mov     r2,#0x80
    lsl     r3,r2,#0x2
    and     r3,r1
    cmp     r3,#0x0
    beq     @after_checkpoint
    bl      load_checkpoint
@after_checkpoint:
    lsl     r3,r2,#0x1
    and     r3,r1
    cmp     r3,#0x0
    bne     @subr_end
    mov     r2,#0x8
    and     r2,r1
    cmp     r2,#0x0
    beq     @subr_end
    bl      @check_state
    bl      show_menu
    b       @subr_end
@r_pressed:
    mov     r2,#0x4
    and     r2,r1
    cmp     r2,#0x0
    bl      @change_rng                ; Branch to RNG changer
@subr_end:
    bl      timer
    bl      @maintain_lives
    pop     {r5-r7}
    mov     r8,r5
    mov     r9,r6
    mov     r10,r7
    pop     {r4-r7}
    bl      #0x080DE58C
    pop     r0
    bx      r0
    .pool
    
@load_checkpoint:
    bl      @check_state
    ldr     r4,=#ADDR_STAGETIME
    mov     r5,#0x0
    str     r5,[r4]
    ldr     r4,=#0x0202F8E1
    mov     r5,#0x3
    strb    r5,[r4]
    ldr     r1,=#0x02036C10     ; "Saved gameplay settings" section to write to
    ldr     r0,=#0x02037EDC     ; Read from control settings
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r3}         ; Load 8 bytes
    stmia   r1!,{r2-r3}         ; Store 8 bytes
    ldrh    r2,[r0]             ; Load another 2 bytes
    strh    r2,[r1]             ; Store another 2 bytes
    b       @subr_end
    .pool

    ; RNG change function. Code taken from 0x080AD44E,
    ; the game's existing RNG function
    ; This also resets the stage timer
@change_rng:
    ldr     r2,=#ADDR_RNG
    ldr     r1, [r2]
    ldr     r0,=#0x343FD
    mul     r0, r1
    ldr     r1,=#0x269EC3
    add     r0, r0, r1
    lsl     r0, r0, #0x01
    lsr     r1, r0, #0x01
    str     r1, [r2]
    ldr     r2,=#ADDR_STAGETIME
    mov     r1,#0x0
    str     r1, [r2]
    bx      r14
    .pool


    ; Jumps to subroutine end if the current game state is 0, 1 or 2
    ; Used to prevent certain functionality from being used while 
    ; the game is paused.
@check_state:
    ldr     r4,=#0x0202F8E1
    ldrb    r4,[r4]
    cmp     r4,#0x0
    beq     @subr_end
    cmp     r4,#0x1
    beq     @subr_end
    cmp     r4,#0x2
    beq     @subr_end
    bx      r14
    .pool
    
@maintain_lives:
    ldr     r4,=#ADDR_STORED_LIVES
    ldrb    r5,[r4]
    cmp     r5,#0x9
    bge     @@subr_end
    mov     r5,#0x9
    strb    r5,[r4]
@@subr_end:
    bx      r14
    .pool

    .endarea

    ; Set the Zero max entity count to 1
    ; This will break multiplayer but frees up a chunk of RAM that can be used (0x304 bytes)
    .org ROMADDR_SET_ZERO_ENTITY_MAX_LOCATION
    mov     r2,#0x1

    .close
