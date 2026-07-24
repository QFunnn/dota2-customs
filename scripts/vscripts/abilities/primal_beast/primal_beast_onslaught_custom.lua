--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_primal_beast_onslaught_custom_cast", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_onslaught_custom", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_primal_beast_onslaught_custom_knockback", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier( "modifier_primal_beast_onslaught_custom_slow", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_onslaught_custom_thinker", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_onslaught_custom_stacks", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_onslaught_custom_stun_slow", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_onslaught_custom_damage", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_onslaught_custom_shield", "abilities/primal_beast/primal_beast_onslaught_custom", LUA_MODIFIER_MOTION_NONE )


primal_beast_onslaught_custom = class({})

function primal_beast_onslaught_custom:CreateTalent()
self:ToggleAutoCast()
end

function primal_beast_onslaught_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_attack_blur_left_to_right.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_attack_blur_right_to_left.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primalbeast_footstep_dust_impact.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_attack_fist_blur_left_to_right.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_attack_fist_blur_right_to_left.vpcf", context )

PrecacheResource( "particle","particles/items_fx/battlefury_cleave.vpcf", context )
PrecacheResource( "particle","particles/primal_knockback.vpcf", context )
PrecacheResource( "particle","particles/pangolier/buckle_refresh.vpcf", context )
PrecacheResource( "particle","particles/beast_charge.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf", context )
PrecacheResource( "particle","particles/beast_haste.vpcf", context )
PrecacheResource( "particle","particles/lina_attack_slow.vpcf", context )
PrecacheResource( "particle","particles/lina_attack_slow.vpcf", context )
PrecacheResource( "particle","particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/pangolier/linken_active.vpcf", context )
PrecacheResource( "particle","particles/pangolier/linken_proc.vpcf", context )

end


function primal_beast_onslaught_custom:GetCastRange(vLocation, hTarget)
if IsClient() then 
 	return self:GetSpecialValueFor("max_distance")
end
return 999999
end

function primal_beast_onslaught_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_primal_beast_onslaught_5") then
	bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + bonus
end

function primal_beast_onslaught_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_primal_beast_onslaught_1") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_primal_beast_onslaught_1", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function primal_beast_onslaught_custom:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_primal_beast_onslaught_3") then  
  bonus = self:GetCaster():GetTalentValue("modifier_primal_beast_onslaught_3", "mana")
end
return self.BaseClass.GetManaCost(self,level) + bonus
end


