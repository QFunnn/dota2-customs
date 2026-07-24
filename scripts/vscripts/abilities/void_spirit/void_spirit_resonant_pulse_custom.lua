--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_void_spirit_resonant_pulse", "abilities/void_spirit/void_spirit_resonant_pulse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_generic_ring_lua", "util/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_void_spirit_resonant_slow", "abilities/void_spirit/void_spirit_resonant_pulse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_resonant_resist", "abilities/void_spirit/void_spirit_resonant_pulse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_resonant_tracker", "abilities/void_spirit/void_spirit_resonant_pulse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_resonant_stats", "abilities/void_spirit/void_spirit_resonant_pulse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_resonant_invun", "abilities/void_spirit/void_spirit_resonant_pulse_custom", LUA_MODIFIER_MOTION_NONE)


void_spirit_resonant_pulse_custom = class({})


function void_spirit_resonant_pulse_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/void_shield_legen.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/pulse_legendary.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_impact.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield_deflect.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/shield_buff.vpcf", context )
PrecacheResource( "particle","particles/void_astral_slow.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/step_status.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/shield_legendary_impact.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/shield_refresh.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/pulse_shield_invun.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/shield_invun_absorb.vpcf", context )
end


function void_spirit_resonant_pulse_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_void_spirit_resonant_tracker"
end


