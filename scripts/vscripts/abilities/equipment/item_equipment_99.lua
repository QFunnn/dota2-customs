--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_99"
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
		["33"] = 24,
		["34"] = 29,
		["35"] = 30,
		["36"] = 29,
		["37"] = 35,
		["38"] = 36,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["45"] = 45,
		["46"] = 46,
		["47"] = 47,
		["48"] = 48,
		["49"] = 48,
		["50"] = 48,
		["51"] = 48,
		["52"] = 48,
		["53"] = 48,
		["57"] = 35,
		["58"] = 20,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 20,
		["70"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_99 = c()
local n = g.item_equipment_99
n.name = "item_equipment_99"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_99"
end
n = e({ j(nil) }, n)
g.item_equipment_99 = n
g.modifier_item_equipment_99 = c()
local o = g.modifier_item_equipment_99
o.name = "modifier_item_equipment_99"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { -1, -1 } }
end
function o.prototype.OnHeal(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent()
	local r = self:GetAbility()
	if IsValid(q) and IsValid(r) then
		local s = q:GetEnemy()
		if s == p.target then
			if self:PRD(self.chance) then
				local t = (p.flHealAmount or 0) * self.heal_pct
				Heal(q, t, r:GetAbilityName(), "Ability")
			end
		end
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
g.modifier_item_equipment_99 = o
return g