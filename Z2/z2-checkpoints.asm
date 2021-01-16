    .gba
    .org REG_CHECKPOINTS
    .area REG_CHECKPOINTS_AREA
load_checkpoint:
    push    {r4-r7,r14}
    ldr     r4,=#ADDR_STAGETIME             ; Stage timer
    mov     r5,#0x0
    str     r5,[r4]
    ldr     r4,=#ADDR_GAME_STATE            ; Game state
    mov     r5,#0x3
    strb    r5,[r4]
    ldr     r4,=#ADDR_ZERO_RESPAWN_HEALTH   ; Zero's saved health
    mov     r5,#0x10
    strb    r5,[r4]
    ldr     r4,=#ADDR_ZERO_SUBTANK_CONTENTS_1
    lsl     r5,#0x1
    strb    r5,[r4]
    ldr     r4,=#ADDR_KEY
    ldrh    r5,[r4]
    mov     r6,#VAL_KEY_DOWN
    and     r6,r5
    cmp     r6,#0x0
    bne     @after_settings
    ldr     r0,=#ADDR_ZERO_BASE
    ldr     r1,=#ADDR_STORED_ZERO_DATA
    bl      ROMADDR_STORE_ZERO_DATA
@after_settings:
    ldr     r4,=#ADDR_STAGE_INDEX
    ldrb    r3,[r4]
    cmp     r3,#0x11
    beq     @checkpoints_end
    sub     r3,r3,1
    mov     r2,r3
    lsl     r3,#0x4
    ldr     r6,=#org(@checkpoint_indices_base)
    add     r6,r6,r3
    ldrb    r0,[r4,#0x2]
    mov     r1,r4
    bl      @check_if_boss
@after_boss_check:
    add     r6,r6,r0
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
    mov     r7,#0x24
    add     r7,r4,r7
    mov     r5,#0x0
    strh    r5,[r7]
    mov     r7,#0x80            ; Right held
    lsl     r7,r7,2
    add     r6,r6,r7
    b       @store_checkpoint
@left_held:
    mov     r7,0x80
    lsl     r7,r7,1
    add     r6,r6,r7
@store_checkpoint:
    bl      @check_platinum
    cmp     r0,#0x0
    bne     @@not_platinum
    mov     r0,#0xC0
    lsl     r0,#0x2
    add     r6,r6,r0
@@not_platinum:
    ldrb    r5,[r6]
@@really_store_checkpoint:
    strb    r5,[r4,#0x2]
    ldr     r1,=#ADDR_STAGE_INDEX
    ldrb    r0,[r1]
    cmp     r0,#0x5             ; Phoenix reactor handling
    bne     @checkpoints_end
    ldrb    r0,[r1,#0x2]
    ldr     r2,=#org(@phoenix_reactors)
    add     r2,r2,r0
    ldrb    r0,[r2]
    strb    r0,[r1,#0xA]
@checkpoints_end:
    pop     {r4-r7}
    pop     r0
    bx      r0
    .pool

@check_platinum:
    ldr     r0,=#ROMADDR_PLATINUM
    ldr     r0,[r0]
    ldr     r1,=#org(@plat_ascii)
    ldr     r1,[r1]
    cmp     r0,r1
    beq     @@ret_0
    mov     r0,#0x1
    b       @@subr_end
@@ret_0:
    mov     r0,#0x0
@@subr_end:
    bx      r14
    .pool
@plat_ascii:
    .ascii "PLAT"

@phoenix_reactors:
    .db 0x0, 0x0, 0x8, 0x78, 0x28, 0x68, 0x0, 0x78, 0x78, 0x78, 0x78
    .align 2

    ; r0 = current checkpoint, r1 = stage index addr (0x0202EC30), r2 = current stage index
@check_if_boss:
    push    {r4-r7,r14}
    mov     r4,r0
    mov     r5,r1
    bl      @check_platinum
    cmp     r0,#0x0
    bne     @@return_input
    mov     r1,r5
    ldr     r0,[r1,#0x30]
    cmp     r0,#0x0
    beq     @@return_input
    mov     r3,#0xBE
    lsl     r3,#0x1
    add     r1,r1,r3
    ldrb    r1,[r1]
    ldr     r3,=#org(@boss_stage_states)
    add     r3,r3,r2
    ldrb    r0,[r3]
    cmp     r1,r0
    blt     @@check_if_kuwagust
    ldr     r3,=#org(@boss_checkpoints)
    add     r3,r3,r2
    ldrb    r0,[r3]
    b       @@subr_end
@@check_if_kuwagust:
    cmp     r2,#0x3
    bne     @@return_input
    cmp     r4,#0x3
    bne     @@return_input
    cmp     r1,#0x7
    blt     @@return_input
    mov     r0,#0x6
    b       @@subr_end
@@return_input:
    mov     r0,r4
@@subr_end:
    pop     {r4-r7}
    pop     r1
    bx      r1
    .pool

@boss_stage_states:
    .db 0xD, 0xA, 0x7, 0xD, 0x8, 0x8, 0x8, 0x3, 0x7, 0x3, 0xF, 0xF, 0x5, 0x5, 0x4, 0xE
@boss_checkpoints:
    .db 0x4, 0x4, 0x4, 0x8, 0x8, 0x4, 0x4, 0x3, 0x4, 0x3, 0x2, 0x2, 0x3, 0x3, 0x3, 0xC

    .endarea
    
    ; Current checkpoint
    .org REG_CHECKPOINTS_INDICES
    .area REG_CHECKPOINTS_INDICES_AREA
    .align 0x10

@checkpoint_indices_base:
    ; Intro
    .db 0,1,2,3
    .align 0x10
    
    ; Hyleg
    .db 0,1,2,3
    .align 0x10
    
    ; Poler
    .db 0,1,2,3
    .align 0x10
    
    ; Kuwagust
    .db 0,1,2,3,4,5
    .align 0x10
    
    ; Phoenix
    .db 0,1,2,3,4,5,6
    .align 0x10
    
    ; Panter
    .db 0,1,2,3
    .align 0x10
    
    ; Burble
    .db 0,1,2,3
    .align 0x10
    
    ; Leviathan
    .db 0,1,2
    .align 0x10
    
    ; Harpuia
    .db 0,1,2,3
    .align 0x10
    
    ; Fefnir
    .db 0,1,2
    .align 0x10
    
    ; NA2
    .db 0,1,2
    .align 0x10
    
    ; NA1
    .db 0,1,2
    .align 0x10
    
    ; Fefnir AP
    .db 0,1,2
    .align 0x10
    
    ; Leviathan AP
    .db 0,1,2
    .align 0x10
    
    ; Harpuia AP
    .db 0,1,2
    .align 0x10
    
    ; Final
    .db 0,1,2,3,4,5
    .align 0x10
    


    ; Previous checkpoint
    
    ; Intro
    .db 0,1,1,2
    .align 0x10
    
    ; Hyleg
    .db 0,1,1,2
    .align 0x10
    
    ; Poler
    .db 0,1,1,2
    .align 0x10
    
    ; Kuwagust
    .db 0,1,1,2,3,4
    .align 0x10
    
    ; Phoenix
    .db 0,1,1,5,2,4,6
    .align 0x10
    
    ; Panter
    .db 0,1,1,2
    .align 0x10
    
    ; Burble
    .db 0,1,1,2
    .align 0x10
    
    ; Leviathan
    .db 0,1,1
    .align 0x10
    
    ; Harpuia
    .db 0,1,1,2
    .align 0x10
    
    ; Fefnir
    .db 0,1,1
    .align 0x10
    
    ; NA2
    .db 0,1,1
    .align 0x10
    
    ; NA1
    .db 0,1,1
    .align 0x10
    
    ; Fefnir AP
    .db 0,1,1
    .align 0x10
    
    ; Leviathan AP
    .db 0,1,1
    .align 0x10
    
    ; Harpuia AP
    .db 0,1,1
    .align 0x10
    
    ; Final
    .db 0,0,1,2,3,4
    .align 0x10
    


    ; Next checkpoint
    
    ; Intro
    .db 1,2,3,3
    .align 0x10
    
    ; Hyleg
    .db 0,2,3,3
    .align 0x10
    
    ; Poler
    .db 0,2,3,3
    .align 0x10
    
    ; Kuwagust
    .db 0,2,3,4,5,5
    .align 0x10
    
    ; Phoenix
    .db 0,2,4,3,5,3,6
    .align 0x10
    
    ; Panter
    .db 0,2,3,3
    .align 0x10
    
    ; Burble
    .db 0,2,3,3
    .align 0x10
    
    ; Leviathan
    .db 0,2,2
    .align 0x10
    
    ; Harpuia
    .db 0,2,3,3
    .align 0x10
    
    ; Fefnir
    .db 0,2,2
    .align 0x10
    
    ; NA2
    .db 0,2,2
    .align 0x10
    
    ; NA1
    .db 0,2,2
    .align 0x10
    
    ; Fefnir AP
    .db 0,2,2
    .align 0x10
    
    ; Leviathan AP
    .db 0,2,2
    .align 0x10
    
    ; Harpuia AP
    .db 0,2,2
    .align 0x10
    
    ; Final
    .db 1,2,3,4,5,5
    .align 0x10
    


    ; PLATINUM
    ; Current checkpoint

    ; Intro
    .db 0,1,2,3,4,4,4,4
    .align 0x10
    
    ; Hyleg
    .db 0,1,2,3,4,4
    .align 0x10
    
    ; Poler
    .db 0,1,2,3,4
    .align 0x10
    
    ; Kuwagust
    .db 0,1,2,3,4,5,6,6,8
    .align 0x10
    
    ; Phoenix
    .db 0,1,2,3,4,5,6,7,8,9,0xA
    .align 0x10
    
    ; Panter
    .db 0,1,2,3,4
    .align 0x10
    
    ; Burble
    .db 0,1,2,3,4,4
    .align 0x10
    
    ; Leviathan
    .db 0,1,2,3,3
    .align 0x10
    
    ; Harpuia
    .db 0,1,2,3,4,4
    .align 0x10
    
    ; Fefnir
    .db 0,1,2,3,3
    .align 0x10
    
    ; NA2
    .db 0,1,2
    .align 0x10
    
    ; NA1
    .db 0,1,2,2
    .align 0x10
    
    ; Fefnir AP
    .db 0,1,2,3,3
    .align 0x10
    
    ; Leviathan AP
    .db 0,1,2,3,3
    .align 0x10
    
    ; Harpuia AP
    .db 0,1,2,3,3
    .align 0x10
    
    ; Final
    .db 0,1,2,3,4,5,1,1,1,3,3,3,0xC,0xC
    .align 0x10
    
    
    
    ; Previous checkpoint
    
    ; Intro
    .db 0,1,1,2,3,3,3,3,3
    .align 0x10
    
    ; Hyleg
    .db 0,1,1,2,3,4
    .align 0x10
    
    ; Poler
    .db 0,1,1,2,3
    .align 0x10
    
    ; Kuwagust
    .db 0,1,1,2,3,4,3,6,5
    .align 0x10
    
    ; Phoenix
    .db 0,1,1,5,2,4,6,2,3,4,5
    .align 0x10
    
    ; Panter
    .db 0,1,1,2,3
    .align 0x10
    
    ; Burble
    .db 0,1,1,2,3,4
    .align 0x10
    
    ; Leviathan
    .db 0,1,1,2,3
    .align 0x10
    
    ; Harpuia
    .db 0,1,1,2,3,4
    .align 0x10
    
    ; Fefnir
    .db 0,1,1,2,3
    .align 0x10
    
    ; NA2
    .db 0,1,1
    .align 0x10
    
    ; NA1
    .db 0,1,1,2
    .align 0x10
    
    ; Fefnir AP
    .db 0,1,1,2,3
    .align 0x10
    
    ; Leviathan AP
    .db 0,1,1,2,3
    .align 0x10
    
    ; Harpuia AP
    .db 0,1,1,2,3
    .align 0x10
    
    ; Final
    .db 0,0,1,2,3,4,1,1,1,3,3,3,5,0xC
    .align 0x10
    


    ; Next checkpoint
    
    ; Intro
    .db 1,2,3,4,4,4,4,4
    .align 0x10
    
    ; Hyleg
    .db 0,2,3,4,4,4
    .align 0x10
    
    ; Poler
    .db 0,2,3,4,4
    .align 0x10
    
    ; Kuwagust
    .db 0,2,3,6,5,8,7,4,8
    .align 0x10
    
    ; Phoenix
    .db 0,2,4,8,5,3,6,7,8,9,0xA
    .align 0x10
    
    ; Panter
    .db 0,2,3,4,4
    .align 0x10
    
    ; Burble
    .db 0,2,3,4,4,4
    .align 0x10
    
    ; Leviathan
    .db 0,2,3,3,3
    .align 0x10
    
    ; Harpuia
    .db 0,2,3,4,4,4
    .align 0x10
    
    ; Fefnir
    .db 0,2,3,3,3
    .align 0x10
    
    ; NA2
    .db 0,2,2
    .align 0x10
    
    ; NA1
    .db 0,2,2,2
    .align 0x10
    
    ; Fefnir AP
    .db 0,2,3,3,3
    .align 0x10
    
    ; Leviathan AP
    .db 0,2,3,3,3
    .align 0x10
    
    ; Harpuia AP
    .db 0,2,3,3,3
    .align 0x10
    
    ; Final
    .db 1,2,3,4,5,0xC,2,2,2,4,4,4,0xD,0xD
    .endarea