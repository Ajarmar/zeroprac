    .gba

    REG_STAGE_SELECT_CFG equ 0x0835780E
    REG_STAGE_SELECT_CFG_AREA equ 0xAA0
    REG_STAGE_SELECT equ REG_STAGE_SELECT_CFG+REG_STAGE_SELECT_CFG_AREA
    REG_STAGE_SELECT_AREA equ 0x53A
    REG_TEXTBOX_SKIP equ REG_STAGE_SELECT+REG_STAGE_SELECT_AREA
    REG_TEXTBOX_SKIP_AREA equ 0xE0
    REG_MAIN equ REG_TEXTBOX_SKIP+REG_TEXTBOX_SKIP_AREA
    REG_MAIN_AREA equ 0x200
    REG_TIMER equ REG_MAIN+REG_MAIN_AREA
    REG_TIMER_AREA equ 0x200
    REG_TIMER_TABLE equ REG_TIMER+REG_TIMER_AREA
    REG_TIMER_TABLE_AREA equ 0xF0
    REG_CHECKPOINTS equ REG_TIMER_TABLE + REG_TIMER_TABLE_AREA
    REG_CHECKPOINTS_AREA equ 0x200
    REG_CHECKPOINTS_INDICES equ REG_CHECKPOINTS + REG_CHECKPOINTS_AREA
    REG_CHECKPOINTS_INDICES_AREA equ 0x610