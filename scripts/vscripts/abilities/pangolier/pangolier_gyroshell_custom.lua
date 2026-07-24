--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_gyroshell_custom", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_tracker", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_heal", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_damage", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_dummy_thinker", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_stunned", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_stop", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_VERTICAL)
LinkLuaModifier("modifier_pangolier_rollup_custom", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_damage_cd", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_shard_damage_cd", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_turn_boost", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_legendary_cast", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_legendary", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_legendary_target", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_attack", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_perma", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_scepter", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_legendary_inactive", "abilities/pangolier/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)



pangolier_gyroshell_custom = class({})



function pangolier_gyroshell_custom:CreateTalent()

local caster = self:GetCaster()
if caster:HasTalent("modifier_pangolier_lucky_7") then return end

if caster:FindAbilityByName("pangolier_gyroshell_custom_legendary") then 

	caster:SwapAbilities("pangolier_gyroshell_custom_legendary", "pangolier_heartpiercer_custom", true, false)
	caster:FindAbilityByName("pangolier_gyroshell_custom_legendary"):SetActivated(caster:HasModifier("modifier_pangolier_gyroshell_custom"))
end


end



function pangolier_gyroshell_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/pangolier/pangolier_gyroshell_cast.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/vindicators_axe_armor.vpcf", context )
PrecacheResource( "particle","particles/pangolier/buckle_refresh.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle","particles/pangolier/rolling_stack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_techies/techies_blast_off_trail.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_stunned.vpcf", context )
PrecacheResource( "particle","particles/pangolier/pangolier_gyroshell_cast.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", context )
PrecacheResource( "particle","particles/beast_charge.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_charge.vpcf", context )
PrecacheResource( "particle","particles/pangolier/pangolier_gyroshell_cast_fast.vpcf", context )
PrecacheResource( "model", "models/heroes/pangolier/pangolier_gyroshell2.vmdl", context )

end

function pangolier_gyroshell_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self,level)
end


function pangolier_gyroshell_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "pangolier_gyroshell", self)
end 

function pangolier_gyroshell_custom:GetBehavior()
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end


function pangolier_gyroshell_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_pangolier_rolling_3") then  
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_pangolier_rolling_3", "cd")
end 
return (self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown)
end

function pangolier_gyroshell_custom:GetCastPoint(iLevel)

local bonus = 0
if self:GetCaster():HasTalent("modifier_pangolier_rolling_5") then 
	bonus = self:GetCaster():GetTalentValue("modifier_pangolier_rolling_5", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end



function pangolier_gyroshell_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_pangolier_gyroshell_custom_tracker"
end


function pangolier_gyroshell_custom:OnAbilityPhaseStart()
local caster = self:GetCaster()

caster:EmitSound("Hero_Pangolier.Gyroshell.Cast")
local particle = "particles/pangolier/pangolier_gyroshell_cast.vpcf"

if self:GetCaster():HasTalent("modifier_pangolier_rolling_5") then 
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.5)
	particle = "particles/pangolier/pangolier_gyroshell_cast_fast.vpcf"
else 
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
end

