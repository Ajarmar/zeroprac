# Mega Man Zero Practice Hacks

ROM hacks of the Mega Man Zero games for the Game Boy Advance.

Currently available: 
* Rockman Zero 2
* Rockman Zero 3
* Rockman Zero 4

Up next:
* Rockman Zero 1
* More features for Zero 2/3/4

Developers:

* [Ajarmar](http://twitter.com/Ajarmar_) (main developer)
* [cleartonic](http://twitter.com/cleartonic) (original concept, work on early versions)
* [Krankdud](http://twitter.com/Krankdud) (Zero 2 Hard Mode functionality)

## Building the practice ROM

There are two ways to build the practice ROMs.

### IPS/BPS Patch (recommended)

You will need a Rockman Zero 2/Rockman Zero 3/Rockman Zero 4 ROM and an IPS/BPS patcher - [Floating IPS](https://www.romhacking.net/utilities/1040/) is recommended.


1. Download the IPS/BPS patch for [Zero 2](https://github.com/Ajarmar/zeroprac/raw/master/Z2/ips/z2prac_v2_1.ips), [Zero 3](https://github.com/Ajarmar/zeroprac/raw/master/Z3/ips/z3prac_v2.ips) or [Zero 4](https://github.com/Ajarmar/zeroprac/raw/master/Z4/bps/z4prac_v1_1.bps)
2. Open Floating IPS and press "Apply Patch".
3. Choose the IPS/BPS patch you want to use, then your original ROM file, and then specify the name and directory for the practice hack.

The practice hack will be created in the directory you specified, with the name you specified.

### Assembling with ARMIPS

You will need a Rockman Zero 2/Rockman Zero 3/Rockman Zero 4 ROM and [ARMIPS](https://github.com/Kingcom/armips/releases/tag/v0.10.0). The following instructions are for Windows, but I think ARMIPS will work on other operating systems as well - although you will have to [build it from source](https://github.com/Kingcom/armips#22-building-from-source).

1. Clone or download this repository. For easier assembling, put the zeroprac folder in the folder where you have ARMIPS.
2. Put your Rockman Zero 2/Rockman Zero 3/Rockman Zero 4 ROM in the Z2/Z3/Z4 folder. The ROM must be named "Rockman Zero 2 (Japan).gba" / "Rockman Zero 3 (Japan).gba" / "Rockman Zero 4 (Japan).gba".
3. Open a cmd window in the folder where you have ARMIPS. (Shift + Right click in the folder -> "Open command window here")
4. Assemble with the following command, replacing x with the number of the game (2/3/4):

```
armips zxprac.asm -root zeroprac/Zx
```

If you don't put the zeroprac folder in the folder where you have ARMIPS, put the whole filepath to the Z2/Z3/Z4 folder after "-root".

There will be a new ROM called "z2prac.gba" / "z3prac.gba" / "z4prac.gba" in the Z2/Z3/Z4 folder, which is the practice hack.

## Features

### Zero 2

[Video](https://www.youtube.com/watch?v=oFmz7C9agcM)

- Hold Select and press Start to bring up a stage select menu. Selecting a stage will bring you to it with the appropriate equipment/experience for that point in the route.
    - Hold L when selecting a stage to get the appropriate hard mode equipment.
- Hold Select and press L to return to the latest checkpoint.
- Press Start during stage intro cutscenes to skip them. (Not available for other cutscenes.)
- If you die, you can press Start to immediately return to the latest checkpoint without losing a life.
- Skip text boxes by holding Start.

### Zero 3

[Video](https://www.youtube.com/watch?v=hQKZBsgO-4k)

- Skippable cutscenes without needing a save file.
- Infinite lives.
- Holding Select and pressing Start opens the stage select menu.
    - Choose a stage with up/down, and press A to enter the stage.
    - Press B to exit the menu.
    - Press L to switch between routes (currently available: Blizzack first/Reflect Laser in Foxtar, Hanumachine first/No Reflect Laser in Foxtar, and Custom)
    - Press R to edit custom route.
        - Press Select+A to select a stage to move, and then A to confirm which stage you want to switch it with. Intro/Baby Elves 1/Copy X/Baby Elves 2/Final/Commander Room cannot be moved.
        - Press Select+L to open a menu with special options that affect every stage except intro.
        - Press Select+R to save your custom route to SRAM, which will be loaded when you start the game.
        - Press A to edit the currently selected stage. Intro/Commander Room cannot be edited.
- Hold Select and press Up to switch between A rank and B rank.
- Hold Select and press L to reload latest checkpoint. Also works on bosses (the beginning of a boss fight is a checkpoint).
    - Hold Select+Left and press L to load previous checkpoint, hold Select+Right and press L to load next checkpoint.
    - Hold Select+Down (plus Left/Right if you want) and press L to load checkpoint without loading changes you've made to your equipment.
- There is a timer showing the stage time. It displays minutes:seconds:frames. When you load a checkpoint, it will go back to 0.

- Tips:
    - When you enter/skip a cutscene, your weapon charges are stored and will be loaded whenever you load a checkpoint. If you want your weapons to be charged at the beginning of a boss fight, go to the checkpoint just before the boss, enter the boss room normally with your weapons charged and skip the cutscene. When reloading the checkpoint, your weapons will be charged in the same way that they were when you skipped the cutscene. If you want to get rid of your stored charge, just enter/skip a cutscene without your weapons charged.
    
### Zero 4

- Infinite lives.
- Holding Select and pressing Start opens the stage select menu.
    - Choose a stage with up/down, and press A to enter the stage.
    - Press B to exit the menu.
    - Press L to switch between routes (currently available: No Junk, Junk **Work in Progress**)
- Hold Select and press L to reload latest checkpoint.
    - Hold Select+Left and press L to load previous checkpoint, hold Select+Right and press L to load next checkpoint.
    - Hold Select+Down (plus Left/Right if you want) and press L to load checkpoint without loading changes you've made to your equipment.
- There is a timer showing the stage time. It displays minutes:seconds:frames. When you load a checkpoint, it will go back to 0.
