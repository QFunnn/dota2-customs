--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_take_aim_custom", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_legendary", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_legendary_unit", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_legendary_damage", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_active", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_damage", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_armor", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_block", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_damage_reduce", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_no_count_move", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom_break", "abilities/sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )

sniper_take_aim_custom = class({})

function sniper_take_aim_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end


PrecacheResource( "particle","particles/items3_fx/blink_swift_buff.vpcf", context ) 
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle","particles/sniper_aim_blink.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_forcestaff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_swift_buff.vpcf", context ) 
PrecacheResource( "particle","particles/lc_odd_proc_hands.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_snapfire_slow.vpcf", context )
PrecacheResource( "particle","particles/sniper_matrix.vpcf", context )
PrecacheResource( "particle","particles/sniper_shield_hit.vpcf", context )
PrecacheResource( "particle","particles/hoodwink/bush_damage.vpcf", context )
PrecacheResource( "particle","particles/sniper/aim_block.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_take_aim_overhead.vpcf", context )

end


sniper_take_aim_custom.projectiles = {}

function sniper_take_aim_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_sniper_aim_1") then  
	upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_sniper_aim_1", "cd")
end 
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function sniper_take_aim_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sniper_take_aim_custom"
end

function sniper_take_aim_custom:GetManaCost(iLevel)
if self:GetCaster():HasTalent("modifier_sniper_aim_5") then
	return 0
end
return self.BaseClass.GetManaCost(self,iLevel)
end 


function sniper_take_aim_custom:OnSpellStart()

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

if caster:HasTalent("modifier_sniper_aim_7") then
	caster:EmitSound("Sniper.Headshot_legendary_voice")
	duration = caster:GetTalentValue("modifier_sniper_aim_7", "duration")
else 
	caster:EmitSound("Hero_Sniper.TakeAim.Cast")
end

duration = duration + caster:GetTalentValue("modifier_sniper_aim_1", "duration")

if caster:HasTalent("modifier_sniper_aim_5") then
	caster:AddNewModifier(caster, self, "modifier_sniper_take_aim_custom_block", {duration = caster:GetTalentValue("modifier_sniper_aim_5", "duration")})
	caster:AddNewModifier(caster, self, "modifier_sniper_take_aim_custom_damage_reduce", {})
end

caster:AddNewModifier(caster, self, "modifier_sniper_take_aim_custom_active", {duration = duration})
end



function sniper_take_aim_custom:OnProjectileThink_ExtraData(location, data)
if not IsServer() then return end
if not data.index or not self.projectiles or not self.projectiles[data.index] then return end
if not data.thinker then return end

local caster = self:GetCaster()
local thinker =  EntIndexToHScript(data.thinker)

if thinker == nil or thinker:IsNull() then return end
if not EntIndexToHScript(data.thinker):HasModifier("modifier_sniper_take_aim_custom_legendary_unit") then return end

