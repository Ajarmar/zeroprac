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
    cmp     r4,#0x11
    beq     @checkpoints_end
    sub     r4,r4,1
    mov     r5,#0x10
    mul     r4,r5
    ; ldr     r6,=#REG_CHECKPOINTS_CURRENT
    ; add     r6,r6,r4
    ldrb    r5,[r3,#0x2]
    mov     r2,r3
    ; b       @check_if_boss
@after_boss_check:
    ; add     r6,r6,r1
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
    add     r5,#0x1
    ; mov     r7,#0x24
    ; add     r7,r3,r7
    ; mov     r5,#0x0
    ; strh    r5,[r7]
    ; mov     r7,#0x80
    ; lsl     r7,r7,2
    ; add     r6,r6,r7
    b       @store_checkpoint
@left_held:
    sub     r5,#0x1
    ; mov     r7,0x80
    ; lsl     r7,r7,1
    ; add     r6,r6,r7
@store_checkpoint:
    ; ldrb    r5,[r6]
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
    .pool
    .endarea
    .endarea