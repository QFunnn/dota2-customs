--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_106"
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
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 24,
		["34"] = 29,
		["35"] = 30,
		["36"] = 30,
		["37"] = 32,
		["38"] = 32,
		["39"] = 32,
		["40"] = 30,
		["41"] = 30,
		["42"] = 29,
		["43"] = 36,
		["44"] = 37,
		["47"] = 41,
		["48"] = 36,
		["49"] = 44,
		["50"] = 45,
		["51"] = 44,
		["52"] = 48,
		["53"] = 49,
		["54"] = 50,
		["55"] = 51,
		["56"] = 52,
		["57"] = 52,
		["58"] = 52,
		["59"] = 52,
		["60"] = 52,
		["61"] = 52,
		["63"] = 48,
		["64"] = 20,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 20,
		["76"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_106 = c()
local n = g.item_equipment_106
n.name = "item_equipment_106"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_106"
end
n = e({ j(nil) }, n)
g.item_equipment_106 = n
g.modifier_item_equipment_106 = c()
local o = g.modifier_item_equipment_106
o.name = "modifier_item_equipment_106"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.damage_factor = self:GetAbilitySpecialValueFor("damage_factor")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	local r = q:GetEnemy()
	if IsInjurable(q, r) then
		q:DealDamage(
			r,
			self:GetAbility(),
			GetAttackDamage(q) * self.damage_factor * 0.01,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE
		)
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
g.modifier_item_equipment_106 = o
return g