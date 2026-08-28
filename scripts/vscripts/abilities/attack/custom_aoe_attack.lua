--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/attack/custom_aoe_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "custom_aoe_attack"
d(j, h)
function j.prototype.GetCastRange(self, k, l)
	return self:GetCaster():Script_GetAttackRange()
end
function j.prototype.GetCooldown(self, m)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function j.prototype.OnCreated(self)
	local n = toFiniteNumber
	local o = KeyValues.units[self:GetCaster():GetUnitName()]
	if o ~= nil then
		o = o.custom_aoe_attack
	end
	self.backswingTime = n(o, 0.2)
	local p = toFiniteNumber
	local q = KeyValues.units[self:GetCaster():GetUnitName()]
	if q ~= nil then
		q = q.AttackRadius
	end
	self.attackRadius = p(q, 100)
end
function j.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function j.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function j.prototype.OnAbilityPhaseStart(self)
	local r = self:GetCaster()
	local s = self:GetCursorPosition()
	local t = CalcDirection2D(s, r)
	local u = self.attackRadius
	local v = r:GetAbsOrigin() + t * (r:Script_GetAttackRange() + u)
	self:CircleWarning(v, u, self:GetCastPoint())
	r:EmitSound(KeyValues:GetAttackSoundSet(r, "SoundSet") .. ".PreAttack")
	Event:Fire("pre_attack_event", { attacker = r, position = s })
	return true
end
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function j.prototype.GetBackswingTime(self)
	return self.backswingTime * self:GetCaster():GetSecondsPerAttack(false) / self:GetCaster():GetBaseAttackTime(false)
end
function j.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local r = self:GetCaster()
	r:SimulateCast({ duration = self:GetBackswingTime() })
	local s = self:GetCursorPosition()
	local t = CalcDirection2D(s, r)
	local u = self.attackRadius
	local v = r:GetAbsOrigin() + t * (r:Script_GetAttackRange() + u)
	local w = FindEnemiesInRadius(r, v, u)
	for x, l in ipairs(w) do
		r:Attack(l)
	end
	r:EmitSound(KeyValues:GetAttackSoundSet(r, "SoundSet") .. ".Attack")
	Event:Fire("attack_event", { attacker = r, position = v })
end
j = e({ i(nil) }, j)
return f