--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


item_levelup_26 = class({})

local function GetAtlasStatValue(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function item_levelup_26:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local strength_per_second = self:GetSpecialValueFor("strength_per_second")
	strength_per_second = strength_per_second
		* (1 + GetAtlasStatValue(caster:GetPlayerOwnerID(), "str_essence_str_per_sec_bonus") / 100)
	local source_key = caster:LevelUpGetSourceKey(ability, ability:GetAbilityName())
	if not source_key then
		return
	end
	caster:LevelUpSetCustomStatsBonus(source_key, {
		base = { str_per_sec = strength_per_second },
		bonus = {},
	})
	caster:TakeItem(ability)
end