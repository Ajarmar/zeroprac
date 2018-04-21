    .gba
    .open "Rockman Zero 2 (Japan).gba", "z2prac.gba", 0x08000000
    .include "z2-stageselect.asm"
    .include "z2-cutsceneskips.asm"
    
    .close