--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_lucky_shot_custom", "heroes/hero_pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_debuff", "heroes/hero_pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_lucky_shot_custom = class({})

function pangolier_lucky_shot_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcff", context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_heartpiercer_debuff.vpcf", context)
end

local proc_abilities = 
{
    pangolier_swashbuckle = true,
    pangolier_shield_crash = true,
    pangolier_heartpiercer_custom = true,
    pangolier_gyroshell = true,
    pangolier_rollup = true,
}

function pangolier_lucky_shot_custom:GetIntrinsicModifierName()
    return "modifier_pangolier_lucky_shot_custom"
end

modifier_pangolier_lucky_shot_custom = class({})

function modifier_pangolier_lucky_shot_custom:IsHidden() return true end
function modifier_pangolier_lucky_shot_custom:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_pangolier_lucky_shot_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_pangolier_lucky_shot_custom:GetModifierTotalDamageOutgoing_Percentage(params)
    if self:GetParent():PassivesDisabled() or self:GetParent():IsIllusion() then return end

    if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK or (params.inflictor and proc_abilities[params.inflictor:GetAbilityName()]) then
        local chance = self:GetAbility():GetSpecialValueFor("chance_pct")

        if not params.target:IsMagicImmune() and RollPercentage(chance) then
            local duration = self:GetAbility():GetSpecialValueFor("duration")
            params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_pangolier_lucky_shot_custom_debuff", { duration = duration * (1 - params.target:GetStatusResistance()) })

            local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:SetParticleControlEnt(fx, 1, params.target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
            ParticleManager:ReleaseParticleIndex(fx)

            EmitSoundOn("Hero_Pangolier.LuckyShot.Proc", params.target)
        end
    end
end

modifier_pangolier_lucky_shot_custom_debuff = class({})
function modifier_pangolier_lucky_shot_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_REDUCTION_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
end
function modifier_pangolier_lucky_shot_custom_debuff:GetModifierAttackSpeedReductionPercentage()
    return self:GetAbility():GetSpecialValueFor("attack_slow")
end
function modifier_pangolier_lucky_shot_custom_debuff:GetModifierAttackSpeedPercentage()
    return -self:GetAbility():GetSpecialValueFor("attack_slow")
end

function modifier_pangolier_lucky_shot_custom_debuff:GetModifierPhysicalArmorBonus()
    return -self:GetAbility():GetSpecialValueFor("armor")
end

function modifier_pangolier_lucky_shot_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_pangolier/pangolier_heartpiercer_debuff.vpcf"
end

function modifier_pangolier_lucky_shot_custom_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end