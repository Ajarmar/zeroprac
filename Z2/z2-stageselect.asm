; With "zeroprac" folder in the same folder as ARMIPS:
; compile with "armips z2-stageselect.asm -root zeroprac/Z2"

    .gba
    .open "Rockman Zero 2 (Japan).gba", "z2-stageselect.gba", 0x08000000
    .include "stageselectcfg.asm"

    ; Change to existing code
    .org 0x080E4862
    mov     r5,#0xC             ; Check for start/select instead of just start
    .skip 8
    ldr     r5,=#0x080F90F5     ; New subroutine
    bx      r5
    .pool
    
    ; Change to existing code
    .org 0x080E543C
    .area 14,0
    .skip 2
    ldr     r2,=#0x0835780E
    bx      r3
    .pool
    .endarea
    
    ; Change to existing code
    .org 0x080E5470 ; Fix text alignments
    .db 0xBB        ; Panter
    .org 0x080E547C
    .db 0xEB        ; Hyleg
    
    ; Change to existing code
    .org 0x080E54B4
    .dw 0x08357B3F  ; Change pool for instruction at 080E543C

    ; New code
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

    ; Change to existing code
    .org 0x080FEB94 ; Fix stage index order in menu
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

    ; Change to existing code
    .org 0x080FEBA8 ; Change stage select menu entries
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
    .org 0x08357B3E
    push    {r0,r4-r7}
    sub     r0,1                ; Subtract stage index by 1
    mov     r3,0x30
    mul     r0,r3               ; Multiply by 0x30
    add     r0,r2,r0            ; Add as offset to source address
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
    ldr     r3,=#0x080E544B     ; Address to return to
    pop     {r0,r4-r7}
    bx      r3
    .pool

    .close