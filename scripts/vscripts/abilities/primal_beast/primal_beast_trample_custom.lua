--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_primal_beast_trample_custom", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_tracker", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_speed", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_slow", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_damage", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_charge", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_primal_beast_trample_silence_stack", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_quest", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_scepter_attack", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_scepter_slow", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_trample_custom_haste", "abilities/primal_beast/primal_beast_trample_custom", LUA_MODIFIER_MOTION_NONE )

primal_beast_trample_custom = class({})

function primal_beast_trample_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_disarm.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_lifesteal.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/ascetic_cap.vpcf", context ) 
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", context )
PrecacheResource( "particle","particles/beast_silence.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_silenced.vpcf", context )
end



function primal_beast_trample_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_primal_beast_trample_tracker"
end


function primal_beast_trample_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_primal_beast_trample_6") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_primal_beast_trample_6", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end


function primal_beast_trample_custom:OnSpellStart()
if not IsServer() then return end

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor( "duration" ) + caster:GetTalentValue("modifier_primal_beast_trample_3", "duration")

if caster:HasTalent("modifier_primal_beast_trample_7") then 
	local ability = caster:FindAbilityByName("primal_beast_charge_custom")
	if ability then 
		ability:StartCooldown(0.2)
	end
	caster:SwapAbilities( "primal_beast_trample_custom", "primal_beast_charge_custom", false, true )
end

if caster:HasTalent("modifier_primal_beast_trample_5") then 
	caster:AddNewModifier(caster, self, "modifier_primal_beast_trample_speed", {duration = duration})
	caster:AddNewModifier(caster, self, "modifier_primal_beast_trample_custom_haste", {duration = caster:GetTalentValue("modifier_primal_beast_trample_5", "duration")})
end

caster:RemoveModifierByName("modifier_primal_beast_trample_damage")
caster:AddNewModifier( caster, self, "modifier_primal_beast_trample_custom", { duration = duration } )
end



function primal_beast_trample_custom:Trample(damage_ability)
local caster = self:GetCaster()
local radius = self:GetSpecialValueFor( "effect_radius" ) + caster:GetTalentValue("modifier_primal_beast_trample_6", "radius")
local base_damage = self:GetSpecialValueFor( "base_damage" )
local attack_damage = (self:GetSpecialValueFor( "attack_damage" ) + caster:GetTalentValue("modifier_primal_beast_trample_1", "damage"))/100
local sound = "Hero_PrimalBeast.Trample"

local source = nil
if damage_ability then
	sound = "PBeast.Trample_mini" 
	source = damage_ability
	radius = radius + caster:GetTalentValue("modifier_primal_beast_trample_1", "radius")
end

local pos = caster:GetOrigin()
local enemies = caster:FindTargets(radius) 
local damage = base_damage + caster:GetAverageTrueAttackDamage(nil) * attack_damage
local damageTable = { attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }

local ult = caster:FindAbilityByName("primal_beast_pulverize_custom")
local stack_duration = caster:GetTalentValue("modifier_primal_beast_trample_4", "duration")
local damage_duration = caster:GetTalentValue("modifier_primal_beast_trample_7", "duration")
local mod = caster:FindModifierByName("modifier_primal_beast_trample_custom")

if #enemies > 0 then 
	if mod and  caster:HasTalent("modifier_primal_beast_trample_7") then 
		caster:AddNewModifier(caster, self, "modifier_primal_beast_trample_damage", {duration =  mod:GetRemainingTime() + damage_duration})
	end

	if mod and mod.ult_count then 
		mod.ult_count = mod.ult_count + 1
		if mod.ult_count >= caster:GetTalentValue("modifier_primal_beast_pulverize_7", "trample", true) then 
			mod.ult_count = 0
			if ult and ult:IsTrained() then 
				ult:AddLegendaryStack()
			end
		end
	end
	
end

