--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


local levelup_blink_common = {}

local function get_atlas_stat_value(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function levelup_blink_common.GetManaCost(ability, level)
	local base_mana_cost = tonumber(ability.BaseClass.GetManaCost(ability, level)) or 0
	local caster = ability:GetCaster()
	local player_id = IsValid(caster) and caster:GetPlayerOwnerID() or -1
	local reduction = get_atlas_stat_value(player_id, "blink_mana_cost_reduction")
	return math.max(0, base_mana_cost - reduction)
end

function levelup_blink_common.OnSuccessfulBlink(caster, ability)
	if card_system then
		card_system:HandleRuntimeOnBlink(caster, ability)
	end
end

return levelup_blink_common