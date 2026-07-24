--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom", "abilities/drow_ranger/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_silence", "abilities/drow_ranger/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_tracker", "abilities/drow_ranger/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_speed", "abilities/drow_ranger/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_blink", "abilities/drow_ranger/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_attacks", "abilities/drow_ranger/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_NONE )


drow_ranger_wave_of_silence_custom = class({})
drow_ranger_wave_of_silence_custom.talents = {}

function drow_ranger_wave_of_silence_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/drow_ranger/frost_legendary_hit_2.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/silence_legendary_damage.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/silence_legendary_speed.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/silence_legendary_speed_start.vpcf", context )
PrecacheResource( "particle", "particles/zuus_speed.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/drow/drow_arcana/drow_arcana_item_force_staff.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/silence_proc_damage.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/silence_burn.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_crystal_clone_movement.vpcf", context )

end

function drow_ranger_wave_of_silence_custom:UpdateTalents()
local caster = self:GetCaster()

if not self.init then
	self.init = true
	self.talents =
	{
	  has_damage = 0,
	  damage_inc = 0,
	  damage_spell = 0,

	  cd_inc = 0,
	  cast_inc = 0,

	  has_w3 = 0,
	  w3_damage = 0,
	  w3_damage_creeps = 0,
	  w3_heal = caster:GetTalentValue("modifier_drow_gust_3", "heal", true)/100,
	  w3_radius = caster:GetTalentValue("modifier_drow_gust_3", "aoe", true),
	  w3_damage_type = caster:GetTalentValue("modifier_drow_gust_3", "damage_type", true),
	  w3_duration = caster:GetTalentValue("modifier_drow_gust_3", "duration", true),
	  w3_max = caster:GetTalentValue("modifier_drow_gust_3", "max", true),

	  has_w7 = 0,
	  w7_mana = caster:GetTalentValue("modifier_drow_gust_7", "mana", true)/100,

	  has_move = 0,
	  move_duration = caster:GetTalentValue("modifier_drow_hero_2", "duration", true),

	  has_stun = 0,
	  stun_knock = 0,
	  stun_silence = caster:GetTalentValue("modifier_drow_hero_5", "silence", true),
	}
end

if caster:HasTalent("modifier_drow_gust_1") then
	self.talents.has_damage = 1
	self.talents.damage_inc = caster:GetTalentValue("modifier_drow_gust_1", "damage")
	self.talents.damage_spell = caster:GetTalentValue("modifier_drow_gust_1", "spell")
end

if caster:HasTalent("modifier_drow_gust_2") then
	self.talents.cd_inc = caster:GetTalentValue("modifier_drow_gust_2", "cd")
	self.talents.cast_inc = caster:GetTalentValue("modifier_drow_gust_2", "cast")
end

if caster:HasTalent("modifier_drow_hero_2") then
	self.talents.has_move = 1
end

if caster:HasTalent("modifier_drow_gust_3") then
	self.talents.has_w3 = 1
	self.talents.w3_damage = caster:GetTalentValue("modifier_drow_gust_3", "damage")/100
	self.talents.w3_damage_creeps = caster:GetTalentValue("modifier_drow_gust_3", "damage_creeps")
	caster:AddAttackEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_drow_hero_5") then
	self.talents.has_stun = 1
	self.talents.stun_knock = caster:GetTalentValue("modifier_drow_hero_5", "duration")
end

if caster:HasTalent("modifier_drow_gust_7") then
	self.talents.has_w7 = 1
end

end

function drow_ranger_wave_of_silence_custom:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "drow_ranger_wave_of_silence", self)
end

function drow_ranger_wave_of_silence_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_drow_ranger_wave_of_silence_custom_tracker"
end

function drow_ranger_wave_of_silence_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self, level)*(1 + (self.talents.has_w7 == 1 and self.talents.w7_mana or 0))
end

function drow_ranger_wave_of_silence_custom:GetCooldown(level) 
return self.BaseClass.GetCooldown( self, level ) + (self.talents.cd_inc and self.talents.cd_inc or 0)
end

function drow_ranger_wave_of_silence_custom:GetCastPoint()
return self.BaseClass.GetCastPoint(self)  + (self.talents.cast_inc and self.talents.cast_inc or 0)
end

