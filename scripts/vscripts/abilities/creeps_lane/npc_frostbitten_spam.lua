--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_frostbitten_spam_buff",
	"abilities/creeps_lane/npc_frostbitten_spam",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_frostbitten_spam_thinker",
	"abilities/creeps_lane/npc_frostbitten_spam",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_frostbitten_spam", "abilities/creeps_lane/npc_frostbitten_spam", LUA_MODIFIER_MOTION_NONE)

npc_frostbitten_spam = class({})

function npc_frostbitten_spam:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context)
	PrecacheResource("particle", "particles/creeps/frostbitten_strike.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf",
		context
	)
	PrecacheResource("particle", "particles/generic_gameplay/generic_slowed_cold.vpcf", context)
end

function npc_frostbitten_spam:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.slow = self:GetLevelSpecialValueFor("slow", 1)
	self.speed = self:GetLevelSpecialValueFor("speed", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.interval = self:GetLevelSpecialValueFor("interval", 1)
	self.delay = self:GetLevelSpecialValueFor("delay", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.duration_slow = self:GetLevelSpecialValueFor("duration_slow", 1)
	self.range = self:GetLevelSpecialValueFor("range", 1)
end

function npc_frostbitten_spam:GetChannelTime()
	return self.duration
end

function npc_frostbitten_spam:OnSpellStart()
	self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_frostbitten_spam",
		{ target = self:GetCursorTarget():entindex() }
	)
end

function npc_frostbitten_spam:OnChannelFinish(bInterrupted)
	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	self.caster:RemoveModifierByName("modifier_frostbitten_spam")
end

modifier_frostbitten_spam = class(mod_hidden)
function modifier_frostbitten_spam:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.target = EntIndexToHScript(table.target)

	self:StartIntervalThink(self.ability.interval)
	self:OnIntervalThink()
end

function modifier_frostbitten_spam:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not IsValid(self.target) or not self.target:IsAlive() then
		return
	end
	if (self.parent:GetAbsOrigin() - self.target:GetAbsOrigin()):Length2D() > self.ability.range then
		return
	end

	CreateModifierThinker(
		self.parent,
		self.ability,
		"modifier_frostbitten_spam_thinker",
		{ duration = self.ability.delay },
		self.target:GetAbsOrigin() + RandomVector(RandomInt(-1, 1) + RandomInt(100, 350)),
		self.parent:GetTeamNumber(),
		false
	)
end

modifier_frostbitten_spam_thinker = class(mod_hidden)
function modifier_frostbitten_spam_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.radius, 0, -self.ability.radius))
	ParticleManager:SetParticleControl(particle, 2, Vector(self:GetRemainingTime(), 0, 0))
	self:AddParticle(particle, true, false, -1, false, false)
end

function modifier_frostbitten_spam_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.caster) then
		return
	end

	local point = self.parent:GetAbsOrigin()

	local strike = ParticleManager:CreateParticle(
		"particles/creeps/frostbitten_strike.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.caster
	)
	ParticleManager:SetParticleControlEnt(
		strike,
		0,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_staff",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(strike, 1, point)
	ParticleManager:ReleaseParticleIndex(strike)

	self.caster:EmitSound("UI.Ability_frost")

	local nova = ParticleManager:CreateParticle(
		"particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(nova, 0, point)
	ParticleManager:SetParticleControl(nova, 1, point)
	ParticleManager:SetParticleControl(nova, 2, point)
	ParticleManager:ReleaseParticleIndex(nova)

	for _, target in pairs(self.caster:FindTargets(self.ability.radius, point)) do
		target:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_frostbitten_spam_buff",
			{ duration = self.ability.duration_slow * (1 - target:GetStatusResistance()) }
		)
		DoDamage({
			victim = target,
			attacker = self.caster,
			damage = self.ability.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
	end
end

modifier_frostbitten_spam_buff = class(mod_visible)
function modifier_frostbitten_spam_buff:IsPurgable()
	return true
end
function modifier_frostbitten_spam_buff:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end
function modifier_frostbitten_spam_buff:OnCreated()
	self.ability = self:GetAbility()

	self.slow = -self.ability.slow
	self.speed = -self.ability.speed
end

function modifier_frostbitten_spam_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_frostbitten_spam_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_frostbitten_spam_buff:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end