--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_gem/boss_gem_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_gem_1"
d(j, h)
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function j.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		local k = self:GetCaster()
		local l = self:GetCursorPosition()
		k:SetForwardVector(CalcDirection2D(l, k))
		k:FaceTowards(l)
		local m = self:GetCastRange(vec3_zero, nil)
		local n = FindEnemiesInRadius(k, l, 600, FIND_CLOSEST)
		local o = n[1]
		if not IsValid(o) then
			return false
		end
		local p = 20
		local q = CalcDirection2D(l, k)
		if (l - k:GetAbsOrigin()):Length2D() <= 0 then
			q = CalcDirection2D(o:GetAbsOrigin(), k)
		end
		local r = k:GetAbsOrigin() + q * m
		local s = self:FacingSupport(r, o, p, m)
		self:LineWarning(k, s, 300, self:GetCastPoint())
		self:LockFacingTarget(o, p)
		k:EmitSound("skeleton_king_skel_arc_ability_hellfire_05")
	end
	return true
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local t = AnglesToVector(k:GetLocalAngles())
	k:StartGesture(ACT_SCRIPT_CUSTOM_3)
	local u = self:GetCaster():HasModifier("modifier_boss_reincarnation_buff") and self:GetSpecialValueFor("count") or 1
	local v = 30
	local w = self:GetSpecialValueFor("damage")
	k:SimulateCast({ orderType = DOTA_UNIT_ORDER_CAST_POSITION, position = vec3_zero, duration = 0.6 })
	Bullet:SplitAction(t, u, v, function(x, y)
		Bullet:CreateLinearBullet({
			caster = k,
			spawnOrigin = k:GetAbsOrigin(),
			direction = y,
			effectName = "particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil.vpcf",
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			ignoreBlock = true,
			moveSpeed = 1800,
			distance = 2000,
			interval = 0.1,
			OnIntervalThink = function(z)
				local A = ParticleManager:CreateParticle(
					"particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(A, 0, z.__position)
				ParticleManager:SetParticleControl(A, 1, Vector(300, 0, 0))
				local n = FindEnemiesInRadius(k, z.__position, 300)
				k:DealDamage(n, nil, w)
				k:EmitSound("n_creep_Thunderlizard_Big.Stomp")
			end,
		})
	end)
	k:EmitSound("Hero_Magnataur.ShockWave.Particle.Anvil")
end
j = e({ i(nil) }, j)
return f