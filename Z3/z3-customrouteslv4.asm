    ; welcome to hell

    .gba
    
    MENU_OFFSET_LV4 equ 0x4
    ASCII_OFFSET equ 0x30
    INIT_Y_OFFSET equ 3
    ELF_OFFSET equ 13
    CRYSTAL_OFFSET equ 18
    SUBTANK_OFFSET equ 16
    WEAPON_OFFSET equ 19
    CHIP_OFFSET equ 17
    EX_OFFSET equ 6
    LV4_ENTRY_MAX equ 16
    LV4_ENTRY_DATA_MAX equ 4
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
    push    {r4,r7}
    beq     @@print_ex_skills
@@print_entries_loop:
    ldr     r0,=#ADDR_LV4_STATE
    ldrb    r0,[r0]
    cmp     r0,r6
    beq     @@read_from_selection
    ldrb    r0,[r7,r6]          ; Offset in cfg
    mov     r1,r6               ; Entry number
    mov     r2,r4               ; Address to cfg area
    b       @@arguments_selected
@@read_from_selection:
    mov     r0,#0x0
    mov     r1,r6
    ldr     r2,=#ADDR_LV4_SELECTION
@@arguments_selected:
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
@@print_ex_skills:
    ldrb    r0,[r7,r6]          ; Offset in cfg
    add     r0,r4
    bl      @print_ex_skill_cursor
    mov     r3,r0
    ldrb    r5,[r7,r6]
    add     r5,r4
    sub     r6,r5,#0x2
    ldrh    r5,[r5]             ; Unlocked EX skills
    ldrh    r6,[r6]             ; Equipped EX skills
    mov     r0,#0x0
    mov     r2,#0x0
    ldr     r7,=#ADDR_LV4_SELECTION
@@print_ex_skills_loop:
    cmp     r5,#0x0
    beq     @@done_printing
    lsl     r3,r5,#0x1F
    lsr     r3,r3,#0x1F
    cmp     r3,#0x0
    beq     @@no_skill
    strb    r0,[r7,r2]
    lsl     r1,r6,#0x1F
    lsr     r1,r1,#0x1F
    bl      @print_ex_skill_string_data
@@no_skill:
    lsr     r5,r5,#0x1
    lsr     r6,r6,#0x1
    add     r0,#0x1
    b       @@print_ex_skills_loop
