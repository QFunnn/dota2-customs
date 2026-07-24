--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sandking_sand_storm_custom", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_target", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_tracker", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_caster", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_spider_ai", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_spider_effect", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_speed", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_cyclone", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_silence", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_damage_cd", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_heal", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_root", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_fade", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_sand_storm_custom_speed_cd", "abilities/sand_king/sandking_sand_storm_custom", LUA_MODIFIER_MOTION_NONE)



sandking_sand_storm_custom = class({})
		
function sandking_sand_storm_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/sand_king/sandking_sandstorm_custom.vpcf", context )
PrecacheResource( "particle","particles/muerta/veil_pull.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_armadillo_shield.vpcf", context )
PrecacheResource( "particle","particles/neutral_fx/skeleton_spawn.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf", context )
PrecacheResource( "particle","particles/sand_king/sandking_caustic_finale_explode_custom.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/sand_king/sand_tornado.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_silenced.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf", context )
PrecacheResource( "particle","particles/sand_king/tornado_damage.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle","particles/sand_king/sand_root.vpcf", context )
PrecacheResource( "particle","particles/lina/dragon_status.vpcf", context )
PrecacheUnitByNameSync("npc_dota_sand_king_spider", context, -1)
end

function sandking_sand_storm_custom:GetRadius()
return self:GetSpecialValueFor("sand_storm_radius") + self:GetCaster():GetTalentValue("modifier_sand_king_sand_6", "radius")
end

function sandking_sand_storm_custom:GetCastRange(vLocation, hTarget)
return self:GetRadius()
end

function sandking_sand_storm_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sand_king_sand_2") then 
	bonus = self:GetCaster():GetTalentValue("modifier_sand_king_sand_2", "cd")
end 
return self.BaseClass.GetCooldown(self, level)  + bonus
end


function sandking_sand_storm_custom:GetManaCost(iLevel)
if self:GetCaster():HasTalent("modifier_sand_king_sand_5") then 
	return 0
end
return self:GetSpecialValueFor("AbilityManaCost")
end

function sandking_sand_storm_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_sand_king_sand_5") then 
	bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + bonus
end


function sandking_sand_storm_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sandking_sand_storm_custom_tracker"
end

function sandking_sand_storm_custom:ProcLegendary(point)
local caster = self:GetCaster()
if not caster:HasTalent("modifier_sand_king_sand_7") then return end

local life_duration = caster:GetTalentValue("modifier_sand_king_sand_7", "life_duration")

for i = 1,caster:GetTalentValue("modifier_sand_king_sand_7", "count") do

	local pos = point + RandomVector(220)

	local unit = CreateUnitByName("npc_dota_sand_king_spider", pos, false, caster, caster, caster:GetTeamNumber())
	unit:AddNewModifier(caster, self, "modifier_sandking_sand_storm_custom_spider_ai", {})
	unit:AddNewModifier(caster, self, "modifier_kill", { duration = life_duration })

	unit.owner = caster

	EmitSoundOnLocationWithCaster(unit:GetAbsOrigin(), "SandKing.Spider_spawn", caster)
	unit:SetAngles(0, 0, 0)
	unit:SetForwardVector(caster:GetForwardVector())
	FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
end

end



function sandking_sand_storm_custom:OnSpellStart()
local duration = self:GetSpecialValueFor("duration")
local caster = self:GetCaster()
local thinker =  CreateModifierThinker(caster, self, "modifier_sandking_sand_storm_custom", {duration = duration}, caster:GetAbsOrigin(), caster:GetTeamNumber(), false)

caster:AddNewModifier(caster, self, "modifier_sandking_sand_storm_custom_caster", {duration = duration, thinker = thinker:entindex()})

if caster:HasTalent("modifier_sand_king_sand_4") then 
	for i = 1,caster:GetTalentValue("modifier_sand_king_sand_4", "max") do
		local angel = (math.pi/2 + 2*math.pi/2 * i)
		CreateModifierThinker(caster, self, "modifier_sandking_sand_storm_custom_cyclone", {thinker = thinker:entindex(), angle = angel}, caster:GetAbsOrigin(), caster:GetTeamNumber(), false)
	end
end

caster:EmitSound("SandKing.SandStorm.start")
end 



