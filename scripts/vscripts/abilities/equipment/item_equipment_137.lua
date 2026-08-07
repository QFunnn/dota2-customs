--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_137"
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
		["35"] = 26,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["40"] = 31,
		["41"] = 36,
		["42"] = 37,
		["43"] = 36,
		["44"] = 41,
		["45"] = 42,
		["46"] = 43,
		["48"] = 41,
		["49"] = 46,
		["50"] = 47,
		["51"] = 48,
		["52"] = 49,
		["53"] = 50,
		["54"] = 50,
		["55"] = 50,
		["56"] = 50,
		["57"] = 50,
		["58"] = 50,
		["59"] = 46,
		["60"] = 21,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 21,
		["72"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_137 = c()
local n = g.item_equipment_137
n.name = "item_equipment_137"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_137"
end
n = e({ j(nil) }, n)
g.item_equipment_137 = n
g.modifier_item_equipment_137 = c()
local o = g.modifier_item_equipment_137
o.name = "modifier_item_equipment_137"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.cd = self:GetAbilitySpecialValueFor("cd")
	self.stun = self:GetAbilitySpecialValueFor("stun")
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		self.cooldown = false
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() } }
end
function o.prototype.OnCustomAttackLanded(self, p)
	if not self.cooldown and self:PRD(self.chance) then
		self:EquipmentEffect(p.target)
	end
end
function o.prototype.EquipmentEffect(self, q)
	self.cooldown = true
	self:StartIntervalThink(self.cd)
	q:EmitSound("DOTA_Item.SkullBasher")
	AddStun(self:GetParent(), q, self:GetAbility(), self.stun)
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
g.modifier_item_equipment_137 = o
return g