function drow_ranger_wave_of_silence_custom:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()
local illusion = 0
local visual_caster = caster

local origin = visual_caster:GetAbsOrigin()

self.can_legendary_cd = true

if self.talents.has_move == 1 then
	caster:RemoveModifierByName("modifier_drow_ranger_wave_of_silence_custom_speed")
	caster:AddNewModifier(caster, self, "modifier_drow_ranger_wave_of_silence_custom_speed", {duration = self.talents.move_duration})
end

if self.talents.has_w3 == 1 then
	caster:RemoveModifierByName("modifier_drow_ranger_wave_of_silence_custom_attacks")
	caster:AddNewModifier(caster, self, "modifier_drow_ranger_wave_of_silence_custom_attacks", {duration = self.talents.w3_duration})
end

if self.tracker and self.tracker.blink_ability then
	self.tracker.blink_ability:EndCd(0)
end

if point == origin then 
	point = origin + visual_caster:GetForwardVector()*10
end 

local speed = self.wave_speed
local width = self.wave_width

local projectile_distance = self:GetCastRange( point, nil )
local projectile_direction = point-origin
projectile_direction.z = 0
projectile_direction = projectile_direction:Normalized()

local proj_particle = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_drow/drow_silence_wave.vpcf", self)

local info = {
	Source = visual_caster,
	Ability = self,
	vSpawnOrigin = origin,

	bDeleteOnHit = false,

	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

	EffectName = proj_particle,
	fDistance = projectile_distance,
	fStartRadius = width,
	fEndRadius = width,
	vVelocity = projectile_direction * speed,
	
	ExtraData = {
		x = origin.x,
		y = origin.y,
		source = source,
	}
}
ProjectileManager:CreateLinearProjectile(info)
visual_caster:EmitSound("Hero_DrowRanger.Silence")
end


function drow_ranger_wave_of_silence_custom:OnProjectileHit_ExtraData( target, location, data )
if not target then return end

local caster = self:GetCaster()
local silence = self.silence_duration
local max_dist = self.knockback_distance_max
local damage = self.damage + self.talents.damage_inc
local damage_ability = data.source
local stun = self.talents.has_stun == 1

silence = silence*(1 - target:GetStatusResistance())

local vec = target:GetOrigin()-Vector(data.x,data.y,0)
vec.z = 0
local distance = vec:Length2D()
local dist_k = (1- distance/self:GetCastRange( Vector(0,0,0), nil ))
distance = dist_k*max_dist
duration = (self.knockback_min + (self.knockback_duration - self.knockback_min)*dist_k) + self.talents.stun_knock
duration = duration*(1 - target:GetStatusResistance())

if max_dist<0 then 
	distance = 0 
end

vec = vec:Normalized()

if stun then
	target:AddNewModifier(caster, self, "modifier_stunned", {duration = duration})
end

if not target:IsDebuffImmune() then 
	local mod = target:AddNewModifier( caster, self, "modifier_generic_knockback",
	{	
		direction_x = vec.x,
		direction_y = vec.y,
		distance = distance,
		height = 0,	
		duration = duration,
		IsStun = false,
		IsFlail = true,
		Purgable = 1,
	})
end

self:PlayEffects( target )

target:RemoveModifierByName("modifier_drow_ranger_wave_of_silence_custom_silence")
target:AddNewModifier(caster, self, "modifier_drow_ranger_wave_of_silence_custom_silence", {main_cast = 1, duration = silence})
DoDamage({victim = target, attacker = caster, ability = self, damage_type = DAMAGE_TYPE_MAGICAL, damage = damage}, damage_ability)
end

function drow_ranger_wave_of_silence_custom:PlayEffects( target )
local caster = self:GetCaster()
local effect_silence = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_drow/drow_hero_silence.vpcf", self)
target:GenericParticle(effect_silence)
end


function drow_ranger_wave_of_silence_custom:ProcDamage(target, is_aoe)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_w3 == 0 then return end

local caster = self:GetCaster()

local damageTable = {attacker = caster, ability = self, damage_type = self.talents.w3_damage_type}
local heal = 0

damageTable.damage = target:IsCreep() and self.talents.w3_damage_creeps or self.talents.w3_damage*target:GetMaxHealth()


