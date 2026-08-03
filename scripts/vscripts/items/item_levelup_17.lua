--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


item_levelup_17 = class({})

local function GetAtlasStatValue(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function item_levelup_17:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local damage = self:GetSpecialValueFor("damage")
	local magic_damage = self:GetSpecialValueFor("magic_damage")
	local fixed_damage_bonus_pct = GetAtlasStatValue(caster:GetPlayerOwnerID(), "fixed_damage_artefact_amp_bonus_pct")
	damage = damage * (1 + fixed_damage_bonus_pct / 100)
	magic_damage = magic_damage * (1 + fixed_damage_bonus_pct / 100)
	local source_key = caster:LevelUpGetSourceKey(ability, ability:GetAbilityName())
	if not source_key then
		return
	end
	caster:LevelUpSetCustomStatsBonus(source_key, {
		base = { fixed_physical_damage = damage, fixed_magical_damage = magic_damage },
		bonus = {},
	})
	caster:TakeItem(ability)
end