--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_mass_arena_player = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
})

function modifier_mass_arena_player:OnCreated(table)
    if not IsServer() then return end

    local WinBuffs = table.win_buffs
    if WinBuffs ~= nil and WinBuffs < 100 then
        local Digits = extractDigits(WinBuffs)
        local fDigit = Digits[1]
        local sDigit = Digits[2]
        
        local iIsTwoDigits = fDigit > 0 and 1 or 0
        local WinFx = ParticleManager:CreateParticle("particles/minigames/win_buff_counter/win_buff_counter.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(WinFx, 3, Vector(0,0,250))
        ParticleManager:SetParticleControl(WinFx, 1, Vector(iIsTwoDigits, sDigit, 0))
        ParticleManager:SetParticleControl(WinFx, 2, Vector(iIsTwoDigits, fDigit, 0))
        self:AddParticle(WinFx, false, false, -1, false, false)
    end
end