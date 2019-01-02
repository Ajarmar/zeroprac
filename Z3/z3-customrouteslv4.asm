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
    beq     @@print_ex_skills
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
@@print_ex_skills_loop:
    cmp     r5,#0x0
    beq     @@done_printing
    lsl     r3,r5,#0x1F
    lsr     r3,r3,#0x1F
    cmp     r3,#0x0
    beq     @@no_skill
    lsl     r1,r6,#0x1F
    lsr     r1,r1,#0x1F
    bl      @print_ex_skill_string_data
@@no_skill:
    lsr     r5,r5,#0x1
    lsr     r6,r6,#0x1
    add     r0,#0x1
    b       @@print_ex_skills_loop
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
    ldr     r1,=#ADDR_CURSOR_POSITION_LV3
    ldrb    r1,[r1]
    add     r1,#0x1
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
    ldr     r0,=#ADDR_LV4_STATE
    ldrb    r1,[r0]
    cmp     r1,#0x0
    beq     @@subr_end
    mov     r1,#0x0
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