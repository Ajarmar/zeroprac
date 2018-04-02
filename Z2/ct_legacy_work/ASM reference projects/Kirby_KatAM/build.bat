arm-none-eabi-cpp hack.s hack-temp.s
arm-none-eabi-gcc -c -mthumb hack-temp.s -o hack.o
arm-none-eabi-ld -Ttext 0x08000000 hack.o
arm-none-eabi-objcopy -O binary a.out "KatAM_Practice_Cart.gba"
pause