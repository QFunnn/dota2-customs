--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_12"
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
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 24,
		["35"] = 29,
		["36"] = 30,
		["37"] = 29,
		["38"] = 35,
		["39"] = 36,
		["40"] = 37,
		["42"] = 35,
		["43"] = 40,
		["44"] = 41,
		["45"] = 40,
		["46"] = 20,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 20,
		["58"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_12 = c()
local n = g.item_equipment_12
n.name = "item_equipment_12"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_12"
end
n = e({ j(nil) }, n)
g.item_equipment_12 = n
g.modifier_item_equipment_12 = c()
local o = g.modifier_item_equipment_12
o.name = "modifier_item_equipment_12"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.health = self:GetAbilitySpecialValueFor("health")
	self.damage_increase = self:GetAbilitySpecialValueFor("damage_increase")
	self.mana_regen_reduce = self:GetAbilitySpecialValueFor("mana_regen_reduce")
end
function o.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS,
	}
end
function o.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	if self.health > 0 then
		return math.floor(self:GetParent():GetMaxHealth() / self.health) * self.damage_increase
	end
end
function o.prototype.EOM_GetModifierManaRegenBonus(self, p)
	return -self.mana_regen_reduce
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
g.modifier_item_equipment_12 = o
return g