for _,enemy in pairs(enemies) do
	damageTable.victim = enemy

	if mod and ult and ult:IsTrained() and enemy:IsHero() then 
		enemy:AddNewModifier(caster, ult, "modifier_primal_beast_pulverize_custom_trample_count", {duration = mod:GetRemainingTime() + 0.1})
	end

	local current_damage = damage
	damageTable.damage = current_damage
	DoDamage(damageTable, source)
	enemy:SendNumber(4, current_damage)

	if mod and caster:HasTalent("modifier_primal_beast_trample_4") then 
		enemy:AddNewModifier(caster, self, "modifier_primal_beast_trample_slow", {duration = mod:GetRemainingTime() + stack_duration})
	end

	if caster:GetQuest() == "Beast.Quest_6" and enemy:IsRealHero() and not caster:QuestCompleted() then 
		enemy:AddNewModifier(caster, self, "modifier_primal_beast_trample_quest", {duration = 1})
	end

	if caster:HasTalent("modifier_primal_beast_trample_6") and mod and mod.silence_targets and not mod.silence_targets[enemy:entindex()] then 
		enemy:AddNewModifier(caster, self, "modifier_primal_beast_trample_silence_stack", {duration = mod:GetRemainingTime() + 0.1})
	end
end

self:PlayEffects(radius, sound)
end



function primal_beast_trample_custom:PlayEffects(radius, sound)

local caster = self:GetCaster()

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf", PATTACH_ABSORIGIN, caster )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0, 0 ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
caster:EmitSound(sound)
end





modifier_primal_beast_trample_custom = class({})

function modifier_primal_beast_trample_custom:IsPurgable() return false end
function modifier_primal_beast_trample_custom:IsHidden() return false end

function modifier_primal_beast_trample_custom:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.step_distance = self.ability:GetSpecialValueFor( "step_distance" )
self.radius = self.ability:GetSpecialValueFor( "effect_radius" )

self.move_bonus = self.parent:GetTalentValue("modifier_primal_beast_trample_3", "move")

if not IsServer() then return end
self.silence_targets = {}
self.ability:EndCd()

self.RemoveForDuel = true
self.ult_count = 0
self.distance = 0
self.treshold = 500
self.currentpos = self.parent:GetOrigin()
self:StartIntervalThink( 0.1 )
self.ability:Trample()
end


function modifier_primal_beast_trample_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
}
end

function modifier_primal_beast_trample_custom:GetActivityTranslationModifiers()
return "heavy_steps"
end

function modifier_primal_beast_trample_custom:GetModifierMoveSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_primal_beast_trample_3") then return end
return self.move_bonus
end

