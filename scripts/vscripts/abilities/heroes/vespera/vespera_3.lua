--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vespera/vespera_3"
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
o.name = "vespera_3"
d(o, k)
function o.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("duration")
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	p:EmitSound("Hero_TemplarAssassin.Meld")
	local q = self:GetSpecialValueFor("duration")
	p:AddNewModifier(p, self, "modifier_vespera_3_buff", { duration = q })
	local r = p:AddNewModifier(
		p,
		self,
		"modifier_vespera_3_movespeed",
		{ duration = self:GetSpecialValueFor("movespeed_duration") }
	)
	if IsValid(r) then
		self:SetFrozenCooldown(true, r:GetRemainingTime())
	end
	local s = self:GetSpecialValueFor("image_duration")
	if s > 0 then
		local t = p:SummonUnit("vespera_dummy", p:GetAbsOrigin(), s)
		if t ~= nil then
			t:AddNewModifier(p, self, "modifier_vespera_upgrade_24", { duration = s })
		end
		local u = FindEnemiesInRadius(p, p:GetAbsOrigin(), 900)
		for v, w in ipairs(u) do
			if BehaviorTree:GetTarget(w) == p then
				BehaviorTree:ClearTarget(w)
				w:Stop()
			end
		end
	end
end
o = e(
	{
		n(nil, {
			funcCondition = function(x, y)
				local z = DungeonManager:GetCurrentRoom()
				if Demo.force_dash_auto_cast then
					return Demo:CanForceDefenseAutoCast(y)
				end
				local A = y:GetAutoCastState()
				if A then
					local B = z and z:IsCombatRoom() and not z:IsCombatEnd() or AbyssalHordeManager:IsRunning()
					if not B then
						local C = DungeonAdventure
						local D = DungeonAdventure.IsPlayerInRunningAdventure
						local E = y:GetCaster()
						B = D(C, E and E:GetPlayerOwnerID())
					end
					A = B
				end
				return A
			end,
		}),
	},
	o
)
local F = c()
F.name = "modifier_vespera_3_buff"
d(F, h)
function F.prototype.OnCreated(self, G)
	if IsClient() then
		local H = self:GetParent()
		local I = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_2_fx_shanbi_01.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			H
		)
		ParticleManager:SetParticleControlEnt(I, 1, H, PATTACH_ABSORIGIN, nil, H:GetAbsOrigin(), true)
		self:AddParticle(I, false, false, -1, false, false)
		local J = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_phantom_assassin_active_blur.vpcf",
			PATTACH_INVALID,
			H
		)
		self:AddParticle(J, false, true, -1, false, false)
	end
end
function F.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():AddShield(self:GetAbilitySpecialValueFor("shield"), "vespera_upgrade_15")
	end
end
function F.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function F.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1, [PropertyFunction.ATTACK] = self.effect_attack }
end
function F.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true, [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
end
e({ m(nil) }, F.prototype, "effect_attack", nil)
e({ m(nil) }, F.prototype, "reduce_damage", nil)
F = e(
	{
		i(
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
	F
)
local K = c()
K.name = "modifier_vespera_3_movespeed"
d(K, h)
function K.prototype.GetAbilitySpecialValue(self)
	self.movespeed = self:GetAbilitySpecialValueFor("movespeed")
	self.evade = self:GetAbilitySpecialValueFor("evade")
	self.snow_ball_interval = self:GetAbilitySpecialValueFor("snow_ball_interval")
	self.snow_ball_frozen = self:GetAbilitySpecialValueFor("snow_ball_frozen")
	self.snow_ball_damage = self:GetAbilitySpecialValueFor("snow_ball_damage")
end
function K.prototype.OnCreated(self, G)
	if IsServer() then
		self:IncrementStackCount()
		local H = self:GetParent()
		if H:HasAbilityUpgrade("vespera_upgrade_5") then
			local y = H:GetAbilityByTag(AbilityTag.Attack)
			y:CuttingStorm(H, 1)
		end
		if H:HasAbilityUpgrade("vespera_upgrade_26") then
			local L = self:GetAbilitySpecialValueFor("suriken_interval")
			if L > 0 then
				self:ThrowSuriken(H)
				self:StartThink(L, "vespera_upgrade_26", function()
					self:ThrowSuriken(H)
				end)
			end
		end
		if self.snow_ball_interval > 0 then
			self:StartIntervalThink(self.snow_ball_interval)
		end
	end
end
function K.prototype.ThrowSuriken(self, H)
	local y = H:GetAbilityByTag(AbilityTag.Skill)
	if not IsValid(y) then
		return
	end
	local u = FindEnemiesInRadius(H, H:GetAbsOrigin(), y:GetSpecialValueFor("distance"), FIND_CLOSEST)
	local M = u[1]
	local N = IsValid(M) and M:GetAbsOrigin() or H:GetAbsOrigin() + H:GetForwardVector() * 100
	y:SurikenToss({ castPosition = N })
	Event:Fire("ability_cast_complete", { ability = y, caster = H, position = N, abilityTag = y:GetAbilityTag() })
end
function K.prototype.OnIntervalThink(self)
	local H = self:GetParent()
	local u = FindEnemiesInRadius(H, H:GetAbsOrigin(), 900)
	local M = GetRandomElement(u)
	if IsValid(M) then
		H:ThrowSnowball(M, nil, self.snow_ball_frozen, self.snow_ball_damage)
	end
end
function K.prototype.DeclareFunctions(self)
	return {}
end
function K.prototype.GetActivityTranslationModifiers(self)
	return "haste"
end
function K.prototype.StaticProperty(self)
	return { [PropertyFunction.EVASION] = self.evade, [PropertyFunction.MOVESPEED] = self.movespeed }
end
function K.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK] = function()
			return self:GetAbilitySpecialValueFor("attack_bonus")
		end,
	}
end
K = e(
	{
		i(
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
local O = c()
O.name = "modifier_vespera_upgrade_24"
d(O, h)
function O.prototype.GetAbilitySpecialValue(self) end
function O.prototype.OnCreated(self, G)
	local p = self:GetCaster()
	if IsClient() then
		local P = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/remnant_dummy.vpcf",
			PATTACH_ABSORIGIN,
			p
		)
		self:AddParticle(P, false, false, -1, false, false)
	end
end
function O.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function O.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function O.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function O.prototype.OnDestroy(self)
	if IsServer() then
		local p = self:GetCaster()
		local H = self:GetParent()
		if IsValid(p) then
			local y = p:GetAbilityByTag(AbilityTag.Attack)
			if IsValid(y) then
				y:CuttingStorm(H:GetAbsOrigin() + Vector(0, 0, 100), self:GetAbilitySpecialValueFor("aoe_image_factor"))
			end
		end
		H:RemoveSelf()
	end
end
O = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	O
)
return f