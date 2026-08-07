--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vexis/vexis_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.ability_ai")
local k = j.EOMAbilityAI
local l = require("abilities.eom_ability")
local m = l.registerEOMAbility
local n = c()
n.name = "vexis_1"
d(n, k)
function n.prototype.GetAICastRange(self)
	return self:GetSpecialValueFor("distance")
end
function n.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function n.prototype.GetLinearEndWidth(self)
	return self:GetSpecialValueFor("width")
end
function n.prototype.GetCastPoint(self)
	return self:GetSpecialValueFor("channel_duration")
end
function n.prototype.GetBehavior(self)
	if self:GetCaster():HasAbilityUpgrade("vexis_upgrade_2") then
		return tonumber(tostring(k.prototype.GetBehavior(self))) + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return k.prototype.GetBehavior(self)
end
function n.prototype.GetCooldown(self, o)
	return math.max(k.prototype.GetCooldown(self, o) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function n.prototype.GetPlaybackRateOverride(self)
	return 0.4 / self:GetSpecialValueFor("channel_duration")
end
function n.prototype.OnAbilityPhaseStart(self)
	local p = self:GetCaster()
	p:EmitSound("Ability.AssassinateLoad")
	return true
end
function n.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	p:StopSound("Ability.PowershotPull")
	local q = self:GetSupportCastPoint()
	local r = CalcDirection(q or vec3_bottom, p:GetAbsOrigin())
	self:PowerShot(p:GetAttachmentPosition("attach_attack3"), r, 1)
	if p:HasAbilityUpgrade("vexis_upgrade_2") then
		p:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
	end
end
function n.prototype.PowerShot(self, s, t, u, v)
	if v == nil then
		v = false
	end
	local p = self:GetCaster()
	local w = self:GetSpecialValueFor("distance_pct")
	local x = p:HasAbilityUpgrade("vexis_1_upgrade_8") and 1 or (w > 0 and w * 0.01 or 1)
	local y = self:GetSpecialValueFor("distance") * u * x
	local z = self:GetSpecialValueFor("arrow_count")
	local A = self:GetSpecialValueFor("bounce_count")
	local B = p:HasAbilityUpgrade("vexis_1_upgrade_7")
	local C = B and self:GetSpecialValueFor("return_damage_boost") or 0
	local D = self:GetSpecialValueFor("damage")
	local E = D * u
	local F = z > 1 and EOM_DAMAGE_FLAGS.SPLIT_DAMAGE or EOM_DAMAGE_FLAGS.NONE
	local G = self:GetSpecialValueFor("angle")
	local H = G / z
	Bullet:SplitAction(t, z, H, function(I, J)
		self:FireBullet({
			start = s,
			direction = J,
			distance = y,
			damage = E,
			damageFlags = F,
			bounceCount = A,
			canReturn = B,
			returnDamagePct = C,
		})
	end)
	p:EmitSound("Ability.Assassinate")
	if p:HasAbilityUpgrade("vexis_upgrade_29") and not v then
		local K = p:GetAbilityByTag(AbilityTag.Attack)
		local v = K.wisp
		if IsValid(v) then
			local L = FindEnemiesInRadius(p, p:GetAbsOrigin(), 1200)
			local M = IsValid(L[1]) and CalcDirection2D(L[1], v) or t
			v:SetLocalAngles(0, VectorToAngles(M).y, 0)
			self:PowerShot(v:GetAttachmentPosition("attach_attack1") + Vector(0, 0, 75), M, u, true)
		end
	end
end
function n.prototype.FireBullet(self, N)
	local p = self:GetCaster()
	local O = self:GetSpecialValueFor("speed")
	local P = self:GetSpecialValueFor("width")
	Bullet:CreateGuidedBullet({
		caster = p,
		ability = self,
		effectName = "models/eom/hero/shooter_1/particles/shooter_1_special_skill_fx.vpcf",
		spawnOrigin = N.start,
		direction = N.direction,
		lifeTime = N.distance / O,
		moveSpeed = O,
		radius = P,
		bounce = N.bounceCount,
		ignoreBlock = N.bounceCount <= 0 and not N.canReturn,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		flagFilter = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		OnBulletHit = function(Q)
			p:DealDamage(Q, self, N.damage, nil, N.damageFlags)
		end,
		OnBulletDestroy = N.canReturn and function(R)
			if not IsValid(p) then
				return
			end
			local S = R.__position
			local T = p:GetAbsOrigin()
			local U = CalcDistance(S, T)
			if U <= 0 then
				return
			end
			self:FireBullet({
				start = S,
				direction = CalcDirection(T, S),
				distance = U,
				damage = N.damage * N.returnDamagePct * 0.01,
				damageFlags = N.damageFlags,
				bounceCount = 0,
				canReturn = false,
				returnDamagePct = 0,
			})
		end or nil,
	})
end
n = e(
	{
		m(nil, {
			searchBehavior = AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET,
			funcCondition = function(I, K)
				return K:GetAutoCastState()
			end,
		}),
	},
	n
)
local V = c()
V.name = "modifier_vexis_1"
d(V, h)
V = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	V
)
return f