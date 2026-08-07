--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_62"
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
		["37"] = 29,
		["38"] = 31,
		["39"] = 31,
		["40"] = 31,
		["41"] = 29,
		["42"] = 29,
		["43"] = 28,
		["44"] = 34,
		["45"] = 35,
		["46"] = 34,
		["47"] = 37,
		["48"] = 38,
		["49"] = 37,
		["50"] = 40,
		["51"] = 41,
		["52"] = 42,
		["53"] = 42,
		["54"] = 42,
		["55"] = 42,
		["56"] = 40,
		["57"] = 21,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 21,
		["69"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_62 = c()
local n = g.item_equipment_62
n.name = "item_equipment_62"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_62"
end
n = e({ j(nil) }, n)
g.item_equipment_62 = n
g.modifier_item_equipment_62 = c()
local o = g.modifier_item_equipment_62
o.name = "modifier_item_equipment_62"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.poison_reduce = self:GetAbilitySpecialValueFor("poison_reduce")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self)
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local p = self:GetParent()
	ReducePoison(p, math.ceil(GetPoison(p) * self.poison_reduce * 0.01))
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
g.modifier_item_equipment_62 = o
return g