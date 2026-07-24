--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_patrol_reward_1_vision = class({})
function modifier_patrol_reward_1_vision:IsHidden() return false end
function modifier_patrol_reward_1_vision:GetTexture() return self.hero_name end
function modifier_patrol_reward_1_vision:RemoveOnDeath() return false end
function modifier_patrol_reward_1_vision:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_patrol_reward_1_vision:IsPurgable() return false end
function modifier_patrol_reward_1_vision:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddDeathEvent(self, true)
self.hero = nil
self.parent_team = self.parent:GetTeamNumber()

local ids = {}
for id,player in pairs(players) do
	local team = player:GetTeamNumber()
	if team ~= self.parent_team then
		ids[#ids + 1] = id
	end
end

if #ids <= 0 then
	self:Destroy()
	return
end

self.hero = players[ids[RandomInt(1, #ids)]]

if not self.hero or self.hero:IsNull() then
	self:Destroy()
	return
end

EmitSoundOnEntityForPlayer("UI.Patrol_contract", self.parent, self.parent:GetPlayerOwnerID())

self.interval = 0.3
self.hero_name = self.hero:GetUnitName()

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()
end

function modifier_patrol_reward_1_vision:OnIntervalThink()
if not IsServer() then return end
if not self.hero or self.hero:IsNull() or not self.hero:IsAlive() then return end 

AddFOWViewer(self.parent_team, self.hero:GetAbsOrigin(), 50, self.interval + 0.1, false)
end


function modifier_patrol_reward_1_vision:AddCustomTransmitterData()
return 
{
	hero_name = self.hero_name,
}
end

function modifier_patrol_reward_1_vision:HandleCustomTransmitterData(data)
self.hero_name = data.hero_name
end



function modifier_patrol_reward_1_vision:DeathEvent(params)
if not IsServer() then return end
if not self.hero or self.hero:IsNull() or self.hero:IsReincarnating() then return end
if self.hero ~= params.unit then return end
if params.unit:IsReincarnating() then return end

local attacker = params.attacker

if not attacker then return end
if attacker:IsBuilding() then return end

if attacker:GetTeamNumber() ~= self.parent:GetTeamNumber() then return end

self:Destroy()
end