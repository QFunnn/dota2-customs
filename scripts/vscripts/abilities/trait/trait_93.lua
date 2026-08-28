--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_93"
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
		["56"] = 32,
		["57"] = 39,
		["58"] = 32,
		["59"] = 39,
		["60"] = 41,
		["61"] = 42,
		["62"] = 41,
		["63"] = 44,
		["64"] = 45,
		["65"] = 46,
		["66"] = 46,
		["67"] = 45,
		["68"] = 44,
		["69"] = 49,
		["70"] = 50,
		["71"] = 50,
		["72"] = 50,
		["73"] = 50,
		["74"] = 49,
		["75"] = 39,
		["76"] = 32,
		["77"] = 32,
		["78"] = 32,
		["79"] = 32,
		["80"] = 32,
		["81"] = 32,
		["82"] = 32,
		["83"] = 39,
		["85"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_93 = c()
local n = g.trait_93
n.name = "trait_93"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_93"
end
n = e({ j(nil) }, n)
g.trait_93 = n
g.modifier_trait_93 = c()
local o = g.modifier_trait_93
o.name = "modifier_trait_93"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_93_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_93_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_93 = o
g.modifier_trait_93_buff = c()
local q = g.modifier_trait_93_buff
q.name = "modifier_trait_93_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.mana = self:GetAbilitySpecialValueFor("mana")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function q.prototype.OnCustomAttackLanded(self, r)
	Restore(self:GetParent(), self.mana)
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_93_buff = q
return g