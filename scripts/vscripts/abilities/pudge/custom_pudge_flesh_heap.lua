--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_pudge_flesh_heap_stack","abilities/pudge/custom_pudge_flesh_heap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_flesh_heap_tempo_count","abilities/pudge/custom_pudge_flesh_heap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_flesh_heap","abilities/pudge/custom_pudge_flesh_heap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_flesh_heap_hit_cd","abilities/pudge/custom_pudge_flesh_heap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_flesh_heap_charge","abilities/pudge/custom_pudge_flesh_heap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_flesh_heap_charge_active","abilities/pudge/custom_pudge_flesh_heap", LUA_MODIFIER_MOTION_HORIZONTAL)



custom_pudge_flesh_heap = class({})


function custom_pudge_flesh_heap:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/status_fx/status_effect_grimstroke_dark_artistry.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pudge/pudge_fleshheap_status_effect.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_undying/undying_fg_aura.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pudge/pudge_fleshheap_block_activation.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_undying/undying_decay_strength_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pudge/pudge_fleshheap_count.vpcf", context )
PrecacheResource( "particle","particles/econ/items/centaur/centaur_ti9/flesh_bash.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf", context )
PrecacheResource( "particle","particles/pudge/meat_lowhealth.vpcf", context )
PrecacheResource( "particle","particles/pudge/meat_charge.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", context )
end


function custom_pudge_flesh_heap:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "pudge_flesh_heap", self)
end

function custom_pudge_flesh_heap:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_pudge_flesh_heap_stack"
end

function custom_pudge_flesh_heap:GetManaCost(level)
if self:GetCaster():HasTalent("modifier_pudge_flesh_6") then 
    return 0 
end
return self.BaseClass.GetManaCost(self,level)
end

function custom_pudge_flesh_heap:GetCooldown(iLevel)
local bonus = 0
local caster = self:GetCaster()
if caster:HasTalent("modifier_pudge_flesh_1") then
	bonus = caster:GetTalentValue("modifier_pudge_flesh_1", "cd")
end 
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end


function custom_pudge_flesh_heap:GetBehavior()
local bonus = 0
if self:GetCaster():HasModifier("modifier_custom_pudge_flesh_heap_charge") then
	bonus = DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + bonus
end


function custom_pudge_flesh_heap:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration") + caster:GetTalentValue("modifier_pudge_flesh_1", "duration")
local mod = caster:FindModifierByName("modifier_custom_pudge_flesh_heap_charge")

self:EndCd()

if mod then
	local dist = caster:GetTalentValue("modifier_pudge_flesh_6", "range")
	local point = caster:GetAbsOrigin() + caster:GetForwardVector()*dist
	local duration = dist/caster:GetTalentValue("modifier_pudge_flesh_6", "speed")

	caster:AddNewModifier(caster, self, "modifier_custom_pudge_flesh_heap_charge_active", {x = point.x, y = point.y, duration = duration})
	mod:Destroy()
	return
end

if caster:HasTalent("modifier_pudge_flesh_6") then
	caster:AddNewModifier(caster, self, "modifier_custom_pudge_flesh_heap_charge", {duration = duration})
	self:SetActivated(true)
	self:StartCooldown(0.5)
end

caster:RemoveModifierByName("modifier_custom_pudge_flesh_heap_tempo_count")
caster:AddNewModifier(caster, self, "modifier_custom_pudge_flesh_heap", {duration = duration})
end




modifier_custom_pudge_flesh_heap = class({})
function modifier_custom_pudge_flesh_heap:IsHidden() return false end
function modifier_custom_pudge_flesh_heap:IsPurgable() return false end
function modifier_custom_pudge_flesh_heap:GetStatusEffectName()
if self:GetParent():HasTalent("modifier_pudge_flesh_legendary") then
	return "particles/status_fx/status_effect_grimstroke_dark_artistry.vpcf"
else 
	return "particles/units/heroes/hero_pudge/pudge_fleshheap_status_effect.vpcf"
end

end

function modifier_custom_pudge_flesh_heap:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end

