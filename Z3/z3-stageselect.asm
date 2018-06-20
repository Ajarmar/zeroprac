    .gba
    
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
    .dw 0x08386C70 ;1E CHANGE TO WHERE STAGE SELECT MENU ROUTINE BEGINS
    .endarea
    
    ; New code. Stage order for the stage select menu.
    .org 0x08386C70
    .db 0x1         ; Intro
    .db 0x4         ; Hellbat
    .db 0x2         ; Flizard
    .db 0x5         ; Mantisk
    .db 0x3         ; Childre
    .db 0x6         ; Baby Elves 1
    .db 0x9         ; Blizzack
    .db 0x8         ; Hanumachine
    .db 0x7         ; Anubis
    .db 0xA         ; Copy X (needs fix to spawn at beginning)
    .db 0xC         ; le Cactank
    .db 0xB         ; Foxtar
    .db 0xE         ; Kelverian
    .db 0xD         ; Volteel
    .db 0xF         ; Sub Arcadia
    .db 0x10        ; Final
    .db 0x11        ; Commander room (buggy as hell)
    
    ; New code. Recreation of stage select menu routine from Z2.
    ; ORDER OF OPERATIONS:
    ; 1. Check a bunch of random shit
    ; 2. Check for up/down input, increment/decrement stage index
    ; 3. Draw stage select menu, including cursor
    ; 4. Check for A input
    ; 5a. A input -> goto 6
    ; 5b. A input -> goto 8
    ; 6. Load stage settings
    ; 7. Set stage index and game state
    ; 8. End
    .org 0x08386C70
    push    {r4-r7,r14}
    add     sp,-#0x14
    mov     r6,r0
    