@@done_printing:
    pop     {r4,r5}
    ldr     r7,=#ADDR_KEY
    ldrh    r1,[r7,#0x4]
    mov     r0,#VAL_KEY_A   ; Check for A input
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
    ldr     r2,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    ldrb    r2,[r2]
    ldr     r3,=#ADDR_CURSOR_POSITION_LV2
    ldrb    r3,[r3]
    cmp     r3,#0x5
    beq     @@ex_skill_case
    ldr     r0,=#ADDR_LV4_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x0
    bne     @@return_to_zero
    ldr     r1,=#ADDR_CURSOR_POSITION_LV3
    ldrb    r1,[r1]
    add     r1,#0x1
    strb    r1,[r0]
    ldrb    r6,[r5,r1]
    cmp     r3,#0x0
    beq     @@load_byte
    cmp     r3,#0x1
    beq     @@load_halfword
    cmp     r3,#0x2
    beq     @@load_word
@@load_byte:        ; elves, weapons, chips
    ldrb    r4,[r4,r6]
    b       @@store_as_selection
@@load_halfword:    ; e-crystals
    ldrh    r4,[r4,r6]
    b       @@store_as_selection
@@load_word:        ; subtanks
    ldr     r4,[r4,r6]
@@store_as_selection:
    ldr     r5,=#ADDR_LV4_SELECTION
    str     r4,[r5]
    b       @@subr_end
@@ex_skill_case:
    ldr     r0,=#ADDR_CURSOR_POSITION_LV3
    ldrb    r0,[r0]
    mov     r1,#0x1
    ldrh    r2,[r4,#20]                ; Equipped EX skills
    ldrh    r3,[r4,#22]                ; Unlocked EX skills
    ldr     r5,=#ADDR_LV4_SELECTION
    mov     r7,#0x1
    ldrb    r6,[r5,r0]
    lsl     r7,r6
    eor     r2,r7
    strh    r2,[r4,#20]
    b       @@subr_end
@@return_to_zero:
    ldrb    r6,[r5,r1]
    ldr     r5,=#ADDR_LV4_SELECTION
    ldr     r5,[r5]
    cmp     r3,#0x0
    beq     @@store_byte
    cmp     r3,#0x1
    beq     @@store_halfword
    cmp     r3,#0x2
    beq     @@store_word
@@store_byte:        ; elves, weapons, chips
    lsl     r5,r5,#0x18
    lsr     r5,r5,#0x18
    cmp     r3,#0x4
    beq     @@body_chip_element_check
    cmp     r5,#0xFF
    beq     @@check_if_clokkle_removed
    cmp     r6,#3
    beq     @@decrease_offset
    cmp     r6,#15
    beq     @@decrease_offset
    add     r7,r6,#0x1
    b       @@offset_changed
@@decrease_offset:
    sub     r7,r6,#0x1
@@offset_changed:
    ldrb    r2,[r4,r7]
    cmp     r2,r5
    bne     @@check_if_clokkle_removed
    ldrb    r2,[r4,r6]
    strb    r2,[r4,r7]
    b       @@just_store
@@body_chip_element_check:
    cmp     r6,#18          ; Is it a body chip?
    bne     @@just_store
    cmp     r5,#0x3         ; Is it elemental?
    blt     @@neutral_element
    sub     r2,r5,#0x2
    b       @@picked_element
@@neutral_element:
    mov     r2,#0x0
@@picked_element:
    strb    r2,[r4,#16]
@@just_store:
    strb    r5,[r4,r6]
    cmp     r5,#0x34
    bne     @@done_storing
    mov     r5,#0x4
    ldrb    r6,[r4,#0x1]
    orr     r5,r6
    strb    r5,[r4,#0x1]
    b       @@done_storing
@@check_if_clokkle_removed:
    ldrb    r3,[r4,r6]
    cmp     r3,#0x34
    bne     @@just_store
    mov     r3,#0x1
    strb    r3,[r4,#0x1]
    b       @@just_store
@@store_halfword:    ; e-crystals
    strh    r5,[r4,r6]
    b       @@done_storing
@@store_word:        ; subtanks
    str    r5,[r4,r6]
@@done_storing:
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
    beq     @@check_for_left
    ldr     r0,=#ADDR_LV4_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x0
    beq     @@subr_end
    mov     r1,#0x0
    strb    r1,[r0]
    b       @@subr_end
@@check_for_left:
    ldr     r0,=#ADDR_LV4_STATE
    ldrb    r0,[r0]
    cmp     r0,#0x0
    beq     @@subr_end
    ldrh    r1,[r7,#0x6]
    mov     r0,#VAL_KEY_LEFT
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_right
    mov     r0,#0x0
    b       @@change_value
@@check_for_right:
    mov     r0,#VAL_KEY_RIGHT
    and     r0,r1
    cmp     r0,#0x0
    beq     @@subr_end
    mov     r0,#0x1
@@change_value:
    ldr     r1,=#ADDR_CURSOR_POSITION_LV2
    ldrb    r1,[r1]
    cmp     r1,#0x0
    beq     @@change_elf
    cmp     r1,#0x1
    beq     @@change_crystals
    cmp     r1,#0x2
    beq     @@change_subtanks
    cmp     r1,#0x3
    beq     @@change_weapon
    cmp     r1,#0x4
    beq     @@change_chip_midpoint
    b       @@subr_end
    
@@change_elf:
    ldr     r2,=#ADDR_CHOSEN_STAGE
    ldrb    r2,[r2]
    sub     r2,#0x1
    mov     r3,#28
    mul     r3,r2
    ldr     r1,=#ADDR_STORED_CUSTOM_ROUTE_CFG
    add     r1,r3
    mov     r5,#0x1
    ldrh    r2,[r1]
    lsl     r2,r2,#0x1
    orr     r5,r2
    lsr     r2,r2,#0x7
    orr     r5,r2
    mov     r1,#0x0
    ldr     r2,=#ADDR_LV4_SELECTION
    ldrb    r3,[r2]
    cmp     r3,#0xFF
    beq     @@none
    cmp     r3,#0x20
    beq     @@biraid
    cmp     r3,#0x34
    beq     @@clokkle
@@none:
    mov     r3,#0x0
    b       @@got_elf_cursor
@@biraid:
    mov     r3,#0x1
    b       @@got_elf_cursor
@@clokkle:
    mov     r3,#0x2
@@got_elf_cursor:
    mov     r1,#0x1
    cmp     r0,#0x0
    beq     @@decrease_elf
@@increase_elf:
    add     r3,#0x1
    cmp     r3,#0x3
    blt     @@inc_elf_check  
    mov     r3,#0x0
@@inc_elf_check:
    mov     r4,r5
    lsr     r4,r3
    and     r4,r1
    beq     @@increase_elf
    b       @@elf_changed
@@decrease_elf:
    sub     r3,#0x1
    lsl     r3,r3,#0x18
    lsr     r3,r3,#0x18
    cmp     r3,#0xFF
    bne     @@dec_elf_check
    mov     r3,#0x2
@@dec_elf_check:
    mov     r4,r5
    lsr     r4,r3
    and     r4,r1
    beq     @@decrease_elf
@@elf_changed:
    mov     r5,#LV4_ENTRY_DATA_MAX
    mul     r5,r3
    ldr     r7,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA
    add     r7,r5
    ldrb    r7,[r7]
    strb    r7,[r2]
    b       @@subr_end
    
@@change_crystals:
    ldr     r2,=#ADDR_LV4_SELECTION
    ldrh    r1,[r2]
    cmp     r0,#0x0
    beq     @@decrease_crystals
    add     r1,#0x1
    ldr     r0,=#999
    cmp     r1,r0
    ble     @@crystals_changed
    mov     r1,#0x0
    b       @@crystals_changed
@@decrease_crystals:
    sub     r1,#0x1
    ldr     r0,=#0xFFFFFFFF
    cmp     r1,r0
    bne     @@crystals_changed
    ldr     r1,=#999
@@crystals_changed:
    strh    r1,[r2]
    b       @@subr_end
    
@@change_subtanks:
    ldr     r2,=#ADDR_LV4_SELECTION
    ldr     r1,[r2]
    ldr     r4,=#0xFFFFFF20
    cmp     r1,r4
    beq     @@one_subtank
    ldr     r4,=#0xFFFF2020
    cmp     r1,r4
    beq     @@two_subtanks
    ldr     r4,=#0xFF202020
    cmp     r1,r4
    beq     @@three_subtanks
    ldr     r4,=#0x20202020
    cmp     r1,r4
    beq     @@four_subtanks
@@one_subtank:
    mov     r3,#0x3
    b       @@got_subtank_cursor
@@two_subtanks:
    mov     r3,#0x4
    b       @@got_subtank_cursor
@@three_subtanks:
    mov     r3,#0x5
    b       @@got_subtank_cursor
@@four_subtanks:
    mov     r3,#0x6
@@got_subtank_cursor:
    cmp     r0,#0x0
    beq     @@decrease_subtanks
    add     r3,#0x1
    cmp     r3,#0x7
    blt     @@subtanks_changed    
    mov     r3,#0x3
    b       @@subtanks_changed
@@decrease_subtanks:
    sub     r3,#0x1
    lsl     r3,r3,#0x18
    lsr     r3,r3,#0x18
    cmp     r3,#0xFF
    bne     @@subtanks_changed
    mov     r3,#0x6
@@subtanks_changed:
    mov     r5,#LV4_ENTRY_DATA_MAX
    mul     r5,r3
    ldr     r7,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA
    add     r7,r5
    ldr     r7,[r7]
    str     r7,[r2]
    b       @@subr_end

@@change_chip_midpoint:
    b       @@change_chip
    
@@change_weapon:
    ldr     r2,=#ADDR_LV4_SELECTION
    ldrb    r3,[r2]
    cmp     r0,#0x0
    beq     @@decrease_weapon
    add     r3,#0x1
    cmp     r3,#0x4
    blt     @@weapon_changed    
    mov     r3,#0x0
    b       @@weapon_changed
@@decrease_weapon:
    sub     r3,#0x1
    lsl     r3,r3,#0x18
    lsr     r3,r3,#0x18
    cmp     r3,#0xFF
    bne     @@weapon_changed
    mov     r3,#0x3
@@weapon_changed:
    mov     r5,#LV4_ENTRY_DATA_MAX
    mul     r5,r3
    ldr     r7,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*7
    add     r7,r5
    ldrb    r7,[r7]
    strb    r7,[r2]
    b       @@subr_end
    
@@change_chip:
    ldr     r2,=#ADDR_CHOSEN_STAGE
    ldrb    r2,[r2]
    sub     r2,#0x1
    mov     r3,#28
    mul     r3,r2
    ldr     r5,=#ADDR_STORED_CUSTOM_ROUTE_CFG
    add     r5,r3
    ldr     r2,=#ADDR_LV4_SELECTION
    ldrb    r3,[r2]
    ldr     r4,=#ADDR_LV4_STATE
    ldrb    r6,[r4]
    cmp     r6,#0x1
    beq     @@head_chip
    cmp     r6,#0x2
    beq     @@body_chip
    cmp     r6,#0x3
    beq     @@foot_chip
@@head_chip:
    add     r5,#25
    mov     r6,#0x4
    ldr     r7,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*11
    b       @@chip_type_chosen
@@body_chip:
    add     r5,#26
    mov     r6,#0x6
    ldr     r7,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*15
    b       @@chip_type_chosen
@@foot_chip:
    add     r5,#27
    mov     r6,#0x8
    ldr     r7,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*21
@@chip_type_chosen:
    ldrb    r5,[r5]
    mov     r1,#0x1
    cmp     r0,#0x0
    beq     @@decrease_chip
@@increase_chip:
    add     r3,#0x1
    cmp     r3,r6
    blt     @@inc_chip_check  
    mov     r3,#0x0
@@inc_chip_check:
    mov     r4,r5
    lsr     r4,r3
    and     r4,r1
    beq     @@increase_chip
    b       @@chip_changed
@@decrease_chip:
    sub     r3,#0x1
    lsl     r3,r3,#0x18
    lsr     r3,r3,#0x18
    cmp     r3,#0xFF
    bne     @@dec_chip_check
    sub     r3,r6,#0x1
@@dec_chip_check:
    mov     r4,r5
    lsr     r4,r3
    and     r4,r1
    beq     @@decrease_chip
@@chip_changed:
    mov     r5,#LV4_ENTRY_DATA_MAX
    mul     r5,r3
    add     r7,r5
    ldrb    r7,[r7]
    strb    r7,[r2]
    b       @@subr_end
    .pool
    .endarea
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PRINTING SUBROUTINES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    .org REG_CUSTOM_ROUTE_MENU_LV4_PRINTING
    .area REG_CUSTOM_ROUTE_MENU_LV4_PRINTING_AREA
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
    cmp     r3,r6
    bne     @@no_leading_arrow
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
    cmp     r3,r6
    bne     @@subr_end
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
    mov     r5,r0
    mov     r6,r1
    mov     r7,r2
    ldrh    r4,[r7,r5]
    ldr     r3,=#999
    cmp     r4,r3
    ble     @@under_1k
    mov     r4,r3
@@under_1k:
    mov     r0,r4
    mov     r1,#100
    bl      div
    add     r0,#ASCII_OFFSET
    ldr     r3,=#ADDR_NUMBER_STRING
    strb    r0,[r3]
    mov     r0,r1
    mov     r1,#10
    bl      div
    add     r0,#ASCII_OFFSET
    ldr     r3,=#ADDR_NUMBER_STRING
    strb    r0,[r3,#0x1]
    add     r1,#ASCII_OFFSET
    strb    r1,[r3,#0x2]
    mov     r1,#0x0
    strb    r1,[r3,#0x3]
    mov     r1,#CRYSTAL_OFFSET
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    ldr     r3,=#ADDR_LV4_STATE
    ldrb    r3,[r3]
    cmp     r3,r6
    bne     @@no_leading_arrow
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES
    sub     r1,#0x1
    bl      draw_textline           ; Draw leading arrow
@@no_leading_arrow:
    ldr     r0,=#ADDR_NUMBER_STRING
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    bl      draw_textline
    cmp     r3,r6
    bne     @@subr_end
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+2
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    bl      draw_textline           ; Draw trailing arrow
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@print_subtank_string_data:
    push    {r3-r7,r14}
    mov     r5,r0
    mov     r6,r1
    mov     r7,r2
    ldr     r4,[r7,r5]
    mov     r2,#0x0
    lsl     r3,r4,#0x18
    lsr     r3,r3,#0x18
    cmp     r3,#0xFF
    beq     @@next_1
    add     r2,#0x1
@@next_1:
    lsl     r3,r4,0x10
    lsr     r3,r3,#0x18
    cmp     r3,#0xFF
    beq     @@next_2
    add     r2,#0x1
@@next_2:
    lsl     r3,r4,0x8
    lsr     r3,r3,#0x18
    cmp     r3,#0xFF
    beq     @@next_3
    add     r2,#0x1
@@next_3:
    lsr     r3,r4,#0x18
    cmp     r3,#0xFF
    beq     @@dunzo
    add     r2,#0x1
@@dunzo:
    add     r2,#ASCII_OFFSET
    ldr     r0,=#ADDR_NUMBER_STRING+2
    strb    r2,[r0]
    mov     r2,#0x0
    strb    r2,[r0,#0x1]
    mov     r1,#SUBTANK_OFFSET
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    ldr     r3,=#ADDR_LV4_STATE
    ldrb    r3,[r3]
    cmp     r3,r6
    bne     @@no_leading_arrow
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES
    sub     r1,#0x1
    bl      draw_textline           ; Draw leading arrow
@@no_leading_arrow:
    ldr     r0,=#ADDR_NUMBER_STRING+2
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    bl      draw_textline
    cmp     r3,r6
    bne     @@subr_end
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+2
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    bl      draw_textline           ; Draw trailing arrow
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@print_weapon_string_data:
    push    {r3-r7,r14}
    mov     r5,r0
    mov     r6,r1
    mov     r7,r2
    mov     r1,#WEAPON_OFFSET
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    ldr     r3,=#ADDR_LV4_STATE
    ldrb    r3,[r3]
    cmp     r3,r6
    bne     @@no_leading_arrow
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES
    sub     r1,#0x1
    bl      draw_textline           ; Draw leading arrow
@@no_leading_arrow:
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    ldrb    r4,[r7,r5]
    cmp     r4,#0x0
    beq     @@buster
    cmp     r4,#0x1
    beq     @@saber
    cmp     r4,#0x2
    beq     @@recoil
    cmp     r4,#0x3
    beq     @@shield
    b       @@subr_end
@@buster:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*4
    b       @@print_it
@@saber:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*5
    b       @@print_it
@@recoil:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*6
    b       @@print_it
@@shield:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*7
@@print_it:
    bl      draw_textline
    cmp     r3,r6
    bne     @@subr_end
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+2
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    bl      draw_textline           ; Draw trailing arrow
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@print_chip_string_data:
    push    {r3-r7,r14}
    mov     r5,r0
    mov     r6,r1
    mov     r7,r2
    mov     r1,#CHIP_OFFSET
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    ldr     r3,=#ADDR_LV4_STATE
    ldrb    r3,[r3]
    cmp     r3,r6
    bne     @@no_leading_arrow
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES
    sub     r1,#0x1
    bl      draw_textline           ; Draw leading arrow
@@no_leading_arrow:
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    ldrb    r4,[r7,r5]
    mov     r0,#LV4_ENTRY_MAX
    mul     r4,r0
    cmp     r6,#0x1
    beq     @@head
    cmp     r6,#0x2
    beq     @@body
    cmp     r6,#0x3
    beq     @@foot
    b       @@subr_end
@@head:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*8
    add     r0,r0,r4
    b       @@print_it
@@body:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*12
    add     r0,r0,r4
    b       @@print_it
@@foot:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*18
    add     r0,r0,r4
@@print_it:
    bl      draw_textline
    cmp     r3,r6
    bne     @@subr_end
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+2
    mov     r2,#INIT_Y_OFFSET
    add     r2,r2,r6
    bl      draw_textline           ; Draw trailing arrow
@@subr_end:
    pop     {r3-r7}
    pop     r15
    
@print_ex_skill_string_data:
    push    {r3-r7,r14}
    mov     r3,r0
    mov     r4,r1
    mov     r7,r2
    mov     r5,#LV4_ENTRY_MAX
    mul     r5,r3
    ldr     r6,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*26
    cmp     r4,#0x1
    bne     @@not_equipped
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+4
    mov     r1,#EX_OFFSET
    mov     r2,#INIT_Y_OFFSET+1
    add     r2,r2,r7
    bl      draw_textline
@@not_equipped:
    add     r0,r6,r5
    mov     r1,#EX_OFFSET+3
    mov     r2,#INIT_Y_OFFSET+1
    add     r2,r2,r7
    bl      draw_textline
@@subr_end:
    mov     r0,r3
    add     r2,r7,#0x1
    pop     {r3-r7}
    pop     r15
    
@print_ex_skill_cursor:
    push    {r3-r7,r14}
    mov     r3,#0x0
    ldrh    r4,[r0]
    mov     r5,#0x1F
@@loop:
    mov     r6,r4
    lsl     r6,r5
    lsr     r6,r6,#0x1F
    cmp     r6,#0x1
    bne     @@no_skill
    add     r3,#0x1
@@no_skill:
    sub     r5,#0x1
    cmp     r5,#0x13
    bgt     @@loop
    push    r3
    cmp     r3,#0x0
    bne     @@not_zero
    add     r3,#0x1
@@not_zero:
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
    mov     r7,r3
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
@@after_moving_cursor:
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*1
    mov     r1,CURSOR_OFFSET
    add     r2,r4,#MENU_OFFSET_LV4
    bl      draw_textline
    strb    r4,[r5]
@@subr_end:
    pop     r0
    pop     {r3-r7}
    pop     r15
    
    .pool
    .endarea
    
    
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES
    .area REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES_AREA
    .asciiz "<"
    .asciiz ">"
    .asciiz "E"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*1
    .asciiz "NONE"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*2
    .asciiz "BIRAID"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*3
    .asciiz "CLOKKLE"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*4
    .asciiz "BUSTER"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*5
    .asciiz "SABER"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*6
    .asciiz "RECOIL ROD"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*7
    .asciiz "SHIELD"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*8
    .asciiz "NEUTRAL"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*9
    .asciiz "AUTORECOVER"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*10
    .asciiz "AUTOCHARGE"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*11
    .asciiz "QUICKCHARGE"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*12
    .asciiz "NEUTRAL"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*13
    .asciiz "LIGHT"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*14
    .asciiz "ABSORBER"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*15
    .asciiz "THUNDER"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*16
    .asciiz "FLAME"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*17
    .asciiz "ICE"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*18
    .asciiz "NEUTRAL"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*19
    .asciiz "SPLASH JUMP"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*20
    .asciiz "DOUBLE JUMP"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*21
    .asciiz "SHADOW"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*22
    .asciiz "QUICK"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*23
    .asciiz "SPIKE"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*24
    .asciiz "FROG"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*25
    .asciiz "ULTIMA"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*26
    .asciiz "REFLECT LASER"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*27
    .asciiz "V-SHOT"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*28
    .asciiz "BURST SHOT"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*29
    .asciiz "BLIZZARD ARROW"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*30
    .asciiz "GALE ATTACK"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*31
    .asciiz "SABER SMASH"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*32
    .asciiz "SPLIT HEAVENS"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*33
    .asciiz "THROW BLADE"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*34
    .asciiz "1000 SLASH"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*35
    .asciiz "SOUL LAUNCHER"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*36
    .asciiz "SHIELD SWEEP"
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES+LV4_ENTRY_MAX*37
    .asciiz "ORBIT SHIELD"
    
    .endarea
    
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA
    .area REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA_AREA
    .db ELF_NONE
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*1
    .db ELF_BIRAID
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*2
    .db ELF_CLOKKLE
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*3
    .dw 0xFFFFFF20
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*4
    .dw 0xFFFF2020
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*5
    .dw 0xFF202020
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*6
    .dw 0x20202020
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*7
    .db WEP_BUSTER
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*8
    .db WEP_SABER
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*9
    .db WEP_RECOIL
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*10
    .db WEP_SHIELD
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*11
    .db HEAD_NEUTRAL
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*12
    .db HEAD_AUTORECOVER
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*13
    .db HEAD_AUTOCHARGE
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*14
    .db HEAD_QKCHARGE
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*15
    .db BODY_NEUTRAL
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*16
    .db BODY_LIGHT
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*17
    .db BODY_ABSORBER
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*18
    .db BODY_THUNDER
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*19
    .db BODY_FLAME
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*20
    .db BODY_ICE
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*21
    .db FOOT_NEUTRAL
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*22
    .db FOOT_SPLASHJUMP
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*23
    .db FOOT_DBLJUMP
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*24
    .db FOOT_SHADOW
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*25
    .db FOOT_QUICK
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*26
    .db FOOT_SPIKE
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*27
    .db FOOT_FROG
    .org REG_CUSTOM_ROUTE_MENU_LV4_ENTRY_DATA+LV4_ENTRY_DATA_MAX*28
    .db FOOT_ULTIMA
    
    .endarea