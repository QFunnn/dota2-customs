--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tower_incoming_speed", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_incoming_damage", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_incoming_damage_cd", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_incoming_no_heal", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_incoming_no_spells", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_incoming_push_reduce", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_incoming_push_reduce_hero", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_incoming_push_reduce_hero_duo", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_incoming_timer", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_alert_cd", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_mark", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tower_voice_cd", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )


LinkLuaModifier( "modifier_backdoor_knock_aura", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_backdoor_knock_aura_damage", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_backdoor_mute", "modifiers/tower/modifier_tower_incoming", LUA_MODIFIER_MOTION_NONE )




modifier_tower_incoming = class({})

modifier_tower_incoming.skills = 
{
	"ember_spirit_activate_fire_remnant_custom",
	"alchemist_acid_spray_mixing",
	"custom_puck_ethereal_jaunt"
	
}


function modifier_tower_incoming:IsHidden() return true end
function modifier_tower_incoming:IsPurgable() return false end

function modifier_tower_incoming:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.shrine_damage = 10
self.tower_damage = 4

if test and false then
	self.shrine_damage = 100
	self.tower_damage = 49
end

if IsClient() then
	local effect_name = nil
	if self.parent:GetUnitName() == "npc_filler_radiant_resist" then
		effect_name = "particles/radiant_resist.vpcf"
	end
	if self.parent:GetUnitName() == "npc_filler_radiant_stun" then
		effect_name = "particles/radiant_stun.vpcf"
	end
	if self.parent:GetUnitName() == "npc_filler_radiant_plasma" then
		effect_name = "particles/radiant_plasma.vpcf"
	end

	if self.parent:GetUnitName() == "npc_filler_dire_resist" then
		effect_name = "particles/dire_resist.vpcf"
	end
	if self.parent:GetUnitName() == "npc_filler_dire_stun" then
		effect_name = "particles/dire_stun.vpcf"
	end
	if self.parent:GetUnitName() == "npc_filler_dire_plasma" then
		effect_name =  "particles/world_shrine/dire_shrine_ambient.vpcf"
	end

	if effect_name then 
		self.effect = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
		self:AddParticle(self.effect, false, false, -1, false, false  )
	end
end

if not IsServer() then return end

self.bkb_ability = self.parent:AddAbility("custom_bkb_effects")
self.bkb_ability:SetLevel(1)

self.radius = 1200
self.tower = EntIndexToHScript(table.tower)
self.tower_pos = self.tower:GetAbsOrigin()
self.tower_range = self.tower:Script_GetAttackRange() + 100
self.height = GetGroundHeight(self.tower_pos, nil) - 10

self:SetStackCount(0)

if self.tower == self.parent then
	self:SetStackCount(1)
end

self.parent:AddAttackEvent_inc(self, true)
self.parent:AddDamageEvent_inc(self, true)
self.parent:AddDeathEvent(self)

self.leash_duration = self.parent:GetTalentValue("modifier_patrol_reward_fortifier", "duration", true)

self.state = 0
self:StartIntervalThink(0.5)

self.no_push_mods =
{
	"modifier_mars_scepter_damage",
	"modifier_skeleton_king_reincarnation_custom_legendary",
	"modifier_can_not_push",
	"modifier_custom_juggernaut_blade_fury",
	"modifier_invoker_invoke_custom_legendary",
	"modifier_abaddon_borrowed_time_custom",
	"modifier_bristleback_bristleback_custom_legendary_active",
	"modifier_monkey_king_wukongs_command_custom_buff",
	"modifier_muerta_the_calling_custom_tower_damage",
	"modifier_skeleton_king_innate_custom_ghost",
	"modifier_custom_puck_phase_shift",
	"modifier_slark_shadow_dance_custom",
	"item_aeon_disk_custom_proc",
	"modifier_sven_warcry_custom_legendary",
	"modifier_bane_nightmare_custom_legendary",
	"modifier_crystal_maiden_freezing_field_custom",
	"modifier_morphling_replicate_custom",
	"modifier_abaddon_aphotic_shield_custom_immune",
	"modifier_life_stealer_rage_custom",
	"modifier_life_stealer_infest_custom_legendary_creep",
	"modifier_tinker_march_of_the_machines_custom_active",
}

