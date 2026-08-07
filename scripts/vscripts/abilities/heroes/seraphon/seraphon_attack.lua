--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/seraphon/seraphon_attack"
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
local m = l.AbilityValue
local n = l.registerEOMAbility
local o = c()
o.name = "seraphon_attack"
d(o, k)
function o.prototype.GetAICastRange(self)
	return self:GetCaster():Script_GetAttackRange()
end
function o.prototype.GetThinkInterval(self)
	return math.max(FrameTime(), self:GetCaster():GetSecondsPerAttack(false) * 0.5)
end
function o.prototype.ProcsMagicStick(self)
	return false
end
function o.prototype.GetCooldown(self, p)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function o.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function o.prototype.GetCastAnimation(self)
	if AbilityUpgrade:HasAbilityUpgrade(self:GetCaster(), "seraphon_upgrade_5") then
		return ACT_DOTA_CAST_ABILITY_1
	end
	if self:IsRechargeFully() then
		return ACT_DOTA_ATTACK_EVENT
	end
	return ACT_DOTA_ATTACK
end
function o.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function o.prototype.OnAbilityPhaseStart(self)
	local q = self:GetCaster()
	q:EmitSound(tostring(KeyValues.heroes[q:GetUnitName()].SoundSet) .. ".PreAttack")
	return true
end
function o.prototype.OnSpellStart(self)
	local q = self:GetCaster()
	local r = 150
	local s = 100
	local t = q:Script_GetAttackRange()
	local u = q:GetAbsOrigin()
	local v = self:GetCursorPosition()
	local w = CalcDirection2D(v, u)
	local x = u + w * t
	local y = {}
	local z = q:HasAbilityUpgrade("seraphon_upgrade_5")
	if z then
		local A = u + w * 150
		self:HeavyHammer(A)
		local B = self:GetSpecialValueFor("aoe_count")
		if B > 0 then
			local C = self:GetSpecialValueFor("aoe_reduce_pct")
			local D = 0
			local E = 1 - C * 0.01
			self:StartThink(0.3, "aoe_count", function()
				D = D + 1
				self:HeavyHammer(A + w * 300 * D, E)
				B = B - 1
				if B <= 0 then
					return -1
				end
			end)
		end
	else
		local F = Rotation2D(w, math.rad(90))
		local G = { u + F * r, x + F * s, x - F * s, u - F * r }
		y = FindUnitsInLine(
			q:GetTeam(),
			u,
			x,
			nil,
			math.max(r, s),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			UNIT_AND_BUILDING,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE
		)
		local H = G[1]:Lerp(G[3], 0.5)
		do
			local I = 0
			while I < #G do
				local J = G[I + 1]
				G[I + 1] = J + CalcDirection2D(J, H) * 50
				I = I + 1
			end
		end
		do
			local I = 0
			while I < #y do
				if IsPointInPolygon(y[I + 1]:GetAbsOrigin(), G) then
					q:Attack(y[I + 1], { damageType = self:GetDamageType() })
				end
				I = I + 1
			end
		end
		local K = Bullet:GetBulletInPolygon(G)
		q:ShootDown(K)
	end
	q:EmitSound(tostring(KeyValues.heroes[q:GetUnitName()].SoundSet) .. ".Attack")
	if self:ConsumeCharge() then
		local L = self:GetSpecialValueFor("shield")
		if L > 0 then
			Game:EachPlayer(function(M, N)
				local O = Player:GetHero(N)
				if IsValid(O) then
					O:AddShield(L, "seraphon_attack")
				end
			end)
		end
		local P = self:GetSpecialValueFor("heal")
		if P > 0 then
			q:Heal(P, self)
			local Q = ParticleManager:CreateParticle(
				"particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward_death.vpcf",
				PATTACH_ABSORIGIN,
				q
			)
			ParticleManager:ReleaseParticleIndex(Q)
		end
		q:EmitSound("Hero_Dawnbreaker.Luminosity.Strike")
		self:ConsumeCharge()
		if q:HasAbilityUpgrade("seraphon_upgrade_2") then
			local R = q:GetAbilityByTag(AbilityTag.Dodge)
			if IsValid(R) then
				R:EndCooldown()
				R:RestoreCharges()
			end
		end
	end
	if q:HasAbilityUpgrade("seraphon_upgrade_1") then
		q:AddNewModifier(
			q,
			self,
			"modifier_seraphon_upgrade_1",
			{ duration = self:GetSpecialValueFor("attackspeed_duration") }
		)
	end
	Event:Fire("attack_event", { attacker = q, position = v })
