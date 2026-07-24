--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_patrol_armor", "abilities/patrol_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_patrol_armor_buff", "abilities/patrol_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_patrol_armor_death", "abilities/patrol_armor", LUA_MODIFIER_MOTION_NONE)




patrol_armor = class({})

function patrol_armor:GetIntrinsicModifierName() return "modifier_patrol_armor" end

modifier_patrol_armor = class({})
function modifier_patrol_armor:IsPurgable() return false end
function modifier_patrol_armor:IsHidden() return true end
function modifier_patrol_armor:OnCreated(table)
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.ability = self:GetAbility()
self.radius = self.ability:GetSpecialValueFor("radius")

if not IsServer() then return end
if not IsValidEntity(self.ability) then return end

self.armor = self.ability:GetSpecialValueFor("armor_first")

if not IsServer() then return end

self.interval = 0.2
self:OnIntervalThink(true)
self:StartIntervalThink(self.interval)
end

function modifier_patrol_armor:OnIntervalThink(first)
if not IsServer() then return end
if not IsValidEntity(self.parent) then return end

if self.parent.patrol_teams then
	if not self.init and self.parent:IsAlive() then
		self.init = true
		for _,tower in pairs(towers) do
			if tower.map_team and self.parent.patrol_teams[tower.map_team] then
				tower.active_patrol[self.parent] = 1
			end
		end
	end
	if not self.parent:IsAlive() and not first then
		for _,tower in pairs(towers) do
			if tower.map_team and self.parent.patrol_teams[tower.map_team] then
				tower.active_patrol[self.parent] = nil
			end
		end
	end
end

local team_register = {}
local count = 0

for _,player in pairs(players) do
	local team = player:GetTeamNumber()

	if self.parent.patrol_teams and self.parent.patrol_teams[player.map_team] then
	 	AddFOWViewer(team, self.parent:GetAbsOrigin(), 500, self.interval + 0.1, false)
	end

	if (player:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius and not team_register[player:GetTeamNumber()] and player:IsAlive() then
		team_register[player:GetTeamNumber()] = true
		count = count + 1
		if count > 1 then
			break
		end
	end
end

if count > 1 and not self.parent:HasModifier("modifier_patrol_armor_buff") then 
	self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_patrol_armor_buff", {})
end

if count <= 1 and self.parent:HasModifier("modifier_patrol_armor_buff") then
	self.parent:RemoveModifierByName("modifier_patrol_armor_buff") 
end

end



function modifier_patrol_armor:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end


function modifier_patrol_armor:DeathEvent(params)
if not IsServer() then return end
if not  dota1x6:IsPatrol(params.unit:GetUnitName()) then return end
if (self.parent:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > self.radius then return end
if not params.attacker then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_armor_death", {duration = self:GetAbility():GetSpecialValueFor("death_duration")})

end


function modifier_patrol_armor:GetModifierIncomingDamage_Percentage(params)
if not IsServer() then return end

local hero = players[params.attacker:GetId()]

if hero and (hero:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then
	return -200
end

if towers[params.attacker:GetTeamNumber()] then 
	dota1x6:ActivatePushReduce(params.attacker:GetTeamNumber())
end

if self.parent:HasModifier("modifier_patrol_armor_buff") then 
	return self.armor
end

end





modifier_patrol_armor_death = class({})

function modifier_patrol_armor_death:IsHidden() return true end
function modifier_patrol_armor_death:IsPurgable() return false end
function modifier_patrol_armor_death:OnCreated(table)

self.incoming = self:GetAbility():GetSpecialValueFor("death_incoming")
if not IsServer() then return end
self.particle = ParticleManager:CreateParticle("particles/glyph_damage.vpcf" , PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(120,1,1))
self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_patrol_armor_death:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MIN_HEALTH
}
end

function modifier_patrol_armor_death:GetMinHealth()
if self:GetParent():HasModifier("modifier_death") then return end
return 1
end



modifier_patrol_armor_buff = class({})
function modifier_patrol_armor_buff:IsHidden() return false end
function modifier_patrol_armor_buff:IsPurgable() return false end
function modifier_patrol_armor_buff:GetEffectName()
return "particles/items2_fx/medallion_of_courage_friend.vpcf"
end
function modifier_patrol_armor_buff:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end