function modifier_custom_pudge_flesh_heap:GetEffectName()
return "particles/units/heroes/hero_pudge/pudge_fleshheap_block_activation.vpcf"
end

function modifier_custom_pudge_flesh_heap:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_scale = self.parent:GetTalentValue("modifier_pudge_flesh_legendary", "model", true)
self.legendary_speed = self.parent:GetTalentValue("modifier_pudge_flesh_legendary", "speed", true)

self.damage_block = self.ability:GetSpecialValueFor("damage_block")
if not IsServer() then return end

self.RemoveForDuel = true

if self.parent:HasTalent("modifier_pudge_flesh_legendary") then 
	self.parent:EmitSound("Pudge.Flesh_active")
	self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_ROT)

	self.parent:GenericParticle("particles/units/heroes/hero_undying/undying_fg_aura.vpcf", self)

	self.hands = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_decay_strength_buff.vpcf",PATTACH_ABSORIGIN_FOLLOW,self.parent)
	ParticleManager:SetParticleControlEnt(self.hands,0,self.parent,PATTACH_ABSORIGIN_FOLLOW,"follow_origin",self.parent:GetOrigin(),false)
	self:AddParticle(self.hands,true,false,0,false,false)
end

if self.parent:HasTalent("modifier_pudge_flesh_3") then
	self.parent:AddPercentStat({str = self.parent:GetTalentValue("modifier_pudge_flesh_3", "str")/100}, self)
end

end

function modifier_custom_pudge_flesh_heap:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
end


function modifier_custom_pudge_flesh_heap:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
}
end

function modifier_custom_pudge_flesh_heap:GetModifierTotal_ConstantBlock(params)
return self.damage_block
end

function modifier_custom_pudge_flesh_heap:GetModifierModelScale()
if not self.parent:HasTalent("modifier_pudge_flesh_legendary") then return end
return self.legendary_scale
end

function modifier_custom_pudge_flesh_heap:GetModifierAttackSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_pudge_flesh_legendary") then return end
return self.legendary_speed
end






modifier_custom_pudge_flesh_heap_stack = class({})

function modifier_custom_pudge_flesh_heap_stack:IsHidden()
if not self.parent:HasTalent("modifier_pudge_flesh_5") then return true end
if self.parent:PassivesDisabled() then return true end
return self.parent:GetHealthPercent() > self.low_health
end

function modifier_custom_pudge_flesh_heap_stack:IsPurgable() return false end
function modifier_custom_pudge_flesh_heap_stack:RemoveOnDeath() return false end
function modifier_custom_pudge_flesh_heap_stack:GetTexture() return "buffs/flesh_lowhp" end

function modifier_custom_pudge_flesh_heap_stack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_duration = self.parent:GetTalentValue("modifier_pudge_flesh_legendary", "duration", true)

self.heal_creeps = self.parent:GetTalentValue("modifier_pudge_flesh_2", "creeps", true)
self.heal_bonus = self.parent:GetTalentValue("modifier_pudge_flesh_2", "bonus", true)

self.low_health = self.parent:GetTalentValue("modifier_pudge_flesh_5", "health", true)
self.low_status = self.parent:GetTalentValue("modifier_pudge_flesh_5", "status", true)
self.low_reduce = self.parent:GetTalentValue("modifier_pudge_flesh_5", "damage_reduce", true)
self.low_bonus = self.parent:GetTalentValue("modifier_pudge_flesh_5", "bonus", true)
self.low_max = self.parent:GetTalentValue("modifier_pudge_flesh_5", "max", true)

self.stun_duration = self.parent:GetTalentValue("modifier_pudge_flesh_4", "stun", true)
self.stun_damage = self.parent:GetTalentValue("modifier_pudge_flesh_4", "damage", true)/100
self.stun_heal = self.parent:GetTalentValue("modifier_pudge_flesh_4", "heal", true)/100

self.parent:AddAttackEvent_out(self)
self.parent:AddDamageEvent_out(self)

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_custom_pudge_flesh_heap_stack:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local mod = self.parent:FindModifierByName("modifier_custom_pudge_flesh_heap")

