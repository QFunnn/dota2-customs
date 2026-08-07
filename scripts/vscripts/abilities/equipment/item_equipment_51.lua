--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_51"
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
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 37,
		["47"] = 37,
		["48"] = 37,
		["49"] = 37,
		["50"] = 37,
		["51"] = 37,
		["52"] = 37,
		["53"] = 37,
		["55"] = 33,
		["56"] = 21,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 21,
		["68"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_51 = c()
local n = g.item_equipment_51
n.name = "item_equipment_51"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_51"
end
n = e({ j(nil) }, n)
g.item_equipment_51 = n
g.modifier_item_equipment_51 = c()
local o = g.modifier_item_equipment_51
o.name = "modifier_item_equipment_51"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function o.prototype.OnPoisonTakeDamage(self, p)
	if self.chance > 0 and self:PRD(self.chance) then
		local q = self:GetParent()
		local r = q:GetEnemy()
		local s = Heal
		local t = self.hp_regen
		local u = self:GetAbility()
		s(q, t, u and u:GetAbilityName(), "Ability")
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
g.modifier_item_equipment_51 = o
return g