--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tormentor_custom = class(mod_hidden)
function modifier_tormentor_custom:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()

local base = 3300
local inc = 1.12

for i = 8,dota1x6.current_wave do
	if i >= 10 then 
		inc = 1.09
	end 
	base = base*inc
end

if not IsSoloMode() then
  base = base*tormentor_team_health
end


self.max_shield = base
self.shield = self.max_shield

self:SetHasCustomTransmitterData(true)
self.parent:SetNeverMoveToClearSpace(true)

self.reflect_ability = self.parent:FindAbilityByName("patrol_tormentor_reflect_custom")
self.shield_ability = self.parent:FindAbilityByName("patrol_tormentor_shield_custom")

self.origin = self.parent:GetAbsOrigin()

if not self.reflect_ability or not self.shield_ability then 
	self:Destroy()
	return
end

self.damageTable = {attacker = self.parent, ability = self.reflect_ability, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_REFLECTION}
self.radius = self.reflect_ability:GetSpecialValueFor("radius")
self.damage = self.reflect_ability:GetSpecialValueFor("damage")/100

self.invun_duration = self.shield_ability:GetSpecialValueFor("invun_duration")
self.invun_damage = self.shield_ability:GetSpecialValueFor("invun_damage")
self.shield_regen = self.shield_ability:GetSpecialValueFor("regen")/100
self.field_duration = self.shield_ability:GetSpecialValueFor("field_duration")
self.death_heal = self.shield_ability:GetSpecialValueFor("death_heal")/100
self.damage_reduce = self.shield_ability:GetSpecialValueFor("damage_reduce")/100

self.health_1 = self.shield_ability:GetSpecialValueFor("health_1")
self.health_2 = self.shield_ability:GetSpecialValueFor("health_2")

self.invun_proc =
{
	[1] = {health = self.health_1, proc = false},
	[2] = {health = self.health_2, proc = false},
}

self.shield_effect = "particles/neutral_fx/miniboss_shield.vpcf"
self.reflect_effect = "particles/neutral_fx/miniboss_damage_reflect.vpcf"
self.impact_effect = "particles/neutral_fx/miniboss_damage_impact.vpcf"
self.knock_effect = "particles/tormentor/stun_target.vpcf"

self.side = table.side

if self.side == 1 then
	self.knock_effect = "particles/tormentor/stun_target_dire.vpcf"
	self.shield_effect = "particles/neutral_fx/miniboss_shield_dire.vpcf"
	self.reflect_effect = "particles/neutral_fx/miniboss_damage_reflect_dire.vpcf"
	self.impact_effect = "particles/neutral_fx/miniboss_dire_damage_impact.vpcf"

	self.parent:SetMaterialGroup("1")
end

self.particle = ParticleManager:CreateParticle(self.shield_effect, PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, false, false, -1, true, false)

self.parent:EmitSound("Miniboss.Tormenter.Spawn")
self.parent:StartGesture(ACT_DOTA_SPAWN)

self.interval = 0.1

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_tormentor_custom:OnDestroy()
if not IsServer() then return end

for _,tower in pairs(towers) do
	if tower.map_team and self.parent.patrol_teams[tower.map_team] then
		tower.active_patrol[self.parent] = nil
	end
end

end

function modifier_tormentor_custom:OnIntervalThink()
if not IsServer() then return end

if self.parent.patrol_teams and not self.init then
	self.init = true
	for _,tower in pairs(towers) do
		if tower.map_team and self.parent.patrol_teams[tower.map_team] then
			tower.active_patrol[self.parent] = 2
		end
	end
end

