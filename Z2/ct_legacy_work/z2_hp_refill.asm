; PATCH_CODE: 0x0835A000

; Z2 HP Refill

; Modifies HP to 16 on button press (L)

; PROJECT TO DOs

; Figure out where EWRAM/IWRAM (and if other like VRAM need to be saved too) will be stored
; It will either be:
;        1. Actual save/load functionality using active random spots within SRAM
;        2. Load only functionality by having pre-set savestates available in the ROM's empty space
; Next test may best be to test out #2 for one case to make sure the load functionality actually can work
; Develop load functionality






.gba
.thumb
.open "rmz2.gba", "rmz2-output.gba", 0x08000000

; //////////////////////////// MACROS ////////////////////////////


; // WRITE X VALUES


.macro writeram,loops,start
push {r3-r7}
mov r3, #0
ldr r4, =(start)
ldr r5, [r2]
mov r6, #loops
bl writestart



writestart:
str r5, [r4]
add r4, 0x01
add r3, 0x01


cmp r3, r6
bge writeend
blt writestart

writeend:
pop {r3-r7}
.endmacro




; Area to inject
.org 0x0801E90E 			; location to inject code
ldr r3,=(0x0835A001)	; new code destination
bx r3							; branch
.pool


;; TO DO
;; START the Sram loads
;; END TO DO

; New code setup
.org 0x0835A000			;	new code destination
push {r1-r7}
nop

; //////////////////////////// DO MAIN CODE HERE ////////////////////////////


; ////// Branch on R press

ldr r1,=(0x0202EC34) ;; Inputs for R/Select button address in RAM
ldrh r2, [r1] ;; Load RAM value from address
ldr r1, =(0x7E04) ;; Button press R and Select
cmp r1, r2 ;; Compare values
nop
nop
nop
nop
nop
beq label1 ;; Label 1 (press combo activated)
bne label2 ;; Label 2 (no press combo)


; ////// SAVE STATE CODE
; Initial test - save HP then load it

saveCode: 
push {r1-r3}
ldr r1,=(0x02037D94)
ldr r2, [r1]
nop
nop
nop
nop
nop
writeram 5, 0x02050000
nop
nop
nop
nop
nop
;ldr r3, =(0x02040000)
;str r2, [r3]
pop {r1-r3}
bl label3 ;; THIS IS THE PROBLEM, FIX. SOMETHING WITH R1 GETTING WONKY



; ////// Label1 : If both R and Select pressed, proceed:

label1:
; ///// Restore HP
ldr r6,=(0x02037D94)
ldr r7, [r6]
mov r7, 0x10
strb r7, [r6]

bl label2


; ////// Label 2: Continue code 
label2:
nop
bl saveCode



label3:
nop
nop
; //////////////////////////// END MAIN CODE HERE //////////////////////////// 
pop {r1-r7}
pop {r3-r5}
mov r8, r3					;	 replicate the exact same code as before,
mov r9, r4					;   for all code that was overwritten by the above instructions
mov r10, r5
pop {r4-r7}
pop {r1}
bx r1
.pool
; //////////////////////////// OTHER FUNCTIONS ////////////////////////////




; Branch test code
.org 0x0835B000





.close











/*
; ////////////// LATER - PUT BACK UNDER LABEL1 IF DESIRED
; Restore HP
;ldr r6,=(0x02037D94)
;ldr r7, [r6]
;mov r7, 0x10
;strb r7, [r6]
*/

