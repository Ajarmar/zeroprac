local lib = {}

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