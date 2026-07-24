--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_donate_pet_inactive", "modifiers/main_mods/modifier_donate_pet", LUA_MODIFIER_MOTION_NONE )



modifier_donate_pet = class({})

function modifier_donate_pet:IsHidden() return true end
function modifier_donate_pet:IsPurgable() return false end
function modifier_donate_pet:RemoveOnDeath() return false end

function modifier_donate_pet:CheckState()
--if (self.tower and not self.tower:IsNull() and (self.tower:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= 900) then
--	return 
--	{
--		[MODIFIER_STATE_INVULNERABLE] = true,
--        [MODIFIER_STATE_UNSELECTABLE] = true,
--		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
--		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
--		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
--		[MODIFIER_STATE_OUT_OF_GAME] = true,
--		[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
--	}
--else 
	return 
	{
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
	}
	--end
end

function modifier_donate_pet:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_MODEL_SCALE
	}
end

function modifier_donate_pet:GetModifierMoveSpeed_Absolute()
if self.parent:HasModifier("modifier_donate_pet_inactive") then 
	return 250
end

return self.caster:GetMoveSpeedModifier(self.caster:GetBaseMoveSpeed(), true)
end


function modifier_donate_pet:GetModifierModelScale() 
return 20 + self.scale
end


function modifier_donate_pet:OnCreated(table)

self.parent = self:GetParent()
self.caster = self:GetCaster()

if not IsServer() then return end
self.tower = towers[self.caster:GetTeamNumber()]
self.parent:SetControllableByPlayer(self.caster:GetPlayerOwnerID(), false)

self.scale = table.scale
self.caster_alive = true

local player_table = CustomNetTables:GetTableValue('sub_data', tostring(self.caster:GetPlayerOwnerID()))

if player_table and player_table.pet_state then 
	local ability = self.parent:FindAbilityByName("donate_pet_ability")
	if ability then 

		if tonumber(player_table.pet_state) == 1 and ability:GetToggleState() == false then 
			ability:ToggleAbility()
		end 

		if tonumber(player_table.pet_state) == 0 and ability:GetToggleState() == true then 
			ability:ToggleAbility()
		end 
	end 
end 

CustomNetTables:SetTableValue('sub_data', tostring(self.caster:GetPlayerOwnerID()), player_table)
CustomGameEventManager:Send_ServerToAllClients('event_update_pets_index', {index = self.parent:GetEntityIndex()})

self.last_state = 0
self:StartIntervalThink(0.4)
end


function modifier_donate_pet:OnRefresh(table)
if not IsServer() then return end
self.scale = table.scale
end


function modifier_donate_pet:SaveState()
if not IsServer() then return end
local player_table = CustomNetTables:GetTableValue('sub_data', tostring(self.caster:GetPlayerOwnerID()))

if not player_table then return end 

player_table.pet_state = self:GetStackCount()
CustomNetTables:SetTableValue('sub_data', tostring(self.caster:GetPlayerOwnerID()), player_table)
end



function modifier_donate_pet:PlayEffect()
if not IsServer() then return end

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_start.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex( particle )
end



function modifier_donate_pet:OnIntervalThink()
local owner = self.caster

if not self.tower or self.tower:IsNull() then 
	self.tower = towers[self.caster:GetTeamNumber()]
	self:StartIntervalThink(0.1)
	return
end 


if self.parent:IsNull() then return end

if owner.pet_state == 1 then 
	if self.last_state == 0 then 
		--self:SaveState()
	end 
	self.last_state = 1
	self.parent:AddNewModifier(self.parent, nil, "modifier_donate_pet_inactive", {})
	self.parent:RemoveNoDraw()
	return 
else 
	if self.last_state == 1 then 
		--self:SaveState()
	end
	self.last_state = 0
	self.parent:RemoveModifierByName("modifier_donate_pet_inactive")
end 

local owner_pos = owner:GetAbsOrigin()
local pet_pos = self.parent:GetAbsOrigin()
local distance = ( owner_pos - pet_pos ):Length2D()
local owner_dir = owner:GetForwardVector()
local dir = owner_dir * RandomInt( 110, 140 )

if owner:IsAlive() or owner:IsReincarnating() then
	self.parent:RemoveNoDraw()

	self.caster_alive = true

	if distance > 900 then

		local a = RandomInt( 60, 120 )
		if RandomInt( 1, 2 ) == 1 then
			a = a * -1
		end
		local r = RotatePosition( Vector( 0, 0, 0 ), QAngle( 0, a, 0 ), dir )

		self:PlayEffect()

		self.parent:SetAbsOrigin( owner_pos + r )
		self.parent:SetForwardVector( owner_dir )
		FindClearSpaceForUnit( self.parent, owner_pos + r, true )

		local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
		ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex( particle )
		

	elseif distance > 150 then
		local right = RotatePosition( Vector( 0, 0, 0 ), QAngle( 0, RandomInt( 70, 110 ) * -1, 0 ), dir ) + owner_pos
		local left = RotatePosition( Vector( 0, 0, 0 ), QAngle( 0, RandomInt( 70, 110 ), 0 ), dir ) + owner_pos
		if ( pet_pos - right ):Length2D() > ( pet_pos - left ):Length2D() then
			self.parent:MoveToPosition( left )
		else
			self.parent:MoveToPosition( right )
		end
	elseif distance < 90 then
		self.parent:MoveToPosition( owner_pos + ( pet_pos - owner_pos ):Normalized() * RandomInt( 110, 140 ) )
	end
	
	if owner:IsInvisible() or owner:HasModifier("modifier_monkey_king_innate_custom") then
		self.parent:AddNewModifier(self.parent, self.parent, "modifier_invisible", {})
	else
		self.parent:RemoveModifierByName("modifier_invisible")
	end
else
	if self.caster_alive == true then 
		self:PlayEffect()

		FindClearSpaceForUnit( self.parent, self.tower:GetAbsOrigin(), true )
		self.caster_alive = false
	end

	self.parent:AddNoDraw()
end

self:StartIntervalThink(0.4)
end


modifier_donate_pet_inactive = class({})
function modifier_donate_pet_inactive:IsHidden() return true end
function modifier_donate_pet_inactive:IsPurgable() return false end
function modifier_donate_pet_inactive:RemoveOnDeath() return false end
function modifier_donate_pet_inactive:OnCreated()

self.parent = self:GetParent()
self.caster = self:GetCaster()
if not IsServer() then return end

self.tower = towers[self.caster:GetTeamNumber()]
self.tower_abs = self.tower:GetAbsOrigin()

if (self.tower_abs - self.parent:GetAbsOrigin()):Length2D() >= 1500 then 
	FindClearSpaceForUnit(self.parent, self.tower_abs, false)
end 

self.start_vec = RandomVector(620)

self.max_timer = 10
self.turn_max = 20
self.speed = 250
self.k = 1
self.stage = 1

local number = tonumber(teleports[self.caster:GetTeamNumber()]:GetName())
local spawner_abs = Entities:FindByName( nil, "spawner_team" ..number ):GetAbsOrigin()
   
local SpawnerVector  = (self.tower_abs - spawner_abs):Normalized()
self.SpawnAngle   = math.deg(math.atan2(SpawnerVector.x, SpawnerVector.y))

self:OnIntervalThink()
end


function modifier_donate_pet_inactive:OnIntervalThink()
if not IsServer() then return end


if self.stage == 0 then 
	self.stage = 1
	self:StartIntervalThink(self.max_timer)
	return
end

if self.stage == 1 then 

	self:IncrementStackCount()

	if self:GetStackCount() >= self.turn_max then 
		self:SetStackCount(0)
		self.k = self.k * -1
	end 

	repeat self.start_vec = RotatePosition( Vector( 0, 0, 0 ), QAngle( 0, RandomInt( 25*self.k, 40*self.k ), 0 ), self.start_vec )
		local delta =  math.abs(self.SpawnAngle - math.deg(math.atan2(self.start_vec.x, self.start_vec.y))) 
	until delta > 220 or delta < 140 

	self.start_pos = self.tower_abs + self.start_vec

	local time = (self.parent:GetAbsOrigin() - self.start_pos):Length2D()/self.speed
	self.parent:MoveToPosition( self.start_pos )

	self.stage = 0
	self:StartIntervalThink(time)
	return
end  


end