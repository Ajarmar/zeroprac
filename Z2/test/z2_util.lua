local lib = {}

function lib.press(mnemonic)
    joypad.setfrommnemonicstr("|    0,    0,    0,  100," .. mnemonic)
    emu.frameadvance()
end

function lib.hold(mnemonic, frames)
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

function wait(frames)
    for i=0,frames do
        emu.frameadvance()
    end
end

function lib.z2_start()
    client.unpause()
    client.reboot_core()
    wait(5)
    lib.press("....S......")
    wait(30)
    lib.press("....S......")
    wait(17)
    lib.press("....S......")
    wait(10)
    lib.press("....S......")
end

function lib.split(line, pattern)
    t = {}
    local i = 0
    for v in string.gmatch(line,pattern) do
        t[i] = v
        i = i + 1
    end
    return t
end

function lib.split_kv(line, pattern)
    t = {}
    for k, v in string.gmatch(line, pattern) do
        t[k] = v
    end
    return t
end

return lib