--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_events_thinker_woda = class({})
function modifier_events_thinker_woda:IsPurgable() return false end
function modifier_events_thinker_woda:IsPurgeException() return false end
function modifier_events_thinker_woda:RemoveOnDeath() return false end
function modifier_events_thinker_woda:IsPurgeException() return false end

function modifier_events_thinker_woda:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
    }
end

function modifier_events_thinker_woda:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target then
        for _, mod in pairs(params.target:FindAllModifiers()) do
            if mod and mod.OnAttackLanded then
                mod:OnAttackLanded(params)
            end
        end
    end
    if params.attacker then
        for _, mod in pairs(params.attacker:FindAllModifiers()) do
            if mod and mod.OnAttackLanded then
                mod:OnAttackLanded(params)
            end
        end
    end
end

function modifier_events_thinker_woda:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.ability and params.ability:GetAbilityName() == "twin_gate_portal_warp" then return end
    if params.unit then
        for _, mod in pairs(params.unit:FindAllModifiers()) do
            if mod and mod.OnAbilityFullyCast then
                mod:OnAbilityFullyCast(params)
            end
        end
    end
    if params.target and (params.target:IsNPC() or params.target:IsBaseNPC()) and params.target ~= params.unit then
        for _, mod in pairs(params.target:FindAllModifiers()) do
            if mod and mod.OnAbilityFullyCast then
                mod:OnAbilityFullyCast(params)
            end
        end
    end
end

function modifier_events_thinker_woda:OnTakeDamage(params)
    if not IsServer() then return end

    if params.attacker then
        for _, mod in pairs(params.attacker:FindAllModifiers()) do
            if mod and mod.OnTakeDamage and mod:GetName() ~= "modifier_visage_soul_assumption_custom" then
                local ok, err = pcall(function()
                    mod:OnTakeDamage(params)
                end)

                if not ok then
                    print("[modifier_events_thinker_woda] OnTakeDamage attacker modifier error:", err)
                end
            end
        end
    end

    if params.unit then
        for _, mod in pairs(params.unit:FindAllModifiers()) do
            if mod and mod.OnTakeDamage and mod:GetName() ~= "modifier_visage_soul_assumption_custom" then
                local ok, err = pcall(function()
                    mod:OnTakeDamage(params)
                end)

                if not ok then
                    print("[modifier_events_thinker_woda] OnTakeDamage unit modifier error:", err)
                end
            end
        end
    end
end