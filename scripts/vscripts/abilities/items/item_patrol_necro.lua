--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_patrol_necro", "abilities/items/item_patrol_necro", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_patrol_necro_creeps", "abilities/items/item_patrol_necro", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_patrol_necro_caster", "abilities/items/item_patrol_necro", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_patrol_necro_timer", "abilities/items/item_patrol_necro", LUA_MODIFIER_MOTION_NONE)

item_patrol_necro = class({})

function item_patrol_necro:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
end


function item_patrol_necro:OnSpellStart()
local caster = self:GetCaster()

local find_towers = FindUnitsInRadius(caster:GetTeamNumber(), self:GetCursorPosition(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

if #find_towers == 0 then return false end

local tower = towers[find_towers[1]:GetTeamNumber()]

if not tower then return end
if tower:HasModifier("modifier_item_patrol_necro") then

    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(caster:GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#necro_used"})
	return
end

local heroes = dota1x6:FindPlayers(tower:GetTeamNumber(), true)
CustomGameEventManager:Send_ServerToAllClients("mini_alert_event",  {hero_1 = caster:GetUnitName(), heroes_2 = heroes, event_type = "necro"})

local delay = self:GetSpecialValueFor("delay")
local damage_out = self:GetSpecialValueFor("damage_out")
local damage_inc = self:GetSpecialValueFor("damage_inc")


tower:AddNewModifier(caster, self, "modifier_item_patrol_necro", {duration = delay, damage_out = damage_out, damage_inc = damage_inc})
caster:AddNewModifier(caster, self, "modifier_item_patrol_necro_caster", {duration = delay})

self:Destroy()
end




modifier_item_patrol_necro = class(mod_hidden)
function modifier_item_patrol_necro:OnCreated(table)
if not IsServer() then return end 

self.parent = self:GetParent()
self.caster = self:GetCaster()

self.ids = dota1x6:FindPlayers(self.parent:GetTeamNumber())

self.damage_out = table.damage_out
self.damage_inc = table.damage_inc
self.max_timer = table.duration
self.timer = self.max_timer + 1

self:OnIntervalThink()
self:StartIntervalThink(1)
end 

function modifier_item_patrol_necro:OnIntervalThink()
if not IsServer() then return end 

self.timer = self.timer - 1

if self.timer == 5 then 
	local spawner = Entities:FindByName(nil, self.parent:GetName().."_vision_2")
	if spawner then
		local count = 0
		Timers:CreateTimer(0, function()
			GameRules:ExecuteTeamPing( self.parent:GetTeamNumber(), spawner:GetAbsOrigin().x, spawner:GetAbsOrigin().y, player, 0 )
			count = count + 1
			if count <= 2 then
				return 1.5
			end
		end)
	end
    dota1x6:spawn_portal( self.parent:GetTeamNumber(), self.caster:GetTeamNumber() )
end 

if self.ids then
	for _,id in pairs(self.ids) do
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "NecroWave_think",  {time = self.timer, max = self.max_timer})
	end
end

end 


function modifier_item_patrol_necro:OnDestroy()
if not IsServer() then return end

dota1x6:SpawnNecro(self.parent:GetTeamNumber(), self.caster:GetTeamNumber(), self.damage_out, self.damage_inc)

if self.ids then
	for _,id in pairs(self.ids) do
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "NecroWave_hide",  {})
	end
end

end 




modifier_item_patrol_necro_creeps = class({})
function modifier_item_patrol_necro_creeps:IsHidden() return true end
function modifier_item_patrol_necro_creeps:IsPurgable() return false end 
function modifier_item_patrol_necro_creeps:OnCreated(table)
if not IsServer() then return end 
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.caster_team = table.caster_team
self.damage_out = table.damage_out
self.damage_inc = table.damage_inc

self.interval = 0.5
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end 

function modifier_item_patrol_necro_creeps:OnIntervalThink()
if not IsServer() then return end
if not self.caster_team then return end

AddFOWViewer(self.caster_team, self.parent:GetAbsOrigin(), 400, self.interval + 0.1, false)
end

function modifier_item_patrol_necro_creeps:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL
}
end

function modifier_item_patrol_necro_creeps:GetAbsoluteNoDamagePhysical(params)
if not IsServer() then return end
if params.attacker and params.attacker:IsBuilding() then
	return 1
end

end


modifier_item_patrol_necro_caster = class(mod_visible)
function modifier_item_patrol_necro_caster:RemoveOnDeath() return false end
function modifier_item_patrol_necro_caster:IsDebuff() return true end
function modifier_item_patrol_necro_caster:GetTexture() return "item_necronomicon_2" end






modifier_item_patrol_necro_timer = class(mod_visible)
function modifier_item_patrol_necro_timer:IsDebuff() return true end
function modifier_item_patrol_necro_timer:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_patrol_necro_timer:RemoveOnDeath() return false end
function modifier_item_patrol_necro_timer:GetTexture() return "item_necronomicon_3" end
function modifier_item_patrol_necro_timer:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.item = EntIndexToHScript(table.item)
self:StartIntervalThink(1)
end

function modifier_item_patrol_necro_timer:OnIntervalThink()
if not IsServer() then return end
if IsValid(self.item) then return end
self:Destroy()
end

function modifier_item_patrol_necro_timer:OnDestroy()
if not IsServer() then return end

if IsValid(self.item) then
	local container = self.item:GetContainer()
	UTIL_Remove(self.item)
	if container then
		UTIL_Remove(container)
	end
end

end

function modifier_item_patrol_necro_timer:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_item_patrol_necro_timer:OnTooltip()
if IsServer() then return end
return self:GetRemainingTime()
end