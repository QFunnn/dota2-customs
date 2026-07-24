--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_bog = class({})
function modifier_woda_bog:IsHidden() return true end
function modifier_woda_bog:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end
function modifier_woda_bog:GetModifierPreAttack_BonusDamage()
    return 1000000
end