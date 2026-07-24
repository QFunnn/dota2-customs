--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_towerresist_aura", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_towerresist", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_tower_stun", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tower_stun_thinker", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tower_stun_cd", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tower_stun_search", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_tower_plasma", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tower_plasma_cd", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tower_plasma_search", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tower_plasma_slow", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_tower_plasma_heal_reduce", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_tower_armor_aura", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_tower_truesight", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_tower_shrine_damaga_reduction", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_shrine_tower_search", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_filler_armor", "abilities/tower_abilities.lua", LUA_MODIFIER_MOTION_NONE )

 

tower_aura_regen = class({})

function tower_aura_regen:GetIntrinsicModifierName() 
return "modifier_towerresist" 
end

function tower_aura_regen:GetCastRange(vLocation, hTarget) 
return self:GetCaster():Script_GetAttackRange() 
end 

modifier_towerresist = class({})

function modifier_towerresist:IsHidden() return true end
function modifier_towerresist:IsPurgable() return false end

function modifier_towerresist:OnCreated()
self.parent = self:GetParent()

if not IsServer() then return end

self.radius = self.parent:Script_GetAttackRange() + 50
self.ability = self:GetAbility()

self.spell_radius = self.ability:GetSpecialValueFor("spell_radius")
self.vision_radius = self.ability:GetSpecialValueFor("vision_radius")
self.interval = 0.2


self:StartIntervalThink(self.interval)
end



function modifier_towerresist:OnIntervalThink()
if not IsServer() then return end
if GameRules:State_Get() <= DOTA_GAMERULES_STATE_PRE_GAME then return end
if not self.parent:IsAlive() then return end

if self.parent:HasModifier("modifier_tower_aura") then 
  self.parent:RemoveModifierByName("modifier_tower_aura")
end

local stun_search = self.parent:FindModifierByName("modifier_tower_stun_search")
local plasma_search = self.parent:FindModifierByName("modifier_tower_plasma_search")

if (stun_search or plasma_search) and not self.parent:HasModifier("modifier_razor_tower_custom") and not self.parent:HasModifier("modifier_the_hunt_custom_tower")
	and not self.parent:HasModifier("modifier_tower_no_owner") then 

	local units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.spell_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_CLOSEST, false)

	if #units > 0 then
		local unit = units[1]
		if stun_search then
			stun_search:ProcEffect(unit)
		end
		if plasma_search then
			plasma_search:ProcEffect()
		end
	end
end


if GameRules:GetDOTATime(false, false) < push_timer then return end

local team_register = {}

for _,player in pairs(players) do
	local team = player:GetTeamNumber()
	local dist = (player:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D()  

	if player:IsAlive() and team ~= self.parent:GetTeamNumber() and not team_register[team] and dist <= self.vision_radius then
		team_register[team] = true
		AddFOWViewer(team, self.parent:GetAbsOrigin(), self.vision_radius, self.interval + 0.1, false)
	end
end

end


function modifier_towerresist:IsAura() return self.parent and not self.parent:IsNull() and not self.parent:HasModifier("modifier_razor_tower_custom") end
function modifier_towerresist:GetAuraDuration() return 3 end
function modifier_towerresist:GetAuraRadius() return self.radius end
function modifier_towerresist:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_towerresist:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING end
function modifier_towerresist:GetModifierAura() return "modifier_towerresist_aura" end
function modifier_towerresist:GetAuraEntityReject(hEntity)
return hEntity:GetUnitName() == "npc_teleport"
end


function modifier_towerresist:CheckState()
return
{
	[MODIFIER_STATE_CANNOT_MISS] = true
}
end





modifier_towerresist_aura = class({})
function modifier_towerresist_aura:IsHidden() return self:GetStackCount() > 0 or self:GetParent():IsBuilding() end
function modifier_towerresist_aura:IsPurgable() return false end
function modifier_towerresist_aura:CheckState()
if GameRules:State_Get() ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then return end
if not PlayerResource then end
if not self.parent or self.parent:IsNull() then return end  
if not self.parent:IsHero() then return end
local state = PlayerResource:GetConnectionState(self.parent:GetPlayerOwnerID())

if state ~= DOTA_CONNECTION_STATE_DISCONNECTED and state ~= DOTA_CONNECTION_STATE_ABANDONED then return end
if self.parent:HasModifier("modifier_death") then return end	
return
{
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_STUNNED] = true
}
end

function modifier_towerresist_aura:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.mana_regen = self.ability:GetSpecialValueFor("mana_regen")
self.health_regen = self.ability:GetSpecialValueFor("health_regen")

