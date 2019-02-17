    .gba
    .include "cfg/z4-stageselectcfg.asm"
    
    ; Stage select menu x position offsets
    MENU_OFFSET equ 8
    CURSOR_OFFSET equ 7
    GAMESTATE_MENU equ 0x28
    GAMESTATE_MENU_2 equ (GAMESTATE_MENU+1)
    GAMESTATE_MENU_3 equ (GAMESTATE_MENU_2+1)
    
    WEATHER_GENBLEM_HARD equ 0x10
    WEATHER_GENBLEM_EASY equ 0x3
    WEATHER_KRAKEN_HARD equ 0x12
    WEATHER_KRAKEN_EASY equ 0x0
    WEATHER_PEGASOLTA_HARD equ 0x13
    WEATHER_PEGASOLTA_EASY equ 0x0
    WEATHER_MANDRAGO_HARD equ 0x10
    WEATHER_MANDRAGO_EASY equ 0x3
    WEATHER_TITANION_HARD equ 0x10
    WEATHER_TITANION_EASY equ 0x3
    WEATHER_FENRI_HARD equ 0x12
    WEATHER_FENRI_EASY equ 0x3
    WEATHER_MINO_HARD equ 0x11
    WEATHER_MINO_EASY equ 0x3
    WEATHER_POPLA_HARD equ 0x10
    WEATHER_POPLA_EASY equ 0x2
    
    ; Change to existing code.
    ; Manually changes the pool for loading the base address
    ; for game state subroutines. (See below.)
    .org 0x08112A20
    .dw REG_GAME_STATE_ROUTINES
    
    ; New code.
    ; All previous game state subroutines have been moved over here to 
    ; make place for potential new subroutines. 0-27 are the old subroutines.
    .org REG_GAME_STATE_ROUTINES
    .area REG_GAME_STATE_ROUTINES_AREA
    .dw 0x08112B75 ; 00
    .dw 0x08112C6D ; 01
    .dw 0x08112D61 ; 02
    .dw 0x08112D65 ; 03
    .dw 0x08112F6D ; 04
    .dw 0x081133B1 ; 05
    .dw 0x081134F5 ; 06
    .dw 0x081136A9 ; 07
    .dw 0x08113AC1 ; 08
    .dw 0x08113C21 ; 09
    .dw 0x08113FA1 ; 0A
    .dw 0x08113FA5 ; 0B
    .dw 0x08114319 ; 0C
    .dw 0x081148ED ; 0D
    .dw 0x08114939 ; 0E
    .dw 0x08114AAD ; 0F
    .dw 0x08112D19 ; 10 (out of order)
    .dw 0x08114C8D ; 11
    .dw 0x08114CE5 ; 12
    .dw 0x08115239 ; 13
    .dw 0x081157A9 ; 14
    .dw 0x08115BA9 ; 15
    .dw 0x08115DD9 ; 16
    .dw 0x08116061 ; 17
    .dw 0x081162DD ; 18
    .dw 0x081167F1 ; 19
    .dw 0x08116B3D ; 1A
    .dw 0x081171B1 ; 1B
    .dw 0x081173FD ; 1C
    .dw 0x08117661 ; 1D
    .dw 0x081178C5 ; 1E
    .dw 0x08118415 ; 1F
    .dw 0x08119BA5 ; 20
    .dw 0x0811B239 ; 21
    .dw 0x0811BDE5 ; 22
    .dw 0x08117C0D ; 23 (out of order)
    .dw 0x08117D2D ; 24 (out of order?)
    .dw 0x08117DA1 ; 25
    .dw 0x08117DF5 ; 26
    .dw 0x08117E61 ; 27
    .dw REG_STAGE_SELECT_MENU+1 ; 28
    .dw REG_STAGE_SELECT_MENU+1 ; 29
    ; Stage select subroutine here
    .endarea
    
    ; New code. Stage names for the stage select menu in stage index order.
    .org REG_STAGE_SELECT_ENTRIES
    .area REG_STAGE_SELECT_ENTRIES_AREA
    .align 4
    .asciiz "INTRO 1"
    .org REG_STAGE_SELECT_ENTRIES+0x16*1
    .asciiz "INTRO 2"
    .org REG_STAGE_SELECT_ENTRIES+0x16*2
    .asciiz "HEAT GENBLEM"
    .org REG_STAGE_SELECT_ENTRIES+0x16*3
    .asciiz "TECH KRAKEN"
    .org REG_STAGE_SELECT_ENTRIES+0x16*4
    .asciiz "PEGASOLTA ECLAIR"
    .org REG_STAGE_SELECT_ENTRIES+0x16*5
    .asciiz "NOBLE MANDRAGO"
    .org REG_STAGE_SELECT_ENTRIES+0x16*6
    .asciiz "SOL TITANION"
    .org REG_STAGE_SELECT_ENTRIES+0x16*7
    .asciiz "FENRI LUNAEDGE"
    .org REG_STAGE_SELECT_ENTRIES+0x16*8
    .asciiz "MINO MAGNUS"
    .org REG_STAGE_SELECT_ENTRIES+0x16*9
    .asciiz "POPLA COCAPETRI"
    .org REG_STAGE_SELECT_ENTRIES+0x16*10
    .asciiz "CRAFT 1"
    .org REG_STAGE_SELECT_ENTRIES+0x16*11
    .asciiz "HELL THE GIANT"
    .org REG_STAGE_SELECT_ENTRIES+0x16*12
    .asciiz "CRAFT 2"
    .org REG_STAGE_SELECT_ENTRIES+0x16*13
    .asciiz "RANDAM BANDAM"
    .org REG_STAGE_SELECT_ENTRIES+0x16*14
    .asciiz "CYBALL"
    .org REG_STAGE_SELECT_ENTRIES+0x16*15
    .asciiz "FINAL"
    .org REG_STAGE_SELECT_ENTRIES+0x16*16
    .asciiz "COMMANDER ROOM"
    .org REG_STAGE_SELECT_ENTRIES+0x16*17
    .asciiz ">"
    .endarea
    
    .org REG_STAGE_SELECT_MENU
    .area REG_STAGE_SELECT_MENU_AREA
    push    {r4-r7,r14}
    sub     sp,#0x14
    mov     r6,r0
    ldr     r5,=#ADDR_CURSOR_POSITION
    ldrb    r4,[r5]
    ldr     r0,=#ADDR_GAMESTATE
    ldrb    r0,[r0]
    ; cmp     r0,#0x20
    ; bne     @@continue_normal
    ; ldr     r1,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    ; b       @@continue_custom
