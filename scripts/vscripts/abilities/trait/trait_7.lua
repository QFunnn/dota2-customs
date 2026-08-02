--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_7"
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
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["34"] = 21,
		["35"] = 20,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 19,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 19,
		["55"] = 19,
		["56"] = 31,
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 41,
		["61"] = 42,
		["62"] = 43,
		["63"] = 41,
		["64"] = 45,
		["65"] = 46,
		["66"] = 45,
		["67"] = 38,
		["68"] = 31,
		["69"] = 31,
		["70"] = 31,
		["71"] = 31,
		["72"] = 31,
		["73"] = 31,
		["74"] = 31,
		["75"] = 38,
		["77"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_7 = c()
local n = g.trait_7
n.name = "trait_7"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_7"
end
n = e({ j(nil) }, n)
g.trait_7 = n
g.modifier_trait_7 = c()
local o = g.modifier_trait_7
o.name = "modifier_trait_7"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_7_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_7_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_7 = o
g.modifier_trait_7_buff = c()
local q = g.modifier_trait_7_buff
q.name = "modifier_trait_7_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_pct = self:GetAbilitySpecialValueFor("attackspeed_pct")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS_PERCENTAGE] = self.attackspeed_pct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_PERCENTAGE] = -self.damage_pct,
	}
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_7_buff = q
return g