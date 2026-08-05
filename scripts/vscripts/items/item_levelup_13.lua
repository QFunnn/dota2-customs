--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_levelup_13 = class({})

local function GetAtlasStatValue(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function item_levelup_13:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local bonus_int = self:GetSpecialValueFor("bonus_int")
	bonus_int = bonus_int * (1 + GetAtlasStatValue(caster:GetPlayerOwnerID(), "int_book_int_pct_bonus") / 100)
	local source_key = caster:LevelUpGetSourceKey(ability, ability:GetAbilityName())
	if not source_key then
		return
	end
	caster:LevelUpSetCustomStatsBonus(source_key, {
		base = { int_base_pct = bonus_int },
		bonus = {},
	})
	caster:TakeItem(ability)
end