local team_count = 0
for team,tower in pairs(towers) do
	local player_count = 0
	for _,player in pairs(players) do
		if player:GetTeamNumber() == team and (player:IsAlive() or player:IsReincarnating()) and (player:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius then
			player_count = player_count + 1
		end
	end
	if player_count > 0 then
		team_count = team_count + 1
	end
	if self.parent.patrol_teams and self.parent.patrol_teams[tower.map_team] then	
		AddFOWViewer(team, self.origin, self.radius, self.interval, false)
	end
end

if team_count <= 0 then
	if self.shield < self.max_shield then
		local regen = self.max_shield*self.shield_regen*self.interval
		self.shield = math.min(self.max_shield, self.shield + regen)
		self:SendBuffRefreshToClients()
	end
end

if team_count >= 2 then
	self.parent:AddNewModifier(self.parent, self.shield_ability, "modifier_tormentor_custom_damage_reduce", {side = self.side})
elseif self.parent:HasModifier("modifier_tormentor_custom_damage_reduce") then
	self.parent:RemoveModifierByName("modifier_tormentor_custom_damage_reduce")
end

if self.shield <= self.max_shield*self.health_2/100 and not self.parent:HasModifier("modifier_tormentor_custom_field") and not self.parent:HasModifier("modifier_tormentor_custom_field_cd") then
	self.parent:AddNewModifier(self.parent, self.shield_ability, "modifier_tormentor_custom_field", {side = self.side, duration = self.field_duration})
end

if self.parent:HasModifier("modifier_tormentor_custom_field") then
	if not self.teams_inside then
		self.teams_inside = {}
		for _,player in pairs(players) do
			if (player:IsAlive() or player:IsReincarnating()) and (player:GetAbsOrigin() - self.origin):Length2D() <= self.radius then
				self.teams_inside[player:GetTeamNumber()] = true
			end
		end
	end

	local units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.origin, nil, self.radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)
	for _,unit in pairs(units) do
		if unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS and not self.teams_inside[unit:GetTeamNumber()] and not unit:HasModifier("modifier_tormentor_custom_field_knock_cd") then
	    local dir = unit:GetAbsOrigin() - self.origin
	    local point = self.origin + dir:Normalized()*self.radius*1.1

			local pfx = ParticleManager:CreateParticle(self.knock_effect, PATTACH_ABSORIGIN_FOLLOW, self.parent)
			ParticleManager:SetParticleControl(pfx, 0, self.parent:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(pfx, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(pfx)
			unit:EmitSound("Tormentor.Stun_target")

	    unit:InterruptMotionControllers(false)
	    self:ChangePos(unit, point)
	    unit:AddNewModifier(unit, nil, "modifier_tormentor_custom_field_knock_cd", {duration = 0.2})
		end
	end
else
	self.teams_inside = nil
end

if self.parent:GetAbsOrigin() == self.origin then return end
self.parent:SetAbsOrigin(self.origin)
end

function modifier_tormentor_custom:ChangePos(target, point)
if not IsServer() then return end

local duration = 0.2
local distance = (target:GetAbsOrigin() - point):Length2D()
if distance > 400 then
	FindClearSpaceForUnit(target, point, false)
	return
end

local knockbackProperties =
{
  target_x = point.x,
  target_y = point.y,
  distance = distance,
  speed = distance/duration,
  height = 0,
  fix_end = true,
  isStun = true,
  activity = ACT_DOTA_FLAIL,
}
target:AddNewModifier(self.parent, self.shield_ability, "modifier_generic_arc", knockbackProperties )
end 

function modifier_tormentor_custom:DeathReward(attacker)
if not IsServer() then return end

local attacker_table = players[attacker:GetId()]

if not attacker_table then return end

local attacker_id = attacker_table:GetId()
local team = attacker_table:GetTeamNumber()
local heroes = dota1x6:FindPlayers(team, nil, true)
local low_player = -1

if not heroes then return end
if self.ended then return end
self.ended = true

local shard_table = {}
for _,hero in pairs(heroes) do
	if not hero:HasShard() then
		table.insert(shard_table, hero)
	end

	if hero and hero:IsAlive() and (hero:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius then
		hero:GenericParticle("particles/lc_odd_proc_.vpcf")
		hero:GenericHeal( hero:GetMaxHealth()*self.death_heal, self.shield_ability)
	end
end

if #shard_table > 0 then
	low_player = shard_table[1]
	local low_net = players[low_player:GetId()].networth-- PlayerResource:GetNetWorth(low_player:GetId())

	for _,hero in pairs(shard_table) do
		local net = players[hero:GetId()].networth --PlayerResource:GetNetWorth(hero:GetId())
		if net <= low_net then
			low_net = net
			low_player = hero
		end
	end
	if low_player then
		self:GiveItem("item_aghanims_shard", low_player)
	end
else
	local gold = tormentor_gold/#heroes
	for _,player in pairs(heroes) do
		player:ModifyGoldFiltered(gold, true, DOTA_ModifyGold_CreepKill)
		player:SendNumber(0, gold)
	end
end

attacker_table:AddNewModifier(attacker_table, nil, "modifier_patrol_reward_2_respawn", {})
CustomGameEventManager:Send_ServerToAllClients("mini_alert_event",  {hero_1 = attacker_table:GetUnitName(), hero_2 = low_player == -1 and low_player or low_player:GetUnitName(), event_type = "tormentor"})
end


function modifier_tormentor_custom:GiveItem(name, attacker)
if not IsServer() then return end

local item = CreateItem(name, attacker, attacker)

if attacker:GetNumItemsInInventory() < 10 then
  attacker:AddItem(item)
else
  CreateItemOnPositionSync(GetGroundPosition(attacker:GetAbsOrigin(), attacker), item)
end

end

function modifier_tormentor_custom:DamageEvent(params)
if not IsServer() then return end 
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end

local damage = params.original_damage

if damage <= 0 then return end

local attacker = params.attacker

local attacker_table = players[attacker:GetId()]
if attacker_table then
	if towers[attacker:GetTeamNumber()] then 
		dota1x6:ActivatePushReduce(attacker:GetTeamNumber())
	end
end

self.parent:StartGesture(ACT_DOTA_FLINCH)

local count = 1
local reflect_damage = self.damage*damage
if self.parent:HasModifier("modifier_tormentor_custom_invun") then
	count = 3
	reflect_damage = reflect_damage*self.invun_damage
end

for i = 1, count do
	self.parent:GenericParticle(self.impact_effect)
	self.parent:EmitSound("Miniboss.Tormenter.Target")
	local pfx = ParticleManager:CreateParticle(self.reflect_effect, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(pfx, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(pfx, 1, attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", attacker:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(pfx)
end

self.damageTable.damage = reflect_damage
self.damageTable.victim = attacker

attacker:EmitSound("Miniboss.Tormenter.Reflect")
DoDamage(self.damageTable)
end

function modifier_tormentor_custom:CheckState()
return
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true, 
}
end

function modifier_tormentor_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_tormentor_custom:GetOverrideAnimation()
return ACT_DOTA_IDLE
end

function modifier_tormentor_custom:GetModifierIncomingDamageConstant( params )

if IsClient() then 
  if params.report_max then 
      return self.max_shield
  else  
      return self.shield
  end 
end

if not IsServer() then return end
local attacker = params.attacker
self.last_attacker = attacker

if ((attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius or not attacker:IsAlive()) or (self.teams_inside and not self.teams_inside[attacker:GetTeamNumber()]) then 

	self.parent:EmitSound("UI.Immune_attack")
	self.effect_cast = ParticleManager:CreateParticle("particles/items_fx/backdoor_protection.vpcf", PATTACH_ABSORIGIN, self.parent)
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 300, 0, 0) )
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	return -params.damage
end

local damage = params.damage
local damage_k = 1
if self.parent:HasModifier("modifier_tormentor_custom_damage_reduce") then
	damage_k = 1 + self.damage_reduce
end

local block_damage = math.min(damage, self.shield/damage_k)
local real_damage = block_damage*damage_k

if self.parent:HasModifier("modifier_tormentor_custom_invun") then
	block_damage = damage
else
	local invun_index = 0
	for index,data in ipairs(self.invun_proc) do
		if not data.proc then
			invun_index = index
			break
		end
	end
	if self.invun_proc[invun_index] then
		local min_shield = self.invun_proc[invun_index].health*self.max_shield/100
		if self.shield - real_damage < min_shield then
			real_damage = self.shield - min_shield
			block_damage = damage
			self.invun_proc[invun_index].proc = true
			self.parent:AddNewModifier(self.parent, self.shield_ability, "modifier_tormentor_custom_invun", {side = self.side, duration = self.invun_duration})
		end
	end
	self.shield = self.shield - real_damage
	self:SendBuffRefreshToClients()

	if self.shield <= 0 then
	  self:DeathReward(params.attacker)
	end
end

self:DamageEvent(params)

return -block_damage
end

function modifier_tormentor_custom:AddCustomTransmitterData()
return 
{
	shield = self.shield,
	max_shield = self.max_shield
}
end

function modifier_tormentor_custom:HandleCustomTransmitterData(data)
self.shield = data.shield
self.max_shield = data.max_shield
end



modifier_tormentor_custom_field_cd = class(mod_visible)
function modifier_tormentor_custom_field_cd:RemoveOnDeath() return false end
function modifier_tormentor_custom_field_cd:IsDebuff() return true end


modifier_tormentor_custom_field = class(mod_hidden)
function modifier_tormentor_custom_field:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end

self.parent:EmitSound("Tormentor.Field_start1")
self.parent:EmitSound("Tormentor.Field_start2")
self.parent:EmitSound("Tormentor.Field_loop")

self.radius = self.ability:GetSpecialValueFor("radius")
self.cd = self.ability:GetSpecialValueFor("field_cd")
self.center = self.parent:GetAbsOrigin()

self.side = table.side
self.field_effect = "particles/tormentor/tormentor_knock_field.vpcf"
self.wave_effect = "particles/tormentor/stun_wave.vpcf"

if self.side == 1 then
	self.wave_effect = "particles/tormentor/stun_wave_dire.vpcf"
	self.field_effect = "particles/tormentor/tormentor_knock_field_dire.vpcf"
end

self.parent:GenericParticle(self.wave_effect)

self.particle = ParticleManager:CreateParticle(self.field_effect, PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self.center)
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius,1,1))
self:AddParticle(self.particle, false, false, -1, false, false)
end


function modifier_tormentor_custom_field:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("Tormentor.Field_loop")
self.parent:AddNewModifier(self.parent, self.ability, "modifier_tormentor_custom_field_cd", {duration = self.cd})
end

modifier_tormentor_custom_field_knock_cd = class(mod_hidden)



modifier_tormentor_custom_invun = class(mod_hidden)
function modifier_tormentor_custom_invun:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.electro_effect = "particles/tormentor/stun_wave_electro.vpcf"
self.invun_effect = "particles/generic/tormentor_invun_field_radiant.vpcf"

self.side = table.side
if self.side == 1 then
	self.electro_effect = "particles/tormentor/stun_wave_electro_dire.vpcf"
	self.invun_effect = "particles/generic/tormentor_invun_field.vpcf"
end

self.parent:EmitSound("Tormentor.Stun_wave")
self.parent:GenericParticle(self.electro_effect)

self.particle = ParticleManager:CreateParticle(self.invun_effect, PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(300,1,1))
self:AddParticle(self.particle, false, false, -1, false, false)
end


modifier_tormentor_custom_damage_reduce = class(mod_hidden)
function modifier_tormentor_custom_damage_reduce:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.invun_effect = "particles/generic/tormentor_invun_field_radiant.vpcf"

self.side = table.side
if self.side == 1 then
	self.invun_effect = "particles/generic/tormentor_invun_field.vpcf"
end

self.particle = ParticleManager:CreateParticle(self.invun_effect, PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(300,1,1))
self:AddParticle(self.particle, false, false, -1, false, false)
end