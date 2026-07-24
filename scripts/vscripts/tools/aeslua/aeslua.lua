--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local private = {};
local public = {};
aeslua = public;

local ciphermode = require("tools/aeslua/ciphermode");
local util = require("tools/aeslua/util");

--
-- Simple API for encrypting strings.
--

public.AES128 = 16;
public.AES192 = 24;
public.AES256 = 32;

public.ECBMODE = 1;
public.CBCMODE = 2;
public.OFBMODE = 3;
public.CFBMODE = 4;

function private.pwToKey(password, keyLength)
    local padLength = keyLength;
    if (keyLength == public.AES192) then
        padLength = 32;
    end
    if (padLength > #password) then
        local postfix = "";
        for i = 1,padLength - #password do
            postfix = postfix .. string.char(0);
        end
        password = password .. postfix;
    else
        password = string.sub(password, 1, padLength);
    end
    local pwBytes = {string.byte(password,1,#password)};
    password = ciphermode.encryptString(pwBytes, password, ciphermode.encryptCBC);
    password = string.sub(password, 1, keyLength);
    return {string.byte(password,1,#password)};
end

--
-- Encrypts string data with password password.
-- password  - the encryption key is generated from this string
-- data      - string to encrypt (must not be too large)
-- keyLength - length of aes key: 128(default), 192 or 256 Bit
-- mode      - mode of encryption: ecb, cbc(default), ofb, cfb 
--
-- mode and keyLength must be the same for encryption and decryption.
--
function public.encrypt(password, data, keyLength, mode)
	assert(password ~= nil, "Empty password.");
	assert(password ~= nil, "Empty data.");
    local mode = mode or public.CBCMODE;
    local keyLength = keyLength or public.AES128;
    local key = private.pwToKey(password, keyLength);
    local paddedData = util.padByteString(data);
    if (mode == public.ECBMODE) then
        return ciphermode.encryptString(key, paddedData, ciphermode.encryptECB);
    elseif (mode == public.CBCMODE) then
        return ciphermode.encryptString(key, paddedData, ciphermode.encryptCBC);
    elseif (mode == public.OFBMODE) then
        return ciphermode.encryptString(key, paddedData, ciphermode.encryptOFB);
    elseif (mode == public.CFBMODE) then
        return ciphermode.encryptString(key, paddedData, ciphermode.encryptCFB);
    else
        return nil;
    end
end

--
-- Decrypts string data with password password.
-- password  - the decryption key is generated from this string
-- data      - string to encrypt
-- keyLength - length of aes key: 128(default), 192 or 256 Bit
-- mode      - mode of decryption: ecb, cbc(default), ofb, cfb 
--
-- mode and keyLength must be the same for encryption and decryption.
--
function public.decrypt(password, data, keyLength, mode)
    local mode = mode or public.CBCMODE;
    local keyLength = keyLength or public.AES128;
    local key = private.pwToKey(password, keyLength);
    local plain;
    if (mode == public.ECBMODE) then
        plain = ciphermode.decryptString(key, data, ciphermode.decryptECB);
    elseif (mode == public.CBCMODE) then
        plain = ciphermode.decryptString(key, data, ciphermode.decryptCBC);
    elseif (mode == public.OFBMODE) then
        plain = ciphermode.decryptString(key, data, ciphermode.decryptOFB);
    elseif (mode == public.CFBMODE) then
        plain = ciphermode.decryptString(key, data, ciphermode.decryptCFB);
    end
    result = util.unpadByteString(plain);
    if (result == nil) then
        return nil;
    end
    return result;
end

function private.CStringFromHex(str)
    return (str:gsub("..", function(cc)
        return string.char(tonumber(cc, 16))
    end))
end

function private.CStringToHex(str)
    return (str:gsub(".", function(c)
        return string.format("%02X", string.byte(c))
    end))
end

function public.decryptFile(key, content)
    return loadstring(public.decrypt(key, private.CStringFromHex(content)))()
end

function public.encryptFile(key, path)
    print(path)
    local file = io.open(path)
    local content = aeslua.encrypt(key, file:read("*all"))
    file:close()
    local wf = io.open(path, "w+")
    wf:write('return aeslua.decryptFile(GetServerKey(), "'..private.CStringToHex(content)..'")')
    wf:flush()
    wf:close()
end

function public.batchEncrypt(key, path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local filePath = path.."/"..file
            local fileAttr = lfs.attributes(filePath)
            if fileAttr.mode == "directory" then
                public.batchEncrypt(key, filePath)
            else
                public.encryptFile(key, filePath)
            end
        end
    end
end