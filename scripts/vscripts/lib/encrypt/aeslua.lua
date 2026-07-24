--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local public = {};
local private = {};
aeslua = public;

local ciphermode = require("lib.encrypt.aeslua.ciphermode");

public.AES128 = 16;
public.AES192 = 24;
public.AES256 = 32;

public.ECBMODE = 1;
public.CBCMODE = 2;
public.OFBMODE = 3;
public.CFBMODE = 4;

function private.FromHex(str)
    return (str:gsub('..', function(cc)
        return string.char(tonumber(cc, 16))
    end))
end

function public.decrypt(password, data, i, keyLength, mode)
    mode = mode or public.CBCMODE;
    keyLength = keyLength or public.AES128;
    
    local key = {string.byte(password:sub(1, keyLength),1, keyLength)};
    
    local iv = {string.byte(private.FromHex(i), 1, 16)}
    data = private.FromHex(data)
    local plain;
    if (mode == public.ECBMODE) then
        plain = ciphermode.decryptString(key, data, iv, ciphermode.decryptECB);
    elseif (mode == public.CBCMODE) then
        plain = ciphermode.decryptString(key, data, iv, ciphermode.decryptCBC);
    elseif (mode == public.OFBMODE) then
        plain = ciphermode.decryptString(key, data, iv, ciphermode.decryptOFB);
    elseif (mode == public.CFBMODE) then
        plain = ciphermode.decryptString(key, data, iv, ciphermode.decryptCFB);
    end
    
    if (plain == nil) then return ''; end
    
    local result = plain
    local i = string.find(plain, "\0")
    if i then
        result = string.sub(plain, 1, i - 1);
    end
    
    return result;
end

return public