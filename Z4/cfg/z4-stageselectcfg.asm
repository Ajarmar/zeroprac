    .gba
    
    SETTINGS_SIZE equ 36
    
    ; Subtank existence
    SUBT_NONE equ 0xFF
    
    ; Equipped weapon
    WEP_BUSTER equ 0
    WEP_SABER equ 1
    WEP_KNUCKLE equ 2
    
    CHIP_NONE equ 0xFF
    
    UNLFOOT_DBLJUMP equ 0x00002200
    
    FOOT_DBLJUMP equ 0x15
    
    EX_TIMESTOPPER equ 0x1
    EX_TRACTORSHOT equ 0x2
    EX_BURNINGSHOT equ 0x4
    EX_ICEJAVELIN equ 0x8
    EX_SKYCHASER equ 0x10
    EX_THUNDERSTAB equ 0x20
    EX_FLAMEFANG equ 0x40
    EX_ICEBLADE equ 0x80
    
    UNLEX_MANDRAGO equ EX_TIMESTOPPER
    UNLEX_GENBLEM equ EX_TIMESTOPPER + EX_SKYCHASER
    UNLEX_FENRI equ EX_TIMESTOPPER + EX_SKYCHASER + EX_FLAMEFANG
    UNLEX_INTERMISSION equ EX_TIMESTOPPER + EX_SKYCHASER + EX_FLAMEFANG + EX_ICEBLADE
    UNLEX_PEGASOLTA equ EX_TIMESTOPPER + EX_SKYCHASER + EX_FLAMEFANG + EX_ICEBLADE + EX_ICEJAVELIN
    UNLEX_FINAL equ EX_TIMESTOPPER + EX_SKYCHASER + EX_FLAMEFANG + EX_ICEBLADE + EX_ICEJAVELIN + EX_TRACTORSHOT
    
    EQUEX_GENBLEM equ EX_TIMESTOPPER
    EQUEX_FENRI equ EX_TIMESTOPPER + EX_SKYCHASER
    EQUEX_CRAFT1 equ EX_TIMESTOPPER + EX_SKYCHASER + EX_FLAMEFANG
    EQUEX_HELL equ EX_SKYCHASER + EX_FLAMEFANG + EX_ICEBLADE
    EQUEX_PEGASOLTA equ EX_TIMESTOPPER + EX_SKYCHASER + EX_FLAMEFANG + EX_ICEBLADE
    EQUEX_FINAL equ EX_SKYCHASER + EX_FLAMEFANG + EX_ICEBLADE + EX_ICEJAVELIN
    
    UNLEX_J_GENBLEM equ EX_TIMESTOPPER
    UNLEX_J_FENRI equ EX_TIMESTOPPER + EX_FLAMEFANG
    UNLEX_J_TITANION equ EX_TIMESTOPPER + EX_FLAMEFANG + EX_ICEBLADE
    UNLEX_J_KRAKEN equ EX_TIMESTOPPER + EX_FLAMEFANG + EX_ICEBLADE + EX_SKYCHASER
    UNLEX_J_PEGASOLTA equ EX_TIMESTOPPER + EX_FLAMEFANG + EX_ICEBLADE + EX_SKYCHASER + EX_ICEJAVELIN
    UNLEX_J_FINAL equ EX_TIMESTOPPER + EX_FLAMEFANG + EX_ICEBLADE + EX_SKYCHASER + EX_ICEJAVELIN + EX_TRACTORSHOT
    
    EQUEX_J_FENRI equ EX_TIMESTOPPER
    EQUEX_J_TITANION equ EX_TIMESTOPPER + EX_FLAMEFANG
    EQUEX_J_JAIL equ EX_FLAMEFANG + EX_ICEBLADE
    EQUEX_J_KRAKEN equ EX_TIMESTOPPER + EX_FLAMEFANG + EX_ICEBLADE
    EQUEX_J_PEGASOLTA equ EX_TIMESTOPPER + EX_FLAMEFANG + EX_ICEBLADE + EX_SKYCHASER
    EQUEX_J_MINO equ EX_FLAMEFANG + EX_ICEBLADE + EX_SKYCHASER + EX_ICEJAVELIN
    
    
    ELF_NONE equ 0xFF
    ELF_CROIRE equ 0x3
    
    ; Halfword aligned, but not word aligned - put weather somewhere else
    ; Somehow solve parts for junk route
    ; 36 bytes total
    
    ; Part data structure:
    ; POINTER -> SECTION_SIZE (1byte), ENTRY (2byte), ENTRY, ..., ENTRY, SECTION_SIZE, ENTRY ...
    ; POINTER: Static pointer, same for all within a route
    ; SECTION_SIZE: Provided from stage select cfg, corresponds to amount of different parts (entries)
    ; ENTRY: Part index (1byte), count (1byte)
    ; Algorithm: get(route_index,stage_index)
    ; offset = mul route_index, 4
    ; pointer = add base_addr, offset
    ; i = 0
    ; while i != stage_index
    ;   size = ldrb pointer
    ;   pointer = add pointer, 1
    ;   skip = mul size, 2
    ;   pointer = add pointer, skip
    ; end while
    ; relevant_size = ldrb pointer
    ; pointer = add pointer, 1
    ; j = 0
    ; while j < relevant_size
    ;   part_index = ldrb pointer
    ;   part_count = ldrb pointer,1
    ;   store at a good location
    ;   pointer = add pointer, 2
    ; end while
    
    .org REG_STAGE_SELECT_CFG
    .area REG_STAGE_SELECT_CFG_AREA
    
    ; Intro
    INDEX_INTRO equ 0
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     0                               ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_BUSTER                      ; Main weapon
    .db     WEP_KNUCKLE                     ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,CHIP_NONE   ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     0                               ; Equipped EX skills
    .dh     0                               ; Unlocked EX skills
    
    .db     0                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     0                               ; Cyber elf capacity
    .db     0xFF                            ; Cyber elf name
    
    ; Intro 2
    INDEX_INTRO2 equ (INDEX_INTRO+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     0                               ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,CHIP_NONE   ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     0                               ; Equipped EX skills
    .dh     0                               ; Unlocked EX skills
    
    .db     0                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     0                               ; Cyber elf capacity
    .db     0xFF                            ; Cyber elf name
    
    INDEX_GENBLEM equ (INDEX_INTRO2+1)
    .db     0                               ; Gangagun parts
    .db     1                               ; C-Hopper parts
    .db     1                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     0                               ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,CHIP_NONE   ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_GENBLEM                   ; Equipped EX skills
    .dh     UNLEX_GENBLEM                   ; Unlocked EX skills
    
    .db     2                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     2                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_KRAKEN equ (INDEX_GENBLEM+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_HELL                      ; Equipped EX skills
    .dh     UNLEX_INTERMISSION              ; Unlocked EX skills
    
    .db     5                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     5                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_PEGASOLTA equ (INDEX_KRAKEN+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_BUSTER                      ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_PEGASOLTA                 ; Equipped EX skills
    .dh     UNLEX_PEGASOLTA                 ; Unlocked EX skills
    
    .db     6                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     6                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_MANDRAGO equ (INDEX_PEGASOLTA+1)
    .db     0                               ; Gangagun parts
    .db     1                               ; C-Hopper parts
    .db     1                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     0                               ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,CHIP_NONE   ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     0                               ; Equipped EX skills
    .dh     UNLEX_MANDRAGO                  ; Unlocked EX skills
    
    .db     1                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     1                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_TITANION equ (INDEX_MANDRAGO+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_HELL                      ; Equipped EX skills
    .dh     UNLEX_INTERMISSION              ; Unlocked EX skills
    
    .db     4                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     4                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_FENRI equ (INDEX_TITANION+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,CHIP_NONE   ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_FENRI                     ; Equipped EX skills
    .dh     UNLEX_FENRI                     ; Unlocked EX skills
    
    .db     3                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     3                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_MINO equ (INDEX_FENRI+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_BUSTER                      ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_FINAL                     ; Equipped EX skills
    .dh     UNLEX_PEGASOLTA                 ; Unlocked EX skills
    
    .db     7                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     7                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_POPLA equ (INDEX_MINO+1)
    .db     0                               ; Gangagun parts
    .db     1                               ; C-Hopper parts
    .db     1                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     0                               ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,CHIP_NONE   ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     0                               ; Equipped EX skills
    .dh     0                               ; Unlocked EX skills
    
    .db     0                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     0                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_CRAFT1 equ (INDEX_POPLA+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_CRAFT1                    ; Equipped EX skills
    .dh     UNLEX_INTERMISSION              ; Unlocked EX skills
    
    .db     4                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     4                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_HELL equ (INDEX_CRAFT1+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_BUSTER                      ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_HELL                      ; Equipped EX skills
    .dh     UNLEX_INTERMISSION              ; Unlocked EX skills
    
    .db     4                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     4                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_CRAFT2 equ (INDEX_HELL+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_BUSTER                      ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_FINAL                     ; Equipped EX skills
    .dh     UNLEX_FINAL                     ; Unlocked EX skills
    
    .db     7                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     7                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_RANDAM equ (INDEX_CRAFT2+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_FINAL                     ; Equipped EX skills
    .dh     UNLEX_FINAL                     ; Unlocked EX skills
    
    .db     7                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     7                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_CYBALL equ (INDEX_RANDAM+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_FINAL                     ; Equipped EX skills
    .dh     UNLEX_FINAL                     ; Unlocked EX skills
    
    .db     7                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     7                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    INDEX_FINAL equ (INDEX_CYBALL+1)
    .db     0                               ; Gangagun parts
    .db     0                               ; C-Hopper parts
    .db     0                               ; Gyro Cannon H parts
    .db     0                               ; Faital parts
    .dw     0                               ; Unlocked chips, part 1
    .dw     UNLFOOT_DBLJUMP                 ; Unlocked chips, part 2
    
    .dh     0                               ; E-crystals
    .db     32,32,SUBT_NONE,SUBT_NONE       ; Subtanks
    .db     WEP_KNUCKLE                     ; Main weapon
    .db     WEP_SABER                       ; Sub weapon
    .dh     0                               ; Knuckle equipment things
    .db     CHIP_NONE,CHIP_NONE,FOOT_DBLJUMP  ; Equipped chips
    .db     0                               ; Hard/ultimate mode flag
    .dh     EQUEX_FINAL                     ; Equipped EX skills
    .dh     UNLEX_FINAL                     ; Unlocked EX skills
    
    .db     7                               ; Cyber elf level
    .db     0                               ; Nurse level
    .db     0                               ; Animal level
    .db     0                               ; Hacker level
    .db     7                               ; Cyber elf capacity
    .db     ELF_CROIRE                      ; Cyber elf name
    
    .endarea
    
    .org REG_STAGE_SETTING_POINTERS
    .area REG_STAGE_SETTING_POINTERS_AREA
    
    ; Pointers in stage index order
    
    ; Route 1
    
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_INTRO)    
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_INTRO2)   
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_GENBLEM)  
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_KRAKEN)   
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_PEGASOLTA)
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_MANDRAGO) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_TITANION)
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_FENRI) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_MINO)  
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_POPLA) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_CRAFT1)
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_HELL)
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_CRAFT2)
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_RANDAM)
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_CYBALL)
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_FINAL)
    
    ; Route 2
    
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_INTRO)    
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_INTRO2)   
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_GENBLEM)  
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_KRAKEN)   
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_PEGASOLTA)
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_MANDRAGO) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_TITANION) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_FENRI) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_MINO)  
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_POPLA) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_CRAFT1) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_HELL)   
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_CRAFT2) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_RANDAM) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_CYBALL) 
    .dw REG_STAGE_SELECT_CFG+(SETTINGS_SIZE*INDEX_FINAL)  
    
    ; Route 3 (custom)
    
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_INTRO)       ; Intro
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_FLIZARD)     ; Flizard
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_CHILDRE)     ; Childre
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_HELLBAT)     ; Hellbat
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_MANTISK)     ; Mantisk
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_BABY1)       ; Baby Elves 1
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_ANUBIS)      ; Anubis
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_HANUMACHINE) ; Hanumachine
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_BLIZZACK)    ; Blizzack
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_COPYX)       ; Copy X
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_FOXTAR)      ; Foxtar
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_CACTANK)     ; Cactank
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_VOLTEEL)     ; Volteel
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_KELVERIAN)   ; Kelverian
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_BABY2)       ; Baby Elves 2
    ; .dw ADDR_STORED_CUSTOM_ROUTE_CFG+(SETTINGS_SIZE*INDEX_FINAL)       ; Final
    
    .endarea