self.interval = self.ability:GetSpecialValueFor("damage_interval")

self.tower_heal = 0
if self.parent:IsBuilding() then
	self.tower_heal = self.ability:GetSpecialValueFor("shrine_heal")
	if self.parent == self.caster then
		self.tower_heal = self.ability:GetSpecialValueFor("tower_heal")
	end
else
	self.parent:AddDamageEvent_inc(self, true)
end

self:SetStackCount(0)
if not IsServer() then return end
local player_id = self.parent:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_regeneration")
self.default_effect = nil
if custom_effect_data then
    self.default_effect = custom_effect_data[1]
end

self:UpdateEffect()
end

function modifier_towerresist_aura:UpdateEffect()
if not IsServer() then return end
if not self.default_effect then return end

if self:GetStackCount() == 0 and not self.effect then
	self.effect = self.parent:GenericParticle(self.default_effect, self)
end

if self:GetStackCount() == 1 and self.effect then
	ParticleManager:DestroyParticle(self.effect, false)
	ParticleManager:ReleaseParticleIndex(self.effect)
	self.effect = nil
end

end

function modifier_towerresist_aura:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,	
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
}
end 

function modifier_towerresist_aura:GetModifierConstantHealthRegen()
if self.parent:HasModifier("modifier_tower_incoming_no_heal") then return end
return self.tower_heal
end

function modifier_towerresist_aura:GetModifierHealthRegenPercentage() 
if self.parent:IsBuilding() then return end
if self:GetStackCount() > 0 then return end
return self.health_regen 
end

function modifier_towerresist_aura:GetModifierTotalPercentageManaRegen() 
if self.parent:IsBuilding() then return end
if self:GetStackCount() > 0 then return end
return self.mana_regen 
end

function modifier_towerresist_aura:OnIntervalThink()
if not IsServer() then return end
self:SetStackCount(0)
self:StartIntervalThink(-1)

self:UpdateEffect()
end


function modifier_towerresist_aura:DamageEvent_inc(params)
if not IsServer() then return end

local unit = params.unit
local attacker = params.attacker

if unit ~= self.parent then return end
if unit:GetTeamNumber() == attacker:GetTeamNumber() then return end
if (attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 900 then return end

self:SetStackCount(1)
self:UpdateEffect()
self:StartIntervalThink(self.interval)
end





tower_truesight = class({})

function tower_truesight:GetIntrinsicModifierName() 
return "modifier_tower_truesight" 
end


modifier_tower_truesight = class({})
function modifier_tower_truesight:IsHidden() return true end
function modifier_tower_truesight:IsPurgable() return false end
function modifier_tower_truesight:RemoveOnDeath() return false end
function modifier_tower_truesight:GetAuraRadius() return 1200 end
function modifier_tower_truesight:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_tower_truesight:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_tower_truesight:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_tower_truesight:GetModifierAura() return "modifier_truesight" end
function modifier_tower_truesight:IsAura() return true end





tower_stun = class({})

function tower_stun:GetIntrinsicModifierName() 
return "modifier_tower_stun_search" 
end


modifier_tower_stun_search = class({})
function modifier_tower_stun_search:IsHidden() return true end
function modifier_tower_stun_search:OnCreated(table)
if not IsServer() then return end

self.ability = self:GetAbility()
self.parent = self:GetParent()

self.cd = self.ability:GetSpecialValueFor("cd")
self.delay = self.ability:GetSpecialValueFor("delay")
end


function modifier_tower_stun_search:ProcEffect(target)
if not IsServer() then return end
if self.parent:HasModifier("modifier_tower_stun_cd") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_tower_stun_cd", {duration = self.cd})
CreateModifierThinker(self.parent, self.ability, "modifier_tower_stun_thinker", {duration = self.delay}, target:GetAbsOrigin(), self.parent:GetTeamNumber(), false)
end




modifier_tower_stun_thinker = class({})
function modifier_tower_stun_thinker:IsHidden() return true end
function modifier_tower_stun_thinker:IsPurgable() return false end
function modifier_tower_stun_thinker:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("radius")
self.damage = self.ability:GetSpecialValueFor("damage")/100

self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self:GetRemainingTime(), 0, 0 ) )
self:AddParticle( self.effect_cast, false, false, -1, false, false  )
end

function modifier_tower_stun_thinker:OnDestroy(table)
if not IsServer() then return end
if not self.caster or self.caster:IsNull() or not self.caster:IsAlive() then return end

