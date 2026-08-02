--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_131"
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
		["31"] = 20,
		["32"] = 23,
		["33"] = 11,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 25,
		["38"] = 29,
		["39"] = 30,
		["40"] = 30,
		["41"] = 32,
		["42"] = 32,
		["43"] = 32,
		["44"] = 30,
		["45"] = 33,
		["46"] = 33,
		["47"] = 33,
		["48"] = 30,
		["49"] = 30,
		["50"] = 29,
		["51"] = 36,
		["52"] = 37,
		["53"] = 38,
		["54"] = 36,
		["55"] = 40,
		["56"] = 41,
		["57"] = 40,
		["58"] = 43,
		["59"] = 44,
		["62"] = 47,
		["63"] = 48,
		["64"] = 48,
		["65"] = 48,
		["66"] = 48,
		["67"] = 48,
		["68"] = 48,
		["70"] = 43,
		["71"] = 20,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 20,
		["83"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_131 = c()
local n = g.item_equipment_131
n.name = "item_equipment_131"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_131"
end
n = e({ j(nil) }, n)
g.item_equipment_131 = n
g.modifier_item_equipment_131 = c()
local o = g.modifier_item_equipment_131
o.name = "modifier_item_equipment_131"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.flag = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.chaos_bonus = self:GetAbilitySpecialValueFor("chaos_bonus")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnBattleStartBefore(self, p)
	self.source = self:GetAbility():GetAbilityName()
	self.flag = true
end
function o.prototype.OnBattleEnd(self, p)
	self.flag = false
end
function o.prototype.OnCustomTakeDamage(self, q)
	if not self.flag then
		return
	end
	if self:PRD(self.chance) then
		AddChaos(self:GetParent(), self.chaos_bonus, self.source, "Ability")
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
g.modifier_item_equipment_131 = o
return g