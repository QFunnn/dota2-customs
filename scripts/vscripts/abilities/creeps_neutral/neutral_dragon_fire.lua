--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_dragon_fire_ability",
	"abilities/creeps_neutral/neutral_dragon_fire",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_dragon_fire_delay", "abilities/creeps_neutral/neutral_dragon_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_dragon_fire_thinker",
	"abilities/creeps_neutral/neutral_dragon_fire",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_dragon_fire_burn", "abilities/creeps_neutral/neutral_dragon_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_fire_slow", "abilities/creeps_neutral/neutral_dragon_fire", LUA_MODIFIER_MOTION_NONE)

neutral_dragon_fire = class({})

function neutral_dragon_fire:Precache(context)
	PrecacheResource("particle", "particles/ember_spirit/remnant_fire.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_icarus_dive_burn_debuff.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_burn.vpcf", context)
end

function neutral_dragon_fire:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_dragon_fire_ability"
end

modifier_dragon_fire_ability = class(mod_hidden)
function modifier_dragon_fire_ability:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.delay = self.ability:GetSpecialValueFor("delay")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
	self.ability.debuff_duration = self.ability:GetSpecialValueFor("debuff_duration")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
	self.ability.damage_inc = self.ability:GetSpecialValueFor("damage_inc")
	self.ability.max = self.ability:GetSpecialValueFor("max")
end

function modifier_dragon_fire_ability:StartCast(target)
	if not IsServer() then
		return
	end
	self.target = target

	self.parent:EmitSound("n_black_dragon.Fireball.Cast")
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.5,
			effect = 1,
			anim = ACT_DOTA_CAST_ABILITY_1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_dragon_fire_ability:EndCast()
	if not IsServer() then
		return
	end
	if not IsValid(self.target) then
		return
	end

	CreateModifierThinker(
		self.parent,
		self.ability,
		"modifier_dragon_fire_delay",
		{ duration = self.ability.delay },
		self.target:GetAbsOrigin(),
		self.parent:GetTeamNumber(),
		false
	)
end

modifier_dragon_fire_delay = class(mod_hidden)
function modifier_dragon_fire_delay:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.radius = self.ability.radius
	self.duration = self.ability.duration
	local time = self:GetRemainingTime()

	local particle =
		ParticleManager:CreateParticle("particles/generic/red_zone.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, 0, -self.radius / time))
	ParticleManager:SetParticleControl(particle, 2, Vector(time, 0, 0))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_dragon_fire_delay:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.caster, self.ability) then
		return
	end

	CreateModifierThinker(
		self.caster,
		self.ability,
		"modifier_dragon_fire_thinker",
		{ duration = self.duration },
		self.parent:GetAbsOrigin(),
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_dragon_fire_thinker = class(mod_hidden)
function modifier_dragon_fire_thinker:IsAura()
	return true
end
function modifier_dragon_fire_thinker:GetAuraDuration()
	return 0.5
end
function modifier_dragon_fire_thinker:GetAuraRadius()
	return self.radius
end
function modifier_dragon_fire_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_dragon_fire_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_dragon_fire_thinker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.radius = self.ability.radius
	self.duration = self.ability.duration

	if not IsServer() then
		return
	end
	local particle =
		ParticleManager:CreateParticle("particles/ember_spirit/remnant_fire.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 2, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControl(particle, 4, Vector(self.duration - 1, 0, 0))
	self:AddParticle(particle, false, false, -1, false, false)

	self.parent:EmitSound("Generic.Fire_start")
	self.parent:EmitSound("Ember.Fire_burn")
end

function modifier_dragon_fire_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:StopSound("Ember.Fire_burn")
end

function modifier_dragon_fire_thinker:GetModifierAura()
	return "modifier_dragon_fire_burn"
end

modifier_dragon_fire_burn = class(mod_hidden)
function modifier_dragon_fire_burn:GetStatusEffectName()
	return "particles/status_fx/status_effect_burn.vpcf"
end
function modifier_dragon_fire_burn:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end
function modifier_dragon_fire_burn:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.damage = self.ability.damage
	self.damage_health = self.ability.damage_health
	self.debuff_duration = self.ability.debuff_duration
	self.interval = 0.5
	self.stack_interval = 1
	self.stack_timer = 0

	self.parent:EmitSound("Ember.Fire_burn_target")
	self:StartIntervalThink(self.interval)
end

function modifier_dragon_fire_burn:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not IsValid(self.caster, self.ability) then
		return
	end

	DoDamage({
		victim = self.parent,
		attacker = self.caster,
		damage = (self.damage + self.parent:GetMaxHealth() * self.damage_health / 100) * self.interval,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})

	if not self.parent:IsAlive() then
		return
	end

	self.stack_timer = self.stack_timer + self.interval
	if self.stack_timer < self.stack_interval then
		return
	end

	self.stack_timer = 0
	self.parent:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_dragon_fire_slow",
		{ duration = self.debuff_duration }
	)
end

function modifier_dragon_fire_burn:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:StopSound("Ember.Fire_burn_target")
end

modifier_dragon_fire_slow = class(mod_visible)
function modifier_dragon_fire_slow:GetEffectName()
	return "particles/units/heroes/hero_phoenix/phoenix_icarus_dive_burn_debuff.vpcf"
end
function modifier_dragon_fire_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
	self.damage_inc = self.ability.damage_inc
	self.max = self.ability.max

	self:OnRefresh()
end

function modifier_dragon_fire_slow:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end

	self:IncrementStackCount()
end

function modifier_dragon_fire_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_dragon_fire_slow:GetModifierMoveSpeedBonus_Percentage()
	return self:GetStackCount() * self.slow
end

function modifier_dragon_fire_slow:GetModifierIncomingDamage_Percentage()
	return self:GetStackCount() * self.damage_inc
end