--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_63"
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
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 30,
		["36"] = 26,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 34,
		["41"] = 33,
		["42"] = 32,
		["43"] = 37,
		["44"] = 38,
		["45"] = 39,
		["46"] = 39,
		["47"] = 39,
		["48"] = 39,
		["49"] = 40,
		["51"] = 37,
		["52"] = 43,
		["53"] = 44,
		["54"] = 43,
		["55"] = 48,
		["56"] = 49,
		["57"] = 48,
		["58"] = 21,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 21,
		["70"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_63 = c()
local n = g.item_equipment_63
n.name = "item_equipment_63"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_63"
end
n = e({ j(nil) }, n)
g.item_equipment_63 = n
g.modifier_item_equipment_63 = c()
local o = g.modifier_item_equipment_63
o.name = "modifier_item_equipment_63"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.hp_loss = self:GetAbilitySpecialValueFor("hp_loss")
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	self.iStack = 0
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function o.prototype.OnCustomTakeDamage(self, p)
	if p and IsInjurable(p.target) then
		self.iStack = math.min(math.floor((100 - p.target:GetHealthPercent()) / self.hp_loss), self.max_stack)
		self:SetStackCount(self.iStack)
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function o.prototype.EOM_GetModifierIncomingDamagePercentage(self, q)
	return -self.damage_reduce * self:GetStackCount()
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
g.modifier_item_equipment_63 = o
return g