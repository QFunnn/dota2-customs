--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_98"
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
		["33"] = 24,
		["34"] = 29,
		["35"] = 30,
		["36"] = 29,
		["37"] = 35,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["45"] = 35,
		["46"] = 20,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 20,
		["58"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_98 = c()
local n = g.item_equipment_98
n.name = "item_equipment_98"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_98"
end
n = e({ j(nil) }, n)
g.item_equipment_98 = n
g.modifier_item_equipment_98 = c()
local o = g.modifier_item_equipment_98
o.name = "modifier_item_equipment_98"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function o.prototype.EOM_GetModifierOutgoingDamagePercentage(self, p)
	if p then
		local q = p.target
		if IsValid(q) then
			local r = math.floor(q:GetHealth() / self.threshold)
			return r * self.bonus_damage
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
g.modifier_item_equipment_98 = o
return g