function primal_beast_onslaught_custom:GetDamage()
if not IsServer() then return end 
local caster = self:GetCaster()
local damage = self:GetSpecialValueFor("knockback_damage") + caster:GetTalentValue("modifier_primal_beast_onslaught_2", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
return damage
end 

function primal_beast_onslaught_custom:GetChargeTime()
if not IsServer() then return end 
local duration = self:GetSpecialValueFor( "chargeup_time" ) + self:GetCaster():GetTalentValue("modifier_primal_beast_onslaught_4", "cast")	
return duration
end

function primal_beast_onslaught_custom:GetChargeSpeed()
if not IsServer() then return end 
local speed = self:GetSpecialValueFor( "charge_speed" )*(1 + self:GetCaster():GetTalentValue("modifier_primal_beast_onslaught_6", "speed")/100)
return speed
end




function primal_beast_onslaught_custom:KnockTarget(enemy, knock)
if not IsServer() then return end

local caster = self:GetCaster()
local height = 50
local distance = self:GetSpecialValueFor( "knockback_distance" )
local duration = self:GetSpecialValueFor( "knockback_duration" )
local stun = (self:GetSpecialValueFor( "stun_duration" ) + caster:GetTalentValue("modifier_primal_beast_onslaught_1", "stun"))*(1 - enemy:GetStatusResistance())

local stun = enemy:AddNewModifier( caster, self, "modifier_generic_stun", { duration = stun } )

if stun and not stun:IsNull() and caster:HasTalent("modifier_primal_beast_onslaught_6")  then 
  stun:SetEndRule(function()
    if enemy and not enemy:IsNull() then 
      enemy:AddNewModifier( caster, self, "modifier_primal_beast_onslaught_custom_stun_slow", { duration = caster:GetTalentValue("modifier_primal_beast_onslaught_6", "leash")*(1 - enemy:GetStatusResistance())} )
    end 
  end)
end

if knock and knock == true then 
	distance = 20
end

if not (enemy:IsCurrentlyHorizontalMotionControlled() or enemy:IsCurrentlyVerticalMotionControlled()) then
	local direction = enemy:GetOrigin()-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

  local knockbackProperties =
	{
    center_x = caster:GetOrigin().x,
    center_y = caster:GetOrigin().y,
    center_z = caster:GetOrigin().z,
    duration = duration,
    knockback_duration = duration,
    knockback_distance = distance,
    knockback_height = height
  }
  enemy:AddNewModifier( caster, self, "modifier_knockback", knockbackProperties )
end

end 


function primal_beast_onslaught_custom:OnSpellStart()
if not IsServer() then return end

local caster = self:GetCaster()
local duration = self:GetChargeTime()
local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then
	point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end

local dir = point - caster:GetAbsOrigin()

caster:FaceTowards(point)
caster:SetForwardVector(dir:Normalized())

local release_ability = caster:FindAbilityByName( "primal_beast_onslaught_release_custom" )
if release_ability then
	release_ability:UseResources( false, false, false, true )
end

caster:AddNewModifier( caster, self, "modifier_primal_beast_onslaught_custom_cast", { duration = duration } )

if caster:HasTalent("modifier_primal_beast_onslaught_5") and self:GetAutoCastState() then 

	local radius = caster:GetTalentValue("modifier_primal_beast_onslaught_5", "radius")
	local knock_duration = caster:GetTalentValue("modifier_primal_beast_onslaught_5", "knock_duration")

	local nFXIndex = ParticleManager:CreateParticle( "particles/primal_knockback.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl( nFXIndex, 0, caster:GetAbsOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	caster:EmitSound("PBeast.Onslaught_knock_caster")
	for _,enemy in pairs(caster:FindTargets(radius)) do 
	  enemy:EmitSound("PBeast.Onslaught_knock")
	  enemy:AddNewModifier(caster, self, "modifier_primal_beast_onslaught_custom_knockback", {duration = knock_duration, x = caster:GetAbsOrigin().x, y = caster:GetAbsOrigin().y})
	end
end

end


function primal_beast_onslaught_custom:OnChargeFinish( interrupt, max )
if not IsServer() then return end


local caster = self:GetCaster()
local max_duration = self:GetChargeTime()
local max_distance = self:GetSpecialValueFor( "max_distance" ) 
local speed = self:GetChargeSpeed()

local legendary_max = caster:GetTalentValue("modifier_primal_beast_onslaught_7", "duration")
local charge_duration = max_duration

local mod = caster:FindModifierByName( "modifier_primal_beast_onslaught_custom_cast" )

if mod then
	charge_duration = mod:GetElapsedTime()
	mod.charge_finish = true
	mod:Destroy()
elseif not max then 
	return
end

local k = charge_duration / max_duration
local charge = math.floor(charge_duration/(max_duration/legendary_max) )

if k >= 0.98 then 
	local ult = caster:FindAbilityByName("primal_beast_pulverize_custom")
	if ult and ult:IsTrained() then 
		ult:AddLegendaryStack()
	end 
end

if caster:HasTalent("modifier_primal_beast_onslaught_7") then 
	if max == 1 or max == true then
    local particle = ParticleManager:CreateParticle("particles/pangolier/buckle_refresh.vpcf", PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControlEnt( particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
    ParticleManager:ReleaseParticleIndex(particle)
    caster:EmitSound("Hero_Rattletrap.Overclock.Cast")
	end
	caster:CdAbility(self, self:GetCooldownTimeRemaining()*caster:GetTalentValue("modifier_primal_beast_onslaught_7", "cd")*k/100)
end

if caster:HasTalent("modifier_primal_beast_onslaught_2") then 
	local damage = caster:GetTalentValue("modifier_primal_beast_onslaught_2", "damage_inc")*k
	caster:RemoveModifierByName("modifier_primal_beast_onslaught_custom_damage")
	caster:AddNewModifier(caster, self, "modifier_primal_beast_onslaught_custom_damage", {duration = caster:GetTalentValue("modifier_primal_beast_onslaught_2", "duration"), damage = damage})
end

local distance = max_distance * k
local duration = distance / speed

if interrupt then
	caster:RemoveModifierByName("modifier_primal_beast_onslaught_custom_absorb")
	return
end 

caster:AddNewModifier( caster, self, "modifier_primal_beast_onslaught_custom", {charge = charge, duration = duration, max = max } )
caster:EmitSound("Hero_PrimalBeast.Onslaught")
end





primal_beast_onslaught_release_custom = class({})

function primal_beast_onslaught_release_custom:OnSpellStart()
local ability = self:GetCaster():FindAbilityByName("primal_beast_onslaught_custom")
if ability then
	ability:OnChargeFinish( false, false )
end

end



modifier_primal_beast_onslaught_custom_cast = class({})
function modifier_primal_beast_onslaught_custom_cast:IsHidden() return false end
function modifier_primal_beast_onslaught_custom_cast:IsPurgable() return false end

function modifier_primal_beast_onslaught_custom_cast:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.ability:GetChargeSpeed()
self.turn_speed = self.ability:GetSpecialValueFor( "turn_rate" )
self.max_time = self.ability:GetChargeTime()
self.hit_radius = self.ability:GetSpecialValueFor( "knockback_radius" )/1.4
self.vision_radius = self.ability:GetSpecialValueFor("vision_radius")
self.max_distance = self.ability:GetSpecialValueFor("max_distance")

self.legendary_max = self.parent:GetTalentValue("modifier_primal_beast_onslaught_7", "duration", true)

if not IsServer() then return end

self.parent:AddOrderEvent(self)
self.parent:AddSpellEvent(self)

if not self.ability:IsHidden() then 
	self.parent:SwapAbilities( "primal_beast_onslaught_custom", "primal_beast_onslaught_release_custom", false, true )
end

if self.parent:HasTalent("modifier_primal_beast_onslaught_3") then
	self.parent:RemoveModifierByName("modifier_primal_beast_onslaught_custom_shield")
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_primal_beast_onslaught_custom_shield", {duration = self.parent:GetTalentValue("modifier_primal_beast_onslaught_3", "duration")})
end

if self.parent:HasTalent("modifier_primal_beast_onslaught_5") then 
	self.block = true
	self.particle = ParticleManager:CreateParticle("particles/pangolier/linken_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
	self:AddParticle(self.particle, false, false, -1, false, false)
end

self.anim_return = 0
self.origin = self.parent:GetOrigin()
self.target_angle = self.parent:GetAnglesAsVector().y
self.current_angle = self.target_angle
self.face_target = true
self.charge_finish = false
self.interval = 0.01

self:OnIntervalThink()
self:StartIntervalThink( self.interval )

self:PlayEffects1()
self:PlayEffects2()
end


function modifier_primal_beast_onslaught_custom_cast:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if bit.band(params.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL) ~= 0 then return end
if params.ability:GetName() == "primal_beast_rock_throw" then return end

self.ability:OnChargeFinish( false, false )
end 


function modifier_primal_beast_onslaught_custom_cast:OnDestroy()
if not IsServer() then return end

if self.parent:HasTalent("modifier_primal_beast_onslaught_7") then 
	self.parent:UpdateUIshort({hide = 1, dots = self.legendary_max, style = "BeastCharge"})
end 

self.parent:SwapAbilities( "primal_beast_onslaught_custom", "primal_beast_onslaught_release_custom", true ,  false)

self.parent:EmitSound("Hero_PrimalBeast.Onslaught.Channel")
self.parent:RemoveGesture(ACT_DOTA_CAST_ABILITY_2)

if self.charge_finish == false then 
	self.ability:OnChargeFinish( false, self:GetRemainingTime() <= 0.03 )
end 

end

function modifier_primal_beast_onslaught_custom_cast:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_ABSORB_SPELL,
}
end


function modifier_primal_beast_onslaught_custom_cast:GetAbsorbSpell(params) 
if not self.block then return end
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end

self.block = false

local particle = ParticleManager:CreateParticle("particles/pangolier/linken_proc.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

if self.particle then 
	ParticleManager:DestroyParticle(self.particle, true)
	ParticleManager:ReleaseParticleIndex(self.particle)
end

self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
return 1 
end

function modifier_primal_beast_onslaught_custom_cast:GetModifierDisableTurning()
return 1
end


function modifier_primal_beast_onslaught_custom_cast:OrderEvent( params )

if params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
then
	self:SetDirection( params.pos )
elseif 
	(params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
	params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target
then
	self:SetDirection( params.target:GetOrigin() )
elseif
	params.order_type==DOTA_UNIT_ORDER_STOP or 
	params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
then
	if not self.charge_finish then
		self.ability:OnChargeFinish( false, false )
	end
end	

end

function modifier_primal_beast_onslaught_custom_cast:SetDirection( location )
local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
self.target_angle = VectorToAngles( dir ).y
self.face_target = false
end

function modifier_primal_beast_onslaught_custom_cast:GetModifierMoveSpeed_Limit()
return 0.1
end

function modifier_primal_beast_onslaught_custom_cast:CheckState()
return 
{
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
}
end

function modifier_primal_beast_onslaught_custom_cast:OnIntervalThink()
if IsServer() then
	self.anim_return = self.anim_return + self.interval
	if self.anim_return >= 1 then
		self.anim_return = 0
		self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	end

	if self.parent:HasTalent("modifier_primal_beast_onslaught_7") and not self.charge_finish then 
		self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetElapsedTime(), dots = self.legendary_max, style = "BeastCharge"})
	end

	AddFOWViewer(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.vision_radius, self.interval*3, false)
end

if self.parent:IsRooted() or self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsLeashed() and not self.charge_finish then
	self.ability:OnChargeFinish( true,  false )
end

self:TurnLogic( self.interval )
self:SetEffects()
end

function modifier_primal_beast_onslaught_custom_cast:TurnLogic( dt )
if self.face_target then return end
local angle_diff = AngleDiff( self.current_angle, self.target_angle )
local turn_speed = self.turn_speed*dt

local sign = -1
if angle_diff<0 then sign = 1 end

if math.abs( angle_diff )<1.1*turn_speed then
	self.current_angle = self.target_angle
	self.face_target = true
else
	self.current_angle = self.current_angle + sign*turn_speed
end

local angles = self.parent:GetAnglesAsVector()
self.parent:SetLocalAngles( angles.x, self.current_angle, angles.z )
end

function modifier_primal_beast_onslaught_custom_cast:PlayEffects1()
self.effect_cast = ParticleManager:CreateParticleForPlayer( "particles/beast_charge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetPlayerOwner() )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(self.hit_radius, 0, 0) )
self:AddParticle( self.effect_cast, false, false, -1, false, false )

self:SetEffects()
end

function modifier_primal_beast_onslaught_custom_cast:SetEffects()
if not self.effect_cast then return end
local time = self:GetElapsedTime()

local k =  time/self.max_time
local target_pos = self.origin + self.parent:GetForwardVector() * k * self.max_distance

ParticleManager:SetParticleControl( self.effect_cast, 1, target_pos )
end

function modifier_primal_beast_onslaught_custom_cast:PlayEffects2()
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf", PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
self:AddParticle( effect_cast, false, false, -1, false, false )

self.parent:EmitSound("Hero_PrimalBeast.Onslaught.Channel")
end






modifier_primal_beast_onslaught_custom = class({})

function modifier_primal_beast_onslaught_custom:IsHidden() return true end
function modifier_primal_beast_onslaught_custom:IsPurgable() return false end
function modifier_primal_beast_onslaught_custom:CheckState()
return 
{
	[MODIFIER_STATE_DISARMED] = true,
}
end


function modifier_primal_beast_onslaught_custom:OnCreated( kv )

self.ability = self:GetAbility()
self.parent = self:GetParent()

self.turn_speed = self.ability:GetSpecialValueFor( "turn_rate" )
self.radius = self.ability:GetSpecialValueFor( "knockback_radius" )
self.damage = self.ability:GetDamage()

self.tree_radius = 100

self.legendary_max = self.parent:GetTalentValue("modifier_primal_beast_onslaught_7", "duration")

if not IsServer() then return end

self.parent:AddOrderEvent(self)

self.ult = self.parent:FindAbilityByName("primal_beast_pulverize_custom")

self.speed = self.ability:GetChargeSpeed()

if self.parent:HasTalent("modifier_primal_beast_onslaught_5") then 
	self.bkb = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {effect = 1, duration = self:GetRemainingTime() + 0.1})
end

self.max = kv.max 
self.charge = math.min(self.legendary_max, math.max(0,  kv.charge))

self.target_angle = self.parent:GetAnglesAsVector().y
self.current_angle = self.target_angle
self.face_target = true

self.knockback_units = {}
self.knockback_units[self.parent] = true

if not self:ApplyHorizontalMotionController() then
	self:Destroy()
	return
end

self.damageTable = { attacker = self.parent, damage = self.damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self.ability }
end

function modifier_primal_beast_onslaught_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
}
end

function modifier_primal_beast_onslaught_custom:OrderEvent( params )
if self:GetElapsedTime() <= 0.1 then return end

if params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
	self:SetDirection( params.pos )
elseif
	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
then
	self:SetDirection( params.pos )
elseif 
	(params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
	params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target
then
	self:SetDirection( params.target:GetOrigin() )
elseif
	params.order_type==DOTA_UNIT_ORDER_STOP or 
	params.order_type==DOTA_UNIT_ORDER_CAST_TARGET or
	params.order_type==DOTA_UNIT_ORDER_CAST_POSITION or
	params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
then
	self:Destroy()
end	

end

function modifier_primal_beast_onslaught_custom:GetModifierDisableTurning()
return 1
end

function modifier_primal_beast_onslaught_custom:SetDirection( location )
local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
self.target_angle = VectorToAngles( dir ).y
self.face_target = false
end

function modifier_primal_beast_onslaught_custom:GetOverrideAnimation()
return ACT_DOTA_RUN
end

function modifier_primal_beast_onslaught_custom:GetActivityTranslationModifiers()
return "onslaught_movement"
end


function modifier_primal_beast_onslaught_custom:TurnLogic( dt )
if self.face_target then return end
local angle_diff = AngleDiff( self.current_angle, self.target_angle )
local turn_speed = self.turn_speed*dt

local sign = -1
if angle_diff<0 then sign = 1 end

if math.abs( angle_diff )<1.1*turn_speed then
	self.current_angle = self.target_angle
	self.face_target = true
else
	self.current_angle = self.current_angle + sign*turn_speed
end

local angles = self.parent:GetAnglesAsVector()
self.parent:SetLocalAngles( angles.x, self.current_angle, angles.z )
end


function modifier_primal_beast_onslaught_custom:HitLogic()

GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.tree_radius, false )


for _,unit in pairs(self.parent:FindTargets(self.radius) ) do
	if not self.knockback_units[unit] then

		self.knockback_units[unit] = true
		self.damageTable.victim = unit

		if unit:IsValidKill(self.parent) and self.max == 1 then 
			if self.parent:GetQuest() == "Beast.Quest_5"  then 
				self.parent:UpdateQuest(1)
			end 
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_primal_beast_onslaught_custom_stacks", {})
		end

		if self.ult and self.ult:IsTrained() and self.max == 1 then 
			self.ult:AddStrStack(unit)
		end

		DoDamage(self.damageTable)
		self.ability:KnockTarget(unit)
		self:PlayEffects( unit, self.radius )
	end
end

end



function modifier_primal_beast_onslaught_custom:UpdateHorizontalMotion( me, dt )
if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsChanneling() then
	self:Destroy()
	return
end

if self.parent:IsRooted() or self.parent:IsLeashed() then
	return
end

self:HitLogic()
self:TurnLogic( dt )
local nextpos = me:GetOrigin() + me:GetForwardVector() * self.speed * dt
me:SetOrigin(nextpos)
end

function modifier_primal_beast_onslaught_custom:OnHorizontalMotionInterrupted()
self:Destroy()
end

function modifier_primal_beast_onslaught_custom:GetEffectName()
return "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
end

function modifier_primal_beast_onslaught_custom:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_primal_beast_onslaught_custom:PlayEffects( target, radius )
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
target:EmitSound("Hero_PrimalBeast.Onslaught.Hit")
end

function modifier_primal_beast_onslaught_custom:OnDestroy()
if not IsServer() then return end

if self.bkb and not self.bkb:IsNull() then 
	self.bkb:Destroy()
end

self.parent:RemoveModifierByName("modifier_primal_beast_onslaught_custom_absorb")
self.parent:RemoveHorizontalMotionController(self)

local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)
self.parent:SetForwardVector(dir)

FindClearSpaceForUnit( self.parent, self.parent:GetOrigin(), false )

if self.parent:HasTalent("modifier_primal_beast_onslaught_7") and self.charge >= 1 then 
	CreateModifierThinker(self.parent, self.ability, "modifier_primal_beast_onslaught_custom_thinker", {max = self.charge}, self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*100, self.parent:GetTeamNumber(), false)
end

end




modifier_primal_beast_onslaught_custom_thinker = class({})
function modifier_primal_beast_onslaught_custom_thinker:IsHidden() return true end
function modifier_primal_beast_onslaught_custom_thinker:IsPurgable() return false end
function modifier_primal_beast_onslaught_custom_thinker:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.interval = self.caster:GetTalentValue("modifier_primal_beast_onslaught_7", "interval")
self.radius = self.caster:GetTalentValue("modifier_primal_beast_onslaught_7", "radius")
self.damage = self.caster:GetTalentValue("modifier_primal_beast_onslaught_7", "damage")/100
self.heal = self.caster:GetTalentValue("modifier_primal_beast_onslaught_7", "heal")/100
self.max = table.max

self.damageTable = { attacker = self.caster, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK, }

self:StartIntervalThink(self.interval)
end

function modifier_primal_beast_onslaught_custom_thinker:OnIntervalThink()
if not IsServer() then return end
if not self.caster or self.caster:IsNull() then
	self:Destroy()
	return 
end

self:IncrementStackCount()

local damage = self.ability:GetDamage()*self.damage

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.radius, self.radius, self.radius) )
ParticleManager:DestroyParticle( effect_cast, false )
ParticleManager:ReleaseParticleIndex( effect_cast )

