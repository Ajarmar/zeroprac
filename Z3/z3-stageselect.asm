    .gba
    .include "cfg/z3-stageselectcfg.asm"
    
    ; Stage select menu x position offsets
    MENU_OFFSET equ 5
    CURSOR_OFFSET equ 4
    
    ; Change to existing code.
    ; Manually changes the pool for loading the base address
    ; for game state subroutines. (See below.)
    .org 0x080EE374
    .dw 0x08386BE0
    
    ; New code.
    ; All previous game state subroutines have been moved over here to 
    ; make place for potential new subroutines. 0-1D are the old subroutines.
    .org 0x08386BE0
    .area 0x90
    .dw 0x080EE4C9 ;0
    .dw 0x080EE615 ;1
    .dw 0x080EE699 ;2
    .dw 0x080EE69D ;3
    .dw 0x080EE869 ;4
    .dw 0x080EECAD ;5
    .dw 0x080EEDF1 ;6
    .dw 0x080EEFE1 ;7
    .dw 0x080EF401 ;8
    .dw 0x080EF581 ;9
    .dw 0x080EF921 ;A
    .dw 0x080EF925 ;B
    .dw 0x080EFD09 ;C
    .dw 0x080F02F1 ;D
    .dw 0x080F033D ;E
    .dw 0x080F0465 ;F
    .dw 0x080F0655 ;10
    .dw 0x080F0659 ;11
    .dw 0x080F10B9 ;12
    .dw 0x080F1DAD ;13
    .dw 0x080F1FE5 ;14
    .dw 0x080F20F5 ;15
    .dw 0x080F21F5 ;16
    .dw 0x080F2621 ;17
    .dw 0x080F2C25 ;18
    .dw 0x080F2D35 ;19
    .dw 0x080F2E45 ;1A
    .dw 0x080F2F45 ;1B
    .dw 0x080F3045 ;1C
    .dw 0x080F3129 ;1D
    .dw 0x08386E01 ;1E
    .endarea
    
    ; New code. Stage order for the stage select menu.
    .org 0x08386C70
    .area 0x190
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
    .align 4
    .asciiz "INTRO"
    .asciiz "HELLBAT SCHILT"
    .asciiz "BLAZIN' FLIZARD"
    .asciiz "DEATHTANZ MANTISK"
    .asciiz "CHILDRE INARABITTA"
    .asciiz "BABY ELVES 1"
    .asciiz "BLIZZACK STAGGROFF"
    .asciiz "HANUMACHINE"
    .asciiz "ANUBIS NECROMANCESS V"
    .asciiz "COPY X MK 2"
    .asciiz "GLACIER LE CACTANK"
    .asciiz "CUBIT FOXTAR"
    .asciiz "TRETISTA KELVERIAN"
    .asciiz "VOLTEEL BIBLIO"
    .asciiz "BABY ELVES 2"
    .asciiz "FINAL"
    .asciiz "COMMANDER ROOM"
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
    .org 0x08386E00
    .area 0x300
    push    {r4-r7,r14}
    sub     sp,#0x14
    mov     r6,r0
    ldr     r0,=#0x6260
    add     r5,r6,r0        ; Fixed (r5 is stage index address)
    ldrb    r4,[r5]
    ldr     r1,=#0x08386C70 ; Fixed (stage indexes)
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
    ldr     r0,=#0x08386C84 ; "INTRO"
    mov     r1,MENU_OFFSET  ; x offset
    mov     r2,#0x1         ; y offset
    bl      @draw_textline
    ldr     r0,=#0x08386C8A ; "HELLBAT SCHILT"
    mov     r1,MENU_OFFSET
    mov     r2,#0x2
    bl      @draw_textline
    ldr     r0,=#0x08386C99 ; "BLAZIN' FLIZARD"
    mov     r1,MENU_OFFSET
    mov     r2,#0x3
    bl      @draw_textline
    ldr     r0,=#0x08386CA9 ; "DEATHTANZ MANTISK"
    mov     r1,MENU_OFFSET
    mov     r2,#0x4
    bl      @draw_textline
    ldr     r0,=#0x08386CBB ; "CHILDRE INARABITTA"
    mov     r1,MENU_OFFSET
    mov     r2,#0x5
    bl      @draw_textline
    ldr     r0,=#0x08386CCE ; "BABY ELVES 1"
    mov     r1,MENU_OFFSET
    mov     r2,#0x6
    bl      @draw_textline
    ldr     r0,=#0x08386CDB ; "BLIZZACK STAGGROFF"
    mov     r1,MENU_OFFSET
    mov     r2,#0x7
    bl      @draw_textline
    ldr     r0,=#0x08386CEE ; "HANUMACHINE"
    mov     r1,MENU_OFFSET
    mov     r2,#0x8
    bl      @draw_textline
    ldr     r0,=#0x08386CFA ; "ANUBIS NECROMANCESS V"
    mov     r1,MENU_OFFSET
    mov     r2,#0x9
    bl      @draw_textline
    ldr     r0,=#0x08386D10 ; "COPY X MK 2"
    mov     r1,MENU_OFFSET
    mov     r2,#0xA
    bl      @draw_textline
    ldr     r0,=#0x08386D1C ; "GLACIER LE CACTANK"
    mov     r1,MENU_OFFSET
    mov     r2,#0xB
    bl      @draw_textline
    ldr     r0,=#0x08386D2F ; "CUBIT FOXTAR"
    mov     r1,MENU_OFFSET
    mov     r2,#0xC
    bl      @draw_textline
    ldr     r0,=#0x08386D3C ; "TRETISTA KELVERIAN"
    mov     r1,MENU_OFFSET
    mov     r2,#0xD
    bl      @draw_textline
    ldr     r0,=#0x08386D4F ; "VOLTEEL BIBLIO"
    mov     r1,MENU_OFFSET
    mov     r2,#0xE
    bl      @draw_textline
    ldr     r0,=#0x08386D5E ; "BABY ELVES 2"
    mov     r1,MENU_OFFSET
    mov     r2,#0xF
    bl      @draw_textline
    ldr     r0,=#0x08386D6B ; "FINAL"
    mov     r1,MENU_OFFSET
    mov     r2,#0x10
    bl      @draw_textline
    ldr     r0,=#0x08386D71 ; "COMMANDER ROOM"
    mov     r1,MENU_OFFSET
    mov     r2,#0x11
    bl      @draw_textline
    ldr     r0,=#0x08386D80 ; ">"
    mov     r1,CURSOR_OFFSET
    add     r2,r4,#0x1
    bl      @draw_textline
    str     r4,[r5]
    ldrh    r1,[r7,#0x4]    ; Check for A input
    mov     r0,#0x1
    and     r0,r1
    cmp     r0,#0x0
    beq     @@check_for_b
    mov     r1,r13
    add     r0,r1,r4
    ldrb    r0,[r0]
    str     r0,[r5]
    ldr     r2,=#0x083874FE ; Fixed, base address for stage settings
    mov     r1,r4
    bl      @stage_settings
    bl      0x08019E94      
    mov     r1,#0xC0
    lsl     r1,r1,#0x2
    str     r1,[r6]
    mov     r1,#0x0
    str     r1,[r6,#0x4]
    str     r1,[r6,#0x8]
@@subr_end:
    add     sp,#0x14
    pop     {r4-r7}
    pop     {r0}
    bx      r0
@@check_for_b:
    mov     r0,#0x2
    and     r0,r1
    cmp     r0,#0x0
    beq     @@subr_end
    ldr     r0,=#0x02030B61
    mov     r1,#0x4
    strb    r1,[r0]
    b       @@subr_end
    .pool
    
@indexes_on_stack: ; r0 = sp, r1 = stage index list, r2 = 0x11
    push    {r4-r7,r14}
    mov     r5,r0
    mov     r4,r5
    mov     r3,r1
    cmp     r2,0xF          ; Probably unnecessary
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
    
@draw_textline:
    push    {r4-r6,r14}
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
    pop     {r4-r6}
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
    mov     r3,0x1C
    mul     r1,r3               ; Multiply by 0x1C
    add     r0,r2,r1            ; Add as offset to base address
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
    
    ; New code.
    ; Cursor positions for the stages, in stage index order.
    .org 0x08387100
    .area 0x100
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
    .align 2
    
show_menu:
    ldr     r4,=#0x02002141 ; DISPCNT register
    ldrb    r5,[r4]
    mov     r6,#0x1
    orr     r5,r6
    strb    r5,[r4]
    ; ldr     r4,=#0x02000FEE   ; WINOUT register. Probably unnecessary, so I commented it out
    ; ldrb    r5,[r4]
    ; orr     r5,r6
    ; strb    r5,[r4]
    ldr     r4,=#0x08387100
    ldr     r5,=#0x02036DC0
    ldrb    r6,[r5]
    sub     r6,r6,#0x1
    add     r4,r4,r6
    ldrb    r4,[r4]
    strb    r4,[r5]
    ldr     r4,=#0x02030B61
    mov     r5,#0x1E
    strb    r5,[r4]
    bx      r14
    .pool
    .endarea