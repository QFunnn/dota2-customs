--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_tower_pre_game = class({})
function modifier_tower_pre_game:IsHidden() return true end
function modifier_tower_pre_game:IsPurgable() return false end


function modifier_tower_pre_game:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.team = self.parent:GetTeamNumber()

self.radius = 1100
self.intervak = 0.05

local effect = "particles/generic/duel_wall.vpcf"
if teleports[self.parent:GetTeamNumber()] then
  if IsDire(teleports[self.parent:GetTeamNumber()]:GetName()) then
    effect = "particles/generic/duel_wall_dire.vpcf"
  end
end

self.height = GetGroundHeight(self.parent:GetAbsOrigin(), nil) - 10

self.wall_particle = {}
local tower_name = self.parent:GetName()
for count = 1,4 do
  local wall_1 = Entities:FindByName(nil, tower_name.."_wall_"..tostring(count).."_1")
  local wall_2 = Entities:FindByName(nil, tower_name.."_wall_"..tostring(count).."_2")
  if wall_1 and wall_2 then
    self.wall_particle[count] = ParticleManager:CreateParticle(effect, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.wall_particle[count], 0, wall_1:GetAbsOrigin())
    ParticleManager:SetParticleControl(self.wall_particle[count], 1, wall_2:GetAbsOrigin())
    self:AddParticle( self.wall_particle[count], false, false, -1, false, false  )
  end
end

self:StartIntervalThink(0.05) 
end

function modifier_tower_pre_game:CheckPos(pos)
return (self.parent:GetAbsOrigin() - pos):Length2D() <= self.radius and GetGroundHeight(pos, nil) >= self.height
end

function modifier_tower_pre_game:OnIntervalThink()
if not IsServer() then return end

local ids = dota1x6:FindPlayers(self.team)
if not ids then return end

for _,id in pairs(ids) do
  local player = players[id]
  local abs = player:GetAbsOrigin()

  if not self:CheckPos(abs) then
    player:WallKnock(self.parent:GetAbsOrigin(), self.radius, self.height, true)
  end
end

end