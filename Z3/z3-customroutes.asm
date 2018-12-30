    .gba
    
    ; Stage select menu x position offsets
    
    ; New code. Stage names for the stage select menu in stage index order.
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES
    .area REG_CUSTOM_ROUTE_MENU_ENTRIES_AREA
    .asciiz "EDITING CUSTOM ROUTE"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*1
    .asciiz ">"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*2
    .asciiz ">>"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*3
    .asciiz "HELLBAT SCHILT"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*4
    .asciiz "DEATHTANZ MANTISK"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*5
    .asciiz "BABY ELVES 1"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*6
    .asciiz "ANUBIS NECROMANCESS V"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*7
    .asciiz "HANUMACHINE"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*8
    .asciiz "BLIZZACK STAGGROFF"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*9
    .asciiz "COPY X MK 2"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*10
    .asciiz "CUBIT FOXTAR"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*11
    .asciiz "GLACIER LE CACTANK"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*12
    .asciiz "VOLTEEL BIBLIO"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*13
    .asciiz "TRETISTA KELVERIAN"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*14
    .asciiz "BABY ELVES 2"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*15
    .asciiz "FINAL"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*16
    .asciiz "COMMANDER ROOM"
    .org REG_CUSTOM_ROUTE_MENU_ENTRIES+0x16*17
    .asciiz ">"
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
    .org REG_CUSTOM_ROUTE_MENU
    .area REG_CUSTOM_ROUTE_MENU_AREA
    push    {r4-r7,r14}
    ldr     r4,=#ADDR_CUSTOM_ROUTE_MENU_STATE
    ldr     r4,[r4]
    cmp     r4,#0x1
    ble     @level_not_chosen
    ldr     r4,=#REG_CUSTOM_ROUTE_MENU_LV2+1
    bx      r4
