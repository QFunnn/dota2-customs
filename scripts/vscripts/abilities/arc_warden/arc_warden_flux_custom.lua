--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_arc_warden_flux_custom", "abilities/arc_warden/arc_warden_flux_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_arc_warden_flux_custom_legendary", "abilities/arc_warden/arc_warden_flux_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_arc_warden_flux_custom_legendary_cd", "abilities/arc_warden/arc_warden_flux_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_arc_warden_flux_custom_legendary_tempest_cd", "abilities/arc_warden/arc_warden_flux_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_arc_warden_flux_custom_count", "abilities/arc_warden/arc_warden_flux_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_arc_warden_flux_custom_resist", "abilities/arc_warden/arc_warden_flux_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_arc_warden_flux_custom_tracker", "abilities/arc_warden/arc_warden_flux_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_arc_warden_flux_custom_silence", "abilities/arc_warden/arc_warden_flux_custom", LUA_MODIFIER_MOTION_NONE )

arc_warden_flux_custom = class({})
arc_warden_flux_custom.talents = {}
arc_warden_flux_custom.active_mod = nil
arc_warden_flux_custom.shield_mod = nil

function arc_warden_flux_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_flux_tempest_tgt.vpcf", context )
PrecacheResource( "particle", "particles/arc_warden/flux_self.vpcf", context )
PrecacheResource( "particle", "particles/arc_warden/flux_self_tempest.vpcf", context )
PrecacheResource( "particle", "particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle", "particles/items_fx/harpoon_pull.vpcf", context )
PrecacheResource( "particle", "particles/zuus_speed.vpcf", context )
PrecacheResource( "particle", "particles/void_astral_slow.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/generic_silenced.vpcf", context )
PrecacheResource( "particle", "particles/ta_trap_damage.vpcf", context )
end

function arc_warden_flux_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_damage = 0,
    q1_spell = 0,
    
    has_q2 = 0,
    q2_slow = 0,
    q2_cd = 0,
    
    has_q3 = 0,
    q3_resist = 0,
    q3_heal_reduce = 0,
    q3_max = caster:GetTalentValue("modifier_arc_warden_flux_3", "max", true),
    q3_duration = caster:GetTalentValue("modifier_arc_warden_flux_3", "duration", true),
    q3_stack = caster:GetTalentValue("modifier_arc_warden_flux_3", "stack", true),
    
    has_q4 = 0,
    q4_shield = caster:GetTalentValue("modifier_arc_warden_flux_4", "shield", true)/100,
    q4_heal = caster:GetTalentValue("modifier_arc_warden_flux_4", "heal", true),
    q4_duration = caster:GetTalentValue("modifier_arc_warden_flux_4", "duration", true),
    q4_shield_max = caster:GetTalentValue("modifier_arc_warden_flux_4", "shield_max", true)/100,
    
    has_q7 = 0,
    q7_radius = caster:GetTalentValue("modifier_arc_warden_flux_7", "radius", true),
    q7_interval = caster:GetTalentValue("modifier_arc_warden_flux_7", "interval", true),
    
    has_h1 = 0,
    h1_cast_range = 0,
    h1_cdr = 0,
    
    has_h4 = 0,
    h4_silence = caster:GetTalentValue("modifier_arc_warden_hero_4", "silence", true),
    h4_cast = caster:GetTalentValue("modifier_arc_warden_hero_4", "cast", true),
    h4_attack_slow = caster:GetTalentValue("modifier_arc_warden_hero_4", "attack_slow", true),
  }
end

if caster:HasTalent("modifier_arc_warden_flux_1") then
  self.talents.has_q1 = 1
  self.talents.q1_damage = caster:GetTalentValue("modifier_arc_warden_flux_1", "damage")/100
  self.talents.q1_spell = caster:GetTalentValue("modifier_arc_warden_flux_1", "spell")
end

if caster:HasTalent("modifier_arc_warden_flux_2") then
  self.talents.has_q2 = 1
  self.talents.q2_slow = caster:GetTalentValue("modifier_arc_warden_flux_2", "slow")
  self.talents.q2_cd = caster:GetTalentValue("modifier_arc_warden_flux_2", "cd")
end

if caster:HasTalent("modifier_arc_warden_flux_3") then
  self.talents.has_q3 = 1
  self.talents.q3_resist = caster:GetTalentValue("modifier_arc_warden_flux_3", "resist")
  self.talents.q3_heal_reduce = caster:GetTalentValue("modifier_arc_warden_flux_3", "heal_reduce")
