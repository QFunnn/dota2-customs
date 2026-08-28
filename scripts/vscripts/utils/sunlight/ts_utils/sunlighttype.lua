--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
SLType = SLType or {}
do
	--- 是否是 CBaseEntity
	--
	-- @both
	function SLType.Is_CBaseEntity(self, param)
		return type(param) == "table" and param.GetEntityIndex ~= nil
	end
	--- 是否是 CDOTA_BaseNPC
	--
	-- @both
	function SLType.Is_CDOTA_BaseNPC(self, param)
		return type(param) == "table" and param.GetUnitName ~= nil
	end
	--- 是否是 Vector
	--
	-- @both
	function SLType.Is_Vector(self, param)
		return type(param) == "userdata" and param.Length2D ~= nil
	end
	--- 是否是 CDOTA_BaseNPC_Hero
	--
	-- @both
	function SLType.Is_CDOTA_BaseNPC_Hero(self, param)
		return type(param) == "table"
			and param.GetStrength ~= nil
			and param.GetAgility ~= nil
			and param.GetIntellect ~= nil
	end
	--- 是否是 CDOTA_BaseNPC_Building
	--
	-- @both
	function SLType.Is_CDOTA_BaseNpc_Building(self, param)
		return type(param) == "table" and param.GetInvulnCount ~= nil and param.SetInvulnCount ~= nil
	end
end