@@continue_normal:
    mov     r1,#GAMESTATE_MENU
    sub     r0,r0,r1
    mov     r1,#0x14
    mul     r0,r1
    ldr     r1,=#REG_STAGE_SELECT_ROUTES ; Fixed (stage indexes)
    add     r1,r1,r0
@@continue_custom:
    mov     r0,r13
    mov     r2,#0x11
    bl      @indexes_on_stack
    ldr     r7,=#ADDR_KEY
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
    ldr     r3,=#ADDR_GAMESTATE
    ldrb    r3,[r3]
    mov     r6,#GAMESTATE_MENU
    sub     r3,r3,r6
    mov     r5,r3
    mov     r6,#0x20
    mul     r5,r6
    ldr     r0,=#REG_STAGE_SELECT_ROUTE_NAMES
    add     r0,r0,r5
    mov     r1,#0x0
    mov     r2,#0x13
    bl      @draw_textline  ; Draw route name
    ldr     r1,=#ADDR_GAMESTATE
    ldrb    r1,[r1]
    ; cmp     r1,#0x20
    ; bne     @@continue_normal
    ; ldr     r5,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    ; b       @@continue_custom
@@continue_normal:
    mov     r6,#0x14
    mul     r3,r6
    ldr     r5,=#REG_STAGE_SELECT_ROUTES
    add     r5,r5,r3
