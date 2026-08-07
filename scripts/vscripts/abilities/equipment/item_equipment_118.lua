--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_118"
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
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["35"] = 26,
		["36"] = 32,
		["37"] = 33,
		["38"] = 34,
		["39"] = 34,
		["40"] = 34,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["44"] = 32,
		["45"] = 38,
		["46"] = 39,
		["47"] = 38,
		["48"] = 41,
		["49"] = 42,
		["50"] = 41,
		["51"] = 44,
		["52"] = 45,
		["53"] = 46,
		["54"] = 47,
		["55"] = 48,
		["56"] = 48,
		["57"] = 48,
		["58"] = 48,
		["59"] = 48,
		["60"] = 48,
		["61"] = 48,
		["62"] = 44,
		["63"] = 20,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 20,
		["75"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_118 = c()
local n = g.item_equipment_118
n.name = "item_equipment_118"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_118"
end
n = e({ j(nil) }, n)
g.item_equipment_118 = n
g.modifier_item_equipment_118 = c()
local o = g.modifier_item_equipment_118
o.name = "modifier_item_equipment_118"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.poison = self:GetAbilitySpecialValueFor("poison")
	self.round = self:GetAbilitySpecialValueFor("round")
	self.bonus_poison = self:GetAbilitySpecialValueFor("bonus_poison")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function o.prototype.OnBattleStart(self)
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	local r = q:GetEnemy()
	local s = self.poison + self.bonus_poison * math.floor(Rounds:getCurrentRound() / self.round)
	AddPoison(q, r, s, self:GetAbility():GetAbilityName(), "Ability")
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
g.modifier_item_equipment_118 = o
return g