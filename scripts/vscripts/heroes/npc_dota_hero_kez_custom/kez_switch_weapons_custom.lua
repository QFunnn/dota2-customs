--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_switch_weapons_custom", "heroes/npc_dota_hero_kez_custom/kez_switch_weapons_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_switch_weapons_custom_handler", "heroes/npc_dota_hero_kez_custom/kez_switch_weapons_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_switch_weapons_custom_scepter", "heroes/npc_dota_hero_kez_custom/kez_switch_weapons_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_switch_weapons_custom_bonus_movespeed", "heroes/npc_dota_hero_kez_custom/kez_switch_weapons_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_switch_weapons_custom_bonus_damage", "heroes/npc_dota_hero_kez_custom/kez_switch_weapons_custom", LUA_MODIFIER_MOTION_NONE)

kez_switch_weapons_custom = class({})

function kez_switch_weapons_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_kez_1") then
        return "kez_switch_weapons_katana"
    end
    if self:GetCaster():HasModifier("modifier_kez_8") then
        return "kez_switch_weapons_sai"
    end
    if self:GetCaster():HasModifier("modifier_kez_switch_weapons_custom") then
        return "kez_switch_weapons_katana"
    end
    return "kez_switch_weapons_sai"
end

function kez_switch_weapons_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_kez_1") then
        return 0
    end
    if self:GetCaster():HasModifier("modifier_kez_8") then
        return 0
    end
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    return cooldown
end

function kez_switch_weapons_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_kez_1") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    if self:GetCaster():HasModifier("modifier_kez_8") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_INVISIBLE
end

function kez_switch_weapons_custom:GetIntrinsicModifierName()
    return "modifier_kez_switch_weapons_custom_handler"
end

function kez_switch_weapons_custom:OnSpellStart()
    if not IsServer() then return end
    local modifier_kez_shodo_sai_custom = self:GetCaster():FindModifierByName("modifier_kez_shodo_sai_custom")
    if modifier_kez_shodo_sai_custom then
        modifier_kez_shodo_sai_custom:Destroy()
    end
    local modifier_kez_switch_weapons_custom = self:GetCaster():FindModifierByName("modifier_kez_switch_weapons_custom")
    if modifier_kez_switch_weapons_custom then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_switch_weapons_custom_bonus_damage", {})
        self:GetCaster():EmitSound("Hero_Kez.SwitchWeapon.Katana")
        modifier_kez_switch_weapons_custom:Destroy()
        local modifier_kez_switch_weapons_custom_bonus_movespeed = self:GetCaster():FindModifierByName("modifier_kez_switch_weapons_custom_bonus_movespeed")
        if modifier_kez_switch_weapons_custom_bonus_movespeed then
            modifier_kez_switch_weapons_custom_bonus_movespeed:Destroy()
        end
    else
        self:GetCaster():EmitSound("Hero_Kez.SwitchWeapon.Sai")
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_switch_weapons_custom", {})
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_switch_weapons_custom_bonus_movespeed", {duration = self:GetSpecialValueFor("sai_swap_duration")})
        local modifier_kez_switch_weapons_custom_bonus_damage = self:GetCaster():FindModifierByName("modifier_kez_switch_weapons_custom_bonus_damage")
        if modifier_kez_switch_weapons_custom_bonus_damage then
            modifier_kez_switch_weapons_custom_bonus_damage:Destroy()
        end
    end
end

modifier_kez_switch_weapons_custom = class({})
function modifier_kez_switch_weapons_custom:IsHidden() return true end
function modifier_kez_switch_weapons_custom:IsPurgable() return false end
function modifier_kez_switch_weapons_custom:IsPurgeException() return false end
function modifier_kez_switch_weapons_custom:RemoveOnDeath() return false end
function modifier_kez_switch_weapons_custom:OnCreated()
    if not IsServer() then return end
    self.abilities_list = 
    {
        {"kez_echo_slash_custom", "kez_falcon_rush_custom"},
        {"kez_grappling_claw_custom", "kez_talon_toss_custom"},
        {"kez_kazurai_katana_custom", "kez_shodo_sai_custom"},
        {"kez_raptor_dance_custom", "kez_ravens_veil_custom"},
    }
    for _, ability in pairs(self.abilities_list) do
        self:GetParent():SwapAbilities(ability[1], ability[2], false, true)
    end