function sandking_sand_storm_custom:GetDamage(target)
local caster = self:GetCaster()
local damage = self:GetSpecialValueFor("sand_storm_damage") + caster:GetTalentValue("modifier_sand_king_sand_1", "damage")*caster:GetMaxHealth()/100
local damage_inc = self:GetCaster():GetTalentValue("modifier_sand_king_sand_7", "damage")/100

local mod = target:FindModifierByName("modifier_sandking_sand_storm_custom_spider_effect")

if mod then 
	damage = damage*(1 + mod:GetStackCount()*damage_inc)
end 
return damage
end 


modifier_sandking_sand_storm_custom = class({})
function modifier_sandking_sand_storm_custom:IsPurgable() return false end

function modifier_sandking_sand_storm_custom:OnCreated(table)
if not IsServer() then return end

self.caster = self:GetCaster()
self.thinker = self:GetParent()
self.ability = self:GetAbility()

self.ability:EndCd()

if self.caster:HasTalent("modifier_sand_king_sand_6") and not self.ability:IsHidden() then 
	self.caster:SwapAbilities(self.ability:GetName(), "sandking_sand_storm_custom_legendary", false, true)
	self.caster:FindAbilityByName("sandking_sand_storm_custom_legendary"):StartCooldown(0.5)
end

self.radius = self.ability:GetRadius()
self.speed = (self.ability:GetSpecialValueFor("sand_storm_move_speed") + self.caster:GetTalentValue("modifier_sand_king_sand_2", "speed"))/100
self.timer = self.ability:GetSpecialValueFor("timer")

self.scepter_max = nil
self.scepter_count = 0

self.effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sandking_sandstorm_custom.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.thinker:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, self.radius, self.radius ) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)

self.thinker:EmitSound("SandKing.SandStorm.loop")

self.interval = 0.03
self:StartIntervalThink(self.interval)
end 


function modifier_sandking_sand_storm_custom:OnDestroy()
if not IsServer() then return end 

if self.caster:HasTalent("modifier_sand_king_sand_6") and self.ability:IsHidden() then 
	self.caster:SwapAbilities(self.ability:GetName(), "sandking_sand_storm_custom_legendary", true, false)
end

self.ability:StartCd()

self.thinker:StopSound("SandKing.SandStorm.loop")
self.caster:RemoveModifierByName("modifier_sandking_sand_storm_custom_caster")
UTIL_Remove(self.thinker)
end 

function modifier_sandking_sand_storm_custom:OnIntervalThink()
if not IsServer() then return end

if not self.thinker or self.thinker:IsNull() or not self.caster or self.caster:IsNull() or not self.caster:IsAlive() then 
	self:Destroy()
	return 
end


local dir = (self.caster:GetAbsOrigin() - self.thinker:GetAbsOrigin())
local caster_near = dir:Length2D() <= self.radius

if caster_near then 
	self.thinker:RemoveModifierByName("modifier_sandking_sand_storm_custom_fade")
end

if not caster_near and not self.thinker:HasModifier("modifier_sandking_sand_storm_custom_fade") then 
	self.thinker:AddNewModifier(self.caster, self.ability, "modifier_sandking_sand_storm_custom_fade", {duration = self.timer})
end

local speed = self.caster:GetMoveSpeedModifier(self:GetCaster():GetBaseMoveSpeed(), false)*self.speed

if dir:Length2D() <= speed/10 then return end 
local dist = speed*self.interval

self.thinker:SetAbsOrigin(GetGroundPosition((self.thinker:GetAbsOrigin() + dir:Normalized()*dist), nil))
if self.effect_cast then 
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.thinker:GetAbsOrigin() )
end 

end


function modifier_sandking_sand_storm_custom:IsAura() return true end

function modifier_sandking_sand_storm_custom:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_sandking_sand_storm_custom:GetAuraSearchType()
return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_sandking_sand_storm_custom:GetModifierAura()
return "modifier_sandking_sand_storm_custom_target"
end

function modifier_sandking_sand_storm_custom:GetAuraRadius()
return self.radius
end

function modifier_sandking_sand_storm_custom:GetAuraDuration()
return 0
end



modifier_sandking_sand_storm_custom_target = class({})
function modifier_sandking_sand_storm_custom_target:IsHidden() return true end
function modifier_sandking_sand_storm_custom_target:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_target:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.is_enemy = self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber()

