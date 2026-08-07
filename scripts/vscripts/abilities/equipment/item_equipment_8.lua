--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_8"
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
		["33"] = 27,
		["34"] = 24,
		["35"] = 29,
		["36"] = 30,
		["37"] = 30,
		["38"] = 32,
		["39"] = 32,
		["40"] = 32,
		["41"] = 30,
		["42"] = 30,
		["43"] = 29,
		["44"] = 35,
		["45"] = 36,
		["46"] = 37,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["52"] = 38,
		["53"] = 39,
		["54"] = 40,
		["55"] = 41,
		["56"] = 42,
		["57"] = 42,
		["58"] = 42,
		["59"] = 42,
		["60"] = 42,
		["61"] = 42,
		["64"] = 35,
		["65"] = 46,
		["66"] = 47,
		["67"] = 46,
		["68"] = 49,
		["69"] = 50,
		["70"] = 49,
		["71"] = 20,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 20,
		["83"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
g.item_equipment_8 = c()
local n = g.item_equipment_8
n.name = "item_equipment_8"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_8"
end
n = e({ j(nil) }, n)
g.item_equipment_8 = n
g.modifier_item_equipment_8 = c()
local o = g.modifier_item_equipment_8
o.name = "modifier_item_equipment_8"
d(o, m)
function o.prototype.GetAbilitySpecialValue(self)
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.damage_factor = self:GetAbilitySpecialValueFor("damage_factor")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnIntervalThink(self)
	local p = self:GetParent()
	local q = p:GetEnemy()
	AddFury(p, self.stack, self:GetAbility():GetName(), "Ability")
	if IsInjurable(q) then
		local r = p:FindModifierByName("modifier_fury_custom")
		if IsValid(r) then
			p:DealDamage(
				q,
				self:GetAbility(),
				r:GetStackCount() * self.damage_factor * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
		end
	end
end
function o.prototype.OnBattleStart(self)
	self:StartIntervalThink(self.tick)
end
function o.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
o = e(
	{
		l(
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
g.modifier_item_equipment_8 = o
return g