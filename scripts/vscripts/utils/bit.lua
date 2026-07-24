--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[
Description:
    FileName:bit.lua
    This module provides a selection of bitwise operations.
History:
Notes:
  ....
]] --[[{2147483648,1073741824,536870912,268435456,134217728,67108864,33554432,16777216,
        8388608,4194304,2097152,1048576,524288,262144,131072,65536,
        32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2,1}
]]
band_function = bit.band

bit = {data32 = {}}
for i = 1, 32 do bit.data32[i] = 2 ^ (32 - i) end
bit.band = band_function
function bit:d2b(arg)
    local tr = {}
    for i = 1, 32 do
        if arg >= self.data32[i] then
            tr[i] = 1
            arg = arg - self.data32[i]
        else
            tr[i] = 0
        end
    end
    return tr
end -- bit:d2b

function bit:b2d(arg)
    local nr = 0
    for i = 1, 32 do if arg[i] == 1 then nr = nr + 2 ^ (32 - i) end end
    return nr
end -- bit:b2d

function bit:_xor(a, b)
    local op1 = self:d2b(a)
    local op2 = self:d2b(b)
    local r = {}

    for i = 1, 32 do
        if op1[i] == op2[i] then
            r[i] = 0
        else
            r[i] = 1
        end
    end
    return self:b2d(r)
end -- bit:xor

function bit:_and(a, b)
    local op1 = self:d2b(a)
    local op2 = self:d2b(b)
    local r = {}

    for i = 1, 32 do
        if op1[i] == 1 and op2[i] == 1 then
            r[i] = 1
        else
            r[i] = 0
        end
    end
    return self:b2d(r)

end -- bit:_and

function bit:_or(a, b)
    local op1 = self:d2b(a)
    local op2 = self:d2b(b)
    local r = {}

    for i = 1, 32 do
        if op1[i] == 1 or op2[i] == 1 then
            r[i] = 1
        else
            r[i] = 0
        end
    end
    return self:b2d(r)
end -- bit:_or

function bit:_not(a)
    local op1 = self:d2b(a)
    local r = {}

    for i = 1, 32 do
        if op1[i] == 1 then
            r[i] = 0
        else
            r[i] = 1
        end
    end
    return self:b2d(r)
end -- bit:_not

function bit:_rshift(a, n)
    local op1 = self:d2b(a)
    local r = self:d2b(0)

    if n < 32 and n > 0 then
        for i = 1, n do
            for i = 31, 1, -1 do op1[i + 1] = op1[i] end
            op1[1] = 0
        end
        r = op1
    end
    return self:b2d(r)
end -- bit:_rshift

function bit:_lshift(a, n)
    local op1 = self:d2b(a)
    local r = self:d2b(0)

    if n < 32 and n > 0 then
        for i = 1, n do
            for i = 1, 31 do op1[i] = op1[i + 1] end
            op1[32] = 0
        end
        r = op1
    end
    return self:b2d(r)
end -- bit:_lshift

function bit:print(ta)
    local sr = ""
    for i = 1, 32 do sr = sr .. ta[i] end
    logger:Log(sr)
end

-- alias-совместимость с Lua bit/bit32 API
bit.bor   = function(...) local r = 0; for _,v in ipairs({...}) do r = bit:_or(r, v) end; return r end
bit.band  = function(...) local r = 0xFFFFFFFF; for _,v in ipairs({...}) do r = bit:_and(r, v) end; return r end
bit.bxor  = function(a, b) return bit:_xor(a, b) end
bit.bnot  = function(a) return bit:_not(a) end
bit.lshift = function(a, n) return bit:_lshift(a, n) end
bit.rshift = function(a, n) return bit:_rshift(a, n) end


-- end of bit.lua