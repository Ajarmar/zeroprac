    .gba
    .include "z3-customrouteslv2.asm"
    
    UNLOCK_CELL_SIZE equ 8
    ; New code. Stage names for the stage select menu in stage index order.
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES
    .area REG_CUSTOM_ROUTE_MENU_ENTRIES_AREA
    .asciiz "EDITING CUSTOM ROUTE"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*1
    .asciiz ">"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*2
    .asciiz ">>"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*3
    .asciiz "CYBER ELVES"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*4
    .asciiz "E-CRYSTALS"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*5
    .asciiz "SUBTANKS"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*6
    .asciiz "WEAPONS"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*7
    .asciiz "CHIPS"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*8
    .asciiz "EX SKILLS"
    .endarea
    
    ; New code. Recreation of stage select menu routine from Z2.
    ; ORDER OF OPERATIONS:
    ; 1. Check a bunch of random shit
    ; 2. Check for up/down input, increment/decrement stage index
    ; 3. Draw stage select menu, including cursor
    ; 4. Check for A input
    ; 5a. A input -> goto 6
    ; 5b. No A input -> goto 8
    ; 6. Load stage settings
    ; 7. Set stage index and game state
    ; 8. End
    .org REG_CUSTOM_ROUTE_MENU ;0x08389680
    .area REG_CUSTOM_ROUTE_MENU_AREA
    push    {r4-r7,r14}
    ldr     r5,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    ldrb    r5,[r5]
    cmp     r5,#0x1
    ble     @@level_not_chosen
    ldr     r5,=#REG_CUSTOM_ROUTE_MENU_LV2+1
    bl      REG_CUSTOM_ROUTE_MENU_LV2
    b       @@subr_end
