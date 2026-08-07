--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_12"
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
		["60"] = 43,
		["61"] = 44,
		["62"] = 45,
		["63"] = 46,
		["64"] = 47,
		["65"] = 48,
		["66"] = 49,
		["67"] = 50,
		["68"] = 43,
		["69"] = 52,
		["70"] = 53,
		["71"] = 53,
		["72"] = 53,
		["73"] = 53,
		["74"] = 53,
		["75"] = 53,
		["76"] = 53,
		["77"] = 53,
		["78"] = 53,
		["79"] = 52,
		["80"] = 35,
		["81"] = 28,
		["82"] = 28,
		["83"] = 28,
		["84"] = 28,
		["85"] = 28,
		["86"] = 28,
		["87"] = 28,
		["88"] = 35,
		["90"] = 35,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_12 = c()
local n = g.treasure_12
n.name = "treasure_12"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_12"
end
n = e({ j(nil) }, n)
g.treasure_12 = n
g.modifier_treasure_12 = c()
local o = g.modifier_treasure_12
o.name = "modifier_treasure_12"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_12_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_12_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_12 = o
g.modifier_treasure_12_buff = c()
local q = g.modifier_treasure_12_buff
q.name = "modifier_treasure_12_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.health_bonus = self:GetAbilitySpecialValueFor("health_bonus")
	self.physicalBonus = self:GetAbilitySpecialValueFor("physical_bonus_pct")
	self.magicBonus = self:GetAbilitySpecialValueFor("magic_bonus_pct")
	self.physicalReduce = self:GetAbilitySpecialValueFor("physical_reduce_pct")
	self.magicReduce = self:GetAbilitySpecialValueFor("magic_reduce_pct")
	self.attackSpeed = self:GetAbilitySpecialValueFor("attackspeed_bonus")
	self.manaRegen = self:GetAbilitySpecialValueFor("mana_reply_bonus")
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS] = self.health_bonus,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE] = self.physicalBonus,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE] = self.magicBonus,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = -self.physicalReduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = -self.magicReduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackSpeed,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS] = self.manaRegen,
	}
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_12_buff = q
return g