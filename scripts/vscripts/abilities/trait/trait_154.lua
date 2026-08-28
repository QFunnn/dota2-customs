--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_154"
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
		["26"] = 11,
		["27"] = 18,
		["28"] = 11,
		["29"] = 18,
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 21,
		["34"] = 20,
		["35"] = 19,
		["36"] = 24,
		["37"] = 25,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["43"] = 26,
		["44"] = 24,
		["45"] = 18,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 18,
		["55"] = 18,
		["56"] = 30,
		["57"] = 37,
		["58"] = 30,
		["59"] = 37,
		["61"] = 37,
		["62"] = 40,
		["63"] = 30,
		["64"] = 41,
		["65"] = 42,
		["66"] = 43,
		["67"] = 41,
		["68"] = 46,
		["69"] = 47,
		["70"] = 46,
		["71"] = 52,
		["72"] = 53,
		["73"] = 52,
		["74"] = 56,
		["75"] = 57,
		["76"] = 58,
		["77"] = 58,
		["78"] = 57,
		["79"] = 56,
		["80"] = 61,
		["81"] = 62,
		["82"] = 63,
		["83"] = 64,
		["85"] = 61,
		["86"] = 37,
		["87"] = 30,
		["88"] = 30,
		["89"] = 30,
		["90"] = 30,
		["91"] = 30,
		["92"] = 30,
		["93"] = 30,
		["94"] = 37,
		["96"] = 37,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_154 = c()
local n = g.trait_154
n.name = "trait_154"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_154"
end
n = e({ j(nil) }, n)
g.trait_154 = n
g.modifier_trait_154 = c()
local o = g.modifier_trait_154
o.name = "modifier_trait_154"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_154_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_154_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_154 = o
g.modifier_trait_154_buff = c()
local q = g.modifier_trait_154_buff
q.name = "modifier_trait_154_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.cur_ult_cnt = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.max_ult_cnt = self:GetAbilitySpecialValueFor("max_ult_cnt")
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function q.prototype.EOM_GetModifierManaRegenBonus(self, p)
	return self.mana_regen
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function q.prototype.OnCustomAbilityFullyCast(self, r)
	self.cur_ult_cnt = self.cur_ult_cnt + 1
	if self.cur_ult_cnt >= self.max_ult_cnt then
		self.parent:RemoveModifierByName("modifier_trait_154_buff")
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_154_buff = q
return g