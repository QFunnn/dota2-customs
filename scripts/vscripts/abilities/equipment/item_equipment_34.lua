--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_34"
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
		["40"] = 34,
		["41"] = 36,
		["42"] = 36,
		["43"] = 36,
		["44"] = 34,
		["45"] = 34,
		["46"] = 33,
		["47"] = 39,
		["48"] = 40,
		["49"] = 39,
		["50"] = 42,
		["51"] = 43,
		["52"] = 42,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 48,
		["57"] = 49,
		["58"] = 49,
		["59"] = 49,
		["60"] = 49,
		["61"] = 49,
		["62"] = 49,
		["63"] = 45,
		["64"] = 21,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 21,
		["76"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_34 = c()
local n = g.item_equipment_34
n.name = "item_equipment_34"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_34"
end
n = e({ j(nil) }, n)
g.item_equipment_34 = n
g.modifier_item_equipment_34 = c()
local o = g.modifier_item_equipment_34
o.name = "modifier_item_equipment_34"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.hp_regen_per_second = self:GetAbilitySpecialValueFor("hp_regen_per_second")
	self.hp_regen_percent = self:GetAbilitySpecialValueFor("hp_regen_percent")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY] = self.hp_regen_percent }
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self)
	self:StartIntervalThink(1)
end
function o.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local p = self:GetParent()
	local q = self:GetAbility()
	local r = p:GetMaxHealth() * self.hp_regen_per_second * 0.01
	Heal(p, r, q:GetAbilityName(), "Ability")
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
g.modifier_item_equipment_34 = o
return g