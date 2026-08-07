--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_122"
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
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["44"] = 26,
		["45"] = 20,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 20,
		["57"] = 20,
		["58"] = 34,
		["59"] = 43,
		["60"] = 34,
		["61"] = 43,
		["62"] = 46,
		["63"] = 47,
		["64"] = 46,
		["65"] = 49,
		["66"] = 50,
		["67"] = 49,
		["68"] = 54,
		["69"] = 55,
		["70"] = 56,
		["71"] = 56,
		["72"] = 55,
		["73"] = 54,
		["74"] = 59,
		["75"] = 60,
		["76"] = 59,
		["77"] = 43,
		["78"] = 34,
		["79"] = 34,
		["80"] = 34,
		["81"] = 34,
		["82"] = 34,
		["83"] = 34,
		["84"] = 34,
		["85"] = 34,
		["86"] = 34,
		["87"] = 43,
		["89"] = 43,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_122 = c()
local n = g.item_equipment_122
n.name = "item_equipment_122"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_122"
end
n = e({ j(nil) }, n)
g.item_equipment_122 = n
g.modifier_item_equipment_122 = c()
local o = g.modifier_item_equipment_122
o.name = "modifier_item_equipment_122"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self, p)
	local q = self:GetParent()
	local r = q:GetEnemy()
	if IsInjurable(r) then
		r:AddNewModifier(q, self:GetAbility(), "modifier_item_equipment_122_buff", {})
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
g.modifier_item_equipment_122 = o
g.modifier_item_equipment_122_buff = c()
local s = g.modifier_item_equipment_122_buff
s.name = "modifier_item_equipment_122_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER] = -self.reduce }
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
				IsDebuff = true,
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
g.modifier_item_equipment_122_buff = s
return g