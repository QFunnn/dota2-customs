--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_13"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 23,
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 28,
		["37"] = 27,
		["38"] = 26,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 36,
		["46"] = 36,
		["47"] = 36,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 37,
		["53"] = 31,
		["54"] = 20,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 20,
		["66"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
g.item_equipment_13 = c()
local n = g.item_equipment_13
n.name = "item_equipment_13"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_13"
end
n = e({ j(nil) }, n)
g.item_equipment_13 = n
g.modifier_item_equipment_13 = c()
local o = g.modifier_item_equipment_13
o.name = "modifier_item_equipment_13"
d(o, m)
function o.prototype.GetAbilitySpecialValue(self)
	self.stack_bonus = self:GetAbilitySpecialValueFor("stack_bonus")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { self:GetParent(), -1 } }
end
function o.prototype.OnInjuryGained(self, p)
	if p and not self.processing then
		self.processing = true
		local q = self:GetParent()
		local r = q:GetEnemy()
		AddInjury(q, r, self.stack_bonus, self:GetAbility():GetName(), "Ability")
		self.processing = false
	end
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
g.modifier_item_equipment_13 = o
return g