    .gba
    .org 0x08387A00
    .area 0x600
    
    .db 7, 6    ; Intro
    .db 6, 7    ; Flizard
    .db 8, 9    ; Childre
    .db 5, 6    ; Hellbat
    .db 6, 7    ; Mantisk
    .db 5, 6    ; Baby Elves 1
    .db 4, 5    ; Anubis
    .db 4, 5    ; Hanumachine
    .db 4, 5    ; Blizzack
    .db 4, 5    ; Copy X
    .db 5, 6    ; Foxtar
    .db 4, 5    ; Cactank
    .db 5, 6    ; Volteel
    .db 5, 6    ; Kelverian
    .db 7, 8    ; Baby Elves 2
    .db 9, 0xC  ; Final
    
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