function modifier_primal_beast_trample_custom:CheckState()
if not self.parent:HasScepter() then 
	return 
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
else 
	return 
	{
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

end

function modifier_primal_beast_trample_custom:OnIntervalThink()
local pos = self.parent:GetOrigin()
local dist = (pos-self.currentpos):Length2D()
self.currentpos = pos
GridNav:DestroyTreesAroundPoint( pos, self.radius, false )
if dist>self.treshold then return end

self.distance = self.distance + dist
if self.distance > self.step_distance then
	self.ability:Trample()
	self.distance = 0
end

end


function modifier_primal_beast_trample_custom:GetEffectName()
if self.parent:HasScepter() then return end
return "particles/units/heroes/hero_primal_beast/primal_beast_disarm.vpcf"
end

function modifier_primal_beast_trample_custom:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end


function modifier_primal_beast_trample_custom:OnDestroy()
if not IsServer() then return end

self.ability:StartCd()

if self.parent:HasTalent("modifier_primal_beast_trample_7") and self.ability:IsHidden() then 
	self.parent:SwapAbilities( "primal_beast_trample_custom", "primal_beast_charge_custom", true, false )
end

end





modifier_primal_beast_trample_tracker = class({})
function modifier_primal_beast_trample_tracker:IsHidden() return true end
function modifier_primal_beast_trample_tracker:IsPurgable() return false end


function modifier_primal_beast_trample_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_creeps = self.parent:GetTalentValue("modifier_primal_beast_trample_2", "creeps", true)
self.heal_bonus = self.parent:GetTalentValue("modifier_primal_beast_trample_2", "bonus", true)

self.parent:AddDamageEvent_out(self)
self.parent:AddSpellEvent(self)

if not IsServer() then return end 
self:StartIntervalThink(1)
end

function modifier_primal_beast_trample_tracker:OnIntervalThink()
if not self.parent:HasTalent("modifier_primal_beast_trample_1") then return end 
if not self.parent:IsAlive() then return end

self.ability:Trample("modifier_primal_beast_trample_1")
self:StartIntervalThink(self.parent:GetTalentValue("modifier_primal_beast_trample_1", "cd"))
end


function modifier_primal_beast_trample_tracker:SpellEvent( params )
if not IsServer() then return end
if not self.parent:HasScepter() then return end
if params.unit~=self.parent then return end
if params.ability:IsItem() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_primal_beast_trample_scepter_attack", {})
end


function modifier_primal_beast_trample_tracker:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_primal_beast_trample_2") then return end
if not self.parent:CheckLifesteal(params, 0) then return end

local heal = self.parent:GetTalentValue("modifier_primal_beast_trample_2", "heal")*params.damage/100
local hide_number = true

if params.inflictor and params.inflictor == self.ability then 
	hide_number = false
	heal = heal*self.heal_bonus
end

if params.unit:IsCreep() then 
	heal = heal / self.heal_creeps
end

self.parent:GenericHeal(heal, self.ability, hide_number, nil, "modifier_primal_beast_trample_2")
end






modifier_primal_beast_trample_scepter_attack = class({})
function modifier_primal_beast_trample_scepter_attack:IsHidden() return true end
function modifier_primal_beast_trample_scepter_attack:IsPurgable() return false end


function modifier_primal_beast_trample_scepter_attack:CheckState()
return
{
	[MODIFIER_STATE_CANNOT_MISS] = true
}
end


function modifier_primal_beast_trample_scepter_attack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddAttackEvent_out(self)
end


function modifier_primal_beast_trample_scepter_attack:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local target = params.target
local radius = self.ability:GetSpecialValueFor("scepter_radius")
local damage = self.parent:GetAverageTrueAttackDamage(nil)*self.ability:GetSpecialValueFor("scepter_damage")/100
local duration = self.ability:GetSpecialValueFor("scepter_duration")

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, target:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
ParticleManager:DestroyParticle( effect_cast, false )
ParticleManager:ReleaseParticleIndex( effect_cast )
EmitSoundOnLocationWithCaster( target:GetOrigin(), "Hero_PrimalBeast.Pulverize.Impact", self.parent )

local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
local damageTable = { attacker = self.parent, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_NONE, }

for _,enemy in pairs(enemies) do 
	damageTable.victim = enemy
	DoDamage(damageTable, "scepter")
	SendOverheadEventMessage( nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, enemy, damage, nil )
	enemy:AddNewModifier(self.parent, self.ability, "modifier_primal_beast_trample_scepter_slow", {duration = (1 - enemy:GetStatusResistance())*duration})
end

self:Destroy()
end


modifier_primal_beast_trample_scepter_slow = class({})
function modifier_primal_beast_trample_scepter_slow:IsHidden() return false end
function modifier_primal_beast_trample_scepter_slow:IsPurgable() return true end
function modifier_primal_beast_trample_scepter_slow:OnCreated()
self.slow = self:GetAbility():GetSpecialValueFor("scepter_slow")
self.attack = self:GetAbility():GetSpecialValueFor("scepter_attack_slow")
end

function modifier_primal_beast_trample_scepter_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_primal_beast_trample_scepter_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_primal_beast_trample_scepter_slow:GetModifierAttackSpeedBonus_Constant()
return self.attack
end



modifier_primal_beast_trample_speed = class({})
function modifier_primal_beast_trample_speed:IsHidden() return false end
function modifier_primal_beast_trample_speed:IsPurgable() return false end
function modifier_primal_beast_trample_speed:GetTexture() return "buffs/bloodlust_resist" end
function modifier_primal_beast_trample_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_primal_beast_trample_speed:GetModifierIncomingDamage_Percentage()
return self.damage_reduce*(self:GetStackCount()/self.stack)
end


function modifier_primal_beast_trample_speed:GetModifierStatusResistanceStacking() 
return self.status*(self:GetStackCount()/self.stack)
end


function modifier_primal_beast_trample_speed:OnCreated(table)

self.parent = self:GetParent()
self.stack = self.parent:GetTalentValue("modifier_primal_beast_trample_5", "stack")
self.status = self.parent:GetTalentValue("modifier_primal_beast_trample_5", "status")
self.damage_reduce = self.parent:GetTalentValue("modifier_primal_beast_trample_5", "damage_reduce")

if not IsServer() then return end
self.parent:GenericParticle("particles/items4_fx/ascetic_cap.vpcf", self)
self:SetStackCount(self.stack)
self:StartIntervalThink(self:GetRemainingTime()/self.stack)
end

function modifier_primal_beast_trample_speed:OnIntervalThink()
if not IsServer() then return end
self:DecrementStackCount()
end










modifier_primal_beast_trample_slow = class({})
function modifier_primal_beast_trample_slow:IsHidden() return false end
function modifier_primal_beast_trample_slow:IsPurgable() return false end
function modifier_primal_beast_trample_slow:GetTexture() return "buffs/trample_stack" end
function modifier_primal_beast_trample_slow:OnCreated(table)

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.max = self.caster:GetTalentValue("modifier_primal_beast_trample_4", "max")
self.slow = self.caster:GetTalentValue("modifier_primal_beast_trample_4", "slow")/self.max
self.damage = self.caster:GetTalentValue("modifier_primal_beast_trample_4", "damage")/self.max
if not IsServer() then return end

self.effect_cast = self.parent:GenericParticle("particles/beast_silence.vpcf", self, true)
self:SetStackCount(1)
end

function modifier_primal_beast_trample_slow:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_primal_beast_trample_slow:OnStackCountChanged(iStackCount)
if not self.effect_cast then return end

if self:GetStackCount() < self.max or true then 
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
else 
	ParticleManager:DestroyParticle(self.effect_cast, true)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	self.effect_cast = nil
	self.parent:EmitSound("Item.StarEmblem.Enemy")
	self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
end

end

function modifier_primal_beast_trample_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_primal_beast_trample_slow:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.slow
end

function modifier_primal_beast_trample_slow:GetModifierIncomingDamage_Percentage(params)
if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then return end 
return self:GetStackCount()*self.damage
end



modifier_primal_beast_trample_damage = class({})
function modifier_primal_beast_trample_damage:IsHidden() return false end
function modifier_primal_beast_trample_damage:IsPurgable() return false end
function modifier_primal_beast_trample_damage:GetTexture() return "buffs/bulwark_face" end
function modifier_primal_beast_trample_damage:OnCreated(table)

self.caster = self:GetCaster()
self.damage = self.caster:GetTalentValue("modifier_primal_beast_trample_7", "damage")
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_primal_beast_trample_damage:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()
end

function modifier_primal_beast_trample_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_primal_beast_trample_damage:GetModifierDamageOutgoing_Percentage()
return self:GetStackCount()*self.damage
end





modifier_primal_beast_trample_charge = class({})

function modifier_primal_beast_trample_charge:IsPurgable() return false end
function modifier_primal_beast_trample_charge:IsHidden() return true end
function modifier_primal_beast_trample_charge:CheckState()
return 
{
	[MODIFIER_STATE_DISARMED] = true,
}
end


function modifier_primal_beast_trample_charge:OnCreated( kv )
self.parent = self:GetParent()
self.speed = self:GetAbility():GetSpecialValueFor("speed")
self.turn_speed = 70

if not IsServer() then return end
self.parent:AddOrderEvent(self)

self.target_angle = self.parent:GetAnglesAsVector().y
self.current_angle = self.target_angle
self.face_target = true

if not self:ApplyHorizontalMotionController() then
self:Destroy()
return
end

end

function modifier_primal_beast_trample_charge:OnDestroy()
if not IsServer() then return end
self.parent:RemoveHorizontalMotionController(self)
FindClearSpaceForUnit( self.parent, self.parent:GetOrigin(), false )
end

function modifier_primal_beast_trample_charge:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
}
end

