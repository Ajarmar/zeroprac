    .gba

    MENU_OFFSET_LVX equ 0x5
    LVX_ENTRY_MAX equ 32
    LVX_ENTRY_COUNT equ 6
    .org REG_CUSTOM_ROUTE_MENU_LVX
    .area REG_CUSTOM_ROUTE_MENU_LVX_AREA
    push    {r3-r7,r14}
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES
    mov     r1,#0x0
    mov     r2,#0x2
    bl      draw_textline  ; Draw explanation line 1
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*1
    mov     r1,#0x0
    mov     r2,#0x3
    bl      draw_textline  ; Draw explanation line 2
    ldr     r5,=#ADDR_CURSOR_POSITION_LVX
    ldrb    r4,[r5]
    ldr     r7,=#ADDR_LVX_STATE
    ldrb    r7,[r7]
    cmp     r7,#0x1
    bne     @@after_moving_cursor
    ldr     r7,=#0x02001EB0 ; Fixed (input checking)
    ldrh    r1,[r7,#0x6]
@@check_for_down:
    mov     r0,#VAL_KEY_DOWN
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_up
    add     r0,r4,#0x1
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
@@check_for_up:
    mov     r0,#VAL_KEY_UP
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
    mov     r0,#LVX_ENTRY_COUNT-1
@@no_upwrap:
    cmp     r0,#LVX_ENTRY_COUNT
    bne     @@no_downwrap
    mov     r0,#0x0
@@no_downwrap:
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
@@after_moving_cursor:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*1
    mov     r1,CURSOR_OFFSET
    add     r2,r4,#MENU_OFFSET_LVX
    bl      draw_textline
    strb    r4,[r5]
    mov     r3,#0x0         ; y offset
    ldr     r4,=#REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*2 ; First address of menu entry
    mov     r6,#LVX_ENTRY_MAX
@@print_menu_loop:
    mov     r1,#MENU_OFFSET  ; x offset
    mov     r2,r3
    add     r2,#MENU_OFFSET_LVX
    sub     r7,r2,#MENU_OFFSET_LVX      ; 0-indexed stage number
    mul     r7,r6           ; Stage select entry offset
    add     r0,r4,r7        ; Stage select entry address
    bl      draw_textline
    add     r3,#0x1
    cmp     r3,#LVX_ENTRY_COUNT
    blt     @@print_menu_loop
    ldr     r4,=#ADDR_LVX_STATE
    ldrb    r4,[r4]
    cmp     r4,#0x1
    ble     @@check_for_a
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*8
    mov     r1,#MENU_OFFSET
    mov     r2,#13
    bl      draw_textline
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*9
    mov     r1,#MENU_OFFSET
    mov     r2,#14
    bl      draw_textline
@@check_for_a:
    ldr     r7,=#ADDR_KEY
    ldrh    r1,[r7,#0x4]    ; Check for A input
    mov     r0,#VAL_KEY_A
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
    ldr     r0,=#ADDR_LVX_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x1
    bgt     @@confirm
    mov     r1,#0x2
    strb    r1,[r0]
    b       @@subr_end
@@confirm:
    mov     r1,#0x1
    strb    r1,[r0]
    ldr     r0,=#ADDR_CURSOR_POSITION_LVX
    ldrb    r2,[r0]
    ldr     r0,=#ADDR_STORED_CUSTOM_ROUTE_CFG
    cmp     r2,#0x0
    beq     @@goto_999_crystals
    cmp     r2,#0x1
    beq     @@goto_4_subtanks
    cmp     r2,#0x2
    beq     @@goto_swap_elves
    cmp     r2,#0x3
    beq     @@goto_swap_weapons
    cmp     r2,#0x4
    beq     @@goto_copy_route1
    cmp     r2,#0x5
    beq     @@goto_copy_route2
    b       @@subr_end
@@goto_999_crystals:
    bl      @set_999_crystals
    b       @@subr_end
@@goto_4_subtanks:
    bl      @set_4_subtanks
    b       @@subr_end
@@goto_swap_elves:
    bl      @swap_elves
    b       @@subr_end
@@goto_swap_weapons:
    bl      @swap_weapons
    b       @@subr_end
@@goto_copy_route1:
    mov     r1,#0x0
    bl      @copy_route
    b       @@subr_end
@@goto_copy_route2:
    mov     r1,#0x1
    bl      @copy_route
@@subr_end:
    pop     {r3-r7}
    pop     r0
    bx      r0
@@check_for_b:
    mov     r0,#VAL_KEY_B
    and     r0,r1
    cmp     r0,#0x0
    beq     @@subr_end
    ldr     r0,=#ADDR_LVX_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x1
    bgt     @@cancel
    mov     r1,#0x0
    strb    r1,[r0]
    b       @@subr_end
@@cancel:
    mov     r1,#0x1
    strb    r1,[r0]
    b       @@subr_end
    .pool
    
@set_999_crystals:
    push    {r3-r7,r14}
    mov     r3,#0x8
    add     r0,r0,r3
    mov     r3,#28
    mov     r4,#0x1
    ldr     r7,=#999
@@loop:
    mov     r5,r4
    mul     r5,r3
    add     r6,r0,r5
    strh    r7,[r6]
    add     r4,#0x1
    cmp     r4,#0x10
    blt     @@loop
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@set_4_subtanks:
    push    {r3-r7,r14}
    mov     r3,#0xA
    add     r0,r0,r3
    mov     r3,#28
    mov     r4,#0x1
    ldr     r7,=#0x20202020
@@loop:
    mov     r5,r4
    mul     r5,r3
    add     r6,r0,r5
    str     r7,[r6]
    add     r4,#0x1
    cmp     r4,#0x10
    blt     @@loop
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@swap_elves:
    push    {r3-r7,r14}
    add     r0,#2
    mov     r3,#28
    mov     r4,#0x1
@@loop:
    mov     r5,r4
    mul     r5,r3
    add     r6,r0,r5
    ldrb    r1,[r6]
    ldrb    r7,[r6,#0x1]
    strb    r1,[r6,#0x1]
    strb    r7,[r6]
    add     r4,#0x1
    cmp     r4,#0x10
    blt     @@loop
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@swap_weapons:
    push    {r3-r7,r14}
    add     r0,#14
    mov     r3,#28
    mov     r4,#0x1
@@loop:
    mov     r5,r4
    mul     r5,r3
    add     r6,r0,r5
    ldrb    r1,[r6]
    ldrb    r7,[r6,#0x1]
    strb    r1,[r6,#0x1]
    strb    r7,[r6]
    add     r4,#0x1
    cmp     r4,#0x10
    blt     @@loop
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@copy_route:
    push    {r3-r7,r14}
    mov     r7,r1
    mov     r3,#0x14
    mul     r3,r7
    ldr     r0,=#REG_STAGE_SELECT_DISPLAY
    add     r0,r3
    ldr     r1,=#ADDR_STAGE_SELECT_DISPLAY_CUSTOM
    ldmia   r0!,{r3-r6}
    stmia   r1!,{r3-r6}
    ldrb    r3,[r0]
    strb    r3,[r1]
    mov     r3,#0x14
    mul     r3,r7
    ldr     r0,=#REG_STAGE_SELECT_ROUTES
    add     r0,r3
    ldr     r1,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    ldmia   r0!,{r3-r6}
    stmia   r1!,{r3-r6}
    ldrb    r3,[r0]
    strb    r3,[r1]
    ldr     r0,=#REG_STAGE_SETTING_POINTERS
    mov     r3,#0x40
    mul     r3,r7
    add     r0,r3
    ldr     r1,=#ADDR_STORED_CUSTOM_ROUTE_CFG
    mov     r2,#0x0
@@load_store_loop:
    mov     r4,#0x4
    mul     r4,r2
    add     r3,r0,r4
    ldr     r3,[r3]
    ldrh    r4,[r3]
    strh    r4,[r1]
    add     r3,#0x2
    add     r1,#0x2
    ldmia   r3!,{r4-r6}
    stmia   r1!,{r4-r6}
    ldmia   r3!,{r4-r6}
    stmia   r1!,{r4-r6}
    ldrh    r4,[r3]
    strh    r4,[r1]
    add     r3,#0x2
    add     r1,#0x2
    add     r2,#0x1
    cmp     r2,#0x10
    blt     @@load_store_loop
@@subr_end:
    pop     {r3-r7}
    pop     r15
    .pool
    .endarea
    
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES
    .area REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES_AREA
    .asciiz "THE FOLLOWING OPTIONS AFFECT"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*1
    .asciiz "EVERY STAGE EXCEPT FOR INTRO"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*2
    .asciiz "999 E-CRYSTALS"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*3
    .asciiz "4 SUBTANKS"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*4
    .asciiz "SWAP ELF 1/ELF2"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*5
    .asciiz "SWAP MAIN/SUB WEAPON"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*6
    .asciiz "COPY ROUTE 1"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*7
    .asciiz "COPY ROUTE 2"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*8
    .asciiz "A: CONFIRM"
    .org REG_CUSTOM_ROUTE_MENU_LVX_ENTRIES+LVX_ENTRY_MAX*9
    .asciiz "B: CANCEL"
    .endarea