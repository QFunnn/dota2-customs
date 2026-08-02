--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_142"
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
		["32"] = 21,
		["33"] = 28,
		["34"] = 12,
		["35"] = 29,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 29,
		["41"] = 36,
		["42"] = 37,
		["44"] = 36,
		["45"] = 41,
		["46"] = 42,
		["47"] = 41,
		["48"] = 46,
		["49"] = 47,
		["50"] = 48,
		["51"] = 49,
		["54"] = 53,
		["55"] = 54,
		["57"] = 56,
		["58"] = 57,
		["59"] = 58,
		["60"] = 59,
		["61"] = 59,
		["62"] = 59,
		["63"] = 59,
		["64"] = 59,
		["65"] = 59,
		["67"] = 46,
		["68"] = 63,
		["69"] = 64,
		["70"] = 65,
		["71"] = 66,
		["72"] = 67,
		["73"] = 63,
		["74"] = 21,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 21,
		["86"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_142 = c()
local n = g.item_equipment_142
n.name = "item_equipment_142"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_142"
end
n = e({ j(nil) }, n)
g.item_equipment_142 = n
g.modifier_item_equipment_142 = c()
local o = g.modifier_item_equipment_142
o.name = "modifier_item_equipment_142"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.steal_fury = self:GetAbilitySpecialValueFor("steal_fury")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() } }
end
function o.prototype.OnCustomAttackLanded(self, q)
	local r = self:GetParent()
	local s = r:GetEnemy()
	if not IsInjurable(r, s) then
		return
	end
	if self:PRD(self.chance) then
		self:EquipmentEffect(s)
	end
	self.record = self.record + 1
	if self.record == self.count then
		self.record = 0
		r:DealDamage(s, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	end
end
function o.prototype.EquipmentEffect(self, t)
	local u = 0
	ReduceFury(t, self.steal_fury)
	u = u + self.steal_fury
	AddFury(self.parent, u, "item_equipment_142", "Ability")
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
g.modifier_item_equipment_142 = o
return g