end
function o.prototype.HeavyHammer(self, A, E)
	if E == nil then
		E = 1
	end
	local q = self:GetCaster()
	local t = q:Script_GetAttackRange()
	local y = {}
	local S = self:GetSpecialValueFor("attackrange")
	local T = (S + GetAttackRange(q) + GetAttackRangeMelee(q)) * E
	local Q = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf",
		PATTACH_CUSTOMORIGIN,
		q
	)
	ParticleManager:SetParticleControl(Q, 0, A)
	ParticleManager:SetParticleControl(Q, 1, Vector(T, T, T))
	ParticleManager:ReleaseParticleIndex(Q)
	q:EmitSound("Hero_Marci.Unleash.Pulse")
	y = FindUnitsInRadius(
		q:GetTeam(),
		A,
		nil,
		T,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		UNIT_AND_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_ANY_ORDER,
		false
	)
	do
		local I = 0
		while I < #y do
			q:Attack(y[I + 1], { baseDamage = q:GetAttackDamage() * E, damageType = self:GetDamageType() })
			I = I + 1
		end
	end
	local K = Bullet:GetBulletInRadius(A, t)
	do
		local I = 0
		while I < #K do
			local U = K[I + 1]
			if IsValid(U.caster) and not U.caster:IsFriendly(q) then
				Bullet:DestroyBulletByID(U.__projIndex)
			end
			I = I + 1
		end
	end
end
function o.prototype.ConsumeCharge(self)
	if self:IsRechargeFully() then
		self:SetStackCount(0)
		self:DestroyParticles()
		return true
	else
		self:IncrementStackCount(1, false)
		if self:IsRechargeFully() and (self.__ParticleIDs == nil or #self.__ParticleIDs <= 0) then
			local Q = ParticleManager:CreateParticle(
				"particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_hammer_ambient.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(
				Q,
				0,
				self:GetCaster(),
				PATTACH_POINT_FOLLOW,
				"attach_attack1",
				self:GetCaster():GetAbsOrigin(),
				true
			)
			self:AddParticle(Q)
		end
		return false
	end
end
function o.prototype.IsRechargeFully(self)
	return self:GetStackCount()
		>= self:GetSpecialValueFor("require_count")
			+ 1
			- self:GetCaster():GetModifierStackCount("modifier_seraphon_4_buff", self:GetCaster())
end
function o.prototype.StaticProperty(self)
	return {
		[PropertyFunction.ATTACKSPEED_REDUCTION] = self:GetSpecialValueFor("attackspeed_reduce_pct"),
		[PropertyFunction.ATTACK_AMPLIFY] = self:GetSpecialValueFor("attack_pct"),
	}
end
function o.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_AMPLIFY] = function(M, V)
			if V ~= nil and self:IsRechargeFully() and V.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				return self:GetSpecialValueFor("last_hit_damage")
			end
		end,
	}
end
o = e({ n(nil, {
	funcCondition = function(M, R)
		return R:GetAutoCastState()
	end,
}) }, o)
local W = c()
W.name = "modifier_seraphon_upgrade_1"
d(W, h)
function W.prototype.OnCreated(self, X)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function W.prototype.OnRefresh(self, X)
	if IsServer() then
		self:SetStackCount(math.min(self.attackspeed_max_stack, self:GetStackCount() + 1))
	end
end
function W.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACKSPEED] = self.attackspeed_per_stack * self:GetStackCount() }
end
e({ m(nil) }, W.prototype, "attackspeed_per_stack", nil)
e({ m(nil) }, W.prototype, "attackspeed_max_stack", nil)
W = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	W
)
return f