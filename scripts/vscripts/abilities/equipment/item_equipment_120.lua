--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_120"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 29,
		["38"] = 29,
		["39"] = 29,
		["40"] = 29,
		["41"] = 29,
		["42"] = 26,
		["43"] = 20,
		["44"] = 11,
		["45"] = 11,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 20,
		["55"] = 20,
		["56"] = 32,
		["57"] = 41,
		["58"] = 32,
		["59"] = 41,
		["60"] = 44,
		["61"] = 45,
		["62"] = 44,
		["63"] = 47,
		["64"] = 48,
		["65"] = 47,
		["66"] = 52,
		["67"] = 53,
		["68"] = 54,
		["69"] = 54,
		["70"] = 53,
		["71"] = 52,
		["72"] = 57,
		["73"] = 58,
		["74"] = 57,
		["75"] = 41,
		["76"] = 32,
		["77"] = 32,
		["78"] = 32,
		["79"] = 32,
		["80"] = 32,
		["81"] = 32,
		["82"] = 32,
		["83"] = 32,
		["84"] = 32,
		["85"] = 41,
		["87"] = 41,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_120 = c()
local n = g.item_equipment_120
n.name = "item_equipment_120"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_120"
end
n = e({ j(nil) }, n)
g.item_equipment_120 = n
g.modifier_item_equipment_120 = c()
local o = g.modifier_item_equipment_120
o.name = "modifier_item_equipment_120"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self, p)
	local q = self:GetParent()
	local r = q:GetEnemy()
	r:AddNewModifier(q, self:GetAbility(), "modifier_item_equipment_120_buff", {})
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
g.modifier_item_equipment_120 = o
g.modifier_item_equipment_120_buff = c()
local s = g.modifier_item_equipment_120_buff
s.name = "modifier_item_equipment_120_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.injury = self:GetAbilitySpecialValueFor("injury")
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS] = self.injury }
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function s.prototype.OnBattleEnd(self, p)
	self:Destroy()
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
g.modifier_item_equipment_120_buff = s
return g