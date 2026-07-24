--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nyx_assassin_vendetta_custom", "heroes/npc_dota_hero_nyx_assassin_custom/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nyx_assassin_vendetta_custom_debuff", "heroes/npc_dota_hero_nyx_assassin_custom/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nyx_assassin_vendetta_custom_invisible", "heroes/npc_dota_hero_nyx_assassin_custom/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE)

nyx_assassin_vendetta_custom = class({})

nyx_assassin_vendetta_custom.modifier_nyx_assassin_17 = {-10,-20,-30}
nyx_assassin_vendetta_custom.modifier_nyx_assassin_17_duration = 10
nyx_assassin_vendetta_custom.modifier_nyx_assassin_20 = {1,2,3}

function nyx_assassin_vendetta_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_shadow_dance_dummy.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_slark_shadow_dance.vpcf", context )
    PrecacheResource( "particle_folder", "particles/units/heroes/hero_nyx_assassin/", context )
end

function nyx_assassin_vendetta_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():EmitSound("Hero_NyxAssassin.Vendetta")
    local modifier_nyx_assassin_burrow_custom = self:GetCaster():FindModifierByName("modifier_nyx_assassin_burrow_custom")
    if modifier_nyx_assassin_burrow_custom then
        modifier_nyx_assassin_burrow_custom:Destroy()
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_nyx_assassin_vendetta_custom", {duration = duration})
    if self:GetCaster():HasModifier("modifier_nyx_assassin_20") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_nyx_assassin_vendetta_custom_invisible", {duration = self.modifier_nyx_assassin_20[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_20")]} )
    end
end

modifier_nyx_assassin_vendetta_custom = class({})
function modifier_nyx_assassin_vendetta_custom:IsPurgable() return false end
function modifier_nyx_assassin_vendetta_custom:IsPurgeException() return false end

function modifier_nyx_assassin_vendetta_custom:OnCreated()
    self.movement_speed = self:GetAbility():GetSpecialValueFor("movement_speed")
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.attack_animation_bonus = self:GetAbility():GetSpecialValueFor("attack_animation_bonus")
    self.attack_range_bonus = self:GetAbility():GetSpecialValueFor("attack_range_bonus")
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_nyx_assassin_vendetta_custom:OnRefresh()
    self:OnCreated()
end

function modifier_nyx_assassin_vendetta_custom:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FORCED_FLYING_VISION] = true,
        [MODIFIER_STATE_CANNOT_MISS] = true,
    }
end

function modifier_nyx_assassin_vendetta_custom:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		 
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_ATTACK_ANIM_TIME_PERCENTAGE,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    }
end

function modifier_nyx_assassin_vendetta_custom:GetModifierAttackRangeBonusUnique()
    return self.attack_range_bonus
end

function modifier_nyx_assassin_vendetta_custom:GetModifierInvisibilityLevel()
	return 1
end

function modifier_nyx_assassin_vendetta_custom:GetModifierPercentageAttackAnimTime()
	return self.attack_animation_bonus
end

function modifier_nyx_assassin_vendetta_custom:GetActivityTranslationModifiers()
	return "vendetta"
end

function modifier_nyx_assassin_vendetta_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.movement_speed
end

function modifier_nyx_assassin_vendetta_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local target = params.target
    target:EmitSound("Hero_NyxAssassin.Vendetta.Crit")
    if self:GetCaster():HasModifier("modifier_nyx_assassin_17") then
        target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_nyx_assassin_vendetta_custom_debuff", {duration = self:GetAbility().modifier_nyx_assassin_17_duration})
    end
    target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_nyx_assassin_vendetta_break", {duration = self:GetAbility():GetSpecialValueFor("break_duration") * (1-target:GetStatusResistance())})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() )
    ParticleManager:SetParticleControlForward(particle, 0, self:GetParent():GetForwardVector())
    local pfx_damage = ApplyDamage({victim = target, attacker = self:GetParent(), damage = self.bonus_damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility() })
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, target, pfx_damage, nil)
	self:Destroy()
end

modifier_nyx_assassin_vendetta_custom_debuff = class({})

function modifier_nyx_assassin_vendetta_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_nyx_assassin_vendetta_custom_debuff:GetModifierMagicalResistanceBonus()
    return self:GetAbility().modifier_nyx_assassin_17[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_17")]
end

modifier_nyx_assassin_vendetta_custom_invisible = class({})

function modifier_nyx_assassin_vendetta_custom_invisible:IsPurgable()
	return false
end

function modifier_nyx_assassin_vendetta_custom_invisible:IsPurgeException()
	return false
end

function modifier_nyx_assassin_vendetta_custom_invisible:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_nyx_assassin_vendetta_custom_invisible:OnCreated( kv )
	if not IsServer() then return end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_shadow_dance", {})
	self.thinker = CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_kill", {}, self:GetParent():GetAbsOrigin(), self:GetParent():GetTeamNumber(), false)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slark/slark_shadow_dance_dummy.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.thinker)
	ParticleManager:SetParticleControlEnt(particle, 0, self.thinker, PATTACH_POINT_FOLLOW, nil, self.thinker:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, self.thinker, PATTACH_POINT_FOLLOW, nil, self.thinker:GetAbsOrigin(), true)
	self:AddParticle(particle, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end

function modifier_nyx_assassin_vendetta_custom_invisible:OnIntervalThink( kv )
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_gem_active_truesight")
    self:GetParent():RemoveModifierByName("modifier_truesight")
    self:GetParent():RemoveModifierByName("modifier_item_dustofappearance")
	if self.thinker then
		self.thinker:SetAbsOrigin(self:GetParent():GetAbsOrigin())
	end
end

function modifier_nyx_assassin_vendetta_custom_invisible:OnDestroy( kv )
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_slark_shadow_dance")
	UTIL_Remove(self.thinker)
end

function modifier_nyx_assassin_vendetta_custom_invisible:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION,
        MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
	}
	return funcs
end

function modifier_nyx_assassin_vendetta_custom_invisible:GetModifierInvisibilityAttackBehaviorException()
    return 1
end

function modifier_nyx_assassin_vendetta_custom_invisible:GetModifierPersistentInvisibility()
    return 1
end

function modifier_nyx_assassin_vendetta_custom_invisible:GetAlwaysAutoAttackWhileHoldPosition()
    return 1
end

function modifier_nyx_assassin_vendetta_custom_invisible:GetModifierInvisibilityLevel()
	return 1
end

function modifier_nyx_assassin_vendetta_custom_invisible:CheckState()
	local state = 
	{
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
	}

	return state
end

function modifier_nyx_assassin_vendetta_custom_invisible:GetStatusEffectName()
	return "particles/status_fx/status_effect_slark_shadow_dance.vpcf"
end

function modifier_nyx_assassin_vendetta_custom_invisible:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end