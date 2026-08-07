--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
				return x:GetAutoCastState()
					and (y and y:IsCombatRoom() and not y:IsCombatEnd() or AbyssalHordeManager:IsRunning())
			end,
		}),
	},
	o
)
local z = c()
z.name = "modifier_vespera_3_buff"
d(z, h)
function z.prototype.OnCreated(self, A)
	if IsClient() then
		local B = self:GetParent()
		local C = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_2_fx_shanbi_01.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			B
		)
		ParticleManager:SetParticleControlEnt(C, 1, B, PATTACH_ABSORIGIN, nil, B:GetAbsOrigin(), true)
		self:AddParticle(C, false, false, -1, false, false)
		local D = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_phantom_assassin_active_blur.vpcf",
			PATTACH_INVALID,
			B
		)
		self:AddParticle(D, false, true, -1, false, false)
	end
end
function z.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():AddShield(self:GetAbilitySpecialValueFor("shield"), "vespera_upgrade_15")
	end
end
function z.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function z.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1, [PropertyFunction.ATTACK] = self.effect_attack }
end
function z.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true, [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
end
e({ m(nil) }, z.prototype, "effect_attack", nil)
e({ m(nil) }, z.prototype, "reduce_damage", nil)
z = e(
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
	z
)
local E = c()
E.name = "modifier_vespera_3_movespeed"
d(E, h)
function E.prototype.GetAbilitySpecialValue(self)
	self.movespeed = self:GetAbilitySpecialValueFor("movespeed")
	self.evade = self:GetAbilitySpecialValueFor("evade")
	self.snow_ball_interval = self:GetAbilitySpecialValueFor("snow_ball_interval")
	self.snow_ball_frozen = self:GetAbilitySpecialValueFor("snow_ball_frozen")
	self.snow_ball_damage = self:GetAbilitySpecialValueFor("snow_ball_damage")
end
function E.prototype.OnCreated(self, A)
	if IsServer() then
		self:GetAbility():SetFrozenCooldown(true)
		self:IncrementStackCount()
		local B = self:GetParent()
		if B:HasAbilityUpgrade("vespera_upgrade_5") then
			local x = B:GetAbilityByTag(AbilityTag.Attack)
			x:CuttingStorm(B, 1)
		end
		if self.snow_ball_interval > 0 then
			self:StartIntervalThink(self.snow_ball_interval)
		end
	end
end
function E.prototype.OnDestroy(self)
	if IsServer() then
		self:GetAbility():SetFrozenCooldown(false)
	end
end
function E.prototype.OnIntervalThink(self)
	local B = self:GetParent()
	local t = FindEnemiesInRadius(B, B:GetAbsOrigin(), 900)
	local F = GetRandomElement(t)
	if IsValid(F) then
		B:ThrowSnowball(F, nil, self.snow_ball_frozen, self.snow_ball_damage)
	end
end
function E.prototype.DeclareFunctions(self)
	return {}
end
function E.prototype.GetActivityTranslationModifiers(self)
	return "haste"
end
function E.prototype.StaticProperty(self)
	return { [PropertyFunction.EVASION] = self.evade, [PropertyFunction.MOVESPEED] = self.movespeed }
end
function E.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK] = function()
			return self:GetAbilitySpecialValueFor("attack_bonus")
		end,
	}
end
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
local G = c()
G.name = "modifier_vespera_upgrade_24"
d(G, h)
function G.prototype.GetAbilitySpecialValue(self) end
function G.prototype.OnCreated(self, A)
	local B = self:GetParent()
	local p = self:GetCaster()
	local H = p and p:HasAbilityUpgrade("vespera_upgrade_26")
	if IsServer() then
		if H then
			local I = p and p:GetForwardVector() or vec3_right
			self:StartThink(0.3, function()
				if IsValid(p) then
					local x = p:GetAbilityByTag(AbilityTag.Skill)
					if IsValid(x) then
						local J = B:GetAbsOrigin() + I * 100
						x:SurikenToss({
							castPosition = J,
							startPosition = B:GetAbsOrigin() + Vector(0, 0, 100),
							returnTarget = B,
							sourceAbility = self:GetAbility(),
						})
						Event:Fire(
							"ability_cast_complete",
							{ ability = x, caster = p, position = J, abilityTag = x:GetAbilityTag() }
						)
					end
				end
				return -1
			end)
		end
	else
		local K = H and "particles/units/heroes/hero_phantom_assassin/remnant_dummy_cast.vpcf"
			or "particles/units/heroes/hero_phantom_assassin/remnant_dummy.vpcf"
		local L = ParticleManager:CreateParticle(K, PATTACH_ABSORIGIN, p)
		self:AddParticle(L, false, false, -1, false, false)
	end
end
function G.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function G.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function G.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function G.prototype.OnDestroy(self)
	if IsServer() then
		local p = self:GetCaster()
		local B = self:GetParent()
		if IsValid(p) then
			local x = p:GetAbilityByTag(AbilityTag.Attack)
			if IsValid(x) then
				x:CuttingStorm(B:GetAbsOrigin() + Vector(0, 0, 100), self:GetAbilitySpecialValueFor("aoe_image_factor"))
			end
		end
		B:RemoveSelf()
	end
end
G = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	G
)
return f