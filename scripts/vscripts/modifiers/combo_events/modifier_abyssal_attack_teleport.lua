--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/combo_events/modifier_abyssal_attack_teleport"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.registerEOMModifier
local i = g.EOMModifier
local j = c()
j.name = "modifier_abyssal_attack_teleport"
d(j, i)
function j.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.extraSearchRange = 800
	self.damageReduction = 0
	self.triggerInterval = 0
	self.nextTriggerTime = 0
end
function j.prototype.OnCreated(self, k)
	self:UpdateParams(k)
end
function j.prototype.OnRefresh(self, k)
	self:UpdateParams(k)
end
function j.prototype.EventListener(self)
	return {
		ability_cast_start = function(l, m)
			if m.caster ~= self:GetParent() then
				return
			end
			if m.ability:GetAbilityTag() ~= AbilityTag.Attack then
				return
			end
			self:TryTeleportToEnemy()
		end,
	}
end
function j.prototype.TryTeleportToEnemy(self)
	local n = GameRules:GetGameTime()
	if n < self.nextTriggerTime then
		return
	end
	local o = self:GetParent()
	if not IsValid(o) or not o:IsAlive() then
		return
	end
	local p = o:GetAbsOrigin()
	local q = o:Script_GetAttackRange()
	if self:FindEnemyInRange(p, q) ~= nil then
		return
	end
	local r = self:FindEnemyInRange(p, q + self.extraSearchRange)
	if r == nil then
		return
	end
	local s = r:GetAbsOrigin()
	local t = CalcDirection2D(p, s)
	if VectorIsZero(t) then
		t = o:GetForwardVector()
		t.z = 0
		t = t:Normalized()
	end
	local u = s + t * 100
	FindClearSpaceForUnit(o, u, true)
	self.nextTriggerTime = n + self.triggerInterval
end
function j.prototype.FindEnemyInRange(self, v, w)
	local o = self:GetParent()
	local x = FindUnitsInRadius(
		o:GetTeamNumber(),
		v,
		nil,
		w,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_CLOSEST,
		false
	)
	return x[1]
end
function j.prototype.UpdateParams(self, k)
	self.triggerInterval = math.max(0, toFiniteNumber(k and k.interval, 5))
	self.damageReduction = math.max(0, toFiniteNumber(k and k.damage_reduction, 0))
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_REDUCTION] = self.damageReduction }
end
j = e(
	{
		h(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	j
)
return f