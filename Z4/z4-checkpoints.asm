    .gba
    .org REG_CHECKPOINTS
    .area REG_CHECKPOINTS_AREA
    .area REG_CHECKPOINTS_INSTR_AREA
    ; 036FE8 big important for charge (???)
load_checkpoint:
    push    r14
    ldr     r4,=#ADDR_STAGETIME     ; Stage timer
    mov     r5,#0x0
    str     r5,[r4]
    ldr     r4,=#ADDR_GAMESTATE     ; Game state
    mov     r5,#0x3
    strb    r5,[r4]
    ldr     r4,=#ADDR_SAVEDHEALTH     ; Zero's saved health
    mov     r5,#0x10
    strb    r5,[r4]
    ldr     r4,=#ADDR_KEY
    ldrh    r5,[r4]
    mov     r6,#VAL_KEY_DOWN
    and     r6,r5
    cmp     r6,#0x0
    bne     @after_settings
    ; 366BA = e-crystals
    ; 366F5 = elf name
    ; saved: 3595E - 35999
    ; 0x3C = 60 bytes
    ldr     r1,=#ADDR_SETTINGS_SAVED     ; "Saved gameplay settings" section to write to
    ldr     r0,=#ADDR_SETTINGS     ; Read from control settings
    ldrh    r2,[r0]             ; Load 2 bytes
    strh    r2,[r1]             ; Store 2 bytes
    add     r0,#0x2
    add     r1,#0x2
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r3}         ; Load 8 bytes
    stmia   r1!,{r2-r3}         ; Store 8 bytes
    ldrh    r2,[r0]             ; Load another 2 bytes
    strh    r2,[r1]             ; Store another 2 bytes
@after_settings:
    ldr     r3,=#ADDR_STAGEINDEX
    ldrb    r4,[r3]
    mov     r0,r4
    cmp     r4,#VAL_STAGE_COMMANDERROOM
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
    ldr     r0,=#ADDR_KEY
    ldrh    r1,[r0]
    mov     r2,#VAL_KEY_LEFT
    and     r2,r1
    cmp     r2,#0x0
    bne     @left_held
    mov     r2,#VAL_KEY_RIGHT
    and     r2,r1
    cmp     r2,#0x0
    beq     @store_checkpoint
    mov     r2,#0x1
    mov     r7,#0x24
    add     r7,r3,r7
    mov     r5,#0x0
    strh    r5,[r7]
    mov     r7,#0x80
    lsl     r7,r7,2
    add     r6,r6,r7
    b       @store_checkpoint
@left_held:
    mov     r2,#0x2
    mov     r7,0x80
    lsl     r7,r7,1
    add     r6,r6,r7
@store_checkpoint:
    ldrb    r5,[r6]
    ldr     r0,=#ADDR_STAGEINDEX
    ldrb    r0,[r0]
    cmp     r0,#0xB
    beq     @in_craft1
    cmp     r0,#0xE
    beq     @in_randam
    cmp     r0,#0x10
    beq     @in_final
