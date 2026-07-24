--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_marci_dispose_custom_knockback", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier("modifier_marci_dispose_custom_hits", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_dispose_custom_hits_slow", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_dispose_custom_legendary_count", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_dispose_custom_tracker", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_dispose_custom_slow", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_dispose_custom_swap", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_dispose_custom_health_reduce", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_dispose_custom_health_inc", "abilities/marci/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE )

marci_grapple_custom = class({})
marci_grapple_custom.talents = {}

function marci_grapple_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_attack_blur_l01.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_attack_blur_r01.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_attack_blur_r02.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_attack_blur_kick01.vpcf", context )

PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_aoe_damage.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_grapple.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_buff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce_impact_debuff.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_snapfire_slow.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire_debuff.vpcf", context )
PrecacheResource( "particle", "particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle", "particles/hoodwink/bush_damage.vpcf", context )
end

function marci_grapple_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_base = 0,
    q1_damage = 0,
    
    has_q2 = 0,
    q2_cd = 0,
    q2_range = 0,
    
    has_q3 = 0,
    q3_health_reduce = 0,
    q3_duration = caster:GetTalentValue("modifier_marci_dispose_3", "duration", true),
    q3_max = caster:GetTalentValue("modifier_marci_dispose_3", "max", true),
    
    has_q4 = 0,
    q4_range = caster:GetTalentValue("modifier_marci_dispose_4", "range", true),
    q4_cast_range = caster:GetTalentValue("modifier_marci_dispose_4", "cast_range", true),
    q4_stun = caster:GetTalentValue("modifier_marci_dispose_4", "stun", true),
    q4_damage = caster:GetTalentValue("modifier_marci_dispose_4", "damage", true)/100,
    q4_duration = caster:GetTalentValue("modifier_marci_dispose_4", "duration", true),
    q4_speed = caster:GetTalentValue("modifier_marci_dispose_4", "speed", true),

    has_q7 = 0,
    q7_count = caster:GetTalentValue("modifier_marci_dispose_7", "count", true),
    q7_duration = caster:GetTalentValue("modifier_marci_dispose_7", "duration", true),
  }
end

if caster:HasTalent("modifier_marci_dispose_1") then
  self.talents.has_q1 = 1
  self.talents.q1_base = caster:GetTalentValue("modifier_marci_dispose_1", "base")
  self.talents.q1_damage = caster:GetTalentValue("modifier_marci_dispose_1", "damage")/100
end

if caster:HasTalent("modifier_marci_dispose_2") then
  self.talents.has_q2 = 1
  self.talents.q2_cd = caster:GetTalentValue("modifier_marci_dispose_2", "cd")
  self.talents.q2_range = caster:GetTalentValue("modifier_marci_dispose_2", "range")
end

if caster:HasTalent("modifier_marci_dispose_3") then
  self.talents.has_q3 = 1
  self.talents.q3_health_reduce = caster:GetTalentValue("modifier_marci_dispose_3", "health_reduce")
end

if caster:HasTalent("modifier_marci_dispose_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_marci_dispose_7") then
  self.talents.has_q7 = 1
  if IsServer() and not self.q7_init then
  	self.q7_init = true
  	caster:AddSpellEvent(self.tracker, true)
  	self.tracker:UpdateUI()
	end
end

end

function marci_grapple_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_marci_dispose_custom_tracker"
end

function marci_grapple_custom:GetAbilityTextureName()
if self.caster:HasModifier("modifier_marci_dispose_custom_swap") then 
	return "dispose_knockback"
end
return "marci_grapple"
end

function marci_grapple_custom:GetCastAnimation()
if self.caster:HasModifier("modifier_marci_dispose_custom_swap") then 
	return ACT_DOTA_ATTACK
end
return ACT_DOTA_CAST_ABILITY_5
end

function marci_grapple_custom:GetAOERadius()
if self.caster:HasModifier("modifier_marci_dispose_custom_swap") then return end
return self.landing_radius and self.landing_radius or 0
end

