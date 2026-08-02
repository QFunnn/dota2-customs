--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_spike"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_spike"
d(j, h)
function j.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		local k = self:GetCaster()
		local l = self:GetCursorPosition()
		local m = CalcDirection2D(l, k)
		k:SetForwardVector(m)
		k:FaceTowards(l)
		self:LineWarning(k, k:GetAbsOrigin() + m * self:GetCastRange(vec3_zero, nil), 200, self:GetCastPoint())
	end
	return true
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local m = AnglesToVector(k:GetLocalAngles())
	local n = self:GetSpecialValueFor("damage")
	k:StartGesture(ACT_SCRIPT_CUSTOM_1)
	local o = ParticleManager:CreateParticle(
		"particles/units/boss/boss_skeleton_king/spike_trail.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(o, 3, k, PATTACH_POINT_FOLLOW, "attach_sword", k:GetAbsOrigin(), true)
	k:Dash(m, 800, 0, 0.2, function(l)
		k:PushOff(l)
	end)
	local p = k:FindAbilityByName("boss_hellfire_blast")
	Bullet:CreateCustomBullet({
		spawnOrigin = k:GetAbsOrigin(),
		lifeTime = 0.2,
		radius = 200,
		PathFunction = function(q)
			return k:GetAbsOrigin()
		end,
		FuncUnitFinder = function(r, l, s, t)
			return Bullet:FindUnitInLine(
				k:GetTeamNumber(),
				r,
				l,
				s,
				s,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE
			)
		end,
		OnBulletThink = function(t)
			p:CreateHellfireBlast(Rotation2D(m, 90, true), 0.5)
			p:CreateHellfireBlast(Rotation2D(m, -90, true), 0.5)
		end,
		OnBulletHit = function(u, l, t)
			u:KnockBack(m, 150, 0, 0.06)
			k:DealDamage(u, nil, n)
		end,
	})
	k:EmitSound("Hero_SkeletonKing.Attack")
	k:SimulateCast({ orderType = DOTA_UNIT_ORDER_CAST_POSITION, duration = 0.2 })
end
j = e({ i(nil) }, j)
return f