end

if caster:HasTalent("modifier_arc_warden_flux_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_arc_warden_flux_7") then
  self.talents.has_q7 = 1
end

if caster:HasTalent("modifier_arc_warden_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_cast_range = caster:GetTalentValue("modifier_arc_warden_hero_1", "cast_range")
  self.talents.h1_cdr = caster:GetTalentValue("modifier_arc_warden_hero_1", "cdr")
end

if caster:HasTalent("modifier_arc_warden_hero_4") then
  self.talents.has_h4 = 1
end

end

function arc_warden_flux_custom:Init()
self.caster = self:GetCaster()
end

function arc_warden_flux_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_arc_warden_flux_custom_tracker"
end 

function arc_warden_flux_custom:GetBehavior()
if self.talents.has_q7 == 1 then
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT
end
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function arc_warden_flux_custom:GetAOERadius()
return self.talents.q7_radius and self.talents.q7_radius or 0
end

function arc_warden_flux_custom:GetCooldown(level)
return self.BaseClass.GetCooldown(self, level)  + (self.talents.q2_cd and self.talents.q2_cd or 0)
end

function arc_warden_flux_custom:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self) + (self.talents.has_h4 == 1 and self.talents.h4_cast or 0)
end

function arc_warden_flux_custom:GetAbilityTextureName()
if self.caster:HasModifier("modifier_arc_warden_tempest_double") then
	return "arc_warden_flux_tempest"
end
return "arc_warden_flux"
end

function arc_warden_flux_custom:CastFilterResultTarget(target)
local type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
local team = DOTA_UNIT_TARGET_TEAM_ENEMY
local flags = 0
if self.talents.has_q7 == 1 then
	team = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	type = DOTA_UNIT_TARGET_HERO
	flags = DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
end
if target:HasModifier("modifier_arc_warden_flux_custom_legendary") then
	return UF_FAIL_OTHER
end
return UnitFilter(target, team, type, flags, self.caster:GetTeamNumber() )
end

function arc_warden_flux_custom:OnSpellStart()
local target = self:GetCursorTarget()

if target and target:GetTeamNumber() ~= self.caster:GetTeamNumber() then
	if target:TriggerSpellAbsorb(self) then return end 
end

local duration = self:GetSpecialValueFor("duration")
local caster_mod = nil
local target_mod = nil

self.caster:EmitSound("Hero_ArcWarden.Flux.Cast")

if self.caster.spark_ability then
	self.caster.spark_ability:ApplySpeed(true)
end