function marci_grapple_custom:GetManaCost(iLevel)
if self.caster:HasModifier("modifier_marci_dispose_custom_swap") then return 0 end
return self.BaseClass.GetManaCost(self, iLevel)
end

function marci_grapple_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.q2_cd and self.talents.q2_cd or 0)
end

function marci_grapple_custom:GetDamage()
return self.impact_damage + self.talents.q1_base + self.talents.q1_damage*self.caster:GetMaxHealth()
end

function marci_grapple_custom:OnSpellStart()

local target = self:GetCursorTarget()

if target:TriggerSpellAbsorb( self ) then return end

local damage = self:GetDamage()
local damageTable = {attacker = self.caster, ability = self, damage_type = DAMAGE_TYPE_MAGICAL}

if IsValid(self.caster.unleash_ability) then
	self.caster.unleash_ability:Pulse(target:GetAbsOrigin(), true)
end

local mod = self.caster:FindModifierByName("modifier_marci_dispose_custom_swap")
if mod then
	for i = 1,2 do 
		local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster )
		ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
		ParticleManager:ReleaseParticleIndex( particle )
	end

	local damage_k = 1
	if target:IsCreep() then 
		damage_k = 1 + self.creeps
	end

	if IsValid(self.caster.rebound_ability) then
		self.caster.rebound_ability:ApplyProc(target)
	end

	damageTable.damage = damage*damage_k*self.talents.q4_damage
	damageTable.victim = target
	DoDamage(damageTable, "modifier_marci_dispose_4")

	local dir = (target:GetAbsOrigin() - self.caster:GetAbsOrigin()):Normalized()
	local point = self.caster:GetAbsOrigin() + dir*self.talents.q4_range
	local dist = (point - target:GetAbsOrigin()):Length()
	local knock_duration = dist/self.talents.q4_speed

	target:AddNewModifier(self.caster, self, "modifier_marci_dispose_custom_knockback", {dist = dist, duration = knock_duration})
	mod:Destroy()
	return
end

if self.talents.has_q4 == 1 then
	self.caster:AddNewModifier(self.caster, self, "modifier_marci_dispose_custom_swap", {duration = self.talents.q4_duration})
end

local targetpos = self.caster:GetOrigin() - self.caster:GetForwardVector() * self.throw_distance_behind

self:ApplyHealth(target)

for _,aoe_target in pairs(self.caster:FindTargets(self.landing_radius, target:GetOrigin())) do 

	local totaldist = (aoe_target:GetOrigin() - targetpos):Length2D()
	local damage_k = 1
	if aoe_target:IsCreep() then 
		totaldist = 0
		damage_k = 1 + self.creeps
	end

	self:PlayEffects3(aoe_target, self.air_duration)
	self:PlayEffects4()

	local arc = aoe_target:AddNewModifier( self.caster, ability, "modifier_generic_arc", 
	{ 
		target_x = targetpos.x, 
		target_y = targetpos.y, 
		duration = self.air_duration, 
		distance = totaldist, 
		height = self.air_height, 
		fix_end = false, 
		fix_duration = false, 
		isStun = true, 
		isForward = true, 
		activity = ACT_DOTA_FLAIL, 
	})
	
	if IsValid(self.caster.rebound_ability) then
		self.caster.rebound_ability:ApplyProc(aoe_target)
	end

	arc:SetEndCallback( function()
		aoe_target:AddNewModifier( self.caster, self, "modifier_marci_dispose_custom_slow", {duration = self.slow_duration*(1 - aoe_target:GetStatusResistance())})

		if self.caster:HasShard() then
			aoe_target:AddNewModifier(self.caster, self, "modifier_generic_silence", {duration = self.shard_silence*(1 - aoe_target:GetStatusResistance()), sound = "Sf.Raze_Silence"})
		end

		damageTable.damage = damage*damage_k
		damageTable.victim = aoe_target
		DoDamage(damageTable)

		if aoe_target == target then
			self:PlayEffects1(aoe_target:GetOrigin())
			GridNav:DestroyTreesAroundPoint(aoe_target:GetOrigin(), self.landing_radius, false)
		end
	end)
