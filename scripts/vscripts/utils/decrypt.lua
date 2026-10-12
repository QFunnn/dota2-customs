--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- 目前这个解密模块只在服务器端运行
if not IsServer() then
	return
end

function string.fromhex(str)
	return (str:gsub("..", function(cc)
		return string.char(tonumber(cc, 16))
	end))
end

function string.tohex(str)
	return (str:gsub(".", function(c)
		return string.format("%02X", string.byte(c))
	end))
end

-- 解码函数，这个函数根据我自己的需求，只在server中使用
-- 如果你有在client使用的需求，请自行在其他脚本中处理
local key = GetDedicatedServerKeyV3("dota_super_mid") -- 密钥，这个密钥需自行获取并填写到package.json

local function execute_decrypted(code, chunk_name, ...)
	local text = string.fromhex(code)
	local plain = aeslua.decrypt(key, text, aeslua.AES128, aeslua.CBCMODE)
	local loader, err = loadstring(plain, chunk_name)
	if not loader then
		error(err)
	end
	return loader(...)
end

GameRules.XDecrypt = function(code, ...)
	return execute_decrypted(code, nil, ...)
end

-- 新包保留原始 Lua 文件名，使无 debug 环境也能转换到 TS 源码位置。
GameRules.XDecryptNamed = function(source_name, code, ...)
	return execute_decrypted(code, "@" .. source_name, ...)
end