if self.talents.has_q7 == 1 then 
	local point = self:GetCursorPosition()
	if target then
		point = target:GetAbsOrigin()
		caster_mod = target:AddNewModifier(self.caster, self, "modifier_arc_warden_flux_custom_legendary", {duration = duration})
	else
		caster_mod = CreateModifierThinker(self.caster, self, "modifier_arc_warden_flux_custom_legendary", {duration = duration}, point, self.caster:GetTeamNumber(), false)
	end

	local qangle_rotation_rate = 60
	local line_position = point + self.caster:GetForwardVector() * 350
	for i = 1, 6 do
		local qangle = QAngle(0, qangle_rotation_rate, 0)
		line_position = RotatePosition(point, qangle, line_position)

		local cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
		ParticleManager:SetParticleControlEnt(cast_particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(cast_particle, 1, line_position)
		ParticleManager:SetParticleControlEnt(cast_particle, 2, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(cast_particle)
	end
else
	target_mod = target:AddNewModifier(self.caster, self, "modifier_arc_warden_flux_custom", {duration = duration, is_legendary = 0})

	for _,aoe_target in pairs(self.caster:FindTargets(self.aoe_radius, target:GetAbsOrigin())) do
		if aoe_target ~= target and aoe_target:IsCreep() then
			aoe_target:AddNewModifier(self.caster, self, "modifier_arc_warden_flux_custom", {duration = duration, is_legendary = 0, is_aoe = 1})
		end
	end

	local cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
	ParticleManager:SetParticleControlEnt(cast_particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1", self.caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(cast_particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(cast_particle, 2, self.caster, PATTACH_POINT_FOLLOW, "attach_attack2", self.caster:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(cast_particle)
	target:EmitSound("Hero_ArcWarden.Flux.Target")
	self.caster:MoveToTargetToAttack(target)

	if self.talents.has_h4 == 1 then
		target:EmitSound("Sf.Raze_silence")
		target:AddNewModifier(self.caster, self, "modifier_arc_warden_flux_custom_silence", {duration = (1 - target:GetStatusResistance())*self.talents.h4_silence})
	end
end

end

function arc_warden_flux_custom:ApplyResist(target, stack)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_q3 == 0 then return end

target:AddNewModifier(self.caster, self, "modifier_arc_warden_flux_custom_resist", {duration = self.talents.q3_duration, stack = stack})
end

function arc_warden_flux_custom:ApplyHeal(target, effect)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_q4 == 0 then return end
if not target:IsAlive() then return end

local shield = target:GetMaxHealth()*self.talents.q4_shield
local max = target:GetMaxHealth()*self.talents.q4_shield_max
if effect then
	target:GenericParticle("particles/arc_warden/spark_heall.vpcf")
end

if not IsValid(target.flux_shield_mod) then
	target.flux_shield_mod = target:AddNewModifier(target, self, "modifier_generic_shield",
	{
		duration = self.talents.q4_duration,
		max_shield = max,
		shield_talent = "modifier_arc_warden_flux_4",
		health_regen = self.talents.q4_heal
	})
	if target.flux_shield_mod then
		target:GenericParticle("particles/generic_gameplay/rune_arcane_owner.vpcf", target.flux_shield_mod)
	end
end

if target.flux_shield_mod then
	target.flux_shield_mod:AddShield(shield, max)
	target.flux_shield_mod:SetDuration(self.talents.q4_duration, true)
end

end

modifier_arc_warden_flux_custom = class({})
function modifier_arc_warden_flux_custom:IsPurgable() return self.ability.talents.has_q7 == 1 end
function modifier_arc_warden_flux_custom:IsHidden() return true end 
function modifier_arc_warden_flux_custom:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_arc_warden_flux_custom:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.think_interval	= self.ability:GetSpecialValueFor("think_interval")
self.search_radius = self.ability:GetSpecialValueFor("search_radius")
self.move_speed_slow_pct	= self.ability:GetSpecialValueFor("move_speed_slow_pct") + self.ability.talents.q2_slow
self.damage_per_interval	= self.ability:GetSpecialValueFor("damage_per_second") + self.caster:GetMaxHealth()*self.ability.talents.q1_damage
self.damage_per_interval = self.damage_per_interval * self.think_interval

local duration = self.ability:GetSpecialValueFor("duration")

if IsServer() then
	self:SetStackCount(self.move_speed_slow_pct*(1 - self.parent:GetStatusResistance()))
end

self.move_speed_slow_pct = self:GetStackCount()

if not IsServer() then return end

if self.ability.talents.has_q7 == 0 and not table.is_aoe then
	self.switch = true
	self.ability:EndCd()
end

self.damage_ability = table.is_legendary == 1 and "modifier_arc_warden_flux_7" or nil

self.damageTable = {victim = self.parent, damage = self.damage_per_interval, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self.caster, ability	= self.ability}
self.parent:AddNewModifier(self.caster, self.ability, "modifier_arc_warden_flux_custom_count", {duration = duration})

self.flux_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.flux_particle, 2, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), true)
self:AddParticle(self.flux_particle, false, false, -1, false, false)

self.count = 0
self.max = duration/self.think_interval + 1

self:StartIntervalThink(FrameTime())
end

function modifier_arc_warden_flux_custom:OnIntervalThink()
if not IsServer() then return end 
self:SetStackCount(0)

local no_near = true 

if self.ability.talents.has_q7 == 0 and not self.parent:IsCreep() then
	local units = self.caster:FindTargets(self.search_radius, self.parent:GetAbsOrigin())
	for _,unit in pairs(units) do 
		if unit ~= self.parent then 
			no_near = false
			break
		end 
	end 
end

if no_near == true then
	ParticleManager:SetParticleControl(self.flux_particle, 4, Vector(1, 0, 0))
	DoDamage(self.damageTable, self.damage_ability)
else
	ParticleManager:SetParticleControl(self.flux_particle, 4, Vector(0, 0, 0))
end

self.count = self.count + 1 

if self.count >= self.max then
	self:Destroy()
	return 
end

self:StartIntervalThink(self.think_interval)
end

function modifier_arc_warden_flux_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_arc_warden_flux_custom:GetModifierMoveSpeedBonus_Percentage()
return self.move_speed_slow_pct
end

function modifier_arc_warden_flux_custom:OnDestroy()
if not IsServer() then return end 

if self.switch then
	self.ability:StartCd()
end

local mod = self.parent:FindModifierByName("modifier_arc_warden_flux_custom_count")
if not mod then return end 
mod:DecrementStackCount() 

if mod:GetStackCount() <= 0 then 
	mod:Destroy()
end

end 

modifier_arc_warden_flux_custom_count = class(mod_visible)
function modifier_arc_warden_flux_custom_count:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end 
self:SetStackCount(1)
self.think_interval = 1

self.tracker = self.ability.tracker
if self.caster.owner and self.caster.flux_ability then
	self.tracker = self.caster.owner.flux_ability.tracker
end
self.tracker:UpdateMod(self)

self:StartIntervalThink(self.think_interval - FrameTime())
end 

function modifier_arc_warden_flux_custom_count:OnRefresh(table)
if not IsServer() then return end 
self:IncrementStackCount()
end 

function modifier_arc_warden_flux_custom_count:OnDestroy()
if not IsServer() then return end
if not self.tracker then return end
self.tracker:UpdateMod(self, true)
end

function modifier_arc_warden_flux_custom_count:OnIntervalThink()
if not IsServer() then return end 

local hero = self.caster
if hero:IsTempestDouble() and hero.owner then 
	hero = hero.owner
end

if hero:GetQuest() == "Arc.Quest_5" and self.parent:IsRealHero() and not hero:QuestCompleted() then 
	hero:UpdateQuest(self.think_interval)
end

if self.ability.talents.has_q3 == 1 then
	self.ability:ApplyResist(self.parent, 1)
end

end



modifier_arc_warden_flux_custom_legendary = class(mod_visible)
function modifier_arc_warden_flux_custom_legendary:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.cd = self.ability.talents.q7_interval - 0.1
self.duration = self.ability:GetSpecialValueFor("duration")

if not IsServer() then return end
self.ability:EndCd()

self.parent:EmitSound("Hero_ArcWarden.Flux.Target")
self.part = "particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf"
self.part_2 = "particles/arc_warden/flux_self.vpcf"
self.cd_mod = "modifier_arc_warden_flux_custom_legendary_cd"

if self.caster:HasModifier("modifier_arc_warden_tempest_double") then
	self.part = "particles/units/heroes/hero_arc_warden/arc_warden_flux_tempest_tgt.vpcf"
	self.part_2 = "particles/arc_warden/flux_self_tempest.vpcf"
	self.cd_mod = "modifier_arc_warden_flux_custom_legendary_tempest_cd"
end

self.radius = self.ability.talents.q7_radius

self.flux_particle = ParticleManager:CreateParticle(self.part, PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.flux_particle, 2, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(self.flux_particle, 4, Vector(1, 0, 0))
self:AddParticle(self.flux_particle, false, false, -1, false, false)

local effect_cast = ParticleManager:CreateParticle( self.part_2, PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius*0.9, 1, 1 ) )
self:AddParticle( effect_cast, false, false, -1, false, false )

self.interval = 0.05

self:OnIntervalThink(true)
self:StartIntervalThink(self.interval)
end 


function modifier_arc_warden_flux_custom_legendary:OnIntervalThink(first)
if not IsServer() then return end 

for _,unit in pairs(self.caster:FindTargets(self.radius, self.parent:GetAbsOrigin())) do 
	if not unit:HasModifier(self.cd_mod) then 
		unit:AddNewModifier(self.caster, self.ability, self.cd_mod, {duration = self.cd})

		self.parent:EmitSound("Hero_ArcWarden.Flux.Cast")
		unit:EmitSound("Hero_ArcWarden.Flux.Target")

		local cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
		ParticleManager:SetParticleControl(cast_particle, 0, self.parent:GetAbsOrigin() + Vector(0, 0, 75))
		ParticleManager:SetParticleControlEnt(cast_particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(cast_particle, 2, self.parent:GetAbsOrigin() + Vector(0, 0, 75))
		ParticleManager:ReleaseParticleIndex(cast_particle)

		unit:AddNewModifier(self.caster, self.ability, "modifier_arc_warden_flux_custom", {duration = self.duration, is_legendary = 1})

		if self.ability.talents.has_h4 == 1 and first then
			unit:EmitSound("Sf.Raze_silence")
			unit:AddNewModifier(self.caster, self.ability, "modifier_arc_warden_flux_custom_silence", {duration = (1 - unit:GetStatusResistance())*self.ability.talents.h4_silence})
		end
	end 
end 

end

function modifier_arc_warden_flux_custom_legendary:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
end


modifier_arc_warden_flux_custom_legendary_cd = class(mod_hidden)
modifier_arc_warden_flux_custom_legendary_tempest_cd = class(mod_hidden)


modifier_arc_warden_flux_custom_tracker = class(mod_hidden)
function modifier_arc_warden_flux_custom_tracker:RemoveOnDeath() return false end
function modifier_arc_warden_flux_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.aoe_count = self.ability:GetSpecialValueFor("aoe_count")
self.ability.aoe_radius = self.ability:GetSpecialValueFor("aoe_radius")

self.parent.flux_ability = self.ability
self.active_mods = {}
self.current_think = false
end 

function modifier_arc_warden_flux_custom_tracker:UpdateMod(mod, remove)
if not IsServer() then return end
if self.ability.talents.has_q4 == 0 then return end
if self.parent:IsIllusion() or self.parent:IsTempestDouble() then return end

if remove then
	self.active_mods[mod] = nil
else
	self.active_mods[mod] = true
end

local has_mod = false
for check_mod,_ in pairs(self.active_mods) do
	if IsValid(check_mod) then
		has_mod = true
	else
		self.active_mods[check_mod] = nil
	end
end

if has_mod then
	if not self.current_think then
		self.current_think = true
		self:StartIntervalThink(1)
	end
else
	self.current_think = false
	self:StartIntervalThink(-1)
end

end

function modifier_arc_warden_flux_custom_tracker:OnIntervalThink()
if not IsServer() then return end

self.ability:ApplyHeal(self.parent)
local heal_target = self.parent:GetTempest()
if heal_target then
	self.ability:ApplyHeal(heal_target)
end

end

function modifier_arc_warden_flux_custom_tracker:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
}
end

function modifier_arc_warden_flux_custom_tracker:GetModifierPercentageCooldown()
return self.ability.talents.h1_cdr
end

function modifier_arc_warden_flux_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end

function modifier_arc_warden_flux_custom_tracker:GetModifierCastRangeBonusStacking()
return self.ability.talents.h1_cast_range
end



modifier_arc_warden_flux_custom_resist = class(mod_visible)
function modifier_arc_warden_flux_custom_resist:GetTexture() return "buffs/arc_warden/flux_3" end
function modifier_arc_warden_flux_custom_resist:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.q3_max
self.resist = self.ability.talents.q3_resist/self.max
self.heal_reduce = self.ability.talents.q3_heal_reduce/self.max

if not IsServer() then return end
self:AddStack(table.stack)
end

function modifier_arc_warden_flux_custom_resist:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table.stack)
end

