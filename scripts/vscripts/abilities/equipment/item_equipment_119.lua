--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_119"
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
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 28,
		["37"] = 27,
		["38"] = 26,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 37,
		["47"] = 37,
		["48"] = 37,
		["49"] = 37,
		["50"] = 42,
		["51"] = 43,
		["52"] = 44,
		["53"] = 44,
		["54"] = 44,
		["55"] = 44,
		["56"] = 44,
		["58"] = 37,
		["59"] = 37,
		["61"] = 51,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["65"] = 51,
		["68"] = 31,
		["69"] = 20,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 20,
		["81"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_119 = c()
local n = g.item_equipment_119
n.name = "item_equipment_119"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_119"
end
n = e({ j(nil) }, n)
g.item_equipment_119 = n
g.modifier_item_equipment_119 = c()
local o = g.modifier_item_equipment_119
o.name = "modifier_item_equipment_119"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { -1, self:GetParent() } }
end
function o.prototype.OnCustomAttackLanded(self, p)
	local q = self:GetParent()
	local r = q:GetEnemy()
	if self:GetAbility():IsCooldownReady() then
		self:GetAbility():StartCooldown(self.cooldown)
		if q:IsRangedAttacker() then
			Projectile:CreateTrackingProjectile({
				EffectName = q:GetRangedProjectileName(),
				hCaster = q,
				hTarget = r,
				iMoveSpeed = q:GetProjectileSpeed(),
				OnProjectileHit = function(s, t, u)
					if IsInjurable(s) then
						DamageSystem:performAttack(q, s, { ability = self:GetAbility() })
					end
				end,
			})
		else
			DamageSystem:performAttack(q, r, { ability = self:GetAbility() })
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
g.modifier_item_equipment_119 = o
return g