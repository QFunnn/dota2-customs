--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_61"
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
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 25,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 32,
		["40"] = 32,
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 30,
		["45"] = 36,
		["46"] = 37,
		["47"] = 38,
		["48"] = 39,
		["51"] = 40,
		["52"] = 41,
		["53"] = 42,
		["54"] = 43,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 43,
		["60"] = 36,
		["61"] = 47,
		["62"] = 48,
		["63"] = 47,
		["64"] = 21,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 21,
		["76"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_61 = c()
local n = g.item_equipment_61
n.name = "item_equipment_61"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_61"
end
n = e({ j(nil) }, n)
g.item_equipment_61 = n
g.modifier_item_equipment_61 = c()
local o = g.modifier_item_equipment_61
o.name = "modifier_item_equipment_61"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.ice_count = self:GetAbilitySpecialValueFor("ice_count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.IceCounter = 0
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function o.prototype.OnIceGained(self, p)
	local q = self:GetParent()
	local r = q:GetEnemy()
	if not IsValid(r) then
		return
	end
	self.IceCounter = self.IceCounter + 1
	if self.IceCounter >= self.ice_count then
		self.IceCounter = self.IceCounter - self.ice_count
		q:DealChaosDamage(r, self:GetAbility(), self.damage)
	end
end
function o.prototype.OnBattleStart(self, p)
	self.IceCounter = 0
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
g.modifier_item_equipment_61 = o
return g