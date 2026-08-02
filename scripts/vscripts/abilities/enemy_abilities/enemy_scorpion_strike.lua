--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_scorpion_strike"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "enemy_scorpion_strike"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.warningParticleID = {}
end
function j.prototype.GetCooldown(self, k)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function j.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = l:GetAbsOrigin()
	local n = CalcDirection(self:GetCursorPosition(), m)
	local o = m + n * self:GetCastRange(vec3_zero, nil)
	self:LineWarning(m, o, self:GetSpecialValueFor("width"), self:GetCastPoint())
	return true
end
function j.prototype.DestroyWarningParticle(self, p)
	if p == nil then
		p = false
	end
	for q, r in ipairs(self.warningParticleID) do
		ParticleManager:DestroyParticle(r, p)
		ParticleManager:ReleaseParticleIndex(r)
	end
	self.warningParticleID = {}
end
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle(true)
end
function j.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local l = self:GetCaster()
	local s = self:GetCursorPosition()
	local m = l:GetAbsOrigin()
	local n = CalcDirection2D(s, l:GetAbsOrigin())
	n.z = 0
	n = n:Normalized()
	local t = self:GetCastRange(vec3_zero, nil)
	local o = m + n * t
	local u = self:GetSpecialValueFor("duration")
	local v = 0
	local w = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_burrowstrike.vpcf",
		PATTACH_CUSTOMORIGIN,
		l
	)
	ParticleManager:SetParticleControl(w, 0, m)
	ParticleManager:SetParticleControl(w, 1, o)
	ParticleManager:ReleaseParticleIndex(w)
	l:StartGesture(ACT_SCRIPT_CUSTOM_2)
	Bullet:CreateLinearBullet({
		caster = l,
		direction = n,
		distance = t,
		moveSpeed = t / u,
		spawnOrigin = m,
		ability = self,
		ignoreBlock = true,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnBulletHit = function(x, s, y)
			l:Attack(x)
		end,
	})
	l:Dash(n, t, v, u, function()
		l:RemoveGesture(ACT_SCRIPT_CUSTOM_2)
		l:SimulateCast({ duration = 0.4 })
		l:StartGesture(ACT_SCRIPT_CUSTOM_1)
	end)
	l:EmitSound("Ability.SandKing_BurrowStrike")
end
j = e({ i(nil) }, j)
return f