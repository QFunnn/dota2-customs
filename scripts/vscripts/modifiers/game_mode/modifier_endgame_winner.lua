--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_endgame_winner = class({})
function modifier_endgame_winner:IsHidden() return true end
function modifier_endgame_winner:IsPurgable() return false end
function modifier_endgame_winner:CheckState()
return 
{
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_OUT_OF_GAME] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
}
end

function modifier_endgame_winner:OnCreated(table)
if not IsServer() then return end 
self:GetParent():Stop()
self:GetParent():StartGesture(ACT_DOTA_VICTORY)
end 


function modifier_endgame_winner:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end


function modifier_endgame_winner:GetOverrideAnimation()
return ACT_DOTA_VICTORY
end