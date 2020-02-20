local lu = require("luaunit")

local socket = require("socket")
local listen_port = 10002

package.loaded["z2-util"] = nil
local util = require("z2-util")

package.loaded["intro-cutscene-skip"] = nil
require("intro-cutscene-skip")

--_G["print"] = nil
--console.writeline(intro_cutscene_skip)
console.writeline(util)

local server = socket.udp()
if (server == nil) then
    console.writeline("Could not create server socket.")
    return
end
ret, err = server:setsockname("localhost",listen_port)
if (ret == nil) then
    console.writeline(err)
end

event.onexit(function () server:close() end)

console.writeline("Listening on port " .. listen_port)
local msg, remote_host, remote_port = server:receivefrom()

console.writeline("Received " .. msg .. " from " .. remote_host .. ", " .. remote_port)

ret, err = server:setpeername(remote_host, remote_port)
if (ret == nil) then
    console.writeline(err)
end



client.unpause()

done = false

--util.z2_start()
--intro_cutscene_skip.test1()
--TestIntroCutsceneSkip.test1()
--lu.LuaUnit.run("TestIntroCutsceneSkip")

while not done do
    msg = server:receive()

    console.writeline(msg)

    local t = util.split_kv(msg,"([%w_]+)=([%w_]+)")

    console.writeline(t)

    if t["all"] == "done" then
        done = true
        break
    end
    local args
    if t["args"] ~= nil then
        args = util.split(t["args"],"[%w_]+")
    end

    if t["lib"] == "util" then
        util[t["func"]](args)
    end
end
server:close()

client.pause()