function modifier_primal_beast_trample_charge:OrderEvent( params )

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
	params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
then
	self:Destroy()
end	
end

function modifier_primal_beast_trample_charge:GetModifierDisableTurning()
return 1
end

function modifier_primal_beast_trample_charge:SetDirection( location )
local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
self.target_angle = VectorToAngles( dir ).y
self.face_target = false
end

function modifier_primal_beast_trample_charge:GetOverrideAnimation()
return ACT_DOTA_RUN
end

function modifier_primal_beast_trample_charge:GetActivityTranslationModifiers()
return "onslaught_movement"
end

function modifier_primal_beast_trample_charge:TurnLogic( dt )
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



function modifier_primal_beast_trample_charge:UpdateHorizontalMotion( me, dt )
self:TurnLogic( dt )
local nextpos = me:GetOrigin() + me:GetForwardVector() * self.speed * dt
me:SetOrigin(nextpos)
end

function modifier_primal_beast_trample_charge:OnHorizontalMotionInterrupted()
self:Destroy()
end

function modifier_primal_beast_trample_charge:GetEffectName()
return "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
end

function modifier_primal_beast_trample_charge:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_primal_beast_trample_charge:PlayEffects( target, radius )
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
target:EmitSound("Hero_PrimalBeast.Onslaught.Hit")
end




