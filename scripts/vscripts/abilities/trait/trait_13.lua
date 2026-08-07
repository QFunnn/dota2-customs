--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_13"
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
		["60"] = 44,
		["61"] = 45,
		["62"] = 47,
		["63"] = 48,
		["64"] = 49,
		["65"] = 44,
		["66"] = 51,
		["67"] = 52,
		["68"] = 51,
		["69"] = 58,
		["70"] = 59,
		["71"] = 58,
		["72"] = 64,
		["73"] = 65,
		["74"] = 66,
		["76"] = 64,
		["77"] = 69,
		["78"] = 70,
		["79"] = 71,
		["81"] = 69,
		["82"] = 38,
		["83"] = 31,
		["84"] = 31,
		["85"] = 31,
		["86"] = 31,
		["87"] = 31,
		["88"] = 31,
		["89"] = 31,
		["90"] = 38,
		["92"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_13 = c()
local n = g.trait_13
n.name = "trait_13"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_13"
end
n = e({ j(nil) }, n)
g.trait_13 = n
g.modifier_trait_13 = c()
local o = g.modifier_trait_13
o.name = "modifier_trait_13"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_13_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_13_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_13 = o
g.modifier_trait_13_buff = c()
local q = g.modifier_trait_13_buff
q.name = "modifier_trait_13_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.hit_rate = self:GetAbilitySpecialValueFor("hit_rate")
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE] = -self.attackspeed,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_EVASION] = self.hit_rate,
	}
end
function q.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE,
	}
end
function q.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, p)
	if p and p.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self.crit_chance
	end
end
function q.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, p)
	if p and p.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self.crit_damage
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_13_buff = q
return g