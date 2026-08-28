--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_charge_dismember"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIndexOf
local f = b.__TS__DecorateLegacy
local g = b.__TS__StringSplit
local h = b.__TS__ParseFloat
local i = {}
local j = require("modifiers.eom_modifier.eom_modifier")
local k = j.EOMModifier
local l = j.EOMModifierMotionHorizontal
local m = j.registerEOMModifier
local n = require("abilities.bt_ability_ai")
local o = n.EOMBTAbilityAI
local p = require("abilities.eom_ability")
local q = p.registerEOMAbility
local r = c()
r.name = "enemy_charge_dismember"
d(r, o)
function r.prototype.OnAbilityPhaseStart(self)
	local s = self:GetCaster()
	return true
end
function r.prototype.OnSpellStart(self)
	local s = self:GetCaster()
	local t = self:GetSpecialValueFor("duration")
	s:AddNewModifier(s, self, "modifier_enemy_charge_dismember", { duration = t })
end
function r.prototype.Dismember(self, u)
	local s = self:GetCaster()
	local v = self:GetSpecialValueFor("dismember_duration")
	local w = 1.1
	local x = 200
	local y = s:GetAbsOrigin() + s:GetForwardVector() * x
	if IsValid(u) then
		y = u:GetAbsOrigin()
	end
	local z = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, s)
	ParticleManager:SetParticleControl(z, 0, y)
	ParticleManager:SetParticleControl(z, 1, y)
	ParticleManager:SetParticleControl(z, 2, Vector(x, w, 0))
	s:PassiveCast(
		self,
		DOTA_UNIT_ORDER_CAST_POSITION,
		{ position = y, castPoint = w, castAnimation = ACT_DOTA_VICTORY },
		function(A)
			if not A then
				return
			end
			local B = FindUnitsInRadiusWithAbility(s, y, x, self)
			if #B > 0 then
				if u == nil or e(B, u) == -1 then
					u = B[1]
				end
			else
				u = nil
			end
			if not IsValid(s) then
				return
			end
			s:AddNewModifier(s, self, "modifier_dismember_animation", { duration = v })
			if IsValid(u) then
				u:AddNewModifier(s, self, "modifier_enemy_charge_dismember_debuff", { duration = v })
			end
			s:EmitSound("Hero_Pudge.Dismember.Cast")
		end
	)
end
function r.prototype.GetDismemberEffects(self, u)
	if not u:IsHero() then
		return {
			"particles/status_fx/status_effect_pudge_dismember_null.vpcf",
			"particles/units/heroes/hero_pudge/pudge_dismember_null.vpcf",
		}
	end
	local C = DOTAGameManager:GetHeroDataByName_Script(u:GetUnitName())
	if C and C.GibType ~= nil then
		local D = C.GibType
		local E = C.GibTintColor
		repeat
			local F = D
			local G = F == "ethereal"
			if G then
				return {
					"particles/status_fx/status_effect_pudge_dismember_ethereal.vpcf",
					"particles/units/heroes/hero_pudge/pudge_dismember_ethereal.vpcf",
					E,
				}
			end
			G = G or F == "goo"
			if G then
				return {
					"particles/status_fx/status_effect_pudge_dismember_goo.vpcf",
					"particles/units/heroes/hero_pudge/pudge_dismember_goo.vpcf",
					E,
				}
			end
			G = G or F == "motor"
			if G then
				return {
					"particles/status_fx/status_effect_pudge_dismember_motor.vpcf",
					"particles/units/heroes/hero_pudge/pudge_dismember_motor.vpcf",
					E,
				}
			end
			G = G or F == "ice"
			if G then
				return {
					"particles/status_fx/status_effect_pudge_dismember_ice.vpcf",
					"particles/units/heroes/hero_pudge/pudge_dismember_ice.vpcf",
					E,
				}
			end
			G = G or F == "fire"
			if G then
				return {
					"particles/status_fx/status_effect_pudge_dismember_fire.vpcf",
					"particles/units/heroes/hero_pudge/pudge_dismember_fire.vpcf",
					E,
				}
			end
			G = G or F == "electric"
			if G then
				return {
					"particles/status_fx/status_effect_pudge_dismember_electric.vpcf",
					"particles/units/heroes/hero_pudge/pudge_dismember_electric.vpcf",
					E,
				}
			end
			G = G or F == "wood"
			if G then
				return {
					"particles/status_fx/status_effect_pudge_dismember_wood.vpcf",
					"particles/units/heroes/hero_pudge/pudge_dismember_wood.vpcf",
					E,
				}
			end
			G = G or F == "stone"
			if G then
				return {
					"particles/status_fx/status_effect_pudge_dismember_stone.vpcf",
					"particles/units/heroes/hero_pudge/pudge_dismember_stone.vpcf",
					E,
				}
			end
		until true
	end
	local H
	if C then
		H = C.GibTintColor
	else
		H = nil
	end
	return {
		"particles/status_fx/status_effect_pudge_dismember_null.vpcf",
		"particles/units/heroes/hero_pudge/pudge_dismember_null.vpcf",
		H,
	}