@@continue_custom:
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
    sub     r3,r3,#0x1
    mul     r6,r3
    add     r0,r4,r6        ; ">" address
    mov     r1,CURSOR_OFFSET
    pop     {r3-r7}
    add     r2,r4,#0x1
    bl      @draw_textline
    str     r4,[r5]
    ldrh    r1,[r7,#0x4]    ; Check for A input
    mov     r0,#VAL_KEY_A
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
    mov     r1,r13
    add     r0,r1,r4
    ldrb    r0,[r0]
    str     r0,[r5]
    ldr     r2,=#REG_STAGE_SETTING_POINTERS ; Fixed, base address for stage settings
    ldr     r1,=#ADDR_GAMESTATE
    ldrb    r1,[r1]
    ldr     r3,=#ADDR_STORED_GAMESTATE      ; Address for storing stage select menu game state
    strb    r1,[r3]
    ; cmp     r1,#0x20
    ; bne     @@continue_normal
    ; ldr     r3,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    ; b       @@continue_custom
@@continue_normal:
    mov     r3,#GAMESTATE_MENU
    sub     r1,r3
    mov     r3,#0x14
    mul     r1,r3
    ldr     r3,=#REG_STAGE_SELECT_ROUTES
    add     r3,r1
@@continue_custom:
    ldrb    r1,[r3,r4]
    sub     r1,#0x1
    bl      @stage_settings
    ; bl      reset_progress
    ldr     r1,=#0x0801F125 ; magical subroutine
    bl      @@bx_to_r1
    mov     r1,#0xC0
    lsl     r1,r1,#0x2
    str     r1,[r6]
    mov     r1,#0x0
    str     r1,[r6,#0x4]
    str     r1,[r6,#0x8]
    ; bl      reset_disks
    ; bl      reset_volteel_rng
@@subr_end:
    add     sp,#0x14
    pop     {r4-r7}
    pop     {r0}
    bx      r0
@@check_for_b:
    mov     r0,#0x2
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_l
    ldr     r0,=#ADDR_GAMESTATE
    mov     r1,#0x4
    strb    r1,[r0]
    ldr     r0,=#ADDR_CURSOR_POSITION
    ldr     r4,=#ADDR_STAGEINDEX
    ldrb    r4,[r4]
    strb    r4,[r0]
    b       @@subr_end
@@check_for_l:
    mov     r0,#0x1
    lsl     r0,r0,#OFFSET_KEY_L
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_r
    ldr     r0,=#ADDR_GAMESTATE
    ldrb    r1,[r0]
    cmp     r1,#GAMESTATE_MENU_2
    bne     @@gamestate_nowrap
    mov     r1,#GAMESTATE_MENU
    b       @@store_changed_gamestate
@@gamestate_nowrap:
    add     r1,r1,#0x1
@@store_changed_gamestate:
    strb    r1,[r0]
    b       @@subr_end
@@check_for_r:
    mov     r0,#0x1
    lsl     r0,r0,#OFFSET_KEY_R
    and     r0,r1
    cmp     r0,#0x0
    beq     @@subr_end
    ; ldr     r0,=#ADDR_GAMESTATE
    ; ldr     r2,=#ADDR_STORED_GAMESTATE
    ; ldrb    r3,[r0]
    ; strb    r3,[r2]
    ; mov     r1,#0x21
    ; strb    r1,[r0]
    b       @@subr_end
@@bx_to_r1:
    bx      r1
    nop
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
    ldr     r1,=#ADDR_BG0_TILES ; Fixed (BG0 tiles)
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
    ldr     r3,=#ADDR_RANK     ; Rank address
    mov     r6,r0
    cmp     r6,#0x11            ; If the chosen stage is commander room,
    beq     @@subr_end          ; don't load any settings
    cmp     r6,#0x1             ; If the chosen stage is intro
    beq     @@in_intro
    cmp     r6,#0xB
    beq     @@craft_1
    mov     r7,#0x4             ; B rank
    b       @@store_rank
@@in_intro:
    mov     r7,#0x0             ; F rank
    b       @@store_rank
@@craft_1:
    mov     r7,#0x5
@@store_rank:
    strb    r7,[r3]
    ; bl      set_game_progress
    ;sub     r0,1                ; Subtract stage index by 1
    cmp     r6,#0x3
    blt     @@no_weather
    cmp     r6,#0xA
    bgt     @@no_weather
    sub     r6,3
    ldr     r5,=#REG_STAGE_SETTING_WEATHER
    add     r4,r5,r6
    ldrb    r4,[r4]
    add     r5,#0x8
    mov     r3,#0x2
    mul     r3,r6
    add     r5,r5,r3
    add     r5,r5,r4
    ldrb    r5,[r5]
    ldr     r3,=#ADDR_WEATHER
    strb    r5,[r3]
@@no_weather:
    mov     r3,0x4
    mul     r1,r3               ; Multiply by 0x1C
    add     r2,r2,r1            ; Add as offset to base address
    ldr     r1,=#ADDR_GAMESTATE
    ldrb    r1,[r1]
    mov     r3,#GAMESTATE_MENU
    sub     r1,r3
    mov     r3,#0x40
    mul     r1,r3
    add     r0,r2,r1
    ldr     r0,[r0]
    ldr     r1,=#0x020358CB     ; Gangagun address
    ldrb    r2,[r0]
    lsl     r2,r2,#0x4
    strb    r2,[r1]
    add     r0,1
    add     r1,1                ; C-hopper address
    ldrb    r2,[r0]
    strb    r2,[r1]
    add     r0,1
    add     r1,5                ; Gyro Cannon H address
    ldrb    r2,[r0]
    strb    r2,[r1]
    add     r0,1
    add     r1,6
    ldrb    r2,[r0]
    lsl     r2,r2,#0x4
    strb    r2,[r1]
    add     r0,1
    ldr     r1,=#ADDR_CHIPS
    ldrh    r2,[r0]
    strh    r2,[r1]
    ldrh    r2,[r0,#0x2]
    strh    r2,[r1,#0x2]
    ldrh    r2,[r0,#0x4]
    strh    r2,[r1,#0x4]
    ldrh    r2,[r0,#0x6]
    strh    r2,[r1,#0x6]
    add     r0,8
    ldr     r1,=#ADDR_SETTINGS_SAVED     ; "Saved gameplay settings" section to write to
    ldrh    r2,[r0]
    strh    r2,[r1]
    add     r0,2
    add     r1,2
    ldmia   r0!,{r2-r5}
    stmia   r1!,{r2-r5}
    add     r1,8
    ldr     r3,=#ADDR_CONTROL_SETTINGS     ; Read from control settings
    ldmia   r3!,{r4-r6}         ; Load 8 bytes
    stmia   r1!,{r4-r6}         ; Store 8 bytes
    ldrh    r4,[r3]             ; Load another 2 bytes
    strh    r4,[r1]             ; Store another 2 bytes
    add     r1,#0x10
    ldr     r2,[r0]
    str     r2,[r1]
    ldrh    r2,[r0,#0x4]
    strh    r2,[r1,#0x4]
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
    
    ; New code.
    ; Cursor positions for the stages, in stage index order.
    .org REG_STAGE_SELECT_DISPLAY
    .area REG_STAGE_SELECT_DISPLAY_AREA
    
    ; Route 1
    
    .db 0x0         ; Intro
    .db 0x1         ; Intro 2
    .db 0x4         ; Genblem
    .db 0x9         ; Kraken
    .db 0xA         ; Pegasolta
    .db 0x3         ; Mandrago
    .db 0x8         ; Titanion
    .db 0x5         ; Fenri
    .db 0xB         ; Mino
    .db 0x2         ; Popla
    .db 0x6         ; Craft 1
    .db 0x7         ; HELL THE GIANT
    .db 0xC         ; Craft 2
    .db 0xD         ; Randam
    .db 0xE         ; Cyball
    .db 0xF         ; Final
    .db 0x10        ; Commander room
    
    .align 4
    
    ; Route 2
    
    .db 0x0         ; Intro
    .db 0x1         ; Intro 2
    .db 0x3         ; Genblem
    .db 0x9         ; Kraken
    .db 0xA         ; Pegasolta
    .db 0x8         ; Mandrago
    .db 0x5         ; Titanion
    .db 0x4         ; Fenri
    .db 0xB         ; Mino
    .db 0x2         ; Popla
    .db 0x6         ; Craft 1
    .db 0x7         ; HELL THE GIANT
    .db 0xC         ; Craft 2
    .db 0xD         ; Randam
    .db 0xE         ; Cyball
    .db 0xF         ; Final
    .db 0x10        ; Commander room
    .align 2
    
show_menu:
    push    r14
    ldr     r4,=#0x02000A01 ; DISPCNT register
    ldrb    r5,[r4]
    mov     r6,#0x1
    orr     r5,r6
    strb    r5,[r4]
    ; ldr     r4,=#0x02000FEE   ; WINOUT register. Probably unnecessary, so I commented it out
    ; ldrb    r5,[r4]
    ; orr     r5,r6
    ; strb    r5,[r4]
    ; ldr     r3,=#ADDR_CUSTOM_ROUTE_STATUS
    ; ldrb    r5,[r3]
    ; cmp     r5,#0x0
    ; bne     @@no_init
    ; bl      @init_custom_route
    ; mov     r5,#0x1
    ; strb    r5,[r3]
@@no_init:
    ldr     r3,=#ADDR_GAMESTATE
    ldr     r5,=#ADDR_STORED_GAMESTATE
    ldrb    r5,[r5]
    cmp     r5,#0x0
    bne     @@store_gamestate
    mov     r5,#GAMESTATE_MENU
@@store_gamestate:
    strb    r5,[r3]
    ; cmp     r5,#0x20
    ; bne     @@continue_normal
    ; ldr     r4,=#ADDR_STAGE_SELECT_DISPLAY_CUSTOM
    ; b       @@continue_custom
@@continue_normal:
    mov     r6,#GAMESTATE_MENU
    sub     r5,r5,r6
    mov     r6,#0x14
    mul     r5,r6
    ldr     r4,=#REG_STAGE_SELECT_DISPLAY
    add     r4,r5
@@continue_custom:
    ldr     r5,=#ADDR_CURSOR_POSITION
    ldrb    r6,[r5]
    sub     r6,r6,#0x1
    add     r4,r4,r6
    ldrb    r4,[r4]
    strb    r4,[r5]
    pop     r0
    bx      r0
    .pool
    
; @init_custom_route:
    ; push    {r0-r7,r14}
    ; ldr     r0,=#ADDR_SRAM_ROUTE_AREA
    ; ldrb    r2,[r0]
    ; ldrb    r1,[r0,#0x1]
    ; lsl     r1,r1,#0x8
    ; orr     r2,r1
    ; ldrb    r1,[r0,#0x2]
    ; lsl     r1,r1,#0x10
    ; orr     r2,r1
    ; ldrb    r1,[r0,#0x3]
    ; lsl     r1,r1,#0x18
    ; orr     r2,r1
    ; ldr     r1,=#0x43415250
    ; cmp     r2,r1
    ; bne     @@load_from_rom
    ; bl      @load_from_sram
    ; b       @@subr_end
; @@load_from_rom:
    ; ldr     r0,=#REG_STAGE_SELECT_DISPLAY
    ; ldr     r1,=#ADDR_STAGE_SELECT_DISPLAY_CUSTOM
    ; ldmia   r0!,{r3-r6}
    ; stmia   r1!,{r3-r6}
    ; ldrb    r2,[r0]
    ; strb    r2,[r1]
    ; ldr     r0,=#REG_STAGE_SELECT_ROUTES
    ; ldr     r1,=#ADDR_STAGE_SELECT_ROUTES_CUSTOM
    ; ldmia   r0!,{r3-r6}
    ; stmia   r1!,{r3-r6}
    ; ldrb    r2,[r0]
    ; strb    r2,[r1]
    ; ldr     r0,=#REG_STAGE_SELECT_CFG
    ; ldr     r1,=#ADDR_STORED_CUSTOM_ROUTE_CFG
    ; ldrh    r2,[r0]
    ; strh    r2,[r1]
    ; add     r0,#0x2
    ; add     r1,#0x2
    ; mov     r2,#0x0
; @@load_store_loop:
    ; ldmia   r0!,{r3-r7}
    ; stmia   r1!,{r3-r7}
    ; add     r2,#0x1
    ; cmp     r2,#0x16
    ; blt     @@load_store_loop
    ; ldr     r2,[r0]
    ; str     r2,[r1]
    ; add     r0,#0x4
    ; add     r1,#0x4
    ; ldrh    r2,[r0]
    ; strh    r2,[r1]
; @@subr_end:
    ; pop     {r0-r7}
    ; pop     r15
    ; .pool

; @load_from_sram:
    ; push    r14
    ; add     r0,#0x10
    ; ldr     r1,=#ADDR_STAGE_SELECT_DISPLAY_CUSTOM
    ; mov     r5,#0x0
    ; ldr     r6,=#498
; @@loop:
    ; ldrb    r3,[r0]
    ; strb    r3,[r1]
    ; add     r0,#0x1
    ; add     r1,#0x1
    ; add     r5,#0x1
    ; cmp     r5,r6
    ; blt     @@loop
; @@subr_end:
    ; pop     r15
    ; .pool
    .endarea
    
    .org REG_STAGE_SELECT_ROUTES
    .area REG_STAGE_SELECT_ROUTES_AREA
    
    .db 0x1         ; Intro
    .db 0x2         ; Intro 2
    .db 0xA         ; Popla
    .db 0x6         ; Mandrago
    .db 0x3         ; Genblem
    .db 0x8         ; Fenri
    .db 0xB         ; Craft 1
    .db 0xC         ; HELL THE GIANT
    .db 0x7         ; Titanion
    .db 0x4         ; Kraken
    .db 0x5         ; Pegasolta
    .db 0x9         ; Mino
    .db 0xD         ; Craft 2
    .db 0xE         ; Randam
    .db 0xF         ; Cyball
    .db 0x10        ; Final
    .db 0x11        ; Commander room
    .align 4
    
    .db 0x1         ; Intro
    .db 0x2         ; Intro 2
    .db 0xA         ; Popla
    .db 0x3         ; Genblem
    .db 0x8         ; Fenri
    .db 0x7         ; Titanion
    .db 0xB         ; Craft 1
    .db 0xC         ; HELL THE GIANT
    .db 0x6         ; Mandrago
    .db 0x4         ; Kraken
    .db 0x5         ; Pegasolta
    .db 0x9         ; Mino
    .db 0xD         ; Craft 2
    .db 0xE         ; Randam
    .db 0xF         ; Cyball
    .db 0x10        ; Final
    .db 0x11        ; Commander room
    
    .endarea
    
    .org REG_STAGE_SELECT_ROUTE_NAMES
    .area REG_STAGE_SELECT_ROUTE_NAMES_AREA
    
    .asciiz "NO JUNK"
    .org REG_STAGE_SELECT_ROUTE_NAMES+0x20*1
    .asciiz "JUNK"
    .org REG_STAGE_SELECT_ROUTE_NAMES+0x20*2
    .asciiz "CUSTOM"
    
    .endarea
    
    .org REG_STAGE_SETTING_WEATHER
    .area REG_STAGE_SETTING_WEATHER_AREA
    
    .db 0,0,1,0,1,0,0,0
    
    .db WEATHER_GENBLEM_HARD
    .db WEATHER_GENBLEM_EASY
    .db WEATHER_KRAKEN_HARD
    .db WEATHER_KRAKEN_EASY
    .db WEATHER_PEGASOLTA_HARD
    .db WEATHER_PEGASOLTA_EASY
    .db WEATHER_MANDRAGO_HARD
    .db WEATHER_MANDRAGO_EASY
    .db WEATHER_TITANION_HARD
    .db WEATHER_TITANION_EASY
    .db WEATHER_FENRI_HARD
    .db WEATHER_FENRI_EASY
    .db WEATHER_MINO_HARD
    .db WEATHER_MINO_EASY
    .db WEATHER_POPLA_HARD
    .db WEATHER_POPLA_EASY
    
    .endarea