self.interval = self:GetAbility():GetSpecialValueFor("damage_tick_rate")
self.slow = self.caster:GetTalentValue("modifier_sand_king_sand_1", "slow")

self.speed_cd = self.caster:GetTalentValue("modifier_sand_king_sand_5", "cd", true)
self.speed_duration = self.caster:GetTalentValue("modifier_sand_king_sand_5", "duration", true)

if not IsServer() then return end 
self.damageTable = {victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL}

self:StartIntervalThink(self.interval)

if self.caster:HasTalent("modifier_sand_king_sand_3") and self.caster == self.parent then 
	self.parent:AddPercentStat({str = self.caster:GetTalentValue("modifier_sand_king_sand_3", "str")/100}, self)
end

end 

function modifier_sandking_sand_storm_custom_target:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_sandking_sand_storm_custom_target:GetModifierMoveSpeedBonus_Percentage()
if not self.is_enemy then return end 
if not self.caster:HasTalent("modifier_sand_king_sand_1") then return end 
return self.slow
end

function modifier_sandking_sand_storm_custom_target:OnIntervalThink()
if not IsServer() then return end 

if self.is_enemy then
	if self.caster:GetQuest() == "Sand.Quest_6" and self.parent:IsRealHero() then 
		self.caster:UpdateQuest(self.interval)
	end
	local damage = self.interval*self:GetAbility():GetDamage(self.parent)

	self.damageTable.damage = damage
	DoDamage(self.damageTable)
else 
	if self.caster == self.parent and self.caster:HasTalent("modifier_sand_king_sand_5") and not self.caster:HasModifier("modifier_sandking_sand_storm_custom_speed_cd") then 
		self.caster:AddNewModifier(self.caster, self.ability, "modifier_sandking_sand_storm_custom_speed_cd", {duration = self.speed_cd})
		self.caster:AddNewModifier(self.caster, self.ability, "modifier_sandking_sand_storm_custom_speed", {duration = self.speed_duration})
	end
end

end



modifier_sandking_sand_storm_custom_caster = class({})
function modifier_sandking_sand_storm_custom_caster:IsHidden() return false end
function modifier_sandking_sand_storm_custom_caster:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_caster:OnCreated(table)

self.caster = self:GetCaster()

self.regen = self.caster:GetTalentValue("modifier_sand_king_sand_3", "heal")
end 


function modifier_sandking_sand_storm_custom_caster:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end


function modifier_sandking_sand_storm_custom_caster:GetModifierHealthRegenPercentage()
if not self.caster:HasTalent("modifier_sand_king_sand_3") then return end 
if not self.caster:HasModifier("modifier_sandking_sand_storm_custom_target") then return end
return self.regen
end







sandking_sand_storm_custom_legendary = class({})


function sandking_sand_storm_custom_legendary:GetCooldown(iLevel)
return self:GetCaster():GetTalentValue("modifier_sand_king_sand_6", "cd")
end

function sandking_sand_storm_custom_legendary:GetBehavior()
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function sandking_sand_storm_custom_legendary:GetChannelAnimation()
return ACT_DOTA_OVERRIDE_ABILITY_2
end


function sandking_sand_storm_custom_legendary:OnSpellStart()

self.caster = self:GetCaster()

local mod = self.caster:FindModifierByName("modifier_sandking_sand_storm_custom_target")
self.point = self.caster:GetAbsOrigin()

local ability = self.caster:FindAbilityByName("sandking_sand_storm_custom")
local radius = ability:GetRadius() + self.caster:GetTalentValue("modifier_sand_king_sand_6", "more_radius")