for _,aoe_target in pairs(caster:FindTargets(self.talents.w3_radius, target:GetAbsOrigin())) do
	if is_aoe or aoe_target == target then
		damageTable.victim = aoe_target
		local real_damage = DoDamage(damageTable, "modifier_drow_gust_3")
		if aoe_target == target then
			local result = caster:CanLifesteal(aoe_target)
			if result then
				heal = result*real_damage*self.talents.w3_heal
			end
			target:SendNumber(6, real_damage)
			target:EmitSound("Drow.Silence_damage")
			target:GenericParticle("particles/drow_ranger/silence_proc_damage.vpcf")
		end
	end
end


if heal > 0 then
	caster:GenericHeal(heal, self, true, "particles/drow_ranger/frost_heal.vpcf", "modifier_drow_gust_3")
end

end


modifier_drow_ranger_wave_of_silence_custom_tracker = class(mod_hidden)
function modifier_drow_ranger_wave_of_silence_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.gust_ability = self.ability

self.blink_ability = self.parent:FindAbilityByName("drow_ranger_wave_of_silence_custom_blink")
self.frost_ability = self.parent:FindAbilityByName("drow_ranger_frost_arrows_custom")

if self.blink_ability then
	self.blink_ability:UpdateTalents()
end

self.ability.wave_speed = self.ability:GetSpecialValueFor("wave_speed")            
self.ability.wave_width = self.ability:GetSpecialValueFor("wave_width")               
self.ability.knockback_distance_max = self.ability:GetSpecialValueFor("knockback_distance_max")
self.ability.silence_duration = self.ability:GetSpecialValueFor("silence_duration")   
self.ability.knockback_duration = self.ability:GetSpecialValueFor("knockback_duration")
self.ability.knockback_min = self.ability:GetSpecialValueFor("knockback_min")     
self.ability.wave_length = self.ability:GetSpecialValueFor("wave_length")          
self.ability.damage = self.ability:GetSpecialValueFor("damage")         
end

function modifier_drow_ranger_wave_of_silence_custom_tracker:OnRefresh()
self.ability.silence_duration = self.ability:GetSpecialValueFor("silence_duration")   
self.ability.knockback_duration = self.ability:GetSpecialValueFor("knockback_duration")  
self.ability.knockback_min = self.ability:GetSpecialValueFor("knockback_min")      
self.ability.damage = self.ability:GetSpecialValueFor("damage")
end

function modifier_drow_ranger_wave_of_silence_custom_tracker:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_drow_ranger_wave_of_silence_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.damage_spell
end

function modifier_drow_ranger_wave_of_silence_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end 
if self.ability.talents.has_w3 == 0 then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end

local mod = self.parent:FindModifierByName("modifier_drow_ranger_wave_of_silence_custom_attacks")
if not mod then return end
mod:DecrementStackCount()
if mod:GetStackCount() <= 0 then
	mod:Destroy()
end

self.ability:ProcDamage(params.target, true)
end 



drow_ranger_wave_of_silence_custom_blink = class({})

function drow_ranger_wave_of_silence_custom_blink:CreateTalent()
self:SetHidden(false)
end

function drow_ranger_wave_of_silence_custom_blink:UpdateTalents()
local caster = self:GetCaster()

if not self.init and caster:HasTalent("modifier_drow_gust_4") then
	self.init = true
	if IsServer() and not self:IsTrained() then
		self:SetLevel(1)
	end
	self.range = caster:GetTalentValue("modifier_drow_gust_4", "range", true)
	self.cd = caster:GetTalentValue("modifier_drow_gust_4", "talent_cd", true)
	self.duration = caster:GetTalentValue("modifier_drow_gust_4", "duration", true)
	self.mana = caster:GetTalentValue("modifier_drow_gust_4", "mana", true)
end

end

function drow_ranger_wave_of_silence_custom_blink:GetCastRange(vLocation, hTarget)
if IsServer() then return 99999 end
return (self.range and self.range or 0) - self:GetCaster():GetCastRangeBonus()
end

function drow_ranger_wave_of_silence_custom_blink:GetManaCost(iLevel)
return self.mana and self.mana or 0
end

function drow_ranger_wave_of_silence_custom_blink:GetCooldown()
return self.cd and self.cd or 0
end

