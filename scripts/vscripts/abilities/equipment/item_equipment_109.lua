--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_109"
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
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 25,
		["35"] = 31,
		["36"] = 32,
		["37"] = 32,
		["38"] = 34,
		["39"] = 34,
		["40"] = 34,
		["41"] = 32,
		["42"] = 32,
		["43"] = 31,
		["44"] = 38,
		["45"] = 39,
		["48"] = 43,
		["49"] = 38,
		["50"] = 46,
		["51"] = 47,
		["52"] = 46,
		["53"] = 50,
		["54"] = 51,
		["55"] = 52,
		["56"] = 53,
		["57"] = 53,
		["58"] = 53,
		["59"] = 53,
		["60"] = 53,
		["61"] = 53,
		["62"] = 54,
		["63"] = 54,
		["64"] = 54,
		["65"] = 54,
		["67"] = 50,
		["68"] = 20,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 20,
		["80"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_109 = c()
local n = g.item_equipment_109
n.name = "item_equipment_109"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_109"
end
n = e({ j(nil) }, n)
g.item_equipment_109 = n
g.modifier_item_equipment_109 = c()
local o = g.modifier_item_equipment_109
o.name = "modifier_item_equipment_109"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.regen = self:GetAbilitySpecialValueFor("regen")
	self.injury_reduce = self:GetAbilitySpecialValueFor("injury_reduce")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function o.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	if q:GetHealthPercent() < self.threshold then
		Heal(q, self.regen, self:GetAbility():GetAbilityName(), "Ability")
		ReduceInjury(q, GetInjury(q) * self.injury_reduce * 0.01)
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
g.modifier_item_equipment_109 = o
return g