self.creep_names =
{
	["npc_dota_invoker_forged_spirit_custom"] = 0.5,
	["npc_dota_furion_treant_custom"] = 1,
	["npc_dota_lesser_eidolon_custom"] = 1,
	["npc_dota_broodmother_spiderling_custom"] = 1,
}
end 


function modifier_tower_incoming:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end

if not self.tower then return end
if self.tower:HasModifier("modifier_tower_voice_cd") then return end

self.tower:AddNewModifier(self.tower, nil, "modifier_tower_voice_cd", {duration = 6})

if not self.ids then
  self.ids = dota1x6:FindPlayers(self.parent:GetTeamNumber())
end

if self.ids then
	for _,id in pairs(self.ids) do
	  CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "Attack_Base", {sound = "Tower.Attack"})
	end
end

end


function modifier_tower_incoming:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
local target = params.target
local necro_mod = target:FindModifierByName("modifier_item_patrol_necro_creeps")

if target:IsCreep() and self.creep_names[target:GetUnitName()] == nil and not necro_mod then return end

if target:IsHero() then 
	target:AddNewModifier(self.parent, nil, "modifier_generic_vision", {duration = 5})
end

local targets = {}
table.insert(targets, target)

local k = 0.03
if GameRules:GetDOTATime(false, false) < push_timer then 
	k = 0.15
end
if target:IsIllusion() then 
	k = 1
end

if target:IsTalentIllusion() then 
	k = 0
end

if target:IsCreep() and self.creep_names[target:GetUnitName()] then 
	k = self.creep_names[target:GetUnitName()]
end 

if target:IsCreep() and necro_mod then 
	k = necro_mod.damage_inc/100
end 

if target:HasModifier("modifier_arc_warden_tempest_double_custom") then
	k = k * 4
end

if GameRules:GetDOTATime(false, false) < push_timer then
	for _,aoe_target in pairs(self.parent:FindTargets(300, target:GetAbsOrigin())) do
		if aoe_target ~= target and aoe_target:GetUnitName() == "npc_dota_broodmother_spiderling_custom" then
			aoe_target:ForceKill(false)
		end
	end
end

if test then
	print(k)
end

local bonus = target:GetMaxHealth()*k

for _,aoe_target in pairs(targets) do
	DoDamage({ victim = aoe_target, attacker = self.parent, ability = self.ability, damage = bonus, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK})
end

if self.parent:HasModifier("modifier_patrol_reward_2_fortifier_tower") and target:IsHero() then
	target:AddNewModifier(self.parent, nil, "modifier_patrol_reward_2_fortifier_tower_leash", {duration = self.leash_duration})
end

end


function modifier_tower_incoming:OnIntervalThink()
if not IsServer() then return end
if not self.caster then return end
if not self.parent then return end
if not towers[self.parent:GetTeamNumber()] then return end 
if GameRules:GetDOTATime(false, false) < push_timer then return end

if not self.tower then return end
if self.tower:HasModifier("modifier_the_hunt_custom_tower") then return end

local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.tower:GetAbsOrigin() , nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE  + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO, FIND_CLOSEST, false)
local target = nil
for _,enemy in pairs(enemies) do
	if GetGroundHeight(enemy:GetAbsOrigin(), nil) >= self.height and not target and not enemy:HasModifier("modifier_the_hunt_custom_hero") and enemy:IsRealHero() and not enemy:IsTempestDouble() then
		target = enemy
	end
end

if target then 
	if self.tower and not self.tower:HasModifier("modifier_backdoor_knock_aura") then 
		self.tower:AddNewModifier(self.tower, nil, "modifier_backdoor_knock_aura", {target_team = target:GetTeamNumber()})
	end

	if self.state == 0 then 
		self.state = 1
	 	self.parent:AddNewModifier(self.caster, nil, "modifier_tower_incoming_timer", {duration = 2})
	end 
	if self.state == 1 and not self.parent:HasModifier("modifier_tower_incoming_timer") then 
		self.state = 2
	end
else 
	self.state = 0
	if self.parent:HasModifier("modifier_tower_incoming_timer") then 
		self.parent:RemoveModifierByName("modifier_tower_incoming_timer")
	end
end

end



function modifier_tower_incoming:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
 	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
  MODIFIER_PROPERTY_HEALTHBAR_PIPS,
 	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
}
end



function modifier_tower_incoming:DeathEvent(params)
if not IsServer() then return end
if self:GetStackCount() ~= 1 then return end
if self.parent ~= params.unit then return end

