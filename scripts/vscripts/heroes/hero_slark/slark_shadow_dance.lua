--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_slark_shadow_dance_custom", "heroes/hero_slark/slark_shadow_dance", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_shadow_dance_custom_passive", "heroes/hero_slark/slark_shadow_dance", LUA_MODIFIER_MOTION_NONE )

slark_shadow_dance_custom = class({})

function slark_shadow_dance_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_slark_shadow_dance_custom", { duration = duration } )
end

function slark_shadow_dance_custom:GetIntrinsicModifierName()
	return "modifier_slark_shadow_dance_custom_passive"
end

modifier_slark_shadow_dance_custom = class({})

function modifier_slark_shadow_dance_custom:IsHidden()
	return false
end

function modifier_slark_shadow_dance_custom:IsPurgable()
	return false
end

function modifier_slark_shadow_dance_custom:IsPurgeException()
	return false
end

function modifier_slark_shadow_dance_custom:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_slark_shadow_dance_custom:OnCreated( kv )
	self:OnRefresh()
	if not IsServer() then return end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_shadow_dance", {})
	self:GetParent():EmitSound("Hero_Slark.ShadowDance")
	self.thinker = CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_kill", {}, self:GetParent():GetAbsOrigin(), self:GetParent():GetTeamNumber(), false)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slark/slark_shadow_dance_dummy.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.thinker)
	ParticleManager:SetParticleControlEnt(particle, 0, self.thinker, PATTACH_POINT_FOLLOW, nil, self.thinker:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, self.thinker, PATTACH_POINT_FOLLOW, nil, self.thinker:GetAbsOrigin(), true)
	self:AddParticle(particle, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end

function modifier_slark_shadow_dance_custom:OnRefresh()
	local ability = self:GetAbility()
	if ability then
		self.AttackSpeedBonus = ability:GetSpecialValueFor("attack_speed_bonus")
	end
end

function modifier_slark_shadow_dance_custom:OnIntervalThink( kv )
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_gem_active_truesight")
    self:GetParent():RemoveModifierByName("modifier_truesight")
	if self.thinker then
		self.thinker:SetAbsOrigin(self:GetParent():GetAbsOrigin())
	end
end

function modifier_slark_shadow_dance_custom:OnDestroy( kv )
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_slark_shadow_dance")
	UTIL_Remove(self.thinker)
	self:GetParent():StopSound("Hero_Slark.ShadowDance")
end

function modifier_slark_shadow_dance_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION,
        MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_slark_shadow_dance_custom:GetModifierAttackSpeedBonus_Constant()
	return self.AttackSpeedBonus or 0
end

function modifier_slark_shadow_dance_custom:GetModifierInvisibilityAttackBehaviorException()
    return 1
end

function modifier_slark_shadow_dance_custom:GetModifierPersistentInvisibility()
    return 1
end

function modifier_slark_shadow_dance_custom:GetAlwaysAutoAttackWhileHoldPosition()
    return 1
end

function modifier_slark_shadow_dance_custom:GetActivityTranslationModifiers()
	return "shadow_dance"
end

function modifier_slark_shadow_dance_custom:GetModifierInvisibilityLevel()
	return 1
end

function modifier_slark_shadow_dance_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
	}

	return state
end

function modifier_slark_shadow_dance_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_slark_shadow_dance.vpcf"
end

function modifier_slark_shadow_dance_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

modifier_slark_shadow_dance_custom_passive = class({})

function modifier_slark_shadow_dance_custom_passive:IsHidden()
	return self:GetStackCount()==1
end

function modifier_slark_shadow_dance_custom_passive:IsDebuff()
	return false
end

function modifier_slark_shadow_dance_custom_passive:IsPurgable()
	return false
end

function modifier_slark_shadow_dance_custom_passive:OnCreated( kv )
	self.interval = self:GetAbility():GetSpecialValueFor( "activation_delay" )
	self.bonus_regen = self:GetAbility():GetSpecialValueFor( "bonus_regen" )
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	if not IsServer() then return end
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_slark_shadow_dance_custom_passive:OnRefresh( kv )
	self.bonus_regen = self:GetAbility():GetSpecialValueFor( "bonus_regen" )
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
end