if self.parent:HasTalent("modifier_pudge_flesh_legendary") and mod then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_pudge_flesh_heap_tempo_count", {duration = mod:GetRemainingTime() + self.legendary_duration})
end


if not self.parent:HasTalent("modifier_pudge_flesh_4") then return end
if self.parent:PassivesDisabled() then return end
if self.parent:HasModifier("modifier_custom_pudge_flesh_heap_hit_cd") then return end 

params.target:EmitSound("Pudge.Flesh_bash")
self.parent:EmitSound("Pudge.Flesh_hit")

local forward = (params.target:GetOrigin()-self.parent:GetOrigin()):Normalized()

local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/centaur/centaur_ti9/flesh_bash.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target )
ParticleManager:SetParticleControlEnt(effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true)
ParticleManager:SetParticleControlEnt(effect_cast, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetOrigin(), true)
ParticleManager:SetParticleControl( effect_cast, 2, params.target:GetOrigin() )
ParticleManager:SetParticleControl( effect_cast, 3, params.target:GetAbsOrigin())
ParticleManager:SetParticleControl( effect_cast, 5, params.target:GetOrigin() )
ParticleManager:SetParticleControl( effect_cast, 6, Vector(150,1,1) )
ParticleManager:ReleaseParticleIndex( effect_cast )

local damage = DoDamage({victim = params.target, attacker = self.parent, damage = self.parent:GetStrength()*self.stun_damage, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}, "modifier_pudge_flesh_4")
self.parent:GenericHeal(damage*self.stun_heal, self.ability, false, "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf", "modifier_pudge_flesh_4")

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_pudge_flesh_heap_hit_cd", {duration = self.parent:GetTalentValue("modifier_pudge_flesh_4", "cd")})
params.target:AddNewModifier(self.parent, self.ability, "modifier_bashed", {duration = (1 - params.target:GetStatusResistance())*self.stun_duration})
end

function modifier_custom_pudge_flesh_heap_stack:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_pudge_flesh_2") then return end
if not self.parent:CheckLifesteal(params) then return end

local particle = ""
local heal = params.damage*self.parent:GetTalentValue("modifier_pudge_flesh_2", "heal")/100
if params.unit:IsCreep() then
	heal = heal/self.heal_creeps
end

if self.parent:HasModifier("modifier_custom_pudge_flesh_heap") then
	particle = nil
	heal = heal*self.heal_bonus
end

self.parent:GenericHeal(heal, self.ability, true, particle, "modifier_pudge_flesh_2")
end


function modifier_custom_pudge_flesh_heap_stack:CheckState()
if not self.parent:HasTalent("modifier_pudge_flesh_4") then return end
if self.parent:HasModifier("modifier_custom_pudge_flesh_heap_hit_cd") then return end
return
{
	[MODIFIER_STATE_CANNOT_MISS] = true
}
end


function modifier_custom_pudge_flesh_heap_stack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_custom_pudge_flesh_heap_stack:GetModifierStatusResistanceStacking()
if not self.parent:HasTalent("modifier_pudge_flesh_5") then return end
if self.parent:PassivesDisabled() then return end
if self.parent:GetHealthPercent() > self.low_health then return end
local bonus = self.low_status 
if self.parent:HasModifier("modifier_pudge_innate_custom") then
	bonus = bonus + self.low_bonus*self.parent:GetUpgradeStack("modifier_pudge_innate_custom")
end
return math.min(bonus, self.low_max)
end


function modifier_custom_pudge_flesh_heap_stack:GetModifierIncomingDamage_Percentage()
if not self.parent:HasTalent("modifier_pudge_flesh_5") then return end
if self.parent:PassivesDisabled() then return end
if self.parent:GetHealthPercent() > self.low_health then return end
local bonus = self.low_reduce 
if self.parent:HasModifier("modifier_pudge_innate_custom") then
	bonus = bonus + self.low_bonus*self.parent:GetUpgradeStack("modifier_pudge_innate_custom")
