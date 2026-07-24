--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_monkey_king_tree_dance_custom", "abilities/monkey_king/monkey_king_tree_dance_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_monkey_king_tree_dance_custom_tracker", "abilities/monkey_king/monkey_king_tree_dance_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_monkey_king_tree_dance_vision", "abilities/monkey_king/monkey_king_tree_dance_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_monkey_king_tree_dance_custom_activity", "abilities/monkey_king/monkey_king_tree_dance_custom", LUA_MODIFIER_MOTION_NONE )

monkey_king_tree_dance_custom = class({})
monkey_king_tree_dance_custom.talents = {}

function monkey_king_tree_dance_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_shredder_whirl.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", context )

end

function monkey_king_tree_dance_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_h4 = 0,
    h4_tree_cd = caster:GetTalentValue("modifier_monkey_king_hero_4", "tree_cd", true),
  	
    has_h5 = 0,
    h5_speed = caster:GetTalentValue("modifier_monkey_king_hero_5", "speed", true)/100,
  }
end

if caster:HasTalent("modifier_monkey_king_hero_4") then
  self.talents.has_h4 = 1
end

if caster:HasTalent("modifier_monkey_king_hero_5") then
  self.talents.has_h5 = 1
end

end

function monkey_king_tree_dance_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "monkey_king_tree_dance", self)
end

function monkey_king_tree_dance_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_monkey_king_tree_dance_custom_tracker"
end

function monkey_king_tree_dance_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel)
end

function monkey_king_tree_dance_custom:GetCastPoint()
if self.caster:HasModifier("modifier_monkey_king_tree_dance_custom") then
	return self.tree_cast and self.tree_cast or 0
end
return self.BaseClass.GetCastPoint(self)
end

function monkey_king_tree_dance_custom:OnAbilityPhaseStart()
local mod = self.caster:FindModifierByName("modifier_monkey_king_tree_dance_custom")
if mod and mod.tree and mod.tree == self:GetCursorTarget() then
	return false
end
return tree
end

function monkey_king_tree_dance_custom:OnSpellStart()

local tree = self:GetCursorTarget()
local speed = self.leap_speed * (1 + (self.talents.has_h5 == 1 and self.talents.h5_speed or 0))
local perched_spot_height = self.perched_spot_height
local dir = (tree:GetOrigin() - self.caster:GetOrigin())
dir.z = 0
local distance = dir:Length2D()
local duration = distance / speed
local start_offset = 0

if self.caster:HasModifier("modifier_monkey_king_tree_dance_custom") then
	start_offset = perched_spot_height
end

self.caster:RemoveModifierByName("modifier_monkey_king_innate_custom")
self.caster:RemoveGesture(ACT_DOTA_MK_SPRING_END)

self.caster:FaceTowards(tree:GetAbsOrigin())
self.caster:SetForwardVector(dir:Normalized())

local modifier = self.caster:AddNewModifier(self.caster, self, "modifier_generic_arc", 
{
	target_x = tree:GetOrigin().x, 
	target_y = tree:GetOrigin().y,
	distance = distance, 
	speed = speed, 
	height = perched_spot_height, 
	fix_end = false, 
	fix_height = false, 
	isStun = true, 
	activity = ACT_DOTA_MK_TREE_SOAR, 
	start_offset = start_offset, 
	end_offset = perched_spot_height
})

if not modifier then return end

modifier:SetEndCallback(function()
	if IsValid(tree) then 
		self.caster:AddNewModifier( self.caster, self, "modifier_monkey_king_tree_dance_custom", {tree = tree:entindex()})
	else 
		FindClearSpaceForUnit(self.caster, self.caster:GetAbsOrigin(), false)
	end
end)

self.caster:GenericParticle("particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf", modifier)
self.caster:EmitSound("Hero_MonkeyKing.TreeJump.Cast")

self:StartCooldown(duration + self:GetCooldown(self:GetLevel()))
end


