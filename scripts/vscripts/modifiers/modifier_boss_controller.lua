--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_boss_controller = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
})

function modifier_boss_controller:OnCreated(table)
    if not IsServer() then return end
    local TeamID = table.team

    if TeamID == nil then return end

    local TeamColor = GameMode:GetTeamColor(TeamID)

    if TeamColor == nil then return end

    local fx = ParticleManager:CreateParticle("particles/boss_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(fx, 1, self:GetParent(), PATTACH_OVERHEAD_FOLLOW, "", Vector(0,0,0), true)
    ParticleManager:SetParticleControl(fx, 3, Vector(TeamColor[1],TeamColor[2],TeamColor[3]))
    ParticleManager:SetParticleControl(fx, 4, Vector(150, 0, 0))

    local fTeamPlayerID, PlayerInfo = Players:GetTeamPlayerByNum(TeamID, 1)
    if fTeamPlayerID and PlayerInfo then
        if Players:IsValidHero(PlayerInfo.hero) then
            local HeroInfo = KeyValues:GetHero(PlayerInfo.hero:GetUnitName())
            if HeroInfo then
                local Icon = HeroInfo.minimap_icon_id
                if Icon > -1 then
                    ParticleManager:SetParticleControl(fx, 2, Vector(Icon,32,0))
                end
            end
        end
    end

    self:AddParticle(fx, false, false, -1, false, true)

    local TeamFx = ParticleManager:CreateParticleForTeam("particles/boss_lightning_team.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), TeamID)
    ParticleManager:SetParticleControl(TeamFx, 3, Vector(TeamColor[1],TeamColor[2],TeamColor[3]))
    ParticleManager:SetParticleControl(TeamFx, 4, Vector(150, 0, 0))
    self:AddParticle(TeamFx, false, false, -1, false, false)
end