self.parent:EmitSound("UI.Ability_frost")
local seed_particle = ParticleManager:CreateParticle("particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(seed_particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(seed_particle, 1, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(seed_particle, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(seed_particle)

local enemy_for_ability = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius , DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_CLOSEST, false)
local damage_table = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

for _,target in pairs(enemy_for_ability) do
	damage_table.damage = self.damage*target:GetMaxHealth()
	damage_table.victim = target

	local real_damage = DoDamage(damage_table)
	SendOverheadEventMessage(target, 4, target, real_damage, nil)
end

end



modifier_tower_stun_cd = class({})
function modifier_tower_stun_cd:IsHidden() return false end
function modifier_tower_stun_cd:IsPurgable() return false end




tower_plasma = class({})

function tower_plasma:GetIntrinsicModifierName() 
return "modifier_tower_plasma_search" 
end

function tower_plasma:GetAbilityTextureName()
if self:GetCaster():GetUnitName() == "npc_towerdire" then
  return "dire_plasma"
end 
return "razor_plasma_field"
end

modifier_tower_plasma_search = class({})
function modifier_tower_plasma_search:IsHidden() return true end
function modifier_tower_plasma_search:IsPurgable() return false end
function modifier_tower_plasma_search:OnCreated(table)
if not IsServer() then return end
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.cd = self.ability:GetSpecialValueFor("cd")
self.duration = self.ability:GetSpecialValueFor("radius")/self.ability:GetSpecialValueFor("speed")
end

function modifier_tower_plasma_search:ProcEffect()
if not IsServer() then return end
if self.parent:HasModifier("modifier_tower_plasma_cd") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_tower_plasma_cd", {duration = self.cd})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_tower_plasma", {duration = self.duration})
end




modifier_tower_plasma = class({})
function modifier_tower_plasma:IsHidden() return true end
function modifier_tower_plasma:IsPurchasable() return false end

function modifier_tower_plasma:OnCreated(table)
if not IsServer() then return end
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.end_radius = self:GetAbility():GetSpecialValueFor( "radius" )
self.speed = self:GetAbility():GetSpecialValueFor( "speed" )

self.duration = self.ability:GetSpecialValueFor( "duration" )
self.duration_healing = self.ability:GetSpecialValueFor( "duration_healing" )

local particle_cast = "particles/units/heroes/hero_razor/razor_plasmafield.vpcf"
if self.parent:GetUnitName() == "npc_towerdire" then 
	particle_cast =  "particles/dire_plasma.vpcf"
end

self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.speed, self.end_radius, 1 ) )
self:AddParticle( self.effect_cast, false, false, -1, false, false  )

self.parent:EmitSound( "UI.Ability_Razor" )

self.targets = {}
self.width = 100

self:OnIntervalThink()
self:StartIntervalThink( 0.03 )
end


function modifier_tower_plasma:OnIntervalThink()
if not IsServer() then return end
if not self.ability or self.ability:IsNull() then 
	self:Destroy()
	return
end

local radius = self.speed * self:GetElapsedTime()

if radius>self.end_radius or not self.parent:IsAlive() then
	self:Destroy()
	return
end

local targets = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
for _,target in pairs(targets) do

	if not self.targets[target] and (target:GetOrigin()-self.parent:GetOrigin()):Length2D()>(radius-self.width) then

		self.targets[target] = true

		if (target:IsIllusion() and not target:IsTalentIllusion()) then 
			target:ForceKill(false)
		end

		target:AddNewModifier(self.parent, self.ability, "modifier_tower_plasma_slow", {duration = self.duration*(1 - target:GetStatusResistance())})
		target:AddNewModifier(self.parent, self.ability, "modifier_tower_plasma_heal_reduce", {duration = self.duration_healing})
		target:EmitSound( "UI.Ability_Razor_hit" )
	end
end

end


modifier_tower_plasma_slow = class({})
function modifier_tower_plasma_slow:IsHidden() return true end
function modifier_tower_plasma_slow:IsPurgable() return true end
function modifier_tower_plasma_slow:OnCreated(table)
self.slow =  -1*self:GetAbility():GetSpecialValueFor( "slow" )
end

function modifier_tower_plasma_slow:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_tower_plasma_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end



modifier_tower_plasma_heal_reduce = class({})
function modifier_tower_plasma_heal_reduce:IsHidden() return false end
function modifier_tower_plasma_heal_reduce:IsPurgable() return false end
function modifier_tower_plasma_heal_reduce:OnCreated(table)
self.heal = self:GetAbility():GetSpecialValueFor("heal")*-1
end

