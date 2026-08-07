--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_80"
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
		["34"] = 28,
		["35"] = 29,
		["36"] = 28,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 32,
		["42"] = 20,
		["43"] = 11,
		["44"] = 11,
		["45"] = 11,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 20,
		["54"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_80 = c()
local n = g.item_equipment_80
n.name = "item_equipment_80"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_80"
end
n = e({ j(nil) }, n)
g.item_equipment_80 = n
g.modifier_item_equipment_80 = c()
local o = g.modifier_item_equipment_80
o.name = "modifier_item_equipment_80"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.base_health = self:GetAbilitySpecialValueFor("base_health")
	self.level_hp = self:GetAbilitySpecialValueFor("level_hp")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function o.prototype.EOM_GetModifierHealthBonus(self, p)
	local q = self:GetParent()
	local r = PlayerData:getHero(q:GetPlayerOwnerID())
	return self.level_hp * (r and r:getLevel() or 0)
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
g.modifier_item_equipment_80 = o
return g