EmitSoundOnLocationWithCaster( self.parent:GetOrigin(), "Hero_PrimalBeast.Pulverize.Impact", self.caster )

for _,enemy in pairs(self.caster:FindTargets(self.radius, self.parent:GetAbsOrigin())) do 
	self.damageTable.victim = enemy
	self.damageTable.damage = damage

	DoDamage(self.damageTable, "modifier_primal_beast_onslaught_7")
	enemy:SendNumber(4, damage)
end

if (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius then 
	self.caster:GenericHeal(damage*self.heal, self.ability, nil, nil, "modifier_primal_beast_onslaught_7")
end 

if self:GetStackCount() >= self.max then 
	self:Destroy()
	return
end

end







modifier_primal_beast_onslaught_custom_knockback = class({})

function modifier_primal_beast_onslaught_custom_knockback:IsHidden() return true end

function modifier_primal_beast_onslaught_custom_knockback:OnCreated(params)
if not IsServer() then return end

self.ability        = self:GetAbility()
self.caster         = self:GetCaster()
self.parent         = self:GetParent()

self.slow_duration = self.caster:GetTalentValue("modifier_primal_beast_onslaught_5", "duration")
self.max_range = self.caster:GetTalentValue("modifier_primal_beast_onslaught_5", "radius")
self.knockback_duration = self:GetRemainingTime()

local dir = self.parent:GetAbsOrigin() - self.caster:GetAbsOrigin()
local final_point = self.caster:GetAbsOrigin() + dir:Normalized()*(self.max_range + 50)
local knockback_distance = (final_point - self.parent:GetAbsOrigin()):Length2D()
self.knockback_speed = knockback_distance / self.knockback_duration

self.position = GetGroundPosition(Vector(params.x, params.y, 0), nil)

if self:ApplyHorizontalMotionController() == false then 
  self:Destroy()
  return
end

end

function modifier_primal_beast_onslaught_custom_knockback:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local distance = (me:GetOrigin() - self.position):Normalized()
me:SetOrigin( me:GetOrigin() + distance * self.knockback_speed * dt )
GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.parent:GetHullRadius(), true )
end

