@echo off

cd bps

SETLOCAL ENABLEDELAYEDEXPANSION
set /A mainver_max=0
set /A subver_max=0
for %%f in (*) do (
    set str=%%~nf
    set /A mainver=!str:~8,10!
    if !mainver! gtr !mainver_max! (
        set /A mainver_max=!mainver!
        set /A subver_max=0
    )
    set mainverstr=z4prac_v!mainver!
    if not x!mainverstr!==x%%~nf (
        for /f "tokens=3 delims=_" %%a in ("!str!") do set subver=%%a
        if !subver! gtr !subver_max! set /A subver_max=!subver!
    )
)

cd ..

set /A newmainver=!mainver_max!+1
set /A newsubver=!subver_max!+1
set /P bigver="New main version? [y/n]: "
if !bigver!==y (
    flips "Rockman Zero 4 (Japan).gba" "z4prac.gba" "bps\z4prac_v!newmainver!.bps"
) else (flips "Rockman Zero 4 (Japan).gba" "z4prac.gba" "bps\z4prac_v!mainver_max!_!newsubver!.bps")

ENDLOCAL

cd ..