--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_natures_grasp"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "enemy_natures_grasp"
d(j, h)
function j.prototype.OnAbilityPhaseStart(self)
	local k = self:GetCaster()
	local l = self:GetCursorPosition()
	local m = CalcDirection2D(l, k)
	local n = k:GetAbsOrigin()
	local o = n + m * 600
	self:LineWarning(n, o, 100, self:GetCastPoint())
	return true
end
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local l = self:GetCursorPosition()
	local m = CalcDirection2D(l, k)
	Bullet:CreateLinearBullet({
		caster = k,
		spawnOrigin = k:GetAbsOrigin(),
		direction = m,
		moveSpeed = 600,
		distance = 600,
		interval = 0.2,
		radius = 100,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnIntervalThink = function(p)
			local q =
				ParticleManager:CreateParticle("particles/units/enemy/treant_bramble.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(q, 0, p.__position)
			ParticleManager:ReleaseParticleIndex(q)
		end,
		OnBulletHit = function(r, l, p)
			k:Attack(r)
		end,
	})
	k:EmitSound("Hero_Treant.NaturesGrasp.Cast")
end
j = e({ i(nil) }, j)
return f