function void_spirit_resonant_pulse_custom:GetCooldown(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_void_pulse_4") then 
  bonus = self:GetCaster():GetTalentValue("modifier_void_pulse_4", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end


function void_spirit_resonant_pulse_custom:GetCastRange( location , target)
return self:GetSpecialValueFor("radius")
end



function void_spirit_resonant_pulse_custom:LegendaryStack()
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_void_spirit_resonant_pulse")
if not mod or not mod.legendary_max then return end

local max = mod.legendary_max

if caster:HasTalent("modifier_void_pulse_legendary") and mod.legendary_stack and mod.legendary_stack < max then
	mod.legendary_stack = mod.legendary_stack + 1
end

if caster:HasTalent("modifier_void_pulse_4") then
	caster:AddNewModifier(caster, self, "modifier_void_spirit_resonant_stats", {duration = caster:GetTalentValue("modifier_void_pulse_4", "duration")})
end

end


function void_spirit_resonant_pulse_custom:DealDamage(enemy, legendary_damage, first_hit)
local caster = self:GetCaster()
local effect = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_impact.vpcf"
local damage = self:GetSpecialValueFor( "damage" )
local damage_ability = nil

if legendary_damage then
	effect = "particles/void_spirit/shield_legendary_impact.vpcf"
	damage = legendary_damage
	damage_ability = "modifier_void_pulse_legendary"
end

local damageTable = {attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self, victim = enemy}
local real_damage = DoDamage(damageTable, damage_ability)

if legendary_damage and legendary_damage > 0 then 
	enemy:SendNumber(6, real_damage)
end

if caster:HasTalent("modifier_void_astral_6") and first_hit and first_hit == 1 then
	caster:CdItems(caster:GetTalentValue("modifier_void_astral_6", "cd_items"))
end

local step = caster:FindAbilityByName("void_spirit_astral_step_custom")
if step then
	step:AutoStack(enemy)
end

if caster:HasTalent("modifier_void_pulse_6") then
	local vec = (enemy:GetAbsOrigin() - caster:GetAbsOrigin())
	local dist = math.max(0, math.min(vec:Length2D() - 120, caster:GetTalentValue("modifier_void_pulse_6", "distance")))
	local duration = caster:GetTalentValue("modifier_void_pulse_6", "duration")
	local center = enemy:GetAbsOrigin() + 10*vec:Normalized()

	local knockback =	
	{
	  should_stun = 0,
	  knockback_duration = duration,
	  duration = duration,
	  knockback_distance = dist,
	  knockback_height = 0,
	  center_x = center.x,
	  center_y = center.y,
	  center_z = center.z,
	}

	enemy:AddNewModifier(caster, self, "modifier_knockback", knockback)
	enemy:AddNewModifier(caster, self, "modifier_void_spirit_resonant_slow", {duration = (1 - enemy:GetStatusResistance())*caster:GetTalentValue("modifier_void_pulse_6", "silence")})
end

local effect_cast = ParticleManager:CreateParticle(effect, PATTACH_CUSTOMORIGIN_FOLLOW, enemy )
ParticleManager:SetParticleControlEnt(effect_cast, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
ParticleManager:SetParticleControlEnt(effect_cast, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
ParticleManager:ReleaseParticleIndex( effect_cast )
enemy:EmitSound("Hero_VoidSpirit.Pulse.Target")

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy )
ParticleManager:SetParticleControlEnt( effect_cast, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0),  true )
ParticleManager:SetParticleControlEnt( effect_cast, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true  )
ParticleManager:ReleaseParticleIndex( effect_cast )
end



function void_spirit_resonant_pulse_custom:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor( "buff_duration" )
caster:AddNewModifier(caster, self, "modifier_void_spirit_resonant_pulse", { duration = duration })
end





modifier_void_spirit_resonant_pulse = class({})
function modifier_void_spirit_resonant_pulse:IsHidden() return false end
function modifier_void_spirit_resonant_pulse:IsPurgable() return false end
function modifier_void_spirit_resonant_pulse:OnCreated( kv )

self.ability = self:GetAbility()
self.parent = self:GetParent()

self.max_shield = self.ability:GetSpecialValueFor( "base_absorb_amount" ) + self.parent:GetMaxHealth()*self.parent:GetTalentValue("modifier_void_pulse_1", "shield")/100

if not IsServer() then return end

self.legendary_max = self.parent:GetTalentValue("modifier_void_pulse_legendary", "max", true)
self.legendary_stack = 0

self.RemoveForDuel = true

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield.vpcf", PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt(effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( 130, 130, 130 ) )
self:AddParticle(effect_cast, false, false, -1, false, false )

if self.parent:HasTalent("modifier_void_pulse_5") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_void_spirit_resonant_invun", {duration = self.parent:GetTalentValue("modifier_void_pulse_5", "duration")})
end

self.parent:GenericParticle("particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_buff.vpcf")
self.parent:EmitSound("Hero_VoidSpirit.Pulse.Cast")

self.radius = self.ability:GetSpecialValueFor( "radius" ) + 90
self.speed = self.ability:GetSpecialValueFor( "speed" )

self.max_time = self:GetRemainingTime()

if self.parent:HasTalent("modifier_void_pulse_legendary") then
	self:OnIntervalThink()
	self:StartIntervalThink(0.1)
end

self.heal_creeps = self.parent:GetTalentValue("modifier_void_pulse_1", "creeps", true)
self.heal_shield = self.parent:GetTalentValue("modifier_void_pulse_1", "heal")/100
if self.parent:HasTalent("modifier_void_pulse_1") then
	self.parent:AddDamageEvent_out(self)
end

if self.parent:HasTalent("modifier_void_pulse_3") then 
	self.parent:RemoveModifierByName("modifier_void_spirit_resonant_resist")
 	self.resist = self.parent:AddNewModifier(self.parent, self.ability, "modifier_void_spirit_resonant_resist", {})
end

self:SetStackCount(self.max_shield)
self:CreateWave()

self.ability:EndCd()
end


function modifier_void_spirit_resonant_pulse:CreateWave(new_damage)
if not IsServer() then return end
local ability = self.ability
local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf"
local sound_cast = "Hero_VoidSpirit.Pulse"
if new_damage then
	particle_cast =  "particles/void_spirit/pulse_legendary.vpcf"
	sound_cast = "VoidSpirit.Pulse_legendary"
end

local radius = self.radius * 2
local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, nil )
ParticleManager:SetParticleControlEnt(effect_cast, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
self.parent:EmitSound(sound_cast)

local pulse = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_ring_lua", {end_radius = self.radius, speed = self.speed, target_team = DOTA_UNIT_TARGET_TEAM_ENEMY, target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,})

if not pulse then return end

pulse.first_hit = 1

pulse:SetCallback( function( enemy )
	ability:DealDamage(enemy, new_damage, pulse.first_hit)
	pulse.first_hit = 0
end)


end


function modifier_void_spirit_resonant_pulse:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_void_pulse_1") then return end
if not self.parent:CheckLifesteal(params) then return end

local heal = params.damage*self.heal_shield
if params.unit:IsCreep() then
	heal = heal / self.heal_creeps
end
self:SetStackCount(math.min(self.max_shield, self:GetStackCount() + heal))
end

function modifier_void_spirit_resonant_pulse:OnIntervalThink()
if not IsServer() then return end 
local active = 0
if self.legendary_stack >= self.legendary_max then
	active = 1
end
self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self.legendary_stack, active = active, style = "VoidShield"})
end 


