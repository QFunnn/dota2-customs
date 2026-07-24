--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_phantom_assassin_blur_custom", "abilities/phantom_assassin_blur_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_blur_custom_active", "abilities/phantom_assassin_blur_custom", LUA_MODIFIER_MOTION_NONE )

phantom_assassin_blur_custom = class({})

function phantom_assassin_blur_custom:GetIntrinsicModifierName()
    return "modifier_phantom_assassin_blur_custom"
end

-- Линкуем отображаемый радиус каста с AbilityValues.radius — одна точка правды.
function phantom_assassin_blur_custom:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor("radius")
end

function phantom_assassin_blur_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phantom_assassin_blur_custom_active", { duration = duration})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_start.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    ProjectileManager:ProjectileDodge(self:GetCaster())
end

modifier_phantom_assassin_blur_custom = class({})
function modifier_phantom_assassin_blur_custom:IsHidden() return true end
function modifier_phantom_assassin_blur_custom:IsPurgable() return false end
function modifier_phantom_assassin_blur_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_EVASION_CONSTANT, 
    }
end
function modifier_phantom_assassin_blur_custom:GetModifierEvasion_Constant() 
    if self:GetParent():PassivesDisabled() then return end
    return self:GetAbility():GetSpecialValueFor("bonus_evasion")
end

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
    self:OnIntervalThink()
    self:StartIntervalThink(FrameTime())
end

function modifier_phantom_assassin_blur_custom_active:OnRefresh()
    self:OnCreated()
end

function modifier_phantom_assassin_blur_custom_active:OnIntervalThink()
    local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO,  DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_ANY_ORDER, false) 
    if #enemies > 0 then 
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
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = true
    }
end

function modifier_phantom_assassin_blur_custom_active:GetPriority()
    return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_phantom_assassin_blur_custom_active:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL
    }
end

function modifier_phantom_assassin_blur_custom_active:GetModifierInvisibilityLevel()
    return 1
end