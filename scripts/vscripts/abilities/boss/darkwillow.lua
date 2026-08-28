--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/darkwillow"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.bt_ability_ai")
local l = k.EOMBTAbilityAI
local m = require("abilities.eom_ability")
local n = m.registerEOMAbility
local o = c()
o.name = "darkwillow_1"
d(o, l)
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	local q = p:GetAbsOrigin() + RandomVector(RandomInt(100, 800))
	if RollPercentage(40) then
		local r = self:GetCastRange(vec3_zero, nil)
		local s = FindUnitsInRadiusWithAbility(p, p:GetAbsOrigin(), r, self)
		if s[1] ~= nil then
			if RollPercentage(50) then
				q = s[1]:GetAbsOrigin() + RandomVector(RandomInt(0, 100))
			else
				q = s[1]:GetAbsOrigin() + s[1]:GetForwardVector() * RandomInt(200, 400)
			end
		end
	end
	local t = p:FindModifierByName("modifier_darkwillow_1")
	if t ~= nil then
		t:CreateThinker(q)
	end
end
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_darkwillow_1"
end
o = e({ n(nil) }, o)
local u = c()
u.name = "modifier_darkwillow_1"
d(u, i)
function u.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.thinkerList = {}
end
function u.prototype.AddThinker(self, v)
	local w = self.thinkerList
	w[#w + 1] = v
end
function u.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function u.prototype.OnCreated(self, x)
	if IsServer() then
	end
end
function u.prototype.CreateThinker(self, q)
	local y = self.thinkerList
	y[#y + 1] = CreateModifierThinker(
		self.parent,
		self.ability,
		"modifier_darkwillow_1_thinker",
		{ duration = self.duration },
		q,
		self.parent:GetTeamNumber(),
		false
	)
end
function u.prototype.OnDestroy(self)
	if IsServer() then
		for z, v in ipairs(self.thinkerList) do
			if IsValid(v) then
				v:RemoveModifierByName("modifier_darkwillow_1_thinker")
			end
		end
	end
end
function u.prototype.EventListener(self)
	return {
		entity_killed = function(z, A)
			if A.victim == self:GetParent() then
				self:Destroy()
			end
		end,
	}
end
u = e(
	{
		j(
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
	u
)
local B = c()
B.name = "modifier_darkwillow_1_thinker"
d(B, i)
function B.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.delay = 1
end
function B.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.root_duration = self:GetAbilitySpecialValueFor("root_duration")
end
function B.prototype.OnCreated(self, x)
	local C = self:GetParent()
	local D = self:GetAbility()
	if IsServer() then
		if IsValid(D) then
			local E =
				ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
			ParticleManager:SetParticleControl(E, 0, C:GetAbsOrigin())
			ParticleManager:SetParticleControl(E, 1, C:GetAbsOrigin())
			ParticleManager:SetParticleControl(E, 2, Vector(self.radius, self.delay, 0))
			self:StartIntervalThink(self.delay)
		end
	else
		local E = ParticleManager:CreateParticle(
			"particles/econ/items/dark_willow/dark_willow_chakram_immortal/dark_willow_chakram_immortal_bramble_wraith.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(E, 0, C:GetAbsOrigin())
		ParticleManager:SetParticleControl(E, 1, Vector(self.radius, self.radius, self.radius))
		ParticleManager:SetParticleControl(E, 2, C:GetAbsOrigin())
		self:AddParticle(E, false, false, -1, false, false)
	end
end
function B.prototype.OnIntervalThink(self)
	local C = self:GetParent()
	local p = self:GetCaster()
	local D = self:GetAbility()
	if not IsValid(D) or not IsValid(p) then
		return
	end
	self.tree = CreateTempTreeWithModel(C:GetAbsOrigin(), self:GetDuration(), "models/development/invisiblebox.vmdl")
	local s = FindUnitsInRadiusWithAbility(C, C:GetAbsOrigin(), self.radius, D)
	for F, G in ipairs(s) do
		p:DealDamage(G, D, self.damage)
		G:AddNewModifier(self.parent, self.ability, "modifier_darkwillow_1_debuff", { duration = self.root_duration })
	end
	self:StartIntervalThink(-1)
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		local C = self:GetParent()
		if IsValid(C) then
			C:SafeRemoveUnit()
		end
		if IsValid(self.tree) then
			self.tree:RemoveSelf()
		end
	end
end
function B.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function B.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
B = e(
	{
		j(
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
	B
)
local H = c()
H.name = "modifier_darkwillow_1_debuff"
d(H, i)
function H.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true }
end
H = e(
	{
		j(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				GetEffectName = "particles/econ/items/dark_willow/dark_willow_chakram_immortal/dark_willow_chakram_immortal_bramble.vpcf",
			}
		),
	},
	H
)
local I = c()
I.name = "darkwillow_2"
d(I, l)
function I.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function I.prototype.OnAbilityPhaseStart(self)
	local p = self:GetCaster()
	self:CreateRadiusWarningParticle(p:GetAbsOrigin())
	return true
end
function I.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle(true)
end
function I.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local p = self:GetCaster()
	local G = self:GetCursorTarget()
	if not G then
		return
	end
	local J = CalcDirection2D(G, p)
	local K = self:GetSpecialValueFor("duration")
	local L = self:GetSpecialValueFor("speed")
	local M = self:GetSpecialValueFor("angular_speed")
	local N = self:GetSpecialValueFor("radius")
	local O = self:GetSpecialValueFor("stun_duration")
	local P = self:GetSpecialValueFor("damage")
	Bullet:CreateGuidedBullet({
		caster = p,
		ability = self,
		target = G,
		spawnOrigin = p:GetAbsOrigin() + Vector(0, 0, 100),
		moveSpeed = L,
		angularVelocity = M,
		direction = J,
		lifeTime = K,
		interval = 1,
		ParticleCreator = function(Q)
			local R = ParticleManager:CreateParticle(
				"particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_ti8_immortal_cursed_crown_helper.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				Q.__thinker
			)
			ParticleManager:SetParticleControl(R, 2, Vector(N, N, N))
			p:EmitSound("Hero_DarkWillow.Ley.Target", Q.__position)
			local E = ParticleManager:CreateParticle(
				"particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_ti8_immortal_cursed_crown_start.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				Q.__thinker
			)
			return E
		end,
		OnIntervalThink = function(Q)
			local E = ParticleManager:CreateParticle(
				"particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_ti8_immortal_cursed_crown_helper.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				Q.__thinker
			)
			ParticleManager:SetParticleControl(E, 2, Vector(N, N, N))
			p:EmitSound("Hero_DarkWillow.Ley.Target", Q.__position)
		end,
		OnBulletDestroy = function(Q)
			local E = ParticleManager:CreateParticle(
				"particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_ti8_immortal_cursed_crown_marker.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(E, 0, Q.__position)
			ParticleManager:SetParticleControl(E, 2, Vector(N, N, N))
			local s = FindUnitsInRadiusWithAbility(p, Q.__position, N, self)
			for F, S in ipairs(s) do
				p:DealDamage(S, self, P)
				S:Stun(p, self, O)
			end
			p:EmitSound("Hero_DarkWillow.Ley.Stun", Q.__position)
		end,
	})
	p:EmitSound("Hero_Disruptor.ThunderStrike.Cast")
end
I = e({ n(nil) }, I)
local T = c()
T.name = "darkwillow_3"
d(T, l)
function T.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.preParticleIDList = {}
end
function T.prototype.DestroyPreParticles(self, U)
	if U == nil then
		U = false
	end
	f(self.preParticleIDList, function(z, E)
		ParticleManager:DestroyParticle(E, U)
		ParticleManager:ReleaseParticleIndex(E)
	end)
	self.preParticleIDList = {}
end
function T.prototype.OnAbilityPhaseStart(self)
	local p = self:GetCaster()
	local q = self:GetCursorPosition()
	local N = self:GetSpecialValueFor("radius")
	local E = ParticleManager:CreateParticle(
		"particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_spell_marker.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(E, 0, q)
	ParticleManager:SetParticleControl(E, 1, Vector(N, 0, 0))
	local V = self.preParticleIDList
	V[#V + 1] = E
	local W = ParticleManager:CreateParticle(
		"particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_spell_channel.vpcf",
		PATTACH_ABSORIGIN,
		p
	)
	ParticleManager:SetParticleControl(W, 1, p:GetAbsOrigin())
	local X = self.preParticleIDList
	X[#X + 1] = W
	p:EmitSound("Hero_DarkWillow.Fear.Cast")
	return true
end
function T.prototype.OnAbilityPhaseInterrupted(self)
	local p = self:GetCaster()
	p:StopSound("Hero_DarkWillow.Fear.Cast")
	self:DestroyPreParticles(true)
end
function T.prototype.OnSpellStart(self)
	self:DestroyPreParticles()
	local p = self:GetCaster()
	local q = self:GetCursorPosition()
	local N = self:GetSpecialValueFor("radius")
	local P = self:GetSpecialValueFor("damage")
	local Y = self:GetSpecialValueFor("count")
	local E = ParticleManager:CreateParticle(
		"particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_spell_impact.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(E, 0, q)
	ParticleManager:SetParticleControl(E, 1, Vector(N, 2, N * 2))
	local s = FindUnitsInRadiusWithAbility(p, q, N, self)
	p:DealDamage(s, self, P)
	p:EmitSound("Hero_DarkWillow.Fear.Target", q)
	local Z = p:FindModifierByName("modifier_darkwillow_1")
	if IsValid(Z) then
		do
			local _ = 0
			while _ < Y do
				Z:CreateThinker(q + RandomVector(RandomInt(100, N)))
				_ = _ + 1
			end
		end
	end
end
T = e({ n(nil) }, T)
return g