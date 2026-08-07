--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_battle_attribute_enemy"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Number
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["13"] = 4,
		["14"] = 12,
		["15"] = 4,
		["16"] = 12,
		["17"] = 13,
		["18"] = 14,
		["19"] = 13,
		["20"] = 18,
		["21"] = 19,
		["22"] = 18,
		["23"] = 12,
		["24"] = 4,
		["25"] = 4,
		["26"] = 4,
		["27"] = 4,
		["28"] = 4,
		["29"] = 4,
		["30"] = 4,
		["31"] = 4,
		["32"] = 12,
		["34"] = 12,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_battle_attribute_enemy = c()
local l = h.modifier_battle_attribute_enemy
l.name = "modifier_battle_attribute_enemy"
d(l, j)
function l.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function l.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, m)
	return e(-GetCounterCriticalChance(self.caster, m))
end
l = f(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	l
)
h.modifier_battle_attribute_enemy = l
return h