end
r = f({ q(nil) }, r)
local I = c()
I.name = "modifier_enemy_charge_dismember"
d(I, k)
function I.prototype.GetAbilitySpecialValue(self)
	self.movespeed = self:GetAbilitySpecialValueFor("movespeed")
end
function I.prototype.OnCreated(self, J)
	self.activated = false
	if IsServer() then
		self:StartIntervalThink(0)
	else
		local z = ParticleManager:CreateParticle(
			"particles/econ/items/spirit_breaker/spirit_breaker_iron_surge/spirit_breaker_purple_charge_iron.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(z, false, false, -1, false, false)
	end
end
function I.prototype.OnIntervalThink(self)
	local B = FindUnitsInRadiusWithAbility(self.parent, self.parent:GetAbsOrigin(), 300, self.ability)
	if #B > 0 then
		self.activated = true
		self.ability:Dismember(B[1])
		self:Destroy()
	end
end
function I.prototype.OnDestroy(self)
	if IsServer() then
		if not self.activated then
			self.ability:Dismember(nil)
		end
	end
end
function I.prototype.StaticProperty(self)
	return { [PropertyFunction.MOVESPEED] = self.movespeed }
end
function I.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
I = f(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	I
)
local K = c()
K.name = "modifier_enemy_charge_dismember_debuff"
d(K, l)
function K.prototype.GetStatusEffectName(self)
	local L = self.ability
	if IsValid(L) then
		return L:GetDismemberEffects(self.parent)[1]
	end
	return "particles/status_fx/status_effect_pudge_dismember_null.vpcf"
end
function K.prototype.StatusEffectPriority(self)
	return 10
end
function K.prototype.OnCreated(self)
	local s = self:GetCaster()
	if not IsValid(s) then
		self:Destroy()
		return
	end
	self.ticks = self:GetAbilitySpecialValueFor("ticks") + (self.parent:IsConsideredHero() and 0 or 3)
	self.pull_distance_limit = self:GetAbilitySpecialValueFor("pull_distance_limit")
	self.animation_rate = self:GetAbilitySpecialValueFor("animation_rate")
	self.interval = (self:GetDuration() - 2 / 30) / (self.ticks - 1)
	if IsServer() then
		if self:ApplyHorizontalMotionController() then
			local M = self:GetAbilitySpecialValueFor("pull_units_per_second")
			local N = CalcDirection(s:GetAbsOrigin(), self.parent:GetAbsOrigin())
			local O = CalcDistance(s:GetAbsOrigin(), self.parent:GetAbsOrigin()) - self.pull_distance_limit
			if O > 0 and O / (self.interval * 2) > M then
				M = O / (self.interval * 2)
			end
			self.targetPos = s:GetAbsOrigin()
			self.velocity = N * M
		end
		self.hModifier = self.parent:AddNewModifier(s, self.ability, "modifier_truesight", {})
		self.hModifier2 = self.parent:AddNewModifier(s, self.ability, "modifier_dismember_vulnerable", {})
		local P = s:FindModifierByName("modifier_dismember_animation")
		if IsValid(P) then
			self.hModifier3 = P
		end
		self.count = 0
		self:OnIntervalThink()
		self:StartIntervalThink(self.interval)
	end
end
function K.prototype.OnIntervalThink(self)
	if IsServer() then
		if not IsValid(self.caster) or not IsValid(self.parent) or not self.caster:IsAlive() then
			self:Destroy()
			return
		end
		if self.count >= self.ticks then
			return
		end
		if self.caster:IsPositionInRange(self.parent:GetAbsOrigin(), 300) then
			self.caster:RemoveModifierByName("modifier_dismember_long_activity")
		else
			self.caster:AddNewModifier(self.caster, self.ability, "modifier_dismember_long_activity", {})
		end
		if self.count % 4 == 0 then
			local L = self.ability
			if IsValid(L) then
				local Q = L:GetDismemberEffects(self.parent)
				local R = Q[2]
				local E = Q[3]
				local S
				if E and type(E) == "string" then
					local T = g(E, " ")
					local U = h(T[1]) or 255
					local V = h(T[2]) or 255
					local W = h(T[3]) or 255
					S = Vector(U / 255, V / 255, W / 255)
				else
					S = Vector(1, 1, 1)
				end
				local z = ParticleManager:CreateParticle(R, PATTACH_CUSTOMORIGIN, self.caster)
				ParticleManager:SetParticleControlEnt(
					z,
					0,
					self.parent,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					self.parent:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					z,
					1,
					self.parent,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					self.parent:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControl(z, 2, S)
				ParticleManager:SetParticleControlEnt(
					z,
					3,
					self.parent,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					self.parent:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					z,
					4,
					self.parent,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					self.parent:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControl(z, 8, Vector(0, 0, 0))
				ParticleManager:SetParticleControl(z, 15, Vector(247, 91, 77))
				self:AddParticle(z, false, false, -1, false, false)
			end
		end
		EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Hero_Pudge.Dismember", self.caster)
		self.count = self.count + 1
		self.caster:DealDamage(
			self.parent,
			self.ability,
			self:GetAbilitySpecialValueFor("damage") / self.ticks,
			nil,
			EOM_DAMAGE_FLAGS.DOT
		)
		self.caster:Heal(self:GetAbilitySpecialValueFor("heal") / self.ticks, self.ability)
	end
end
function K.prototype.UpdateHorizontalMotion(self, X, Y)
	if IsServer() then
		local Z = self:GetCaster()
		if not IsValid(Z) then
			self:Destroy()
			return
		end
		X:SetAbsOrigin(X:GetAbsOrigin() + self.velocity * Y)
		if X:IsPositionInRange(self.targetPos, self.pull_distance_limit) then
			X:RemoveHorizontalMotionController(self)
		end
	end
end
function K.prototype.OnDestroy(self)
	if IsServer() then
		local s = self:GetCaster()
		if IsValid(s) then
			s:RemoveModifierByName("modifier_dismember_long_activity")
		end
		self.parent:RemoveHorizontalMotionController(self)
		if IsValid(self.hModifier) then
			self.hModifier:Destroy()
		end
		if IsValid(self.hModifier2) then
			self.hModifier2:Destroy()
		end
		if IsValid(self.hModifier3) then
			self.hModifier3:Destroy()
		end
	end
end
function K.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function K.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function K.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function K.prototype.GetOverrideAnimationRate(self)
	return self.animation_rate or 0
end
K = f(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	K
)
local _ = c()
_.name = "modifier_dismember_animation"
d(_, l)
function _.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_DISABLE_TURNING }
end
function _.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_4
end
function _.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true, [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function _.prototype.GetModifierDisableTurning(self)
	return 1
end
_ = f(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	_
)
local a0 = c()
a0.name = "modifier_dismember_long_activity"
d(a0, l)
function a0.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function a0.prototype.GetActivityTranslationModifiers(self)
	return "long_dismember"
end
a0 = f(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	a0
)
return i