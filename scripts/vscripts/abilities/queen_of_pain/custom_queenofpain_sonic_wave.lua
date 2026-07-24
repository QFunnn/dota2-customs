--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_sonic_tracker", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_fire_thinker", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_fire_damage", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_lifesteal", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_stack", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_kill", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_damage", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_damage_arcana_visual", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_legendary_stack", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_heal_reduce", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sonic_cdr_perma", "abilities/queen_of_pain/custom_queenofpain_sonic_wave", LUA_MODIFIER_MOTION_NONE)



custom_queenofpain_sonic_wave = class({})



function custom_queenofpain_sonic_wave:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "queenofpain_sonic_wave", self)
end



function custom_queenofpain_sonic_wave:CreateTalent(name)

if dota1x6.current_wave >= upgrade_orange then 
	local caster = self:GetCaster()
	local max = caster:GetTalentValue("modifier_queen_sonic_7", "max")/2

	local mod = caster:AddNewModifier(caster, self, "modifier_custom_sonic_legendary_stack", {})
	if mod then 
	  mod:SetStackCount(max)
	end
end

end 


function custom_queenofpain_sonic_wave:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_sonic_wave.vpcf", context )
PrecacheResource( "particle","particles/qop_sonic_attack.vpcf", context )
PrecacheResource( "particle","particles/huskar_leap_heal.vpcf", context )
PrecacheResource( "particle","particles/queenofpain/sonic_stack.vpcf", context )
PrecacheResource( "particle","particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle","particles/qop_sonic_fire.vpcf", context )
PrecacheResource( "particle","particles/sf_timer.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_charge_mark.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_qop_tgt_arcana.vpcf", context )
PrecacheResource( "particle","particles/roshan_meteor_burn_.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )

end

function custom_queenofpain_sonic_wave:GetHealthCost(level)
local caster = self:GetCaster()
if caster:HasModifier("modifier_queenofpain_blood_pact") then 
	return caster:GetTalentValue("modifier_queen_scream_7", "cost")*caster:GetMaxHealth()/100
end
end 

function custom_queenofpain_sonic_wave:GetManaCost(iLevel)
if self:GetCaster():HasModifier("modifier_queenofpain_blood_pact") then 
	return 0
end
return self.BaseClass.GetManaCost(self,iLevel)
end 


function custom_queenofpain_sonic_wave:GetCastPoint(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_queen_sonic_2") then 
	bonus = self:GetCaster():GetTalentValue("modifier_queen_sonic_2", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end

function custom_queenofpain_sonic_wave:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_sonic_tracker"
end

function custom_queenofpain_sonic_wave:GetCooldown(iLevel)
local caster = self:GetCaster()
local k = 1
local bonus = 0
if caster:HasTalent("modifier_queen_sonic_2") then 
	bonus = caster:GetTalentValue("modifier_queen_sonic_2", "cd")
end
if caster:HasModifier("modifier_custom_sonic_legendary_stack") then
	k = k + (caster:GetTalentValue("modifier_queen_sonic_7", "cd_inc")/caster:GetTalentValue("modifier_queen_sonic_7", "max"))*caster:GetUpgradeStack("modifier_custom_sonic_legendary_stack")/100
end
return (self.BaseClass.GetCooldown(self, iLevel) + bonus)*k
end


function custom_queenofpain_sonic_wave:OnAbilityPhaseStart()
local caster = self:GetCaster()
local sound = wearables_system:GetSoundReplacement(caster, "Hero_QueenOfPain.SonicWave.Precast", self)
local particle_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_queenofpain/queen_sonic_wave_cast.vpcf", self)
if particle_name ~= "particles/units/heroes/hero_queenofpain/queen_sonic_wave_cast.vpcf" and caster.current_model == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
    self.start_particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, caster)
end
caster:EmitSound(sound)
return true
end

function custom_queenofpain_sonic_wave:OnAbilityPhaseInterrupted()
local caster = self:GetCaster()
local sound = wearables_system:GetSoundReplacement(caster, "Hero_QueenOfPain.SonicWave.Precast", self)
if self.start_particle ~= nil then
    ParticleManager:DestroyParticle(self.start_particle, true)
    ParticleManager:ReleaseParticleIndex(self.start_particle)
    self.start_particle = nil
end
caster:StopSound(sound)
end

function custom_queenofpain_sonic_wave:GetDamage(target)
if not IsServer() then return end
local caster = self:GetCaster()
local damage =  self:GetSpecialValueFor("damage") + caster:GetTalentValue("modifier_queen_sonic_1", "damage")
local mod = caster:FindModifierByName("modifier_custom_sonic_legendary_stack")
if mod and mod.damage then
	damage = damage*(1 + mod.damage*mod:GetStackCount()/100)
end
local target_mod = target:FindModifierByName("modifier_custom_sonic_stack")
if target_mod and target_mod.damage then
	damage = damage*(1 + target_mod.damage*target_mod:GetStackCount()/100)
end
return damage
end

function custom_queenofpain_sonic_wave:CreateFire(start_pos, end_pos)
local caster = self:GetCaster()
local duration = caster:GetTalentValue("modifier_queen_sonic_7", "duration")

CreateModifierThinker(caster, self, "modifier_custom_sonic_fire_thinker",{duration = duration, end_x = end_pos.x, end_y = end_pos.y}, start_pos, caster:GetTeamNumber(), false)
end


function custom_queenofpain_sonic_wave:OnSpellStart()
local caster = self:GetCaster()
local target_loc = self:GetCursorPosition()
local caster_loc = caster:GetAbsOrigin()

if target_loc == caster_loc then
	target = caster:GetAbsOrigin() + caster:GetForwardVector()
end
local direction = (target_loc - caster_loc):Normalized()

if self.start_particle ~= nil then
    ParticleManager:DestroyParticle(self.start_particle, false)
    ParticleManager:ReleaseParticleIndex(self.start_particle)
    self.start_particle = nil
end

local start_radius = self:GetSpecialValueFor("starting_aoe")
local end_radius = self:GetSpecialValueFor("final_aoe")
local travel_distance = self:GetSpecialValueFor("distance")
local projectile_speed = self:GetSpecialValueFor("speed")

if caster:HasTalent("modifier_queen_sonic_3") then 
	caster:AddNewModifier(caster, self, "modifier_custom_sonic_lifesteal", {duration = caster:GetTalentValue("modifier_queen_sonic_3", "duration")})
end

if caster:HasTalent("modifier_queen_sonic_6") then
	caster:AddNewModifier(caster, self, "modifier_generic_debuff_immune", {duration = caster:GetTalentValue("modifier_queen_sonic_6", "bkb"), effect = 1})
end

local sound = wearables_system:GetSoundReplacement(caster, "Hero_QueenOfPain.SonicWave.ArcanaLayer_null", self)
if sound ~= "Hero_QueenOfPain.SonicWave.ArcanaLayer_null" then
	caster:EmitSound(sound)
end

caster:EmitSound("Hero_QueenOfPain.SonicWave")

local effect = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_queenofpain/queen_sonic_wave.vpcf", self)

projectile =
{
	Ability				= self,
	EffectName			= effect,
	vSpawnOrigin		= caster_loc,
	fDistance			= travel_distance,
	fStartRadius		= start_radius,
	fEndRadius			= end_radius,
	Source				= caster,
	bHasFrontalCone		= true,
	bReplaceExisting	= false,
	iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
	iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_NONE,
	iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	fExpireTime 		= GameRules:GetGameTime() + 10.0,
	bDeleteOnHit		= true,
	vVelocity			= Vector(direction.x,direction.y,0) * projectile_speed,
	bProvidesVision		= false,
	ExtraData			= {x = caster_loc.x, y = caster_loc.y}
}

ProjectileManager:CreateLinearProjectile(projectile)


end

function custom_queenofpain_sonic_wave:OnProjectileHit_ExtraData(target, location, ExtraData)
if not target then return end
if not target:IsUnit() then return end

local caster = self:GetCaster()

local mod = target:FindModifierByName("modifier_custom_sonic_stack")

if mod and mod.max and mod:GetStackCount() >= mod.max then 
	target:AddNewModifier(caster, self, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*caster:GetTalentValue("modifier_queen_sonic_4", "stun")})
end

if caster:HasTalent("modifier_queen_sonic_5") then 
	target:Purge(true, false, false, false, false)
	target:AddNewModifier(caster, self, "modifier_generic_break", {duration = (1 - target:GetStatusResistance())*caster:GetTalentValue("modifier_queen_sonic_5", "duration")})
end 

if caster:HasTalent("modifier_queen_sonic_1") then
	target:AddNewModifier(caster, self, "modifier_custom_sonic_heal_reduce", {duration = caster:GetTalentValue("modifier_queen_sonic_1", "duration")})
end

local sound = wearables_system:GetSoundReplacement(caster, "Hero_QueenOfPain.SonicWave.Arcana.Target_null", self)
if sound ~= "Hero_QueenOfPain.SonicWave.Arcana.Target_null" then
	target:EmitSound(sound)
end

target:AddNewModifier(caster, self, "modifier_custom_sonic_kill", {duration = caster:GetTalentValue("modifier_queen_sonic_7", "timer", true)})
target:AddNewModifier(caster, self, "modifier_custom_sonic_damage", {duration = 5})

local duration_k = (1 + caster:GetTalentValue("modifier_queen_sonic_5", "duration_knock")/100)
local location = GetGroundPosition(Vector(ExtraData.x,  ExtraData.y ,0), nil)
local enemy_direction = (target:GetOrigin() - location):Normalized()
local dist = self:GetSpecialValueFor("knockback_distance") * duration_k
local point = location + enemy_direction*dist
local distance = (point - target:GetAbsOrigin()):Length2D()

target:AddNewModifier(caster, self,
"modifier_generic_knockback",
{
	duration = self:GetSpecialValueFor("knockback_duration") * duration_k,
	distance = dist,
	height = 0,
	direction_x = enemy_direction.x,
	direction_y = enemy_direction.y,
})

end



modifier_custom_sonic_damage = class({})
function modifier_custom_sonic_damage:IsHidden() return true end
function modifier_custom_sonic_damage:IsPurgable() return false end
function modifier_custom_sonic_damage:OnCreated(table)
self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()

if not IsServer() then return end
self.damage = self.ability:GetDamage(self.parent)

self.duration = self.ability:GetSpecialValueFor("knockback_duration")
self.max = self.ability:GetSpecialValueFor("ticks")
self.interval = self.duration/self.max
self.tick_damage = (self.damage/self.max)
self:SetStackCount(self.max)

local pfx_visual = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_queenofpain/queen_sonic_wave_tgt.vpcf", self)
if pfx_visual ~= "particles/units/heroes/hero_queenofpain/queen_sonic_wave_tgt.vpcf" then
    local particle_think = ParticleManager:CreateParticle(pfx_visual, PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle_think, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle_think, 2, self.caster:GetAbsOrigin())
    self:AddParticle(particle_think, false, false, -1, false, false)
    self.parent:AddNewModifier(self.parent, nil, "modifier_custom_sonic_damage_arcana_visual", {duration = self:GetDuration()})
end

self:StartIntervalThink(self.interval)
end 

function modifier_custom_sonic_damage:OnIntervalThink()
if not IsServer() then return end 

DoDamage({attacker = self.caster, victim = self.parent, ability = self.ability, damage = self.tick_damage, damage_type = DAMAGE_TYPE_PURE})
self:DecrementStackCount()
if self:GetStackCount() <= 0 then
	self:Destroy()
end

end

function modifier_custom_sonic_damage:OnDestroy()
if not IsServer() then return end
if self.parent:IsAlive() then return end

local pfx_visual = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_queenofpain/queen_target_death.vpcf", self)
if pfx_visual ~= "particles/units/heroes/hero_queenofpain/queen_target_death.vpcf" then
    local particle_die = ParticleManager:CreateParticle(pfx_visual, PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:ReleaseParticleIndex(particle_die)
end

end




modifier_custom_sonic_tracker = class({})
function modifier_custom_sonic_tracker:IsHidden() return true end
function modifier_custom_sonic_tracker:IsPurgable() return false end



function modifier_custom_sonic_tracker:OnCreated()
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.ability = self:GetAbility()

self.legendary_hero = self.parent:GetTalentValue("modifier_queen_sonic_7", "hero", true)
 
self.stack_radius = self.parent:GetTalentValue("modifier_queen_sonic_4", "radius", true)
self.stack_duration = self.parent:GetTalentValue("modifier_queen_sonic_4", "duration", true)

self.heal_creeps = self.parent:GetTalentValue("modifier_queen_sonic_3", "creeps", true)
self.heal_bonus = self.parent:GetTalentValue("modifier_queen_sonic_3", "bonus", true)

self.parent:AddDamageEvent_out(self)
self.parent:AddAttackEvent_out(self)
end

function modifier_custom_sonic_tracker:AttackEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_queen_sonic_4") then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end


if false then
	params.target:EmitSound("QoP.Sonic_attack")
	local scream_pfx = ParticleManager:CreateParticle("particles/qop_sonic_attack.vpcf", PATTACH_ABSORIGIN, params.target)
	ParticleManager:SetParticleControl(scream_pfx, 0, params.target:GetAbsOrigin() )
	ParticleManager:ReleaseParticleIndex(scream_pfx)
end

local target = params.target
target:GenericParticle("particles/queenofpain/sonic_stack.vpcf")

for _,unit in pairs(self.parent:FindTargets(self.stack_radius, target:GetAbsOrigin())) do 
	unit:AddNewModifier(self.parent, self.ability, "modifier_custom_sonic_stack", {duration = self.stack_duration})
end

end


function modifier_custom_sonic_tracker:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_queen_sonic_3") then return end
if not self.parent:CheckLifesteal(params) then return end
local effect = ""
local heal = self.parent:GetTalentValue("modifier_queen_sonic_3", "heal")/100
if params.unit:IsCreep() then 
  heal = heal / self.heal_creeps
end
if self.parent:HasModifier("modifier_custom_sonic_lifesteal") then
	heal = heal*self.heal_bonus
	effect = nil
end
self.parent:GenericHeal(heal*params.damage, self.ability, true, effect, "modifier_queen_sonic_3")
end


function modifier_custom_sonic_tracker:DeathEvent(params)
if not IsServer() then return end
local target = params.unit

if target:HasModifier("modifier_custom_sonic_kill") and params.unit:IsValidKill(self.parent) then

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_sonic_cdr_perma", {})

	if self.parent:GetQuest() == "Queen.Quest_8" and not self.parent:QuestCompleted() then
		self.parent:UpdateQuest(1)
	end
end

if not self.parent:HasTalent("modifier_queen_sonic_7") then return end
if self.parent ~= params.attacker then return end
if params.inflictor ~= self.ability and not params.unit:HasModifier("modifier_custom_sonic_kill") then return end

local count = 1
if params.unit:IsHero() then
	if not params.unit:IsValidKill(self.parent) then
		return
	end
	count = self.legendary_hero
end

for i = 1,count do
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_sonic_legendary_stack", {})
end

end





modifier_custom_sonic_fire_thinker = class({})

function modifier_custom_sonic_fire_thinker:IsHidden() return true end
function modifier_custom_sonic_fire_thinker:IsPurgable() return false end
function modifier_custom_sonic_fire_thinker:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
			
self.start_pos = self.parent:GetAbsOrigin()
self.end_pos = GetGroundPosition(Vector(table.end_x,table.end_y, 0), nil)

self.radius = self.caster:GetTalentValue("modifier_queen_sonic_7", "radius")

self.parent:EmitSound("QoP.Sonic_fire")

self.pfx = ParticleManager:CreateParticle("particles/qop_sonic_fire.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.pfx, 0, self.start_pos)
ParticleManager:SetParticleControl(self.pfx, 2, Vector(self:GetRemainingTime(), 0, 0))
ParticleManager:SetParticleControl(self.pfx, 1, self.end_pos)
ParticleManager:SetParticleControl(self.pfx, 3, self.end_pos)
ParticleManager:ReleaseParticleIndex(self.pfx)
self:AddParticle(self.pfx,false,false,-1,false,false)

self.interval = 0.2
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_custom_sonic_fire_thinker:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("QoP.Sonic_fire")
end


function modifier_custom_sonic_fire_thinker:OnIntervalThink()
if not IsServer() then return end

local enemies = FindUnitsInLine(self.caster:GetTeamNumber(), self.start_pos, self.end_pos, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NONE)

for _,enemy in pairs(enemies) do 
	enemy:AddNewModifier(self.caster, self.ability, "modifier_custom_sonic_fire_damage", {duration = self.interval*2})
end

end



modifier_custom_sonic_fire_damage = class({})
function modifier_custom_sonic_fire_damage:IsHidden() return true end
function modifier_custom_sonic_fire_damage:IsPurgable() return false end
function modifier_custom_sonic_fire_damage:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = self.caster:GetTalentValue("modifier_queen_sonic_7", "interval")
self.damage_k = self.caster:GetTalentValue("modifier_queen_sonic_7", "damage")*self.interval/100

self.damageTable = {attacker = self.caster, ability = self.ability, victim = self.parent, damage_type = DAMAGE_TYPE_PURE}

if not IsServer() then return end
self.parent:GenericParticle("particles/roshan_meteor_burn_.vpcf", self)
self:StartIntervalThink(self.interval)
end

function modifier_custom_sonic_fire_damage:OnIntervalThink()
if not IsServer() then return end

self.damageTable.damage = self.ability:GetDamage(self.parent)*self.damage_k

local real_damage = DoDamage(self.damageTable, "modifier_queen_sonic_7")
self.parent:SendNumber(4, real_damage)
end

function modifier_custom_sonic_fire_damage:GetStatusEffectName()
return "particles/status_fx/status_effect_qop_tgt_arcana.vpcf"
end
function modifier_custom_sonic_fire_damage:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end





modifier_custom_sonic_lifesteal = class({})
function modifier_custom_sonic_lifesteal:IsHidden() return false end
function modifier_custom_sonic_lifesteal:IsPurgable() return false end
function modifier_custom_sonic_lifesteal:GetTexture() return "buffs/sonic_reduce" end



modifier_custom_sonic_stack = class({})
function modifier_custom_sonic_stack:IsHidden() return false end
function modifier_custom_sonic_stack:IsPurgable() return false end
function modifier_custom_sonic_stack:GetTexture() return "buffs/sonic_stack" end
function modifier_custom_sonic_stack:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.max = self.caster:GetTalentValue("modifier_queen_sonic_4", "max")
self.damage = self.caster:GetTalentValue("modifier_queen_sonic_4", "damage")

if not IsServer() then return end

if not self.caster:HasTalent("modifier_queen_dagger_7") then
	self.particle = self.parent:GenericParticle("particles/sf_timer.vpcf", self, true)
end

self:SetStackCount(1)
end

function modifier_custom_sonic_stack:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_custom_sonic_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if self.particle then
	ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
end

if self:GetStackCount() >= self.max then 
	if self.particle then
		ParticleManager:DestroyParticle(self.particle, true)
		ParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
	self.parent:GenericParticle("particles/lc_odd_charge_mark.vpcf", self, true)
end

end

modifier_custom_sonic_kill = class({})
function modifier_custom_sonic_kill:IsHidden() return true end
function modifier_custom_sonic_kill:IsPurgable() return false end
function modifier_custom_sonic_kill:RemoveOnDeath() return false end



modifier_custom_sonic_damage_arcana_visual = class({})
function modifier_custom_sonic_damage_arcana_visual:IsHidden() return true end
function modifier_custom_sonic_damage_arcana_visual:IsPurgable() return false end
function modifier_custom_sonic_damage_arcana_visual:IsPurgeException() return false end
function modifier_custom_sonic_damage_arcana_visual:GetStatusEffectName()
    return "particles/status_fx/status_effect_qop_tgt_arcana.vpcf"
end
function modifier_custom_sonic_damage_arcana_visual:StatusEffectPriority()
    return MODIFIER_PRIORITY_ULTRA 
end



modifier_custom_sonic_legendary_stack = class({})
function modifier_custom_sonic_legendary_stack:IsHidden() return false end
function modifier_custom_sonic_legendary_stack:IsPurgable() return false end
function modifier_custom_sonic_legendary_stack:RemoveOnDeath() return false end
function modifier_custom_sonic_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.parent:GetTalentValue("modifier_queen_sonic_7", "max", true)
self.damage = self.parent:GetTalentValue("modifier_queen_sonic_7", "damage_inc", true)/self.max
self.cd = self.parent:GetTalentValue("modifier_queen_sonic_7", "cd_inc", true)/self.max
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_custom_sonic_legendary_stack:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
if self:GetStackCount() < self.max then return end

self.parent:GenericParticle("particles/brist_lowhp_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
end

function modifier_custom_sonic_legendary_stack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP,
	MODIFIER_PROPERTY_TOOLTIP2
}
end

function modifier_custom_sonic_legendary_stack:OnTooltip()
return self.damage*self:GetStackCount()
end

function modifier_custom_sonic_legendary_stack:OnTooltip2()
return self.cd*self:GetStackCount()
end	



modifier_custom_sonic_heal_reduce = class({})
function modifier_custom_sonic_heal_reduce:IsHidden() return true end
function modifier_custom_sonic_heal_reduce:IsPurgable() return false end
function modifier_custom_sonic_heal_reduce:OnCreated()
self.heal_reduce = self:GetCaster():GetTalentValue("modifier_queen_sonic_1", "heal_reduce")
end

function modifier_custom_sonic_heal_reduce:DeclareFunctions()
return 
{
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end


function modifier_custom_sonic_heal_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_custom_sonic_heal_reduce:GetModifierHealChange()
return self.heal_reduce
end

function modifier_custom_sonic_heal_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end



modifier_custom_sonic_cdr_perma = class({})
function modifier_custom_sonic_cdr_perma:IsHidden() return not self:GetCaster():HasTalent("modifier_queen_sonic_6") end
function modifier_custom_sonic_cdr_perma:IsPurgable() return false end
function modifier_custom_sonic_cdr_perma:RemoveOnDeath() return false end
function modifier_custom_sonic_cdr_perma:GetTexture() return "buffs/wrath_perma" end
function modifier_custom_sonic_cdr_perma:OnCreated(table)
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_queen_sonic_6", "max", true)
self.cdr = self.parent:GetTalentValue("modifier_queen_sonic_6", "cdr", true)/self.max

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_custom_sonic_cdr_perma:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_queen_sonic_6") then return end

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_custom_sonic_cdr_perma:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

end


function modifier_custom_sonic_cdr_perma:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_custom_sonic_cdr_perma:GetModifierPercentageCooldown() 
if not self.parent:HasTalent("modifier_queen_sonic_6") then return end
return self:GetStackCount()*self.cdr
end
