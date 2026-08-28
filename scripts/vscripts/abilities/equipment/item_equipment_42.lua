--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_42"
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
		["31"] = 22,
		["32"] = 23,
		["33"] = 22,
		["34"] = 27,
		["35"] = 28,
		["36"] = 27,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["44"] = 32,
		["45"] = 21,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 21,
		["57"] = 21,
		["58"] = 41,
		["59"] = 50,
		["60"] = 41,
		["61"] = 50,
		["62"] = 53,
		["63"] = 54,
		["64"] = 55,
		["65"] = 53,
		["66"] = 57,
		["67"] = 58,
		["68"] = 57,
		["69"] = 50,
		["70"] = 41,
		["71"] = 41,
		["72"] = 41,
		["73"] = 41,
		["74"] = 41,
		["75"] = 41,
		["76"] = 41,
		["77"] = 41,
		["78"] = 41,
		["79"] = 50,
		["81"] = 50,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_42 = c()
local n = g.item_equipment_42
n.name = "item_equipment_42"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_42"
end
n = e({ j(nil) }, n)
g.item_equipment_42 = n
g.modifier_item_equipment_42 = c()
local o = g.modifier_item_equipment_42
o.name = "modifier_item_equipment_42"
d(o, l)
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME] = "particles/items2_fx/skadi_projectile.vpcf" }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self)
	local p = self:GetParent()
	local q = p:GetEnemy()
	local r = self:GetAbility()
	if IsInjurable(q) then
		q:AddNewModifier(p, r, "modifier_item_equipment_42_debuff", nil)
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
g.modifier_item_equipment_42 = o
g.modifier_item_equipment_42_debuff = c()
local s = g.modifier_item_equipment_42_debuff
s.name = "modifier_item_equipment_42_debuff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.hp_regen_fail = self:GetAbilitySpecialValueFor("hp_regen_fail")
	self.hp_regen_reduce = self:GetAbilitySpecialValueFor("hp_regen_reduce")
end
function s.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_HEAL_PERCENTAGE] = self.hp_regen_fail,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY] = -self.hp_regen_reduce,
	}
end
s = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	s
)
g.modifier_item_equipment_42_debuff = s
return g