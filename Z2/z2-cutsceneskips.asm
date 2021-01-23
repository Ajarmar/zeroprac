    .gba
    
    ; Change to existing code.
    ; Normally checks a value that is set if you have a save file,
    ; to see if you should be allowed to skip the intro cutscene.
    ; Now branches to a new subroutine instead and skips this check.
    .org 0x08014EA2
    nop
    
    ; Change to existing code.
    ; Branch to new subroutine (see changed pool below)
    .org 0x080E44B6
    bx      r1
    
    ; Change to existing code.
    ; Changes branch destination for text box handling.
    .org 0x0834E0A0
    .dw REG_TEXTBOX_SKIP+0x1
    
    ; New code.
    ; Allows text boxes to be skipped. By holding start, the current text box 
    ; will be skipped to the end immediately, and the remaining text boxes in
    ; the current set will be skipped. Text boxes with prompts are not skippable.
    .org REG_TEXTBOX_SKIP
    .area REG_TEXTBOX_SKIP_AREA
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