@@level_not_chosen:
    ldr     r5,=#ADDR_CURSOR_POSITION
    ldrb    r4,[r5]
    ldr     r7,=#0x02001EB0 ; Fixed (input checking)
    ldrh    r1,[r7,#0x6]
@@check_for_down:
    mov     r0,#0x80
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_up
    add     r0,r4,#0x1
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
@@check_for_up:
    mov     r0,#0x40
    and     r0,r1
    cmp     r0,#0x0
    beq     @@no_up
    mov     r0,r4
    sub     r0,#0x1
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
@@no_up:
    mov     r0,r4
    cmp     r0,#0xFF
    bne     @@no_upwrap
    mov     r0,#0x10
@@no_upwrap:
    cmp     r0,#0x11
    bne     @@no_downwrap
    mov     r0,#0x0
@@no_downwrap:
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
    push    {r3-r7}
    ldr     r4,=#REG_STAGE_SELECT_ENTRIES
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES
    mov     r1,#0x0
    mov     r2,#0x0
    bl      draw_textline  ; Draw route name
    ldr     r5,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    mov     r6,#0x16        ; Size of a stage select entry "cell"
    mov     r3,#0x1         ; y offset
@@print_menu_loop:
    mov     r1,MENU_OFFSET  ; x offset
    mov     r2,r3
    sub     r7,r2,#0x1      ; 0-indexed stage number
    ldrb    r7,[r5,r7]      ; 1-indexed stage index
    sub     r7,#0x1         ; 0-indexed stage index
    mul     r7,r6           ; Stage select entry offset
    add     r0,r4,r7        ; Stage select entry address
    bl      draw_textline
    add     r3,#0x1
    cmp     r3,#0x11
    ble     @@print_menu_loop
    ldr     r3,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    ldrb    r3,[r3]
    cmp     r3,#0x1
    beq     @@diff_cursor
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*1
    mov     r1,CURSOR_OFFSET
    b       @@cursor_chosen
@@diff_cursor:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*2
    mov     r1,CURSOR_OFFSET-1
@@cursor_chosen:
    pop     {r3-r7}
    add     r2,r4,#0x1
    bl      draw_textline
    strb    r4,[r5]
    ldrh    r1,[r7,#0x4]    ; Check for A input
    mov     r0,#0x1
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
    ldr     r0,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x1
    beq     @@confirm_change
    mov     r1,#0x2
    strb    r1,[r0]
    ldr     r0,=#ADDR_CHOSEN_STAGE
    ldr     r2,=#ADDR_CURSOR_POSITION
    ldrb    r2,[r2]
    ldr     r3,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    ldrb    r1,[r3,r2]
    strb    r1,[r0]
@@subr_end:
    pop     {r4-r7}
    pop     {r0}
    bx      r0
@@check_for_b:
    mov     r0,#0x2
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_select
    ldr     r0,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x1
    bne     @@exit_menu
    mov     r1,#0x0
    strb    r1,[r0]
    b       @@subr_end
@@exit_menu:
    ldr     r0,=#ADDR_GAMESTATE
    ldr     r1,=#ADDR_STORED_GAMESTATE
    ldrb    r1,[r1]
    cmp     r1,#0x0
    bne     @@store_menu
    mov     r1,#0x1E
@@store_menu:
    strb    r1,[r0]
    b       @@subr_end
@@check_for_select:
    mov     r0,#0x1
    lsl     r0,r0,#OFFSET_KEY_SEL
    and     r0,r1
    cmp     r0,#0x0
    beq     @@subr_end
    ldr     r0,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x0
    beq     @@change_pos
    cmp     r1,#0x1
    beq     @@confirm_change
    b       @@subr_end
@@change_pos:
    ldr     r1,=#ADDR_CURSOR_POSITION
    ldrb    r1,[r1]
    cmp     r1,#0x0
    beq     @@subr_end
    cmp     r1,#0xF
    bge     @@subr_end
    mov     r2,#0x1
    strb    r2,[r0]
    ldr     r0,=#ADDR_CHANGING_ORDER
    strb    r1,[r0]
    b       @@subr_end
@@confirm_change:
    ldr     r1,=#ADDR_CURSOR_POSITION
    ldrb    r1,[r1]
    cmp     r1,#0x0
    beq     @@subr_end
    cmp     r1,#0xF
    bge     @@subr_end
    ldr     r0,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    mov     r1,#0x0
    strb    r1,[r0]
    ldr     r0,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    ldr     r1,=#ADDR_CURSOR_POSITION
    ldrb    r1,[r1]
    ldr     r2,=#ADDR_CHANGING_ORDER
    ldrb    r2,[r2]
    ldrb    r3,[r0,r1]
    ldrb    r4,[r0,r2]
    strb    r4,[r0,r1]
    strb    r3,[r0,r2]
    push    r0
    ldr     r0,=#ADDR_CHANGING_ORDER
    cmp     r2,r1
    blt     @@store_r3
    strb    r4,[r0]
    b       @@store_display_order
@@store_r3:
    strb    r3,[r0]
@@store_display_order:
    ldr     r0,=#ADDR_STAGE_SELECT_DISPLAY_CUSTOM
    sub     r3,r3,#0x1
    sub     r4,r4,#0x1
    ldrb    r1,[r0,r3]
    ldrb    r2,[r0,r4]
    strb    r2,[r0,r3]
    strb    r1,[r0,r4]
    pop     r0
    mov     r3,#0x2
@@route_unlocks:
    mov     r1,#0x0
    ldr     r2,=#0x00010101
    mov     r4,#0x1
@@route_unlock_loop:
    ldrb    r5,[r0,r4]
    cmp     r3,r5
    beq     @@loop_done
    sub     r5,#0x2
    ldr     r7,=#REG_CUSTOM_ROUTE_MENU_STAGE_UNLOCKS
    mov     r6,#UNLOCK_CELL_SIZE
    mul     r6,r5
    add     r7,r6
    ldr     r5,[r7]
    ldr     r6,[r7,#0x4]
    orr     r1,r5
    orr     r2,r6
    add     r4,#0x1
    b       @@route_unlock_loop
@@loop_done:
    mov     r5,#28
    ldr     r6,=#ADDR_STORED_CUSTOM_ROUTE_CFG
    sub     r4,r3,#0x1
    mul     r5,r4
    add     r6,r5
    ldrb    r7,[r6,#2]
    cmp     r7,#0x34
    beq     @@clokkle_is_here
@@check_elf_2:
    ldrb    r7,[r6,#3]
    cmp     r7,#0x34
    bne     @@after_clokkle_check
@@clokkle_is_here:
    mov     r7,#0x4
    lsl     r7,r7,#0x8
    orr     r1,r7
@@after_clokkle_check:
    strh    r1,[r6]
    lsr     r1,r1,#0x10
    strh    r1,[r6,#22]
    strb    r2,[r6,#25]
    lsr     r2,r2,#0x8
    strh    r2,[r6,#26]
    ldr     r4,=#ADDR_CHANGING_ORDER
    ldrb    r4,[r4]
    cmp     r3,r4
    bne     @@continue
    ldrh    r4,[r6,#20]
    and     r4,r1
    strh    r4,[r6,#20]
@@continue:
    add     r3,#0x1
    cmp     r3,#0x10
    blt     @@route_unlocks
    b       @@subr_end
    .pool
    
    ; r0 = string to be drawn, r1 = x offset, r2 = y offset
    ; exiting this subroutine, r1 can be reused to continue drawing
draw_textline: 
    push    {r3-r7,r14}
    mov     r3,r0
    mov     r4,r1
    mov     r7,r4
    ldr     r1,=#0x02030B70 ; Fixed (BG0 tiles)
    cmp     r2,#0x1F
    bhi     @@subr_end      ; Avoid trying to draw outside of screen
    lsl     r0,r2,#0x5
    add     r0,r4,r0
    lsl     r0,r0,#0x1
    add     r1,r1,r0
    ldrb    r0,[r3]
    cmp     r0,#0x0         ; Check for terminating null byte
    beq     @@subr_end      ; Go to end if there is a null byte
    mov     r2,#0xE8
    lsl     r2,r2,#0x2
    mov     r5,r2
    mov     r6,#0xB8
    lsl     r6,r6,#0x2
    mov     r2,r6
@@write_loop:
    cmp     r4,#0x1F
    bhi     @@subr_end      ; Avoid trying to draw outside of screen again
    cmp     r0,#0x9F
    bhi     @@not_sure      ; I don't think this branch will ever be used, but who knows
    ldrb    r6,[r3]
    add     r0,r5,r6
    b       @@store_letter
@@not_sure:
    ldrb    r6,[r3]
    add     r0,r2,r6
@@store_letter:
    strh    r0,[r1]
    add     r3,#0x1
    add     r1,#0x2
    add     r7,#0x1
    ldrb    r0,[r3]
    cmp     r0,#0x0         ; Check for terminating null byte
    bne     @@write_loop
@@subr_end:
    mov     r1,r7
    pop     {r3-r7}
    pop     {r0}
    bx      r0
    .pool
    .endarea
    
    ; Order: Biraid, Clokkle, EX skills, chips
    ; Stages ordered by index
    .org REG_CUSTOM_ROUTE_MENU_STAGE_UNLOCKS
    .area REG_CUSTOM_ROUTE_MENU_STAGE_UNLOCKS_AREA
    ; Flizard
    .db 0
    .db ELF_EXISTS
    .dh EX_BURST
    .db 0
    .db UNLBODY_FLAME
    .db 0
    .db 0
    
    ; Childre
    .db 0
    .db 0
    .dh EX_THROW
    .db 0
    .db UNLBODY_ICE
    .db 0
    .db 0
    
    ; Hellbat
    .db ELF_EXISTS
    .db 0
    .dh EX_SMASH
    .db 0
    .db UNLBODY_THUNDER
    .db 0
    .db 0
    
    ; Mantisk
    .db 0
    .db 0
    .dh EX_1000
    .db 0
    .db UNLBODY_LIGHT
    .db 0
    .db 0
    
    ; Baby Elves 1
    .db 0
    .db 0
    .dh 0
    .db 0
    .db 0
    .db 0
    .db 0
    
    ; Anubis
    .db 0
    .db 0
    .dh EX_SWEEP
    .db 0
    .db 0
    .db 0
    .db 0
    
    ; Hanumachine
    .db 0
    .db 0
    .dh EX_SPLIT
    .db 0
    .db 0
    .db 0
    .db 0
    
    ; Blizzack
    .db 0
    .db 0
    .dh EX_BLIZZ
    .db 0
    .db 0
    .db 0
    .db 0
    
    ; Copy X
    .db 0
    .db 0
    .dh EX_LASER
    .db 0
    .db 0
    .db UNLFOOT_QUICK
    .db 0
    
    ; Foxtar
    .db 0
    .db 0
    .dh EX_SOUL
    .db 0
    .db 0
    .db UNLFOOT_DBLJUMP
    .db 0
    
    ; Cactank
    .db 0
    .db 0
    .dh EX_ORBIT
    .db UNLHEAD_QKCHARGE
    .db 0
    .db UNLFOOT_SPIKE
    .db 0
    
    ; Volteel
    .db 0
    .db 0
    .dh EX_VSHOT
    .db 0
    .db 0
    .db UNLFOOT_SHADOW
    .db 0
    
    ; Kelverian
    .db 0
    .db 0
    .dh EX_GALE
    .db 0
    .db UNLBODY_ABSORBER
    .db 0
    .db 0
    
    ; Baby Elves 2
    .db 0
    .db 0
    .dh 0
    .db 0
    .db 0
    .db 0
    .db 0
    
    .endarea