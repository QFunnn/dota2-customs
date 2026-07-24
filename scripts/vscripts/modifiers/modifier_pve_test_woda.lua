--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pve_test_woda = class({})
function modifier_pve_test_woda:IsPurgable() return false end
function modifier_pve_test_woda:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MIN_HEALTH,
    }
end

function modifier_pve_test_woda:GetModifierPreAttack_BonusDamage()
    return 100000
end

function modifier_pve_test_woda:GetMinHealth()
    return 1
end