end
return math.min(bonus, self.low_max)*-1
end


function modifier_custom_pudge_flesh_heap_stack:OnIntervalThink()
if not IsServer() then return end

if not self.parent:HasModifier("modifier_custom_pudge_flesh_heap") and not self.ability:IsActivated() then
	self.ability:StartCd()
end

if not self.parent:HasTalent("modifier_pudge_flesh_5") then return end
if not self.parent:IsAlive() then return end

if (self.parent:GetHealthPercent() > self.low_health or self.parent:PassivesDisabled()) and self.particle then
	ParticleManager:DestroyParticle(self.particle, false)
	ParticleManager:ReleaseParticleIndex(self.particle)
	self.particle = nil
end

if (self.parent:GetHealthPercent() <= self.low_health and not self.parent:PassivesDisabled()) and not self.particle then
	self.particle = ParticleManager:CreateParticle( "particles/pudge/meat_lowhealth.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_OVERHEAD_FOLLOW, nil, self.parent:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(self.particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), true)
	self:AddParticle(self.particle,true,false,0,false,false)

	self.parent:EmitSound("Pudge.Meat_lowhealth")
end

self:StartIntervalThink(0.2)
end






modifier_custom_pudge_flesh_heap_tempo_count = class({})
function modifier_custom_pudge_flesh_heap_tempo_count:IsHidden() return false end
function modifier_custom_pudge_flesh_heap_tempo_count:IsPurgable() return false end
function modifier_custom_pudge_flesh_heap_tempo_count:GetTexture() return "buffs/quill_cdr" end
function modifier_custom_pudge_flesh_heap_tempo_count:OnCreated(table)
if not IsServer() then return end
self.RemoveForDuel = true
self.parent = self:GetParent()

local mod = self.parent:FindModifierByName("modifier_pudge_innate_custom")
if mod then
	mod:IncrementStackCount()
end

self:SetStackCount(1)
end

function modifier_custom_pudge_flesh_heap_tempo_count:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()

local mod = self.parent:FindModifierByName("modifier_pudge_innate_custom")
if mod then
	mod:IncrementStackCount()
end

end


function modifier_custom_pudge_flesh_heap_tempo_count:OnDestroy()
if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_pudge_innate_custom")
if mod then
	mod:SetStackCount(math.max(0, mod:GetStackCount() - self:GetStackCount()))
end

end


modifier_custom_pudge_flesh_heap_hit_cd = class({})
function modifier_custom_pudge_flesh_heap_hit_cd:IsHidden() return false end
function modifier_custom_pudge_flesh_heap_hit_cd:IsPurgable() return false end
function modifier_custom_pudge_flesh_heap_hit_cd:IsDebuff() return true end
function modifier_custom_pudge_flesh_heap_hit_cd:RemoveOnDeath() return false end
function modifier_custom_pudge_flesh_heap_hit_cd:GetTexture() return "buffs/flesh_hit" end
function modifier_custom_pudge_flesh_heap_hit_cd:OnCreated(table)
self.RemoveForDuel = true
end



modifier_custom_pudge_flesh_heap_charge = class({})
function modifier_custom_pudge_flesh_heap_charge:IsHidden() return true end
function modifier_custom_pudge_flesh_heap_charge:IsPurgable() return false end



modifier_custom_pudge_flesh_heap_charge_active = class({})
function modifier_custom_pudge_flesh_heap_charge_active:IsHidden() return true end
function modifier_custom_pudge_flesh_heap_charge_active:IsPurgable() return false end

function modifier_custom_pudge_flesh_heap_charge_active:OnCreated(kv)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddOrderEvent(self)

self.turn_speed = 70
self.target_angle = self.parent:GetAnglesAsVector().y
self.current_angle = self.target_angle
self.face_target = true

self.speed = self.parent:GetTalentValue("modifier_pudge_flesh_6", "speed")
self.parent:EmitSound("Pudge.Meat_charge_start")
self.parent:EmitSound("Pudge.Meat_charge_start2")

self.point = GetGroundPosition(Vector(kv.x, kv.y, 0), nil)
self.angle = self.parent:GetForwardVector():Normalized()
self.distance = (self.point - self.parent:GetAbsOrigin()):Length2D() / ( self:GetDuration() / FrameTime())

self.knock_distance = self.parent:GetTalentValue("modifier_pudge_flesh_6", "distance")
self.knock_height = self.parent:GetTalentValue("modifier_pudge_flesh_6", "height")
self.knock_duration = self.parent:GetTalentValue("modifier_pudge_flesh_6", "duration")
self.knock_radius = self.parent:GetTalentValue("modifier_pudge_flesh_6", "width")
self.knock_stun = self.parent:GetTalentValue("modifier_pudge_flesh_6", "stun")

self.parent:GenericParticle("particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", self)

if self:ApplyHorizontalMotionController() == false then
    self:Destroy()
end

end

function modifier_custom_pudge_flesh_heap_charge_active:GetEffectName() 
return --return "particles/pudge/meat_charge.vpcf" 
end

function modifier_custom_pudge_flesh_heap_charge_active:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DISABLE_TURNING,
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
}
end

