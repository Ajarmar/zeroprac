    .gba
    .include "cfg/z2-cutsceneskipscfg.asm"
    
    ; Change to existing code.
    ; Normally checks if you're in the intro stage, now checks
    ; if you are in any stage that isn't commander room.
    .org 0x08014AAA
    cmp     r0,#0x10
    bgt     #0x08014AB4
    nop
    
    ; Change to existing code.
    ; Normally checks a value that is set if you have a save file,
    ; to see if you should be allowed to skip the intro cutscene.
    ; Now branches to a new subroutine instead and skips this check.
    .org 0x08014E96
    .area 14
    ldr     r2,=#0x083581A1
    ldr     r5,=#0x0202F8E0
    bx      r2
    .pool
    .endarea
    
    ; Change to existing code.
    ; Changes branch destination for text box handling.
    .org 0x0834E0A0
    .dw 0x08358221
    
    ; New code.
    ; Skips cutscenes at the beginnings of stages when start is pressed.
    ; These cutscene skips are essentially the same as the stage being reloaded
    ; when you die, but without dying. Also works if you want to reload the
    ; stage quickly after dying.
    .org 0x083581A0
    .area 0x80
    cmp     r0,#0x1
    bne     not_intro
    mov     r2,r1
    ldr     r3,[r2,#0x20]
    ldr     r0,=#0x08014EA5
    bx      r0
not_intro:
    push    {r2,r3,r6,r7}
    ldr     r1,=#0x08358104
    ldr     r5,=#0x0202EC4C
    mov     r4,#0x8
    sub     r0,#0x2
    mul     r0,r4
    add     r0,r1,r0
    ldr     r1,[r0]
    ldr     r5,[r5]
    cmp     r5,r1
    bge     @@subr_end
    ldr     r0,=#0x02000D10     ; Check for start button press {
    ldrh    r1,[r0,#0x4]
    mov     r4,#0x8
    and     r1,r4
    cmp     r1,#0x0             ; }
    beq     @@subr_end
    mov     r4,#0x3
    ldr     r5,=#0x0202F8E1
    strb    r4,[r5]
    ldr     r1,=#0x02036C10     ; "Saved gameplay settings" section to write to
    ldr     r0,=#0x02037EDC     ; Read from control settings
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r3}         ; Load 8 bytes
    stmia   r1!,{r2-r3}         ; Store 8 bytes
    ldrh    r2,[r0]             ; Load another 2 bytes
    strh    r2,[r1]             ; Store another 2 bytes
@@subr_end:
    pop     {r2,r3,r6,r7}
    ldr     r4,=#0x08014EDF
    bx      r4
    .pool
    .endarea
    
    ; New code.
    ; Allows text boxes to be skipped. By holding start, the current text box 
    ; will be skipped to the end immediately, and the remaining text boxes in
    ; the current set will be skipped. Text boxes with prompts are not skippable.
    .area 0xE0
    .org 0x08358220
    push    {r4-r6}
    ldr     r4,=#0x0202F660
    ldrb    r5,[r4]
    cmp     r5,#0x1             ; Checks if there's a prompt
    beq     @@fill_textbox      ; If there is a prompt, just fill the text box without skipping it
    ldr     r4,=#0x02000D10     ; Checks if start is held {
    ldrh    r5,[r4]
    mov     r6,#0x8
    and     r5,r6
    cmp     r5,#0x0             ; }
    beq     @@subr_end
    ldr     r4,=#0x0202F658
    mov     r5,#0x2
    strh    r5,[r4]
@@fill_textbox:
    ldr     r4,=#0x0202F668     ; Sets the progress in the current text box to
    ldrh    r5,[r4]             ; its maximum capacity. {
    strh    r5,[r4,#0x2]        ; }
@@subr_end:
    ldr     r1,=#0x080DF73D
    pop     {r4-r6}
    bx      r1
    .pool
    .endarea