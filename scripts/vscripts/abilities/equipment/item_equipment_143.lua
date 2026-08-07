--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_143"
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
		["32"] = 21,
		["33"] = 22,
		["34"] = 12,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 27,
		["41"] = 33,
		["42"] = 34,
		["43"] = 34,
		["44"] = 36,
		["45"] = 36,
		["46"] = 36,
		["47"] = 34,
		["48"] = 34,
		["49"] = 33,
		["50"] = 39,
		["51"] = 40,
		["52"] = 39,
		["53"] = 42,
		["54"] = 43,
		["57"] = 44,
		["58"] = 45,
		["59"] = 46,
		["60"] = 47,
		["61"] = 47,
		["62"] = 47,
		["63"] = 47,
		["64"] = 47,
		["65"] = 47,
		["67"] = 42,
		["68"] = 21,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 21,
		["80"] = 21,
		["81"] = 52,
		["82"] = 60,
		["83"] = 52,
		["84"] = 60,
		["85"] = 62,
		["86"] = 63,
		["87"] = 62,
		["88"] = 65,
		["89"] = 66,
		["90"] = 65,
		["91"] = 60,
		["92"] = 52,
		["93"] = 52,
		["94"] = 52,
		["95"] = 52,
		["96"] = 52,
		["97"] = 52,
		["98"] = 52,
		["99"] = 52,
		["100"] = 60,
		["102"] = 60,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_143 = c()
local n = g.item_equipment_143
n.name = "item_equipment_143"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_143"
end
n = e({ j(nil) }, n)
g.item_equipment_143 = n
g.modifier_item_equipment_143 = c()
local o = g.modifier_item_equipment_143
o.name = "modifier_item_equipment_143"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.hasTrigger = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.item_attack = self:GetAbilitySpecialValueFor("item_attack")
	self.item_lifesteal = self:GetAbilitySpecialValueFor("item_lifesteal")
	self.trigger_hp_pct = self:GetAbilitySpecialValueFor("trigger_hp_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function o.prototype.OnBattleStartBefore(self, p)
	self.hasTrigger = false
end
function o.prototype.OnCustomTakeDamage(self, q)
	if self.hasTrigger then
		return
	end
	local r = self.caster:GetHealth() / self.caster:GetMaxHealth() * 100
	if r < self.trigger_hp_pct then
		self.hasTrigger = true
		self.caster:AddNewModifier(
			self.caster,
			self:GetAbility(),
			"modifier_item_equipment_143_steal",
			{ duration = self.duration }
		)
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
g.modifier_item_equipment_143 = o
g.modifier_item_equipment_143_steal = c()
local s = g.modifier_item_equipment_143_steal
s.name = "modifier_item_equipment_143_steal"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.steal_hp_pct = self:GetAbilitySpecialValueFor("steal_hp_pct")
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL] = self.steal_hp_pct }
end
s = e(
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
			}
		),
	},
	s
)
g.modifier_item_equipment_143_steal = s
return g