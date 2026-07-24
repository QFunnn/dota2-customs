--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_phantom_assassin_blur_custom", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_blur_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_blur_custom_active", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_blur_custom", LUA_MODIFIER_MOTION_NONE )

phantom_assassin_blur_custom = class({})

function phantom_assassin_blur_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_start.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_phantom_assassin.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_phantom_assassin.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_phantom_assassin.vpcf", context)
end

phantom_assassin_blur_custom.modifier_phantom_assassin_20 = {-9,-18,-27}

function phantom_assassin_blur_custom:GetIntrinsicModifierName() 
    return "modifier_phantom_assassin_blur_custom" 
end

function phantom_assassin_blur_custom:GetCooldown(level)
    local cooldown = 0
    if self:GetCaster():HasModifier("modifier_phantom_assassin_20") then
        cooldown = self.modifier_phantom_assassin_20[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_20")]
    end
    return self.BaseClass.GetCooldown( self, level ) + cooldown
end

function phantom_assassin_blur_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_phantom_assassin_20") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end

function phantom_assassin_blur_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phantom_assassin_blur_custom_active", { duration = duration})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_start.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ProjectileManager:ProjectileDodge(self:GetCaster())
end

modifier_phantom_assassin_blur_custom = class({})
function modifier_phantom_assassin_blur_custom:IsHidden() return true end
function modifier_phantom_assassin_blur_custom:IsPurgable() return false end

modifier_phantom_assassin_blur_custom_active = class({})

function modifier_phantom_assassin_blur_custom_active:IsPurgable() return false end

function modifier_phantom_assassin_blur_custom_active:GetEffectName()
    return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end

function modifier_phantom_assassin_blur_custom_active:GetEffectAttachType()
     return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_phantom_assassin_blur_custom_active:OnCreated()
    if not self:GetAbility() then self:Destroy() return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if not IsServer() then return end
    self.delay = self:GetAbility():GetSpecialValueFor("fade_duration")
    self:GetParent():EmitSound("Hero_PhantomAssassin.Blur")
    self.linger = false
    self.attack = true
    self:OnIntervalThink()
    self:StartIntervalThink(FrameTime())
end

function modifier_phantom_assassin_blur_custom_active:OnRefresh()
    self:OnCreated()
end

function modifier_phantom_assassin_blur_custom_active:OnIntervalThink()
    if self.linger == true then return end
    local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO,  DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_ANY_ORDER, false) 
    if #enemies > 0 then 
        self.linger = true
        self:SetDuration(self.delay, true)
        self:StartIntervalThink(-1)
    end
end

function modifier_phantom_assassin_blur_custom_active:OnDestroy()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_PhantomAssassin.Blur.Break")
end

function modifier_phantom_assassin_blur_custom_active:CheckState()
    return 
    {
        [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
    }
end

function modifier_phantom_assassin_blur_custom_active:GetPriority()
    return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_phantom_assassin_blur_custom_active:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_phantom_assassin_blur_custom_active:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end

function modifier_phantom_assassin_blur_custom_active:GetModifierInvisibilityLevel()
    return 1
end

function modifier_phantom_assassin_blur_custom_active:GetModifierInvisibilityAttackBehaviorException()
    return 1
end

function modifier_phantom_assassin_blur_custom_active:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self.attack and not self.linger then
        self.attack = false
        self:SetDuration(3, true)
    end
end