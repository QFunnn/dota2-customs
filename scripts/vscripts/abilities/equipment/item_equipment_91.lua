--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_91"
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
		["33"] = 27,
		["34"] = 28,
		["35"] = 29,
		["36"] = 29,
		["37"] = 28,
		["38"] = 27,
		["39"] = 33,
		["40"] = 34,
		["41"] = 33,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["45"] = 42,
		["48"] = 39,
		["49"] = 47,
		["50"] = 48,
		["51"] = 49,
		["52"] = 50,
		["53"] = 51,
		["55"] = 47,
		["56"] = 20,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 20,
		["68"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_91 = c()
local n = g.item_equipment_91
n.name = "item_equipment_91"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_91"
end
n = e({ j(nil) }, n)
g.item_equipment_91 = n
g.modifier_item_equipment_91 = c()
local o = g.modifier_item_equipment_91
o.name = "modifier_item_equipment_91"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_EVASION }
end
function o.prototype.OnCustomAttackLanded(self, p)
	if IsServer() then
		if self:GetStackCount() < self.count then
			self:IncrementStackCount()
		end
	end
end
function o.prototype.EOM_GetModifierIgnoreEvasion(self, q)
	if q.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		local r = self:GetStackCount()
		self:SetStackCount(0)
		return r
	end
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
g.modifier_item_equipment_91 = o
return g