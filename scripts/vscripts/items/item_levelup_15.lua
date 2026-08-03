--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


item_levelup_15 = class({})

local function GetAtlasStatValue(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function item_levelup_15:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local exp = self:GetSpecialValueFor("exp")
	exp = exp + math.floor(GetAtlasStatValue(caster:GetPlayerOwnerID(), "xp_book_extra_xp_reward"))
	caster:AddExperience(exp, 0, false, true)
	caster:TakeItem(ability)
end