end

end

function marci_grapple_custom:PlayEffects1( point )
local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_dispose_land.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( particle, 0, point )
ParticleManager:ReleaseParticleIndex( particle )

local particle2 = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( particle2, 0, point )
ParticleManager:SetParticleControl( particle2, 1, Vector(self.landing_radius, 0, 0) )
ParticleManager:ReleaseParticleIndex( particle2 )

EmitSoundOnLocationWithCaster(point, "Hero_Marci.Grapple.Impact", self.caster)
EmitSoundOnLocationWithCaster(point, "Hero_Marci.Grapple.Stun", self.caster)
end

function marci_grapple_custom:PlayEffects3( target, duration )
local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf", PATTACH_POINT_FOLLOW, target )
ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:SetParticleControl( particle, 5, Vector( duration, 0, 0 ) )
ParticleManager:ReleaseParticleIndex( particle )

target:EmitSound("Hero_Marci.Grapple.Target")
end

function marci_grapple_custom:PlayEffects4()
local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_grapple.vpcf", PATTACH_POINT_FOLLOW, self.caster )
ParticleManager:SetParticleControlEnt( particle, 1, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle, 2, self.caster, PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true )
ParticleManager:ReleaseParticleIndex( particle )

self.caster:EmitSound("Hero_Marci.Grapple.Cast")
end


function marci_grapple_custom:ApplyHealth(target)
if not IsServer() then return end
if not self:IsTrained() then return end
if not target:IsRealHero() then return end
if self.talents.has_q3 == 0 then return end

target:AddNewModifier(self.caster, self, "modifier_marci_dispose_custom_health_reduce", {duration = self.talents.q3_duration})
end


modifier_marci_dispose_custom_slow = class(mod_visible)
function modifier_marci_dispose_custom_slow:IsPurgable() return not self.caster:HasShard() end
function modifier_marci_dispose_custom_slow:GetStatusEffectName() return "particles/status_fx/status_effect_snapfire_slow.vpcf" end
function modifier_marci_dispose_custom_slow:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end
function modifier_marci_dispose_custom_slow:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.ability.slow_move + (self.caster:HasShard() and self.ability.shard_slow or 0)

if not IsServer() then return end 
self.parent:GenericParticle("particles/units/heroes/hero_marci/marci_rebound_bounce_impact_debuff.vpcf", self)
end

function modifier_marci_dispose_custom_slow:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,	
}
end

function modifier_marci_dispose_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end




modifier_marci_dispose_custom_knockback = class(mod_hidden)
function modifier_marci_dispose_custom_knockback:OnCreated(params)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.cast_point = self.caster:GetAbsOrigin()

self.parent:StartGesture(ACT_DOTA_FLAIL)
self.tree_stun = false
self.knockback_duration = self:GetRemainingTime()
self.knockback_speed = self.ability.talents.q4_speed

self.ability:PlayEffects3(self.parent, self.knockback_duration)
self.ability:PlayEffects4()

self.position = GetGroundPosition(Vector(self.cast_point.x, self.cast_point.y, 0), nil)

if self:ApplyHorizontalMotionController() == false then 
  self:Destroy()
  return
end

end

function modifier_marci_dispose_custom_knockback:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end

local dir = (me:GetOrigin() - self.position):Normalized()
local check_pos = me:GetAbsOrigin() + dir*110
  
if GridNav:CanFindPath( me:GetOrigin(), check_pos ) then 
	me:SetOrigin( me:GetOrigin() + dir * self.knockback_speed * dt )
	return 
end

self.tree_stun = true
self:Destroy()
end

function modifier_marci_dispose_custom_knockback:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_marci_dispose_custom_knockback:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end

function modifier_marci_dispose_custom_knockback:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true
}
end

function modifier_marci_dispose_custom_knockback:OnDestroy()
if not IsServer() then return end
self.parent:RemoveHorizontalMotionController( self )
self.parent:FadeGesture(ACT_DOTA_FLAIL)

FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)

