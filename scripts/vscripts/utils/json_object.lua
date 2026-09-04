--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
--- 把 Lua 对象表编码为 JSON 对象字符串。
-- 空表在 Lua 里没有数组/对象区别，JSON.encode({}) 会变成 "[]"；
-- 存档里需要对象映射的字段必须强制输出 "{}"。
function ____exports.EncodeJsonObject(self, value)
	if value == nil or type(value) ~= "table" then
		return "{}"
	end
	if { next(value) } == nil then
		return "{}"
	end
	local encoded = JSON:encode(value)
	if encoded == "" or encoded == "[]" then
		return "{}"
	end
	return encoded
end
return ____exports