function drow_ranger_wave_of_silence_custom_blink:OnSpellStart()
local caster = self:GetCaster()

local point = self:GetCursorPosition()
local dir = (point - caster:GetAbsOrigin()):Normalized()
if point == caster:GetAbsOrigin() then
  dir = caster:GetForwardVector()
end
dir.z = 0

point = caster:GetAbsOrigin() + dir*self.range

caster:EmitSound("Drow.Silence_blink")
caster:EmitSound("Drow.Silence_blink2")
caster:AddNewModifier(caster, self, "modifier_drow_ranger_wave_of_silence_custom_blink", {duration = self.duration, x = point.x, y = point.y})
end



modifier_drow_ranger_wave_of_silence_custom_blink = class(mod_hidden)
function modifier_drow_ranger_wave_of_silence_custom_blink:OnCreated(params)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_1)

self.parent:EmitSound("Hero_Crystal.CrystalClone.Cast")
self.parent:GenericParticle("particles/units/heroes/hero_crystalmaiden/maiden_crystal_clone_movement.vpcf", self)
self.point = GetGroundPosition(Vector(params.x, params.y, 0), nil)

self.dir = (self.point - self.parent:GetAbsOrigin())
self.dir.z = 0
self.distance = self.dir:Length2D() / self:GetDuration()

if self:ApplyHorizontalMotionController() == false then
  self:Destroy()
end

end

function modifier_drow_ranger_wave_of_silence_custom_blink:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DISABLE_TURNING
}
end

function modifier_drow_ranger_wave_of_silence_custom_blink:GetModifierDisableTurning() return 1 end
function modifier_drow_ranger_wave_of_silence_custom_blink:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_drow_ranger_wave_of_silence_custom_blink:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end

function modifier_drow_ranger_wave_of_silence_custom_blink:OnDestroy()
if not IsServer() then return end
self.parent:InterruptMotionControllers( true )
local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end

function modifier_drow_ranger_wave_of_silence_custom_blink:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)
self.parent:SetAbsOrigin(GetGroundPosition(pos + self.dir:Normalized() * self.distance * dt,self.parent))
end

function modifier_drow_ranger_wave_of_silence_custom_blink:OnHorizontalMotionInterrupted()
self:Destroy()
end




modifier_drow_ranger_wave_of_silence_custom_speed = class(mod_visible)
function modifier_drow_ranger_wave_of_silence_custom_speed:GetTexture() return "buffs/drow_ranger/hero_2" end
function modifier_drow_ranger_wave_of_silence_custom_speed:OnCreated() 
self.parent = self:GetParent()
self.parent:GenericParticle("particles/drow_ranger/silence_legendary_speed.vpcf", self )
self.parent:GenericParticle("particles/drow_ranger/silence_legendary_speed_start.vpcf")
end



modifier_drow_ranger_wave_of_silence_custom_silence = class({})
function modifier_drow_ranger_wave_of_silence_custom_silence:IsHidden() return false end
function modifier_drow_ranger_wave_of_silence_custom_silence:IsPurgable() return true end
function modifier_drow_ranger_wave_of_silence_custom_silence:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
local particle = wearables_system:GetParticleReplacementAbility(self.caster, "particles/generic_gameplay/generic_silenced.vpcf", self)
self.main_cast = table.main_cast

self.particle = self.parent:GenericParticle(particle, self, true)
end

function modifier_drow_ranger_wave_of_silence_custom_silence:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
}
end

function modifier_drow_ranger_wave_of_silence_custom_silence:OnDestroy()
if not IsServer() then return end
if self.main_cast ~= 1 then return end
if self.ability.talents.has_stun == 0 then return end
self.parent:AddNewModifier(self.caster, self.ability, self:GetName(), {duration = self.ability.talents.stun_silence*(1 - self.parent:GetStatusResistance())})
end


modifier_drow_ranger_wave_of_silence_custom_attacks = class(mod_visible)
function modifier_drow_ranger_wave_of_silence_custom_attacks:GetTexture() return "buffs/drow_ranger/gust_3" end
function modifier_drow_ranger_wave_of_silence_custom_attacks:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self:SetStackCount(self.ability.talents.w3_max)
end