function modifier_primal_beast_onslaught_custom_knockback:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_primal_beast_onslaught_custom_knockback:GetOverrideAnimation()
  return ACT_DOTA_FLAIL
end


function modifier_primal_beast_onslaught_custom_knockback:OnDestroy()
if not IsServer() then return end
self.parent:RemoveHorizontalMotionController( self )
self.parent:FadeGesture(ACT_DOTA_FLAIL)
self.parent:AddNewModifier(self.caster, self.ability, "modifier_primal_beast_onslaught_custom_slow", {duration = (1 - self.parent:GetStatusResistance())*self.slow_duration})
end





modifier_primal_beast_onslaught_custom_slow = class({})
function modifier_primal_beast_onslaught_custom_slow:IsHidden() return true end
function modifier_primal_beast_onslaught_custom_slow:IsPurgable() return true end
function modifier_primal_beast_onslaught_custom_slow:GetEffectName() return "particles/lina_attack_slow.vpcf" end
function modifier_primal_beast_onslaught_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end
function modifier_primal_beast_onslaught_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_primal_beast_onslaught_custom_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_primal_beast_onslaught_5", "slow")
end




modifier_primal_beast_onslaught_custom_stun_slow = class({})
function modifier_primal_beast_onslaught_custom_stun_slow:IsHidden() return true end
function modifier_primal_beast_onslaught_custom_stun_slow:IsPurgable() return true end
function modifier_primal_beast_onslaught_custom_stun_slow:GetEffectName() return "particles/lina_attack_slow.vpcf" end

