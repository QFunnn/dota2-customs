--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


item_levelup_19 = class({})

local function GetAtlasStatValue(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function item_levelup_19:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local min_wood = self:GetSpecialValueFor("min_wood")
	local max_wood = self:GetSpecialValueFor("max_wood")
	max_wood = max_wood + math.floor(GetAtlasStatValue(caster:GetPlayerOwnerID(), "wooden_chest_random_bonus_max"))
	local random_bonus = RandomInt(min_wood, max_wood)
	caster:LevelUpModifyWood(random_bonus)
	CreateMessageResources(caster, random_bonus, "wood", true)
	caster:TakeItem(ability)
end