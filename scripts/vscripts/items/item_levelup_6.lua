--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


item_levelup_6 = class({})

local function GetAtlasStatValue(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function item_levelup_6:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local bonus_gold = self:GetSpecialValueFor("bonus_gold")
	bonus_gold = bonus_gold + GetAtlasStatValue(caster:GetPlayerOwnerID(), "piggy_bank_gold_per_sec_bonus")
	local source_key = caster:LevelUpGetSourceKey(ability, ability:GetAbilityName())
	if not source_key then
		return
	end
	caster:LevelUpSetCustomStatsBonus(source_key, {
		base = { gold_per_sec = bonus_gold },
		bonus = {},
	})
	caster:TakeItem(ability)
end