@really_store_checkpoint:
    strb    r5,[r3,#0x2]
    ; cmp     r5,#0xB
    ; blt     @after_omega_check
    ; ldr     r5,=#0x02036FE8
    ; mov     r6,#0x0
    ; strh    r6,[r5]
; @after_omega_check:
    ; bl      @set_charge
    ; bl      reset_disks
    ; bl      reset_volteel_rng
    ; bl      reset_progress
    ; bl      @undo_mission
@checkpoints_end:
    pop     r0
    bx      r0
@in_craft1:
    cmp     r5,#0x3
    blt     @really_store_checkpoint
    ldr     r1,=#ADDR_STAGEPROGRESS
    ldr     r0,=#0x3E0
    strh    r0,[r1]
    b       @really_store_checkpoint
@in_randam:
    cmp     r2,#0x1
    beq     @cross_forward
    cmp     r2,#0x2
    beq     @cross_backward
    b       @really_store_checkpoint
@cross_forward:
    cmp     r5,#0x3
    bne     @really_store_checkpoint
    ldr     r1,=#ADDR_CHECKPOINT_CROSSSTATION
    ldrb    r0,[r1]
    cmp     r0,#0x4
    bge     @@go_store
    sub     r5,1
    ldr     r4,=#ADDR_STAGEPROGRESS
    ldrb    r6,[r4,#0x1]
    cmp     r0,#0x1
    beq     @@forward_to_l
    cmp     r0,#0x3
    beq     @@forward_to_d
    cmp     r0,#0x2
    beq     @@forward_to_r
    mov     r0,#0x1
    mov     r2,#0x4
    b       @@store_progress
@@forward_to_l:
    mov     r0,#0x3
    mov     r2,#0x10
    b       @@store_progress
@@forward_to_d:
    mov     r0,#0x2
    mov     r2,#0x8
    b       @@store_progress
@@forward_to_r:
    mov     r0,#0x4
    mov     r2,#0x20
@@store_progress:
    orr     r6,r2
    strb    r6,[r4,#0x1]
    strb    r0,[r1]
@@go_store:
    b       @really_store_checkpoint
@cross_backward:
    cmp     r5,#0x1
    bne     @really_store_checkpoint
    ldr     r1,=#ADDR_CHECKPOINT_CROSSSTATION
    ldrb    r0,[r1]
    cmp     r0,#0x0
    beq     @@go_store
    add     r5,1
    ldr     r4,=#ADDR_STAGEPROGRESS
    ldrb    r6,[r4,#0x1]
    cmp     r0,#0x4
    beq     @@backward_to_d
    cmp     r0,#0x2
    beq     @@backward_to_l
    cmp     r0,#0x3
    beq     @@backward_to_u
    mov     r0,#0x0
    mov     r2,#0xFB
    b       @@store_progress
@@backward_to_d:
    mov     r0,#0x2
    mov     r2,#0xDF
    b       @@store_progress
@@backward_to_l:
    mov     r0,#0x3
    mov     r2,#0xF7
    b       @@store_progress
@@backward_to_u:
    mov     r0,#0x1
    mov     r2,#0xEF
@@store_progress:
    and     r6,r2
    strb    r6,[r4,#0x1]
    strb    r0,[r1]
@@go_store:
    b       @really_store_checkpoint
@in_final:
    cmp     r5,#0x7
    bne     @really_store_checkpoint
    ldr     r1,=#0x02036654             ; x position
    ldr     r1,[r1]
    ldr     r0,=#0xE0000
    cmp     r1,r0
    blt     @really_store_checkpoint
    add     r5,1
    b       @really_store_checkpoint
    .pool
    
@check_if_boss: ;r0 = stage index, r1 = checkpoint index, r2 = stage index address
    ldr     r4,=#ADDR_BOSS_EXISTENCE
    ldr     r4,[r4]
    cmp     r4,#0x0
    beq     @@goto_after_boss_check
    mov     r7,r4
    ldr     r4,=#REG_CHECKPOINTS_MINIBOSS
    sub     r5,r0,#0x1
    add     r4,r4,r5
    ldrb    r4,[r4]
    cmp     r1,r4
    beq     @@goto_after_boss_check
@@not_in_foxtar:
    ldr     r4,=#0x0202E917 ; non-zero when not in control
    ldrb    r4,[r4]
    cmp     r4,#0x0
    beq     @@continue
    mov     r4,#0xA4
    add     r7,r7,r4
    ldrh    r7,[r7]
    lsl     r7,r7,#0x10
    asr     r7,r7,#0x10
    cmp     r7,#0x0
    bgt     @@goto_after_boss_check
@@continue:
    add     r1,r1,1
    strb    r1,[r2,#0x2]
@@goto_after_boss_check:
    b       @after_boss_check
    
    .pool
    .endarea
        
    ; Current checkpoint
    .org REG_CHECKPOINTS_CURRENT
    .area REG_CHECKPOINTS_CURRENT_AREA
    ; Intro
    .db 0,1,2,3,4,4,6,7,7,7
    .align 0x10
    
    ; Intro 2
    .db 0,1,2,3,4,5
    .align 0x10
    
    ; Genblem
    .db 0,1,2,4,3,5,6,7
    .align 0x10
    
    ; Kraken
    .db 0,1,2,4,3,5,6,7
    .align 0x10
    
    ; Pegasolta
    .db 0,1,2,4,3,5,6,7
    .align 0x10
    
    ; Mandrago
    .db 0,1,2,3,4,5,6,7
    .align 0x10
    
    ; Titanion
    .db 0,1,2,4,3,5,6,7
    .align 0x10
    
    ; Fenri
    .db 0,1,2,3,4,5,6,7
    .align 0x10
    
    ; Mino
    .db 0,1,2,4,3,5,6,7
    .align 0x10
    
    ; Popla
    .db 0,1,2,4,3,5,6,7
    .align 0x10
    
    ; Craft 1
    .db 0,1,2,3,4
    .align 0x10
    
    ; Hell
    .db 0,1,2,3,4,5,6
    .align 0x10
    
    ; Craft 2
    .db 0,1,2,3,4,5,5,5
    .align 0x10
    
    ; Randam
    .db 0,1,2,3,4,4,4
    .align 0x10
    
    ; Cyball
    .db 0,1,2,3,4,5,5,5
    .align 0x10
    
    ; Final
    .db 0,1,2,3,4,5,6,7,8,8,8
    .endarea
    
    
    
    ; Previous checkpoint
    .org REG_CHECKPOINTS_PREV
    .area REG_CHECKPOINTS_PREV_AREA
    
    ; Intro
    .db 0,1,2,2,3,3,5,6,6
    .align 0x10
    
    ; Intro 2
    .db 0,1,1,2,3,4
    .align 0x10
    
    ; Genblem
    .db 0,1,1,3,2,3,5,6
    .align 0x10
    
    ; Kraken
    .db 0,1,1,3,2,3,5,6
    .align 0x10
    
    ; Pegasolta
    .db 0,1,1,3,2,3,5,6
    .align 0x10
    
    ; Mandrago
    .db 0,1,1,2,3,3,5,6
    .align 0x10
    
    ; Titanion
    .db 0,1,1,3,2,3,5,6
    .align 0x10
    
    ; Fenri
    .db 0,1,1,2,3,3,5,6
    .align 0x10
    
    ; Mino
    .db 0,1,1,3,2,3,5,6
    .align 0x10
    
    ; Popla
    .db 0,1,1,3,2,3,5,6
    .align 0x10
    
    ; Craft 1
    .db 0,1,1,2,3
    .align 0x10
    
    ; Hell
    .db 0,1,1,2,3,3,3
    .align 0x10
    
    ; Craft 2
    .db 0,1,1,2,3,4,4,4
    .align 0x10
    
    ; Randam
    .db 0,1,1,2,3,3,3
    .align 0x10
    
    ; Cyball
    .db 0,1,1,2,3,4,4,4
    .align 0x10
    
    ; Final
    .db 0,1,1,2,3,4,5,6,7,7,7
    .endarea
    
    
    
    ; Next checkpoint
    .org REG_CHECKPOINTS_NEXT
    .area REG_CHECKPOINTS_NEXT_AREA
    
    ; Intro
    .db 0,3,3,4,5,6,7,7,7
    .align 0x10
    
    ; Intro 2
    .db 0,2,3,4,5,5
    .align 0x10
    
    ; Genblem
    .db 0,2,3,5,4,6,7,7
    .align 0x10
    
    ; Kraken
    .db 0,2,3,5,4,6,7,7
    .align 0x10
    
    ; Pegasolta
    .db 0,2,3,5,4,6,7,7
    .align 0x10
    
    ; Mandrago
    .db 0,2,3,4,5,6,7,7
    .align 0x10
    
    ; Titanion
    .db 0,2,3,5,4,6,7,7
    .align 0x10
    
    ; Fenri
    .db 0,2,3,4,5,6,7,7
    .align 0x10
    
    ; Mino
    .db 0,2,3,5,4,6,7,7
    .align 0x10
    
    ; Popla
    .db 0,2,3,5,4,6,7,7
    .align 0x10
    
    ; Craft 1
    .db 0,2,3,4,4
    .align 0x10
    
    ; Hell
    .db 0,2,3,4,5,6,6
    .align 0x10
    
    ; Craft 2
    .db 0,2,3,4,5,5,5,5
    .align 0x10
    
    ; Randam
    .db 0,2,3,4,4,4,4
    .align 0x10
    
    ; Baby Elves 2
    .db 0,2,3,4,5,5,5,5
    .align 0x10
    
    ; Final
    .db 0,2,3,5,5,6,7,8,8,8,8
    .endarea
    
    ; Miniboss values
    .org REG_CHECKPOINTS_MINIBOSS
    .area REG_CHECKPOINTS_MINIBOSS_AREA
    .db 0,0,3,3,3,0,3,0,3,3,0,0,0,0,0,0
    .endarea
    
    .endarea