function modifier_arc_warden_flux_custom_resist:AddStack(stack)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:SetStackCount(math.min(self.max, self:GetStackCount() + stack))

if self:GetStackCount() >= self.max then 
  self.parent:GenericParticle("particles/enigma/summon_spell_damage.vpcf", self, true)
  self.parent:GenericParticle("particles/items4_fx/spirit_vessel_damage.vpcf", self)
  self.parent:EmitSound("Arc.Flux_resist_max")
end 

end 

function modifier_arc_warden_flux_custom_resist:DeclareFunctions()
return 
{ 
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_arc_warden_flux_custom_resist:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce*self:GetStackCount()
end

function modifier_arc_warden_flux_custom_resist:GetModifierHealChange()
return self.heal_reduce*self:GetStackCount()
end

function modifier_arc_warden_flux_custom_resist:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce*self:GetStackCount()
end

function modifier_arc_warden_flux_custom_resist:GetModifierMagicalResistanceBonus()
return self.resist*self:GetStackCount()
end 


modifier_arc_warden_flux_custom_silence = class(mod_hidden)
function modifier_arc_warden_flux_custom_silence:IsPurgable() return true end
function modifier_arc_warden_flux_custom_silence:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
end

function modifier_arc_warden_flux_custom_silence:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_arc_warden_flux_custom_silence:GetModifierAttackSpeedBonus_Constant()
return self.ability.talents.h4_attack_slow
end

function modifier_arc_warden_flux_custom_silence:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
}
end

function modifier_arc_warden_flux_custom_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_arc_warden_flux_custom_silence:ShouldUseOverheadOffset() return true end
function modifier_arc_warden_flux_custom_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end