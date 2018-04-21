; With "zeroprac" folder in the same folder as ARMIPS:
; compile with "armips z2-stageselect.asm -root zeroprac/Z2"

    .gba
    .include "stageselectcfg.asm"

    ; Change to existing code.
    ; When checking inputs for start presses during gameplay,
    ; checks for start+select instead and branches to a new subroutine
    ; which sets the value for the stage select menu to appear.
    .org 0x080E4862
    mov     r5,#0xC             ; Check for start/select instead of just start
    .skip 8
    ldr     r5,=#0x080F90F5     ; New subroutine
    bx      r5
    .pool
    
    ; Change to existing code.
    ; Loads a base address pointing at data to be loaded for the chosen stage,
    ; and branches to a new subroutine to load said data.
    .org 0x080E543C
    .area 14,0
    .skip 2
    ldr     r2,=#0x0835780E
    mov     r1,r4
    bx      r3
    .pool
    .endarea
    
    ; Change to existing code.
    ; Fixes text alignments in the stage select menu for entries longer than
    ; 16 characters.
    .org 0x080E5470
    .db 0xBB        ; Panter
    .org 0x080E547C
    .db 0xEB        ; Hyleg
    
    ; Change to existing code.
    ; Manually changes a pool for a PC relative load done at 0x080E543C.
    .org 0x080E54B4
    .dw 0x08357BC7

    ; New code. Called if the user presses start or select during gameplay.
    ; Checks if the user pressed select (set 0x0202F8E1 to 9, loading the stage select menu),
    ; or if the user pressed start (execute old code to open pause menu).
    .org 0x080F90F4
start_or_select:                ; New subroutine, replaces the start check with a start+select check
    mov     r5,#0x8
    and     r0,r5
    cmp     r0,#0x8
    beq     only_start
    push    {r6,r7}
    ldr     r7,=#0x0202F8E1
    mov     r6,#0x9
    strb    r6,[r7]
    pop     {r6,r7}
    ldr     r4,=#0x080E4909
    bx      r4
only_start:                     ; Old start check code that had to be moved
    ldr     r3,=#0x75B8
    add     r0,r7,r3
    ldr     r2,[r0]
    mov     r0,r2
    ldr     r1,=#0x080E4875
    bx      r1
    .pool

    ; Change to existing code.
    ; Fixes the stage index order in the menu.
    .org 0x080FEB94
    .skip 1         ; Intro
    .db 0x06        ; Panter
    .db 0x05        ; Phoenix
    .db 0x03        ; Poler
    .db 0x02        ; Hyleg
    .db 0x0C        ; NA1
    .db 0x04        ; Kuwagust
    .db 0x09        ; Harpuia
    .db 0x07        ; Burble
    .db 0x08        ; Leviathan
    .db 0x0A        ; Fefnir
    .db 0x0B        ; NA2

    ; Change to existing code.
    ; Changes the stage select menu entries.
    .org 0x080FEBA8
    .asciiz "INTRO" ; 01
    .fill 0xD
    .asciiz "PANTER FLAUCLAWS" ; 06
    .asciiz "PHOENIX MAGNION" ; 05
    .asciiz "POLER KAMROUS" ; 03
    .fill 0x1
    .asciiz "HYLEG OUROBOCKLE" ; 02
    .asciiz "NEO ARCADIA 1" ; 0C
    .fill 0x2
    .asciiz "KUWAGUST ANCHUS" ; 04
    .fill 0x4
    .asciiz "HARPUIA" ; 09
    .fill 0x8
    .asciiz "BURBLE HEKELOT" ; 07
    .fill 0x5
    .asciiz "LEVIATHAN" ; 08
    .fill 0x6
    .asciiz "FEFNIR" ; 0A
    .fill 0xD
    .asciiz "NEO ARCADIA 2" ; 0B
    .fill 0x6
    .asciiz "FEFNIR AP" ; 0D
    .fill 0x6
    .asciiz "LEVIATHAN AP" ;0E
    .fill 0x3
    .asciiz "HARPUIA AP" ;0F
    .fill 0x5
    .asciiz "FINAL" ;10
    .fill 0x12
    
    ; New code
    ; Sets the appropriate values for a stage when it is loaded,
    ; including rank, game progress, equips, experience, etc.
    ; See stageselectcfg.asm
    .org 0x08357BC6
    push    {r0,r4-r7}
    ldr     r3,=#0x02036BB5     ; Rank address
    mov     r6,r0
    cmp     r6,#0x11            ; If the chosen stage is commander room,
    beq     settings_end        ; don't load any settings
    cmp     r6,#0x1             ; If the chosen stage is intro
    beq     in_intro
    cmp     r6,#0x5             ; If the chosen stage is phoenix
    beq     in_phoenix
    mov     r7,#0x4             ; B rank
    b       store_rank
in_intro:
    mov     r7,#0x0             ; F rank
    b       store_rank
in_phoenix:
    mov     r7,#0x5             ; A rank
