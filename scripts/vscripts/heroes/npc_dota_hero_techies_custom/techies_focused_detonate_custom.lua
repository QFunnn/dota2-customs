--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


techies_focused_detonate_custom = class({})

function techies_focused_detonate_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function techies_focused_detonate_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local radius = self:GetSpecialValueFor("radius")
    local techies_remote_mines_custom = self:GetCaster():FindAbilityByName("techies_remote_mines_custom")
    if techies_remote_mines_custom == nil then return end
    local remote_mines = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for i = 1, #remote_mines do
        local techies_remote_mines_self_detonate_custom = remote_mines[i]:FindAbilityByName("techies_remote_mines_self_detonate_custom")
        if techies_remote_mines_self_detonate_custom then
            techies_remote_mines_self_detonate_custom:OnSpellStart(true)
        end
    end
end