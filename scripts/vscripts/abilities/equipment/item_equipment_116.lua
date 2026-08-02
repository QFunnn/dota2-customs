--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_116"
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
		["35"] = 30,
		["36"] = 31,
		["37"] = 31,
		["38"] = 33,
		["39"] = 33,
		["40"] = 33,
		["41"] = 31,
		["42"] = 31,
		["43"] = 30,
		["44"] = 36,
		["45"] = 37,
		["46"] = 36,
		["47"] = 39,
		["48"] = 40,
		["49"] = 39,
		["50"] = 42,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["55"] = 46,
		["56"] = 46,
		["57"] = 46,
		["58"] = 46,
		["59"] = 46,
		["60"] = 47,
		["61"] = 47,
		["62"] = 47,
		["63"] = 47,
		["64"] = 47,
		["65"] = 47,
		["67"] = 42,
		["68"] = 20,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 20,
		["80"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_116 = c()
local n = g.item_equipment_116
n.name = "item_equipment_116"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_116"
end
n = e({ j(nil) }, n)
g.item_equipment_116 = n
g.modifier_item_equipment_116 = c()
local o = g.modifier_item_equipment_116
o.name = "modifier_item_equipment_116"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.fury = self:GetAbilitySpecialValueFor("fury")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self, p)
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	local r = q:GetEnemy()
	if IsInjurable(q, r) then
		AddFury(q, self.fury, self:GetAbility():GetAbilityName(), "Ability")
		q:DealDamage(r, self:GetAbility(), self.damage * GetFury(q) * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
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
g.modifier_item_equipment_116 = o
return g