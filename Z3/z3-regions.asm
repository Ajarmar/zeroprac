    .gba
    
    REG_GAME_STATE_ROUTINES equ 0x08386BE0
    REG_GAME_STATE_ROUTINES_AREA equ 0x90
    REG_STAGE_SELECT_ENTRIES equ REG_GAME_STATE_ROUTINES + REG_GAME_STATE_ROUTINES_AREA
    REG_STAGE_SELECT_ENTRIES_AREA equ 0x190
    REG_STAGE_SELECT_MENU equ REG_STAGE_SELECT_ENTRIES + REG_STAGE_SELECT_ENTRIES_AREA
    REG_STAGE_SELECT_MENU_AREA equ 0x300
    REG_STAGE_SELECT_DISPLAY equ REG_STAGE_SELECT_MENU + REG_STAGE_SELECT_MENU_AREA
    REG_STAGE_SELECT_DISPLAY_AREA equ 0x100
    REG_MAIN equ REG_STAGE_SELECT_DISPLAY + REG_STAGE_SELECT_DISPLAY_AREA
    REG_MAIN_AREA equ 0x2FE
    REG_STAGE_SELECT_CFG equ REG_MAIN + REG_MAIN_AREA ; Should be halfword aligned, but not word aligned
    REG_STAGE_SELECT_CFG_AREA equ 0x502
    REG_CHECKPOINTS equ REG_STAGE_SELECT_CFG + REG_STAGE_SELECT_CFG_AREA
    REG_CHECKPOINTS_AREA equ 0x1600
    REG_CHECKPOINTS_INSTR_AREA equ 0x200
    REG_CHECKPOINTS_CURRENT equ REG_CHECKPOINTS + REG_CHECKPOINTS_INSTR_AREA
    REG_CHECKPOINTS_CURRENT_AREA equ 0x100
    REG_CHECKPOINTS_PREV equ REG_CHECKPOINTS_CURRENT + REG_CHECKPOINTS_CURRENT_AREA
    REG_CHECKPOINTS_PREV_AREA equ 0x100
    REG_CHECKPOINTS_NEXT equ REG_CHECKPOINTS_PREV + REG_CHECKPOINTS_PREV_AREA
    REG_CHECKPOINTS_NEXT_AREA equ 0x100
    REG_CHECKPOINTS_MINIBOSS equ REG_CHECKPOINTS_NEXT + REG_CHECKPOINTS_NEXT_AREA
    REG_TIMER equ REG_CHECKPOINTS + REG_CHECKPOINTS_AREA
    REG_TIMER_AREA equ 0x200
    REG_TIMER_TABLE equ REG_TIMER + REG_TIMER_AREA
    REG_TIMER_TABLE_AREA equ 0xF0
    REG_STAGE_SELECT_ROUTES equ REG_TIMER_TABLE + REG_TIMER_TABLE_AREA
    REG_STAGE_SELECT_ROUTES_AREA equ 0x60
    REG_STAGE_SELECT_ROUTE_NAMES equ REG_STAGE_SELECT_ROUTES + REG_STAGE_SELECT_ROUTES_AREA
    REG_STAGE_SELECT_ROUTE_NAMES_AREA equ 0xA0
    REG_STAGE_SETTING_POINTERS equ REG_STAGE_SELECT_ROUTE_NAMES + REG_STAGE_SELECT_ROUTE_NAMES_AREA
    REG_STAGE_SETTING_POINTERS_AREA equ 0x100
    REG_CUSTOM_ROUTE_MENU_ENTRIES equ REG_STAGE_SETTING_POINTERS + REG_STAGE_SETTING_POINTERS_AREA
    REG_CUSTOM_ROUTE_MENU_ENTRIES_AREA equ 0x190
    REG_CUSTOM_ROUTE_MENU equ REG_CUSTOM_ROUTE_MENU_ENTRIES + REG_CUSTOM_ROUTE_MENU_ENTRIES_AREA
    REG_CUSTOM_ROUTE_MENU_AREA equ 0x300
    REG_CUSTOM_ROUTE_MENU_LV2 equ REG_CUSTOM_ROUTE_MENU + REG_CUSTOM_ROUTE_MENU_AREA
    REG_CUSTOM_ROUTE_MENU_LV2_AREA equ 0x200
    REG_CUSTOM_ROUTE_MENU_LV3 equ REG_CUSTOM_ROUTE_MENU_LV2 + REG_CUSTOM_ROUTE_MENU_LV2_AREA
    REG_CUSTOM_ROUTE_MENU_LV3_AREA equ 0x200
    REG_CUSTOM_ROUTE_MENU_LV3_DETAILS equ REG_CUSTOM_ROUTE_MENU_LV3 + REG_CUSTOM_ROUTE_MENU_LV3_AREA
    REG_CUSTOM_ROUTE_MENU_LV3_DETAILS_AREA equ 0x20
    REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES equ REG_CUSTOM_ROUTE_MENU_LV3_DETAILS + REG_CUSTOM_ROUTE_MENU_LV3_DETAILS_AREA
    REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES_AREA equ 0x100
    REG_CUSTOM_ROUTE_MENU_LV4 equ REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES + REG_CUSTOM_ROUTE_MENU_LV3_ENTRIES_AREA
    REG_CUSTOM_ROUTE_MENU_LV4_AREA equ 0x400
    REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES equ REG_CUSTOM_ROUTE_MENU_LV4 + REG_CUSTOM_ROUTE_MENU_LV4_AREA
    REG_CUSTOM_ROUTE_MENU_LV4_ENTRIES_AREA equ 0x280