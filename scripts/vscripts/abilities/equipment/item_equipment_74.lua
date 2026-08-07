--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_74"
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
		["37"] = 28,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["42"] = 37,
		["43"] = 33,
		["44"] = 21,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 21,
		["56"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_74 = c()
local n = g.item_equipment_74
n.name = "item_equipment_74"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_74"
end
n = e({ j(nil) }, n)
g.item_equipment_74 = n
g.modifier_item_equipment_74 = c()
local o = g.modifier_item_equipment_74
o.name = "modifier_item_equipment_74"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.evade = self:GetAbilitySpecialValueFor("evade")
	self.threshold_pct = self:GetAbilitySpecialValueFor("threshold_pct")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function o.prototype.EOM_GetModifierEvasion_Bonus(self)
	if IsServer() and self:GetParent():GetHealthPercent() <= self.threshold_pct then
		self:SetStackCount(self.evade)
	end
	return self:GetStackCount()
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
g.modifier_item_equipment_74 = o
return g