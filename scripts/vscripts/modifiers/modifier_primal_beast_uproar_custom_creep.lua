--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_primal_beast_uproar_custom_creep = class({})
function modifier_primal_beast_uproar_custom_creep:IsHidden() return false end
function modifier_primal_beast_uproar_custom_creep:IsPurgeException() return false end
function modifier_primal_beast_uproar_custom_creep:IsPurgable() return false end
function modifier_primal_beast_uproar_custom_creep:RemoveOnDeath() return false end
function modifier_primal_beast_uproar_custom_creep:TakeDamageScriptModifier(params)
    if not params.attacker:IsHero() then
        local primal_beast_uproar = self:GetParent():FindAbilityByName("primal_beast_uproar")
        if primal_beast_uproar then
            local modifier_primal_beast_uproar = self:GetParent():AddNewModifier(self:GetParent(), primal_beast_uproar, "modifier_primal_beast_uproar", {duration = primal_beast_uproar:GetSpecialValueFor("stack_duration")})
            modifier_primal_beast_uproar = self:GetParent():FindModifierByName("modifier_primal_beast_uproar")
            if modifier_primal_beast_uproar then
                if params.damage >= 10 then
                    if modifier_primal_beast_uproar:GetStackCount() < primal_beast_uproar:GetSpecialValueFor("stack_limit") then
                        modifier_primal_beast_uproar:SetDuration(primal_beast_uproar:GetSpecialValueFor("stack_duration"), true)
                        modifier_primal_beast_uproar:IncrementStackCount()
                    end
                end
            end
        end
    end
end