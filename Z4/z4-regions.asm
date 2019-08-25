    .gba
    
    REG_GAME_STATE_ROUTINES equ 0x08882440
    REG_GAME_STATE_ROUTINES_AREA equ 0x100
    REG_MAIN equ REG_GAME_STATE_ROUTINES + REG_GAME_STATE_ROUTINES_AREA
    REG_MAIN_AREA equ 0x200
    REG_TIMER equ REG_MAIN + REG_MAIN_AREA
    REG_TIMER_AREA equ 0x200
    REG_TIMER_TABLE equ REG_TIMER + REG_TIMER_AREA
    REG_TIMER_TABLE_AREA equ 0xF0
    REG_CHECKPOINTS equ REG_TIMER_TABLE + REG_TIMER_TABLE_AREA
    REG_CHECKPOINTS_AREA equ 0x700
    REG_CHECKPOINTS_INSTR_AREA equ 0x300
    REG_CHECKPOINTS_CURRENT equ REG_CHECKPOINTS + REG_CHECKPOINTS_INSTR_AREA
    REG_CHECKPOINTS_CURRENT_AREA equ 0x100
    REG_CHECKPOINTS_PREV equ REG_CHECKPOINTS_CURRENT + REG_CHECKPOINTS_CURRENT_AREA
    REG_CHECKPOINTS_PREV_AREA equ 0x100
    REG_CHECKPOINTS_NEXT equ REG_CHECKPOINTS_PREV + REG_CHECKPOINTS_PREV_AREA
    REG_CHECKPOINTS_NEXT_AREA equ 0x100
    REG_CHECKPOINTS_MINIBOSS equ REG_CHECKPOINTS_NEXT + REG_CHECKPOINTS_NEXT_AREA
    REG_CHECKPOINTS_MINIBOSS_AREA equ 0x10
    REG_CHECKPOINTS_CROSS_BLOCKS equ REG_CHECKPOINTS_MINIBOSS + REG_CHECKPOINTS_MINIBOSS_AREA
    REG_CHECKPOINTS_CROSS_BLOCKS_AREA equ 0x100
    REG_STAGE_SELECT_ENTRIES equ REG_CHECKPOINTS_CROSS_BLOCKS + REG_CHECKPOINTS_CROSS_BLOCKS_AREA
    REG_STAGE_SELECT_ENTRIES_AREA equ 0x200
    REG_STAGE_SELECT_MENU equ REG_STAGE_SELECT_ENTRIES + REG_STAGE_SELECT_ENTRIES_AREA
    REG_STAGE_SELECT_MENU_AREA equ 0x400
    REG_STAGE_SELECT_DISPLAY equ REG_STAGE_SELECT_MENU + REG_STAGE_SELECT_MENU_AREA
    REG_STAGE_SELECT_DISPLAY_AREA equ 0x200
    REG_STAGE_SELECT_ROUTES equ REG_STAGE_SELECT_DISPLAY + REG_STAGE_SELECT_DISPLAY_AREA
    REG_STAGE_SELECT_ROUTES_AREA equ 0x100
    REG_STAGE_SELECT_ROUTE_NAMES equ REG_STAGE_SELECT_ROUTES + REG_STAGE_SELECT_ROUTES_AREA
    REG_STAGE_SELECT_ROUTE_NAMES_AREA equ 0xFE
    REG_STAGE_SELECT_CFG equ REG_STAGE_SELECT_ROUTE_NAMES + REG_STAGE_SELECT_ROUTE_NAMES_AREA
    REG_STAGE_SELECT_CFG_AREA equ 0x502
    REG_STAGE_SETTING_POINTERS equ REG_STAGE_SELECT_CFG + REG_STAGE_SELECT_CFG_AREA
    REG_STAGE_SETTING_POINTERS_AREA equ 0x100
    REG_STAGE_SETTING_WEATHER equ REG_STAGE_SETTING_POINTERS + REG_STAGE_SETTING_POINTERS_AREA
    REG_STAGE_SETTING_WEATHER_AREA equ 0x20