self.cast_effect = ParticleManager:CreateParticle(particle, PATTACH_CUSTOMORIGIN, caster)
ParticleManager:SetParticleControlEnt( self.cast_effect, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( self.cast_effect, 3, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
ParticleManager:SetParticleControlForward( self.cast_effect, 0,  caster:GetForwardVector())
ParticleManager:SetParticleControlForward( self.cast_effect, 3,  caster:GetForwardVector())

return true
end


function pangolier_gyroshell_custom:OnAbilityPhaseInterrupted()

local caster = self:GetCaster()
ParticleManager:DestroyParticle(self.cast_effect, true)
ParticleManager:ReleaseParticleIndex(self.cast_effect)
	
caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
caster:StopSound("Hero_Pangolier.Gyroshell.Cast")
end




function pangolier_gyroshell_custom:DealDamage(enemy, legendary)

local caster = self:GetCaster()
local swash = caster:FindAbilityByName("pangolier_swashbuckle_custom")
local passive = caster:FindAbilityByName("pangolier_lucky_shot_custom")
local legendary_ability = caster:FindAbilityByName("pangolier_gyroshell_custom_legendary")

local mod = caster:FindModifierByName("modifier_pangolier_gyroshell_custom")
local stun_duration = self:GetSpecialValueFor("stun_duration")
local knock_duration = self:GetSpecialValueFor("bounce_duration")

if enemy:IsHero() then 
	enemy:EmitSound("Hero_Pangolier.Gyroshell.Stun")
else 
	enemy:EmitSound("Hero_Pangolier.Gyroshell.Stun.Creep")
end
	
if enemy:IsRealHero() then 
	caster:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom_perma", {})
	if caster:HasTalent("modifier_pangolier_rolling_6") then 
  	caster:CdItems(caster:GetTalentValue("modifier_pangolier_rolling_6", "cd_items"))
  end
end

if passive and passive:GetLevel() > 0 then 
	passive:ProcPassive(enemy, false)
end

if swash and caster:HasTalent("modifier_pangolier_buckle_4") then 
  enemy:AddNewModifier(caster, swash, "modifier_pangolier_swashbuckle_custom_blood", {duration = caster:GetTalentValue("modifier_pangolier_buckle_4", "duration")})
end

if caster:HasTalent("modifier_pangolier_rolling_4") then 
	enemy:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom_damage", {duration = caster:GetTalentValue("modifier_pangolier_rolling_4", "duration")})
end

local attack_damage = self:GetSpecialValueFor("attack_damage")/100
local damage = self:GetSpecialValueFor("damage") + caster:GetAverageTrueAttackDamage(nil)*attack_damage
local damage_ability = nil
local damage_type = DAMAGE_TYPE_PHYSICAL

if caster:HasTalent("modifier_pangolier_rolling_1") then 
	caster:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom_attack", {})
	caster:PerformAttack(enemy, true, true, true, true, false, false, true)
	caster:RemoveModifierByName("modifier_pangolier_gyroshell_custom_attack")
end

if legendary_ability and legendary then 
	damage_ability = "modifier_pangolier_rolling_7"
	damage = caster:GetTalentValue("modifier_pangolier_rolling_7", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
	damage_type = DAMAGE_TYPE_MAGICAL
end 

local number = DoDamage({victim = enemy, attacker = caster, damage = damage, damage_type = damage_type, ability = self}, damage_ability)
SendOverheadEventMessage(enemy, 4, enemy, number, nil)

if caster:GetQuest() == "Pangolier.Quest_8" and enemy:IsRealHero() then 
	caster:UpdateQuest(1)
end

if caster:HasModifier("modifier_pangolier_gyroshell_custom_legendary") and mod and mod.target == nil and enemy:IsRealHero() and not legendary then 
	mod.target = enemy
	enemy:AddNewModifier(caster, legendary_ability, "modifier_pangolier_gyroshell_custom_legendary_target", {})
else 
	enemy:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom_stunned", {duration = stun_duration*(1 - enemy:GetStatusResistance()) + knock_duration, legendary = legendary})
	enemy:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom_damage_cd", {duration = stun_duration + knock_duration})
end

end 


function pangolier_gyroshell_custom:RollUpDamage(new_radius)

local caster = self:GetCaster()
local hit_radius = self:GetSpecialValueFor("hit_radius")

if new_radius then 
	hit_radius = new_radius
end

local mod = caster:FindModifierByName("modifier_pangolier_gyroshell_custom")

local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, hit_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
for _, enemy in pairs(enemies) do
	if (not enemy:HasModifier("modifier_pangolier_gyroshell_custom_damage_cd") or 
		(caster:HasModifier("modifier_pangolier_gyroshell_custom_legendary") and not enemy:IsCreep() and mod and not mod.target )) 
		and not enemy:HasModifier("modifier_pangolier_gyroshell_custom_legendary_target") then
		
		self:DealDamage(enemy)
	end
end

end



function pangolier_gyroshell_custom:OnSpellStart()

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration") + caster:GetTalentValue("modifier_pangolier_rolling_3", "duration")

caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)

ParticleManager:DestroyParticle(self.cast_effect, true)
ParticleManager:ReleaseParticleIndex(self.cast_effect)

local point = caster:GetAbsOrigin() + caster:GetForwardVector()
caster:Purge(false, true, false, false, false)
caster:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom", {duration = duration, original = 1})
end




pangolier_gyroshell_stop_custom = class({})

function pangolier_gyroshell_stop_custom:OnSpellStart()
if not IsServer() then return end
self:GetCaster():RemoveModifierByName("modifier_pangolier_gyroshell_custom")
end



modifier_pangolier_gyroshell_custom = class({})
function modifier_pangolier_gyroshell_custom:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom:IsHidden() return false end
function modifier_pangolier_gyroshell_custom:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max_speed = self.ability:GetSpecialValueFor("forward_move_speed")
self.legendary_ability = self.parent:FindAbilityByName("pangolier_gyroshell_custom_legendary")

if not IsServer() then return end
self.RemoveForDuel = true
self.ability:EndCd()

self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_turn_boost", {duration = self.ability:GetSpecialValueFor("jump_recover_time")})
self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_heal")

self.speed_bonus = self.parent:GetTalentValue("modifier_pangolier_rolling_5", "speed")/100

if self.parent:HasTalent("modifier_pangolier_rolling_2") then 
	self.heal_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_heal", {})
end

if self.parent:HasScepter() then 
	self.scepter_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_scepter", {})
end

local shard = self.parent:FindModifierByName("modifier_pangolier_rollup_custom")

if shard then 
	shard.early_stop = true 
	shard:Destroy()
end

self.parent:Stop()
self.bkb_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {})

self.cast_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControlEnt( self.cast_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
self:AddParticle(self.cast_effect,false, false, -1, false, false)


self.parent:EmitSound("Hero_Pangolier.Gyroshell.Loop")
self.parent:EmitSound("Hero_Pangolier.Gyroshell.Layer")

self.main = self.ability:GetName()
self.stop = self.parent:FindAbilityByName("pangolier_gyroshell_stop_custom")

--self.parent:SwapAbilities(self.main, self.stop:GetName(), false, true)

if self.parent:HasTalent("modifier_pangolier_rolling_7") and self.parent:HasTalent("modifier_pangolier_lucky_7") then
	self.parent:SwapAbilities("pangolier_heartpiercer_custom", "pangolier_gyroshell_custom_legendary", false, true)
end

self.target = nil
self.acceleration = 350
self.deceleration = 500

self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate")
self.turn_rate_max = self.ability:GetSpecialValueFor("turn_rate")

self.flCurrentSpeed = self.max_speed
self.flDespawnTime = 0.5
self.nTreeDestroyRadius = 75
self.bMaxSpeedNotified = false
self.bCrashScheduled = false
self.hCrashScheduledUnit = nil

if self.parent.flDesiredYaw == nil then
	self.parent.flDesiredYaw = self.parent:GetAnglesAsVector().y
end

self:StartIntervalThink( 0.01 )
end



function modifier_pangolier_gyroshell_custom:OnDestroy()
if not IsServer() then return end


if self.bkb_mod and not self.bkb_mod:IsNull() then 
	self.bkb_mod:Destroy()
end

if not self.parent:HasModifier("modifier_generic_arc") then
	FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
end 

if not self.early_stop or not self.parent:IsAlive() then 
--	self.ability:StartCd()
end

if not self.early_stop then 
	self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
	self.parent:EmitSound("Hero_Pangolier.Gyroshell.Stop")

	if self.heal_mod and not self.heal_mod:IsNull() then 
		self.heal_mod:SetDuration(self.parent:GetTalentValue("modifier_pangolier_rolling_2", "duration", true), true)
	end

	if self.scepter_mod and not self.scepter_mod:IsNull() then 
		self.scepter_mod:Destroy()
	end

	self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_legendary_inactive")

	if self.parent:HasTalent("modifier_pangolier_rolling_5") then 
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {duration = self.parent:GetTalentValue("modifier_pangolier_rolling_5", "duration"), effect = 1})
	end
end
 
if self.target and not self.target:IsNull() and self.target:IsAlive() then 
	local mod = self.target:FindModifierByName("modifier_pangolier_gyroshell_custom_legendary_target")
	if mod then 
		mod:Destroy()
	end 
	self.target = nil 
end 

self.main = self.ability:GetName()
--self.parent:SwapAbilities(self.stop:GetName(), self.main, false, true)

self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_legendary")
self.parent:StopSound("Hero_Pangolier.Gyroshell.Loop")
self.parent:StopSound("Hero_Pangolier.Gyroshell.Layer")

if self.parent:HasTalent("modifier_pangolier_rolling_7") and self.parent:HasTalent("modifier_pangolier_lucky_7")  then 
	self.parent:SwapAbilities("pangolier_heartpiercer_custom", "pangolier_gyroshell_custom_legendary", true , false)
end

end


function modifier_pangolier_gyroshell_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_CHANGE,
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end

function modifier_pangolier_gyroshell_custom:GetModifierModelChange()
return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pangolier_gyroshell_custom:GetOverrideAnimation()
return ACT_DOTA_RUN
end


function modifier_pangolier_gyroshell_custom:CheckState()
return 
{
	[ MODIFIER_STATE_DISARMED ] = true,
}
end

function modifier_pangolier_gyroshell_custom:GetModifierDisableTurning( params )
return 1
end

function modifier_pangolier_gyroshell_custom:OnIntervalThink()

self.max_speed = self.ability:GetSpecialValueFor("forward_move_speed")

if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary") and self.legendary_ability then 
	self.max_speed = self.legendary_ability:GetSpecialValueFor("cast_speed")
end

self.flCurrentSpeed = self.max_speed

self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate")*(1 + self.speed_bonus)
self.turn_rate_max = self.turn_rate_min

if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_turn_boost") or self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary") then 
	self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate_boosted")*(1 + self.speed_bonus)
