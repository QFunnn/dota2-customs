--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_fortune_favors_the_bold_custom", "heroes/npc_dota_hero_pangolier_custom/pangolier_fortune_favors_the_bold_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_fortune_favors_the_bold_custom = class({})

function pangolier_fortune_favors_the_bold_custom:GetIntrinsicModifierName()
    return "modifier_pangolier_fortune_favors_the_bold_custom"
end

modifier_pangolier_fortune_favors_the_bold_custom = class({})
function modifier_pangolier_fortune_favors_the_bold_custom:IsHidden() return true end
function modifier_pangolier_fortune_favors_the_bold_custom:IsPurgable() return false end
function modifier_pangolier_fortune_favors_the_bold_custom:IsPurgeException() return false end
function modifier_pangolier_fortune_favors_the_bold_custom:RemoveOnDeath() return false end
function modifier_pangolier_fortune_favors_the_bold_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PSEUDORANDOM_BONUS,
    }
end
function modifier_pangolier_fortune_favors_the_bold_custom:GetModifierPropertyPseudoRandomBonus(params)
    return self:GetAbility():GetSpecialValueFor("chance_bonus")
end