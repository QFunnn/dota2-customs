--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_anchor_smash_reduction_lua = class({}) ---@class CDOTA_Modifier_Lua

function modifier_anchor_smash_reduction_lua:OnCreated()
    if not IsServer() then return end

    local caster = self:GetCaster()
    if not caster or caster:IsNull() then return end

    local ability = self:GetAbility()
    if not ability or ability:IsNull() then return end

    local damage_reduction = ability:GetSpecialValueFor("damage_reduction")

    local talent = caster:FindAbilityByName("special_bonus_unique_tidehunter_3")
    if talent and talent:GetLevel() > 0 then
        damage_reduction = damage_reduction + talent:GetSpecialValueFor("value")
    end

    self:SetStackCount(damage_reduction)
end

function modifier_anchor_smash_reduction_lua:OnDestroy()
    if IsClient() then return end

    local parent = self:GetParent()

    if parent:IsAlive() then return end
    
    local ability = self:GetAbility()
    local caster = self:GetCaster()
    
    if not IsValidEntity(ability) or not IsValidEntity(caster) then return end

    if parent:IsRealHero() then
        ability.kills = (ability.kills or 0) + 1
    else
        local creeps_per_stack = ability:GetSpecialValueFor("creeps_per_stack_kraken_shell")
        local modifier = caster:FindModifierByName("modifier_anchor_smash_lua")

        if modifier then
            modifier:IncrementStackCount()

            if modifier:GetStackCount() >= creeps_per_stack then
                ability.kills = (ability.kills or 0) + 1
                modifier:SetStackCount(0)
            end
        end
    end

    local modifier = caster:FindModifierByName("modifier_tidehunter_kraken_shell")
    if modifier then modifier:SetStackCount(ability.kills or 0) end
end

function modifier_anchor_smash_reduction_lua:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_anchor_smash_reduction_lua:GetModifierBaseDamageOutgoing_Percentage()
    return self:GetStackCount()
end