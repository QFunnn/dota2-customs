--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_77"
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
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 24,
		["35"] = 30,
		["36"] = 31,
		["37"] = 30,
		["38"] = 36,
		["39"] = 37,
		["40"] = 36,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["45"] = 44,
		["48"] = 40,
		["49"] = 20,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 20,
		["61"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_77 = c()
local n = g.item_equipment_77
n.name = "item_equipment_77"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_77"
end
n = e({ j(nil) }, n)
g.item_equipment_77 = n
g.modifier_item_equipment_77 = c()
local o = g.modifier_item_equipment_77
o.name = "modifier_item_equipment_77"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.evade = self:GetAbilitySpecialValueFor("evade")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.evade_factor = self:GetAbilitySpecialValueFor("evade_factor")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.evade }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PARRY_DAMAGE }
end
function o.prototype.EOM_GetModifierParryDamage(self, p)
	if IsServer() then
		if self:PRD(self.chance) then
			local q = self:GetParent()
			return self.evade_factor * GetEvasion(q)
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
g.modifier_item_equipment_77 = o
return g