end
function modifier_kez_switch_weapons_custom:OnDestroy()
    if not IsServer() then return end
    local modifier_kez_shodo_sai_custom = self:GetCaster():FindModifierByName("modifier_kez_shodo_sai_custom")
    if modifier_kez_shodo_sai_custom then
        modifier_kez_shodo_sai_custom:Destroy()
    end
    self.abilities_list = 
    {
        {"kez_echo_slash_custom", "kez_falcon_rush_custom"},
        {"kez_grappling_claw_custom", "kez_talon_toss_custom"},
        {"kez_kazurai_katana_custom", "kez_shodo_sai_custom"},
        {"kez_raptor_dance_custom", "kez_ravens_veil_custom"},
    }
    for _, ability in pairs(self.abilities_list) do
        self:GetParent():SwapAbilities(ability[2], ability[1], false, true)
    end
end
function modifier_kez_switch_weapons_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    }
end
function modifier_kez_switch_weapons_custom:GetActivityTranslationModifiers()
    return "kunai"
end
function modifier_kez_switch_weapons_custom:GetModifierAttackRangeBonus()
    return -75
end

modifier_kez_switch_weapons_custom_handler = class({})
function modifier_kez_switch_weapons_custom_handler:IsHidden() return true end
function modifier_kez_switch_weapons_custom_handler:IsPurgeException() return false end
function modifier_kez_switch_weapons_custom_handler:RemoveOnDeath() return false end
function modifier_kez_switch_weapons_custom_handler:IsPurgable() return false end

function modifier_kez_switch_weapons_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end

function modifier_kez_switch_weapons_custom_handler:GetModifierBaseAttackTimeConstant()
    if self:GetParent():HasModifier("modifier_kez_switch_weapons_custom") then
        return self:GetAbility():GetSpecialValueFor("sai_base_attack_time")
    end
    if self:GetCaster():HasModifier("modifier_kez_1") then
        return 1.7
    end
    return self:GetAbility():GetSpecialValueFor("katana_base_attack_time")
end

function modifier_kez_switch_weapons_custom_handler:GetModifierBaseAttack_BonusDamage()
    if self:GetParent():HasModifier("modifier_kez_switch_weapons_custom") then
        return 0
    end
    if self:GetCaster():HasModifier("modifier_kez_1") then
        return self:GetAbility():GetSpecialValueFor("katana_agility_bonus_base_damage") / 100 * self:GetCaster():GetStrength()
    end
    return self:GetAbility():GetSpecialValueFor("katana_agility_bonus_base_damage") / 100 * self:GetCaster():GetAgility()
end

function modifier_kez_switch_weapons_custom_handler:GetModifierTotalDamageOutgoing_Percentage()
    if not self:GetParent():HasModifier("modifier_kez_switch_weapons_custom_bonus_damage") then return end
    return self:GetAbility():GetSpecialValueFor("katana_swap_bonus_damage")
end

modifier_kez_switch_weapons_custom_scepter = class({})
function modifier_kez_switch_weapons_custom_scepter:IsPurgable() return false end
function modifier_kez_switch_weapons_custom_scepter:IsPurgeException() return false end


modifier_kez_switch_weapons_custom_bonus_movespeed = class({})
function modifier_kez_switch_weapons_custom_bonus_movespeed:IsPurgable() return false end
function modifier_kez_switch_weapons_custom_bonus_movespeed:GetTexture() return "kez_switch_weapons_sai" end

function modifier_kez_switch_weapons_custom_bonus_movespeed:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_flutter_sai.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, -1, false, true)
end

function modifier_kez_switch_weapons_custom_bonus_movespeed:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_kez_switch_weapons_custom_bonus_movespeed:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("sai_swap_bonus_movement_speed")
end

modifier_kez_switch_weapons_custom_bonus_damage = class({})
function modifier_kez_switch_weapons_custom_bonus_damage:IsHidden() return self:GetStackCount() == 1 end
function modifier_kez_switch_weapons_custom_bonus_damage:IsPurgable() return false end
function modifier_kez_switch_weapons_custom_bonus_damage:GetTexture() return "kez_switch_weapons_katana" end

function modifier_kez_switch_weapons_custom_bonus_damage:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_flutter_katana.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_weapon", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, -1, false, true)
end

function modifier_kez_switch_weapons_custom_bonus_damage:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    self:SetDuration(FrameTime(), true)
    self:SetStackCount(1)
end