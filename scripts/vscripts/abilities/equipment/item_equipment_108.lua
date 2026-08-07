--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_108"
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
		["32"] = 23,
		["33"] = 27,
		["34"] = 28,
		["35"] = 29,
		["36"] = 29,
		["37"] = 28,
		["38"] = 27,
		["39"] = 33,
		["40"] = 34,
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 41,
		["47"] = 41,
		["48"] = 41,
		["49"] = 41,
		["50"] = 41,
		["51"] = 41,
		["53"] = 33,
		["54"] = 20,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 20,
		["66"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_108 = c()
local n = g.item_equipment_108
n.name = "item_equipment_108"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_108"
end
n = e({ j(nil) }, n)
g.item_equipment_108 = n
g.modifier_item_equipment_108 = c()
local o = g.modifier_item_equipment_108
o.name = "modifier_item_equipment_108"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.injury_factor = self:GetAbilitySpecialValueFor("injury_factor")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomAttackLanded(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent()
	local r = p.target
	if IsInjurable(q, r) then
		q:DealDamage(
			r,
			self:GetAbility(),
			GetInjury(q) * self.injury_factor * 0.01,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
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
g.modifier_item_equipment_108 = o
return g