primal_beast_charge_custom = class({})

function primal_beast_charge_custom:GetCooldown()
return self:GetCaster():GetTalentValue("modifier_primal_beast_trample_7", "cd")
end

function primal_beast_charge_custom:OnSpellStart()
if not IsServer() then return end
local caster = self:GetCaster()
local duration = caster:GetTalentValue("modifier_primal_beast_trample_7", "distance")/self:GetSpecialValueFor("speed")
caster:AddNewModifier(caster, self, "modifier_primal_beast_trample_charge", {duration = duration})
end





modifier_primal_beast_trample_silence_stack = class({})
function modifier_primal_beast_trample_silence_stack:IsHidden() return true end
function modifier_primal_beast_trample_silence_stack:IsPurgable() return false end
function modifier_primal_beast_trample_silence_stack:GetTexture() return "buffs/trample_silence" end
function modifier_primal_beast_trample_silence_stack:OnCreated(table)
if not IsServer() then return end

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.silence = self.caster:GetTalentValue("modifier_primal_beast_trample_6", "silence")
self.max = self.caster:GetTalentValue("modifier_primal_beast_trample_6", "max")
self.RemoveForDuel = true
self:SetStackCount(1)
end

function modifier_primal_beast_trample_silence_stack:OnRefresh(table)
if not IsServer() then return end 
self:IncrementStackCount()

if self:GetStackCount() >= self.max then

	local mod = self.caster:FindModifierByName("modifier_primal_beast_trample_custom")

	if mod and mod.silence_targets and not mod.silence_targets[self.parent:entindex()] then 
		mod.silence_targets[self.parent:entindex()] = true
		self.parent:EmitSound("PBeast.Trample_silence")
		self.parent:AddNewModifier(self.caster, self.ability, "modifier_generic_silence", {duration = (1 - self.parent:GetStatusResistance())*self.silence})
	end

	self:Destroy()
end

end





modifier_primal_beast_trample_quest = class({})
function modifier_primal_beast_trample_quest:IsHidden() return true end
function modifier_primal_beast_trample_quest:IsPurgable() return false end
function modifier_primal_beast_trample_quest:OnCreated(table)
if not IsServer() then return end

self:SetStackCount(1)
end

function modifier_primal_beast_trample_quest:OnRefresh(table)
if not IsServer() then return end
if not self:GetCaster():GetQuest() or self:GetCaster():QuestCompleted() then return end

self:IncrementStackCount()

if self:GetStackCount() >= self:GetCaster().quest.number then
	self:GetCaster():UpdateQuest(1)
	self:Destroy()
end


end





modifier_primal_beast_trample_custom_haste = class({})

function modifier_primal_beast_trample_custom_haste:IsHidden() return true end
function modifier_primal_beast_trample_custom_haste:IsPurgable() return false end
function modifier_primal_beast_trample_custom_haste:GetEffectName()
return "particles/generic_gameplay/rune_haste_owner.vpcf"
end

function modifier_primal_beast_trample_custom_haste:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end


function modifier_primal_beast_trample_custom_haste:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end