    .gba
    .include "z3-customrouteslv3.asm"

    ; Menu offsets
    MENU_OFFSET_LV2 equ 0x4
    .org REG_CUSTOM_ROUTE_MENU_LV2
    .area REG_CUSTOM_ROUTE_MENU_LV2_AREA
    push    {r3-r7,r14}
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES
    mov     r1,#0x0
    mov     r2,#0x0
    bl      draw_textline  ; Draw "Editing..."
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*1
    mov     r1,#0x0
    mov     r2,#0x1
    bl      draw_textline
    ldr     r4,=#ADDR_CURSOR_POSITION
    ldrb    r4,[r4]
    ldr     r5,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    ldrb    r5,[r5,r4]
    ldr     r4,=#REG_STAGE_SELECT_ENTRIES
    sub     r7,r5,#0x1      ; 0-indexed stage index
    mov     r6,#0x16
    mul     r7,r6           ; Stage select entry offset
    add     r0,r4,r7        ; Stage select entry address
    mov     r1,#0x1
    mov     r2,#0x1
    bl      draw_textline
    mov     r0,r5           ; Stage index
    ldr     r5,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    ldrb    r5,[r5]
    cmp     r5,#0x2
    ble     @@category_not_chosen
    ldr     r0,=#ADDR_CURSOR_POSITION_LV2
    ldrb    r0,[r0]
    bl      REG_CUSTOM_ROUTE_MENU_LV3
    b       @@subr_end
@@category_not_chosen:
    ldr     r5,=#ADDR_CURSOR_POSITION_LV2
    ldrb    r4,[r5]
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
    mov     r0,#0x5
@@no_upwrap:
    cmp     r0,#0x6
    bne     @@no_downwrap
    mov     r0,#0x0
@@no_downwrap:
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
    push    {r3-r7}
    ldr     r4,=#REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*3
    ldr     r5,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    mov     r6,#0x16        ; Size of a stage select entry "cell"
    mov     r3,#MENU_OFFSET_LV2         ; y offset
@@print_menu_loop:
    mov     r1,MENU_OFFSET  ; x offset
    mov     r2,r3
    sub     r7,r2,#MENU_OFFSET_LV2      ; 0-indexed stage number
    mul     r7,r6           ; Stage select entry offset
    add     r0,r4,r7        ; Stage select entry address
    bl      draw_textline
    add     r3,#0x1
    cmp     r3,#MENU_OFFSET_LV2+5
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
    add     r2,r4,#MENU_OFFSET_LV2
    bl      draw_textline
    strb    r4,[r5]
    ldrh    r1,[r7,#0x4]    ; Check for A input
    mov     r0,#VAL_KEY_A
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
    ;; A press handling should be here!!
    ldr     r0,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    add     r1,r4,#0x3
    strb    r1,[r0]
@@subr_end:
    pop     {r3-r7}
    pop     r0
    bx      r0
@@check_for_b:
    mov     r0,#VAL_KEY_B
    and     r0,r1
    cmp     r0,#0x0
    beq     @@subr_end
    ldr     r0,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    mov     r1,#0x0
    strb    r1,[r0]
    b       @@subr_end
    .pool
    .endarea