if not self.tree_stun then return end
self.ability:PlayEffects1(self.parent:GetAbsOrigin())
self.parent:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = self.ability.talents.q4_stun*(1 - self.parent:GetStatusResistance())})
end



modifier_marci_dispose_custom_tracker = class(mod_hidden)
function modifier_marci_dispose_custom_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.dispose_ability_legendary = self.parent:FindAbilityByName("marci_dispose_hits")
if self.parent.dispose_ability_legendary then
	self.parent.dispose_ability_legendary:UpdateTalents()
end

self.parent.dispose_ability = self.ability

self.ability.impact_damage = self.ability:GetSpecialValueFor("impact_damage")
self.ability.slow_move = self.ability:GetSpecialValueFor("slow_move")
self.ability.landing_radius = self.ability:GetSpecialValueFor("landing_radius")
self.ability.air_duration = self.ability:GetSpecialValueFor("air_duration")
self.ability.air_height = self.ability:GetSpecialValueFor("air_height")
self.ability.throw_distance_behind = self.ability:GetSpecialValueFor("throw_distance_behind")
self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
self.ability.creeps = self.ability:GetSpecialValueFor("creeps")/100
self.ability.shard_slow = self.ability:GetSpecialValueFor("shard_slow")
self.ability.shard_silence = self.ability:GetSpecialValueFor("shard_silence")
end

function modifier_marci_dispose_custom_tracker:OnRefresh()
self.ability.impact_damage = self.ability:GetSpecialValueFor("impact_damage")
self.ability.slow_move = self.ability:GetSpecialValueFor("slow_move")
end

function modifier_marci_dispose_custom_tracker:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_q7 == 0 then return end

local stack = 0
local max = self.ability.talents.q7_count
local mod = self.parent:FindModifierByName("modifier_marci_dispose_custom_legendary_count")
if mod then
  stack = mod:GetStackCount()
end

self.parent:UpdateUIlong({stack = stack, max = max, active = stack >= max and 1 or 0, style = "MarciDispose"})
end

function modifier_marci_dispose_custom_tracker:SpellEvent( params )
if not IsServer() then return end
if self.ability.talents.has_q7 == 0 then return end
if params.unit~=self.parent then return end
if params.ability:IsItem() then return end
if not self.parent.dispose_ability_legendary then return end
if self.parent.dispose_ability_legendary:GetCooldownTimeRemaining() > 0 then return end
if params.ability == self.parent.dispose_ability_legendary then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_marci_dispose_custom_legendary_count", {duration = self.ability.talents.q7_duration})
end

function modifier_marci_dispose_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
}
end

function modifier_marci_dispose_custom_tracker:GetModifierCastRangeBonusStacking()
return self.ability.talents.q2_range
end



modifier_marci_dispose_custom_swap = class(mod_hidden)
function modifier_marci_dispose_custom_swap:OnCreated()
if not IsServer() then return end 
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability:EndCd(0.5)
end 

function modifier_marci_dispose_custom_swap:OnDestroy()
if not IsServer() then return end 
self.ability:StartCd()

if self:GetRemainingTime() > 0.1 then return end
self.parent:CdAbility(self.ability, self.ability.talents.q4_duration)
end




modifier_marci_dispose_custom_health_reduce = class(mod_visible)
function modifier_marci_dispose_custom_health_reduce:GetTexture() return "buffs/marci/dispose_3" end
function modifier_marci_dispose_custom_health_reduce:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max_health = self.parent:GetMaxHealth()
self.max = self.ability.talents.q3_max
self.health = self.ability.talents.q3_health_reduce

if not IsServer() then return end
self.RemoveForDuel = true

self.duration = self:GetRemainingTime()

self:AddStack(table)
end

function modifier_marci_dispose_custom_health_reduce:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table)
end

function modifier_marci_dispose_custom_health_reduce:AddStack(table)
if not IsServer() then return end

if self:GetStackCount() < self.max then
	local stack = table.stack and table.stack or 1
	self:SetStackCount(math.min(self.max, self:GetStackCount() + stack))

	if self:GetStackCount() >= self.max then
	  self.parent:GenericParticle("particles/hoodwink/bush_damage.vpcf", self)
	end
