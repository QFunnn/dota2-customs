--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/states"
local b = require("lualib_bundle")
local c = b.__TS__ArraySort
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["6"] = 5,
		["7"] = 5,
		["8"] = 5,
		["9"] = 5,
		["10"] = 5,
		["11"] = 5,
		["12"] = 5,
		["13"] = 5,
		["14"] = 5,
		["15"] = 5,
		["16"] = 5,
		["17"] = 5,
		["18"] = 5,
		["19"] = 5,
		["20"] = 5,
		["21"] = 5,
		["22"] = 5,
		["23"] = 5,
		["24"] = 5,
		["25"] = 5,
		["26"] = 5,
		["27"] = 5,
		["28"] = 5,
		["29"] = 5,
		["30"] = 5,
		["31"] = 5,
		["32"] = 5,
		["33"] = 5,
		["34"] = 5,
		["35"] = 5,
		["36"] = 5,
		["37"] = 5,
		["38"] = 5,
		["39"] = 5,
		["40"] = 5,
		["41"] = 5,
		["42"] = 5,
		["43"] = 5,
		["44"] = 5,
		["45"] = 28,
		["46"] = 29,
		["47"] = 29,
		["49"] = 31,
		["50"] = 31,
		["52"] = 32,
		["53"] = 34,
		["54"] = 36,
		["55"] = 36,
		["56"] = 36,
		["57"] = 37,
		["58"] = 38,
		["59"] = 39,
		["60"] = 36,
		["61"] = 36,
		["62"] = 42,
		["63"] = 28,
		["64"] = 44,
		["65"] = 45,
		["66"] = 45,
		["68"] = 47,
		["69"] = 47,
		["71"] = 48,
		["72"] = 50,
		["73"] = 51,
		["75"] = 54,
		["76"] = 44,
		["77"] = 57,
		["78"] = 58,
		["79"] = 58,
		["81"] = 60,
		["82"] = 60,
		["84"] = 61,
		["85"] = 63,
		["86"] = 64,
		["87"] = 65,
		["88"] = 67,
		["89"] = 68,
		["90"] = 69,
		["93"] = 72,
		["96"] = 76,
		["97"] = 57,
		["102"] = 84,
		["103"] = 85,
		["104"] = 84,
		["109"] = 92,
		["110"] = 93,
		["111"] = 92,
		["116"] = 100,
		["117"] = 101,
		["118"] = 100,
		["123"] = 108,
		["124"] = 109,
		["125"] = 108,
		["126"] = 112,
		["127"] = 113,
		["128"] = 112,
		["129"] = 116,
		["130"] = 117,
		["131"] = 116,
	}
)
EOMModifierStates = EOMModifierStates or {}
EOMModifierStates.MODIFIER_STATE_NO_HEALTH_BAR = 65
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_NO_HEALTH_BAR] = "MODIFIER_STATE_NO_HEALTH_BAR"
EOMModifierStates.MODIFIER_STATE_CRITICAL_STRIKE_IMMUNE = 66
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_CRITICAL_STRIKE_IMMUNE] = "MODIFIER_STATE_CRITICAL_STRIKE_IMMUNE"
EOMModifierStates.MODIFIER_STATE_CUSTOM_DOOM = 67
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_CUSTOM_DOOM] = "MODIFIER_STATE_CUSTOM_DOOM"
EOMModifierStates.MODIFIER_STATE_WISP_DISARMED = 68
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_WISP_DISARMED] = "MODIFIER_STATE_WISP_DISARMED"
EOMModifierStates.MODIFIER_STATE_EVASION_DISABLED = 69
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_EVASION_DISABLED] = "MODIFIER_STATE_EVASION_DISABLED"
EOMModifierStates.MODIFIER_STATE_EVASION_REDUCE_DISABLED = 70
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_EVASION_REDUCE_DISABLED] = "MODIFIER_STATE_EVASION_REDUCE_DISABLED"
EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_EFFECT = 71
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_EFFECT] = "MODIFIER_STATE_IGNORE_ICE_EFFECT"
EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_MANA_REGEN_EFFECT = 72
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_MANA_REGEN_EFFECT] =
	"MODIFIER_STATE_IGNORE_ICE_MANA_REGEN_EFFECT"
