local lib = {}

function lib.press(t)
    local mnemonic = t[0]
    joypad.setfrommnemonicstr("|    0,    0,    0,  100," .. mnemonic)
    emu.frameadvance()
end

function lib.hold(t)
    local mnemonic = t[0]
    local frames = t[1]
    for i=0,frames do
        joypad.setfrommnemonicstr("|    0,    0,    0,  100," .. mnemonic)
        emu.frameadvance()
    end
end

function lib.wait(t)
    local frames = tonumber(t[0])
    for i=0,frames do
        emu.frameadvance()
    end
end

return lib