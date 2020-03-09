local lib = {}

function press(mnemonic)
    joypad.setfrommnemonicstr("|    0,    0,    0,  100," .. mnemonic)
    emu.frameadvance()
end

function hold(mnemonic, frames)
    for i=0,frames do
        joypad.setfrommnemonicstr("|    0,    0,    0,  100," .. mnemonic)
        emu.frameadvance()
    end
end

function wait(frames)
    for i=0,frames do
        emu.frameadvance()
    end
end

function lib.start()
    client.unpause()
    -- Soft reset instead of rebooting core to avoid breaking Bizhawk
    -- See https://github.com/TASVideos/BizHawk/issues/1716
    while emu.islagged() do
        wait(1)
    end
    wait(1)
    press("....SsBA...")
    --client.reboot_core()
    wait(5)
    press("....S......")
    wait(30)
    press("....S......")
    wait(17)
    press("....S......")
    wait(10)
    press("....S......")
end

return lib