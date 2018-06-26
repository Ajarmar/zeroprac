    .gba
    
    ; Change to existing code.
    ; Sets cutscenes to always be skippable
    .org 0x0802352E
    b       #0x08023568