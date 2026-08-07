--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_49"
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
		["31"] = 23,
		["32"] = 24,
		["33"] = 23,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["39"] = 26,
		["40"] = 32,
		["41"] = 33,
		["42"] = 32,
		["43"] = 37,
		["44"] = 38,
		["45"] = 37,
		["46"] = 21,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 21,
		["58"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_49 = c()
local n = g.item_equipment_49
n.name = "item_equipment_49"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_49"
end
n = e({ j(nil) }, n)
g.item_equipment_49 = n
g.modifier_item_equipment_49 = c()
local o = g.modifier_item_equipment_49
o.name = "modifier_item_equipment_49"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.atk_speed_bonus = self:GetAbilitySpecialValueFor("atk_speed_bonus")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self:GetTotalWin())
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function o.prototype.EOM_GetModifierAttackSpeedBonus(self, p)
	return self.atk_speed_bonus * self:GetStackCount()
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
g.modifier_item_equipment_49 = o
return g