function modifier_primal_beast_onslaught_custom_stun_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_primal_beast_onslaught_custom_stun_slow:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_primal_beast_onslaught_custom_stun_slow:GetModifierAttackSpeedBonus_Constant()
return self.attack
end

function modifier_primal_beast_onslaught_custom_stun_slow:OnCreated()
self.caster = self:GetCaster()
self.move = self.caster:GetTalentValue("modifier_primal_beast_onslaught_6", "move")
self.attack = self.caster:GetTalentValue("modifier_primal_beast_onslaught_6", "attack")
end

function modifier_primal_beast_onslaught_custom_stun_slow:CheckState()
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end











modifier_primal_beast_onslaught_custom_stacks = class({})
function modifier_primal_beast_onslaught_custom_stacks:IsHidden() return not self:GetCaster():HasTalent("modifier_primal_beast_onslaught_4") end
function modifier_primal_beast_onslaught_custom_stacks:IsPurgable() return false end
function modifier_primal_beast_onslaught_custom_stacks:RemoveOnDeath() return false end
function modifier_primal_beast_onslaught_custom_stacks:OnCreated()

self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_primal_beast_onslaught_4", "max", true)

if not IsServer() then return end 

self:SetStackCount(1)
self:StartIntervalThink(0.5)
end 

function modifier_primal_beast_onslaught_custom_stacks:OnRefresh(table)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
end