function modifier_slark_shadow_dance_custom_passive:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_slark_shadow_dance_custom_passive:GetModifierConstantHealthRegen()
	return self.bonus_regen * (1-self:GetStackCount())
end

function modifier_slark_shadow_dance_custom_passive:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movespeed * (1-self:GetStackCount())
end

function modifier_slark_shadow_dance_custom_passive:OnIntervalThink()
	local active = true
	local targets = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, 1800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, false )
	for _, enemy in pairs( targets ) do
		if enemy:CanEntityBeSeenByMyTeam( self:GetParent() ) then
			active = false
		end
	end

	if self:GetParent():HasModifier("modifier_slark_shadow_dance_custom") then
		active = true
	end

	if not active then
		self:SetStackCount( 1 )
	else
		self:SetStackCount( 0 )
	end
end

function modifier_slark_shadow_dance_custom_passive:OnStackCountChanged( prev )
	if not IsServer() then return end
	if prev==self:GetStackCount() then return end
	if self:GetStackCount()==0 then
		self:PlayEffects()
	elseif self:GetStackCount()==1 then
		self:StopEffects()
	end
end

function modifier_slark_shadow_dance_custom_passive:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_slark/slark_regen.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	self.effect_cast = effect_cast
end

function modifier_slark_shadow_dance_custom_passive:StopEffects()
	if not self.effect_cast then return end
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
	self.effect_cast = nil
end

LinkLuaModifier( "modifier_slark_depth_shroud_custom_thinker", "heroes/hero_slark/slark_shadow_dance", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_shadow_dance_custom_shard", "heroes/hero_slark/slark_shadow_dance", LUA_MODIFIER_MOTION_NONE )

slark_depth_shroud_custom = class({})

function slark_depth_shroud_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function slark_depth_shroud_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	local point = self:GetCursorPosition()
	CreateModifierThinker(self:GetCaster(), self, "modifier_slark_depth_shroud_custom_thinker", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_slark_depth_shroud_custom_thinker = class({})

function modifier_slark_depth_shroud_custom_thinker:IsHidden() return true end
function modifier_slark_depth_shroud_custom_thinker:IsPurgable() return false end
function modifier_slark_depth_shroud_custom_thinker:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slark/slark_shard_depth_shroud.vpcf", PATTACH_WORLDORIGIN, nil)
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
    return 0.5
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

function modifier_slark_shadow_dance_custom_shard:OnCreated( kv )
	if not IsServer() then return end

	self.thinker = CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_kill", {}, self:GetParent():GetAbsOrigin(), self:GetParent():GetTeamNumber(), false)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slark/slark_shadow_dance_dummy.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.thinker)
	ParticleManager:SetParticleControlEnt(particle, 0, self.thinker, PATTACH_POINT_FOLLOW, nil, self.thinker:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, self.thinker, PATTACH_POINT_FOLLOW, nil, self.thinker:GetAbsOrigin(), true)
	self:AddParticle(particle, false, false, -1, false, false)

	self.bonus_regen = 0
	self.bonus_movespeed = 0

	local ultimate_slark = self:GetCaster():FindAbilityByName("slark_shadow_dance_custom")

	if ultimate_slark then
		self.bonus_regen = ultimate_slark:GetSpecialValueFor( "bonus_regen" )
		self.bonus_movespeed = ultimate_slark:GetSpecialValueFor( "bonus_movement_speed" )
	end

	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_shadow_dance", {})

	self:StartIntervalThink(FrameTime())
end

function modifier_slark_shadow_dance_custom_shard:OnIntervalThink( kv )
	if not IsServer() then return end
	if self.thinker then
		self.thinker:SetAbsOrigin(self:GetParent():GetAbsOrigin())
	end
end

function modifier_slark_shadow_dance_custom_shard:OnDestroy( kv )
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_slark_shadow_dance")
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