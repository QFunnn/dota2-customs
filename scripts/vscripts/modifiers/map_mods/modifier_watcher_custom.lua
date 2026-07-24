--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_watcher_custom_animation_idle", "modifiers/map_mods/modifier_watcher_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_watcher_custom_animation_sleep", "modifiers/map_mods/modifier_watcher_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_watcher_custom_animation_cast", "modifiers/map_mods/modifier_watcher_custom", LUA_MODIFIER_MOTION_NONE)

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

modifier_watcher_custom = class({})
function modifier_watcher_custom:IsHidden() return true end
function modifier_watcher_custom:IsPurgable() return false end
function modifier_watcher_custom:DestroyOnExpire() return false end


function modifier_watcher_custom:OnCreated(kv)
self.parent = self:GetParent()

if not IsServer() then return end 

self.base_particle = nil
self.clock_particle = {}

self.material = kv.material

self:GetParent():SetMaterialGroup(tostring(self.material))

self.progress = 0
self.captured_team = -1

self.vision_range = 1200
self.interval = 0.03
self.cooldown = 0

self.max_cd =  120
self.radius = 180
self.clock_radius = 100

self.timer = 0
self.capture_time = 1

self.vPosition = self:GetParent():GetAbsOrigin()
self:StartIntervalThink(self.interval)
end


function modifier_watcher_custom:CheckBaseParticle()
if not IsServer() then return end

if self.captured_team == -1 then 

	if not self.base_particle then 
		self.base_particle = ParticleManager:CreateParticle("particles/shrine/capture_point_ring_overthrow.vpcf", PATTACH_WORLDORIGIN, self.parent)
		local pos = GetGroundPosition(self.parent:GetAbsOrigin(), nil)
		ParticleManager:SetParticleControl(self.base_particle, 0, pos)
		ParticleManager:SetParticleControl(self.base_particle, 3, Vector(150,150,150))
		ParticleManager:SetParticleControl(self.base_particle, 9, Vector(self.radius, 0, 0))
	end 
else 
	if self.base_particle then 
		ParticleManager:DestroyParticle(self.base_particle, false)
		ParticleManager:ReleaseParticleIndex(self.base_particle)
		self.base_particle = nil 
	end 
end 



if self.progress <= 0 or self.progress >= 1 then 
	for team,particle in pairs(self.clock_particle) do 

		ParticleManager:DestroyParticle(particle, true)
		ParticleManager:ReleaseParticleIndex(particle)

		self.clock_particle[team] = nil
	end 

	return
end 

for _,hero in pairs(players) do 

	local team = hero:GetTeamNumber()

	if not self.clock_particle[team] then 
		self.clock_particle[team] = ParticleManager:CreateParticleForTeam("particles/shrine/capture_point_ring_clock_overthrow.vpcf", PATTACH_WORLDORIGIN, self.parent, team)

		ParticleManager:SetParticleControl(self.clock_particle[team], 0, Vector(self.parent:GetAbsOrigin().x, self.parent:GetAbsOrigin().y, self.parent:GetAbsOrigin().z + 75))
		ParticleManager:SetParticleControl(self.clock_particle[team], 11, Vector(0, 0, 1))
	end 

	if self.captured_team == team then 
		ParticleManager:SetParticleControl(self.clock_particle[team], 3, Vector(0,162,255))
		ParticleManager:SetParticleControl(self.clock_particle[team], 9, Vector(self.clock_radius, 0, 0))
	else 
		if self.captured_team == -1 then 
			ParticleManager:SetParticleControl(self.clock_particle[team], 3, Vector(220,220,220))
			ParticleManager:SetParticleControl(self.clock_particle[team], 9, Vector(self.radius, 0, 0))
		else  
			ParticleManager:SetParticleControl(self.clock_particle[team], 3, Vector(255,79,22))
			ParticleManager:SetParticleControl(self.clock_particle[team], 9, Vector(self.clock_radius, 0, 0))
		end 
	end 
	ParticleManager:SetParticleControl(self.clock_particle[team], 17, Vector(self.progress, 0, 0))
end  

end 




function modifier_watcher_custom:OnIntervalThink()
if not IsServer() then return end

self:CheckBaseParticle()
	
if self.cooldown > 0 then 

	self:ChangeAnimation("open")
	self.cooldown = self.cooldown - self.interval

	self.progress = (self.cooldown/self.max_cd)

	AddFOWViewer(self.captured_team, self.parent:GetAbsOrigin(), self.vision_range, FrameTime(), false)

	if self.cooldown <= 0 then 
		self:ResetObserver()
	end
	return 
end  

self.heroes_in_radius = FindUnitsInRadius (DOTA_TEAM_NEUTRALS, self.vPosition, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)

local heroes = {} 
local team_register = {}

