--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_26"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 12,
		["13"] = 3,
		["14"] = 12,
		["15"] = 13,
		["16"] = 14,
		["17"] = 13,
		["18"] = 18,
		["19"] = 19,
		["20"] = 18,
		["21"] = 12,
		["22"] = 3,
		["23"] = 3,
		["24"] = 3,
		["25"] = 3,
		["26"] = 3,
		["27"] = 3,
		["28"] = 3,
		["29"] = 3,
		["30"] = 3,
		["31"] = 12,
		["33"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_26 = c()
local k = g.modifier_card_effect_26
k.name = "modifier_card_effect_26"
d(k, i)
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_RARE_CHANCE_BONUS }
end
function k.prototype.EOM_GetModifierRareChanceBonus(self)
	return self:GetStackCount() / 10
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	k
)
g.modifier_card_effect_26 = k
return g