if mod and mod:GetAuraOwner() and not mod:GetAuraOwner():IsNull() then 
	self.point = mod:GetAuraOwner():GetAbsOrigin()

	local effect_cast = ParticleManager:CreateParticle( "particles/muerta/veil_pull.vpcf", PATTACH_ABSORIGIN_FOLLOW, mod:GetAuraOwner() )
	ParticleManager:SetParticleControl( effect_cast, 0, self.point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end 

EmitSoundOnLocationWithCaster(self.point, "SandKing.Sand_pull", self.caster)

local units = FindUnitsInRadius( self.caster:GetTeamNumber(), self.point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 0, 0, false )

local root_duration = self.caster:GetTalentValue("modifier_sand_king_sand_6", "duration")

for _,unit in pairs(units) do

	local dir = (self.point -  unit:GetAbsOrigin()):Normalized()
	local point = self.point - dir*50
	local distance = (point - unit:GetAbsOrigin()):Length2D()

	distance = math.max(50, distance)
	point = unit:GetAbsOrigin() + dir*distance

	local mod = unit:AddNewModifier( self.caster,  self,  "modifier_generic_arc",  
	{
	  target_x = point.x,
	  target_y = point.y,
	  distance = distance,
	  duration = 0.3,
	  height = 0,
	  fix_end = false,
	  isStun = true,
	  activity = ACT_DOTA_FLAIL,
	})

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
	mod:AddParticle(effect_cast,false, false, -1, false, false)
	mod:SetEndCallback(function()
		unit:AddNewModifier(self.caster, self, "modifier_sandking_sand_storm_custom_root", {duration = (1 - unit:GetStatusResistance())*root_duration})
	end)
end

end 






modifier_sandking_sand_storm_custom_spider_ai = class({})
function modifier_sandking_sand_storm_custom_spider_ai:IsHidden() return true end
function modifier_sandking_sand_storm_custom_spider_ai:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_spider_ai:RemoveOnDeath() return false end

function modifier_sandking_sand_storm_custom_spider_ai:GetStatusEffectName()
return "particles/status_fx/status_effect_armadillo_shield.vpcf"
end

function modifier_sandking_sand_storm_custom_spider_ai:StatusEffectPriority()
	return MODIFIER_PRIORITY_ILLUSION
end


function modifier_sandking_sand_storm_custom_spider_ai:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()

local health = self.caster:GetMaxHealth()*self.caster:GetTalentValue("modifier_sand_king_sand_7", "health")/100
self.slow_duration = self.caster:GetTalentValue("modifier_sand_king_sand_7", "slow_duration", true)

self.parent:SetBaseMaxHealth(health)
self.parent:SetHealth(self.parent:GetMaxHealth())

ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/neutral_fx/skeleton_spawn.vpcf", PATTACH_ABSORIGIN, self.parent ) )
self.parent:SetRenderColor(246, 210, 143)

local vec = (self.parent:GetAbsOrigin() - self.caster:GetAbsOrigin())

self.vec = vec:Normalized()*300

self.radius = 1500

self.target = nil

self:OnIntervalThink()
self:StartIntervalThink(0.2)
end


function modifier_sandking_sand_storm_custom_spider_ai:CheckState()
return
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_sandking_sand_storm_custom_spider_ai:IsValidTarget(target)
if not IsServer() then return end 
if not target or target:IsNull() or not target:IsAlive() or 
 ((target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius) or (not target:IsHero() and not target:IsCreep())
or target:IsCourier() or target:GetUnitName() == "npc_teleport" or target:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then 

	return false 
end
return true
end 

function modifier_sandking_sand_storm_custom_spider_ai:SetTarget(target)
if not IsServer() then return end
if not self:IsValidTarget(target) then return end
if self.target == target then return end

self.target = target
self.parent:MoveToPositionAggressive(self.target:GetAbsOrigin())
self.parent:SetForceAttackTarget(self.target)

end 

function modifier_sandking_sand_storm_custom_spider_ai:MoveToCaster()
if not IsServer() then return end

self.target = nil
self.parent:SetForceAttackTarget(nil)

local point = self.caster:GetAbsOrigin() + self.vec

if (point - self.parent:GetAbsOrigin()):Length2D() > 50 then 
	self.parent:MoveToPosition(self.caster:GetAbsOrigin() + self.vec)
end

end

function modifier_sandking_sand_storm_custom_spider_ai:OnIntervalThink()
if not IsServer() then return end

if self.parent:GetAggroTarget() then
    self.target = self.parent:GetAggroTarget()
end

local heroes = FindUnitsInRadius( self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
local creeps = FindUnitsInRadius( self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )

if self:IsValidTarget(self.target) and self.target:IsHero() then 
    self:SetTarget(self.target)
    return
end 

if (not self:IsValidTarget(self.target) or not self.target:IsHero()) and  #heroes > 0  then
	for _,hero in pairs(heroes) do
		if self:IsValidTarget(hero) then 
			self:SetTarget(hero)
        	break
		end
	end 
end

if not self:IsValidTarget(self.target) and #creeps > 0 then 
	for _,creep in pairs(creeps) do
		if self:IsValidTarget(creep) then 
			self:SetTarget(creep)
        	break
		end
	end
end 

if not self:IsValidTarget(self.target) then 
	self:MoveToCaster()
end

end

function modifier_sandking_sand_storm_custom_spider_ai:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
}
end

function modifier_sandking_sand_storm_custom_spider_ai:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
if not params.target:IsCreep() and not params.target:IsHero() then return end
params.target:AddNewModifier(self.caster, self:GetAbility(), "modifier_sandking_sand_storm_custom_spider_effect", {duration = self.slow_duration})
end




modifier_sandking_sand_storm_custom_spider_effect = class({})
function modifier_sandking_sand_storm_custom_spider_effect:IsHidden() return false end
function modifier_sandking_sand_storm_custom_spider_effect:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_spider_effect:GetTexture() return "buffs/sand_spider" end

function modifier_sandking_sand_storm_custom_spider_effect:GetEffectName()
return "particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf"
end

function modifier_sandking_sand_storm_custom_spider_effect:OnCreated()
self.damage = self:GetCaster():GetTalentValue("modifier_sand_king_sand_7", "damage")
if not IsServer() then return end
self:SetStackCount(1)
end 

function modifier_sandking_sand_storm_custom_spider_effect:OnRefresh(table)
if not IsServer() then return end 
self:IncrementStackCount()
end 

function modifier_sandking_sand_storm_custom_spider_effect:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP
}
end


function modifier_sandking_sand_storm_custom_spider_effect:OnTooltip()
return self:GetStackCount()*self.damage
end




modifier_sandking_sand_storm_custom_tracker = class({})
function modifier_sandking_sand_storm_custom_tracker:IsHidden() return true end
function modifier_sandking_sand_storm_custom_tracker:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_tracker:OnCreated()

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
self.caster:AddSpellEvent(self)
self.death_radius = self.caster:GetTalentValue("modifier_sand_king_sand_7", "radius", true)
self.death_damage = self.caster:GetTalentValue("modifier_sand_king_sand_7", "death_damage", true)/100

self.no_proc = 
{
	["sandking_burrowstrike_custom"] = true,
	["sandking_scorpion_strike_custom"] = true,
	["sandking_burrowstrike_custom_legendary_exit"] = true,
	["sandking_burrowstrike_custom_reverse"] = true
}
end 



function modifier_sandking_sand_storm_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if not self.caster:HasTalent("modifier_sand_king_sand_7") then return end
if params.unit ~= self.caster then return end 
if params.ability:IsItem() then return end 
if self.no_proc[params.ability:GetName()] then return end 

self.ability:ProcLegendary(self.caster:GetAbsOrigin())
end


function modifier_sandking_sand_storm_custom_tracker:DeathEvent(params)
if not IsServer() then return end
if not self.caster:HasTalent("modifier_sand_king_sand_7") then return end

local unit = params.unit

if unit and unit.owner and unit.owner == self.caster and unit:HasModifier("modifier_sandking_sand_storm_custom_spider_ai") then 

	local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sandking_caustic_finale_explode_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	unit:EmitSound("Ability.SandKing_CausticFinale")

	local targets = self.caster:FindTargets(self.death_radius, unit:GetAbsOrigin())

	local damage_table = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

	for _,target in pairs(targets) do

		damage_table.damage = self.ability:GetDamage(target)*self.death_damage
		damage_table.victim = target
		local real_damage = DoDamage(damage_table, "modifier_sand_king_sand_7")
	end 

end 

end







modifier_sandking_sand_storm_custom_speed = class({})
function modifier_sandking_sand_storm_custom_speed:IsHidden() return true end
function modifier_sandking_sand_storm_custom_speed:IsPurgable() return false end

function modifier_sandking_sand_storm_custom_speed:GetEffectName()
return "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf"
end 

function modifier_sandking_sand_storm_custom_speed:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sandking_sand_storm_custom_speed:OnCreated()
self.parent = self:GetParent()
self.speed = self.parent:GetTalentValue("modifier_sand_king_sand_5", "speed")
self.status = self.parent:GetTalentValue("modifier_sand_king_sand_5", "status")
if not IsServer() then return end
self.parent:EmitSound("SandKing.Storm_speed")
self.parent:GenericParticle("particles/lina/dragon_status.vpcf", self)
end

function modifier_sandking_sand_storm_custom_speed:CheckState()
return
{
	--[MODIFIER_STATE_UNSLOWABLE] = true
}
end

function modifier_sandking_sand_storm_custom_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_sandking_sand_storm_custom_speed:GetModifierStatusResistanceStacking()
return self.status
end

function modifier_sandking_sand_storm_custom_speed:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end



modifier_sandking_sand_storm_custom_cyclone = class({})
function modifier_sandking_sand_storm_custom_cyclone:IsHidden() return true end
function modifier_sandking_sand_storm_custom_cyclone:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_cyclone:OnCreated(table)
if not IsServer() then return end 

self.thinker = EntIndexToHScript(table.thinker)
self.hit_radius = 200
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sand_tornado.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.hit_radius, 0, 0) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)


