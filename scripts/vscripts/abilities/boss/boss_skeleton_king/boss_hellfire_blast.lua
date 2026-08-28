--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_hellfire_blast"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "boss_hellfire_blast"
d(m, k)
function m.prototype.GetCastPoint(self)
	return 1.2
end
function m.prototype.GetCastAnimation(self)
	return ACT_SCRIPT_CUSTOM_4
end
function m.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		local n = self:GetCaster()
		local o = self:GetCursorPosition()
		n:SetForwardVector(CalcDirection2D(o, n))
		n:FaceTowards(o)
		local p = self:GetCastRange(vec3_zero, nil)
		local q = self:GetCastPoint()
		local r = self:GetSpecialValueFor("turn_rate")
		local s = FindEnemiesInRadius(n, o, 600, FIND_CLOSEST)
		local t = s[1]
		if not IsValid(t) then
			return false
		end
		local u = n:HasModifier("modifier_boss_reincarnation_buff")
		local v = 30
		local w = CalcDirection2D(o, n)
		if (o - n:GetAbsOrigin()):Length2D() <= 0 then
			w = CalcDirection2D(t:GetAbsOrigin(), n)
		end
		if u then
			local x = self:GetSpecialValueFor("count")
			local y = (x - 1) * v
			do
				local z = 1
				while z <= x do
					local A = -y * 0.5 + (z - 1) * v
					local B = RotatePosition(Vector(0, 0, 0), QAngle(0, A, 0), w)
					local C = n:GetAbsOrigin() + B * p
					local D = self:FacingSupport(C, t, r, p, q, A)
					self:LineWarning(n, D, 100, q)
					z = z + 1
				end
			end
		else
			local C = n:GetAbsOrigin() + w * p
			local D = self:FacingSupport(C, t, r, p, q)
			self:LineWarning(n, D, 100, q)
		end
		self:LockFacingTarget(t, r, q)
		n:EmitSound("skeleton_king_skel_arc_ability_hellfire_01")
	end
	return true
end
function m.prototype.OnAbilityPhaseInterrupted(self)
	if IsServer() then
		self:DestroyWarningParticles(true)
	end
end
function m.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local n = self:GetCaster()
	local E = AnglesToVector(n:GetLocalAngles())
	local o = n:GetAbsOrigin() + E * self:GetCastRange(vec3_zero, nil)
	n:SetForwardVector(E)
	n:FaceTowards(o)
	local x = self:GetSpecialValueFor("count")
	local v = 30
	Bullet:SplitAction(E, x, v, function(F, G)
		self:CreateHellfireBlast(G)
	end)
	n:EmitSound("Hero_SkeletonKing.Hellfire_Blast")
end
function m.prototype.CreateHellfireBlast(self, E, H)
	if H == nil then
		H = 1
	end
	local n = self:GetCaster()
	local p = self:GetCastRange(vec3_zero, nil)
	local I = self:GetSpecialValueFor("speed") * H
	local J = {
		caster = n,
		direction = E,
		ability = self,
		effectName = "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast.vpcf",
		spawnOrigin = n:GetAttachmentPosition("attach_attack2"),
		moveSpeed = I,
		radius = 100,
		reflectable = true,
		lifeTime = p / I,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnBulletHit = function(t, o, K)
			n:DealDamage(t, self, self:GetSpecialValueFor("damage"))
			n:EmitSound("Hero_SkeletonKing.Hellfire_BlastImpact")
		end,
	}
	Bullet:CreateGuidedBullet(J)
end
m = e({ l(nil) }, m)
local L = c()
L.name = "modifier_boss_hellfire_blast"
d(L, h)
function L.prototype.GetEffectName(self)
	return "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_debuff.vpcf"
end
function L.prototype.StaticProperty(self)
	return { [PropertyFunction.MOVESPEED_AMPLIFY] = -self:GetAbilitySpecialValueFor("movespeed_pct") }
end
L = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	L
)
return f