--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


TEAMS_COLORS = 
{
	[DOTA_TEAM_GOODGUYS] = Vector(61, 210, 150),
	[DOTA_TEAM_BADGUYS]  = Vector(243, 201, 9),
	[DOTA_TEAM_CUSTOM_1] = Vector(197, 77, 168),
	[DOTA_TEAM_CUSTOM_2] = Vector(255, 108, 0),
	[DOTA_TEAM_CUSTOM_3] = Vector(52, 85, 255),
	[DOTA_TEAM_CUSTOM_4] = Vector(101, 212, 19),
	[DOTA_TEAM_CUSTOM_5] = Vector(129, 83, 54),
	[DOTA_TEAM_CUSTOM_6] = Vector(27, 192, 216),
	[DOTA_TEAM_CUSTOM_7] = Vector(199, 228, 13),
	[DOTA_TEAM_CUSTOM_8] = Vector(140, 42, 244),
	[DOTA_TEAM_NEUTRALS] = Vector(220,220,220),
}
require("configs/emblems_list")
modifier_teleport_fx_client = class({})
function modifier_teleport_fx_client:IsHidden() return true end
function modifier_teleport_fx_client:IsPurgable() return false end
function modifier_teleport_fx_client:IsPurgeException() return false end
function modifier_teleport_fx_client:RemoveOnDeath() return false end
function modifier_teleport_fx_client:OnCreated()
    if not IsServer() then return end
    local particle = "particles/items2_fx/teleport_start.vpcf"
    local player_id = self:GetParent():GetPlayerOwnerID()
    if player_system.PLAYERS_GLOBAL_INFORMATION[player_id] then
        if player_system.PLAYERS_GLOBAL_INFORMATION[player_id].teleport_id and tonumber(player_system.PLAYERS_GLOBAL_INFORMATION[player_id].teleport_id) ~= 0 then
            particle = _G.EMBLEMS_LIST[tonumber(player_system.PLAYERS_GLOBAL_INFORMATION[player_id].teleport_id)]["particle_name"]
        end
    end
    local dur = self:GetDuration() + 1
    local pfx = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(pfx, 2, Vector(TEAMS_COLORS[self:GetParent():GetTeamNumber()][1]/255, TEAMS_COLORS[self:GetParent():GetTeamNumber()][2]/255, TEAMS_COLORS[self:GetParent():GetTeamNumber()][3]/255))
    ParticleManager:SetParticleControl(pfx, 7, Vector(dur, dur, dur))
    self:AddParticle(pfx, false, false, -1, false, false)
    EmitSoundOn("Portal.Loop_Appear", self:GetParent())

    if particle == "particles/items2_fx/teleport_start.vpcf" then
        local pfx_origin = ParticleManager:CreateParticle("particles/items2_fx/teleport_origin.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(pfx_origin, 2, Vector(TEAMS_COLORS[self:GetParent():GetTeamNumber()][1]/255, TEAMS_COLORS[self:GetParent():GetTeamNumber()][2]/255, TEAMS_COLORS[self:GetParent():GetTeamNumber()][3]/255))
        self:AddParticle(pfx_origin, false, false, -1, false, false)
    end
end

function modifier_teleport_fx_client:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    StopSoundOn("Portal.Loop_Appear", parent)
    Timers:CreateTimer(0.1, function()
        StopSoundOn("Portal.Loop_Appear", parent)
    end)
end