modifier_monkey_king_tree_dance_custom_tracker = class(mod_hidden)
function modifier_monkey_king_tree_dance_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.leap_speed = self.ability:GetSpecialValueFor("leap_speed")
self.ability.jump_damage_cooldown = self.ability:GetSpecialValueFor("jump_damage_cooldown")
self.ability.perched_vision = self.ability:GetSpecialValueFor("perched_vision")
self.ability.perched_spot_height = self.ability:GetSpecialValueFor("perched_spot_height")
self.ability.unperched_stunned_duration = self.ability:GetSpecialValueFor("unperched_stunned_duration")  
self.ability.tree_cast = self.ability:GetSpecialValueFor("tree_cast")                      

self.parent:AddDamageEvent_inc(self, true)
end 

function modifier_monkey_king_tree_dance_custom_tracker:DamageEvent_inc( params )
if not IsServer() then return end
if self.parent:HasModifier( "modifier_monkey_king_tree_dance_custom" ) then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
if params.unit ~= self.parent then return end

local attacker = params.attacker

if self.parent:GetTeamNumber() == attacker:GetTeamNumber() then return end
if not players[attacker:GetId()] and not attacker:IsBuilding() then return end
if params.damage < 3 then return end

local cd = self.ability.jump_damage_cooldown + (self.ability.talents.has_h4 == 1 and self.ability.talents.h4_tree_cd or 0)

self.ability:StartCooldown(cd)
end


modifier_monkey_king_tree_dance_custom = class(mod_hidden)
function modifier_monkey_king_tree_dance_custom:OnCreated( kv )
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.perched_spot_height = self.ability.perched_spot_height
self.perched_vision = self.ability.perched_vision
self.unperched_stunned_duration = self.ability.unperched_stunned_duration

if not IsServer() then return end

self.parent:AddOrderEvent(self)
self.parent:AddNewModifier(self.parent, self.ability, "modifier_monkey_king_tree_dance_hidden", {})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_monkey_king_tree_dance_custom_activity", {})

self.tree = EntIndexToHScript(kv.tree)
self.origin = self.tree:GetOrigin()

if not self:ApplyHorizontalMotionController() or not self:ApplyVerticalMotionController() then
	self.interrupted = true
	self:Destroy()
end

self.parent:EmitSound("Hero_MonkeyKing.TreeJump.Tree")
self:StartIntervalThink(0.1)
end

function modifier_monkey_king_tree_dance_custom:OnIntervalThink()
if not IsServer() then return end

if (self.tree.IsStanding and not self.tree:IsStanding()) or self.tree:IsNull() then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_stunned", { duration = self.unperched_stunned_duration*(1 - self.parent:GetStatusResistance())})
	self.unperched = true
	self:Destroy()
end

end

function modifier_monkey_king_tree_dance_custom:UpdateHorizontalMotion( me, dt )
me:SetOrigin( self.origin )
end

function modifier_monkey_king_tree_dance_custom:UpdateVerticalMotion( me, dt )
me:SetOrigin( self.origin + Vector(0, 0, self.perched_spot_height) )
end

function modifier_monkey_king_tree_dance_custom:OnDestroy()
if not IsServer() then return end

local pos = self.parent:GetOrigin()

self.parent:RemoveModifierByName("modifier_monkey_king_tree_dance_hidden")
self.parent:RemoveHorizontalMotionController( self )
self.parent:RemoveVerticalMotionController( self )

if not self.unperched then
	self.parent:SetOrigin(pos)
end

if not self.target_point then 
	self.parent:RemoveModifierByName("modifier_monkey_king_tree_dance_custom_activity")
	return 
end

local parent = self.parent
local point = self.target_point
local distance = 150
local height = self.perched_spot_height
local speed = 550
local duration = distance/speed

local direction = (point - parent:GetOrigin())
direction.z = 0
direction = direction:Normalized()

parent:SetForwardVector(direction)

