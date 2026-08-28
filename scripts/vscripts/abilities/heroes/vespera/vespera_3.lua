--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
	p:AddNewModifier(
		p,
		self,
		"modifier_vespera_3_movespeed",
		{ duration = self:GetSpecialValueFor("movespeed_duration") }
	)
	local r = self:GetSpecialValueFor("image_duration")
	if r > 0 then
		local s = p:SummonUnit("vespera_dummy", p:GetAbsOrigin(), r)
		if s ~= nil then
			s:AddNewModifier(p, self, "modifier_vespera_upgrade_24", { duration = r })
		end
		local t = FindEnemiesInRadius(p, p:GetAbsOrigin(), 900)
		for u, v in ipairs(t) do
			if BehaviorTree:GetTarget(v) == p then
				BehaviorTree:ClearTarget(v)
				v:Stop()
			end
		end
	end
end
o = e(
	{
		n(nil, {
			funcCondition = function(w, x)
				local y = DungeonManager:GetCurrentRoom()
				if Demo.force_dash_auto_cast then
					return Demo:CanForceDefenseAutoCast(x)
				end
				local z = x:GetAutoCastState()
				if z then
					local A = y and y:IsCombatRoom() and not y:IsCombatEnd() or AbyssalHordeManager:IsRunning()
					if not A then
						local B = DungeonAdventure
						local C = DungeonAdventure.IsPlayerInRunningAdventure
						local D = x:GetCaster()
						A = C(B, D and D:GetPlayerOwnerID())
					end
					z = A
				end
				return z
			end,
		}),
	},
	o
)
local E = c()
E.name = "modifier_vespera_3_buff"
d(E, h)
function E.prototype.OnCreated(self, F)
	if IsClient() then
		local G = self:GetParent()
		local H = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_2_fx_shanbi_01.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			G
		)
		ParticleManager:SetParticleControlEnt(H, 1, G, PATTACH_ABSORIGIN, nil, G:GetAbsOrigin(), true)
		self:AddParticle(H, false, false, -1, false, false)
		local I = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_phantom_assassin_active_blur.vpcf",
			PATTACH_INVALID,
			G
		)
		self:AddParticle(I, false, true, -1, false, false)
	end
end
function E.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():AddShield(self:GetAbilitySpecialValueFor("shield"), "vespera_upgrade_15")
	end
end
function E.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function E.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1, [PropertyFunction.ATTACK] = self.effect_attack }
end
function E.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true, [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
end
e({ m(nil) }, E.prototype, "effect_attack", nil)
e({ m(nil) }, E.prototype, "reduce_damage", nil)
E = e(
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
	E
)
local J = c()
J.name = "modifier_vespera_3_movespeed"
d(J, h)
function J.prototype.GetAbilitySpecialValue(self)
	self.movespeed = self:GetAbilitySpecialValueFor("movespeed")
	self.evade = self:GetAbilitySpecialValueFor("evade")
	self.snow_ball_interval = self:GetAbilitySpecialValueFor("snow_ball_interval")
	self.snow_ball_frozen = self:GetAbilitySpecialValueFor("snow_ball_frozen")
	self.snow_ball_damage = self:GetAbilitySpecialValueFor("snow_ball_damage")
end
function J.prototype.OnCreated(self, F)
	if IsServer() then
		self:GetAbility():SetFrozenCooldown(true)
		self:IncrementStackCount()
		local G = self:GetParent()
		if G:HasAbilityUpgrade("vespera_upgrade_5") then
			local x = G:GetAbilityByTag(AbilityTag.Attack)
			x:CuttingStorm(G, 1)
		end
		if G:HasAbilityUpgrade("vespera_upgrade_26") then
			local K = self:GetAbilitySpecialValueFor("suriken_interval")
			if K > 0 then
				self:ThrowSuriken(G)
				self:StartThink(K, "vespera_upgrade_26", function()
					self:ThrowSuriken(G)
				end)
			end
		end
		if self.snow_ball_interval > 0 then
			self:StartIntervalThink(self.snow_ball_interval)
		end
	end
end
function J.prototype.ThrowSuriken(self, G)
	local x = G:GetAbilityByTag(AbilityTag.Skill)
	if not IsValid(x) then
		return
	end
	local t = FindEnemiesInRadius(G, G:GetAbsOrigin(), x:GetSpecialValueFor("distance"), FIND_CLOSEST)
	local L = t[1]
	local M = IsValid(L) and L:GetAbsOrigin() or G:GetAbsOrigin() + G:GetForwardVector() * 100
	x:SurikenToss({ castPosition = M })
	Event:Fire("ability_cast_complete", { ability = x, caster = G, position = M, abilityTag = x:GetAbilityTag() })
end
function J.prototype.OnDestroy(self)
	if IsServer() then
		self:GetAbility():SetFrozenCooldown(false)
	end
end
function J.prototype.OnIntervalThink(self)
	local G = self:GetParent()
	local t = FindEnemiesInRadius(G, G:GetAbsOrigin(), 900)
	local L = GetRandomElement(t)
	if IsValid(L) then
		G:ThrowSnowball(L, nil, self.snow_ball_frozen, self.snow_ball_damage)
	end
end
function J.prototype.DeclareFunctions(self)
	return {}
end
function J.prototype.GetActivityTranslationModifiers(self)
	return "haste"
end
function J.prototype.StaticProperty(self)
	return { [PropertyFunction.EVASION] = self.evade, [PropertyFunction.MOVESPEED] = self.movespeed }
end
function J.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK] = function()
			return self:GetAbilitySpecialValueFor("attack_bonus")
		end,
	}
end
J = e(
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
	J
)
local N = c()
N.name = "modifier_vespera_upgrade_24"
d(N, h)
function N.prototype.GetAbilitySpecialValue(self) end
function N.prototype.OnCreated(self, F)
	local p = self:GetCaster()
	if IsClient() then
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/remnant_dummy.vpcf",
			PATTACH_ABSORIGIN,
			p
		)
		self:AddParticle(O, false, false, -1, false, false)
	end
end
function N.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function N.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function N.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function N.prototype.OnDestroy(self)
	if IsServer() then
		local p = self:GetCaster()
		local G = self:GetParent()
		if IsValid(p) then
			local x = p:GetAbilityByTag(AbilityTag.Attack)
			if IsValid(x) then
				x:CuttingStorm(G:GetAbsOrigin() + Vector(0, 0, 100), self:GetAbilitySpecialValueFor("aoe_image_factor"))
			end
		end
		G:RemoveSelf()
	end
end
N = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	N
)
return f