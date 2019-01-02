    .gba
    .org REG_CHECKPOINTS
    .area REG_CHECKPOINTS_AREA
    .area REG_CHECKPOINTS_INSTR_AREA
    ; 036FE8 big important for charge
load_checkpoint:
    push    r14
    ldr     r4,=#0x0202FE28     ; Stage timer
    mov     r5,#0x0
    str     r5,[r4]
    ldr     r4,=#0x02030B61     ; Game state
    mov     r5,#0x3
    strb    r5,[r4]
    ldr     r4,=#0x02036FEC     ; Zero's saved health
    mov     r5,#0x10
    strb    r5,[r4]
    ldr     r4,=#0x02001EB0
    ldrh    r5,[r4]
    mov     r6,#0x80
    and     r6,r5
    cmp     r6,#0x0
    bne     @after_settings
    ldr     r1,=#0x02036FC0     ; "Saved gameplay settings" section to write to
    ldr     r0,=#0x02037D14     ; Read from control settings
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r4}         ; Load 12 bytes
    stmia   r1!,{r2-r4}         ; Store 12 bytes
    ldrh    r2,[r0]             ; Load another 2 bytes
    strh    r2,[r1]             ; Store another 2 bytes
@after_settings:
    ldr     r3,=#0x0202FE60
    ldrb    r4,[r3]
    mov     r0,r4
    cmp     r4,#0x11
    beq     @checkpoints_end
    sub     r4,r4,1
    mov     r5,#0x10
    mul     r4,r5
    ldr     r6,=#REG_CHECKPOINTS_CURRENT
    add     r6,r6,r4
    ldrb    r1,[r3,#0x2]
    mov     r2,r3
    b       @check_if_boss
@after_boss_check:
    add     r6,r6,r1
    ldr     r0,=#0x02001EB0
    ldrh    r1,[r0]
    mov     r2,#0x20
    and     r2,r1
    cmp     r2,#0x0
    bne     @left_held
    mov     r2,#0x10
    and     r2,r1
    cmp     r2,#0x0
    beq     @store_checkpoint
    mov     r7,#0x24
    add     r7,r3,r7
    mov     r5,#0x0
    strh    r5,[r7]
    mov     r7,#0x80
    lsl     r7,r7,2
    add     r6,r6,r7
    b       @store_checkpoint
@left_held:
    mov     r7,0x80
    lsl     r7,r7,1
    add     r6,r6,r7
@store_checkpoint:
    ldrb    r5,[r6]
    strb    r5,[r3,#0x2]
    cmp     r5,#0xB
    blt     @after_omega_check
    ldr     r5,=#0x02036FE8
    mov     r6,#0x0
    strh    r6,[r5]
@after_omega_check:
    bl      @set_charge
    bl      reset_disks
    bl      reset_volteel_rng
    bl      reset_progress
    bl      @undo_mission
@checkpoints_end:
    pop     r0
    bx      r0
    
@check_if_boss: ;r0 = stage index, r1 = checkpoint index, r2 = stage index address
    ldr     r4,=#0x0202FE90
    ldr     r4,[r4]
    cmp     r4,#0x0
    beq     @after_boss_check
    mov     r7,r4
    ldr     r4,=#REG_CHECKPOINTS_MINIBOSS
    sub     r5,r0,#0x1
    add     r4,r4,r5
    ldrb    r4,[r4]
    cmp     r1,r4
    beq     @after_boss_check
    cmp     r0,#VAL_STAGE_FOXTAR
    bne     @@not_in_foxtar
    cmp     r1,#0x2
    beq     @after_boss_check
    cmp     r1,#0x4
    beq     @after_boss_check
@@not_in_foxtar:
    ldr     r4,=#0x0202FE67
    ldrb    r4,[r4]
    cmp     r0,#0x1
    beq     @@in_intro
    cmp     r0,#0x10
    beq     @@in_final
    cmp     r4,#0x0
    beq     @@continue
    mov     r4,#0xA4
    add     r7,r7,r4
    ldrh    r7,[r7]
    lsl     r7,r7,#0x10
    asr     r7,r7,#0x10
    cmp     r7,#0x0
    bgt     @after_boss_check
@@continue:
    add     r1,r1,1
    strb    r1,[r2,#0x2]
    b       @after_boss_check
@@in_intro:
    cmp     r4,#0x0
    beq     @after_boss_check
    mov     r4,#0xA4
    add     r7,r7,r4
    ldr     r7,[r7]
    cmp     r7,#0x0
    beq     @after_boss_check
    add     r1,r1,1
    strb    r1,[r2,#0x2]
    b       @after_boss_check
@@in_final:
    cmp     r1,#0x9
    beq     @@at_omega
    cmp     r4,#0x0
    beq     @@continue_final
    mov     r4,#0xA4
    add     r7,r7,r4
    ldrh    r7,[r7]
    lsl     r7,r7,#0x10
    asr     r7,r7,#0x10
    cmp     r7,#0x0
    bgt     @after_boss_check
@@continue_final:
    add     r1,r1,1
    strb    r1,[r2,#0x2]
    b       @after_boss_check
@@at_omega:
    ldr     r5,=#0x0202FE6A
    ldrb    r5,[r5]
    mov     r4,#0x7
    cmp     r5,r4
    bge     @@at_omega_zero
    mov     r4,#0x3
    cmp     r5,r4
    bge     @@at_omega_2
    add     r1,r1,1
    strb    r1,[r2,#0x2]
    b       @after_boss_check
@@at_omega_2:
    add     r1,r1,2
    strb    r1,[r2,#0x2]
    b       @after_boss_check
@@at_omega_zero:
    add     r1,r1,3
    strb    r1,[r2,#0x2]
    b       @after_boss_check
    
    .pool
    
@set_charge:
    ldrb    r5,[r3]
    cmp     r5,#0x1
    beq     @@continue
    cmp     r5,#0x6
    beq     @@continue
    cmp     r5,#0xA
    beq     @@continue
    cmp     r5,#0xF
    beq     @@continue
    cmp     r5,#0x10
    beq     @@continue_final
    b       @@subr_end
@@continue:
    mov     r6,#0x30
    add     r5,r3,r6
    ldr     r5,[r5]
    cmp     r5,#0x0
    beq     @@subr_end
    add     r5,#0xA4
    ldrh    r5,[r5]
    lsl     r5,r5,#0x10
    asr     r5,r5,#0x10
    cmp     r5,#0x0
    bgt     @@subr_end
    ldr     r5,=#0x02037D3C
    mov     r4,#0x24
    add     r4,r3,r4
    ldrh    r4,[r4]
    strh    r4,[r5]
    ldr     r5,=#0x02036FE8
    strh    r4,[r5]
    b       @@subr_end
@@continue_final:
    ldrb    r5,[r3,#0x2]
    cmp     r5,#0xA
    beq     @@continue
    ; ldrb    r5,[r3,#0xA]
    ; cmp     r5,#0x3
    ; blt     @@continue
@@subr_end:
    bx      r14
    .pool
    
@undo_mission:
    ldr     r0,=#0x0202FDC8
    ldr     r4,=#0x000C0000
    str     r4,[r0]
    bx      r14
    .pool
    
    .endarea
    
    ; Current checkpoint
    .org REG_CHECKPOINTS_CURRENT
    .area REG_CHECKPOINTS_CURRENT_AREA
    ; Intro
    .db 0,1,2,3,4,4,7,6
    .align 0x10
    
    ; Flizard
    .db 0,1,1,3,4,5,6,7
    .align 0x10
    
    ; Childre
    .db 0,1,1,3,3,5,6,7,8,9
    .align 0x10
    
    ; Hellbat
    .db 0,1,1,3,4,5,6
    .align 0x10
    
    ; Mantisk
    .db 0,1,1,3,3,5,6,7
    .align 0x10
    
    ; Baby Elves 1
    .db 0,1,1,3,3,5,6
    .align 0x10
    
    ; Anubis
    .db 0,0,0,3,4,5
    .align 0x10
    
    ; Hanumachine
    .db 0,0,0,3,4,5
    .align 0x10
    
    ; Blizzack
    .db 0,0,0,3,4,5
    .align 0x10
    
    ; Copy X
    .db 0,0,0,3,4,5
    .align 0x10
    
    ; Foxtar
    .db 0,1,1,3,4,5,6
    .align 0x10
    
    ; le Cactank
    .db 0,1,1,3,4,5
    .align 0x10
    
    ; Volteel
    .db 0,1,1,3,3,5,6
    .align 0x10
    
    ; Kelverian
    .db 0,0,0,3,4,5,6
    .align 0x10
    
    ; Baby Elves 2
    .db 0,0,0,4,4,5,6,7,8
    .align 0x10
    
    ; Final
    .db 0,0,0,3,4,5,6,7,8,9,0xA,0xB,0xC
    .endarea
    
    
    
    ; Previous checkpoint
    .org REG_CHECKPOINTS_PREV
    .area REG_CHECKPOINTS_PREV_AREA
    
    ; Intro
    .db 0,1,1,2,3,3,4,7
    .align 0x10
    
    ; Flizard
    .db 0,1,1,2,3,4,5,6
    .align 0x10
    
    ; Childre
    .db 0,1,1,2,2,3,5,6,7,8
    .align 0x10
    
    ; Hellbat
    .db 0,1,1,2,3,4,5
    .align 0x10
    
    ; Mantisk
    .db 0,1,1,2,2,3,5,6
    .align 0x10
    
    ; Baby Elves 1
    .db 0,1,1,2,2,3,5
    .align 0x10
    
    ; Anubis
    .db 0,0,0,0,3,4
    .align 0x10
    
    ; Hanumachine
    .db 0,0,0,0,3,4
    .align 0x10
    
    ; Blizzack
    .db 0,0,0,0,3,4
    .align 0x10
    
    ; Copy X
    .db 0,0,0,0,3,4
    .align 0x10
    
    ; Foxtar
    .db 0,1,1,2,3,4,5
    .align 0x10
    
    ; le Cactank
    .db 0,1,1,2,3,4
    .align 0x10
    
    ; Volteel
    .db 0,1,1,2,2,3,5
    .align 0x10
    
    ; Kelverian
    .db 0,0,0,0,3,4,5
    .align 0x10
    
    ; Baby Elves 2
    .db 0,0,0,0,0,4,0,6,7
    .align 0x10
    
    ; Final
    .db 0,0,0,0,3,3,5,6,6,8,9,0xA,0xB
    .endarea
    
    
    
    ; Next checkpoint
    .org REG_CHECKPOINTS_NEXT
    .area REG_CHECKPOINTS_NEXT_AREA
    
    ; Intro
    .db 0,3,3,4,7,7,6,6
    .align 0x10
    
    ; Flizard
    .db 0,2,3,4,5,6,7,7
    .align 0x10
    
    ; Childre
    .db 0,2,3,5,5,6,7,8,9,9
    .align 0x10
    
    ; Hellbat
    .db 0,2,3,4,5,6,6
    .align 0x10
    
    ; Mantisk
    .db 0,2,3,5,5,6,7,7
    .align 0x10
    
    ; Baby Elves 1
    .db 0,2,3,5,5,6,6
    .align 0x10
    
    ; Anubis
    .db 0,3,3,4,5,5
    .align 0x10
    
    ; Hanumachine
    .db 0,3,3,4,5,5
    .align 0x10
    
    ; Blizzack
    .db 0,3,3,4,5,5
    .align 0x10
    
    ; Copy X
    .db 0,3,3,4,5,5
    .align 0x10
    
    ; Foxtar
    .db 0,2,3,4,5,6,6
    .align 0x10
    
    ; le Cactank
    .db 0,2,3,4,5,5
    .align 0x10
    
    ; Volteel
    .db 0,2,3,5,5,6,6
    .align 0x10
    
    ; Kelverian
    .db 0,3,3,4,5,6,6
    .align 0x10
    
    ; Baby Elves 2
    .db 0,6,6,6,6,6,7,8,8
    .align 0x10
    
    ; Final
    .db 0,3,3,5,5,6,8,8,9,0xA,0xB,0xC,0xC
    .endarea
    
    
    
    ; Miniboss values
    .org REG_CHECKPOINTS_MINIBOSS
    .db 0,0,0,3,4,0,2,0,0,0,3,2,0,3,0,0
    
    
    
    
    ; Intro
    ; 5 -> 4
    ; 7 -> 6
    .db 3, 4, 7, 6
    .asciiz "START"
    .asciiz "MIDPOINT"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Hellbat
    ; 5 -> 6
    .db 2, 3, 4, 5, 6
    .asciiz "START"
    .asciiz "BEFORE MIDBOSS"
    .asciiz "AFTER MIDBOSS"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Flizard
    ; 6 -> 7
    .db 2, 3, 4, 5, 6, 7
    .asciiz "START"
    .asciiz "INSIDE"
    .asciiz "BEFORE MIDBOSS"
    .asciiz "AFTER MIDBOSS"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Mantisk
    ; 4 -> 3
    ; 6 -> 7
    .db 2, 3, 4, 5, 6, 7
    .asciiz "START"
    .asciiz "AFTER ELVES"
    .asciiz "AFTER ELVES 2"
    .asciiz "AFTER MIDBOSS"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Childre
    ; 4 -> 3
    ; 5 -> 6
    ; 8 -> 9
    .db 2, 3, 5, 6, 7, 8, 9
    .asciiz "START"
    .asciiz "FIRST CUTSCENE"
    .asciiz "BEFORE MIDBOSS"
    .asciiz "MIDBOSS"
    .asciiz "AFTER MIDBOSS"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Baby Elves 1
    ; 4 -> 3
    ; 5 -> 6
    .db 2, 3, 5, 6
    .asciiz "START"
    .asciiz "ON ROCKET"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Blizzack, Hanumachine, Anubis, Copy X
    ; 2 -> 1 ?
    ; 4 -> 5
    .db 1, 3, 4, 5
    .asciiz "START"
    .asciiz "MIDPOINT"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; le Cactank
    ; 4 -> 5
    .db 2, 3, 4, 5
    .asciiz "START"
    .asciiz "AFTER MIDBOSS"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Foxtar
    ; 5 -> 6
    .db 2, 3, 4, 5, 6
    .asciiz "START"
    .asciiz "BEFORE MIDBOSS"
    .asciiz "AFTER MIDBOSS"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Kelverian
    ; 2 -> 1 ?
    ; 5 -> 6
    .db 1, 3, 4, 5, 6
    .asciiz "START"
    .asciiz "ELEVATOR"
    .asciiz "AFTER ELEVATOR"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Volteel
    ; 4 -> 3
    ; 5 -> 6
    .db 2, 3, 5, 6
    .asciiz "START"
    .asciiz "MIDPOINT"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Baby Elves 2
    ; 2 -> 1
    ; 3 -> 4 (phantom)
    ; 7 -> 8
    .db 1, 3, 4, 6, 7, 8
    .asciiz "START"
    .asciiz "BEFORE PHANTOM"
    .asciiz "PHANTOM"
    .asciiz "MIDPOINT"
    .asciiz "BEFORE BOSS"
    .asciiz "BOSS"
    
    ; Final
    ; For boss rooms, check 0202FE6B:
    ; 1 = Mantisk, 2 = Hellbat, 3 = Childre, 4 = Flizard
    ; 5 = Kelverian, 6 = Volteel, 7 = Cactank, 8 = Foxtar
    ;
    ; 2 -> 1 (maybe...)
    ; 3 -> 4 if 2FE6B = 1,2,3,4
    ; 6 -> 7 if 2FE6B = 5,6,7,8
    .db 1, 3, 0x11, 0x12, 0x13, 0x14, 5, 6, 0x15, 0x16, 0x17, 0x18, 8, 9, 0xA, 0xB, 0xC
    .asciiz "START"
    .asciiz "TELEPORTERS 1"
    .asciiz "MANTISK"
    .asciiz "HELLBAT"
    .asciiz "CHILDRE"
    .asciiz "FLIZARD"
    .asciiz "ICE SECTION"
    .asciiz "TELEPORTERS 2"
    .asciiz "KELVERIAN"
    .asciiz "VOLTEEL"
    .asciiz "LE CACTANK"
    .asciiz "FOXTAR"
    .asciiz "FINAL SECTION"
    .asciiz "BEFORE OMEGA"
    .asciiz "OMEGA 1"
    .asciiz "OMEGA 2"
    .asciiz "OMEGA ZERO"
    
    .endarea