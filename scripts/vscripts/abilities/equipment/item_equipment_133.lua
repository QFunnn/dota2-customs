--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_133"
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
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 28,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 28,
		["41"] = 28,
		["42"] = 27,
		["43"] = 33,
		["44"] = 34,
		["45"] = 33,
		["46"] = 36,
		["47"] = 37,
		["48"] = 36,
		["49"] = 39,
		["50"] = 40,
		["51"] = 41,
		["52"] = 42,
		["53"] = 43,
		["54"] = 44,
		["57"] = 47,
		["58"] = 48,
		["59"] = 48,
		["60"] = 48,
		["61"] = 48,
		["62"] = 48,
		["63"] = 48,
		["64"] = 49,
		["66"] = 39,
		["67"] = 20,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 20,
		["79"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_133 = c()
local n = g.item_equipment_133
n.name = "item_equipment_133"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_133"
end
n = e({ j(nil) }, n)
g.item_equipment_133 = n
g.modifier_item_equipment_133 = c()
local o = g.modifier_item_equipment_133
o.name = "modifier_item_equipment_133"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.steal_pct = self:GetAbilitySpecialValueFor("steal_pct")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStartBefore(self, p)
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		local q = self:GetParent()
		local r = q:GetEnemy()
		if not IsInjurable(q, r) then
			self:StartIntervalThink(-1)
			return
		end
		local s = GetChaos(r, true) * self.steal_pct * 0.01
		AddChaos(q, s, self:GetAbility():GetAbilityName(), "Ability")
		ReduceChaos(r, s)
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
g.modifier_item_equipment_133 = o
return g