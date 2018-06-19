# Mega Man Zero Practice Hacks

ROM hacks of the Mega Man Zero games for the Game Boy Advance.

Currently available: 
* Mega Man Zero 2

Up next:
* Mega Man Zero 3
* Save/load state functionality (Zero 2)

Authors: Ajarmar ([@Ajarmar_](http://twitter.com/Ajarmar_)), cleartonic ([@cleartonic](http://twitter.com/cleartonic))

## Building the practice ROM

There are two ways to build the practice ROM.

### IPS Patch (recommended)

You will need a Rockman Zero 2 ROM and an IPS patcher such as [Lunar IPS](https://www.romhacking.net/utilities/240/). Note that Lunar IPS will overwrite your ROM when patching it, so make a copy of the ROM before patching if you want to keep it.

1. Download the [IPS patch](https://github.com/Ajarmar/zeroprac/raw/master/Z2/ips/z2prac_v1.ips)
2. Open the IPS patch with Lunar IPS, and then choose your original ROM file.

The ROM is now the practice hack.

### Assembling with ARMIPS

You will need a Rockman Zero 2 ROM and [ARMIPS](https://github.com/Kingcom/armips/releases/tag/v0.10.0). The following instructions are for Windows, but I think ARMIPS will work on other operating systems as well - although you will have to [build it from source](https://github.com/Kingcom/armips#22-building-from-source).

1. Clone or download this repository. For easier assembling, put the zeroprac folder in the folder where you have ARMIPS.
2. Put your Rockman Zero 2 ROM in the Z2 folder.
3. Open a cmd window in the folder where you have ARMIPS. (Shift + Right click in the folder -> "Open command window here")
4. Assemble with the following command:

```
armips z2prac.asm -root zeroprac/Z2
```
If you don't put the zeroprac folder in the folder where you have ARMIPS, put the whole filepath to the Z2 folder instead of "zeroprac/Z2".

There will be a new ROM called "z2prac.gba" in the Z2 folder, which is the practice hack.

## Features

### Mega Man Zero 2

- Hold Select and press Start to bring up a stage select menu. Selecting a stage will bring you to it with the appropriate equipment/experience for that point in the route.
- Hold Select and press L to return to the latest checkpoint.
- Press Start during stage intro cutscenes to skip them. (Not available for other cutscenes.)
- If you die, you can press Start to immediately return to the latest checkpoint without losing a life.
- Skip text boxes by holding Start.
