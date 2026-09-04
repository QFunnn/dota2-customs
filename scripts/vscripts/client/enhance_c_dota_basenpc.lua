--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
--- 客户端侧单位自定义值同步表
CLIENT_UNIT_CUSTOM_VALUE_NET_TABLE = "unit_custom_value_sync"
local ____G_C_DOTA_BaseNPC_0 = _G.C_DOTA_BaseNPC
if ____G_C_DOTA_BaseNPC_0 == nil then
	____G_C_DOTA_BaseNPC_0 = _G.CDOTA_BaseNPC
end
BaseNpcClass = ____G_C_DOTA_BaseNPC_0
if BaseNpcClass then
	BaseNpcClass.GetCustomValue = function(self, key)
		local ____temp_3 = not self
		if not ____temp_3 then
			local ____opt_1 = self.IsNull
			____temp_3 = ____opt_1 and ____opt_1(self)
		end
		if ____temp_3 then
			return nil
		end
		local ____opt_4 = self.entindex
		local entIndex = ____opt_4 and ____opt_4(self)
		if entIndex == nil or entIndex == nil then
			return nil
		end
		local synced = CustomNetTables:GetTableValue(CLIENT_UNIT_CUSTOM_VALUE_NET_TABLE, tostring(entIndex))
		local value = synced and synced[key]
		local ____temp_8
		if value ~= nil and value ~= nil then
			____temp_8 = value
		else
			____temp_8 = nil
		end
		return ____temp_8
	end
	BaseNpcClass.SetCustomValue = function(self, _key, _value, _syncNetTable) end
	BaseNpcClass.AddCustomValue = function(self, _key, _value, _syncNetTable)
		return false
	end
end