local attacker = params.attacker
local mod = self.parent:FindModifierByName("modifier_tower_mark")
if mod then
	attacker = mod:GetCaster()
end

if attacker and players[attacker:GetId()] then 
	HTTP.RegisterBuildingDeath(attacker:GetId(), self.parent)
	dota1x6:TowerKill(attacker, self.parent)
	self.parent.killer = players[attacker:GetId()]
end

dota1x6:CheckTowerDeath(self.parent)
end




function modifier_tower_incoming:GetModifierHealthBarPips()
if self:GetStackCount() == 1 then return end
return 100/self.shrine_damage
end

function modifier_tower_incoming:GetAbsoluteNoDamagePhysical(params)
if not IsServer() then return end
local attacker = params.attacker

if not attacker then return end
if not self.tower then return end

if self:CheckDuel(self.tower) then
	return 1
end

if attacker:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5 or attacker.is_necro_creep then 
	return 1 
end 

end


function modifier_tower_incoming:GetAbsoluteNoDamageMagical(params)
if not IsServer() then return end
local attacker = params.attacker

if not attacker then return end
if not self.tower then return end

if self:CheckDuel(self.tower) then
	return 1
end

if attacker:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5 then 
	return 1 
end 

end


function modifier_tower_incoming:GetAbsoluteNoDamagePure(params)
if not IsServer() then return end

local attacker = params.attacker

if not attacker then return end
if not self.tower then return end

if self:CheckDuel(self.tower) then
	return 1
end


if (self.tower_pos - attacker:GetAbsOrigin()):Length2D() > self.tower_range or GetGroundHeight(attacker:GetAbsOrigin(), nil) < self.height or not attacker:IsAlive() then 
	self:PlayEffect()
	return 1
end

if attacker:IsInvulnerable() or attacker:IsOutOfGame() then 
	self:PlayEffect()
	return 1
end

if self.state ~= 2 and attacker:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5 then 
	self:PlayEffect()
	return 1
end

if not attacker:HasModifier("modifier_tower_incoming_damage") and not attacker.is_necro_creep then 
	return 1
end 
return 0 
end

function modifier_tower_incoming:CheckDuel(tower)

if tower and duel_data[tower.duel_data] and duel_data[tower.duel_data].stage ~= 1 and duel_data[tower.duel_data].finished == 0 then 
	return 1
end

end


function modifier_tower_incoming:PlayEffect(new_target)
if not IsServer() then return end 

local target = self.parent
if new_target then
	target = new_target
end

target:EmitSound("UI.Immune_attack")
self.effect_cast = ParticleManager:CreateParticle("particles/items_fx/backdoor_protection.vpcf", PATTACH_ABSORIGIN, target)
ParticleManager:SetParticleControl( self.effect_cast, 0, target:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 200, 0, 0) )
ParticleManager:ReleaseParticleIndex(self.effect_cast)

end 

function modifier_tower_incoming:CheckState()
local state = {}

if dota1x6:FinalDuel() == true then 
	state[MODIFIER_STATE_INVULNERABLE] = true
	state[MODIFIER_STATE_NO_HEALTH_BAR] = true
end 

if self.parent:HasModifier("modifier_the_hunt_custom_tower") then
	state[MODIFIER_STATE_DISARMED] = true	
end 

return state
end




function modifier_tower_incoming:AttackEvent_inc(params)
if not IsServer() then return end
local target = params.target
local attacker = params.attacker

if target ~= self.parent then return end
local necro_mod = attacker:FindModifierByName("modifier_item_patrol_necro_creeps")

if not params.attacker:IsHero() and not necro_mod then return end
if params.no_attack_cooldown then return end

if not self.tower then return end 

if attacker:IsHero() then
	attacker:AddNewModifier(attacker, self.bkb_ability, "modifier_tower_incoming_speed", {duration = 1.1})
end

