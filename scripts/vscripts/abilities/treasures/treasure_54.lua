--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_54"
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
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
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
		["56"] = 31,
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 47,
		["61"] = 48,
		["62"] = 49,
		["63"] = 50,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 54,
		["68"] = 47,
		["69"] = 57,
		["70"] = 58,
		["71"] = 58,
		["72"] = 58,
		["73"] = 58,
		["74"] = 58,
		["75"] = 58,
		["76"] = 58,
		["77"] = 58,
		["78"] = 58,
		["79"] = 57,
		["80"] = 38,
		["81"] = 31,
		["82"] = 31,
		["83"] = 31,
		["84"] = 31,
		["85"] = 31,
		["86"] = 31,
		["87"] = 31,
		["88"] = 38,
		["90"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_54 = c()
local n = g.treasure_54
n.name = "treasure_54"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_54"
end
n = e({ j(nil) }, n)
g.treasure_54 = n
g.modifier_treasure_54 = c()
local o = g.modifier_treasure_54
o.name = "modifier_treasure_54"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_54_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_54_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_54 = o
g.modifier_treasure_54_buff = c()
local q = g.modifier_treasure_54_buff
q.name = "modifier_treasure_54_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.healthBonus = self:GetAbilitySpecialValueFor("health_bonus")
	self.physicalBonus = self:GetAbilitySpecialValueFor("physical_bonus_pct")
	self.magicBonus = self:GetAbilitySpecialValueFor("magic_bonus_pct")
	self.physicalReduce = self:GetAbilitySpecialValueFor("physical_reduce_pct")
	self.magicReduce = self:GetAbilitySpecialValueFor("magic_reduce_pct")
	self.attackSpeed = self:GetAbilitySpecialValueFor("attackspeed_bonus")
	self.manaRegen = self:GetAbilitySpecialValueFor("mana_reply_bonus")
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS] = self.healthBonus,
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
g.modifier_treasure_54_buff = q
return g