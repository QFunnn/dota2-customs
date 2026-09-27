--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_decay", "abilities/creeps_lane/npc_golem_decay", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_decay_debuff", "abilities/creeps_lane/npc_golem_decay", LUA_MODIFIER_MOTION_NONE)

npc_golem_decay = class({})

function npc_golem_decay:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/undying_decay.vpcf", context)
end

function npc_golem_decay:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1) / 100
	self.number = self:GetLevelSpecialValueFor("number", 1)
	self.live = self:GetLevelSpecialValueFor("live", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
end

function npc_golem_decay:OnAbilityPhaseStart()
	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.7)
	return true
end

function npc_golem_decay:OnSpellStart()
	self.caster:EmitSound("Hero_Undying.Decay.Cast")
	CreateModifierThinker(
		self.caster,
		self,
		"modifier_decay",
		{ duration = FrameTime() },
		self:GetCursorPosition(),
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_decay = class(mod_hidden)
function modifier_decay:IsAura()
	return true
end
function modifier_decay:GetAuraDuration()
	return 0.1
end
function modifier_decay:GetAuraRadius()
	return self.ability.radius
end
function modifier_decay:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_decay:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_decay:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
end

function modifier_decay:OnDestroy()
	if not IsServer() then
		return
	end
	local point = self.parent:GetAbsOrigin()

	for i = 1, self.ability.number do
		local zombie = CreateUnitByName(
			"npc_golem_zombie",
			point + RandomVector(RandomInt(-150, 150)),
			true,
			nil,
			nil,
			DOTA_TEAM_CUSTOM_5
		)
		zombie.mkb = self.caster.mkb
		zombie.host_team = self.caster.host_team
		dota1x6:SetLaneCreepsStats(zombie)
		zombie:AddNewModifier(self.caster, self.ability, "modifier_kill", { duration = self.ability.live })
	end

	self.caster:EmitSound("Hero_Undying.Decay.Target")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_undying/undying_decay.vpcf",
		PATTACH_WORLDORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.radius, 0, 0))
	ParticleManager:SetParticleControl(particle, 2, self.caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_decay:GetModifierAura()
	return "modifier_decay_debuff"
end

modifier_decay_debuff = class(mod_hidden)
function modifier_decay_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	local damage = self.parent:GetMaxHealth() * self.ability.damage

	DoDamage({
		victim = self.parent,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self.ability,
	})
	self.caster:GenericHeal(damage, self.ability)
end