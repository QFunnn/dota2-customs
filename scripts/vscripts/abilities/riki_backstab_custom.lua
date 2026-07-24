--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_riki_backstab_custom", "abilities/riki_backstab_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_backstab_custom_invis", "abilities/riki_backstab_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_backstab_custom_cd", "abilities/riki_backstab_custom.lua", LUA_MODIFIER_MOTION_NONE)

riki_backstab_custom = class({})

function riki_backstab_custom:GetIntrinsicModifierName()
    return "modifier_riki_backstab_custom"
end

function riki_backstab_custom:GetCooldown(level)
    return self:GetSpecialValueFor("fade_delay")
end

modifier_riki_backstab_custom = class({})

function modifier_riki_backstab_custom:IsHidden()
    return true
end

function modifier_riki_backstab_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_riki_backstab_custom:OnIntervalThink()
    if self:GetAbility():IsFullyCastable() then
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_riki_backstab_custom_invis", {duration = duration})
    else
        self:GetParent():RemoveModifierByName("modifier_riki_backstab_custom_invis")
    end
end

function modifier_riki_backstab_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    }
end

function modifier_riki_backstab_custom:GetModifierBonusStats_Agility()
    if self.lock then
        return
    end
    self.lock = true
    local agi = self:GetParent():GetAgility() / 100 * self:GetAbility():GetSpecialValueFor("agility_percent")
    self.lock = false
    return agi
end

function modifier_riki_backstab_custom:GetModifierProcAttack_BonusDamage_Physical(params)
    if not IsServer() then return end
    if self:GetParent():PassivesDisabled() then return end
    if params.target:IsWard() then return end
    if params.no_attack_cooldown then return end

    if not self:GetCaster():HasShard() then
        if self:GetParent():IsIllusion() then return end
    end

    self:GetAbility():UseResources(false,false,false,true)
    if self:GetParent():HasModifier("modifier_riki_backstab_custom_cd") then return end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_riki_backstab_custom_cd", {duration = 0.4})
    local agility_damage_multiplier = self:GetAbility():GetSpecialValueFor("damage_multiplier")
    local victim_angle = params.target:GetAnglesAsVector().y
    local origin_difference = params.target:GetAbsOrigin() - params.attacker:GetAbsOrigin()
    local origin_difference_radian = math.atan2(origin_difference.y, origin_difference.x)
    origin_difference_radian = origin_difference_radian * 180
    local attacker_angle = origin_difference_radian / math.pi
    attacker_angle = attacker_angle + 180.0
    local result_angle = attacker_angle - victim_angle
    result_angle = math.abs(result_angle)
    params.target:EmitSound("Hero_Riki.Backstab")
    if params.target:IsHero() then
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_backstab.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target) 
        ParticleManager:SetParticleControlEnt(particle, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
    end
    local end_damage = params.attacker:GetAgility() * agility_damage_multiplier
    if not params.target:IsHero() then
        end_damage = end_damage * 2
    end
    return end_damage
end

modifier_riki_backstab_custom_invis = class({})

function modifier_riki_backstab_custom_invis:IsHidden()
    return true
end

function modifier_riki_backstab_custom_invis:OnCreated()
    self:OnRefresh()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/generic_hero_status/status_invisibility_start.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_riki_backstab_custom_invis:OnRefresh()
    local ability = self:GetAbility()
    if ability then
        self.bonus_movespeed = ability:GetSpecialValueFor("bonus_movespeed")
    end
end

function modifier_riki_backstab_custom_invis:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_riki_backstab_custom_invis:GetModifierInvisibilityLevel()
    return 1
end

function modifier_riki_backstab_custom_invis:GetModifierMoveSpeedBonus_Percentage()
    return self.bonus_movespeed or 0
end

function modifier_riki_backstab_custom_invis:CheckState()
    local state = { [MODIFIER_STATE_INVISIBLE] = true}
    return state
end

modifier_riki_backstab_custom_cd = class({})
function modifier_riki_backstab_custom_cd:IsHidden() return true end
function modifier_riki_backstab_custom_cd:IsPurgable() return false end
function modifier_riki_backstab_custom_cd:IsPurgeException() return false end
function modifier_riki_backstab_custom_cd:RemoveOnDeath() return false end