end

self:SendHealth()
end

function modifier_marci_dispose_custom_health_reduce:SendHealth()
if not IsServer() then return end

local health = self.max_health*self.health*self:GetStackCount()/100

if not IsValid(self.health_mod) then
  self.health_mod = self.caster:AddNewModifier(self.caster, self.ability, "modifier_marci_dispose_custom_health_inc", {duration = self.duration, health = health})
else
  self.health_mod:SetDuration(self.duration, true)
  self.health_mod:AddHealth({health = health})
end

end

function modifier_marci_dispose_custom_health_reduce:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.parent:IsHero() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_marci_dispose_custom_health_reduce:OnDestroy()
if not IsServer() then return end
if IsValid(self.health_mod) then
  self.health_mod:Destroy()
end

self:OnStackCountChanged()
end

function modifier_marci_dispose_custom_health_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
}
end

function modifier_marci_dispose_custom_health_reduce:GetModifierExtraHealthPercentage()
return self.health*self:GetStackCount()*-1
end


modifier_marci_dispose_custom_health_inc = class(mod_visible)
function modifier_marci_dispose_custom_health_inc:GetTexture() return "buffs/marci/dispose_3" end
function modifier_marci_dispose_custom_health_inc:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_marci_dispose_custom_health_inc:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self:AddHealth(table)
end

function modifier_marci_dispose_custom_health_inc:AddHealth(table)
if not IsServer() then return end
self:SetStackCount(table.health)
self.parent:CalculateStatBonus(true)
end

function modifier_marci_dispose_custom_health_inc:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_marci_dispose_custom_health_inc:GetModifierHealthBonus()
return self:GetStackCount()
end


marci_dispose_hits = class({})
marci_dispose_hits.talents = {}

function marci_dispose_hits:CreateTalent()
self:SetHidden(false)
self:SetLevel(1)
self:SetActivated(false)
end

function marci_dispose_hits:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q7 = 0,
    q7_talent_cd = caster:GetTalentValue("modifier_marci_dispose_7", "talent_cd", true),
    q7_slow = caster:GetTalentValue("modifier_marci_dispose_7", "slow", true),
    q7_linger = caster:GetTalentValue("modifier_marci_dispose_7", "linger", true),
    q7_interval = caster:GetTalentValue("modifier_marci_dispose_7", "interval", true),
    q7_damage = caster:GetTalentValue("modifier_marci_dispose_7", "damage", true)/100,
    q7_channel = caster:GetTalentValue("modifier_marci_dispose_7", "channel", true),
    q7_range = caster:GetTalentValue("modifier_marci_dispose_7", "range", true),
  }
end

end

function marci_dispose_hits:GetChannelTime()
return (self.talents.q7_channel and self.talents.q7_channel or 0)
end

function marci_dispose_hits:GetCooldown()
return self.talents.q7_talent_cd and self.talents.q7_talent_cd or 0
end

function marci_dispose_hits:GetCastRange(vLocation, hTarget)
return self.talents.q7_range and self.talents.q7_range
end

function marci_dispose_hits:OnSpellStart()
local point = self:GetCursorPosition()

if point == self.caster:GetAbsOrigin() then
	point = self.caster:GetAbsOrigin() + self.caster:GetForwardVector()*10
end

if IsValid(self.caster.unleash_ability) then
	self.caster.unleash_ability:Pulse(self.caster:GetAbsOrigin(), true)
end

local dir = point - self.caster:GetAbsOrigin()
dir.z = 0

self.caster:RemoveModifierByName("modifier_marci_dispose_custom_legendary_count")

self.caster:SetForwardVector(dir:Normalized())
self.caster:FaceTowards(point)
self.caster:AddNewModifier(self.caster, self, "modifier_marci_dispose_custom_hits", {duration = self:GetChannelTime()})
end

function marci_dispose_hits:OnChannelFinish(bInterrupted)
self.caster:RemoveModifierByName("modifier_marci_dispose_custom_hits")
end