if self.tower:HasModifier("modifier_the_hunt_custom_tower") then 
	self:PlayEffect(self.parent)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(attacker:GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#push_target"})
	return
end

if self:CheckDuel(self.tower) then 
	self:PlayEffect(self.parent)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(attacker:GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#push_duel"})
	return
end 

if dota1x6:DuelSoon() then
	self:PlayEffect(self.parent)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(attacker:GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#push_duel_soon"})
	return
end 

if self.parent:HasModifier("modifier_fountain_glyph") then return end

if GameRules:GetDOTATime(false, false) < push_timer then 
	self:PlayEffect(self.parent)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(attacker:GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#push_timer"})
	return
end

if not attacker:IsRealHero() and not necro_mod then return end
if attacker:IsTempestDouble() then return end
if attacker:IsAttackImmune() then return end

for _,mod in pairs(self.no_push_mods) do 
	if attacker:HasModifier(mod) then 
		return
	end 
end 

local nightmare = attacker:FindAbilityByName("bane_nightmare_custom")
if nightmare and nightmare.current_mod ~= nil then
	return
end

local mod = attacker:FindModifierByName("modifier_crystal_maiden_crystal_nova_legendary_aura")
if mod and mod:GetCaster() == attacker then 
	return
end

attacker:AddNewModifier(attacker, nil, "modifier_tower_incoming_damage", {})

local damage = self.parent:GetMaxHealth()*self.shrine_damage/100

if self.parent:GetUnitName() == "npc_towerradiant" or self.parent:GetUnitName() == "npc_towerdire" then 
	damage = self.parent:GetMaxHealth()*self.tower_damage/100
end

if necro_mod then
	damage = self.parent:GetMaxHealth()*necro_mod.damage_out/100
end

local k = 1

local shrine_mod = self.parent:FindModifierByName("modifier_filler_armor")
local razor_enemy = self.parent:FindModifierByName("modifier_razor_tower_custom")
local push_mod = self.tower:FindModifierByName("modifier_tower_incoming_push_reduce")

if razor_enemy and razor_enemy.damage then 
	k = k + razor_enemy.damage/100
end
	
if push_mod and not necro_mod then 
	local reason = 1
	local attacker_allow = self.tower:FindModifierByNameAndCaster("modifier_tower_incoming_push_reduce_hero", attacker)

	if push_mod.killed_index and push_mod.killed_index ~= -1 then
		reason = 2
	end

	if not attacker_allow then
		if not attacker:HasModifier("modifier_tower_alert_cd") then 
			attacker:AddNewModifier(attacker, nil, "modifier_tower_alert_cd", {duration = 20})
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(attacker:GetPlayerOwnerID()), 'BackdoorAlert',  {reason = reason})
		end 
		local ids = dota1x6:FindPlayers(self.parent:GetTeamNumber())
		if ids then
			for _,id in pairs(ids) do
				local player = players[id]
				if player and player:IsAlive() then
					AddFOWViewer(attacker:GetTeamNumber(), player:GetAbsOrigin(), 800, 3, false)
				end
			end
		end
		k = k - 0.7
	end
end

if not IsSoloMode() and not necro_mod then
	local attacker_allow = self.tower:FindModifierByNameAndCaster("modifier_tower_incoming_push_reduce_hero_duo", attacker)
	if not attacker_allow then
		if not attacker:HasModifier("modifier_tower_alert_cd") then
			attacker:AddNewModifier(attacker, nil, "modifier_tower_alert_cd", {duration = 20})
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(attacker:GetPlayerOwnerID()), 'BackdoorAlert',  {reason = 3})
		end
		k = k - 0.7
	end
end

if shrine_mod and not necro_mod then 
	k =  k - 0.2*shrine_mod:GetStackCount()
end

local fortifier = self.parent:FindModifierByName("modifier_patrol_reward_2_fortifier_effect")
if attacker:IsRealHero() and self.state == 2 and fortifier and not attacker:HasModifier("modifier_tower_incoming_damage_cd") then
	k = 0
	fortifier:DealDamage()
end

if k <= 0 and not fortifier then 
	k = 0
	self:PlayEffect(self.parent)
end

if test then
	print(k, damage)
end

damage = damage*k

local ids = dota1x6:FindPlayers(attacker:GetTeamNumber())
if ids then
	damage = damage/#ids
end

if not attacker:HasModifier("modifier_tower_incoming_damage_cd") or necro_mod then 

	local damageTable = 
	{
		victim = self.parent,
		attacker = attacker,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = nil,
		damage_flags = DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	}

	local real_damage = DoDamage(damageTable)

	if real_damage > 0 and self.parent:GetUnitName() ~= "npc_towerradiant" and self.parent:GetUnitName() ~= "npc_towerdire" then 
		start_quest:CheckQuest({id = attacker:GetId(), quest_name = "Quest_10"})
	end

	if players[attacker:GetId()] then
		players[attacker:GetId()].tower_damage = players[attacker:GetId()].tower_damage + real_damage

		if self.parent:GetHealth() <= 0 then
			HTTP.RegisterBuildingDeath(attacker:GetId(), self.parent)
		elseif self:GetStackCount() == 1 then
			self.parent:RemoveModifierByName("modifier_tower_mark")
		  self.parent:AddNewModifier(attacker, nil, "modifier_tower_mark", {duration = 10})
		end
	end

	if attacker:IsRealHero() and attacker:GetQuest() == "General.Quest_14" then 
		attacker:UpdateQuest(damage)
	end

	self.parent:AddNewModifier(self.parent, nil, "modifier_tower_incoming_no_heal", {duration = 3})

	if towers[attacker:GetTeamNumber()] then 
		local ids = dota1x6:FindPlayers(self.parent:GetTeamNumber())
		if ids then
			for _,id in pairs(ids) do
				dota1x6:ActivatePushReduce(attacker:GetTeamNumber(), id)
			end
		end
	end

	for _,name in pairs(self.skills) do 	
		local ability = attacker:FindAbilityByName(name)

		if ability and ability:GetSpecialValueFor("tower_attack_cd") then 
			local cd = ability:GetCooldownTimeRemaining()

			if cd < ability:GetSpecialValueFor("tower_attack_cd") then 
				ability:StartCooldown(ability:GetSpecialValueFor("tower_attack_cd"))
			end
		end

	end

	if not necro_mod then
		attacker:AddNewModifier(attacker, nil, "modifier_tower_incoming_damage_cd", {duration = 0.5})
	end
end

attacker:RemoveModifierByName("modifier_tower_incoming_damage")
end


modifier_tower_incoming_damage = class({})
function modifier_tower_incoming_damage:IsHidden() return true end
function modifier_tower_incoming_damage:IsPurgable() return false end


modifier_tower_incoming_speed = class({})
function modifier_tower_incoming_speed:IsHidden() return false end
function modifier_tower_incoming_speed:IsDebuff() return true end
function modifier_tower_incoming_speed:IsPurgable() return false end
function modifier_tower_incoming_speed:GetTexture() return "backdoor_protection" end
function modifier_tower_incoming_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_FIXED_ATTACK_RATE,
	MODIFIER_PROPERTY_TOOLTIP,
	MODIFIER_PROPERTY_TOOLTIP2,
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_tower_incoming_speed:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.rate = 0.75
self.heal_reduce = -50

self.parent:AddAttackRecordEvent_out(self, true)
end

function modifier_tower_incoming_speed:AttackRecordEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if params.target:IsBuilding() then return end

self:Destroy()
end

function modifier_tower_incoming_speed:GetModifierFixedAttackRate()
return self.rate
end

function modifier_tower_incoming_speed:OnTooltip()
return 10
end

function modifier_tower_incoming_speed:OnTooltip2()
return 4
end

function modifier_tower_incoming_speed:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_tower_incoming_speed:GetModifierHealChange()
return self.heal_reduce
end

function modifier_tower_incoming_speed:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_tower_incoming_speed:CheckState()
return
{
	[MODIFIER_STATE_PASSIVES_DISABLED] = true,
}
end



function modifier_tower_incoming_speed:GetEffectName() return "particles/generic_gameplay/generic_break.vpcf" end
function modifier_tower_incoming_speed:ShouldUseOverheadOffset() return true end
function modifier_tower_incoming_speed:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end



modifier_tower_incoming_damage_cd = class({})
function modifier_tower_incoming_damage_cd:IsHidden() return true end
function modifier_tower_incoming_damage_cd:IsPurgable() return false end


modifier_tower_incoming_no_heal = class({})
function modifier_tower_incoming_no_heal:IsHidden() return true end
function modifier_tower_incoming_no_heal:IsPurgable() return false end


modifier_tower_incoming_no_spells = class({})
function modifier_tower_incoming_no_spells:IsHidden() return false end
function modifier_tower_incoming_no_spells:IsPurgable() return false end
function modifier_tower_incoming_no_spells:OnCreated(table)
if not IsServer() then return end

for _,name in pairs(self.skills) do 
	local ability = self:GetParent():FindAbilityByName(name)
	if ability then 
		local cd = ability:GetCooldownTimeRemaining()
		if cd < self:GetRemainingTime() then 
			ability:StartCooldown(self:GetRemainingTime())
		end
	end
end

end

function modifier_tower_incoming_no_spells:OnRefresh(table)
self:OnCreated()
end


modifier_tower_incoming_push_reduce = class({})
function modifier_tower_incoming_push_reduce:IsHidden() return true end
function modifier_tower_incoming_push_reduce:IsPurgable() return false end
function modifier_tower_incoming_push_reduce:GetTexture() return "shrine_aura" end
function modifier_tower_incoming_push_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_tower_incoming_push_reduce:OnTooltip()
return -70
end



function modifier_tower_incoming_push_reduce:OnCreated(table)
if not  IsServer() then return end 
self.parent = self:GetParent()

self.killed_index = table.killed_index

if self.killed_index and self.killed_index ~= -1 then
	self.killed_unit = EntIndexToHScript(self.killed_index)
end

self.effects = {}

self:OnIntervalThink()
self:StartIntervalThink(0.2)
end 


function modifier_tower_incoming_push_reduce:OnIntervalThink()
if not IsServer() then return end

for id,player in pairs(players) do
	local mod = self.parent:FindModifierByNameAndCaster("modifier_tower_incoming_push_reduce_hero", player)
	if mod and self.effects[id] then
		for _,effect in pairs(self.effects[id]) do
			ParticleManager:Delete(effect, 2)
		end
		self.effects[id] = nil
	end

	if not mod and not self.effects[id] then
		self.effects[id] = {}
		local buildings = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin() , nil, 1500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
		for _,building in pairs(buildings) do
			local count = #self.effects[id] + 1
			self.effects[id][count] = ParticleManager:CreateParticleForPlayer("particles/items2_fx/vindicators_axe_armor.vpcf", PATTACH_ABSORIGIN_FOLLOW, building, PlayerResource:GetPlayer(id))
			self:AddParticle( self.effects[id][count], false, false, -1, false, false  )
		end
	end
end

if self.killed_unit and not self.killed_unit:IsNull() then
	if self.killed_unit:IsAlive() then
		self:Destroy()
	else
		self:SetDuration(9999, true)
	end
end

end




modifier_tower_incoming_push_reduce_hero = class({})
function modifier_tower_incoming_push_reduce_hero:IsHidden() return true end
function modifier_tower_incoming_push_reduce_hero:IsPurgable() return false end
function modifier_tower_incoming_push_reduce_hero:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_tower_incoming_push_reduce_hero:OnCreated(table)
if not IsServer() then return end
self.caster = self:GetCaster()

self.killed_index = table.killed_index

if self.killed_index and self.killed_index ~= -1 then
	self.killed_unit = EntIndexToHScript(self.killed_index)
	self:OnIntervalThink()
	self:StartIntervalThink(0.2)
end

end


function modifier_tower_incoming_push_reduce_hero:OnIntervalThink()
if not IsServer() then return end

if self.killed_unit and not self.killed_unit:IsNull() then
	if self.killed_unit:IsAlive() then
		self:Destroy()
	else
		self:SetDuration(9999, true)
	end
end

end


modifier_tower_incoming_push_reduce_hero_duo = class(mod_hidden)
function modifier_tower_incoming_push_reduce_hero_duo:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_tower_incoming_push_reduce_hero_duo:OnCreated(table)
if not IsServer() then return end

self.caster = self:GetCaster()
self.parent = self:GetParent()

self.killed_index = table.killed_index

if self.killed_index and self.killed_index ~= -1 then
	self.killed_unit = EntIndexToHScript(self.killed_index)
	self:OnIntervalThink()
	self:StartIntervalThink(0.2)
end

local buildings = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin() , nil, 1500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
for _,building in pairs(buildings) do
	local effect = ParticleManager:CreateParticleForPlayer("particles/generic/duo_backdoor.vpcf", PATTACH_ABSORIGIN_FOLLOW, building, PlayerResource:GetPlayer(self.caster:GetId()))
	self:AddParticle( effect, false, false, -1, false, false  )
end

end


function modifier_tower_incoming_push_reduce_hero_duo:OnIntervalThink()
if not IsServer() then return end
if not IsValid(self.killed_unit) then return end

if self.killed_unit:IsAlive() then
	if not self.linger then
		self.linger = true
		self:SetDuration(5, true)
	end
else
	self.linger = false
	self:SetDuration(9999, true)
end

end


modifier_tower_incoming_timer = class({})
function modifier_tower_incoming_timer:IsHidden() return true end
function modifier_tower_incoming_timer:IsPurgable() return false end

function modifier_tower_incoming_timer:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()

local mod = self.parent:FindModifierByName("modifier_patrol_reward_2_fortifier_effect")
if mod then
	mod:ClearParticle()
end

self.particle_cast = "particles/huskar_timer.vpcf"
if towers[self.parent:GetTeamNumber()] and towers[self.parent:GetTeamNumber()]:GetUnitName() == "npc_towerdire" then 
	self.particle_cast =  "particles/lina_timer.vpcf"
end

self.t = -1
self.timer = 2*2 
self:StartIntervalThink(0.5)
self:OnIntervalThink()
end

function modifier_tower_incoming_timer:OnDestroy()
if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_patrol_reward_2_fortifier_effect")
if mod then
	mod:OnStackCountChanged()
end

end

function modifier_tower_incoming_timer:OnIntervalThink()
if not IsServer() then return end
self.t = self.t + 1

local caster = self:GetParent()

local number = (self.timer-self.t)/2 
local int = 0
int = number

if number % 1 ~= 0 then int = number - 0.5  end

local digits = math.floor(math.log10(number)) + 2

local decimal = number % 1

if decimal == 0.5 then
  decimal = 8
else 
  decimal = 1
end

local particle = ParticleManager:CreateParticle(self.particle_cast, PATTACH_OVERHEAD_FOLLOW, caster)
ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)
end




modifier_tower_alert_cd = class({})
function modifier_tower_alert_cd:IsHidden() return true end
function modifier_tower_alert_cd:IsPurgable() return false end
function modifier_tower_alert_cd:RemoveOnDeath() return false end





modifier_backdoor_knock_aura = class({})
function modifier_backdoor_knock_aura:IsHidden() return true end
function modifier_backdoor_knock_aura:IsPurgable() return false end
function modifier_backdoor_knock_aura:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:EmitSound("UI.Tower_wall")

self.target_team = table.target_team

self.center = self.parent:GetAbsOrigin()
self.heroes = dota1x6:FindPlayers(self.target_team, false, true)

self.ending = false
self.death_ending = false

self.interval = 0.1
self.radius = 1200
self.height = GetGroundHeight(self.parent:GetAbsOrigin(), nil) - 10

local effect = "particles/generic/duel_wall.vpcf"
if teleports[self.parent:GetTeamNumber()] then
	if IsDire(teleports[self.parent:GetTeamNumber()]:GetName()) then
		effect = "particles/generic/duel_wall_dire.vpcf"
	end
end

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

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_backdoor_knock_aura:IsAura() return true end
function modifier_backdoor_knock_aura:GetAuraDuration() return 0 end
function modifier_backdoor_knock_aura:GetAuraRadius() return self.radius end
function modifier_backdoor_knock_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_BOTH end
function modifier_backdoor_knock_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_backdoor_knock_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_backdoor_knock_aura:GetModifierAura() return "modifier_backdoor_knock_aura_damage" end

function modifier_backdoor_knock_aura:GetAuraEntityReject(hEntity)
return hEntity:GetTeamNumber() ~= self.target_team and hEntity:GetTeamNumber() ~= self.parent:GetTeamNumber() and GetGroundHeight(hEntity:GetAbsOrigin(), nil) >= self.height
end 	


function modifier_backdoor_knock_aura:OnIntervalThink()
if not IsServer() then return end

local all_dead = true
local allow = false

for _,hero in pairs(self.heroes) do
	if hero and not hero:IsNull() and not hero:HasModifier("modifier_the_hunt_custom_hero") then
		local dist = (hero:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D()

		if hero:IsAlive() or hero:IsReincarnating() then
			all_dead = false
			if dist <= self.radius then
				allow = true
			end
		end
	end
end

if all_dead then
	if not self.death_ending then
		self.ending = true
		self.death_ending = true
		self:SetDuration(15, true)
	end
else
	self.death_ending = false
end

if not allow then
	if self.ending == false then
		self.ending = true
		self:SetDuration(3, true)
	end
else
	self.ending = false
	self:SetDuration(-1, true)
end

local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.center, nil, 1500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE  + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)

for _,unit in pairs(enemies) do 

	--[[
	if unit:IsHero() and unit:GetTeamNumber() ~= self.target_team and unit:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5  then 
		unit:AddNewModifier(unit, nil, "modifier_backdoor_mute", {duration = 0.2})
	end]] 
                 
	if unit:GetTeamNumber() ~= self.target_team 
		and unit:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5
		and (unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius 
		and GetGroundHeight(unit:GetAbsOrigin(), nil) >= (self.height - 20)
		and not unit:IsCourier() 
		and unit:GetUnitName() ~= "npc_dota_donate_item_illusion" 
		and not unit:HasModifier("modifier_unselect") 
		and not unit:HasModifier("modifier_orb_icon") 
		and not unit:HasModifier("modifier_mars_arena_of_blood_custom_legendary")
		and not unit:HasModifier("modifier_custom_terrorblade_reflection_unit")
		and not unit:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") 
		and not unit:HasModifier("modifier_mars_arena_of_blood_custom_soldier") then 

		unit:WallKnock(self.center, self.radius, (self.height - 20), false, 150)
	end
end


end


modifier_backdoor_knock_aura_damage = class({})
function modifier_backdoor_knock_aura_damage:IsHidden() return true end
function modifier_backdoor_knock_aura_damage:IsPurgable() return false end
function modifier_backdoor_knock_aura_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
  MODIFIER_PROPERTY_ABSORB_SPELL
}
end 


function modifier_backdoor_knock_aura_damage:OnCreated()
if not IsServer() then return end 
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.parent.field_invun_mod = self

local mod = self.caster:FindModifierByName("modifier_backdoor_knock_aura")
self.radius = 0
self.target_team = -1

if mod then
	if mod.radius then
		self.radius = mod.radius
	end
	if mod.target_team then
		self.target_team = mod.target_team
	end
end

self.teams = {}
self.teams[self.target_team] = true
self.teams[self.caster:GetTeamNumber()] = true
self.teams[DOTA_TEAM_CUSTOM_5] = true
end 

function modifier_backdoor_knock_aura_damage:OnDestroy()
if not IsServer() then return end

if self.parent.field_invun_mod == self then
	self.parent.field_invun_mod = nil
end

end

function modifier_backdoor_knock_aura_damage:NoDamage(attacker)
if not IsServer() then return end 
if not attacker then return end
if self.teams[attacker:GetTeamNumber()] then return end
return 1
end 


function modifier_backdoor_knock_aura_damage:GetAbsorbSpell(params)
if not IsServer() then return end
if self.parent:HasModifier("modifier_antimage_counterspell_custom_active") then return 0 end
if self.parent:IsInvulnerable() then return end
if not params.ability:GetCaster() then return end

local caster = params.ability:GetCaster():CheckOwner()

if caster:IsNull() then return end

if self:NoDamage(caster) == 1 then 
	local particle = ParticleManager:CreateParticle("particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)
	self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
	return 1
end
return 0
end


function modifier_backdoor_knock_aura_damage:GetAbsoluteNoDamagePure(params)
if not IsServer() then return end
return self:NoDamage(params.attacker)
end

function modifier_backdoor_knock_aura_damage:GetAbsoluteNoDamagePhysical(params)
if not IsServer() then return end
return self:NoDamage(params.attacker)
end

function modifier_backdoor_knock_aura_damage:GetAbsoluteNoDamageMagical(params)
if not IsServer() then return end
return self:NoDamage(params.attacker)
end



modifier_backdoor_mute = class({})
function modifier_backdoor_mute:IsHidden() return true end
function modifier_backdoor_mute:IsPurgable() return false end
function modifier_backdoor_mute:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_MUTED] = true,
	[MODIFIER_STATE_SILENCED] = true
}

end
function modifier_backdoor_mute:GetEffectName() 
return "particles/units/heroes/hero_demonartist/demonartist_engulf_disarm/items2_fx/heavens_halberd.vpcf"
end
function modifier_backdoor_mute:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end







modifier_tower_mark = class({})
function modifier_tower_mark:IsHidden() return false end
function modifier_tower_mark:IsPurgable() return false end
function modifier_tower_mark:GetTexture() return self:GetCaster():GetUnitName() end




modifier_tower_voice_cd = class({})
function modifier_tower_voice_cd:IsHidden() return true end
function modifier_tower_voice_cd:IsPurgable() return false end
