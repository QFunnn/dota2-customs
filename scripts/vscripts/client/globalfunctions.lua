--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
--- 客户端对象有效性检查。
-- 只接受 Dota 句柄常见的 table/userdata 代理，并通过 IsNull 排除无效对象。
local function ClientIsValid(self, obj)
	if not obj then
		return false
	end
	local objType = type(obj)
	if objType ~= "table" and objType ~= "userdata" then
		return false
	end
	local ok, isNull = pcall(function()
		if type(obj.IsNull) ~= "function" then
			return true
		end
		return obj:IsNull()
	end)
	return ok and not isNull
end
--- 客户端实体存活检查。
-- 部分客户端环境没有 IsValidEntity，因此仅在原生函数存在时调用，并保留 IsNull/IsAlive 兜底。
local function ClientIsValidAlive(self, obj)
	if not ClientIsValid(nil, obj) then
		return false
	end
	if type(IsValidEntity) == "function" then
		local entityCheckOk, isEntityValid = pcall(function()
			return IsValidEntity(obj)
		end)
		if not entityCheckOk or not isEntityValid then
			return false
		end
	end
	local aliveCheckOk, isAlive = pcall(function()
		if type(obj.IsAlive) ~= "function" then
			return true
		end
		return obj:IsAlive()
	end)
	return aliveCheckOk and isAlive
end
__TS__ObjectAssign(getfenv(), { IsValid = ClientIsValid, IsValidAlive = ClientIsValidAlive })
return ____exports