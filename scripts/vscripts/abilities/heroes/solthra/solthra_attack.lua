--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/solthra/solthra_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.ability_ai")
local i = h.EOMAbilityAI
local j = require("abilities.eom_ability")
local k = j.registerEOMAbility
local l = c()
l.name = "solthra_attack"
d(l, i)
function l.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.isAoe = false
end
function l.prototype.GetAICastRange(self)
	return self:GetCaster():Script_GetAttackRange()
end
function l.prototype.GetThinkInterval(self)
	return math.max(FrameTime(), self:GetCaster():GetSecondsPerAttack(false) * 0.5)
end
function l.prototype.GetCooldown(self, m)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function l.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function l.prototype.GetBehavior(self)
	if self:GetCaster():HasAbilityUpgrade("solthra_upgrade_25") then
		return tonumber(tostring(i.prototype.GetBehavior(self))) + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return i.prototype.GetBehavior(self)
end
function l.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function l.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	n:EmitSound(KeyValues:GetAttackSoundSet(n, "SoundSet") .. ".PreAttack")
	return true
end
function l.prototype.ResetTimer(self)
	self.isAoe = false
	self:StartThink(self:GetSpecialValueFor("interval"), "aoe", function()
		self.isAoe = true
		return -1
	end)
end
function l.prototype.OnCreated(self)
	self:ResetTimer()
end
function l.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local o = self:GetSupportCastPoint()
	local p = self:GetSpecialValueFor("damage")
	self:StartAttack({ caster = n, position = o, damage = p, isAOEAttack = self.isAoe })
	if self.isAoe then
		self:ResetTimer()
	end
	Event:Fire("attack_event", { attacker = n, position = o })
end
function l.prototype.StartAttack(self, q)
	local r = q
	local n = r.caster
	local o = r.position
	local s = r.isAOEAttack
	local p = r.damage
	local t = self:GetSpecialValueFor("passive_chance")
	local u = false
	if not s and self:PRD(t) then
		u = true
	end
	local v = n:GetAbsOrigin()
	local w = CalcDirection2D(o, v)
	local x = self:GetSpecialValueFor("count")
	local y = self:GetSpecialValueFor("big_ball_count")
	local z = math.ceil(x / 2)
	Bullet:SplitAction(w, x, 60 / x, function(A, B, C)
		local D = (s or u) and C == z
		self:StartSingleBallAttack({
			source = n,
			damage = p,
			isAoe = D,
			flags = x > 1 and EOM_DAMAGE_FLAGS.SPLIT_DAMAGE or EOM_DAMAGE_FLAGS.NONE,
			direction = B,
		})
		if D and y > 0 then
			local E = 0.2
			local F = self:GetSpecialValueFor("big_ball_damage") - 100
			self:StartThink(E, function()
				y = y - 1
				self:StartSingleBallAttack({
					source = n,
					damage = p,
					isAoe = D,
					flags = x > 1 and EOM_DAMAGE_FLAGS.SPLIT_DAMAGE or EOM_DAMAGE_FLAGS.NONE,
					direction = B,
					aoeExtraBonus = F,
				})
				return y > 0 and E or -1
			end)
		end
	end)
end
function l.prototype.StartSingleBallAttack(self, G)
	local H = G
	local I = H.source
	local p = H.damage
	local J = H.isAoe
	local K = H.aoeExtraBonus
	if K == nil then
		K = 0
	end
	local L = H.flags
	local w = H.direction
	local n = self:GetCaster()
	local M = I == n and 0 or GetWispDamage(n) / 100
	local N = J and K > 0
	local O = N and 1.2 or 1
	local P = I:Script_GetAttackRange()
	local Q = I:GetProjectileSpeed()
	local R = O * self:GetSpecialValueFor("radius")
	local S = self:GetSpecialValueFor("burning_damage")
	local T = {
		caster = n,
		direction = w,
		effectName = J and "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_attack.vpcf"
			or I:GetRangedProjectileName(),
		spawnOrigin = I:GetAbsOrigin() + Vector(0, 0, 75) + w * 50,
		moveSpeed = Q,
		radius = BULLET_WIDTH,
		lifeTime = P / Q,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		flagFilter = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		OnBulletHit = function(U, o, V)
			if J then
				local W = FindUnitsInRadius(
					I:GetTeamNumber(),
					o,
					nil,
					R,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					UNIT_AND_BUILDING,
					DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
					FIND_ANY_ORDER,
					false
				)
				e(W, function(A, X)
					n:Attack(
						X,
						{ bonusDamage = p, flags = L, damageAmplify = K / 100 + M, damageType = self:GetDamageType() }
					)
					if S > 0 then
						n:Burning(X, self, S)
					end
				end)
				local Y = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phoenix/phoenix_fire_spirit_ground.vpcf",
					PATTACH_CUSTOMORIGIN,
					n
				)
				ParticleManager:SetParticleControl(Y, 0, o)
				ParticleManager:SetParticleControl(Y, 1, Vector(R, 0, 0))
				I:EmitSound("Hero_Phoenix.ProjectileImpact", o)
			else
				n:Attack(U, { bonusDamage = 0, flags = L, damageAmplify = M, damageType = self:GetDamageType() })
				if S > 0 then
					n:Burning(U, self, S)
				end
			end
			return true
		end,
	}
	Bullet:CreateGuidedBullet(T)
	I:EmitSound(KeyValues:GetAttackSoundSet(I, "SoundSet") .. ".Attack")
end
function l.prototype.StaticProperty(self)
	return {
		[PropertyFunction.COOLDOWN_REDUCTION] = self:GetSpecialValueFor("cooldown_reduction"),
		[PropertyFunction.WISP_ATTACKSPEED] = self:GetSpecialValueFor("summon_attackspeed"),
	}
end
function l.prototype.EventListener(self)
	return {
		ability_upgrade_added = function(A, Z)
			if Z.unit == self:GetCaster() and Z.upgradeName == "solthra_upgrade_14" then
				self.wisp = Z.unit:CreateWisp(
					"solthra_wisp",
					{ attack = self:GetSpecialValueFor("wisp_attack"), attack_ability_name = "solthra_wisp_attack" }
				)
			end
		end,
		ability_upgrade_removed = function(A, Z)
			if Z.unit == self:GetCaster() and Z.upgradeName == "solthra_upgrade_14" and IsValid(self.wisp) then
				Z.unit:RemoveWisp(self.wisp)
				self.wisp = nil
			end
		end,
		ability_upgrades_cleared = function(A, Z)
			if Z.unit == self:GetCaster() and IsValid(self.wisp) then
				Z.unit:RemoveWisp(self.wisp)
				self.wisp = nil
			end
		end,
	}
end
l = f({ k(nil, {
	funcCondition = function(A, _)
		return _:GetAutoCastState()
	end,
}) }, l)
return g