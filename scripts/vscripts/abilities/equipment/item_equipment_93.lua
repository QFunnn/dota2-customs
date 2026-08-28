--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_93"
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
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["45"] = 39,
		["46"] = 40,
		["49"] = 33,
		["50"] = 20,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 20,
		["62"] = 20,
		["63"] = 47,
		["64"] = 56,
		["65"] = 47,
		["66"] = 56,
		["67"] = 59,
		["68"] = 60,
		["69"] = 59,
		["70"] = 63,
		["71"] = 64,
		["72"] = 63,
		["73"] = 56,
		["74"] = 47,
		["75"] = 47,
		["76"] = 47,
		["77"] = 47,
		["78"] = 47,
		["79"] = 47,
		["80"] = 47,
		["81"] = 47,
		["82"] = 47,
		["83"] = 56,
		["85"] = 56,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_93 = c()
local n = g.item_equipment_93
n.name = "item_equipment_93"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_93"
end
n = e({ j(nil) }, n)
g.item_equipment_93 = n
g.modifier_item_equipment_93 = c()
local o = g.modifier_item_equipment_93
o.name = "modifier_item_equipment_93"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomAttackLanded(self, p)
	local q = self:GetParent()
	local r = self:GetAbility()
	local s = p.target
	if IsValid(q) and IsInjurable(q, s) and IsValid(r) then
		if r:IsCooldownReady() then
			r:StartCooldown(-1)
			s:AddNewModifier(q, r, "modifier_item_equipment_93_debuff", { duration = self.duration })
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
g.modifier_item_equipment_93 = o
g.modifier_item_equipment_93_debuff = c()
local t = g.modifier_item_equipment_93_debuff
t.name = "modifier_item_equipment_93_debuff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.evade_reduce = self:GetAbilitySpecialValueFor("evade_reduce")
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = -self.evade_reduce }
end
t = e(
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
	t
)
g.modifier_item_equipment_93_debuff = t
return g