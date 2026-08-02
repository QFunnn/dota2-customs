--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_11"
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
		["36"] = 30,
		["37"] = 30,
		["38"] = 30,
		["39"] = 29,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 29,
		["44"] = 32,
		["45"] = 32,
		["46"] = 32,
		["47"] = 29,
		["48"] = 29,
		["49"] = 28,
		["50"] = 35,
		["51"] = 36,
		["52"] = 35,
		["53"] = 42,
		["54"] = 43,
		["55"] = 44,
		["56"] = 45,
		["57"] = 45,
		["58"] = 45,
		["59"] = 45,
		["61"] = 42,
		["62"] = 48,
		["63"] = 49,
		["64"] = 50,
		["65"] = 51,
		["66"] = 51,
		["67"] = 51,
		["68"] = 51,
		["70"] = 48,
		["71"] = 54,
		["72"] = 55,
		["73"] = 56,
		["74"] = 57,
		["75"] = 57,
		["76"] = 57,
		["77"] = 57,
		["79"] = 54,
		["80"] = 20,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 20,
		["92"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_11 = c()
local n = g.item_equipment_11
n.name = "item_equipment_11"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_11"
end
n = e({ j(nil) }, n)
g.item_equipment_11 = n
g.modifier_item_equipment_11 = c()
local o = g.modifier_item_equipment_11
o.name = "modifier_item_equipment_11"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.stack_reduce = self:GetAbilitySpecialValueFor("stack_reduce")
	self.buff_per = self:GetAbilitySpecialValueFor("buff_per")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { -1, self:GetParent() },
	}
end
function o.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS_PERCENTAGE] = -self.buff_per,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS_PERCENTAGE] = -self.buff_per,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS_PERCENTAGE] = -self.buff_per,
	}
end
function o.prototype.OnIceGained(self, p)
	if p then
		local q = math.min(p.iStackCount, self.stack_reduce)
		ReduceIce(self:GetParent(), q)
	end
end
function o.prototype.OnInjuryGained(self, p)
	if p then
		local q = math.min(p.iStackCount, self.stack_reduce)
		ReduceInjury(self:GetParent(), q)
	end
end
function o.prototype.OnPoisonGained(self, p)
	if p then
		local q = math.min(p.iStackCount, self.stack_reduce)
		ReducePoison(self:GetParent(), q)
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
g.modifier_item_equipment_11 = o
return g