self:GetParent():EmitSound("SandKing.Tornado_start")
self:GetParent():EmitSound("SandKing.Tornado_loop")

self.radius_min = 220

self.radius_max = self.ability:GetRadius() - self.hit_radius

self.radius_speed = 60
self.radius_k = 1
self.radius_timer = 0 
self.radius_timer_max = 2
self.radius_stop = false
self.radius = self.radius_min

self.ability =  self:GetAbility()
self.caster = self:GetCaster()
self.target_point = nil
self.damage_dealt = false

self.center = self.thinker:GetAbsOrigin()

self.current_angle = table.angle

self.current_speed = 1.3
if self.caster:GetTalentValue("modifier_sand_king_sand_4", "max") == 1 then 
	self.current_speed = self.current_speed * 1.2
end 

self.dt = 0.01
self:StartIntervalThink(self.dt)
self:OnIntervalThink()
end 

function modifier_sandking_sand_storm_custom_cyclone:OnIntervalThink()
if not IsServer() then return end 

if not self.thinker or self.thinker:IsNull() then 
	self:Destroy()
	return
end 


self.center = self.thinker:GetAbsOrigin()

self.current_angle = self.current_angle + self.current_speed * self.dt
if self.current_angle > 2*math.pi then
	self.current_angle = self.current_angle - 2*math.pi
