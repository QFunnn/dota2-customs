--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


item_levelup_27 = class({})

local function GetAtlasStatValue(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function item_levelup_27:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local agility_per_second = self:GetSpecialValueFor("agility_per_second")
	agility_per_second = agility_per_second
		* (1 + GetAtlasStatValue(caster:GetPlayerOwnerID(), "agi_essence_agi_per_sec_bonus") / 100)
	local source_key = caster:LevelUpGetSourceKey(ability, ability:GetAbilityName())
	if not source_key then
		return
	end
	caster:LevelUpSetCustomStatsBonus(source_key, {
		base = { agi_per_sec = agility_per_second },
		bonus = {},
	})
	caster:TakeItem(ability)
end