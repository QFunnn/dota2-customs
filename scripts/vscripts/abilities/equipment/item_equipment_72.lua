--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_72"
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
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 24,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 30,
		["39"] = 29,
		["40"] = 28,
		["41"] = 33,
		["42"] = 34,
		["43"] = 34,
		["44"] = 34,
		["45"] = 34,
		["46"] = 34,
		["47"] = 34,
		["48"] = 34,
		["49"] = 34,
		["50"] = 33,
		["51"] = 21,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 21,
		["63"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_72 = c()
local n = g.item_equipment_72
n.name = "item_equipment_72"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_72"
end
n = e({ j(nil) }, n)
g.item_equipment_72 = n
g.modifier_item_equipment_72 = c()
local o = g.modifier_item_equipment_72
o.name = "modifier_item_equipment_72"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.hp_pct = self:GetAbilitySpecialValueFor("hp_pct")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomAttackLanded(self, p)
	DamageSystem:dealDamage({
		attacker = self:GetParent(),
		target = p.target,
		ability = self:GetAbility(),
		damage_type = DAMAGE_TYPE_PURE,
		damage_category = DOTA_DAMAGE_CATEGORY_ATTACK,
		damage = self:GetParent():GetHealth() * self.hp_pct * 0.01,
	})
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
g.modifier_item_equipment_72 = o
return g