local width = caster:GetTalentValue("modifier_sniper_aim_7", "width")
local enemies = FindUnitsInRadius( caster:GetTeamNumber(), location, nil, width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
local hit = false

for _,enemy in pairs(enemies) do 
	if enemy:GetUnitName() ~= "npc_teleport" and not enemy:HasModifier("modifier_skeleton_king_reincarnation_custom_legendary") then 

		hit = true
		if not caster:HasModifier("modifier_sniper_take_aim_custom_active") then 
			caster:AddNewModifier(caster, self, "modifier_sniper_take_aim_custom_legendary_damage", {})
		end

		caster:PerformAttack(enemy, false, true, true, true, false, false, false)
		local particle_aoe_fx = ParticleManager:CreateParticle("particles/sniper_legendary_attacka.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
		ParticleManager:SetParticleControlEnt( particle_aoe_fx, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		ParticleManager:SetParticleControlEnt( particle_aoe_fx, 3, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		ParticleManager:DestroyParticle(particle_aoe_fx, false)
		ParticleManager:ReleaseParticleIndex(particle_aoe_fx) 

		caster:RemoveModifierByName("modifier_sniper_take_aim_custom_legendary_damage")
		break
	end
end

if hit == true then 
	UTIL_Remove(thinker)
	--ProjectileManager:DestroyTrackingProjectile(self.projectiles[data.index])
end

end



modifier_sniper_take_aim_custom = class({})
function modifier_sniper_take_aim_custom:IsHidden() return true end
function modifier_sniper_take_aim_custom:IsPurgable() return false end

function modifier_sniper_take_aim_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end

function modifier_sniper_take_aim_custom:GetModifierStatusResistanceStacking() 
if not self.parent:HasTalent("modifier_sniper_aim_2") then return end
return self.parent:GetTalentValue("modifier_sniper_aim_2", "status")
end

function modifier_sniper_take_aim_custom:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()
end




modifier_sniper_take_aim_custom_active = class({})
function modifier_sniper_take_aim_custom_active:IsHidden() return false end
function modifier_sniper_take_aim_custom_active:IsPurgable() return false end

function modifier_sniper_take_aim_custom_active:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability:GetSpecialValueFor("active_slow")
self.range = self.ability:GetSpecialValueFor("active_range")
self.armor = self.ability:GetSpecialValueFor("active_armor")

self.lifesteal = self.parent:GetTalentValue("modifier_sniper_aim_2", "heal")/100
self.creeps = self.parent:GetTalentValue("modifier_sniper_aim_2", "creeps", true)

self.damage_duration = self.parent:GetTalentValue("modifier_sniper_aim_3", "duration", true)

if self.parent:HasTalent("modifier_sniper_aim_2") then
	self.parent:AddDamageEvent_out(self)
end

if self.parent:HasTalent("modifier_sniper_aim_3") or self.parent:HasTalent("modifier_sniper_aim_6") then
	self.parent:AddAttackEvent_out(self)
end

self.leash_duration = self.parent:GetTalentValue("modifier_sniper_aim_6", "leash", true)
self.leashed = false

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_sniper/sniper_take_aim_overhead.vpcf", self, true)

if not self.parent:HasTalent("modifier_sniper_aim_7") then return end

self.parent:AddOrderEvent(self)

self.parent:EmitSound("Sniper.Headshot_legendary")
self.damage = self.parent:GetTalentValue("modifier_sniper_aim_7", "damage") - 100
self.width = self.parent:GetTalentValue("modifier_sniper_aim_7", "width")
self.distance = self.parent:GetTalentValue("modifier_sniper_aim_7", "distance")
self.attack_pause = self.parent:GetTalentValue("modifier_sniper_aim_7", "interval")
self.auto = self.parent:GetTalentValue("modifier_sniper_aim_7", "auto")
self.turn_speed = self.parent:GetTalentValue("modifier_sniper_aim_7", "turn")
self.random_factor = self.parent:GetTalentValue("modifier_sniper_aim_7", "random_factor")
self.speed = self.parent:GetTalentValue("modifier_sniper_aim_7", "speed")

self.drow_back = 35

self.anim_return = 0
self.origin = self.parent:GetOrigin()
self.charge_finish = false
self.target_angle = self.parent:GetAnglesAsVector().y
self.current_angle = self.target_angle
self.face_target = true

self.count = 0
self.interval = FrameTime()

self:StartIntervalThink(self.interval)
end

function modifier_sniper_take_aim_custom_active:CheckState()
local table_state = {}

if self.parent:HasTalent("modifier_sniper_aim_7") then
	table_state[MODIFIER_STATE_DISARMED] = true
	table_state[MODIFIER_STATE_SILENCED] = true
end

if self.parent:HasTalent("modifier_sniper_aim_6") then
	table_state[MODIFIER_STATE_CANNOT_MISS] = true
end

return table_state
end


function modifier_sniper_take_aim_custom_active:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sniper_aim_2") then return end
if not self.parent:CheckLifesteal(params) then return end

local heal = params.damage*self.lifesteal
if params.unit:IsCreep() then
	heal = heal/self.creeps
end
self.parent:GenericHeal(heal, self.ability, true, nil, "modifier_sniper_aim_2")
end

function modifier_sniper_take_aim_custom_active:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

if self.parent:HasTalent("modifier_sniper_aim_3") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_sniper_take_aim_custom_damage", {duration = self.damage_duration})
end

if self.parent:HasTalent("modifier_sniper_aim_6") and params.target:IsHero() and self.leashed == false then
	self.leashed = true
	params.target:AddNewModifier(self.parent, self.ability, "modifier_sniper_take_aim_custom_break", {duration = (1 - params.target:GetStatusResistance())*self.leash_duration})
end

end



function modifier_sniper_take_aim_custom_active:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sniper_aim_7") then return end

self.count = self.count + self.interval

if self.parent:IsHexed() or self.parent:IsStunned() then 
	return
end

if self.count >= self.attack_pause then 
	self.count = 0
	self.parent:FadeGesture(ACT_DOTA_ATTACK)
	self.parent:StartGesture(ACT_DOTA_ATTACK)

	local point = self.parent:GetForwardVector()*self.distance + self.parent:GetAbsOrigin()
	local thinker = CreateModifierThinker( self.parent,  self.ability,  "modifier_sniper_take_aim_custom_legendary_unit",   { duration = (0.90*self.distance)/self.speed}, point, self.parent:GetTeamNumber(),  false )

	local index = #self.ability.projectiles + 1

	self.ability.projectiles[index] =  ProjectileManager:CreateTrackingProjectile({
	    Target = thinker,
        EffectName = "particles/sniper_legendary_attack.vpcf",
        Ability = self.ability,
	    iMoveSpeed = self.speed,
	    bDodgeable = false, 
        vSpawnOrigin = self.parent:GetAbsOrigin(),
        vSourceLoc = self.parent:GetAttachmentOrigin(self.parent:ScriptLookupAttachment("attach_attack1")),
        Source = self.parent,
        bDeleteOnHit = true,
        bProvidesVision = true,
        iVisionTeamNumber = self.parent:GetTeamNumber(),
        iVisionRadius = 100,
        ExtraData = {index = index, thinker = thinker:entindex()},
	})

	self.parent:EmitSound("Sniper.Headshot_legendary_attack")
	FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin() - self.parent:GetForwardVector()*(self.drow_back*self.attack_pause), false)
end

local qangle_rotation_rate = -self.random_factor + self.random_factor*2*(RandomInt(0, 1))
local line_position = self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 400
local qangle = QAngle(0, qangle_rotation_rate, 0)
line_position = RotatePosition(self.parent:GetAbsOrigin() , qangle, line_position)

self:AutoTurn( line_position )
self:TurnLogic( FrameTime() )
end

function modifier_sniper_take_aim_custom_active:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
}
end

function modifier_sniper_take_aim_custom_active:GetModifierAttackRangeBonus()
return self.range
end

function modifier_sniper_take_aim_custom_active:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_sniper_take_aim_custom_active:GetModifierPhysicalArmorBonus()
return self.armor
end

function modifier_sniper_take_aim_custom_active:GetModifierDamageOutgoing_Percentage()
if not self.parent:HasTalent("modifier_sniper_aim_7") then return end
return self.damage
end

function modifier_sniper_take_aim_custom_active:GetModifierMoveSpeed_Limit()
if not self.parent:HasTalent("modifier_sniper_aim_7") then return end
return 0.1
end

function modifier_sniper_take_aim_custom_active:GetModifierDisableTurning()
if not self.parent:HasTalent("modifier_sniper_aim_7") then return end
return 1
end

function modifier_sniper_take_aim_custom_active:OrderEvent( params )
if not self.parent:HasTalent("modifier_sniper_aim_7") then return end


if 	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
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

function modifier_sniper_take_aim_custom_active:SetDirection( location )
local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
self.target_angle = VectorToAngles( dir ).y
self.face_target = false
end

function modifier_sniper_take_aim_custom_active:TurnLogic( dt )
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


function modifier_sniper_take_aim_custom_active:AutoTurn(location)

local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
local target_angle = VectorToAngles( dir ).y

local angle_diff = AngleDiff( self.current_angle, target_angle )
local turn_speed = self.turn_speed*self.interval*self.auto

local sign = -1
if angle_diff<0 then sign = 1 end

if math.abs( angle_diff )<1.1*turn_speed then
	self.current_angle = target_angle
else
	self.current_angle = self.current_angle + sign*turn_speed
end

local angles = self.parent:GetAnglesAsVector()
self.parent:SetLocalAngles( angles.x, self.current_angle, angles.z )

end



function modifier_sniper_take_aim_custom_active:OnDestroy()
if not IsServer() then return end

if self.parent:HasTalent("modifier_sniper_aim_7") then 
	self.parent:FadeGesture(ACT_DOTA_ATTACK)
	self.parent:StopSound("Sniper.Headshot_legendary")

	local dir = self.parent:GetForwardVector()
	dir.z = 0

	self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)
	self.parent:SetForwardVector(dir)

	self.parent:Stop()
	FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_sniper_take_aim_custom_no_count_move", {duration = 0.3})
end



modifier_sniper_take_aim_custom_legendary_unit = class({})
function modifier_sniper_take_aim_custom_legendary_unit:IsHidden() return true end
function modifier_sniper_take_aim_custom_legendary_unit:IsPurgable() return false end



modifier_sniper_take_aim_custom_legendary_damage = class({})
function modifier_sniper_take_aim_custom_legendary_damage:IsHidden() return true end
function modifier_sniper_take_aim_custom_legendary_damage:IsPurgable() return false end
function modifier_sniper_take_aim_custom_legendary_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_sniper_take_aim_custom_legendary_damage:GetModifierDamageOutgoing_Percentage()
return self.damage
end


function modifier_sniper_take_aim_custom_legendary_damage:OnCreated()
self.damage = self:GetCaster():GetTalentValue("modifier_sniper_aim_7", "damage") - 100
end 









modifier_sniper_take_aim_custom_armor = class({})
function modifier_sniper_take_aim_custom_armor:IsHidden() return false end
function modifier_sniper_take_aim_custom_armor:IsPurgable() return false end
function modifier_sniper_take_aim_custom_armor:GetTexture() return "buffs/headshot_armor" end
function modifier_sniper_take_aim_custom_armor:OnCreated(table)

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.max = self.caster:GetTalentValue("modifier_sniper_aim_4", "max")
self.armor = self.caster:GetTalentValue("modifier_sniper_aim_4", "armor")
self.slow = self.caster:GetTalentValue("modifier_sniper_aim_4", "slow")

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_sniper_take_aim_custom_armor:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
	self.parent:EmitSound("Hoodwink.Acorn_armor")
	self.parent:GenericParticle("particles/hoodwink/bush_damage.vpcf", self)
end

end

function modifier_sniper_take_aim_custom_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sniper_take_aim_custom_armor:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end

function modifier_sniper_take_aim_custom_armor:GetModifierMoveSpeedBonus_Percentage()
return self.slow*self:GetStackCount()
end



modifier_sniper_take_aim_custom_damage_reduce = class({})
function modifier_sniper_take_aim_custom_damage_reduce:IsHidden() return false end
function modifier_sniper_take_aim_custom_damage_reduce:IsPurgable() return false end
function modifier_sniper_take_aim_custom_damage_reduce:GetTexture() return "buffs/headshot_status" end

function modifier_sniper_take_aim_custom_damage_reduce:OnCreated(table)

self.parent = self:GetParent()
self.damage = self.parent:GetTalentValue("modifier_sniper_aim_5", "damage_reduce")

if not IsServer() then return end
self.pos = self.parent:GetAbsOrigin()
self.parent:GenericParticle("particles/items2_fx/vindicators_axe_armor.vpcf", self)
self:StartIntervalThink(0.1)
end


function modifier_sniper_take_aim_custom_damage_reduce:OnIntervalThink()
if not IsServer() then return end

if self.parent:HasModifier("modifier_sniper_take_aim_custom_active") or self.parent:HasModifier("modifier_sniper_take_aim_custom_no_count_move") then 
	self.pos = self.parent:GetAbsOrigin()
	return 
end

if self.pos == self.parent:GetAbsOrigin() then return end
self:Destroy()
end


function modifier_sniper_take_aim_custom_damage_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end

function modifier_sniper_take_aim_custom_damage_reduce:GetModifierIncomingDamage_Percentage()
return self.damage
end




modifier_sniper_take_aim_custom_no_count_move = class({})
function modifier_sniper_take_aim_custom_no_count_move:IsHidden() return true end
function modifier_sniper_take_aim_custom_no_count_move:IsPurgable() return false end





modifier_sniper_take_aim_custom_damage = class({})
function modifier_sniper_take_aim_custom_damage:IsHidden() return false end
function modifier_sniper_take_aim_custom_damage:IsPurgable() return false end
function modifier_sniper_take_aim_custom_damage:GetTexture() return "buffs/assassinate_break" end
function modifier_sniper_take_aim_custom_damage:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_sniper_aim_3", "max")
self.damage = self.parent:GetTalentValue("modifier_sniper_aim_3", "damage")/self.max
self.move = self.parent:GetTalentValue("modifier_sniper_aim_3", "move")/self.max
if not IsServer() then return end

self:SetStackCount(1)
end

function modifier_sniper_take_aim_custom_damage:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end

function modifier_sniper_take_aim_custom_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sniper_take_aim_custom_damage:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.move
end

function modifier_sniper_take_aim_custom_damage:GetModifierPreAttack_BonusDamage()
return self:GetStackCount()*self.damage
end




modifier_sniper_take_aim_custom_block = class({})
function modifier_sniper_take_aim_custom_block:IsHidden() return true end
function modifier_sniper_take_aim_custom_block:IsPurgable() return false end
function modifier_sniper_take_aim_custom_block:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end 
self.particle = ParticleManager:CreateParticle("particles/sniper/aim_block.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, true, false, -1, false, false)
end

function modifier_sniper_take_aim_custom_block:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSORB_SPELL
}
end

function modifier_sniper_take_aim_custom_block:GetAbsorbSpell(params) 
if not IsServer() then return end
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end

if self.particle then 
	ParticleManager:DestroyParticle(self.particle, false)
	ParticleManager:ReleaseParticleIndex(self.particle)
end 

self.block = true
self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
self:Destroy()
return 1 
end




modifier_sniper_take_aim_custom_break = class({})
function modifier_sniper_take_aim_custom_break:IsHidden() return true end
function modifier_sniper_take_aim_custom_break:IsPurgable() return false end
function modifier_sniper_take_aim_custom_break:CheckState() 
return 
{
	[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	[MODIFIER_STATE_TETHERED] = true,
} 
end
function modifier_sniper_take_aim_custom_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end


function modifier_sniper_take_aim_custom_break:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.parent:EmitSound("DOTA_Item.SilverEdge.Target")
--self.parent:GenericParticle("particles/generic_gameplay/generic_break.vpcf", self, true)
end
