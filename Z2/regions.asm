	.gba

	REG_STAGE_SELECT_CFG equ 0x0835780E
	REG_STAGE_SELECT_CFG_AREA equ 0x3B8
	REG_STAGE_SELECT equ REG_STAGE_SELECT_CFG+REG_STAGE_SELECT_CFG_AREA
	REG_STAGE_SELECT_AREA equ 0x53A
	REG_CUTSCENE_CFG equ REG_STAGE_SELECT+REG_STAGE_SELECT_AREA
	REG_CUTSCENE_CFG_AREA equ 0xA0
	REG_CUTSCENE_SKIP equ REG_CUTSCENE_CFG+REG_CUTSCENE_CFG_AREA
	REG_CUTSCENE_SKIP_AREA equ 0x80
	REG_TEXTBOX_SKIP equ REG_CUTSCENE_SKIP+REG_CUTSCENE_SKIP_AREA
	REG_TEXTBOX_SKIP_AREA equ 0xE0
	REG_INPUT_CHECK equ REG_TEXTBOX_SKIP+REG_TEXTBOX_SKIP_AREA
	REG_INPUT_CHECK_AREA equ 0x200
	REG_SKIP_RNG equ REG_INPUT_CHECK+REG_INPUT_CHECK_AREA