function modifier_primal_beast_onslaught_custom_stacks:OnIntervalThink()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_primal_beast_onslaught_4") then return end
if self:GetStackCount() < self.max then return end

local particle_peffect = ParticleManager:CreateParticle("particles/lc_odd_proc_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)
self.parent:EmitSound("BS.Thirst_legendary_active")

self:StartIntervalThink(-1)
end 


function modifier_primal_beast_onslaught_custom_stacks:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end 

function modifier_primal_beast_onslaught_custom_stacks:GetModifierSpellAmplify_Percentage()
if not self.parent:HasTalent("modifier_primal_beast_onslaught_4") then return end 
return self:GetStackCount()*(self.parent:GetTalentValue("modifier_primal_beast_onslaught_4", "damage")/self.max)
end 



modifier_primal_beast_onslaught_custom_damage = class({})
function modifier_primal_beast_onslaught_custom_damage:IsHidden() return false end
function modifier_primal_beast_onslaught_custom_damage:IsPurgable() return false end
function modifier_primal_beast_onslaught_custom_damage:GetTexture() return "buffs/Bloodrite_attack" end
function modifier_primal_beast_onslaught_custom_damage:OnCreated(table)
self.parent = self:GetParent()
if not IsServer() then return end
self:SetStackCount(table.damage)
end

function modifier_primal_beast_onslaught_custom_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_primal_beast_onslaught_custom_damage:GetModifierPreAttack_BonusDamage()
return self:GetStackCount()
end






modifier_primal_beast_onslaught_custom_shield = class({})
function modifier_primal_beast_onslaught_custom_shield:IsHidden() return true end
function modifier_primal_beast_onslaught_custom_shield:IsPurgable() return false end
function modifier_primal_beast_onslaught_custom_shield:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.shield_talent = "modifier_primal_beast_onslaught_3"
self.max_shield = self.caster:GetTalentValue("modifier_primal_beast_onslaught_3", "shield")
self.interval = 0.1
self.shield = 0

if not IsServer() then return end

self.shield_inc = (self.max_shield/self.ability:GetChargeTime())*self.interval

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_primal_beast_onslaught_custom_shield:OnIntervalThink()
if not IsServer() then return end 

local shield = math.min(self.max_shield, (self:GetStackCount() + self.shield_inc))

self:SetStackCount(shield)
if not self.caster:HasModifier("modifier_primal_beast_onslaught_custom_cast") then 
	self:StartIntervalThink(-1)
end

end


function modifier_primal_beast_onslaught_custom_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end


function modifier_primal_beast_onslaught_custom_shield:GetModifierIncomingDamageConstant( params )
if self:GetStackCount() == 0 then return end

if IsClient() then 
  if params.report_max then 
  	return self.max_shield
  else 
	  return self:GetStackCount()
	end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
    if not self.caster:HasModifier("modifier_primal_beast_onslaught_custom_cast") then 
    	self:Destroy()
  	end
end

return -damage
end