--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
do
	CDOTA_Buff.GetAbilitySpecialValueFor = function(self, name)
		local ability = self:GetAbility()
		if not IsValid(ability) then
			return
		end
		return ability:GetSpecialValueFor(name)
	end
	CDOTA_Buff.GetAbilityLevelSpecialValueFor = function(self, name, level)
		local ability = self:GetAbility()
		if not IsValid(ability) then
			return
		end
		return ability:GetLevelSpecialValueFor(name, level)
	end
	CDOTA_Buff.GetAbilityLevel = function(self)
		local ability = self:GetAbility()
		if not IsValid(ability) then
			return
		end
		return ability:GetLevel()
	end
end
return ____exports