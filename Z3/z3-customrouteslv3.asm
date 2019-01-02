    .gba
    .include "z3-customrouteslv4.asm"

    MENU_OFFSET_LV3 equ 0x4
    LV3_DETAIL_MAX equ 0x4
    LV3_ENTRY_MAX equ 16
    .org REG_CUSTOM_ROUTE_MENU_LV3
    .area REG_CUSTOM_ROUTE_MENU_LV3_AREA
    push    {r3-r7,r14}
    mov     r3,#0x16
    add     r0,#0x3
    mul     r0,r3
    ldr     r3,=#REG_CUSTOM_ROUTE_MENU_ENTRIES
    add     r0,r0,r3
    mov     r1,#0x2
    mov     r2,#0x2
    bl      draw_textline  ; Draw category
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*2
    mov     r1,#0x0
    mov     r2,#0x2
    bl      draw_textline  ; Draw >>
    ldr     r5,=#ADDR_CURSOR_POSITION_LV3
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
    ldr     r7,=#ADDR_CURSOR_POSITION_LV2
    ldrb    r7,[r7]
    mov     r6,#LV3_DETAIL_MAX
    mul     r6,r7
    ldr     r7,=#REG_CUSTOM_ROUTE_MENU_LV3_DETAILS
    add     r7,r7,r6
    ldrb    r7,[r7]
    mov     r0,r4
    cmp     r0,#0xFF
    bne     @@no_upwrap
    sub     r0,r7,#0x1
@@no_upwrap:
    cmp     r0,r7
    bne     @@no_downwrap
    mov     r0,#0x0
@@no_downwrap:
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
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
    add     r2,r4,#MENU_OFFSET_LV3
    bl      draw_textline
    strb    r4,[r5]
    ldr     r4,=#ADDR_CURSOR_POSITION_LV2
    ldrb    r4,[r4]
    ldr     r5,=#REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES
    mov     r3,#0x0
    cmp     r3,r4
    beq     @@found_address
@@list_iteration_loop:
    ldr     r5,[r5]
    add     r3,#0x1
    cmp     r3,r4
    blt     @@list_iteration_loop
@@found_address:
    add     r5,#0x4
    mov     r6,#LV3_DETAIL_MAX
    mul     r6,r4
    ldr     r4,=#REG_CUSTOM_ROUTE_MENU_LV3_DETAILS
    add     r6,r4
    push    r6
    ldrb    r6,[r6]
    mov     r3,#0x0         ; y offset
    mov     r4,r5                   ; First address of menu entry
    mov     r5,r6
    mov     r6,#LV3_ENTRY_MAX
@@print_menu_loop:
    mov     r1,#MENU_OFFSET  ; x offset
    mov     r2,r3
    add     r2,#MENU_OFFSET_LV3
    sub     r7,r2,#MENU_OFFSET_LV3      ; 0-indexed stage number
    mul     r7,r6           ; Stage select entry offset
    add     r0,r4,r7        ; Stage select entry address
    bl      draw_textline
    add     r3,#0x1
    cmp     r3,r5
    blt     @@print_menu_loop
    ldr     r7,=#ADDR_KEY
    ldrh    r1,[r7,#0x4]    ; Check for A input
    mov     r0,#0x1
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
@@subr_end:
    pop     r0
    bl      REG_CUSTOM_ROUTE_MENU_LV4
    pop     {r3-r7}
    pop     r0
    bx      r0
@@check_for_b:
    mov     r0,#VAL_KEY_B
    and     r0,r1
    cmp     r0,#0x0
    beq     @@subr_end
    ldr     r0,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    mov     r1,#0x2
    strb    r1,[r0]
    ldr     r0,=#ADDR_CURSOR_POSITION_LV3
    mov     r1,#0x0
    strb    r1,[r0]
    b       @@subr_end
    .pool
    .endarea
    
    .org REG_CUSTOM_ROUTE_MENU_LV3_DETAILS
    .area REG_CUSTOM_ROUTE_MENU_LV3_DETAILS_AREA
    .db 2       ; Amount of entries in "Cyber Elves" menu
    .db 2       ; Offset for cyber elf 1
    .db 3       ; Offset for cyber elf 2
    .org REG_CUSTOM_ROUTE_MENU_LV3_DETAILS+LV3_DETAIL_MAX*0x1
    .db 1       ; Amount of entries in "E-crystals" menu
    .db 8       ; Offset for e-crystals
    .org REG_CUSTOM_ROUTE_MENU_LV3_DETAILS+LV3_DETAIL_MAX*0x2
    .db 1       ; Amount of entries in "Subtanks" menu
    .db 10      ; Offset for subtanks (add 1 for each subtank)
    .org REG_CUSTOM_ROUTE_MENU_LV3_DETAILS+LV3_DETAIL_MAX*0x3
    .db 2       ; Amount of entries in "Weapons" menu
    .db 14      ; Offset for main wep
    .db 15      ; Offset for sub wep
    .org REG_CUSTOM_ROUTE_MENU_LV3_DETAILS+LV3_DETAIL_MAX*0x4
    .db 3       ; Amount of entries in "Chips" menu
    .db 17      ; Offset for head chip
    .db 18      ; Offset for body chip
    .db 19      ; Offset for foot chip
    .org REG_CUSTOM_ROUTE_MENU_LV3_DETAILS+LV3_DETAIL_MAX*0x5
    .db 12      ; Amount of entries in "EX Skills" menu
    .db 20
    
    .endarea
    
    LV3_ENTRY_CELL_2 equ (REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES+4*1+LV3_ENTRY_MAX*0x2)
    LV3_ENTRY_CELL_3 equ (REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES+4*2+LV3_ENTRY_MAX*0x3)
    LV3_ENTRY_CELL_4 equ (REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES+4*3+LV3_ENTRY_MAX*0x4)
    LV3_ENTRY_CELL_5 equ (REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES+4*4+LV3_ENTRY_MAX*0x6)
    
    .org REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES
    .area REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES_AREA
    .dw LV3_ENTRY_CELL_2 ; pointer to next cell
    .asciiz "ELF 1: "
    .org REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES+4*1+LV3_ENTRY_MAX*0x1
    .asciiz "ELF 2: "
    
    .org LV3_ENTRY_CELL_2
    .dw LV3_ENTRY_CELL_3 ; pointer to next cell
    .asciiz "E-CRYSTALS: "
    
    .org LV3_ENTRY_CELL_3
    .dw LV3_ENTRY_CELL_4
    .asciiz "SUBTANKS: "
    
    .org LV3_ENTRY_CELL_4
    .dw LV3_ENTRY_CELL_5
    .asciiz "MAIN WEAPON: "
    .org REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES+4*4+LV3_ENTRY_MAX*0x5
    .asciiz "SUB WEAPON: "
    
    .org LV3_ENTRY_CELL_5
    .dw REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES
    .asciiz "HEAD CHIP: "
    .org REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES+4*5+LV3_ENTRY_MAX*0x7
    .asciiz "BODY CHIP: "
    .org REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES+4*5+LV3_ENTRY_MAX*0x8
    .asciiz "FOOT CHIP: "
    
    .endarea