local socket = require("socket")
local listen_port = 20202

package.loaded["lua\\action"] = nil
local action = require("lua\\action")

package.loaded["lua\\util"] = nil
local util = require("lua\\util")

package.loaded["lua\\z2\\macro"] = nil
local macro = require("lua\\z2\\macro")

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

server:send("hey")

client.unpause()

done = false

while not done do
    msg = server:receive()

    console.writeline(msg)

    local t = util.split_kv(msg,"([%w_]+)=([%w_\.]+)")

    console.writeline(t)

    if t["all"] == "done" then
        done = true
        break
    end

    local args
    if t["args"] ~= nil then
        args = util.split(t["args"],"[%w_\.]+")
    end

    if t["lib"] == "action" then
        action[t["func"]](args)
    elseif t["lib"] == "macro" then
        macro[t["func"]](args)
    elseif t["lib"] == "get_action" then
        local res = action[t["func"]](args)
        server:send(string.format("%x",res))
    end
end
server:close()

client.pause()