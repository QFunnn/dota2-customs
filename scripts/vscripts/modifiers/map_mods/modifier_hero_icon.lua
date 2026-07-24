--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_hero_icon = class({})


function modifier_hero_icon:IsHidden() return false end
function modifier_hero_icon:IsPurgable() return false end
function modifier_hero_icon:RemoveOnDeath() return false end


function modifier_hero_icon:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PROVIDES_FOW_POSITION 
}
end

function modifier_hero_icon:GetModifierProvidesFOWVision()
return 1
end

function modifier_hero_icon:CheckState()
return 
{
    [MODIFIER_STATE_UNSELECTABLE] = true,
    [MODIFIER_STATE_ATTACK_IMMUNE] = true,
    [MODIFIER_STATE_MAGIC_IMMUNE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_OUT_OF_GAME] = true,
    [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
}
end

