--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- LinkLuaModifier("modifier_spectre_haunted_night", "heroes/hero_spectre/spectre_haunted_night.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if spectre_haunted_night == nil then
	spectre_haunted_night = class({})
end
function spectre_haunted_night:OnSpellStart()
	local hCaster = self:GetCaster()
	local hAbility = hCaster:FindAbilityByName("spectre_suffering_specter")
	local night_duration = self:GetSpecialValueFor("night_duration")

	GameRules:BeginTemporaryNight(night_duration)

	if IsValid(hCaster) and IsValid(hAbility) and hAbility:GetLevel() >= 1 and hAbility.Fire and type(hAbility.Fire) == "function" then
		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), Vector(0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() and unit:IsRealHero() then
				hAbility:Fire(unit, false)
			end
		end
		local hBuff = hCaster:FindModifierByName("modifier_spectre_suffering_specter")
		if hBuff then
			hBuff:SetStackCount(0)
			hBuff:ClearStacks()
		end
	end
end