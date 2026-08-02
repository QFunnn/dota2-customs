--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_94"
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
		["41"] = 35,
		["42"] = 37,
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 40,
		["47"] = 40,
		["48"] = 40,
		["49"] = 40,
		["50"] = 40,
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
g.item_equipment_94 = c()
local n = g.item_equipment_94
n.name = "item_equipment_94"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_94"
end
n = e({ j(nil) }, n)
g.item_equipment_94 = n
g.modifier_item_equipment_94 = c()
local o = g.modifier_item_equipment_94
o.name = "modifier_item_equipment_94"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.heal = self:GetAbilitySpecialValueFor("heal")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function o.prototype.OnCustomTakeDamage(self, p)
	local q = self:GetParent()
	local r = self:GetAbility()
	if IsValid(q) and p.is_crit and IsValid(r) then
		if r:IsCooldownReady() then
			r:StartCooldown(-1)
			Heal(q, self.heal, r:GetAbilityName(), "Ability")
		end
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
g.modifier_item_equipment_94 = o
return g