function modifier_void_spirit_resonant_pulse:OnDestroy()
if not IsServer() then return end

if self.resist and not self.resist:IsNull() then 
	self.resist:SetDuration(self.parent:GetTalentValue("modifier_void_pulse_3", "duration"), true)
	self.resist:PlayEffect()
end 

self.ability:StartCd()
self.parent:EmitSound("Hero_VoidSpirit.Pulse.Destroy")

if self.parent:HasTalent("modifier_void_pulse_5") then 
	self.parent:Purge(false, true, false, false, false)
	self.parent:EmitSound("VoidSpirit.Shield_legendary")
	local heal = (self.parent:GetMaxHealth() - self.parent:GetHealth())*self.parent:GetTalentValue("modifier_void_pulse_5", "heal")/100
	self.parent:GenericHeal(heal, self.ability, nil, nil, "modifier_void_pulse_5")

	local effect_cast = ParticleManager:CreateParticle( "particles/void_shield_legen.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(),  true )
	ParticleManager:ReleaseParticleIndex( effect_cast )	
end

local legendary_damage = 0

if self.parent:HasTalent("modifier_void_pulse_legendary") then
	legendary_damage = self.legendary_stack*self.parent:GetTalentValue("modifier_void_pulse_legendary", "damage")*self.parent:GetAverageTrueAttackDamage(nil)/100
	if self.legendary_stack >= self.legendary_max then
		local effect = ParticleManager:CreateParticle("particles/void_spirit/shield_refresh.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
		ParticleManager:SetParticleControlEnt( effect, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
		ParticleManager:Delete(effect, 0)

		self.parent:EmitSound("VoidSpirit.Shield_refresh")

		local cd = self.ability:GetCooldownTimeRemaining()
		self.parent:CdAbility(self.ability, cd*self.parent:GetTalentValue("modifier_void_pulse_legendary", "cd")/100)
	end
	self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "VoidShield"})
end

if legendary_damage > 0 or self.parent:HasTalent("modifier_void_pulse_6") then
	self:CreateWave(legendary_damage)
end

end

function modifier_void_spirit_resonant_pulse:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_void_spirit_resonant_pulse:GetModifierIncomingDamageConstant( params )

if IsClient() then 
	if params.report_max then 
		return self.max_shield 
	else 
		return self:GetStackCount()
	end 
end

local effect = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield_deflect.vpcf"
local mod = self.parent:FindModifierByName("modifier_void_spirit_resonant_invun")
if mod then
	effect = "particles/void_spirit/shield_invun_absorb.vpcf"
	self.parent:EmitSound("VoidSpirit.Shield_invun")
end

local effect_cast = ParticleManager:CreateParticle(effect, PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( 100, 100, 100 ) )
ParticleManager:ReleaseParticleIndex( effect_cast )

local damage = math.min(params.damage, self:GetStackCount())

if mod then 
	damage = params.damage
else
	self:SetStackCount(self:GetStackCount() - damage)
end

if self.parent:GetQuest() == "Void.Quest_7" and params.attacker:IsRealHero() then 
	self.parent:UpdateQuest(damage)
end

self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end


function modifier_void_spirit_resonant_pulse:GetStatusEffectName()
return "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
end

function modifier_void_spirit_resonant_pulse:StatusEffectPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA
end






modifier_void_spirit_resonant_tracker = class({})
function modifier_void_spirit_resonant_tracker:IsHidden() return true end
function modifier_void_spirit_resonant_tracker:IsPurgable() return false end
function modifier_void_spirit_resonant_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()


if not IsServer() then return end
self:SetHasCustomTransmitterData(true)

self:UpdateTalent()
end

function modifier_void_spirit_resonant_tracker:UpdateTalent(name)

if name == "modifier_void_pulse_legendary" or self.parent:HasTalent("modifier_void_pulse_legendary") then
	self.parent:AddAttackEvent_out(self)
end

if name == "modifier_void_pulse_4" or self.parent:HasTalent("modifier_void_pulse_4") then
	self.parent:AddAttackEvent_out(self)
end

end

function modifier_void_spirit_resonant_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if not self.parent:HasModifier("modifier_void_spirit_resonant_pulse") then return end
if params.no_attack_cooldown then return end

if self.parent:HasTalent("modifier_void_pulse_legendary") or self.parent:HasTalent("modifier_void_pulse_4") then
	self.ability:LegendaryStack()
end

end








modifier_void_spirit_resonant_slow = class({})
function modifier_void_spirit_resonant_slow:IsHidden() return true end
function modifier_void_spirit_resonant_slow:IsPurgable() return true end
function modifier_void_spirit_resonant_slow:GetTexture() return "buffs/Pulse_slow" end
function modifier_void_spirit_resonant_slow:GetEffectName() return "particles/void_astral_slow.vpcf" end

function modifier_void_spirit_resonant_slow:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.move = self.caster:GetTalentValue("modifier_void_pulse_6", "slow")

if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/generic_silenced.vpcf", self, true)
end

function modifier_void_spirit_resonant_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_void_spirit_resonant_slow:GetModifierMoveSpeedBonus_Percentage()
return self.move
end


function modifier_void_spirit_resonant_slow:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
}
end




