    .gba
    
    ; Elf availability
    ELF_EXISTS equ 1
    ELF_USED equ 3
    ELF_FED_S equ 5
    ELF_FED_F1 equ 9
    ELF_FED_F2 equ 0x11
    
    ; Equipped cyber elf
    ELF_NONE equ 0xFF
    ELF_CLOKKLE equ 0x34
    ELF_BIRAID equ 0x20
    
    ; Subtank existence
    SUBT_NONE equ 0xFF
    
    ; Equipped weapon
    WEP_BUSTER equ 0
    WEP_SABER equ 1
    WEP_RECOIL equ 2
    WEP_SHIELD equ 3
    
    ; Unlocked weapons
    UNLWEP_INTRO equ 3
    UNLWEP_ALL equ 0xF
	
	; Equipped element
	ELEM_NEUTRAL equ 0
	ELEM_THUNDER equ 1
	ELEM_FLAME equ 2
	ELEM_ICE equ 3
    
    ; Equipped head chip
    HEAD_NEUTRAL equ 0
    HEAD_AUTORECOVER equ 1
    HEAD_AUTOCHARGE equ 2
    HEAD_QKCHARGE equ 3
    
    ; Unlocked head chips
    UNLHEAD_NEUTRAL equ 1
    UNLHEAD_AUTORECOVER equ 2
    UNLHEAD_AUTOCHARGE equ 4
    UNLHEAD_QKCHARGE equ 8
    
    ; Equipped body chip
    BODY_NEUTRAL equ 0
    BODY_LIGHT equ 1
    BODY_ABSORBER equ 2
    BODY_THUNDER equ 3
    BODY_FLAME equ 4
    BODY_ICE equ 5
    
    ; Unlocked body chips
    UNLBODY_NEUTRAL equ 1
    UNLBODY_LIGHT equ 2
    UNLBODY_ABSORBER equ 4
    UNLBODY_THUNDER equ 8
    UNLBODY_FLAME equ 0x10
    UNLBODY_ICE equ 0x20
	UNLBODY_ALL equ 0x3F
    
    UNLBODY_FLIZARD equ UNLBODY_NEUTRAL + UNLBODY_THUNDER
    UNLBODY_MANTISK equ UNLBODY_NEUTRAL	+ UNLBODY_THUNDER + UNLBODY_FLAME
    UNLBODY_CHILDRE equ UNLBODY_NEUTRAL	+ UNLBODY_THUNDER + UNLBODY_FLAME + UNLBODY_LIGHT
    UNLBODY_BABY1 equ UNLBODY_NEUTRAL + UNLBODY_THUNDER + UNLBODY_FLAME + UNLBODY_LIGHT + UNLBODY_ICE
    
    ; Equipped foot chip
    FOOT_NEUTRAL equ 0
	FOOT_SPLASHJUMP equ 1
    FOOT_DBLJUMP equ 2
	FOOT_SHADOW equ 3
    FOOT_QUICK equ 4
	FOOT_SPIKE equ 5
	FOOT_FROG equ 6
	FOOT_ULTIMA equ 7
    
    ; Unlocked foot chips
    UNLFOOT_NEUTRAL equ 1
    UNLFOOT_SPLASHJUMP equ 2
    UNLFOOT_DBLJUMP equ 4
    UNLFOOT_SHADOW equ 8
    UNLFOOT_QUICK equ 0x10
    UNLFOOT_SPIKE equ 0x20
    UNLFOOT_FROG equ 0x40
    UNLFOOT_ULTIMA equ 0x80
    
    UNLFOOT_CACTANK equ UNLFOOT_NEUTRAL + UNLFOOT_QUICK
    UNLFOOT_FOXTAR equ UNLFOOT_NEUTRAL + UNLFOOT_QUICK + UNLFOOT_SPIKE
    UNLFOOT_KELVERIAN equ UNLFOOT_NEUTRAL + UNLFOOT_QUICK + UNLFOOT_SPIKE + UNLFOOT_DBLJUMP
    UNLFOOT_BABY2 equ UNLFOOT_NEUTRAL + UNLFOOT_QUICK + UNLFOOT_SPIKE + UNLFOOT_DBLJUMP + UNLFOOT_SHADOW
    
    ; EX skills
    EX_LASER equ 1
    EX_VSHOT equ 2
    EX_BURST equ 4
    EX_BLIZZ equ 8
    EX_GALE equ 0x10
    EX_SMASH equ 0x20
    EX_SPLIT equ 0x40
    EX_THROW equ 0x80
    EX_1000 equ 0x100
    EX_SOUL equ 0x200
    EX_SWEEP equ 0x400
    EX_ORBIT equ 0x800
	EX_ALL equ 0xFFF
    
    UNLEX_MANTISK equ EX_SMASH + EX_BURST
    UNLEX_CHILDRE equ EX_SMASH + EX_BURST + EX_1000
    UNLEX_BABY1 equ EX_SMASH + EX_BURST + EX_1000 + EX_THROW
    UNLEX_HANUMACHINE equ EX_SMASH + EX_BURST + EX_1000 + EX_THROW + EX_BLIZZ
    UNLEX_ANUBIS equ EX_SMASH + EX_BURST + EX_1000 + EX_THROW + EX_BLIZZ + EX_SPLIT
    UNLEX_COPYX equ EX_SMASH + EX_BURST + EX_1000 + EX_THROW + EX_BLIZZ + EX_SPLIT + EX_SWEEP
    UNLEX_CACTANK equ EX_SMASH + EX_BURST + EX_1000 + EX_THROW + EX_BLIZZ + EX_SPLIT + EX_SWEEP + EX_LASER
    UNLEX_FOXTAR equ EX_SMASH + EX_BURST + EX_1000 + EX_THROW + EX_BLIZZ + EX_SPLIT + EX_SWEEP + EX_LASER + EX_ORBIT
    UNLEX_KELVERIAN equ EX_SMASH + EX_BURST + EX_1000 + EX_THROW + EX_BLIZZ + EX_SPLIT + EX_SWEEP + EX_LASER + EX_ORBIT + EX_SOUL
    UNLEX_VOLTEEL equ EX_SMASH + EX_BURST + EX_1000 + EX_THROW + EX_BLIZZ + EX_SPLIT + EX_SWEEP + EX_LASER + EX_ORBIT + EX_SOUL + EX_GALE
    
	; 2 + 26 bytes per stage
	.org REG_STAGE_SELECT_CFG
    .area REG_STAGE_SELECT_CFG_AREA
	
    ; Intro
    INDEX_INTRO equ 0
    
    .db 0							; Biraid status
    .db 0							; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_NONE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_NEUTRAL				; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh 0							; Equipped EX skills
	.dh 0							; Unlocked EX skills
	.db UNLWEP_INTRO				; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_NEUTRAL				; Unlocked body chips
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
    
	; Flizard
    INDEX_FLIZARD equ (INDEX_INTRO+1)
	
	.db ELF_EXISTS					; Biraid status
    .db 0							; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_NONE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 150							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_NEUTRAL				; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh 0							; Equipped EX skills
	.dh EX_SMASH					; Unlocked EX skills
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_FLIZARD             ; Unlocked body chips
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
    
	; Childre
    INDEX_CHILDRE equ (INDEX_FLIZARD+1)
    
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_FLAME					; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_FLAME					; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH					; Equipped EX skills
	.dh UNLEX_CHILDRE
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_CHILDRE
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
    
	; Hellbat
    INDEX_HELLBAT equ (INDEX_CHILDRE+1)
	
	.db 0							; Biraid status
    .db 0							; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_NONE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 40							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_NEUTRAL				; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh 0							; Equipped EX skills
	.dh 0							; Unlocked EX skills
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_NEUTRAL				; Unlocked body chips
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
	
	; Mantisk
    INDEX_MANTISK equ (INDEX_HELLBAT+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_EXISTS					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_NONE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 200							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_THUNDER				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_THUNDER				; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH					; Equipped EX skills
	.dh UNLEX_MANTISK
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_MANTISK
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
	
	
	; Baby Elves 1
    INDEX_BABY1 equ (INDEX_MANTISK+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_FLAME					; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_FLAME					; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000          ; Equipped EX skills
	.dh UNLEX_BABY1
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
	
	; Anubis
    INDEX_ANUBIS equ (INDEX_BABY1+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_THUNDER				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_THUNDER				; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000
	.dh UNLEX_ANUBIS
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
	
	; Hanumachine
    INDEX_HANUMACHINE equ (INDEX_ANUBIS+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_FLAME					; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_FLAME					; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000
	.dh UNLEX_HANUMACHINE
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
	
	; Blizzack
    INDEX_BLIZZACK equ (INDEX_HANUMACHINE+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_FLAME					; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_FLAME					; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000          ; Equipped EX skills
	.dh UNLEX_BABY1
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
	
	; Copy X
    INDEX_COPYX equ (INDEX_BLIZZACK+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_ICE					; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_ICE					; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT
	.dh UNLEX_COPYX
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
	
	; Foxtar
    INDEX_FOXTAR equ (INDEX_COPYX+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_BIRAID					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_LIGHT					; Body chip
	.db FOOT_QUICK					; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT + EX_LASER
	.dh UNLEX_FOXTAR
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL + UNLHEAD_QKCHARGE
	.db UNLBODY_BABY1
	.db UNLFOOT_FOXTAR
	
	; le Cactank
    INDEX_CACTANK equ (INDEX_FOXTAR+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_FLAME					; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_FLAME					; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT
	.dh UNLEX_CACTANK
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_CACTANK
	
	; Volteel
    INDEX_VOLTEEL equ (INDEX_CACTANK+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_BIRAID					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_QKCHARGE				; Head chip
	.db BODY_NEUTRAL				; Body chip
	.db FOOT_DBLJUMP				; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT + EX_LASER
	.dh UNLEX_VOLTEEL
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL + UNLHEAD_QKCHARGE
	.db UNLBODY_ALL					; Unlocked body chips
	.db UNLFOOT_KELVERIAN
	
	; Kelverian
    INDEX_KELVERIAN equ (INDEX_VOLTEEL+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_BIRAID					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_LIGHT					; Body chip
	.db FOOT_QUICK					; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT + EX_LASER
	.dh UNLEX_KELVERIAN
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL + UNLHEAD_QKCHARGE
	.db UNLBODY_BABY1
	.db UNLFOOT_KELVERIAN
	
	; Baby Elves 2
    INDEX_BABY2 equ (INDEX_KELVERIAN+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_BIRAID					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_QKCHARGE				; Head chip
	.db BODY_NEUTRAL				; Body chip
	.db FOOT_DBLJUMP				; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT + EX_LASER + EX_GALE
	.dh EX_ALL						; Unlocked EX skills
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL + UNLHEAD_QKCHARGE
	.db UNLBODY_ALL					; Unlocked body chips
	.db UNLFOOT_BABY2
	
	; Final
    INDEX_FINAL equ (INDEX_BABY2+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_BIRAID					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_QKCHARGE				; Head chip
	.db BODY_NEUTRAL				; Body chip
	.db FOOT_DBLJUMP				; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT + EX_LASER + EX_GALE
	.dh EX_ALL						; Unlocked EX skills
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL + UNLHEAD_QKCHARGE
	.db UNLBODY_ALL					; Unlocked body chips
	.db UNLFOOT_BABY2
    
    ; Hanumachine 1st
    INDEX_HANUMACHINE_ALT1 equ (INDEX_FINAL+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_FLAME					; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_FLAME					; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000
	.dh UNLEX_BABY1
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
    
	; Blizzack 2nd
    INDEX_BLIZZACK_ALT1 equ (INDEX_HANUMACHINE_ALT1+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_THUNDER				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_THUNDER				; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000          ; Equipped EX skills
	.dh UNLEX_BABY1 + EX_SPLIT
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
    
    ; Anubis with Hanumachine 1st
    INDEX_ANUBIS_ALT1 equ (INDEX_BLIZZACK_ALT1+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_NONE					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_FLAME				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_FLAME				; Body chip
	.db FOOT_NEUTRAL				; Foot chip
	.dh EX_SMASH + EX_1000 + EX_SPLIT
	.dh UNLEX_ANUBIS
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL				; Unlocked head chips
	.db UNLBODY_BABY1
	.db UNLFOOT_NEUTRAL				; Unlocked foot chips
    
    ; Foxtar without laser
    INDEX_FOXTAR_ALT1 equ (INDEX_ANUBIS_ALT1+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_BIRAID					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_LIGHT					; Body chip
	.db FOOT_QUICK					; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT
	.dh UNLEX_FOXTAR
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL + UNLHEAD_QKCHARGE
	.db UNLBODY_BABY1
	.db UNLFOOT_FOXTAR
    
    ; Volteel without laser
    INDEX_VOLTEEL_ALT1 equ (INDEX_FOXTAR_ALT1+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_BIRAID					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_RECOIL					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_QKCHARGE				; Head chip
	.db BODY_NEUTRAL				; Body chip
	.db FOOT_DBLJUMP				; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT
	.dh UNLEX_VOLTEEL
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL + UNLHEAD_QKCHARGE
	.db UNLBODY_ALL					; Unlocked body chips
	.db UNLFOOT_KELVERIAN
	
	; Kelverian without laser
    INDEX_KELVERIAN_ALT1 equ (INDEX_VOLTEEL_ALT1+1)
	
	.db ELF_EXISTS					; Biraid status
    .db ELF_FED_S					; Clokkle status
	
	.db ELF_BIRAID					; Elf 1
	.db ELF_CLOKKLE					; Elf 2
	.db 0,0,0,0						; Unknown
	.dh 0							; E-crystals
	.db 32,SUBT_NONE,SUBT_NONE,SUBT_NONE					; Subtank contents
	.db WEP_BUSTER					; Main weapon
	.db WEP_SABER					; Sub weapon
	.db ELEM_NEUTRAL				; Element
	.db HEAD_NEUTRAL				; Head chip
	.db BODY_LIGHT					; Body chip
	.db FOOT_QUICK					; Foot chip
	.dh EX_SMASH + EX_1000 + EX_BLIZZ + EX_SPLIT
	.dh UNLEX_KELVERIAN
	.db UNLWEP_ALL					; Unlocked weapons
	.db UNLHEAD_NEUTRAL + UNLHEAD_QKCHARGE
	.db UNLBODY_BABY1
	.db UNLFOOT_KELVERIAN
    
    .endarea
    
    .org REG_STAGE_SETTING_POINTERS
    .area REG_STAGE_SETTING_POINTERS_AREA
    
    ; Route 1
    
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_INTRO)       ; Intro
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_FLIZARD)     ; Flizard
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_CHILDRE)     ; Childre
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_HELLBAT)     ; Hellbat
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_MANTISK)     ; Mantisk
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_BABY1)       ; Baby Elves 1
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_ANUBIS)      ; Anubis
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_HANUMACHINE) ; Hanumachine
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_BLIZZACK)    ; Blizzack
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_COPYX)       ; Copy X
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_FOXTAR)      ; Foxtar
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_CACTANK)     ; Cactank
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_VOLTEEL)     ; Volteel
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_KELVERIAN)   ; Kelverian
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_BABY2)       ; Baby Elves 2
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_FINAL)       ; Final
    
    ; Route 2
    
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_INTRO)       ; Intro
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_FLIZARD)     ; Flizard
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_CHILDRE)     ; Childre
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_HELLBAT)     ; Hellbat
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_MANTISK)     ; Mantisk
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_BABY1)       ; Baby Elves 1
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_ANUBIS_ALT1)         ; Anubis
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_HANUMACHINE_ALT1)    ; Hanumachine
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_BLIZZACK_ALT1)       ; Blizzack
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_COPYX)       ; Copy X
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_FOXTAR_ALT1)         ; Foxtar
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_CACTANK)     ; Cactank
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_VOLTEEL_ALT1)        ; Volteel
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_KELVERIAN_ALT1)      ; Kelverian
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_BABY2)       ; Baby Elves 2
    .dw REG_STAGE_SELECT_CFG+(0x1C*INDEX_FINAL)       ; Final
    
    ; Route 3 (custom)
    
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_INTRO)       ; Intro
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_FLIZARD)     ; Flizard
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_CHILDRE)     ; Childre
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_HELLBAT)     ; Hellbat
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_MANTISK)     ; Mantisk
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_BABY1)       ; Baby Elves 1
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_ANUBIS)      ; Anubis
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_HANUMACHINE) ; Hanumachine
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_BLIZZACK)    ; Blizzack
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_COPYX)       ; Copy X
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_FOXTAR)      ; Foxtar
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_CACTANK)     ; Cactank
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_VOLTEEL)     ; Volteel
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_KELVERIAN)   ; Kelverian
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_BABY2)       ; Baby Elves 2
    .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(0x1C*INDEX_FINAL)       ; Final
    
    .endarea