function modifier_custom_pudge_flesh_heap_charge_active:GetActivityTranslationModifiers()
return "haste"
end

function modifier_custom_pudge_flesh_heap_charge_active:OrderEvent( params )

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


function modifier_custom_pudge_flesh_heap_charge_active:SetDirection( location )
local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
self.target_angle = VectorToAngles( dir ).y
self.face_target = false
end


function modifier_custom_pudge_flesh_heap_charge_active:TurnLogic( dt )
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


function modifier_custom_pudge_flesh_heap_charge_active:GetOverrideAnimation()
return ACT_DOTA_RUN
end

function modifier_custom_pudge_flesh_heap_charge_active:GetModifierDisableTurning() return 1 end
function modifier_custom_pudge_flesh_heap_charge_active:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_custom_pudge_flesh_heap_charge_active:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL  end

function modifier_custom_pudge_flesh_heap_charge_active:OnDestroy()
if not IsServer() then return end
self.parent:InterruptMotionControllers( true )

local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end


function modifier_custom_pudge_flesh_heap_charge_active:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end

if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsRooted() then 
	self:Destroy()
	return
end
local targets = self.parent:FindTargets(self.knock_radius)
if #targets > 0 then 
	self.parent:EmitSound("Pudge.Meat_charge_hit")

	for _,enemy in pairs(self.parent:FindTargets(self.knock_radius*2)) do 

		local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, enemy)
		ParticleManager:SetParticleControlEnt(hit_effect, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), false) 
		ParticleManager:SetParticleControlEnt(hit_effect, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), false) 
		ParticleManager:ReleaseParticleIndex(hit_effect)

		local direction = enemy:GetOrigin()-self.parent:GetOrigin()
		direction.z = 0
		direction = direction:Normalized()

		enemy:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = (1 - enemy:GetStatusResistance())*self.knock_stun})

		local knockbackProperties =
	  	{
	      center_x = self.parent:GetOrigin().x,
	      center_y = self.parent:GetOrigin().y,
	      center_z = self.parent:GetOrigin().z,
	      duration = self.knock_duration,
	      knockback_duration = self.knock_duration,
	      knockback_distance = self.knock_distance,
	      knockback_height = self.knock_height,
	      should_stun = 0,
	  	}
	    enemy:AddNewModifier( self.parent, self.ability, "modifier_knockback", knockbackProperties )
	end 
	self:Destroy()
	return
end

self:TurnLogic( dt )
local nextpos = me:GetOrigin() + me:GetForwardVector() * self.speed * dt
me:SetOrigin(nextpos)
GridNav:DestroyTreesAroundPoint(nextpos, self.knock_radius*0.75, true)
end


function modifier_custom_pudge_flesh_heap_charge_active:OnHorizontalMotionInterrupted()
self:Destroy()
end

function modifier_custom_pudge_flesh_heap_charge_active:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_DISARMED] = true
}
end
