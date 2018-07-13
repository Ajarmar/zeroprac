    .gba
    
    ; Equipped form
    FORM_NORMAL equ 0
    FORM_RISE equ 7
	FORM_PROTO equ 8
    
    ; Unlocked forms
    UNLFORM_NORMAL equ 1
    UNLFORM_RISE equ 0x81
	UNLFORM_HARD equ 0x100
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
    
    ; Specific stages beaten - includes preceding stages
    BEAT_INTRO equ 2
    BEAT_PANTER equ 0x42
    BEAT_PHOENIX equ 0x62
    BEAT_POLER equ 0x6A
    BEAT_HYLEG equ 0x6E
    BEAT_NA1 equ 0x106E
    BEAT_KUWAGUST equ 0x107E
    BEAT_HARPUIA equ 0x127E
    BEAT_BURBLE equ 0x12FE
    BEAT_LEVIATHAN equ 0x13FE
    BEAT_FEFNIR equ 0x17FE
    BEAT_NA2 equ 0x1FFE
    BEAT_AP1 equ 0x3FFE
    BEAT_AP2 equ 0x7FFE
    BEAT_AP3 equ 0xFFFE
    
    .org REG_STAGE_SELECT_CFG
    
    .area REG_STAGE_SELECT_CFG_AREA
   
   	; Normal mode

	; Intro
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_NORMAL                ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_NORMAL             ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_INTRO               ; Unlocked weapons
    .db UNLCHIP_NEUTRAL            ; Unlocked chips
    .db WEP_BUSTER                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_NEUTRAL               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0                          ; Total points
    .dh 0                          ; Stages beaten
    .dh 0                          ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Hyleg
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_FLAME                 ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 220                        ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_3SLASH               ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x147                      ; Total points
    .dh 4                          ; Stages beaten
    .dh BEAT_POLER                 ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Poler
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_NORMAL                ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_FLAME              ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 165                        ; Saber experience
    .dh 1                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_3SLASH               ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x105                      ; Total points
    .dh 3                          ; Stages beaten
    .dh BEAT_PHOENIX               ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Kuwagust
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 370                        ; Saber experience
    .dh 4                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_CHARGE               ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x1E6                      ; Total points
    .dh 6                          ; Stages beaten
    .dh BEAT_NA1                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Phoenix
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_NORMAL                ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_THUNDER            ; Unlocked chips
    .db WEP_BUSTER                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_NEUTRAL               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 130                        ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_3SLASH               ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0xB2                       ; Total points
    .dh 2                          ; Stages beaten
    .dh BEAT_PANTER                ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Panter
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_NORMAL                ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_NORMAL             ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_NEUTRAL            ; Unlocked chips
    .db WEP_BUSTER                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_NEUTRAL               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x51                       ; Total points
    .dh 1                          ; Stages beaten
    .dh BEAT_INTRO                 ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Burble
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 620                        ; Saber experience
    .dh 125                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_CHARGE               ; Saber level
    .db CHAIN_CHARGE               ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x286                      ; Total points
    .dh 8                          ; Stages beaten
    .dh BEAT_HARPUIA               ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Leviathan
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_BUSTER                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_FLAME                 ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 730                        ; Saber experience
    .dh 125                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_CHARGE               ; Saber level
    .db CHAIN_CHARGE               ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x2E0                      ; Total points
    .dh 9                          ; Stages beaten
    .dh BEAT_BURBLE                ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Harpuia
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 470                        ; Saber experience
    .dh 110                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_CHARGE               ; Saber level
    .db CHAIN_CHARGE               ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x22F                      ; Total points
    .dh 7                          ; Stages beaten
    .dh BEAT_KUWAGUST              ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Fefnir
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_FLAME                 ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 800                        ; Saber experience
    .dh 140                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_CHARGE               ; Saber level
    .db CHAIN_CHARGE               ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x337                      ; Total points
    .dh 10                         ; Stages beaten
    .dh BEAT_LEVIATHAN             ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Neo Arcadia 2
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 940                        ; Saber experience
    .dh 155                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_QKCHARGE             ; Saber level
    .db CHAIN_CHARGE               ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x388                      ; Total points
    .dh 11                         ; Stages beaten
    .dh BEAT_FEFNIR                ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Neo Arcadia 1
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 270                        ; Saber experience
    .dh 4                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_3SLASH               ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x185                      ; Total points
    .dh 5                          ; Stages beaten
    .dh BEAT_HYLEG                 ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Fefnir AP
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 1120                       ; Saber experience
    .dh 160                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_QKCHARGE             ; Saber level
    .db CHAIN_CHARGE               ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x3DE                      ; Total points
    .dh 12                         ; Stages beaten
    .dh BEAT_NA2                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Leviathan AP
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 1250                       ; Saber experience
    .dh 195                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_QKCHARGE             ; Saber level
    .db CHAIN_CHARGE               ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x431                      ; Total points
    .dh 13                         ; Stages beaten
    .dh BEAT_AP1                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Harpuia AP
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_FLAME                 ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 1300                       ; Saber experience
    .dh 220                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_QKCHARGE             ; Saber level
    .db CHAIN_QKCHARGE             ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x47E                      ; Total points
    .dh 14                         ; Stages beaten
    .dh BEAT_AP2                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Final
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 1380                       ; Saber experience
    .dh 240                        ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_QKCHARGE             ; Saber level
    .db CHAIN_QKCHARGE             ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x4D7                      ; Total points
    .dh 15                         ; Stages beaten
    .dh BEAT_AP3                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Commander Room
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_RISE                  ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_RISE               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 0                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 0,0,0,0                    ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_CHAIN                  ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_TENSHOUZAN              ; Unlocked EX skills
    .dh EX_TENSHOUZAN              ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db SABER_QKCHARGE             ; Saber level
    .db CHAIN_QKCHARGE             ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0                          ; Total points
    .dh 0                          ; Stages beaten
    .dh 0                          ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Hard mode

	; Intro
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_INTRO               ; Unlocked weapons
    .db UNLCHIP_NEUTRAL            ; Unlocked chips
    .db WEP_BUSTER                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_NEUTRAL               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0                          ; Total points
    .dh 0                          ; Stages beaten
    .dh 0                          ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Hyleg
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_FLAME                 ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x147                      ; Total points
    .dh 4                          ; Stages beaten
    .dh BEAT_POLER                 ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Poler
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_FLAME              ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x105                      ; Total points
    .dh 3                          ; Stages beaten
    .dh BEAT_PHOENIX               ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Kuwagust
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x1E6                      ; Total points
    .dh 6                          ; Stages beaten
    .dh BEAT_NA1                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Phoenix
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_THUNDER            ; Unlocked chips
    .db WEP_BUSTER                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_NEUTRAL               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0xB2                       ; Total points
    .dh 2                          ; Stages beaten
    .dh BEAT_PANTER                ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Panter
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_NEUTRAL            ; Unlocked chips
    .db WEP_BUSTER                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_NEUTRAL               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x51                       ; Total points
    .dh 1                          ; Stages beaten
    .dh BEAT_INTRO                 ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Burble
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x286                      ; Total points
    .dh 8                          ; Stages beaten
    .dh BEAT_HARPUIA               ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Leviathan
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_FLAME                 ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x2E0                      ; Total points
    .dh 9                          ; Stages beaten
    .dh BEAT_BURBLE                ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Harpuia
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x22F                      ; Total points
    .dh 7                          ; Stages beaten
    .dh BEAT_KUWAGUST              ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Fefnir
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_FLAME                 ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x337                      ; Total points
    .dh 10                         ; Stages beaten
    .dh BEAT_LEVIATHAN             ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Neo Arcadia 2
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x388                      ; Total points
    .dh 11                         ; Stages beaten
    .dh BEAT_FEFNIR                ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Neo Arcadia 1
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x185                      ; Total points
    .dh 5                          ; Stages beaten
    .dh BEAT_HYLEG                 ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Fefnir AP
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0x42,0,0                   ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x3DE                      ; Total points
    .dh 12                         ; Stages beaten
    .dh BEAT_NA2                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0x4,0xC,0,0  ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0x4,0xC,0,0  ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Leviathan AP
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x431                      ; Total points
    .dh 13                         ; Stages beaten
    .dh BEAT_AP1                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Harpuia AP
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0x43,0x45,0x3A             ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_FLAME                 ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x47E                      ; Total points
    .dh 14                         ; Stages beaten
    .dh BEAT_AP2                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0x4,0x2C,0,0 ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0x4,0x28,0,0 ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Final
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 1                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 32,0,0,0                   ; Subtank contents for subtank 1-4
    .db 0x45,0x3A,0                ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_ICE                   ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0x4D7                      ; Total points
    .dh 15                         ; Stages beaten
    .dh BEAT_AP3                   ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0x4,0x2C,0,0 ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0x4,0x20,0,0 ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

	; Commander Room
    .db 0,0,0,0,0,0                ; Unknown
    .db FORM_PROTO                 ; Equipped form
    .db 0x10                       ; Max health
    .dh 0                          ; E-crystals
    .dh UNLFORM_HARD               ; Unlocked forms
    .db 0                          ; Extra health bars
    .db 0                          ; Unknown
    .db 0                          ; Subtank count
    .db 0                          ; Subtank count (elves)
    .db 0,0,0,0                    ; Subtank contents for subtank 1-4
    .db 0,0,0                      ; Equipped cyber elves 1-3
    .db 0,0,0                      ; Unknown
    .db UNLWEP_ALL                 ; Unlocked weapons
    .db UNLCHIP_ICE                ; Unlocked chips
    .db WEP_SHIELD                 ; Equipped main weapon
    .db WEP_SABER                  ; Equipped secondary weapon
    .db 0                          ; Unknown
    .db CHIP_THUNDER               ; Equipped chip
    .dh EX_NONE                    ; Unlocked EX skills
    .dh EX_NONE                    ; Equipped EX skills
    .dh 0                          ; Buster experience
    .dh 0                          ; Saber experience
    .dh 0                          ; Chain Rod experience
    .dh 0                          ; Shield Boomerang experience
    .db 0                          ; Buster level
    .db 0                          ; Saber level
    .db 0                          ; Chain Rod level
    .db 0                          ; Shield Boomerang level
    .dh 0                          ; Total points
    .dh 0                          ; Stages beaten
    .dh 0                          ; Specific stages beaten
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves obtained
	.db 0,0,0,0,0,0,0,0,0,0,0      ; Cyber elves used
	.db 0xFF,0xFF,0xFF,0xFF        ; Extra bytes to align configuration

    .endarea
