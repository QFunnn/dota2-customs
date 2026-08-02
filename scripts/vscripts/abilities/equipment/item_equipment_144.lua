--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_144"
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
		["35"] = 26,
		["36"] = 27,
		["37"] = 28,
		["38"] = 29,
		["39"] = 26,
		["40"] = 31,
		["41"] = 32,
		["42"] = 32,
		["43"] = 34,
		["44"] = 34,
		["45"] = 34,
		["46"] = 32,
		["47"] = 32,
		["48"] = 31,
		["49"] = 37,
		["50"] = 38,
		["51"] = 37,
		["52"] = 40,
		["53"] = 41,
		["56"] = 42,
		["57"] = 43,
		["58"] = 44,
		["59"] = 45,
		["60"] = 45,
		["61"] = 45,
		["62"] = 45,
		["63"] = 45,
		["64"] = 45,
		["66"] = 40,
		["67"] = 21,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 21,
		["79"] = 21,
		["80"] = 50,
		["81"] = 59,
		["82"] = 50,
		["83"] = 59,
		["84"] = 61,
		["85"] = 62,
		["86"] = 61,
		["87"] = 64,
		["88"] = 65,
		["89"] = 64,
		["90"] = 59,
		["91"] = 50,
		["92"] = 50,
		["93"] = 50,
		["94"] = 50,
		["95"] = 50,
		["96"] = 50,
		["97"] = 50,
		["98"] = 50,
		["99"] = 50,
		["100"] = 59,
		["102"] = 59,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_144 = c()
local n = g.item_equipment_144
n.name = "item_equipment_144"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_144"
end
n = e({ j(nil) }, n)
g.item_equipment_144 = n
g.modifier_item_equipment_144 = c()
local o = g.modifier_item_equipment_144
o.name = "modifier_item_equipment_144"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.hasTrigger = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.trigger_chance = self:GetAbilitySpecialValueFor("trigger_chance")
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
	if r < self.trigger_chance then
		self.hasTrigger = true
		self.caster:AddNewModifier(
			self.caster,
			self:GetAbility(),
			"modifier_item_equipment_144_steal",
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
g.modifier_item_equipment_144 = o
g.modifier_item_equipment_144_steal = c()
local s = g.modifier_item_equipment_144_steal
s.name = "modifier_item_equipment_144_steal"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.add_ability_life_steal = self:GetAbilitySpecialValueFor("add_ability_life_steal")
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL] = self.add_ability_life_steal }
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	s
)
g.modifier_item_equipment_144_steal = s
return g