--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_base_attack_speed_custom = class({})
function modifier_base_attack_speed_custom:IsPurgable() return false end
function modifier_base_attack_speed_custom:IsPurgeException() return false end
function modifier_base_attack_speed_custom:IsHidden() return true end
function modifier_base_attack_speed_custom:RemoveOnDeath() return false end
function modifier_base_attack_speed_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT 
    }
end
function modifier_base_attack_speed_custom:GetModifierBaseAttackTimeConstant()
    local attack_time = 1.7
    if self:GetParent():HasModifier("modifier_alchemist_chemical_rage") then
        local ability = self:GetParent():FindAbilityByName("alchemist_chemical_rage")
        if ability then
            attack_time = math.min(attack_time, ability:GetSpecialValueFor("base_attack_time"))
        end
    end
    if self:GetParent():HasModifier("modifier_snapfire_lil_shredder_custom") then
        local ability = self:GetParent():FindAbilityByName("snapfire_lil_shredder_custom")
        if ability then
            attack_time = math.min(attack_time, ability:GetSpecialValueFor("base_attack_time"))
        end
    end
    if self:GetParent():HasModifier("modifier_custom_terrorblade_metamorphosis") then
        local ability = self:GetParent():FindAbilityByName("custom_terrorblade_metamorphosis")
        if ability then
            attack_time = math.min(attack_time, ability:GetSpecialValueFor("base_attack_time"))
        end
    end
    --if self:GetParent():HasModifier("modifier_lone_druid_true_form_custom") then
    --    local ability = self:GetParent():FindAbilityByName("lone_druid_true_form_custom")
    --    if ability then
    --        attack_time = math.min(attack_time, ability:GetSpecialValueFor("base_attack_time"))
    --    end
    --end
    local troll_warlord_switch_stance = self:GetParent():FindAbilityByName("troll_warlord_switch_stance")
    if troll_warlord_switch_stance and troll_warlord_switch_stance:GetToggleState() then
        attack_time = math.min(attack_time, 1.1)
    end
    if self:GetParent():HasModifier("modifier_skill_swiftness_buff") then
        attack_time = attack_time - 0.25
    end
    if self:GetParent():HasModifier("modifier_item_dark_moon_shard") then
        attack_time = attack_time - (attack_time * 0.23)
    end
    return attack_time
end