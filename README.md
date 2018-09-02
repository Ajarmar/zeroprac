# Mega Man Zero Practice Hacks

ROM hacks of the Mega Man Zero games for the Game Boy Advance.

Currently available: 
* Rockman Zero 2
* Rockman Zero 3

Up next:
* Rockman Zero 4

Authors: Ajarmar ([@Ajarmar_](http://twitter.com/Ajarmar_)), cleartonic ([@cleartonic](http://twitter.com/cleartonic))

## Building the practice ROM

There are two ways to build the practice ROMs.

### IPS Patch (recommended)

You will need a Rockman Zero 2/Rockman Zero 3 ROM and an IPS patcher such as [Lunar IPS](https://www.romhacking.net/utilities/240/). Note that Lunar IPS will overwrite your ROM when patching it, so make a copy of the ROM before patching if you want to keep it.

1. Download the IPS patch for [Zero 2](https://github.com/Ajarmar/zeroprac/blob/master/Z2/ips/z2prac_v1_1.ips) or [Zero 3](https://github.com/Ajarmar/zeroprac/raw/master/Z3/ips/z3prac_v1_1.ips)
2. Open the IPS patch with Lunar IPS, and then choose your original ROM file.

The ROM is now the practice hack.

### Assembling with ARMIPS

You will need a Rockman Zero 2/Rockman Zero 3 ROM and [ARMIPS](https://github.com/Kingcom/armips/releases/tag/v0.10.0). The following instructions are for Windows, but I think ARMIPS will work on other operating systems as well - although you will have to [build it from source](https://github.com/Kingcom/armips#22-building-from-source).

1. Clone or download this repository. For easier assembling, put the zeroprac folder in the folder where you have ARMIPS.
2. Put your Rockman Zero 2/Rockman Zero 3 ROM in the Z2/Z3 folder. The ROM must be named "Rockman Zero 2 (Japan).gba" / "Rockman Zero 3 (Japan).gba".
3. Open a cmd window in the folder where you have ARMIPS. (Shift + Right click in the folder -> "Open command window here")
4. Assemble with the following command:

* Z2
```
armips z2prac.asm -root zeroprac/Z2
```

* Z3
```
armips z3prac.asm -root zeroprac/Z3
```

If you don't put the zeroprac folder in the folder where you have ARMIPS, put the whole filepath to the Z2/Z3 folder instead of "zeroprac/Z2" / "zeroprac/Z3".

There will be a new ROM called "z2prac.gba" / "z3prac.gba" in the Z2/Z3 folder, which is the practice hack.

## Features

### Zero 2

[Video](https://www.youtube.com/watch?v=oFmz7C9agcM)

- Hold Select and press Start to bring up a stage select menu. Selecting a stage will bring you to it with the appropriate equipment/experience for that point in the route.
- Hold Select and press L to return to the latest checkpoint.
- Press Start during stage intro cutscenes to skip them. (Not available for other cutscenes.)
- If you die, you can press Start to immediately return to the latest checkpoint without losing a life.
- Skip text boxes by holding Start.

### Zero 3

[Video](https://www.youtube.com/watch?v=hQKZBsgO-4k)

- Skippable cutscenes without needing a save file.
- Infinite lives.
- Holding Select and pressing Start opens the stage select menu. You can press B to exit.
- Hold Select and press Up to switch between A rank and B rank.
- Hold Select and press L to reload latest checkpoint. Also works on bosses (the beginning of a boss fight is a checkpoint).
    - Hold Select+Left and press L to load previous checkpoint, hold Select+Right and press L to load next checkpoint.
    - Hold Select+Down (plus Left/Right if you want) and press L to load checkpoint without loading changes you've made to your equipment.
- There is a timer showing the stage time. It displays minutes:seconds:frames. When you load a checkpoint, it will go back to 0.

- Tips:
    - When you enter/skip a cutscene, your weapon charges are stored and will be loaded whenever you load a checkpoint. If you want your weapons to be charged at the beginning of a boss fight, go to the checkpoint just before the boss, enter the boss room normally with your weapons charged and skip the cutscene. When reloading the checkpoint, your weapons will be charged in the same way that they were when you skipped the cutscene. If you want to get rid of your stored charge, just enter/skip a cutscene without your weapons charged.
    - To start a stage with different equipment than what you're given, you can load the stage, change your equipment normally and then reload the checkpoint to store your equipment status.
