--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
function n.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.autoShotDistance = 0
end
function n.prototype.OnCreated(self)
	self:StartThink(0, "Weapon043AutoShot", function()
		local o = self:GetCaster()
		if not IsValid(o) or not o:IsAlive() or not o:HasAbilityUpgrade("vexis_1_upgrade_wp43") then
			self.autoShotDistance = 0
			self.autoShotLastOrigin = nil
			return
		end
		local p = self:GetSpecialValueFor("auto_cast1_move_dist")
		if p <= 0 then
			self.autoShotDistance = 0
			self.autoShotLastOrigin = nil
			return
		end
		local q = o:GetAbsOrigin()
		if self.autoShotLastOrigin ~= nil then
			local r = q:__sub(self.autoShotLastOrigin):Length2D()
			if r < 2000 then
				self.autoShotDistance = self.autoShotDistance + r
			end
		end
		self.autoShotLastOrigin = q
		if self.autoShotDistance >= p then
			self.autoShotDistance = 0
			local s = FindEnemiesInRadius(o, q, self:GetSpecialValueFor("distance"), FIND_CLOSEST)
			local t = IsValid(s[1]) and CalcDirection2D(s[1], o) or o:GetForwardVector()
			self:PowerShot(
				o:GetAttachmentPosition("attach_attack3"),
				t,
				1,
				false,
				self:GetSpecialValueFor("auto_damage_pct") * 0.01
			)
		end
	end)
end
function n.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_BOOST_MULT] = function(u, v)
			if (v and v.ability) == self then
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
function n.prototype.GetCooldown(self, w)
	return math.max(k.prototype.GetCooldown(self, w) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function n.prototype.GetPlaybackRateOverride(self)
	return 0.4 / self:GetSpecialValueFor("channel_duration")
end
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	o:EmitSound("Ability.AssassinateLoad")
	return true
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	o:StopSound("Ability.PowershotPull")
	local x = self:GetSupportCastPoint()
	local y = CalcDirection(x or vec3_bottom, o:GetAbsOrigin())
	self:PowerShot(o:GetAttachmentPosition("attach_attack3"), y, 1)
	if o:HasAbilityUpgrade("vexis_upgrade_2") then
		o:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
	end
end
function n.prototype.PowerShot(self, z, t, A, B, C)
	if B == nil then
		B = false
	end
	if C == nil then
		C = 1
	end
	local o = self:GetCaster()
	local D = self:GetSpecialValueFor("distance_pct")
	local E = o:HasAbilityUpgrade("vexis_1_upgrade_8") and 1 or (D > 0 and D * 0.01 or 1)
	local r = self:GetSpecialValueFor("distance") * A * E
	local F = self:GetSpecialValueFor("arrow_count")
	local G = o:HasAbilityUpgrade("vexis_upgrade_14_1_1")
	local H = math.max(F - 1, 0)
	local I = G and 1 + H * self:GetSpecialValueFor("giant_scale_per_arrow") * 0.01 or 1
	local J = G and 1 + H * self:GetSpecialValueFor("giant_damage_per_arrow") * 0.01 or 1
	local K = G and 1 or F
	local L = self:GetSpecialValueFor("bounce_count")
	local M = o:HasAbilityUpgrade("vexis_1_upgrade_7")
	local N = M and self:GetSpecialValueFor("return_damage_boost") or 0
	local O = self:GetSpecialValueFor("damage")
	local P = O * A * J * C
	local Q = F > 1 and EOM_DAMAGE_FLAGS.SPLIT_DAMAGE or EOM_DAMAGE_FLAGS.NONE
	local R = self:GetSpecialValueFor("angle")
	local S = R / K
	Bullet:SplitAction(t, K, S, function(u, T)
		self:FireBullet({
			start = z,
			direction = T,
			distance = r,
			damage = P,
			damageFlags = Q,
			widthScale = I,
			particleScale = I,
			useGiantParticle = G,
			bounceCount = L,
			canReturn = M,
			returnDamagePct = N,
		})
	end)
	o:EmitSound("Ability.Assassinate")
	if o:HasAbilityUpgrade("vexis_upgrade_29") and not B then
		local U = o:GetAbilityByTag(AbilityTag.Attack)
		local B = U.wisp
		if IsValid(B) then
			local s = FindEnemiesInRadius(o, o:GetAbsOrigin(), 1200)
			local V = IsValid(s[1]) and CalcDirection2D(s[1], B) or t
			B:SetLocalAngles(0, VectorToAngles(V).y, 0)
			self:PowerShot(B:GetAttachmentPosition("attach_attack1") + Vector(0, 0, 75), V, A, true, C)
		end
	end
end
function n.prototype.FireBullet(self, W)
	local o = self:GetCaster()
	local X = self:GetSpecialValueFor("speed")
	local Y = self:GetSpecialValueFor("width") * W.widthScale
	local Z = W.useGiantParticle and "models/eom/hero/shooter_1/particles/shooter_1_special_skill_fx_giant.vpcf"
		or "models/eom/hero/shooter_1/particles/shooter_1_special_skill_fx.vpcf"
	Bullet:CreateGuidedBullet({
		caster = o,
		ability = self,
		effectName = Z,
		spawnOrigin = W.start,
		direction = W.direction,
		lifeTime = W.distance / X,
		moveSpeed = X,
		radius = Y,
		ParticleCreator = W.useGiantParticle and function(_)
			local a0 = ParticleManager:CreateParticle(Z, PATTACH_CUSTOMORIGIN, o)
			ParticleManager:SetParticleControlTransformForward(a0, 0, W.start, _.__velocity:Normalized())
			ParticleManager:SetParticleControlEnt(
				a0,
				1,
				_.__thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				_.__thinker:GetAbsOrigin(),
				false
			)
			ParticleManager:SetParticleControl(a0, 2, Vector(_.moveSpeed, 0, 0))
			ParticleManager:SetParticleControl(a0, 10, Vector(W.particleScale, 0, 0))
			return a0
		end or nil,
		bounce = W.bounceCount,
		ignoreBlock = W.bounceCount <= 0 and not W.canReturn,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		flagFilter = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		OnBulletHit = function(a1)
			o:DealDamage(a1, self, W.damage, nil, W.damageFlags)
		end,
		OnBulletDestroy = W.canReturn and function(_)
			if not IsValid(o) then
				return
			end
			local a2 = _.__position
			local a3 = o:GetAbsOrigin()
			local a4 = CalcDistance(a2, a3)
			if a4 <= 0 then
				return
			end
			self:FireBullet({
				start = a2,
				direction = CalcDirection(a3, a2),
				distance = a4,
				damage = W.damage * W.returnDamagePct * 0.01,
				damageFlags = W.damageFlags,
				widthScale = W.widthScale,
				particleScale = W.particleScale,
				useGiantParticle = W.useGiantParticle,
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
			funcCondition = function(u, U)
				return U:GetAutoCastState()
			end,
		}),
	},
	n
)
local a5 = c()
a5.name = "modifier_vexis_1"
d(a5, h)
a5 = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	a5
)
return f