modifier_void_spirit_resonant_resist = class({})
function modifier_void_spirit_resonant_resist:IsHidden() return false end
function modifier_void_spirit_resonant_resist:IsPurgable() return false end
function modifier_void_spirit_resonant_resist:GetTexture() return "buffs/Pulse_reduce" end
function modifier_void_spirit_resonant_resist:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end

function modifier_void_spirit_resonant_resist:OnCreated()
self.parent = self:GetParent()
self.magic = self.parent:GetTalentValue("modifier_void_pulse_3", "magic")
self.status = self.parent:GetTalentValue("modifier_void_pulse_3", "status")
end 

function modifier_void_spirit_resonant_resist:GetModifierMagicalResistanceBonus()
return self.magic 
end

function modifier_void_spirit_resonant_resist:GetModifierStatusResistanceStacking()
return self.status
end

function modifier_void_spirit_resonant_resist:PlayEffect()
if not IsServer() then return end
self.parent:GenericParticle("particles/void_spirit/step_status.vpcf", self)
end





modifier_void_spirit_resonant_stats = class({})
function modifier_void_spirit_resonant_stats:IsHidden() return false end
function modifier_void_spirit_resonant_stats:IsPurgable() return false end
function modifier_void_spirit_resonant_stats:GetTexture() return "buffs/eye_damage" end
function modifier_void_spirit_resonant_stats:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.parent:GetTalentValue("modifier_void_pulse_4", "max")
self.stats = self.parent:GetTalentValue("modifier_void_pulse_4", "stats")

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_void_spirit_resonant_stats:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
if self:GetStackCount() >= self.max then
	self.parent:EmitSound("VoidSpirit.Shield_buff")
	self.particle = ParticleManager:CreateParticle( "particles/void_spirit/shield_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( self.particle, 0, self.parent:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.particle, 1, self.parent:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.particle, 2, self.parent:GetAbsOrigin() )
	self:AddParticle(self.particle, false, false, 0, true, false)
end

end

function modifier_void_spirit_resonant_stats:OnStackCountChanged(iStackCount)
if not IsServer() then return end
local stat = self.stats*self:GetStackCount()/100
self.parent:AddPercentStat({agi = stat, str = stat, int = stat}, self)
end

function modifier_void_spirit_resonant_stats:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP,
	MODIFIER_PROPERTY_MODEL_SCALE
}
end

function modifier_void_spirit_resonant_stats:OnTooltip()
return self.stats*self:GetStackCount()
end

function modifier_void_spirit_resonant_stats:GetModifierModelScale()
if self:GetStackCount() < self.max then return end
return 15
end




modifier_void_spirit_resonant_invun = class({})
function modifier_void_spirit_resonant_invun:IsHidden() return true end
function modifier_void_spirit_resonant_invun:IsPurgable() return false end
function modifier_void_spirit_resonant_invun:OnCreated()
self.parent = self:GetParent()
if not IsServer() then return end

local effect_cast = ParticleManager:CreateParticle( "particles/void_spirit/pulse_shield_invun.vpcf", PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt(effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( 130, 130, 130 ) )
self:AddParticle(effect_cast, false, false, -1, false, false )
end
