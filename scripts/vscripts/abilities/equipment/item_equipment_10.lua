--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_10"
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
		["27"] = 21,
		["28"] = 12,
		["29"] = 21,
		["30"] = 23,
		["31"] = 24,
		["32"] = 23,
		["33"] = 27,
		["34"] = 28,
		["35"] = 29,
		["36"] = 29,
		["37"] = 28,
		["38"] = 27,
		["39"] = 32,
		["40"] = 33,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["45"] = 33,
		["46"] = 34,
		["47"] = 34,
		["48"] = 34,
		["49"] = 34,
		["51"] = 32,
		["52"] = 21,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 21,
		["64"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
g.item_equipment_10 = c()
local n = g.item_equipment_10
n.name = "item_equipment_10"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_10"
end
n = e({ j(nil) }, n)
g.item_equipment_10 = n
g.modifier_item_equipment_10 = c()
local o = g.modifier_item_equipment_10
o.name = "modifier_item_equipment_10"
d(o, m)
function o.prototype.GetAbilitySpecialValue(self)
	self.mana_restore = self:GetAbilitySpecialValueFor("mana_restore")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomAbilityFullyCast(self, p)
	if p and (string.find(p.ability:GetName(), "_ult", nil, true) or 0) - 1 ~= -1 then
		Restore(self:GetParent(), self.mana_restore)
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
g.modifier_item_equipment_10 = o
return g