@level_not_chosen:
    sub     sp,#0x14
    mov     r6,r0
    ldr     r0,=#0x6260
    add     r5,r6,r0        ; Fixed (r5 is stage index address)
    ldrb    r4,[r5]
    ldr     r1,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM ; Fixed (stage indexes)
    mov     r0,r13
    mov     r2,#0x11
    bl      @indexes_on_stack
    ldr     r7,=#0x02001EB0 ; Fixed (input checking)
    ldrh    r1,[r7,#0x6]
@check_for_down:
    mov     r0,#0x80
    and     r0,r1
    cmp     r0,#0x0
    beq     @check_for_up
    add     r0,r4,#0x1
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
@check_for_up:
    mov     r0,#0x40
    and     r0,r1
    cmp     r0,#0x0
    beq     @no_up
    mov     r0,r4
    sub     r0,#0x1
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
@no_up:
    mov     r0,r4
    cmp     r0,#0xFF
    bne     @no_upwrap
    mov     r0,#0x10
@no_upwrap:
    cmp     r0,#0x11
    bne     @no_downwrap
    mov     r0,#0x0
@no_downwrap:
    lsl     r0,r0,#0x18
    lsr     r4,r0,#0x18
    push    {r3-r7}
    ldr     r4,=#REG_STAGE_SELECT_ENTRIES
    ldr     r0,=#REG_CUSTOM_ROUTE_MENU_ENTRIES
    mov     r1,#0x0
    mov     r2,#0x0
    bl      @draw_textline  ; Draw route name
    ldr     r5,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    mov     r6,#0x16        ; Size of a stage select entry "cell"
    mov     r3,#0x1         ; y offset
@print_menu_loop:
    mov     r1,MENU_OFFSET  ; x offset
    mov     r2,r3
    sub     r7,r2,#0x1      ; 0-indexed stage number
    ldrb    r7,[r5,r7]      ; 1-indexed stage index
    sub     r7,#0x1         ; 0-indexed stage index
    mul     r7,r6           ; Stage select entry offset
    add     r0,r4,r7        ; Stage select entry address
    bl      @draw_textline
    add     r3,#0x1
    cmp     r3,#0x11
    ble     @print_menu_loop
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
    bl      @draw_textline
    str     r4,[r5]
    ldrh    r1,[r7,#0x4]    ; Check for A input
    mov     r0,#0x1
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
    b       @@subr_end
    ;; A press handling should be here!!
    mov     r1,r13
    add     r0,r1,r4
    ldrb    r0,[r0]
    str     r0,[r5]
    ldr     r2,=#REG_STAGE_SETTING_POINTERS ; Fixed, base address for stage settings
    ldr     r1,=#ADDR_GAMESTATE
    ldrb    r1,[r1]
    ldr     r3,=#0x02030B5C             ; Address for storing stage select menu game state
    strb    r1,[r3]
    mov     r3,#0x1E
    sub     r1,r3
    mov     r3,#0x11
    mul     r1,r3
    ldr     r3,=#REG_STAGE_SELECT_ROUTES
    add     r3,r1
    ldrb    r1,[r3,r4]
    sub     r1,#0x1
    bl      @stage_settings
    bl      reset_progress
    bl      0x08019E94      
    mov     r1,#0xC0
    lsl     r1,r1,#0x2
    str     r1,[r6]
    mov     r1,#0x0
    str     r1,[r6,#0x4]
    str     r1,[r6,#0x8]
    bl      reset_disks
    bl      reset_volteel_rng
    ;; A press handling should end here!!
@@subr_end:
    add     sp,#0x14
    pop     {r4-r7}
    pop     {r0}
    bx      r0
@@check_for_b:
    mov     r0,#0x2
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_select
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
    mov     r2,#0x1
    strb    r2,[r0]
    ldr     r0,=#ADDR_CHANGING_ORDER
    ldr     r1,=#ADDR_CURSOR_POSITION
    ldrb    r1,[r1]
    strb    r1,[r0]
    b       @@subr_end
@@confirm_change:
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
    ldr     r0,=#ADDR_STAGE_SELECT_DISPLAY_CUSTOM
    sub     r3,r3,#0x1
    sub     r4,r4,#0x1
    ldrb    r1,[r0,r3]
    ldrb    r2,[r0,r4]
    strb    r2,[r0,r3]
    strb    r1,[r0,r4]
    b       @@subr_end
    .pool
    
@indexes_on_stack: ; r0 = sp, r1 = stage index list, r2 = 0x11
    push    {r4-r7,r14}
    mov     r5,r0
    mov     r4,r5
    mov     r3,r1
    cmp     r2,#0xF          ; Probably unnecessary
    bls     @@hmm
    mov     r0,r3
    orr     r0,r5
    mov     r1,#0x3
    and     r0,r1
    cmp     r0,#0x0
    bne     @@hmm
    mov     r1,r5
@@move_stuff:
    ldmia   r3!,{r0,r6,r7}
    stmia   r1!,{r0,r6,r7}
    ldmia   r3!,{r0}
    stmia   r1!,{r0}
    sub     r2,#0x10
    cmp     r2,#0xF         ; Probably unnecessary
    bhi     @@move_stuff
    cmp     r2,#0x3
    bls     @@something
@@move_a_word:
    ldmia   r3!,{r0}
    stmia   r1!,{r0}
    sub     r2,#0x4
    cmp     r2,#0x3
    bhi     @@move_a_word
@@something:
    mov     r4,r1
@@hmm:
    sub     r2,#0x1
    mov     r0,#0x1
    neg     r0,r0
    cmp     r2,r0
    beq     @@subr_end
    mov     r1,r0
@@move_a_byte:
    ldrb    r0,[r3]
    strb    r0,[r4]
    add     r3,#0x1
    add     r4,#0x1
    sub     r2,#0x1
    cmp     r2,r1
    bne     @@move_a_byte
@@subr_end:
    mov     r0,r5
    pop     {r4-r7,r15}
    
@draw_textline: ; r0 = string to be drawn, r1 = x offset, r2 = y offset
    push    {r3-r6,r14}
    mov     r3,r0
    mov     r4,r1
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
    ldrb    r0,[r3]
    cmp     r0,#0x0         ; Check for terminating null byte
    bne     @@write_loop
@@subr_end:
    pop     {r3-r6}
    pop     {r0}
    bx      r0
    .pool
    
@stage_settings:
    push    {r0,r4-r7,r14}
    ldr     r3,=#0x02036F71     ; Rank address
    mov     r6,r0
    cmp     r6,#0x11            ; If the chosen stage is commander room,
    beq     @@subr_end          ; don't load any settings
    cmp     r6,#0x1             ; If the chosen stage is intro
    beq     @@in_intro
    mov     r7,#0x5             ; A rank
    b       @@store_rank
@@in_intro:
    mov     r7,#0x0             ; F rank
@@store_rank:
    strb    r7,[r3]
    ; bl      set_game_progress
    ;sub     r0,1                ; Subtract stage index by 1
    mov     r3,0x4
    mul     r1,r3               ; Multiply by 0x1C
    add     r2,r2,r1            ; Add as offset to base address
    ldr     r1,=#ADDR_GAMESTATE
    ldrb    r1,[r1]
    mov     r3,#0x1E
    sub     r1,r3
    mov     r3,#0x40
    mul     r1,r3
    add     r0,r2,r1
    ldr     r0,[r0]
    ldr     r1,=#0x02036EF8     ; Biraid address
    ldrb    r2,[r0]
    strb    r2,[r1]
    add     r0,1
    add     r1,0x14             ; Clokkle address
    ldrb    r2,[r0]
    strb    r2,[r1]
    add     r0,1
    ldr     r1,=#0x02036FC0     ; "Saved gameplay settings" section to write to
    ldmia   r0!,{r2-r7}
    stmia   r1!,{r2-r7}
    ldrh    r2,[r0]
    strh    r2,[r1]
    add     r1,4
    ldr     r3,=#0x02037D30     ; Read from control settings
    ldmia   r3!,{r4-r5}         ; Load 8 bytes
    stmia   r1!,{r4-r5}         ; Store 8 bytes
    ldrh    r2,[r3]             ; Load another 2 bytes
    strh    r2,[r1]             ; Store another 2 bytes
    ; ldr     r1,=#0x02036BBE     ; Game progress values here
    ; ldrh    r2,[r0]             ; Load total points
    ; strh    r2,[r1]             ; Store total points
    ; ldrb    r2,[r0,#0x2]        ; Load stages beaten
    ; strb    r2,[r1,#0x6]        ; Store
    ; strb    r2,[r1,#0x7]        ; Store, offset by 1
    ; ldrh    r2,[r0,#0x4]        ; Load specific stages beaten
    ; strh    r2,[r1,#0xA]        ; Store
    ; strh    r2,[r1,#0xE]        ; Store, offset by 4
@@subr_end:
    pop     {r0,r4-r7}
    pop     r3
    bx      r3
    .pool
    .endarea
    
    .org REG_CUSTOM_ROUTE_MENU_LV2
    .area REG_CUSTOM_ROUTE_MENU_LV2_AREA
    bx      r14
    .endarea
    
    ; New code.
    ; Cursor positions for the stages, in stage index order.
    .org REG_STAGE_SELECT_DISPLAY
    .area REG_STAGE_SELECT_DISPLAY_AREA
    
    ; Route 1
    
    .db 0x0         ; Intro
    .db 0x2         ; Flizard
    .db 0x4         ; Childre
    .db 0x1         ; Hellbat
    .db 0x3         ; Mantisk
    .db 0x5         ; Baby Elves 1
    .db 0x8         ; Anubis
    .db 0x7         ; Hanumachine
    .db 0x6         ; Blizzack
    .db 0x9         ; Copy X
    .db 0xB         ; Foxtar
    .db 0xA         ; le Cactank
    .db 0xD         ; Volteel
    .db 0xC         ; Kelverian
    .db 0xE         ; Baby Elves 2
    .db 0xF         ; Final
    .db 0x10        ; Commander room
    
    ; Route 2
    
    .db 0x0         ; Intro
    .db 0x2         ; Flizard
    .db 0x4         ; Childre
    .db 0x1         ; Hellbat
    .db 0x3         ; Mantisk
    .db 0x5         ; Baby Elves 1
    .db 0x8         ; Anubis
    .db 0x6         ; Hanumachine
    .db 0x7         ; Blizzack
    .db 0x9         ; Copy X
    .db 0xB         ; Foxtar
    .db 0xA         ; le Cactank
    .db 0xD         ; Volteel
    .db 0xC         ; Kelverian
    .db 0xE         ; Baby Elves 2
    .db 0xF         ; Final
    .db 0x10        ; Commander room
    .align 2
    
    .endarea
    
    .org REG_STAGE_SELECT_ROUTES
    .area REG_STAGE_SELECT_ROUTES_AREA
    
    .db 0x1         ; Intro
    .db 0x4         ; Hellbat
    .db 0x2         ; Flizard
    .db 0x5         ; Mantisk
    .db 0x3         ; Childre
    .db 0x6         ; Baby Elves 1
    .db 0x9         ; Blizzack
    .db 0x8         ; Hanumachine
    .db 0x7         ; Anubis
    .db 0xA         ; Copy X
    .db 0xC         ; le Cactank
    .db 0xB         ; Foxtar
    .db 0xE         ; Kelverian
    .db 0xD         ; Volteel
    .db 0xF         ; Sub Arcadia
    .db 0x10        ; Final
    .db 0x11        ; Commander room
    
    .db 0x1         ; Intro
    .db 0x4         ; Hellbat
    .db 0x2         ; Flizard
    .db 0x5         ; Mantisk
    .db 0x3         ; Childre
    .db 0x6         ; Baby Elves 1
    .db 0x8         ; Hanumachine
    .db 0x9         ; Blizzack
    .db 0x7         ; Anubis
    .db 0xA         ; Copy X
    .db 0xC         ; le Cactank
    .db 0xB         ; Foxtar
    .db 0xE         ; Kelverian
    .db 0xD         ; Volteel
    .db 0xF         ; Sub Arcadia
    .db 0x10        ; Final
    .db 0x11        ; Commander room
    
    .endarea