--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tiny_grow_custom", "heroes/npc_dota_hero_tiny_custom/tiny_grow_custom", LUA_MODIFIER_MOTION_NONE)

tiny_grow_custom = class({})

function tiny_grow_custom:GetIntrinsicModifierName()
    return "modifier_tiny_grow_custom"
end

function tiny_grow_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_tiny.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_tiny.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_tiny.vpcf", context)
end

function tiny_grow_custom:OnUpgrade()
    if not IsServer() then return end
    local caster = self:GetCaster()
    Timers:CreateTimer(FrameTime(), function()
        if self:GetLevel() == 1 then
            caster:SetOriginalModel("models/heroes/tiny/tiny_02/tiny_02.vmdl")
            caster:SetModel("models/heroes/tiny/tiny_02/tiny_02.vmdl")
        elseif self:GetLevel() == 2 then
            caster:SetOriginalModel("models/heroes/tiny/tiny_03/tiny_03.vmdl")
            caster:SetModel("models/heroes/tiny/tiny_03/tiny_03.vmdl")
        elseif self:GetLevel() == 3 then
            caster:SetOriginalModel("models/heroes/tiny/tiny_04/tiny_04.vmdl")
            caster:SetModel("models/heroes/tiny/tiny_04/tiny_04.vmdl")
        end
    end)
    if self:GetCaster():IsIllusion() then return end
    self:GetCaster():StartGesture(ACT_TINY_GROWL)
    self:GetCaster():EmitSound("Tiny.Grow")
    local grow = ParticleManager:CreateParticle("particles/units/heroes/hero_tiny/tiny_transform.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster()) 
    ParticleManager:SetParticleControl(grow, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(grow)
end

function tiny_grow_custom:OnOwnerSpawned()
    if not IsServer() then return end
    local caster = self:GetCaster()
    Timers:CreateTimer(FrameTime(), function()
        if self:GetLevel() == 1 then
            caster:SetOriginalModel("models/heroes/tiny/tiny_02/tiny_02.vmdl")
            caster:SetModel("models/heroes/tiny/tiny_02/tiny_02.vmdl")
        elseif self:GetLevel() == 2 then
            caster:SetOriginalModel("models/heroes/tiny/tiny_03/tiny_03.vmdl")
            caster:SetModel("models/heroes/tiny/tiny_03/tiny_03.vmdl")
        elseif self:GetLevel() == 3 then
            caster:SetOriginalModel("models/heroes/tiny/tiny_04/tiny_04.vmdl")
            caster:SetModel("models/heroes/tiny/tiny_04/tiny_04.vmdl")
        end
    end)
end

modifier_tiny_grow_custom = class({})

function modifier_tiny_grow_custom:IsHidden() return true end
function modifier_tiny_grow_custom:IsPurgable() return false end
function modifier_tiny_grow_custom:IsPurgeException() return false end
function modifier_tiny_grow_custom:RemoveOnDeath() return false end

function modifier_tiny_grow_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    }
end

function modifier_tiny_grow_custom:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("move_speed")
end

function modifier_tiny_grow_custom:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_tiny_grow_custom:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_tiny_grow_custom:GetModifierAttackSpeedPercentage()
    return self:GetAbility():GetSpecialValueFor("attack_speed_reduction")
end