for _,hero in pairs(self.heroes_in_radius) do 
	if not hero:IsTempestDouble() then 
		local team = hero:GetTeamNumber()
		if not team_register[team] then
			team_register[team] = true
			heroes[#heroes + 1] = hero
		end
	end
end 


if #heroes == 1 then

	if self.progress < 1 then
		self:ChangeAnimation("cast")
	end

	self.timer = self.timer + self.interval
	self.progress = self.timer/self.capture_time

	if self.progress >= 1 then
		self:CaptureObserver(heroes[1]:GetId())
		self.progress = 1
	end
else 
	self.timer =  math.max(0, (self.timer - self.interval))
	self.progress = self.timer/self.capture_time
end 

if self.progress <= 0 then 

	self:ChangeAnimation("flail")
end 

end



function modifier_watcher_custom:CaptureObserver(id)
if not IsServer() then return end

local player = players[id]
if not player then return end

self.captured_team = player:GetTeamNumber()
self.cooldown = self.max_cd
self.timer = 0


if player then 
	local bonus_gold = 50
	local team_players = dota1x6:FindPlayers(self.captured_team, false, true)
	for _,team_player in pairs(team_players) do
		team_player:GiveGold(bonus_gold/#team_players, true)
	end
end 


if self.effect then return end 

self.parent:EmitSound("Watcher.Captured")
self.effect = ParticleManager:CreateParticle("particles/econ/items/items_fx/lantern_of_sight_controlled.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)

ParticleManager:SetParticleControl(self.effect, 11, Vector(self.vision_range,0,0))
ParticleManager:SetParticleControl(self.effect, 12, Vector(self.material - 1,0,0))

self.particle_hero_icon = ParticleManager:CreateParticle("particles/hero_capture_icon/hero_capture_icon.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
if player then 
	local name = dota1x6:GetHeroIcon(id)
	if not name then
		name = player:GetUnitName()
	end
    local width_table = Vector(1, 1, 0)
    if icon_hero_width[name] then
    	width_table = Vector(icon_hero_width[name][1], icon_hero_width[name][2], 0)
    end

    ParticleManager:SetParticleControl(self.particle_hero_icon, 1, Vector(icon_hero_id[name],0,0))
    ParticleManager:SetParticleControl(self.particle_hero_icon, 2, width_table)
end

self:ChangeAnimation("open")
end




function modifier_watcher_custom:ResetObserver()
if not IsServer() then return end

self.captured_team = -1
self.cooldown = 0
self.timer = 0

if self.effect then 
	ParticleManager:DestroyParticle(self.effect, false)
	ParticleManager:ReleaseParticleIndex(self.effect)
	self.effect = nil
end 

if self.particle_hero_icon then
	ParticleManager:DestroyParticle(self.particle_hero_icon, true)
	ParticleManager:ReleaseParticleIndex(self.particle_hero_icon)
end

self.parent:EmitSound("Watcher.Reset")
self:ChangeAnimation("flail")
end



function modifier_watcher_custom:IsCaptured(team_number)
	if team_number == DOTA_TEAM_NEUTRALS then
		self:ChangeAnimation("flail")
		return false
	end
	if self.captured_team == team_number then
		self:ChangeAnimation("open")
		return true
	end
	return false
end

function modifier_watcher_custom:CheckState()
	return 
	{
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		--[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
	}
end

function modifier_watcher_custom:ChangeAnimation(anim)
if not IsServer() then return end

if anim ~= "flail" then
	self.parent:RemoveModifierByName("modifier_watcher_custom_animation_idle")
end
if anim ~= "open" then
	self.parent:RemoveModifierByName("modifier_watcher_custom_animation_sleep")
end
if anim ~= "cast" then
	self.parent:RemoveModifierByName("modifier_watcher_custom_animation_cast")
end



if anim == "flail" and not self.parent:HasModifier("modifier_watcher_custom_animation_idle") then
	self.parent:AddNewModifier(self.parent, nil, "modifier_watcher_custom_animation_idle", {})
end
if anim == "open" and not self.parent:HasModifier("modifier_watcher_custom_animation_sleep") then
	self.parent:AddNewModifier(self.parent, nil, "modifier_watcher_custom_animation_sleep", {})
end
if anim == "cast" and not self.parent:HasModifier("modifier_watcher_custom_animation_cast") then
	self.parent:AddNewModifier(self.parent, nil, "modifier_watcher_custom_animation_cast", {})
end

end

modifier_watcher_custom_animation_idle = class({})
function modifier_watcher_custom_animation_idle:IsHidden() return true end
function modifier_watcher_custom_animation_idle:IsPurgable() return false end
function modifier_watcher_custom_animation_idle:IsPurgeException() return false end
function modifier_watcher_custom_animation_idle:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end
function modifier_watcher_custom_animation_idle:GetOverrideAnimation()
return ACT_DOTA_RUN
end


modifier_watcher_custom_animation_sleep = class({})
function modifier_watcher_custom_animation_sleep:IsHidden() return true end
function modifier_watcher_custom_animation_sleep:IsPurgable() return false end
function modifier_watcher_custom_animation_sleep:IsPurgeException() return false end
function modifier_watcher_custom_animation_sleep:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end
function modifier_watcher_custom_animation_sleep:GetOverrideAnimation()
return ACT_DOTA_CHANNEL_ABILITY_2
end


modifier_watcher_custom_animation_cast = class({})
function modifier_watcher_custom_animation_cast:IsHidden() return true end
function modifier_watcher_custom_animation_cast:IsPurgable() return false end
function modifier_watcher_custom_animation_cast:IsPurgeException() return false end
function modifier_watcher_custom_animation_cast:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end
function modifier_watcher_custom_animation_cast:GetOverrideAnimation()
return ACT_DOTA_CHANNEL_ABILITY_1
end




function modifier_watcher_custom_animation_cast:OnCreated()
if not IsServer() then return end 

self:GetParent():EmitSound("Watcher.Channel")
end 


function modifier_watcher_custom_animation_cast:OnDestroy()
if not IsServer() then return end 

self:GetParent():StopSound("Watcher.Channel")
end 