local modifier = parent:AddNewModifier(parent, nil, "modifier_generic_arc", 
{ 
	dir_x = direction.x, 
	activity = ACT_DOTA_MK_STRIKE_END, 
	dir_y = direction.y, 
	distance = distance, 
	speed = speed, 
	height = 1, 
	start_offset = height, 
	fix_end = false, 
	isForward = true 
})

if modifier then
	modifier:SetEndCallback(function()
		FindClearSpaceForUnit( parent, parent:GetOrigin(), true )
	end)
	self.parent:RemoveModifierByName("modifier_monkey_king_tree_dance_custom_activity")
	parent:GenericParticle("particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf", modifier)
end

self.ability:StartCooldown(duration + self.ability:GetCooldown(self.ability:GetLevel()))
end

function modifier_monkey_king_tree_dance_custom:OrderEvent( params )
if not IsServer() then return end
if params.order_type ~= DOTA_UNIT_ORDER_MOVE_TO_POSITION and params.order_type ~= DOTA_UNIT_ORDER_MOVE_TO_TARGET and params.order_type ~= DOTA_UNIT_ORDER_ATTACK_TARGET then return end

if not self.ability:IsCooldownReady() then
	local order = 
	{
		UnitIndex = self.parent:entindex(),
		OrderType = DOTA_UNIT_ORDER_STOP,
	}
	ExecuteOrderFromTable(order)
	return
end

local pos = params.pos
if params.target then 
	pos = params.target:GetOrigin() 
end

self.target_point = pos
self:Destroy()
end

function modifier_monkey_king_tree_dance_custom:CheckState()
return 
{
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
}
end

function modifier_monkey_king_tree_dance_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_FIXED_DAY_VISION,
	MODIFIER_PROPERTY_FIXED_NIGHT_VISION,
}
end

function modifier_monkey_king_tree_dance_custom:GetFixedDayVision()
return self.perched_vision
end

function modifier_monkey_king_tree_dance_custom:GetFixedNightVision()
return self.perched_vision
end

function modifier_monkey_king_tree_dance_custom:OnVerticalMotionInterrupted()
self:Destroy()
end

function modifier_monkey_king_tree_dance_custom:OnHorizontalMotionInterrupted()
self:Destroy()
end

function modifier_monkey_king_tree_dance_custom:GetAuraRadius()
return 600
end

function modifier_monkey_king_tree_dance_custom:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_monkey_king_tree_dance_custom:GetAuraSearchType() 
return DOTA_UNIT_TARGET_HERO
end

function modifier_monkey_king_tree_dance_custom:GetAuraSearchFlags()
return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES +  DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD +  DOTA_UNIT_TARGET_FLAG_INVULNERABLE +  DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
end

function modifier_monkey_king_tree_dance_custom:GetModifierAura()
return "modifier_monkey_king_tree_dance_vision"
end

function modifier_monkey_king_tree_dance_custom:IsAura()
return IsServer() and self.parent:IsAlive() and self.parent:IsOnDuel()
end


modifier_monkey_king_tree_dance_vision = class(mod_hidden)
function modifier_monkey_king_tree_dance_vision:CheckState()
return
{
	[MODIFIER_STATE_FORCED_FLYING_VISION] = true
}
end



modifier_monkey_king_tree_dance_custom_activity = class(mod_hidden)
function modifier_monkey_king_tree_dance_custom_activity:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_monkey_king_tree_dance_custom_activity:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

--self.parent:Stop()
end

function modifier_monkey_king_tree_dance_custom_activity:OnDestroy()
if not IsServer() then return end
self.parent:Stop()
self.parent:RemoveGesture(ACT_DOTA_IDLE)
end

function modifier_monkey_king_tree_dance_custom_activity:GetActivityTranslationModifiers()
return "perch"
end

function modifier_monkey_king_tree_dance_custom_activity:GetOverrideAnimation()
return ACT_DOTA_IDLE
end