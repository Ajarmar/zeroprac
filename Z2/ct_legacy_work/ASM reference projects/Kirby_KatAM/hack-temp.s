# 1 "hack.s"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "hack.s"





.text
start:
baseaddress = 0x08000000
.global _start
_start = baseaddress

@@@@@@@@@@@@@@@@@@@@@@@
@ MACROS
@@@@@@@@@@@@@@@@@@@@@@@

.macro patchat address
  @copy bytes in file from current address to specified address
  .incbin "KatAM_J.gba", (. - start), (\address - baseaddress - (. - start))
.endm

.macro load32 rx, value
  eor \rx, \rx, \rx
  add \rx, \rx, #((\value / 0x1000000) & 0xFF)
  lsl \rx, \rx, #8
  add \rx, \rx, #((\value / 0x10000) & 0xFF)
  lsl \rx, \rx, #8
  add \rx, \rx, #((\value / 0x100) & 0xFF)
  lsl \rx, \rx, #8
  add \rx, \rx, #(\value & 0xFF)
.endm

.thumb

@@@@@@@@@@@@@@@@@@@@@@@
@ HEX EDITS
@@@@@@@@@@@@@@@@@@@@@@@

patchat 0x0803EAB6 @ begin with 99 lives cause why not
 mov r0, #99
patchat 0x0804A91E @ don't take damage
 strb r2,[r1]
patchat 0x0804F826 @ reset death quickly
 mov r1, #0xEF
patchat 0x0804F994 @ don't reset to normal kirby after death
  add r0, r0, #0
patchat 0x0804F9A2 @ don't reset to normal kirby after death
  add r0, r0, #0
  add r0, r0, #0
patchat 0x0804FFAA @ don't lose lives
 sub r0, r1, #0

@@@@@@@@@@@@@@@@@@@@@@@
@ HIJACKS
@@@@@@@@@@@@@@@@@@@@@@@

patchat 0x08056D8C @ R button
 .word 0x08FA0000 +1
@patchat 0x08056F70 @ L button
@ .word increment_ability+1

patchat 0x08087F6A @ don't reset to normal kirby after death
 add r0, r0, #0
 add r0, r0, #0


patchat 0x08F9FFE0
 .ascii "KatAM Practice Cart\x0F\0"

@@@@@@@@@@@@@@@@@@@@@@@
@ CODE
@@@@@@@@@@@@@@@@@@@@@@@

patchat 0x08FA0000
 initChooseAbility:
  push {r4-r7,r14}

  load32 r7, 0x02020FE3
  ldrb r4, [r7,#0]
  load32 r7, 0x02020FBD
  strb r4, [r7,#0]

  load32 r7, 0x02020F58
  load32 r4, (0x08FA1000 +1)
  str r4, [r7,#0]

  pop {r4-r7}
  pop {r0}
  bx r0

patchat 0x08FA1000
 ChooseAbility:
  push {r4-r7,r14}

  @ bring up ability icon
  load32 r7, 0x03003AD0
  mov r4, #0x06
  strb r4, [r7,#0]
  sub r7, r7, #0x10
  mov r4, #0x0C
  strb r4, [r7,#0]

  @ restore ability (magic)
  load32 r7, 0x02020EEF
  mov r4, #0
  strb r4, [r7,#0]

  load32 r7, 0x02020FFA @ buttons

  ldrb r4, [r7,#0]
  cmp r4, #0x10 @ right
  beq pressright
  cmp r4, #0x20 @ left
  beq pressleft
  cmp r4, #0x04 @ select
  beq pressselect
  cmp r4, #0x01 @ A
  bne done

 preparereturn:
  load32 r7, 0x02020F58
  load32 r4, 0x0805C591
  str r4, [r7,#0]

  load32 r7, 0x0203AD20
  mov r4, #0
  str r4, [r7,#0]

  load32 r0, 0x02020EE0
  load32 r5, 0x0806E465
  load32 r6, (0x08FA1200 +1)
  mov r14, r6
  push {r1-r3}
  bx r5

 done:
  pop {r4-r7}
  pop {r0}
  bx r0

 pressselect:
  mov r4, #0
  load32 r7, 0x02020FE0
  strb r4, [r7,#0]
  load32 r7, 0x03000514
  strb r4, [r7,#0]
  b preparereturn

 pressright:
  load32 r7, 0x02020FBD
  ldrb r4, [r7,#0]
  add r4, r4, #1
  cmp r4, #0x1B
  bcc no_wrap_right
  eor r4, r4, r4
 no_wrap_right:
  strb r4, [r7,#0]
  b updategraphics

 pressleft:
  load32 r7, 0x02020FBD
  ldrb r4, [r7,#0]
  cmp r4, #0x00
  bne no_wrap_left
  mov r4, #0x1A
  strb r4, [r7,#0]
  b updategraphics
 no_wrap_left:
  sub r4, r4, #1
  strb r4, [r7,#0]
  b updategraphics

 updategraphics:
  ldrb r0, [r7,#0]
  load32 r5, 0x08035DD5
  load32 r6, (0x08FA1200 +1)
  mov r14, r6
  push {r1-r3}
  bx r5

patchat 0x08FA1200
 returnaddress:
  pop {r1-r3}
  b done



patchat 0x09000000

@@@@@@@@@@@@@@@@@@@@@@@
@ NOTES
@@@@@@@@@@@@@@@@@@@@@@@

@ 0x02020F58 = pointer to routine to run every frame
@ - 0x0803FEDD - default, idle
@ - 0x0805C591 - get an ability (update graphics)
@ - 0x0805C331 - mix roulette
@ 0x02020FBD = next ability
@ 0x02020FE3 = current ability
@ 0x02020FB8 = speed of mix roulette
@ 0x02020EE4 = counter for roulette image
@ 0x02020EE5 = current mix roulette image
@ 0x02020EEF = set to 0x02 to kill ability after this room
@ 0x03000514 = sprite lock if bit0 set
@ 0x03003AC0 = timer for ability image
@ 0x03003AD0 = ability image state


@ press R to add one to ability:
@ load32 r7, 0x02020FE3
@
@ ldrb r4, [r7,#0]
@ sub r7, r7, #0x26 @ r7 := 02020FBD
@ add r4, r4, #1
@ cmp r4, #0x1B
@ bcc save_ability
@ eor r4, r4, r4
@ save_ability:
@ strb r4, [r7,#0]
@
@ sub r7, r7, #0x65 @ r7 := 02020F58
@
@ load32 r4, 0x0805C591
@ str r4, [r7,#0]