end

local position = self:GetPosition()
self.parent:SetAbsOrigin(position)

--local targets = self.caster:FindTargets(self.hit_radius, position)



if self.radius_stop == true then 
	self.radius_timer = self.radius_timer + self.dt

	if self.radius_timer >= self.radius_timer_max then 
		self.radius_stop = false
		self.radius_timer = 0
	else 
		return
	end
end 

self.radius = self.radius + self.radius_k * self.radius_speed * self.dt

if self.radius >= self.radius_max then 
	self.radius_k = -1
	self.radius_stop = true
end 

if self.radius <= self.radius_min then 
	self.radius_k = 1
	self.radius_stop = true
end 


end


function modifier_sandking_sand_storm_custom_cyclone:GetPosition()

local abs = GetGroundPosition(self.center + Vector( math.cos( self.current_angle ), math.sin( self.current_angle ), 0 ) * self.radius, nil)

return abs
end

function modifier_sandking_sand_storm_custom_cyclone:OnDestroy()
if not IsServer() then return end 

self:GetParent():StopSound("SandKing.Tornado_loop")

end 



function modifier_sandking_sand_storm_custom_cyclone:IsAura()
    return true
end

function modifier_sandking_sand_storm_custom_cyclone:GetModifierAura()
    return "modifier_sandking_sand_storm_custom_damage_cd"
end

function modifier_sandking_sand_storm_custom_cyclone:GetAuraRadius()
    return self.hit_radius
end

function modifier_sandking_sand_storm_custom_cyclone:GetAuraDuration()
    return 0.1
end

function modifier_sandking_sand_storm_custom_cyclone:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_sandking_sand_storm_custom_cyclone:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end














modifier_sandking_sand_storm_custom_silence = class({})
function modifier_sandking_sand_storm_custom_silence:IsHidden() return true end
function modifier_sandking_sand_storm_custom_silence:IsPurgable() return true end
function modifier_sandking_sand_storm_custom_silence:OnCreated()

self.slow = self:GetCaster():GetTalentValue("modifier_sand_king_sand_4", "slow")
end