store_rank:
    strb    r7,[r3]
    bl      set_game_progress
    sub     r0,1                ; Subtract stage index by 1
    mov     r3,0x38
    mul     r0,r3               ; Multiply by 0x38
    add     r0,r2,r0            ; Add as offset to base address
    ldr     r1,=#0x02036C10     ; "Saved gameplay settings" section to write to
    ldr     r3,=#0x02037EDC     ; Read from control settings
    ldmia   r3!,{r4-r5}         ; Load 8 bytes
    stmia   r1!,{r4-r5}         ; Store 8 bytes
    ldrh    r2,[r3]             ; Load another 2 bytes
    strh    r2,[r1]             ; Store another 2 bytes
    add     r1,2
    ldrh    r2,[r0]             ; Load 2 bytes
    strh    r2,[r1]             ; Store 2 bytes
    add     r0,2
    add     r1,2
    ldmia   r0!,{r4-r7}         ; Load 16 bytes
    stmia   r1!,{r4-r7}         ; Store 16 bytes
    ldmia   r0!,{r4-r7}         ; Load 16 bytes
    stmia   r1!,{r4-r7}         ; Store 16 bytes
    ldmia   r0!,{r4-r6}         ; Load 12 bytes
    stmia   r1!,{r4-r6}         ; Store 12 bytes
    ldrh    r2,[r0]             ; Load 2 bytes
    strh    r2,[r1]             ; Store 2 bytes
    add     r0,2
    ldr     r1,=#0x02036BBE     ; Game progress values here
    ldrh    r2,[r0]             ; Load total points
    strh    r2,[r1]             ; Store total points
    ldrb    r2,[r0,#0x2]        ; Load stages beaten
    strb    r2,[r1,#0x6]        ; Store
    strb    r2,[r1,#0x7]        ; Store, offset by 1
    ldrh    r2,[r0,#0x4]        ; Load specific stages beaten
    strh    r2,[r1,#0xA]        ; Store
    strh    r2,[r1,#0xE]        ; Store, offset by 4
settings_end:
    ldr     r3,=#0x080E544B     ; Address to return to
    pop     {r0,r4-r7}
    bx      r3
    .pool
    
set_game_progress:
    ldr     r7,=#0x02036B44     ; Game progress values here
    mov     r3,r7
    mov     r4,#0x0
    mov     r5,#0x0
    mov     r6,#0x0
    stmia   r3!,{r4-r6}
    stmia   r3!,{r4-r6}
    stmia   r3!,{r4-r6}
    stmia   r3!,{r4-r6}
    stmia   r3!,{r4-r5}
    cmp     r1,#0x0
    beq     @@subr_end
    ; Panter
    mov     r3,r7
    ldr     r4,=#0x0F80
    ldr     r5,=#0x05040400
    str     r4,[r3]
    str     r5,[r3,#0x18]
    sub     r1,1
    cmp     r1,#0x0
    beq     @@subr_end
    ; Phoenix
    mov     r4,#0x11
    add     r3,#0x26
    strb    r4,[r3]
    sub     r1,1
    cmp     r1,#0x0
    beq     @@subr_end
    ; Poler
    mov     r3,r7
    ldr     r4,=#0x1E000F84
    ldr     r5,=#0x3020
    mov     r6,#0xC
    str     r4,[r3]
    str     r5,[r3,#0x8]
    add     r3,#0x23
    strb    r6,[r3]
    sub     r1,1
    cmp     r1,#0x0
    beq     @@subr_end
    ; Hyleg
    mov     r3,r7
    mov     r4,#0x28
    ldr     r5,=#0x0C010603
    strb    r4,[r3,#0x8]
    add     r3,#0x20
    str     r5,[r3]
    sub     r1,1
    cmp     r1,#0x0
    beq     @@subr_end
    ; NA1
    mov     r3,r7
    mov     r4,#0x2F
    mov     r5,#0x10
    ldr     r6,=#0x0100020F
    strb    r4,[r3,#0x1]
    strb    r5,[r3,#0x9]
    str     r6,[r3,#0x1C]
    sub     r1,1
    cmp     r1,#0x0
    beq     @@subr_end
    ; Kuwagust/Harpuia
    ldr     r4,=#0x1E006F80
    mov     r5,#0x3
    mov     r6,#0xF
    str     r4,[r3]
    add     r3,#0x33
    strb    r5,[r3]
    strb    r6,[r3,#0x1]
    sub     r1,2
    cmp     r1,#0x0
    ble     @@subr_end
    ; Burble
    mov     r3,r7
    mov     r4,#0x4
    add     r3,#0x2F
    strb    r4,[r3]
    sub     r1,1
    cmp     r1,#0x0
    beq     @@subr_end
    ; Leviathan
    mov     r3,r7
    mov     r4,#0x4
    add     r3,#0x28
    strb    r4,[r3]
    sub     r1,1
    cmp     r1,#0x0
    beq     @@subr_end
    ; Fefnir
    mov     r3,r7
    mov     r4,#0x11
    mov     r5,#0x4
    ldr     r6,=#0x04001802
    strb    r4,[r3,#0x9]
    add     r3,#0x2A
    strb    r5,[r3]
    add     r3,#0x2
    str     r6,[r3]
    sub     r1,1
    cmp     r1,#0x0
    beq     @@subr_end
    ; NA2, AP1, AP2, AP3
    mov     r3,r7
    mov     r4,#0xEF
    ldr     r5,=#0x03000201
    strb    r4,[r3,#0x1]
    add     r3,#0x30
    str     r5,[r3]
    sub     r1,4
    cmp     r1,#0x0
    ble     @@subr_end
    ; Final
    mov     r3,r7
    mov     r4,#0x1
    add     r3,#0x36
    strb    r4,[r3]
    
@@subr_end:
    bx      r14
    .pool