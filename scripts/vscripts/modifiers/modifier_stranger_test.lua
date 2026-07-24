--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_stranger_test = class({})
function modifier_stranger_test:IsPurgeException() return false end
function modifier_stranger_test:IsPurgable() return false end
function modifier_stranger_test:RemoveOnDeath() return false end
function modifier_stranger_test:IsHidden() return true end
function modifier_stranger_test:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_stranger_test:GetModifierDamageOutgoing_Percentage()
    return 10000
end

function modifier_stranger_test:CheckState()
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }
end