EOMModifierStates.MODIFIER_STATE_STRONG_SHIELD = 73
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_STRONG_SHIELD] = "MODIFIER_STATE_STRONG_SHIELD"
EOMModifierStates.MODIFIER_STATE_FAKE_ATTACK = 74
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_FAKE_ATTACK] = "MODIFIER_STATE_FAKE_ATTACK"
EOMModifierStates.MODIFIER_STATE_WISP_UNDEAD = 75
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_WISP_UNDEAD] = "MODIFIER_STATE_WISP_UNDEAD"
EOMModifierStates.MODIFIER_STATE_POISON_CRIT = 76
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_POISON_CRIT] = "MODIFIER_STATE_POISON_CRIT"
EOMModifierStates.MODIFIER_STATE_CUSTOM_MANA = 77
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_CUSTOM_MANA] = "MODIFIER_STATE_CUSTOM_MANA"
EOMModifierStates.MODIFIER_STATE_SINGLE_WISP_DISARMED = 78
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_SINGLE_WISP_DISARMED] = "MODIFIER_STATE_SINGLE_WISP_DISARMED"
EOMModifierStates.MODIFIER_STATE_CUSTOM_ULT = 79
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_CUSTOM_ULT] = "MODIFIER_STATE_CUSTOM_ULT"
EOMModifierStates.MODIFIER_STATE_HERO_WISP = 80
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_HERO_WISP] = "MODIFIER_STATE_HERO_WISP"
EOMModifierStates.MODIFIER_STATE_SECT_ATTACK_DISABLE = 81
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_SECT_ATTACK_DISABLE] = "MODIFIER_STATE_SECT_ATTACK_DISABLE"
EOMModifierStates.MODIFIER_STATE_MAGIC_PHYSICAL_EVASION_SWAP = 82
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_MAGIC_PHYSICAL_EVASION_SWAP] =
	"MODIFIER_STATE_MAGIC_PHYSICAL_EVASION_SWAP"
EOMModifierStates.MODIFIER_STATE_MAGIC_PHYSICAL_CRIT_SWAP = 83
EOMModifierStates[EOMModifierStates.MODIFIER_STATE_MAGIC_PHYSICAL_CRIT_SWAP] = "MODIFIER_STATE_MAGIC_PHYSICAL_CRIT_SWAP"
function RegisterModifierState(e, f)
	if not IsValid(e) then
		return false
	end
	if e.aStateModifers == nil then
		e.aStateModifers = {}
	end
	local g = e.aStateModifers
	g[#g + 1] = f
	c(g, function(h, i, j)
		local k = IsValid(i) and type(i.GetPriority) == "function" and i:GetPriority() or MODIFIER_PRIORITY_NORMAL
		local l = IsValid(j) and type(j.GetPriority) == "function" and j:GetPriority() or MODIFIER_PRIORITY_NORMAL
		return k - l
	end)
	return true
end
function UnregisterModifierState(e, f)
	if not IsValid(e) then
		return false
	end
	if e.aStateModifers == nil then
		e.aStateModifers = {}
	end
	local g = e.aStateModifers
	if ArrayRemove(g, f) ~= nil then
		return true
	end
	return false
end
function HasState(e, m)
	if not IsValid(e) then
		return false
	end
	if e.aStateModifers == nil then
		e.aStateModifers = {}
	end
	local g = e.aStateModifers
	for n = #g, 1, -1 do
		local f = g[n]
		if IsValid(f) and type(f.ECheckState) == "function" then
			local o = f.ECheckState(f)
			if o ~= nil and o[m] ~= nil then
				return o[m]
			end
		else
			table.remove(g, n)
		end
	end
	return false
end
function IsNoHealthBar(e)
	return HasState(e, EOMModifierStates.MODIFIER_STATE_NO_HEALTH_BAR)
end
function IsCriticalStrikeImmune(e)
	return HasState(e, EOMModifierStates.MODIFIER_STATE_CRITICAL_STRIKE_IMMUNE)
end
function IsPoisonCritEnabled(e)
	return HasState(e, EOMModifierStates.MODIFIER_STATE_POISON_CRIT)
end
function IsCustomHeroMana(e)
	return HasState(e, EOMModifierStates.MODIFIER_STATE_CUSTOM_MANA)
end
function IsCustomHeroUlt(e)
	return HasState(e, EOMModifierStates.MODIFIER_STATE_CUSTOM_ULT)
end
function IsSectAttackDisabled(e)
	return HasState(e, EOMModifierStates.MODIFIER_STATE_SECT_ATTACK_DISABLE)
end