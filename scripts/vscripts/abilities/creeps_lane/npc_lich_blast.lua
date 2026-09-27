--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_blast_thinker", "abilities/creeps_lane/npc_lich_blast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_blast_targets", "abilities/creeps_lane/npc_lich_blast", LUA_MODIFIER_MOTION_NONE)

npc_lich_blast = class({})

function npc_lich_blast:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf",
		context
	)
end

function npc_lich_blast:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1) / 100
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.delay_blast = self:GetLevelSpecialValueFor("delay_blast", 1)
	self.delay_inc = self:GetLevelSpecialValueFor("delay_inc", 1)
	self.cd_inc = self:GetLevelSpecialValueFor("cd_inc", 1)
end

function npc_lich_blast:GetCooldown(iLevel)
	return self.BaseClass.GetCooldown(self, iLevel)
		- (self.caster:GetUpgradeStack("modifier_waveupgrade_boss") - 1) * (self.cd_inc or 0)
end

function npc_lich_blast:OnSpellStart()
	self.line = not self.line

	self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_lich_blast_targets",
		{ target = self:GetCursorTarget():entindex() }
	)
end

modifier_lich_blast_targets = class(mod_hidden)
function modifier_lich_blast_targets:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	local origin = self.parent:GetAbsOrigin()
	local target = EntIndexToHScript(table.target)

	self.count = 0
	self.targets = {}

	if self.ability.line then
		self.number = 5
		local reverse = RollPseudoRandomPercentage(50, 14, self.parent)
		for i = 1, self.number do
			local n = reverse and (self.number - i + 1) or i
			self.targets[i] = origin + self.parent:GetForwardVector() * n * self.ability.radius
		end
		self:StartIntervalThink(0.1)
	else
		self.number = 10
		local point = origin + Vector(1) * (origin - target:GetAbsOrigin()):Length2D()
		for i = 1, self.number do
			point = RotatePosition(origin, QAngle(0, 360 / self.number, 0), point)
			self.targets[i] = point
		end
		self:StartIntervalThink(0)
	end

	self:OnIntervalThink()
end

function modifier_lich_blast_targets:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.count = self.count + 1

	CreateModifierThinker(
		self.parent,
		self.ability,
		"modifier_lich_blast_thinker",
		{ duration = self.ability.delay_blast - self.ability.delay_inc },
		self.targets[self.count],
		self.parent:GetTeamNumber(),
		false
	)

	if self.count < self.number then
		return
	end
	self:Destroy()
end

modifier_lich_blast_thinker = class(mod_hidden)
function modifier_lich_blast_thinker:OnCreated()
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

function modifier_lich_blast_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	local point = self.parent:GetAbsOrigin()

	self.parent:EmitSound("UI.Ability_frost")

	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, point)
	ParticleManager:SetParticleControl(particle, 2, point)
	ParticleManager:ReleaseParticleIndex(particle)

	for _, target in pairs(self.caster:FindTargets(self.ability.radius, point)) do
		DoDamage({
			victim = target,
			attacker = self.caster,
			damage = target:GetMaxHealth() * self.ability.damage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			ability = self.ability,
		})
	end
end