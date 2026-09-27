--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_bomb", "abilities/creeps_lane/npc_techies_bomb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_bomb_silence", "abilities/creeps_lane/npc_techies_bomb", LUA_MODIFIER_MOTION_NONE)

npc_techies_bomb = class({})

function npc_techies_bomb:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_remote_mines_detonate.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_silenced.vpcf", context)
end

function npc_techies_bomb:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1) / 100
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.hits = self:GetLevelSpecialValueFor("hits", 1)
	self.timer = self:GetLevelSpecialValueFor("timer", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.radius_exp = self:GetLevelSpecialValueFor("radius_exp", 1)
end

function npc_techies_bomb:OnSpellStart()
	self.caster:EmitSound("Hero_Techies.RemoteMine.Plant")

	local bomb = CreateUnitByName(
		"npc_techies_bomb",
		self.caster:GetAbsOrigin() + RandomVector(RandomInt(-1, 1) + self.radius),
		true,
		nil,
		nil,
		DOTA_TEAM_CUSTOM_5
	)
	bomb:AddNewModifier(self.caster, self, "modifier_techies_bomb", {})
end

modifier_techies_bomb = class(mod_hidden)
function modifier_techies_bomb:OnCreated()
	self.ability = self:GetAbility()

	self.pips = self.ability.hits

	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	self.hits = self.pips
	self.timer = self.ability.timer * 2
	self.count = 0

	self.parent:AddAttackEvent_inc(self, true)
	self:StartIntervalThink(0.5)
end

function modifier_techies_bomb:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.count = self.count + 1

	local number = (self.timer - self.count) / 2
	local int = number
	local decimal = 1

	if number % 1 ~= 0 then
		int = number - 0.5
		decimal = 8
		self.parent:EmitSound("Hero_Techies.RemoteMine.Priming")
	end

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
	ParticleManager:SetParticleControl(particle, 2, Vector(math.floor(math.log10(number)) + 2, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

	if self.count < self.timer then
		return
	end

	self.parent:EmitSound("Hero_Techies.RemoteMine.Activate")
	self.parent:EmitSound("Hero_Techies.RemoteMine.Detonate")

	local explosion = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_remote_mines_detonate.vpcf",
		PATTACH_WORLDORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(explosion, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(explosion, 1, Vector(600, 1, 1))
	ParticleManager:SetParticleControl(explosion, 3, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(explosion)

	for _, target in pairs(self.parent:FindTargets(self.ability.radius_exp)) do
		if target:GetTeam() ~= DOTA_TEAM_NEUTRALS and not target:IsBuilding() then
			target:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_techies_bomb_silence",
				{ duration = self.ability.duration * (1 - target:GetStatusResistance()) }
			)
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

	self.parent:Kill(nil, nil)
end

function modifier_techies_bomb:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_HEALTHBAR_PIPS,
	}
end

function modifier_techies_bomb:GetModifierHealthBarPips()
	return self.pips
end

function modifier_techies_bomb:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_techies_bomb:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_techies_bomb:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_techies_bomb:AttackEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.target then
		return
	end

	self.hits = self.hits - 1

	if self.hits <= 0 then
		self.parent:Kill(nil, params.attacker)
	else
		self.parent:SetHealth(self.hits)
	end
end

modifier_techies_bomb_silence = class(mod_visible)
function modifier_techies_bomb_silence:IsPurgable()
	return true
end
function modifier_techies_bomb_silence:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end
function modifier_techies_bomb_silence:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_techies_bomb_silence:CheckState()
	return { [MODIFIER_STATE_SILENCED] = true }
end