function modifier_sandking_sand_storm_custom_silence:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
}
end


function modifier_sandking_sand_storm_custom_silence:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_sandking_sand_storm_custom_silence:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end
function modifier_sandking_sand_storm_custom_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_sandking_sand_storm_custom_silence:ShouldUseOverheadOffset() return true end
function modifier_sandking_sand_storm_custom_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_sandking_sand_storm_custom_silence:GetStatusEffectName()
return "particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf"
end


function modifier_sandking_sand_storm_custom_silence:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end



modifier_sandking_sand_storm_custom_damage_cd = class({})
function modifier_sandking_sand_storm_custom_damage_cd:IsHidden() return true end
function modifier_sandking_sand_storm_custom_damage_cd:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_damage_cd:OnCreated()
if not IsServer() then return end
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.silence = self.caster:GetTalentValue("modifier_sand_king_sand_4", "silence")
self.parent:AddNewModifier(self.caster, self.ability, "modifier_sandking_sand_storm_custom_silence", {duration = self.silence*(1 - self.parent:GetStatusResistance())})

self.damage = self.caster:GetTalentValue("modifier_sand_king_sand_4", "damage")/100

DoDamage({victim = self.parent, attacker = self:GetCaster(), ability = self.ability, damage = self.ability:GetDamage(self.parent)*self.damage, damage_type = DAMAGE_TYPE_MAGICAL}, "modifier_sand_king_sand_4")

local particle = ParticleManager:CreateParticle("particles/sand_king/tornado_damage.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)

self.parent:EmitSound("SandKing.Tornado_damage")
end 



modifier_sandking_sand_storm_custom_heal = class({})
function modifier_sandking_sand_storm_custom_heal:IsHidden() return true end
function modifier_sandking_sand_storm_custom_heal:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_heal:OnCreated()

self.heal = self:GetCaster():GetTalentValue("modifier_sand_king_sand_6", "heal")/self:GetCaster():GetTalentValue("modifier_sand_king_sand_6", "duration")

if not IsServer() then return end 

self.interval = 0.5

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end 

function modifier_sandking_sand_storm_custom_heal:OnIntervalThink()
if not IsServer() then return end 

self:GetParent():SendNumber(10, self.heal*self.interval*self:GetParent():GetMaxHealth()/100)
end 


function modifier_sandking_sand_storm_custom_heal:GetEffectName() return "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf" end

function modifier_sandking_sand_storm_custom_heal:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end



function modifier_sandking_sand_storm_custom_heal:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end


function modifier_sandking_sand_storm_custom_heal:GetModifierHealthRegenPercentage()
return self.heal
end


modifier_sandking_sand_storm_custom_root = class({})
function modifier_sandking_sand_storm_custom_root:IsHidden() return true end
function modifier_sandking_sand_storm_custom_root:IsPurgable() return true end
function modifier_sandking_sand_storm_custom_root:OnCreated(table)
if not IsServer() then return end

self:StartIntervalThink(0.1)
end

function modifier_sandking_sand_storm_custom_root:OnIntervalThink()
if not IsServer() then return end

self.effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sand_root.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
self:AddParticle(self.effect_cast,false, false, -1, false, false)


self:StartIntervalThink(-1)
end 

function modifier_sandking_sand_storm_custom_root:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end


modifier_sandking_sand_storm_custom_fade = class({})
function modifier_sandking_sand_storm_custom_fade:IsHidden() return true end
function modifier_sandking_sand_storm_custom_fade:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_fade:OnDestroy()
if not IsServer() then return end 
if self:GetRemainingTime() > 0.1 then return end
local parent = self:GetParent()
if not parent or parent:IsNull() then return end 

parent:RemoveModifierByName("modifier_sandking_sand_storm_custom")
end


modifier_sandking_sand_storm_custom_speed_cd = class({})
function modifier_sandking_sand_storm_custom_speed_cd:IsHidden() return false end
function modifier_sandking_sand_storm_custom_speed_cd:IsPurgable() return false end
function modifier_sandking_sand_storm_custom_speed_cd:RemoveOnDeath() return false end
function modifier_sandking_sand_storm_custom_speed_cd:IsDebuff() return true end
function modifier_sandking_sand_storm_custom_speed_cd:OnCreated()
self.RemoveForDuel = true
end