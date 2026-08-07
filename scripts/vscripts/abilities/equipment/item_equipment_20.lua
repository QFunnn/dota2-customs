--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_20"
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 21,
		["29"] = 12,
		["30"] = 21,
		["31"] = 28,
		["32"] = 29,
		["33"] = 30,
		["34"] = 31,
		["35"] = 32,
		["36"] = 33,
		["37"] = 34,
		["38"] = 28,
		["39"] = 36,
		["40"] = 37,
		["41"] = 37,
		["42"] = 37,
		["43"] = 37,
		["44"] = 37,
		["45"] = 37,
		["46"] = 37,
		["47"] = 36,
		["48"] = 45,
		["49"] = 46,
		["50"] = 45,
		["51"] = 50,
		["52"] = 51,
		["53"] = 50,
		["54"] = 21,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 21,
		["66"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_20 = c()
local n = g.item_equipment_20
n.name = "item_equipment_20"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_20"
end
n = e({ j(nil) }, n)
g.item_equipment_20 = n
g.modifier_item_equipment_20 = c()
local o = g.modifier_item_equipment_20
o.name = "modifier_item_equipment_20"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.health = self:GetAbilitySpecialValueFor("health")
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.attack_bonus = self:GetAbilitySpecialValueFor("attack_bonus")
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.crit = self:GetAbilitySpecialValueFor("crit")
	self.evasion = self:GetAbilitySpecialValueFor("evasion")
end
function o.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS] = self.health,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.attack_bonus,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.evasion,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed,
	}
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function o.prototype.EOM_GetModifierManaRegenBonus(self, p)
	return self.mana_regen
end
o = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	o
)
g.modifier_item_equipment_20 = o
return g