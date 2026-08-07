--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_100"
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
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 25,
		["35"] = 31,
		["36"] = 32,
		["37"] = 31,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 41,
		["45"] = 36,
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
		["59"] = 46,
		["60"] = 55,
		["61"] = 46,
		["62"] = 55,
		["63"] = 57,
		["64"] = 58,
		["65"] = 57,
		["66"] = 60,
		["67"] = 61,
		["68"] = 60,
		["69"] = 65,
		["70"] = 66,
		["71"] = 65,
		["72"] = 68,
		["73"] = 69,
		["74"] = 68,
		["75"] = 55,
		["76"] = 46,
		["77"] = 46,
		["78"] = 46,
		["79"] = 46,
		["80"] = 46,
		["81"] = 46,
		["82"] = 46,
		["83"] = 46,
		["84"] = 46,
		["85"] = 55,
		["87"] = 55,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_100 = c()
local n = g.item_equipment_100
n.name = "item_equipment_100"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_100"
end
n = e({ j(nil) }, n)
g.item_equipment_100 = n
g.modifier_item_equipment_100 = c()
local o = g.modifier_item_equipment_100
o.name = "modifier_item_equipment_100"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self, p)
	local q = self:GetParent()
	local r = q:GetEnemy()
	local s = self:GetAbility()
	if IsInjurable(q, r) then
		r:AddNewModifier(q, s, "modifier_item_equipment_100_debuff", { duration = self.duration, stack = 1 })
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
g.modifier_item_equipment_100 = o
g.modifier_item_equipment_100_debuff = c()
local t = g.modifier_item_equipment_100_debuff
t.name = "modifier_item_equipment_100_debuff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.regen_reduce = self:GetAbilitySpecialValueFor("regen_reduce")
end
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY }
end
function t.prototype.EOM_GetModifierHealAmplity(self, p)
	return -self.regen_reduce
end
function t.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_frost.vpcf"
end
t = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	t
)
g.modifier_item_equipment_100_debuff = t
return g