end


if not IsServer() then return end
self.parent:SetForceAttackTarget(nil)
self.parent:Stop()

if not self.parent:HasModifier("modifier_generic_arc") then 
	self.ability:RollUpDamage()
end 

if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary_cast") then 
	return
end
self:UpdateHorizontalMotionCustom(self.parent, 0.01)
end


function modifier_pangolier_gyroshell_custom:OnOrderCustom( new_pos, target )
if not IsServer() then return end

local vTargetPos = new_pos
if target ~= nil and target:IsNull() == false then
	vTargetPos = target:GetAbsOrigin()
end

local vMountOrigin = self.parent:GetOrigin()
if self.angle_correction ~= nil and self.angle_correction > 0 then
	local flOrderDist = (vMountOrigin - vTargetPos):Length2D()
	vMountOrigin = vMountOrigin + self.parent:GetForwardVector() * math.min(self.angle_correction, flOrderDist * 0.75)
end

local vDir = vTargetPos - vMountOrigin
vDir.z = 0
vDir = vDir:Normalized()
local angles = VectorAngles( vDir )
self.parent.flDesiredYaw = angles.y
end


function modifier_pangolier_gyroshell_custom:UpdateHorizontalMotionCustom( me, dt )
if not IsServer() or not self.parent then return end

if (self.parent:IsCurrentlyHorizontalMotionControlled() or self.parent:IsCurrentlyVerticalMotionControlled() 
 	or self.parent:IsStunned() or self.parent:IsRooted()) and not self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary") then 
	self:UpdateTarget()	
	return
end 

if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_stop") then return end

if self.bCrashScheduled then
	self:Crash( self.hCrashScheduledUnit )
	return
end

local curAngles = self.parent:GetAnglesAsVector()
local flAngleDiff = AngleDiff( self.parent.flDesiredYaw, curAngles.y ) or 0
local flTurnAmount = dt * ( self.turn_rate_min + self:GetSpeedMultiplier() * ( self.turn_rate_max - self.turn_rate_min ) )

if self.flLastCrashTime ~= nil and GameRules:GetDOTATime(false, true) - self.flLastCrashTime <= 2.0 then
	flTurnAmount = flTurnAmount * 1.5
end

flTurnAmount = math.min( flTurnAmount, math.abs( flAngleDiff ) )

if flAngleDiff < 0.0 then
	flTurnAmount = flTurnAmount * -1
end

if flAngleDiff ~= 0.0 then
	curAngles.y = curAngles.y + flTurnAmount
	me:SetAbsAngles( curAngles.x, curAngles.y, curAngles.z )
end

local flMaxSpeed = self.max_speed

local flAcceleration = self.acceleration or -self.deceleration

self.flCurrentSpeed = math.max( math.min( self.flCurrentSpeed + ( dt * flAcceleration ), flMaxSpeed ), 0 )

local vNewPos = self.parent:GetOrigin() + self.parent:GetForwardVector() *( ( dt * self.flCurrentSpeed ))

local range_vector = self.parent:GetForwardVector()
local check_pos = vNewPos + range_vector

if not GridNav:CanFindPath( me:GetOrigin(), check_pos ) then
	GridNav:DestroyTreesAroundPoint( check_pos, self.nTreeDestroyRadius, true )

	if GridNav:CanFindPath( me:GetOrigin(), check_pos ) then
		self:Crash( nil, true )
	else
		self:Crash()
		return
	end
end

me:SetOrigin(GetGroundPosition( vNewPos , me))

self:UpdateTarget()
end


function modifier_pangolier_gyroshell_custom:UpdateTarget()
if not IsServer() then return end

if self.target and not self.target:IsNull() and self.target:IsAlive() and self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary") then 
	self.point = self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*100

	self.target:SetAbsOrigin(self.point)
	self.target:FaceTowards(self.parent:GetAbsOrigin())

else 
	if self.target then 
		self.target:RemoveModifierByName("modifier_pangolier_gyroshell_custom_legendary_target")
	end 
	self.target = nil 
end

end 

function modifier_pangolier_gyroshell_custom:ScheduleCrash( hHitUnit )
self.bCrashScheduled = true
self.hCrashScheduledUnit = hHitUnit
end

function modifier_pangolier_gyroshell_custom:Crash( hHitUnit, bHitTree )
if bHitTree == nil then bHitTree = false end

if not bHitTree then
	if self.flLastCrashTime ~= nil and GameRules:GetDOTATime(false, true) - self.flLastCrashTime <= 0.1 then
		if self.hLastCrashUnit ~= nil and self.hLastCrashUnit == hHitUnit then
			return
		elseif self.hLastCrashUnit == nil and hHitUnit == nil then
			return
		end
	end
	self.flLastCrashTime = GameRules:GetDOTATime(false, true)
	self.hLastCrashUnit = hHitUnit
end

