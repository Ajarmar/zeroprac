    .gba
    .org REG_CHECKPOINTS
    .area REG_CHECKPOINTS_AREA
load_checkpoint:
    push    r14
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
    ldr     r3,=#ADDR_STAGE_INDEX
    ldrb    r4,[r3]
    mov     r0,r4
    cmp     r4,#0x11
    beq     @checkpoints_end
    sub     r4,r4,1
    mov     r5,#0x10
    mul     r4,r5
    ldr     r6,=#org(@checkpoint_indices_base)
    add     r6,r6,r4
    ldrb    r1,[r3,#0x2]
    mov     r2,r3
;    b       @check_if_boss
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
    mov     r7,#0x24
    add     r7,r3,r7
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
    ldrb    r5,[r6]
    strb    r5,[r3,#0x2]
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
    pop     r0
    bx      r0
    .pool
    
; phoenix reactors: 2->08  4->20  5->40  3->10
    
@phoenix_reactors:
    .db 0x0, 0x0, 0x8, 0x78, 0x28, 0x68, 0x0, 0x78, 0x78, 0x78, 0x78
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
    .db 0,2,3,3
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
    .db 0,2,3,3
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
    .endarea