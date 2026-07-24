--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_patrol_reward_2_necro_effect", "modifiers/patrol_rewards/modifier_patrol_reward_2_necro", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_patrol_reward_2_necro_creeps", "modifiers/patrol_rewards/modifier_patrol_reward_2_necro", LUA_MODIFIER_MOTION_NONE)


modifier_patrol_reward_2_necro = class({})
function modifier_patrol_reward_2_necro:IsHidden() return true end
function modifier_patrol_reward_2_necro:RemoveOnDeath() return false end
function modifier_patrol_reward_2_necro:IsPurgable() return false end


function modifier_patrol_reward_2_necro:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
local delay = self.parent:GetTalentValue("modifier_patrol_reward_necro", "delay", true)

CustomGameEventManager:Send_ServerToAllClients("NecroAttack",  {delay = delay, player_id = self.parent:GetPlayerOwnerID(), attacker = self.parent:GetUnitName()})

for team,tower in pairs(towers) do
	if team ~= self.parent:GetTeamNumber() then
		towers[team]:AddNewModifier(self.parent, self, "modifier_patrol_reward_2_necro_effect", {duration = delay, is_caster = 0})
	end
end

if towers[self.parent:GetTeamNumber()] then
	towers[self.parent:GetTeamNumber()]:AddNewModifier(self.parent, self, "modifier_patrol_reward_2_necro_effect", {duration = delay, is_caster = 1})
end

self:Destroy()
end


modifier_patrol_reward_2_necro_effect = class({})
function modifier_patrol_reward_2_necro_effect:IsHidden() return true end
function modifier_patrol_reward_2_necro_effect:IsPurgable() return false end
function modifier_patrol_reward_2_necro_effect:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_patrol_reward_2_necro_effect:OnCreated(table)
if not IsServer() then return end 

self.parent = self:GetParent()
self.enemy_caster = self:GetCaster()

self.ids = dota1x6:FindPlayers(self.parent:GetTeamNumber())
self.is_caster = self.enemy_caster:GetTeamNumber() == self.parent:GetTeamNumber()

self.max_timer = table.duration
self.timer = self.max_timer + 1

self:OnIntervalThink()
self:StartIntervalThink(1)
end 

function modifier_patrol_reward_2_necro_effect:OnIntervalThink()
if not IsServer() then return end 

self.timer = self.timer - 1


if self.timer == 5 and not self.is_caster then 
    dota1x6:spawn_portal( self.parent:GetTeamNumber() )
end 

local mods = self.parent:FindAllModifiersByName(self:GetName())

if mods[1] ~= self then return end

if self.ids then
	for _,id in pairs(self.ids) do
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "NecroWave_think",  {time = self.timer, max = self.max_timer})
	end
end

end 


function modifier_patrol_reward_2_necro_effect:OnDestroy()
if not IsServer() then return end

if not self.is_caster then
	dota1x6:SpawnNecro(self.parent:GetTeamNumber())
end

local mods = self.parent:FindAllModifiersByName(self:GetName())
if #mods > 1 then return end

if self.ids then
	for _,id in pairs(self.ids) do
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "NecroWave_hide",  {})
	end
end

end 




modifier_patrol_reward_2_necro_creeps = class({})
function modifier_patrol_reward_2_necro_creeps:IsHidden() return true end
function modifier_patrol_reward_2_necro_creeps:IsPurgable() return false end 
function modifier_patrol_reward_2_necro_creeps:OnCreated(table)
if not IsServer() then return end 

self.caster = self:GetCaster()
self.parent = self:GetParent()

end 

function modifier_patrol_reward_2_necro_creeps:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL
}
end

function modifier_patrol_reward_2_necro_creeps:GetAbsoluteNoDamagePhysical(params)
if not IsServer() then return end
if params.attacker and params.attacker:IsBuilding() then
	return 1
end

end


