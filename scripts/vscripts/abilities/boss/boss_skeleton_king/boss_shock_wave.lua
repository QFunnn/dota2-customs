--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_shock_wave"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_shock_wave"
d(j, h)
function j.prototype.GetCastPoint(self)
	return self:GetCaster():HasModifier("modifier_boss_reincarnation_buff") and 2 or 1
end
function j.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():HasModifier("modifier_boss_reincarnation_buff") and 0.6 or 1
end
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
		local q = k:HasModifier("modifier_boss_reincarnation_buff")
		local r = 30
		local s = CalcDirection2D(l, k)
		if (l - k:GetAbsOrigin()):Length2D() <= 0 then
			s = CalcDirection2D(o:GetAbsOrigin(), k)
		end
		if q then
			local t = self:GetSpecialValueFor("count")
			local u = (t - 1) * r
			do
				local v = 1
				while v <= t do
					local w = -u * 0.5 + (v - 1) * r
					local x = RotatePosition(Vector(0, 0, 0), QAngle(0, w, 0), s)
					local y = k:GetAbsOrigin() + x * m
					local z = self:FacingSupport(y, o, p, m, nil, w)
					self:LineWarning(k, z, 300, self:GetCastPoint())
					v = v + 1
				end
			end
		else
			local y = k:GetAbsOrigin() + s * m
			local z = self:FacingSupport(y, o, p, m)
			self:LineWarning(k, z, 300, self:GetCastPoint())
		end
		self:LockFacingTarget(o, p)
		k:EmitSound("skeleton_king_skel_arc_ability_hellfire_05")
	end
	return true
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local A = AnglesToVector(k:GetLocalAngles())
	k:StartGesture(ACT_SCRIPT_CUSTOM_3)
	local t = self:GetCaster():HasModifier("modifier_boss_reincarnation_buff") and self:GetSpecialValueFor("count") or 1
	local r = 30
	local B = self:GetSpecialValueFor("damage")
	k:SimulateCast({ orderType = DOTA_UNIT_ORDER_CAST_POSITION, position = vec3_zero, duration = 0.6 })
	Bullet:SplitAction(A, t, r, function(C, D)
		Bullet:CreateLinearBullet({
			caster = k,
			spawnOrigin = k:GetAbsOrigin(),
			direction = D,
			effectName = "particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil.vpcf",
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			ignoreBlock = true,
			moveSpeed = 1800,
			distance = 2000,
			interval = 0.1,
			OnIntervalThink = function(E)
				local F = ParticleManager:CreateParticle(
					"particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(F, 0, E.__position)
				ParticleManager:SetParticleControl(F, 1, Vector(300, 0, 0))
				local n = FindEnemiesInRadius(k, E.__position, 300)
				k:DealDamage(n, nil, B)
				k:EmitSound("n_creep_Thunderlizard_Big.Stomp")
			end,
		})
	end)
	k:EmitSound("Hero_Magnataur.ShockWave.Particle.Anvil")
end
j = e({ i(nil) }, j)
return f