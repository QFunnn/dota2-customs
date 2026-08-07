--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_40"
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
		["31"] = 23,
		["32"] = 24,
		["33"] = 23,
		["34"] = 26,
		["35"] = 27,
		["36"] = 26,
		["37"] = 21,
		["38"] = 12,
		["39"] = 12,
		["40"] = 12,
		["41"] = 12,
		["42"] = 12,
		["43"] = 12,
		["44"] = 12,
		["45"] = 12,
		["46"] = 12,
		["47"] = 21,
		["49"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
g.item_equipment_40 = c()
local n = g.item_equipment_40
n.name = "item_equipment_40"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_40"
end
n = e({ j(nil) }, n)
g.item_equipment_40 = n
g.modifier_item_equipment_40 = c()
local o = g.modifier_item_equipment_40
o.name = "modifier_item_equipment_40"
d(o, m)
function o.prototype.GetAbilitySpecialValue(self)
	self.crit_damage_bonus = self:GetAbilitySpecialValueFor("crit_damage_bonus")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE] = self.crit_damage_bonus }
end
o = e(
	{
		l(
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
g.modifier_item_equipment_40 = o
return g