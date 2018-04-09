    .gba
    
    ; Equipped form
    FORM_NORMAL equ 0
    FORM_RISE equ 7
    
    ; Unlocked forms
    UNLFORM_NORMAL equ 1
    UNLFORM_RISE equ 0x81
    UNLFORM_ALL equ 0x3FF
    
    ; Equipped chip
    CHIP_NEUTRAL equ 0
    CHIP_THUNDER equ 1
    CHIP_FLAME equ 2
    CHIP_ICE equ 3
    
    ; Unlocked chips (flame & ice includes the preceding chips as well)
    UNLCHIP_NEUTRAL equ 1
    UNLCHIP_THUNDER equ 3
    UNLCHIP_FLAME equ 7
    UNLCHIP_ICE equ 0xF
    
    ; EX skills
    EX_NONE equ 0
    EX_TENSHOUZAN equ 0x10
    
    ; Equipped weapon
    WEP_BUSTER equ 0
    WEP_SABER equ 1
    WEP_CHAIN equ 2
    WEP_SHIELD equ 3
    
    ; Unlocked weapons
    UNLWEP_INTRO equ 3
    UNLWEP_ALL equ 0xF
    
    ; Buster levels above 0
    BUSTER_CHARGE equ 1
    BUSTER_QKCHARGE equ 2
    
    ; Saber levels above 0
    SABER_2SLASH equ 1
    SABER_3SLASH equ 2
    SABER_CHARGE equ 3
    SABER_QKCHARGE equ 4
    
    ; Chain levels above 0
    CHAIN_CHARGE equ 1
    CHAIN_QKCHARGE equ 2
    
    ; Shield levels above 0
    SHIELD_MID equ 1
    SHIELD_LONG equ 2
    
    .org 0x0835780E
    
    .area 0x330
    
    ; Intro
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_NORMAL         ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_NORMAL      ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_INTRO        ; Unlocked weapons
    .db UNLCHIP_NEUTRAL     ; Unlocked chips
    .db WEP_BUSTER          ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_NEUTRAL        ; Equipped chip
    .dh EX_NONE             ; Unlocked EX skills
    .dh EX_NONE             ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 0                   ; Saber experience
    .dh 0                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db 0                   ; Saber level
    .db 0                   ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Hyleg
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_FLAME          ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 220                   ; Saber experience
    .dh 0                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_3SLASH        ; Saber level
    .db 0                   ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Poler
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_NORMAL         ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_FLAME       ; Unlocked chips
    .db WEP_SHIELD          ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_THUNDER        ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_NONE             ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 165                   ; Saber experience
    .dh 1                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_3SLASH        ; Saber level
    .db 0                   ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Kuwagust
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_ICE            ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 370                   ; Saber experience
    .dh 4                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_CHARGE        ; Saber level
    .db 0                   ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Phoenix
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_NORMAL         ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_THUNDER     ; Unlocked chips
    .db WEP_BUSTER          ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_NEUTRAL        ; Equipped chip
    .dh EX_NONE             ; Unlocked EX skills
    .dh EX_NONE             ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 130                   ; Saber experience
    .dh 0                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_3SLASH        ; Saber level
    .db 0                   ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Panter
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_NORMAL         ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_NORMAL      ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_NEUTRAL     ; Unlocked chips
    .db WEP_BUSTER          ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_NEUTRAL        ; Equipped chip
    .dh EX_NONE             ; Unlocked EX skills
    .dh EX_NONE             ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 0                   ; Saber experience
    .dh 0                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db 0                   ; Saber level
    .db 0                   ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Burble
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_ICE            ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 620                   ; Saber experience
    .dh 125                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_CHARGE        ; Saber level
    .db CHAIN_CHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Leviathan
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_BUSTER           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_FLAME          ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 730                   ; Saber experience
    .dh 125                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_CHARGE        ; Saber level
    .db CHAIN_CHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Harpuia
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_ICE            ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 470                   ; Saber experience
    .dh 110                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_CHARGE        ; Saber level
    .db CHAIN_CHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Fefnir
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_FLAME          ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 800                   ; Saber experience
    .dh 140                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_CHARGE        ; Saber level
    .db CHAIN_CHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Neo Arcadia 2
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_THUNDER        ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 940                   ; Saber experience
    .dh 155                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_QKCHARGE        ; Saber level
    .db CHAIN_CHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Neo Arcadia 1
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_ICE            ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 270                   ; Saber experience
    .dh 4                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_3SLASH        ; Saber level
    .db 0                   ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Fefnir AP
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_THUNDER        ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 1120                   ; Saber experience
    .dh 160                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_QKCHARGE        ; Saber level
    .db CHAIN_CHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Leviathan AP
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_THUNDER        ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 1250                   ; Saber experience
    .dh 195                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_QKCHARGE        ; Saber level
    .db CHAIN_CHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Harpuia AP
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_FLAME          ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 1300                   ; Saber experience
    .dh 220                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_QKCHARGE        ; Saber level
    .db CHAIN_QKCHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Final
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_ICE            ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 1380                   ; Saber experience
    .dh 240                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_QKCHARGE        ; Saber level
    .db CHAIN_QKCHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    ; Commander Room
    .db 0,0,0,0,0,0         ; Unknown
    .db FORM_RISE           ; Equipped form
    .db 0x10                ; Max health
    .dh 0                   ; E-crystals
    .dh UNLFORM_RISE        ; Unlocked forms
    .db 0                   ; Extra health bars
    .db 0                   ; Unknown
    .db 0                   ; Subtank count
    .db 0                   ; Subtank count (elves)
    .db 0,0,0,0             ; Subtank contents for subtank 1-4
    .db 0,0,0               ; Equipped cyber elves 1-3
    .db 0,0,0               ; Unknown
    .db UNLWEP_ALL          ; Unlocked weapons
    .db UNLCHIP_ICE         ; Unlocked chips
    .db WEP_CHAIN           ; Equipped main weapon
    .db WEP_SABER           ; Equipped secondary weapon
    .db 0                   ; Unknown
    .db CHIP_THUNDER        ; Equipped chip
    .dh EX_TENSHOUZAN       ; Unlocked EX skills
    .dh EX_TENSHOUZAN       ; Equipped EX skills
    .dh 0                   ; Buster experience
    .dh 0                   ; Saber experience
    .dh 0                   ; Chain Rod experience
    .dh 0                   ; Shield Boomerang experience
    .db 0                   ; Buster level
    .db SABER_QKCHARGE        ; Saber level
    .db CHAIN_QKCHARGE        ; Chain Rod level
    .db 0                   ; Shield Boomerang level
    
    .endarea