function modifier_tower_plasma_heal_reduce:DeclareFunctions()
return
{
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end

function modifier_tower_plasma_heal_reduce:GetModifierLifestealRegenAmplify_Percentage() return self.heal end
function modifier_tower_plasma_heal_reduce:GetModifierHealChange() return self.heal end
function modifier_tower_plasma_heal_reduce:GetModifierHPRegenAmplify_Percentage() return self.heal end
function modifier_tower_plasma_heal_reduce:GetEffectName() return "particles/items4_fx/spirit_vessel_damage.vpcf" end
 



modifier_tower_plasma_cd = class({})
function modifier_tower_plasma_cd:IsHidden() return false end
function modifier_tower_plasma_cd:IsPurgable() return false end






tower_aura_resist = class({})

function tower_aura_resist:GetIntrinsicModifierName()
return "modifier_tower_armor_aura" 
end

modifier_tower_armor_aura = class({})
function modifier_tower_armor_aura:IsHidden() return false end
function modifier_tower_armor_aura:IsPurgable() return false end
function modifier_tower_armor_aura:OnCreated(table)
if not IsServer() then return end
self.respawn = self:GetAbility():GetSpecialValueFor("respawn")/100
end





tower_resist_filler = class({})
function tower_resist_filler:GetIntrinsicModifierName() 
return "modifier_shrine_tower_search" 
end


tower_plasma_filler = class({})
function tower_plasma_filler:GetAbilityTextureName()
if self:GetCaster():GetUnitName() == "npc_filler_dire_plasma" then
  return "dire_plasma"
end 
return "razor_plasma_field"
end

function tower_plasma_filler:GetIntrinsicModifierName() 
return "modifier_shrine_tower_search" 
end

tower_stun_filler = class({})
function tower_stun_filler:GetIntrinsicModifierName() 
return "modifier_shrine_tower_search"
end


modifier_shrine_tower_search = class({})
function modifier_shrine_tower_search:IsHidden() return true end
function modifier_shrine_tower_search:IsPurgable() return false end
function modifier_shrine_tower_search:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.tower = nil

self:OnIntervalThink()
self:StartIntervalThink(0.3)
end


function modifier_shrine_tower_search:OnIntervalThink()
if not IsServer() then return end

if not self.tower then
	self.tower = towers[self.parent:GetTeamNumber()]
end

if self.tower and not self.mod then
	self.mod = self.tower:AddNewModifier(self.tower, nil, "modifier_tower_shrine_damaga_reduction", {})
end

if not self.parent:IsAlive() then
	self:Destroy()
 	self:StartIntervalThink(-1)
end

end


function modifier_shrine_tower_search:OnDestroy()
if not IsServer() then return end
if not self.tower or self.tower:IsNull() then return end
if not self.mod or self.mod:IsNull() then return end

self.mod:Destroy()
local name = nil

if self.ability:GetName() == "tower_stun_filler" then
	name = "tower_stun"
end

if self.ability:GetName() == "tower_plasma_filler" then
	name = "tower_plasma"
end

if self.ability:GetName() == "tower_resist_filler" then
	name = "tower_aura_resist"
end

if not name then return end
local ability = self.tower:FindAbilityByName(name)

if ability then
	self.tower:RemoveAbility(name)
end

end





modifier_tower_shrine_damaga_reduction = class({})
function modifier_tower_shrine_damaga_reduction:IsHidden() return true end
function modifier_tower_shrine_damaga_reduction:IsPurgable() return false end
function modifier_tower_shrine_damaga_reduction:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_tower_shrine_damaga_reduction:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddNewModifier(self.parent, nil, "modifier_filler_armor", {})
end

function modifier_tower_shrine_damaga_reduction:OnDestroy()
if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_filler_armor")
if mod then
	mod:DecrementStackCount()
	if mod:GetStackCount() <= 0 then
		mod:Destroy()
	end
end

end




modifier_filler_armor = class({})
function modifier_filler_armor:IsHidden() return false end
function modifier_filler_armor:IsPurgable() return false end
function modifier_filler_armor:GetTexture() return "buffs/tower_armor" end
function modifier_filler_armor:OnCreated(table)
self.damage_reduce = 20

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_filler_armor:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()
end

function modifier_filler_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_TOOLTIP
}
end


function modifier_filler_armor:OnTooltip()
return self:GetStackCount()*self.damage_reduce
end



tower_filler_aura = class({})