modifier_marci_dispose_custom_hits = class(mod_hidden)
function modifier_marci_dispose_custom_hits:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.distance = self.ability.talents.q7_range + self.parent:GetCastRangeBonus()
self.width = 200
self.interval = self.ability.talents.q7_interval
self.slow_duration = self.ability.talents.q7_linger
self.max = self.ability.talents.q7_channel/self.interval

if not IsServer() then return end
self.parent:EmitSound("Marci.Dispose_legendary")

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_buff.vpcf", PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 1, self.parent, PATTACH_POINT_FOLLOW, "eye_l", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle, 2, self.parent, PATTACH_POINT_FOLLOW, "eye_r", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle, 4, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle, 5, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle, 6, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true )
self:AddParticle( particle, false, false, -1, false, false  )

if IsValid(self.parent.dispose_ability) then
	self.parent.dispose_ability:PlayEffects4()
else
	self:Destroy()
	return
end

self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = self.parent.dispose_ability:GetDamage()*self.ability.talents.q7_damage/self.max}
self:StartIntervalThink(0.1)
end

function modifier_marci_dispose_custom_hits:OnIntervalThink()
if not IsServer() then return end
self:IncrementStackCount()

self.parent:FadeGesture(ACT_DOTA_ATTACK)
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
self.parent:EmitSound("Marci.Dispose_hits_pre")

self.target_abs = self.parent:GetForwardVector()*self.distance + self.parent:GetAbsOrigin()

for i = 1,3 do
	local dist = self.distance
	if i ~= 1 then
		dist = self.distance*RandomFloat(0.2, 0.9)
	end

	local point = self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*dist
	point.z = point.z + 100

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( particle, 1, point)
	ParticleManager:DestroyParticle(particle, false)
	ParticleManager:ReleaseParticleIndex( particle )
end

local attack = FindUnitsInLine(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.target_abs, nil, self.width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE)
for _,enemy in pairs(attack) do 
	enemy:AddNewModifier(self.parent, self.ability, "modifier_marci_dispose_custom_hits_slow", {duration = self.slow_duration})
	self.damageTable.victim = enemy
	DoDamage(self.damageTable)

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:DestroyParticle(particle, false)
	ParticleManager:ReleaseParticleIndex( particle )

	enemy:EmitSound("Marci.Dispose_hits")
end

if self:GetStackCount() >= self.max then
	self:Destroy()
	return
end

self:StartIntervalThink(self.interval - 0.01)
end

function modifier_marci_dispose_custom_hits:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_marci_dispose_custom_hits:GetActivityTranslationModifiers()
if self:GetStackCount() ~= self.max then return end
return "flurry_pulse_attack"
end 


modifier_marci_dispose_custom_hits_slow = class(mod_hidden)
function modifier_marci_dispose_custom_hits_slow:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability.talents.q7_slow
end

function modifier_marci_dispose_custom_hits_slow:CheckState()
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end

function modifier_marci_dispose_custom_hits_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_marci_dispose_custom_hits_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_marci_dispose_custom_legendary_count = class(mod_hidden)
function modifier_marci_dispose_custom_legendary_count:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_count
self.radius = 1000
self.duration = self.ability.talents.q7_duration
if not IsServer() then return end

self:OnRefresh()
self:StartIntervalThink(1)
end

function modifier_marci_dispose_custom_legendary_count:OnIntervalThink()
if not IsServer() then return end
local targets = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #targets > 0 then
  self:SetDuration(self.duration, true)
end

end

function modifier_marci_dispose_custom_legendary_count:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self.ability.tracker then
  self.ability.tracker:UpdateUI()
end

if self:GetStackCount() >= self.max then
	if IsValid(self.parent.dispose_ability_legendary) then
		self.parent.dispose_ability_legendary:SetActivated(true)
	end
end

end

function modifier_marci_dispose_custom_legendary_count:OnDestroy()
if not IsServer() then return end

if self.ability.tracker then
  self.ability.tracker:UpdateUI()
end

if IsValid(self.parent.dispose_ability_legendary) then
	self.parent.dispose_ability_legendary:SetActivated(false)
end

end