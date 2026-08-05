--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_slark_depth_shroud_custom_thinker",
	"heroes/hero_slark/slark_depth_shroud_custom/slark_depth_shroud_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_slark_shadow_dance_custom_shard",
	"heroes/hero_slark/slark_depth_shroud_custom/slark_depth_shroud_custom",
	LUA_MODIFIER_MOTION_NONE
)

slark_depth_shroud_custom = class({})

function slark_depth_shroud_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function slark_depth_shroud_custom:OnSpellStart()
	if not IsServer() then
		return
	end
	local duration = self:GetSpecialValueFor("duration")
	local point = self:GetCursorPosition()
	CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_slark_depth_shroud_custom_thinker",
		{ duration = duration },
		point,
		self:GetCaster():GetTeamNumber(),
		false
	)
end

modifier_slark_depth_shroud_custom_thinker = class({})

function modifier_slark_depth_shroud_custom_thinker:IsHidden()
	return true
end
function modifier_slark_depth_shroud_custom_thinker:IsPurgable()
	return false
end
function modifier_slark_depth_shroud_custom_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slark/slark_shard_depth_shroud.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_slark_depth_shroud_custom_thinker:IsAura()
	return true
end

function modifier_slark_depth_shroud_custom_thinker:GetModifierAura()
	return "modifier_slark_shadow_dance_custom_shard"
end

function modifier_slark_depth_shroud_custom_thinker:GetAuraRadius()
	return self.radius
end

function modifier_slark_depth_shroud_custom_thinker:GetAuraDuration()
	return 0.1
end

function modifier_slark_depth_shroud_custom_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_slark_depth_shroud_custom_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_slark_depth_shroud_custom_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_slark_shadow_dance_custom_shard = class({})

function modifier_slark_shadow_dance_custom_shard:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.thinker = CreateModifierThinker(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_kill",
		{},
		self:GetParent():GetAbsOrigin(),
		self:GetParent():GetTeamNumber(),
		false
	)
	self.bonus_regen = 0
	self.bonus_movespeed = 0

	local ultimate_slark = self:GetCaster():FindAbilityByName("slark_shadow_dance_custom")

	if ultimate_slark then
		self.bonus_regen = ultimate_slark:GetSpecialValueFor("bonus_regen")
		self.bonus_movespeed = ultimate_slark:GetSpecialValueFor("bonus_movement_speed")
	end

	self:StartIntervalThink(FrameTime())
end

function modifier_slark_shadow_dance_custom_shard:OnIntervalThink(kv)
	if not IsServer() then
		return
	end
	if self.thinker then
		self.thinker:SetAbsOrigin(self:GetParent():GetAbsOrigin())
	end
end

function modifier_slark_shadow_dance_custom_shard:OnDestroy(kv)
	if not IsServer() then
		return
	end
	UTIL_Remove(self.thinker)
end

function modifier_slark_shadow_dance_custom_shard:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION,
		MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
		MODIFIER_PROPERTY_PERSISTENT_INVISIBILITY,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_slark_shadow_dance_custom_shard:GetModifierInvisibilityLevel()
	return 2
end

function modifier_slark_shadow_dance_custom_shard:GetModifierInvisibilityAttackBehaviorException()
	return 1
end

function modifier_slark_shadow_dance_custom_shard:GetModifierPersistentInvisibility()
	return 1
end

function modifier_slark_shadow_dance_custom_shard:GetAlwaysAutoAttackWhileHoldPosition()
	return 1
end

function modifier_slark_shadow_dance_custom_shard:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
	}
	return state
end

function modifier_slark_shadow_dance_custom_shard:GetStatusEffectName()
	return "particles/status_fx/status_effect_slark_shadow_dance.vpcf"
end

function modifier_slark_shadow_dance_custom_shard:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_slark_shadow_dance_custom_shard:GetModifierConstantHealthRegen()
	return self.bonus_regen
end

function modifier_slark_shadow_dance_custom_shard:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movespeed
end