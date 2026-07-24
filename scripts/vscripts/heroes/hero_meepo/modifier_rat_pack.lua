--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rat_pack = class({}) --2022.9.16，API不生效，暂不制作

function modifier_rat_pack:IsHidden()
    return false
end
function modifier_rat_pack:RemoveOnDeath()
    return false
end
function modifier_rat_pack:OnCreated(kv)
    if IsServer() then
    end
end
function modifier_rat_pack:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_RAT_PACK
    }
end
function modifier_rat_pack:GetModifierIsRatPack()
    return 1
end