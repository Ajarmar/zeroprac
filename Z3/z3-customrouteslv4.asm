    ; this better be the deepest level

    .gba
    
    INIT_Y_OFFSET equ 3
    ELF_OFFSET equ 13
    LV4_ENTRY_MAX equ 16
    .org REG_CUSTOM_ROUTE_MENU_LV4
    .area REG_CUSTOM_ROUTE_MENU_LV4_AREA
    push    {r3-r7,r14}
    mov     r7,r0
    ldrb    r3,[r7]
    ldr     r4,=#ADDR_STORED_CUSTOM_ROUTE_CFG
    mov     r5,#VAL_STAGE_CFG_SIZE
    ldr     r6,=#ADDR_CHOSEN_STAGE
    ldrb    r6,[r6]
    sub     r6,#0x1
    mul     r6,r5
    add     r4,r4,r6
    ldr     r5,=#ADDR_CURSOR_POSITION_LV2
    ldrb    r5,[r5]
    mov     r6,#0x1
    cmp     r5,#0x5
    beq     @@print_ex_skills_loop
@@print_entries_loop:
    ldrb    r0,[r7,r6]          ; Offset in cfg
    mov     r1,r6               ; Entry number
    mov     r2,r4               ; Address to cfg area
    cmp     r5,#0x0
    beq     @@goto_elf
    cmp     r5,#0x1
    beq     @@goto_crystal
    cmp     r5,#0x2
    beq     @@goto_subtank
    cmp     r5,#0x3
    beq     @@goto_weapon
    cmp     r5,#0x4
    beq     @@goto_chip
    b       @@done_printing
@@goto_elf:
    bl      @print_elf_string_data
    b       @@loop_end
@@goto_crystal:
    bl      @print_crystal_string_data
    b       @@loop_end
@@goto_subtank:
    bl      @print_subtank_string_data
    b       @@loop_end
@@goto_weapon:
    bl      @print_weapon_string_data
    b       @@loop_end
@@goto_chip:
    bl      @print_chip_string_data
    b       @@loop_end
@@loop_end:
    add     r6,#0x1
    cmp     r6,r3
    ble     @@print_entries_loop
    b       @@done_printing
@@print_ex_skills_loop:
@@done_printing:
    ldr     r7,=#ADDR_KEY
    ldrh    r1,[r7,#0x4]    ; Check for A input
    mov     r0,#0x1
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
    ldr     r0,=#ADDR_LV4_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x0
    bne     @@return_to_zero
    mov     r1,#0x1
    strb    r1,[r0]
    b       @@subr_end
@@return_to_zero:
    mov     r1,#0x0
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
    mov     r1,#0x2
    strb    r1,[r0]
    b       @@subr_end
    .pool
    
@print_elf_string_data:
    push    {r3-r7,r14}
    mov     r5,r0
    mov     r6,r1
    mov     r7,r2
    mov     r1,#ELF_OFFSET
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    ldr     r3,=#ADDR_LV4_STATE
    ldrb    r3,[r3]
    cmp     r3,#0x0
    beq     @@no_leading_arrow
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES
    sub     r1,#0x1
    bl      draw_textline           ; Draw leading arrow
@@no_leading_arrow:
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    ldrb    r4,[r7,r5]
    cmp     r4,#0xFF
    beq     @@no_elf
    cmp     r4,#0x20
    beq     @@biraid
    cmp     r4,#0x34
    beq     @@clokkle
    b       @@subr_end
@@no_elf:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*1
    b       @@print_it
@@biraid:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*2
    b       @@print_it
@@clokkle:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*3
@@print_it:
    bl      draw_textline
    cmp     r3,#0x0
    beq     @@subr_end
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+2
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    bl      draw_textline           ; Draw trailing arrow
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
    ;
@print_crystal_string_data:
    push    {r3-r7,r14}
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@print_subtank_string_data:
    push    {r3-r7,r14}
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@print_weapon_string_data:
    push    {r3-r7,r14}
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@print_chip_string_data:
    push    {r3-r7,r14}
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@print_ex_skill_string_data:
    push    {r3-r7,r14}
@@subr_end:
    pop     {r3-r7}
    pop     r15
    .pool
    .endarea
    
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES
    .area REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES_AREA
    .asciiz "<"
    .asciiz ">"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*1
    .asciiz "NONE"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*2
    .asciiz "BIRAID"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*3
    .asciiz "CLOKKLE"
    .endarea