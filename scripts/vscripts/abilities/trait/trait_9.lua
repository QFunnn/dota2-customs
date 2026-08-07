--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_9"
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
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["35"] = 24,
		["36"] = 19,
		["37"] = 12,
		["38"] = 12,
		["39"] = 12,
		["40"] = 12,
		["41"] = 12,
		["42"] = 12,
		["43"] = 12,
		["44"] = 19,
		["46"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_9 = c()
local n = g.trait_9
n.name = "trait_9"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_9"
end
n = e({ j(nil) }, n)
g.trait_9 = n
g.modifier_trait_9 = c()
local o = g.modifier_trait_9
o.name = "modifier_trait_9"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.value = self:GetAbilitySpecialValueFor("value")
end
function o.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INTEREST_RATE_CONSTANT] = 100000,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_BONUS_LIMIT_PERCENTAGE] = self.value,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_WIN_GOLD_PERCENTAGE] = self.value,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_LOSE_GOLD_PERCENTAGE] = self.value,
	}
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_9 = o
return g