--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_18"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["30"] = 18,
		["31"] = 19,
		["32"] = 20,
		["33"] = 20,
		["34"] = 19,
		["35"] = 18,
		["36"] = 23,
		["37"] = 24,
		["38"] = 25,
		["39"] = 25,
		["40"] = 25,
		["41"] = 25,
		["42"] = 25,
		["43"] = 25,
		["44"] = 23,
		["45"] = 17,
		["46"] = 10,
		["47"] = 10,
		["48"] = 10,
		["49"] = 10,
		["50"] = 10,
		["51"] = 10,
		["52"] = 10,
		["53"] = 17,
		["55"] = 17,
		["56"] = 28,
		["57"] = 35,
		["58"] = 28,
		["59"] = 35,
		["60"] = 40,
		["61"] = 41,
		["62"] = 42,
		["63"] = 43,
		["64"] = 44,
		["65"] = 40,
		["66"] = 46,
		["67"] = 47,
		["68"] = 46,
		["69"] = 52,
		["70"] = 53,
		["71"] = 52,
		["72"] = 55,
		["73"] = 56,
		["74"] = 55,
		["75"] = 58,
		["76"] = 59,
		["77"] = 58,
		["78"] = 35,
		["79"] = 28,
		["80"] = 28,
		["81"] = 28,
		["82"] = 28,
		["83"] = 28,
		["84"] = 28,
		["85"] = 28,
		["86"] = 35,
		["88"] = 35,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_18 = c()
local n = g.treasure_18
n.name = "treasure_18"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_18"
end
n = e({ j(nil) }, n)
g.treasure_18 = n
g.modifier_treasure_18 = c()
local o = g.modifier_treasure_18
o.name = "modifier_treasure_18"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_18_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_18_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_18 = o
g.modifier_treasure_18_buff = c()
local q = g.modifier_treasure_18_buff
q.name = "modifier_treasure_18_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.attackSpeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.hitRate = self:GetAbilitySpecialValueFor("hit_rate")
	self.critChance = self:GetAbilitySpecialValueFor("crit_chance")
	self.critDamage = self:GetAbilitySpecialValueFor("crit_damage")
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE] = -self.attackSpeed,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_EVASION] = self.hitRate,
	}
end
function q.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE,
	}
end
function q.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, r)
	return (r and r.damage_category) == DOTA_DAMAGE_CATEGORY_ATTACK and self.critChance or nil
end
function q.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, r)
	return (r and r.damage_category) == DOTA_DAMAGE_CATEGORY_ATTACK and self.critDamage or nil
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_18_buff = q
return g