if not bHitTree then
	local resetDistance = 0
	local vResetPos = self.parent:GetAbsOrigin() 
	local vAngles = self.parent:GetAngles()
	

	local old_vec = self.parent:GetForwardVector()

	self.parent:FaceTowards(self.parent:GetAbsOrigin() - old_vec)
	self.parent:SetForwardVector(old_vec*-1)
	self.parent:SetOrigin( vResetPos )
	--FindClearSpaceForUnit( self.parent, vResetPos, false )
	self.parent.flDesiredYaw = self.parent:GetAnglesAsVector().y

	self.parent:EmitSound("Hero_Pangolier.Gyroshell.Carom")
	self.parent:EmitSound("Hero_Pangolier.Carom.Layer")

	if self.target and not self.target:IsNull() and self.target:IsAlive() then 
		local mod = self.target:FindModifierByName("modifier_pangolier_gyroshell_custom_legendary_target")
		if mod then 
			mod.deal_damage = true

	    local particle = ParticleManager:CreateParticle("particles/pangolier/buckle_refresh.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	    ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
	    ParticleManager:ReleaseParticleIndex(particle)

	    self.parent:EmitSound("Hero_Rattletrap.Overclock.Cast")
			self:SetDuration(self:GetRemainingTime() + self.parent:GetTalentValue("modifier_pangolier_rolling_7", "duration_inc"), true)
			mod:Destroy()
		end 

		self.target = nil 
	end 

	self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_legendary")
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_stop", {duration = self.ability:GetSpecialValueFor("jump_recover_time")})
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_turn_boost", {duration = 2*self.ability:GetSpecialValueFor("jump_recover_time")})
end

self.bCrashScheduled = false
self.hCrashScheduledUnit = nil
end

function modifier_pangolier_gyroshell_custom:GetSpeedMultiplier()
return 0.5 + 0.5 * (self.flCurrentSpeed / self.max_speed)
end




modifier_pangolier_gyroshell_custom_tracker = class({})

function modifier_pangolier_gyroshell_custom_tracker:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_tracker:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end
function modifier_pangolier_gyroshell_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_ability = self.parent:FindAbilityByName("pangolier_gyroshell_custom_legendary")
self.shard_ability = self.parent:FindAbilityByName("pangolier_rollup_custom")
self.shard_ability_stop = self.parent:FindAbilityByName("pangolier_rollup_stop_custom")
self.ability_stop = self.parent:FindAbilityByName("pangolier_gyroshell_stop_custom")

if not IsServer() then return end 
self:StartIntervalThink(1)
end

function modifier_pangolier_gyroshell_custom_tracker:GetModifierDamageOutgoing_Percentage()
if not self.parent:HasTalent("modifier_pangolier_rolling_1") then return end 
return self.parent:GetTalentValue("modifier_pangolier_rolling_1", "damage")
end



function modifier_pangolier_gyroshell_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.ability_stop or not self.shard_ability or not self.legendary_ability or not self.shard_ability_stop then return end

local ulti_mod = self.parent:FindModifierByName("modifier_pangolier_gyroshell_custom")
local shard_mod = self.parent:FindModifierByName("modifier_pangolier_rollup_custom")
local legendary_mod = self.parent:FindModifierByName("modifier_pangolier_gyroshell_custom_legendary_cast")

if ulti_mod then
	self.legendary_ability:SetActivated(not self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary_inactive"))

	if self.ability_stop:IsHidden() then
		self.parent:SwapAbilities(self.ability:GetName(), self.ability_stop:GetName(), false, true)
	end
else
	if not self.ability:IsActivated() and not shard_mod and not legendary_mod then
		self.ability:StartCd()
	end

	if not shard_mod and not legendary_mod then
		self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_legendary_inactive")
	end

	self.legendary_ability:SetActivated(false)

	if not self.ability_stop:IsHidden() then
		self.parent:SwapAbilities(self.ability:GetName(), self.ability_stop:GetName(), true, false)
	end
end

if shard_mod then
	if self.shard_ability_stop:IsHidden() then
		self.parent:SwapAbilities(self.shard_ability:GetName(), self.shard_ability_stop:GetName(), false, true)
	end
else
	if not self.shard_ability_stop:IsHidden() then
		self.parent:SwapAbilities(self.shard_ability:GetName(), self.shard_ability_stop:GetName(), true, false)
	end
end


self:StartIntervalThink(0.1)
end




modifier_pangolier_gyroshell_custom_heal = class({})
function modifier_pangolier_gyroshell_custom_heal:IsHidden() return false end
function modifier_pangolier_gyroshell_custom_heal:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_heal:GetTexture() return "buffs/rolling_heal" end
function modifier_pangolier_gyroshell_custom_heal:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE, 
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_pangolier_gyroshell_custom_heal:GetModifierHealthRegenPercentage()
if not self.parent:HasTalent("modifier_pangolier_rolling_2") then return end 
return self.heal
end

function modifier_pangolier_gyroshell_custom_heal:GetModifierPhysicalArmorBonus()
if not self.parent:HasTalent("modifier_pangolier_rolling_2") then return end 
return self.armor
end

function modifier_pangolier_gyroshell_custom_heal:OnCreated()
self.parent = self:GetParent()
self.heal = self.parent:GetTalentValue("modifier_pangolier_rolling_2", "heal")
self.armor = self.parent:GetTalentValue("modifier_pangolier_rolling_2", "armor")

if not IsServer() then return end

self.parent:GenericParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", self)
self.parent:GenericParticle("particles/items2_fx/vindicators_axe_armor.vpcf", self)

end 




modifier_pangolier_gyroshell_custom_damage = class({})
function modifier_pangolier_gyroshell_custom_damage:IsHidden() return false end
function modifier_pangolier_gyroshell_custom_damage:IsPurgable() return false end 
function modifier_pangolier_gyroshell_custom_damage:GetTexture() return "buffs/rolling_damage" end
function modifier_pangolier_gyroshell_custom_damage:OnCreated(table)

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.max = self.caster:GetTalentValue("modifier_pangolier_rolling_4", "max", true)
self.damage = self.caster:GetTalentValue("modifier_pangolier_rolling_4", "damage")/self.max
self.heal = self.caster:GetTalentValue("modifier_pangolier_rolling_4", "heal_reduce")/self.max

if not IsServer() then return end

self.RemoveForDuel = true

self.effect_cast = ParticleManager:CreateParticle( "particles/pangolier/rolling_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)

self:SetStackCount(1)
end

function modifier_pangolier_gyroshell_custom_damage:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end

function modifier_pangolier_gyroshell_custom_damage:DeclareFunctions()
return
	{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_pangolier_gyroshell_custom_damage:GetModifierIncomingDamage_Percentage()
return self:GetStackCount()*self.damage
end

function modifier_pangolier_gyroshell_custom_damage:GetModifierLifestealRegenAmplify_Percentage() 
return self:GetStackCount()*self.heal
end

function modifier_pangolier_gyroshell_custom_damage:GetModifierHealChange() 
return self:GetStackCount()*self.heal
end

function modifier_pangolier_gyroshell_custom_damage:GetModifierHPRegenAmplify_Percentage() 
return self:GetStackCount()*self.heal
end


function modifier_pangolier_gyroshell_custom_damage:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if self.effect_cast then 
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
end

end






modifier_pangolier_gyroshell_custom_stunned = class({})

function modifier_pangolier_gyroshell_custom_stunned:OnCreated(table)
if not IsServer() then return end


local direction = (self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Normalized()
local distance = self:GetAbility():GetSpecialValueFor("knockback_radius")


if table.legendary then 
	direction = direction*-1
	distance = distance*2
end 


local mod = self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(),
"modifier_generic_knockback",
{	
	direction_x = direction.x,
	direction_y = direction.y,
	distance = distance,
	height = self:GetAbility():GetSpecialValueFor("knockback_radius"),	
	duration = self:GetAbility():GetSpecialValueFor("bounce_duration"),
	IsStun = true,
	IsFlail = true,
})

local particle_stomp_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", PATTACH_ABSORIGIN, self:GetParent())
ParticleManager:SetParticleControl(particle_stomp_fx, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(particle_stomp_fx, 1, Vector(300, 1, 1))
ParticleManager:SetParticleControl(particle_stomp_fx, 2, self:GetParent():GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_stomp_fx)

self.cast_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_blast_off_trail.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
ParticleManager:SetParticleControlEnt( self.cast_effect, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( self.cast_effect, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )


mod:AddParticle( self.cast_effect, false, false, -1, false, false  )

self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("bounce_duration"))
end


function modifier_pangolier_gyroshell_custom_stunned:OnIntervalThink()
if not IsServer() then return end

self:GetParent():RemoveGesture(ACT_DOTA_FLAIL)
self:GetParent():StartGesture(ACT_DOTA_DISABLED)

self:StartIntervalThink(-1)
end

function modifier_pangolier_gyroshell_custom_stunned:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true
}
end


function modifier_pangolier_gyroshell_custom_stunned:OnDestroy()
if not IsServer() then return end 

self:GetParent():FadeGesture(ACT_DOTA_DISABLED)
end



function modifier_pangolier_gyroshell_custom_stunned:GetEffectName()
return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_pangolier_gyroshell_custom_stunned:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end








modifier_pangolier_gyroshell_custom_stop = class({})

function modifier_pangolier_gyroshell_custom_stop:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_stop:IsPurgable() return false end 

function modifier_pangolier_gyroshell_custom_stop:OnCreated(table)
if not IsServer() then return end

self.abs = self:GetParent():GetAbsOrigin()
self.interrupted = false 

self.dir = self:GetParent():GetForwardVector()

self:SetJumpParameters(
	{
		dir_x = self.dir.x,
		dir_y = self.dir.y,
		duration = self:GetRemainingTime(),
		distance = 0,
		height = 50,
		fix_end = true,
		isStun = false,
		isForward = true,
	})

if not self:ApplyVerticalMotionController() then
	self.interrupted = true
	self:Destroy()
end

end


function modifier_pangolier_gyroshell_custom_stop:OnDestroy()
if not IsServer() then return end 

self:GetParent():RemoveVerticalMotionController( self )
self:GetParent():SetAbsOrigin(self.abs)
end


function modifier_pangolier_gyroshell_custom_stop:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_pangolier_gyroshell_custom_stop:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end

function modifier_pangolier_gyroshell_custom_stop:UpdateVerticalMotion( me, dt )
if self.fix_duration and self:GetElapsedTime()>=self.duration then return end
local pos = me:GetOrigin()
local time = self:GetElapsedTime()
local height = pos.z
local speed = self:GetVerticalSpeed( time )
pos.z = height + speed * dt
me:SetOrigin( pos )
if not self.fix_duration then
	local ground = GetGroundHeight( pos, me ) + self.end_offset
	if pos.z <= ground then
		pos.z = ground
		me:SetOrigin( pos )
		self:Destroy()
	end
end

end


function modifier_pangolier_gyroshell_custom_stop:OnVerticalMotionInterrupted()
self.interrupted = true
self:Destroy()
end

function modifier_pangolier_gyroshell_custom_stop:SetJumpParameters( kv )
self.parent = self:GetParent()
self.fix_end = true
self.fix_duration = true
self.fix_height = true
if kv.fix_end then
	self.fix_end = kv.fix_end==1
end
if kv.fix_duration then
	self.fix_duration = kv.fix_duration==1
end
if kv.fix_height then
	self.fix_height = kv.fix_height==1
end
self.isStun = kv.isStun==1
self.isRestricted = kv.isRestricted==1
self.isForward = kv.isForward==1
self.activity = kv.activity or 0
self:SetStackCount( self.activity )
if kv.target_x and kv.target_y then
	local origin = self.parent:GetOrigin()
	local dir = Vector( kv.target_x, kv.target_y, 0 ) - origin
	dir.z = 0
	dir = dir:Normalized()
	self.direction = dir
end
if kv.dir_x and kv.dir_y then
	self.direction = Vector( kv.dir_x, kv.dir_y, 0 ):Normalized()
end
if not self.direction then
	self.direction = self.parent:GetForwardVector()
end
self.duration = kv.duration
self.distance = kv.distance
self.speed = kv.speed
if not self.duration then
	self.duration = self.distance/self.speed
end
if not self.distance then
	self.speed = self.speed or 0
	self.distance = self.speed*self.duration
end
if not self.speed then
	self.distance = self.distance or 0
	self.speed = self.distance/self.duration
end


self.height = kv.height or 0
self.start_offset = kv.start_offset or 0
self.end_offset = kv.end_offset or 0
local pos_start = self.parent:GetOrigin()
local pos_end = pos_start + self.direction * self.distance
local height_start = GetGroundHeight( pos_start, self.parent ) + self.start_offset
local height_end = GetGroundHeight( pos_end, self.parent ) + self.end_offset
local height_max
if not self.fix_height then
	self.height = math.min( self.height, self.distance/4 )
end

if self.fix_end then
	height_end = height_start
	height_max = height_start + self.height
else
	local tempmin, tempmax = height_start, height_end
	if tempmin>tempmax then
		tempmin,tempmax = tempmax, tempmin
	end
	local delta = (tempmax-tempmin)*2/3

	height_max = tempmin + delta + self.height
end

if not self.fix_duration then
	self:SetDuration( -1, false )
else
	self:SetDuration( self.duration, true )
end

self:InitVerticalArc( height_start, height_max, height_end, self.duration )
end


function modifier_pangolier_gyroshell_custom_stop:InitVerticalArc( height_start, height_max, height_end, duration )
local height_end = height_end - height_start
local height_max = height_max - height_start

if height_max<height_end then
	height_max = height_end+0.01
end

if height_max<=0 then
	height_max = 0.01
end

local duration_end = ( 1 + math.sqrt( 1 - height_end/height_max ) )/2
self.const1 = 4*height_max*duration_end/duration
self.const2 = 4*height_max*duration_end*duration_end/(duration*duration)
end

function modifier_pangolier_gyroshell_custom_stop:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_pangolier_gyroshell_custom_stop:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

function modifier_pangolier_gyroshell_custom_stop:SetEndCallback( func )
	self.endCallback = func
end






modifier_pangolier_gyroshell_custom_damage_cd = class({})
function modifier_pangolier_gyroshell_custom_damage_cd:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_damage_cd:IsPurgable() return false end










pangolier_rollup_custom = class({})

function pangolier_rollup_custom:GetBehavior()
if self:GetCaster():HasModifier("modifier_pangolier_gyroshell_custom") and self:GetCaster():HasShard() then 
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET +  DOTA_ABILITY_BEHAVIOR_HIDDEN
end


function pangolier_rollup_custom:OnAbilityPhaseStart()
local caster = self:GetCaster()

caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 3)

self.cast_effect = ParticleManager:CreateParticle("particles/pangolier/pangolier_gyroshell_cast.vpcf", PATTACH_CUSTOMORIGIN, caster)
ParticleManager:SetParticleControlEnt( self.cast_effect, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( self.cast_effect, 3, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
ParticleManager:SetParticleControlForward( self.cast_effect, 0,  caster:GetForwardVector())
ParticleManager:SetParticleControlForward( self.cast_effect, 3,  caster:GetForwardVector())
return true
end


function  pangolier_rollup_custom:OnAbilityPhaseInterrupted()

local caster = self:GetCaster()

if self.cast_effect then 
	ParticleManager:DestroyParticle(self.cast_effect, true)
	ParticleManager:ReleaseParticleIndex(self.cast_effect)
end

caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
end


function pangolier_rollup_custom:OnSpellStart()
self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_4)

if self.cast_effect then 
	ParticleManager:DestroyParticle(self.cast_effect, true)
	ParticleManager:ReleaseParticleIndex(self.cast_effect)
end

self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pangolier_rollup_custom", {duration = self:GetSpecialValueFor("duration")})
end




modifier_pangolier_rollup_custom = class({})

function modifier_pangolier_rollup_custom:IsPurgable() return false end
function modifier_pangolier_rollup_custom:IsPurgeException() return false end
function modifier_pangolier_rollup_custom:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddAttackEvent_inc(self)

self.parent:AddOrderEvent(self)

self.parent:Stop()
self.parent:NoDraw(self)

self.old_duration = nil
self.ulti_ability = self.parent:FindAbilityByName("pangolier_gyroshell_custom")
self.modifier = self.parent:FindModifierByName("modifier_pangolier_gyroshell_custom")

if self.modifier then
	self.old_duration = self.modifier:GetRemainingTime()

	self.modifier.early_stop = true
	self.modifier:Destroy()
end

self.parent:GenericParticle("particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf")

--self.parent:SwapAbilities("pangolier_rollup_custom", "pangolier_rollup_stop_custom", false, true)

if self.parent:HasAbility("pangolier_rollup_stop_custom") then 
	self.parent:FindAbilityByName("pangolier_rollup_stop_custom"):StartCooldown(0.5)
end 

self.turn_rate = self.ability:GetSpecialValueFor("turn_rate_boosted")

local first_point = self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 100
self:SetDirection( Vector(first_point.x, first_point.y, 0) ) 
self.current_dir = self.target_dir
self.turn_speed = FrameTime()*self.turn_rate
self.proj_time = 0

self.bkb_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {effect = 1, duration = self:GetRemainingTime()})

self.parent:StartGesture(ACT_DOTA_SPAWN)
self.parent:EmitSound("Hero_Pangolier.Gyroshell.Layer")

self:StartIntervalThink(FrameTime())
self:OnIntervalThink()
end

function modifier_pangolier_rollup_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MODEL_CHANGE,
    MODIFIER_PROPERTY_DISABLE_TURNING,
    MODIFIER_PROPERTY_MOVESPEED_LIMIT,
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
end



function modifier_pangolier_rollup_custom:GetOverrideAnimation()
return ACT_DOTA_IDLE
end


function modifier_pangolier_rollup_custom:AttackEvent_inc(params)
if not IsServer() then return end
if params.attacker == self.parent then return end
if params.target ~= self.parent then return end
if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_shard_damage_cd") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_shard_damage_cd", {duration = self.ability:GetSpecialValueFor("damage_cd")})

self.parent:RemoveGesture(ACT_DOTA_SPAWN)
self.parent:StartGesture(ACT_DOTA_SPAWN)

local smash = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(smash, 0, self.parent:GetAbsOrigin())
ParticleManager:DestroyParticle(smash, false)
ParticleManager:ReleaseParticleIndex(smash)


self.ulti_ability:RollUpDamage(self.ability:GetSpecialValueFor("hit_radius"))
end

function modifier_pangolier_rollup_custom:OnDestroy()
if not IsServer() then return end

self.parent:RemoveGesture(ACT_DOTA_SPAWN)

if self.bkb_mod and not self.bkb_mod:IsNull() then 
	self.bkb_mod:Destroy()
end

self.parent:StopSound("Hero_Pangolier.Gyroshell.Layer")

if not self.early_stop and self.old_duration == nil then 
	self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
	self.parent:EmitSound("Hero_Pangolier.Gyroshell.Stop")
end

if self.old_duration ~= nil and self.parent:IsAlive() then
	self.parent:AddNewModifier(self.parent, self.ulti_ability, "modifier_pangolier_gyroshell_custom", {duration = self.old_duration})
end

--self.parent:SwapAbilities("pangolier_rollup_stop_custom", "pangolier_rollup_custom", false, true)
end


function modifier_pangolier_rollup_custom:GetModifierModelChange()
return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pangolier_rollup_custom:GetModifierMoveSpeed_Limit()
return 0.1
end

function modifier_pangolier_rollup_custom:GetModifierDisableTurning()
return 1
end


function modifier_pangolier_rollup_custom:OrderEvent( params )

if  params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
    params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
then
    self:SetDirection( params.pos )
elseif 
    (params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
    params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target
then
    self:SetDirection( params.target:GetOrigin() )
end

end

function modifier_pangolier_rollup_custom:SetDirection( vec )
if vec.x == self.parent:GetAbsOrigin().x and vec.y == self.parent:GetAbsOrigin().y then 
    vec = self.parent:GetAbsOrigin() + 100*self.parent:GetForwardVector()
end
self.target_dir = ((vec-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
self.face_target = false
end


function modifier_pangolier_rollup_custom:OnIntervalThink()
if not IsServer() then return end
self:TurnLogic()
end


function modifier_pangolier_rollup_custom:CheckState()
return
{
	[ MODIFIER_STATE_DISARMED ] = true,
}
end

function modifier_pangolier_rollup_custom:TurnLogic()
if self.face_target then return end

local current_angle = VectorToAngles( self.current_dir ).y
local target_angle = VectorToAngles( self.target_dir ).y
local angle_diff = AngleDiff( current_angle, target_angle )
local sign = -1
if angle_diff<0 then sign = 1 end
if math.abs( angle_diff )<1.1*self.turn_speed then
    self.current_dir = self.target_dir
    self.face_target = true
else
    self.current_dir = RotatePosition( Vector(0,0,0), QAngle(0, sign*self.turn_speed, 0), self.current_dir )
end
local a = self.parent:IsCurrentlyHorizontalMotionControlled()
local b = self.parent:IsCurrentlyVerticalMotionControlled()
if not (a or b) then
    self.parent:SetForwardVector( self.current_dir )
end

end



pangolier_rollup_stop_custom = class({})
function pangolier_rollup_stop_custom:OnSpellStart()
if not IsServer() then return end
self:GetCaster():RemoveModifierByName("modifier_pangolier_rollup_custom")
end





modifier_pangolier_gyroshell_custom_shard_damage_cd = class({})
function modifier_pangolier_gyroshell_custom_shard_damage_cd:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_shard_damage_cd:IsPurgable() return false end



modifier_pangolier_gyroshell_custom_turn_boost = class({})
function modifier_pangolier_gyroshell_custom_turn_boost:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_turn_boost:IsPurgable() return false end









pangolier_gyroshell_custom_legendary = class({})


function pangolier_gyroshell_custom_legendary:OnAbilityPhaseStart()
if self:GetCaster():HasModifier("modifier_pangolier_gyroshell_custom_legendary_inactive") then return false end
if self:GetCaster():HasModifier("modifier_pangolier_gyroshell_custom_legendary_cast") then return false end
if not self:GetCaster():HasModifier("modifier_pangolier_gyroshell_custom") then return false end

return true
end


function pangolier_gyroshell_custom_legendary:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("Pango.Ulti_legendary")
self:EndCd(0)
self:StartCooldown(self:GetSpecialValueFor("cast_duration"))
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pangolier_gyroshell_custom_legendary_inactive", {})
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pangolier_gyroshell_custom_legendary_cast", {duration = self:GetSpecialValueFor("cast_duration")})
end






modifier_pangolier_gyroshell_custom_legendary_cast = class({})
function modifier_pangolier_gyroshell_custom_legendary_cast:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_legendary_cast:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_legendary_cast:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
local mod = self.parent:FindModifierByName("modifier_pangolier_gyroshell_custom")
self.ability = self.parent:FindAbilityByName("pangolier_gyroshell_custom")

self.parent:AddOrderEvent(self)

self.no_mod = false 

if not mod then 
	self.no_mod = true
	self:Destroy()
	return
end

self.bkb_mod = self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_generic_debuff_immune", {})

self.ulti_time = mod:GetRemainingTime()
mod.early_stop = true
mod:Destroy()

self.parent:StartGesture(ACT_DOTA_SPAWN)

self.effect_cast = ParticleManager:CreateParticle( "particles/beast_charge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(self.ability:GetSpecialValueFor("hit_radius"), 0, 0) )
self:AddParticle( self.effect_cast, false, false, -1, false, false )

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf", PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
self:AddParticle( effect_cast, false, false, -1, false, false )

local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf", PATTACH_ABSORIGIN, self.parent)
ParticleManager:ReleaseParticleIndex(hit_effect)

self.turn_rate = self:GetAbility():GetSpecialValueFor("turn_rate")

local first_point = self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 100
self:SetDirection( Vector(first_point.x, first_point.y, 0) ) 
self.current_dir = self.target_dir
self.turn_speed = 0.01*self.turn_rate

self.parent:EmitSound("Hero_Pangolier.Gyroshell.Layer")

self:StartIntervalThink(0.01)
self:OnIntervalThink()
end



function modifier_pangolier_gyroshell_custom_legendary_cast:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
	[ MODIFIER_STATE_DISARMED ] = true,
}

end
function modifier_pangolier_gyroshell_custom_legendary_cast:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_CHANGE,
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_MOVESPEED_LIMIT,
}
end

function modifier_pangolier_gyroshell_custom_legendary_cast:GetModifierModelChange()
return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pangolier_gyroshell_custom_legendary_cast:GetModifierMoveSpeed_Limit()
return 0.1
end

function modifier_pangolier_gyroshell_custom_legendary_cast:GetModifierDisableTurning()
return 1
end

function modifier_pangolier_gyroshell_custom_legendary_cast:OrderEvent( params )

if  params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
    params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
then
    self:SetDirection( params.pos )
elseif 
    (params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
    params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target
then
    self:SetDirection( params.target:GetOrigin() )
end

end

function modifier_pangolier_gyroshell_custom_legendary_cast:SetDirection( vec )
    if vec.x == self.parent:GetAbsOrigin().x and vec.y == self.parent:GetAbsOrigin().y then 
        vec = self.parent:GetAbsOrigin() + 100*self.parent:GetForwardVector()
    end
    self.target_dir = ((vec-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
    self.face_target = false
end

function modifier_pangolier_gyroshell_custom_legendary_cast:OnIntervalThink()
    if not IsServer() then return end
    self:TurnLogic()
end

function modifier_pangolier_gyroshell_custom_legendary_cast:TurnLogic()
    if self.face_target then return end
    local current_angle = VectorToAngles( self.current_dir ).y
    local target_angle = VectorToAngles( self.target_dir ).y
    local angle_diff = AngleDiff( current_angle, target_angle )
    local sign = -1
    if angle_diff<0 then sign = 1 end
    if math.abs( angle_diff )<1.1*self.turn_speed then
        self.current_dir = self.target_dir
        self.face_target = true
    else
        self.current_dir = RotatePosition( Vector(0,0,0), QAngle(0, sign*self.turn_speed, 0), self.current_dir )
    end
    local a = self.parent:IsCurrentlyHorizontalMotionControlled()
    local b = self.parent:IsCurrentlyVerticalMotionControlled()
    if not (a or b) then
        self.parent:SetForwardVector( self.current_dir )
    end
	if self.effect_cast then 
		local target_pos = self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*500
		ParticleManager:SetParticleControl( self.effect_cast, 1, target_pos )

	end
end





function modifier_pangolier_gyroshell_custom_legendary_cast:OnDestroy()
if not IsServer() then return end 
if self.no_mod == true then return end

if self.bkb_mod and not self.bkb_mod:IsNull() then 
	self.bkb_mod:Destroy()
end

self.parent:StopSound("Hero_Pangolier.Gyroshell.Layer")

if self.parent:IsAlive() then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom", {duration = self.ulti_time})
end

self.parent:EmitSound("Pango.Ulti_legendary_cast")
self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_pangolier_gyroshell_custom_legendary", {duration = self:GetAbility():GetSpecialValueFor("duration")})
end











modifier_pangolier_gyroshell_custom_legendary = class({})
function modifier_pangolier_gyroshell_custom_legendary:IsHidden() return false end
function modifier_pangolier_gyroshell_custom_legendary:IsPurgable() return false end

function modifier_pangolier_gyroshell_custom_legendary:GetEffectName()
	return "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
end

function modifier_pangolier_gyroshell_custom_legendary:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pangolier_gyroshell_custom_legendary:OnCreated(table)
if not IsServer() then return end 

self.cast_effect = ParticleManager:CreateParticle("particles/lc_odd_charge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
self:AddParticle(self.cast_effect,false, false, -1, false, false)


end 




modifier_pangolier_gyroshell_custom_legendary_target = class({})
function modifier_pangolier_gyroshell_custom_legendary_target:IsHidden() return true end 
function modifier_pangolier_gyroshell_custom_legendary_target:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_legendary_target:OnCreated(table)
if not IsServer() then return end 

self.caster = self:GetCaster()

self:GetParent():FaceTowards(self.caster:GetAbsOrigin())

self:GetParent():RemoveModifierByName("modifier_pangolier_gyroshell_custom_stunned")

self.ability = self:GetCaster():FindAbilityByName("pangolier_gyroshell_custom")
end 


function modifier_pangolier_gyroshell_custom_legendary_target:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
}

end 


function modifier_pangolier_gyroshell_custom_legendary_target:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_pangolier_gyroshell_custom_legendary_target:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end




function modifier_pangolier_gyroshell_custom_legendary_target:OnDestroy()
if not IsServer() then return end 

if self:GetParent():IsDebuffImmune() or not self.deal_damage then 
	FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
end


if self.deal_damage then 
	self.ability:DealDamage(self:GetParent(), true)
else 
	self:GetParent():AddNewModifier(self:GetCaster(), self.ability, "modifier_pangolier_gyroshell_custom_damage_cd", {duration = 1.5})
end


end 



modifier_pangolier_gyroshell_custom_attack = class({})
function modifier_pangolier_gyroshell_custom_attack:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_attack:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_attack:OnCreated()
self.damage = self:GetCaster():GetTalentValue("modifier_pangolier_rolling_1", "attack_damage") - 100
end

function modifier_pangolier_gyroshell_custom_attack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_pangolier_gyroshell_custom_attack:GetModifierDamageOutgoing_Percentage()
if IsClient() then return end
return self.damage
end






modifier_pangolier_gyroshell_custom_perma = class({})
function modifier_pangolier_gyroshell_custom_perma:IsHidden() return not self:GetCaster():HasTalent("modifier_pangolier_rolling_6") end
function modifier_pangolier_gyroshell_custom_perma:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_perma:RemoveOnDeath() return false end
function modifier_pangolier_gyroshell_custom_perma:GetTexture() return "buffs/wrath_perma" end
function modifier_pangolier_gyroshell_custom_perma:OnCreated(table)

self.max = self:GetCaster():GetTalentValue("modifier_pangolier_rolling_6", "max", true)
self.cdr = self:GetCaster():GetTalentValue("modifier_pangolier_rolling_6", "cdr", true)

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_pangolier_gyroshell_custom_perma:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self:GetCaster():HasTalent("modifier_pangolier_rolling_6") then return end

local particle_peffect = ParticleManager:CreateParticle("particles/lc_odd_proc_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControl(particle_peffect, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self:GetParent():GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self:GetCaster():EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_pangolier_gyroshell_custom_perma:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

end


function modifier_pangolier_gyroshell_custom_perma:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_pangolier_gyroshell_custom_perma:GetModifierPercentageCooldown() 
if not self:GetCaster():HasTalent("modifier_pangolier_rolling_6") then return end
return self:GetStackCount()*self.cdr
end



modifier_pangolier_gyroshell_custom_scepter = class({})
function modifier_pangolier_gyroshell_custom_scepter:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_scepter:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_scepter:OnCreated()

self.parent = self:GetParent()
self.swash = self.parent:FindAbilityByName("pangolier_swashbuckle_custom")
 
if not self.swash or self.swash:GetLevel() < 0 then 
	self:Destroy()
	return
end

self.interval = self.swash:GetSpecialValueFor("scepter_interval")

self:OnIntervalThink()
self:StartIntervalThink(self.interval - FrameTime())
end

function modifier_pangolier_gyroshell_custom_scepter:OnIntervalThink()
if not IsServer() then return end 

self.parent:AddNewModifier(self.parent, self.swash, "modifier_pangolier_swashbuckle_custom_scepter", {})
end



modifier_pangolier_gyroshell_custom_legendary_inactive = class({})
function modifier_pangolier_gyroshell_custom_legendary_inactive:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_legendary_inactive:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_legendary_inactive:RemoveOnDeath() return false end