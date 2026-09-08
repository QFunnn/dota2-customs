--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
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
function n.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_BOOST_MULT] = function(o, p)
			if (p and p.ability) == self then
				return self:GetSpecialValueFor("prayer_damage_boost")
			end
		end,
	}
end
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
function n.prototype.GetCooldown(self, q)
	return math.max(k.prototype.GetCooldown(self, q) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function n.prototype.GetPlaybackRateOverride(self)
	return 0.4 / self:GetSpecialValueFor("channel_duration")
end
function n.prototype.OnAbilityPhaseStart(self)
	local r = self:GetCaster()
	r:EmitSound("Ability.AssassinateLoad")
	return true
end
function n.prototype.OnSpellStart(self)
	local r = self:GetCaster()
	r:StopSound("Ability.PowershotPull")
	local s = self:GetSupportCastPoint()
	local t = CalcDirection(s or vec3_bottom, r:GetAbsOrigin())
	self:PowerShot(r:GetAttachmentPosition("attach_attack3"), t, 1)
	if r:HasAbilityUpgrade("vexis_upgrade_2") then
		r:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
	end
end
function n.prototype.PowerShot(self, u, v, w, x)
	if x == nil then
		x = false
	end
	local r = self:GetCaster()
	local y = self:GetSpecialValueFor("distance_pct")
	local z = r:HasAbilityUpgrade("vexis_1_upgrade_8") and 1 or (y > 0 and y * 0.01 or 1)
	local A = self:GetSpecialValueFor("distance") * w * z
	local B = self:GetSpecialValueFor("arrow_count")
	local C = r:HasAbilityUpgrade("vexis_upgrade_14_1_1")
	local D = math.max(B - 1, 0)
	local E = C and 1 + D * self:GetSpecialValueFor("giant_scale_per_arrow") * 0.01 or 1
	local F = C and 1 + D * self:GetSpecialValueFor("giant_damage_per_arrow") * 0.01 or 1
	local G = C and 1 or B
	local H = self:GetSpecialValueFor("bounce_count")
	local I = r:HasAbilityUpgrade("vexis_1_upgrade_7")
	local J = I and self:GetSpecialValueFor("return_damage_boost") or 0
	local K = self:GetSpecialValueFor("damage")
	local L = K * w * F
	local M = B > 1 and EOM_DAMAGE_FLAGS.SPLIT_DAMAGE or EOM_DAMAGE_FLAGS.NONE
	local N = self:GetSpecialValueFor("angle")
	local O = N / G
	Bullet:SplitAction(v, G, O, function(o, P)
		self:FireBullet({
			start = u,
			direction = P,
			distance = A,
			damage = L,
			damageFlags = M,
			widthScale = E,
			particleScale = E,
			useGiantParticle = C,
			bounceCount = H,
			canReturn = I,
			returnDamagePct = J,
		})
	end)
	r:EmitSound("Ability.Assassinate")
	if r:HasAbilityUpgrade("vexis_upgrade_29") and not x then
		local Q = r:GetAbilityByTag(AbilityTag.Attack)
		local x = Q.wisp
		if IsValid(x) then
			local R = FindEnemiesInRadius(r, r:GetAbsOrigin(), 1200)
			local S = IsValid(R[1]) and CalcDirection2D(R[1], x) or v
			x:SetLocalAngles(0, VectorToAngles(S).y, 0)
			self:PowerShot(x:GetAttachmentPosition("attach_attack1") + Vector(0, 0, 75), S, w, true)
		end
	end
end
function n.prototype.FireBullet(self, T)
	local r = self:GetCaster()
	local U = self:GetSpecialValueFor("speed")
	local V = self:GetSpecialValueFor("width") * T.widthScale
	local W = T.useGiantParticle and "models/eom/hero/shooter_1/particles/shooter_1_special_skill_fx_giant.vpcf"
		or "models/eom/hero/shooter_1/particles/shooter_1_special_skill_fx.vpcf"
	Bullet:CreateGuidedBullet({
		caster = r,
		ability = self,
		effectName = W,
		spawnOrigin = T.start,
		direction = T.direction,
		lifeTime = T.distance / U,
		moveSpeed = U,
		radius = V,
		ParticleCreator = T.useGiantParticle and function(X)
			local Y = ParticleManager:CreateParticle(W, PATTACH_CUSTOMORIGIN, r)
			ParticleManager:SetParticleControlTransformForward(Y, 0, T.start, X.__velocity:Normalized())
			ParticleManager:SetParticleControlEnt(
				Y,
				1,
				X.__thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				X.__thinker:GetAbsOrigin(),
				false
			)
			ParticleManager:SetParticleControl(Y, 2, Vector(X.moveSpeed, 0, 0))
			ParticleManager:SetParticleControl(Y, 10, Vector(T.particleScale, 0, 0))
			return Y
		end or nil,
		bounce = T.bounceCount,
		ignoreBlock = T.bounceCount <= 0 and not T.canReturn,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		flagFilter = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		OnBulletHit = function(Z)
			r:DealDamage(Z, self, T.damage, nil, T.damageFlags)
		end,
		OnBulletDestroy = T.canReturn and function(X)
			if not IsValid(r) then
				return
			end
			local _ = X.__position
			local a0 = r:GetAbsOrigin()
			local a1 = CalcDistance(_, a0)
			if a1 <= 0 then
				return
			end
			self:FireBullet({
				start = _,
				direction = CalcDirection(a0, _),
				distance = a1,
				damage = T.damage * T.returnDamagePct * 0.01,
				damageFlags = T.damageFlags,
				widthScale = T.widthScale,
				particleScale = T.particleScale,
				useGiantParticle = T.useGiantParticle,
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
			funcCondition = function(o, Q)
				return Q:GetAutoCastState()
			end,
		}),
	},
	n
)
local a2 = c()
a2.name = "modifier_vexis_1"
d(a2, h)
a2 = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	a2
)
return f