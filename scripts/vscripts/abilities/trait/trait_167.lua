--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_167"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 26,
		["34"] = 26,
		["35"] = 30,
		["36"] = 31,
		["37"] = 30,
		["38"] = 36,
		["39"] = 37,
		["40"] = 36,
		["41"] = 19,
		["42"] = 12,
		["43"] = 12,
		["44"] = 12,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 19,
		["51"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_167 = c()
local n = g.trait_167
n.name = "trait_167"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_167"
end
n = e({ j(nil) }, n)
g.trait_167 = n
g.modifier_trait_167 = c()
local o = g.modifier_trait_167
o.name = "modifier_trait_167"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interest_limit = self:GetAbilitySpecialValueFor("interest_limit")
end
function o.prototype.OnCreated(self, p) end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT }
end
function o.prototype.EOM_GetModifierExtraInterest_Limit(self, p)
	return self.interest_limit
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_167 = o
return g