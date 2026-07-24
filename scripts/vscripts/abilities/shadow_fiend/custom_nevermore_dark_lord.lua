--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_dark_lord_aura","abilities/shadow_fiend/custom_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_dark_lord_debuff", "abilities/shadow_fiend/custom_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_dark_lord_legendary", "abilities/shadow_fiend/custom_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_dark_lord_legendary_fear", "abilities/shadow_fiend/custom_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_custom_dark_lord_damage", "abilities/shadow_fiend/custom_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_dark_lord_speed", "abilities/shadow_fiend/custom_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_dark_lord_slow", "abilities/shadow_fiend/custom_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_dark_lord_fear_cd", "abilities/shadow_fiend/custom_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE)


custom_nevermore_dark_lord = class({})



function custom_nevermore_dark_lord:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/sf_fear.vpcf", context )
PrecacheResource( "particle","particles/sf_wings.vpcf", context )
PrecacheResource( "particle","particles/sf_timer.vpcf", context )
PrecacheResource( "particle","particles/sf_aura.vpcf", context )	
PrecacheResource( "particle","particles/shadow_fiend/dark_legendary_caster.vpcf", context ) 
PrecacheResource( "particle","particles/shadow_fiend/dark_legendary_stun.vpcf", context ) 
PrecacheResource( "particle","particles/shadow_fiend/dark_burn.vpcf", context ) 
PrecacheResource( "particle","particles/shadow_fiend/dark_speed.vpcf", context ) 
PrecacheResource( "particle","particles/units/heroes/npc_dota_hero_nevermorere/nevermore_requiemofsouls_line.vpcf", context ) 
end


function custom_nevermore_dark_lord:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "nevermore_dark_lord", self)
end

function custom_nevermore_dark_lord:GetIntrinsicModifierName()
return "modifier_custom_dark_lord_aura"
end


function custom_nevermore_dark_lord:GetCooldown(iLevel)
if self:GetCaster():HasTalent("modifier_nevermore_darklord_7") or self:GetCaster():HasTalent("modifier_nevermore_darklord_5") then 
	return self:GetCaster():GetTalentValue("modifier_nevermore_darklord_7", "cd", true)
end  

end

function custom_nevermore_dark_lord:GetBehavior()
if self:GetCaster():HasTalent("modifier_nevermore_darklord_7") or self:GetCaster():HasTalent("modifier_nevermore_darklord_5") then
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE 
end


function custom_nevermore_dark_lord:OnSpellStart()
local caster = self:GetCaster()
if caster:HasTalent("modifier_nevermore_darklord_5") then
	caster:RemoveModifierByName("modifier_custom_dark_lord_speed")
	caster:AddNewModifier(caster, self, "modifier_custom_dark_lord_speed", {duration = caster:GetTalentValue("modifier_nevermore_darklord_5", "duration")})
end

if not caster:HasTalent("modifier_nevermore_darklord_7") then return end

caster:StartGestureWithPlaybackRate(ACT_DOTA_RAZE_3, 1)

local mod = caster:FindModifierByName("modifier_custom_dark_lord_legendary")

if not mod then
	self:EndCd(0)
	self:StartCooldown(0.2)

	caster:EmitSound("Sf.Aura_Legendary_Buff")
	caster:EmitSound("Sf.Aura_Legendary")
	caster:AddNewModifier(caster, self, "modifier_custom_dark_lord_legendary", {duration = caster:GetTalentValue("modifier_nevermore_darklord_7", "duration")})
	return
end

self:EndCd()
caster:AddNewModifier(caster, self, "modifier_custom_dark_lord_legendary_fear", {stack = mod:GetStackCount()})
end



function custom_nevermore_dark_lord:OnProjectileHit(target, vLocation)
if not target then return end
local caster = self:GetCaster()
local fear = caster:GetTalentValue("modifier_nevermore_darklord_6", "fear")

target:EmitSound("Hero_Nevermore.RequiemOfSouls.Damage")
target:AddNewModifier(caster, self, "modifier_nevermore_requiem_fear", {duration = (1 - target:GetStatusResistance())*fear})
end


modifier_custom_dark_lord_aura = class({})
function modifier_custom_dark_lord_aura:IsHidden() return true end
function modifier_custom_dark_lord_aura:IsPurgable() return false end
function modifier_custom_dark_lord_aura:AllowIllusionDuplicate() return true end

function modifier_custom_dark_lord_aura:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.aura_radius = self.ability:GetSpecialValueFor("presence_radius")
self.duration = self.ability:GetSpecialValueFor("linger_duration")

if self.caster:IsRealHero() then 
	self.caster:AddDamageEvent_out(self)
	self.caster:AddAttackStartEvent_inc(self)
end
self.damage_radius = self.parent:GetTalentValue("modifier_nevermore_darklord_4", "radius", true)
self.damage_interval = self.parent:GetTalentValue("modifier_nevermore_darklord_4", "interval", true)
self.damage_duration = self.parent:GetTalentValue("modifier_nevermore_darklord_4", "duration", true)

self.fear_status = self.parent:GetTalentValue("modifier_nevermore_darklord_6", "status", true)
self.fear_cd = self.parent:GetTalentValue("modifier_nevermore_darklord_6", "cd", true)
self.fear_range = self.parent:GetTalentValue("modifier_nevermore_darklord_6", "range", true)
self.fear_speed = self.parent:GetTalentValue("modifier_nevermore_darklord_6", "speed", true)
self.fear_width = self.parent:GetTalentValue("modifier_nevermore_darklord_6", "width", true)

self.heal_creeps = self.parent:GetTalentValue("modifier_nevermore_darklord_3", "creeps", true)
self:StartIntervalThink(1)
end

function modifier_custom_dark_lord_aura:OnRefresh()
self:OnCreated()
end


function modifier_custom_dark_lord_aura:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_nevermore_darklord_4") then return end

local targets = self.parent:FindTargets(self.damage_radius)
if #targets > 0 then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_dark_lord_damage", {duration = self.damage_duration, interval = self.damage_interval})
end

self:StartIntervalThink(self.damage_interval)
end


function modifier_custom_dark_lord_aura:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_nevermore_darklord_3") then return end
if not self.parent:CheckLifesteal(params, 0) then return end

local heal = params.damage*self.parent:GetTalentValue("modifier_nevermore_darklord_3", "heal")/100
if params.unit:IsCreep() then
	heal = heal/self.heal_creeps
end

self.parent:GenericHeal(heal, self.ability, true, "", "modifier_nevermore_darklord_3")
end


function modifier_custom_dark_lord_aura:AttackStartEvent_inc(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_nevermore_darklord_6") then return end
if self.parent ~= params.target then return end
if not params.attacker:IsUnit() then return end
if params.attacker:HasModifier("modifier_custom_dark_lord_fear_cd") then return end
if params.attacker:IsInvulnerable() then return end
if not params.attacker:IsRealHero() then return end

params.attacker:AddNewModifier(self.parent, self.ability, "modifier_custom_dark_lord_fear_cd", {duration = self.fear_cd})
self.parent:EmitSound("Sf.Dark_fear")

local particle_lines = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", self)

local direction =  params.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin() 
direction.z = 0.0
direction = direction:Normalized()
 
projectile_info = 
{
	Ability =  self.ability,	  
	vSpawnOrigin = self.parent:GetAbsOrigin() ,
	fDistance = self.fear_range,
	fStartRadius = self.fear_width,
	fEndRadius = self.fear_width,
	Source = self.parent,
	bHasFrontalCone = false,
	bReplaceExisting = false,
	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	bDeleteOnHit = false,
	vVelocity = direction*self.fear_speed,
	bProvidesVision = false,
}

ProjectileManager:CreateLinearProjectile(projectile_info)

local particle_lines_fx = ParticleManager:CreateParticle(particle_lines, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle_lines_fx, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl(particle_lines_fx, 1, direction*self.fear_speed)
ParticleManager:SetParticleControl(particle_lines_fx, 2, Vector(0, self.fear_range / self.fear_speed, 0))
ParticleManager:ReleaseParticleIndex(particle_lines_fx)
end



function modifier_custom_dark_lord_aura:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end


function modifier_custom_dark_lord_aura:GetModifierStatusResistanceStacking() 
if not self.parent:HasTalent("modifier_nevermore_darklord_6") then return end
return self.fear_status
end


function modifier_custom_dark_lord_aura:GetAuraEntityReject(target)
if target:IsFieldInvun(self.caster) then return true end
if (self.caster:GetTeam() == target:GetTeam() and self.caster ~= target) then
	return true 
end
return false
end

function modifier_custom_dark_lord_aura:GetAuraSearchTeam()
if self.caster:HasModifier("modifier_custom_dark_lord_legendary") then 
	return DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_custom_dark_lord_aura:GetAuraDuration() return self.duration end
function modifier_custom_dark_lord_aura:GetAuraRadius() return self.aura_radius end
function modifier_custom_dark_lord_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE end
function modifier_custom_dark_lord_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_custom_dark_lord_aura:GetModifierAura() return "modifier_custom_dark_lord_debuff" end
function modifier_custom_dark_lord_aura:IsAura() return not self.caster:PassivesDisabled() end



modifier_custom_dark_lord_debuff =  class({})
function modifier_custom_dark_lord_debuff:IsHidden() return false end
function modifier_custom_dark_lord_debuff:IsPurgable() return false end

function modifier_custom_dark_lord_debuff:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.legendary_bonus = self.caster:GetTalentValue("modifier_nevermore_darklord_7", "bonus", true)/100

self.magic = self.caster:GetTalentValue("modifier_nevermore_darklord_1", "magic")
self.armor = -1*self.ability:GetSpecialValueFor("presence_armor_reduction") + self.caster:GetTalentValue("modifier_nevermore_darklord_1", "armor")

self.attack_slow = self.caster:GetTalentValue("modifier_nevermore_darklord_2", "attack")
self.move_slow = self.caster:GetTalentValue("modifier_nevermore_darklord_2", "move")

self.healing_reduce = self.caster:GetTalentValue("modifier_nevermore_darklord_3", "heal_reduce")
self.healing_health = self.caster:GetTalentValue("modifier_nevermore_darklord_3", "health", true)

self.self_k = 1
if self.caster:GetTeamNumber() == self.parent:GetTeamNumber() then
	self.self_k = -1
end

if not self.caster:HasTalent("modifier_nevermore_darklord_4") or self.self_k == -1 then return end
self.interval = self.caster:GetTalentValue("modifier_nevermore_darklord_4", "interval")
self.damage = self.interval*self.caster:GetTalentValue("modifier_nevermore_darklord_4", "burn")/100
self.radius = self.caster:GetTalentValue("modifier_nevermore_darklord_4", "radius")

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}

self:StartIntervalThink(self.interval)
end


function modifier_custom_dark_lord_debuff:OnIntervalThink()
if not IsServer() then return end

local near = (self.parent:GetAbsOrigin() - self.caster:GetAbsOrigin()):Length2D() <= self.radius

if near then
	self.damageTable.damage = self.damage*self.caster:GetAverageTrueAttackDamage(nil)
	DoDamage(self.damageTable, "modifier_nevermore_darklord_4")

	if not self.burn_paritcle then
		self.burn_paritcle = self.parent:GenericParticle("particles/shadow_fiend/dark_burn.vpcf", self)
	end
else
	if self.burn_paritcle then
		ParticleManager:DestroyParticle(self.burn_paritcle, false)
		ParticleManager:ReleaseParticleIndex(self.burn_paritcle)
		self.burn_paritcle = nil
	end
end

end


function modifier_custom_dark_lord_debuff:GetBonus(bonus)
local result = bonus
if self.caster:HasModifier("modifier_custom_dark_lord_legendary") then
	result = result * (1 + self.caster:GetUpgradeStack("modifier_custom_dark_lord_legendary")*self.legendary_bonus)
end
return result * self.self_k

end


function modifier_custom_dark_lord_debuff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end

function modifier_custom_dark_lord_debuff:GetModifierLifestealRegenAmplify_Percentage() 
if not self.caster:HasTalent("modifier_nevermore_darklord_3") then return end
if self.parent:GetHealthPercent() > self.healing_health then return end
return self:GetBonus(self.healing_reduce)
end

function modifier_custom_dark_lord_debuff:GetModifierHealChange() 
if not self.caster:HasTalent("modifier_nevermore_darklord_3") then return end
if self.parent:GetHealthPercent() > self.healing_health then return end
return self:GetBonus(self.healing_reduce)
end

function modifier_custom_dark_lord_debuff:GetModifierHPRegenAmplify_Percentage() 
if not self.caster:HasTalent("modifier_nevermore_darklord_3") then return end
if self.parent:GetHealthPercent() > self.healing_health then return end
return self:GetBonus(self.healing_reduce)
end

function modifier_custom_dark_lord_debuff:GetModifierMagicalResistanceBonus()
if not self.caster:HasTalent("modifier_nevermore_darklord_1") then return end
return self:GetBonus(self.magic)
end

function modifier_custom_dark_lord_debuff:GetModifierPhysicalArmorBonus()
return self:GetBonus(self.armor)
end

function modifier_custom_dark_lord_debuff:GetModifierMoveSpeedBonus_Percentage()
if not self.caster:HasTalent("modifier_nevermore_darklord_2") then return end
return self:GetBonus(self.move_slow)
end

function modifier_custom_dark_lord_debuff:GetModifierAttackSpeedBonus_Constant()
if not self.caster:HasTalent("modifier_nevermore_darklord_2") then return end
return self:GetBonus(self.attack_slow)
end







modifier_custom_dark_lord_legendary = class({})
function modifier_custom_dark_lord_legendary:IsHidden() return true end
function modifier_custom_dark_lord_legendary:IsPurgable() return false end
function modifier_custom_dark_lord_legendary:GetTexture() return "buffs/darklord_legen" end
function modifier_custom_dark_lord_legendary:OnCreated(table)
self.RemoveForDuel = true
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.parent:GetTalentValue("modifier_nevermore_darklord_7", "radius")
self.max_time = self:GetRemainingTime()

if not IsServer() then return end

self.particle = self.parent:GenericParticle("particles/sf_timer.vpcf", self, true)

local effect_cast = ParticleManager:CreateParticle( "particles/shadow_fiend/dark_legendary_caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 2, Vector(self.radius, self:GetRemainingTime(), self.radius) )
self:AddParticle( effect_cast, false, false, -1, false, false )

self.interval = 0.1
self.count = -self.interval
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_custom_dark_lord_legendary:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
self.parent:RemoveModifierByName("modifier_custom_dark_lord_debuff")
self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "FiendDark"})
end


function modifier_custom_dark_lord_legendary:OnIntervalThink()
if not IsServer() then return end

local targets = self.parent:FindTargets(self.radius)
if #targets > 0 then
	self.count = self.count + self.interval
	if self.count >= 0.99 then
		self.count = 0
		self:IncrementStackCount()
	end
end

self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self:GetStackCount(), style = "FiendDark"})
end


function modifier_custom_dark_lord_legendary:OnStackCountChanged()
if not IsServer() then return end
if not self.particle then return end

ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
end



modifier_custom_dark_lord_legendary_fear = class({})
function modifier_custom_dark_lord_legendary_fear:IsHidden() return true end
function modifier_custom_dark_lord_legendary_fear:IsPurgable() return false end
function modifier_custom_dark_lord_legendary_fear:RemoveOnDeath() return false end

function modifier_custom_dark_lord_legendary_fear:OnCreated( table )
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.origin = self.parent:GetAbsOrigin()

self.start_radius =  0
self.end_radius = self.parent:GetTalentValue("modifier_nevermore_darklord_7", "fear_radius")
self.speed = self.parent:GetTalentValue("modifier_nevermore_darklord_7", "fear_speed")
self.stack = table.stack

self.fear_duration = self.stack*self.parent:GetTalentValue("modifier_nevermore_darklord_7", "fear")
self.fear_damage = self.stack*self.parent:GetTalentValue("modifier_nevermore_darklord_7", "damage")/100

self.damageTable = {ability = self.ability, attacker = self.parent, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}

self.width = 100
self.targets = {}

self.parent:EmitSound("Sf.Aura_Ring")
self.effect_cast = ParticleManager:CreateParticle( "particles/sf_fear.vpcf",  PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin)
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(  900, 1000, 1000 ) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)

AddFOWViewer(self.parent:GetTeamNumber(), self.origin, self.end_radius + 100, self.end_radius/self.speed + 2, false)

self.interval = 0.03
self:StartIntervalThink(self.interval)
end


function modifier_custom_dark_lord_legendary_fear:OnIntervalThink()
if not IsServer() then return end

local radius = self.speed * self:GetElapsedTime()

if radius > self.end_radius then
	self:Destroy()
	return
end

if self.stack <= 0 then return end

for _,target in pairs(self.parent:FindTargets(radius, self.origin)) do
	if not self.targets[target] and (target:GetOrigin()-self.origin):Length2D() > (radius-self.width) then
		self.targets[target] = true
		target:EmitSound("Sf.Aura_Fear")
		target:GenericParticle("particles/shadow_fiend/dark_legendary_stun.vpcf")
		target:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = self.fear_duration*(1 - target:GetStatusResistance())})

		self.damageTable.victim = target
		self.damageTable.damage = self.parent:GetAverageTrueAttackDamage(nil)*self.fear_damage
		DoDamage(self.damageTable, "modifier_nevermore_darklord_7")
	end
end

end



modifier_custom_dark_lord_damage = class({})
function modifier_custom_dark_lord_damage:IsHidden() return false end
function modifier_custom_dark_lord_damage:IsPurgable() return false end
function modifier_custom_dark_lord_damage:GetTexture() return "buffs/darklord_health" end
function modifier_custom_dark_lord_damage:OnCreated(table)
self.parent = self:GetParent()
self.damage = self.parent:GetTalentValue("modifier_nevermore_darklord_4", "damage")
self.max = self.parent:GetTalentValue("modifier_nevermore_darklord_4", "max")
if not IsServer() then return end
self.count = table.interval
end

function modifier_custom_dark_lord_damage:OnRefresh(table)
if not IsServer() then return end
self.count = self.count + table.interval
if self.count >= 0.99 then
	self.count = 0
	if self:GetStackCount() < self.max then
		self:IncrementStackCount()
	end
end

end

function modifier_custom_dark_lord_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
}
end

function modifier_custom_dark_lord_damage:GetModifierPreAttack_BonusDamage()
return self.damage*self:GetStackCount()
end




modifier_custom_dark_lord_speed = class({})
function modifier_custom_dark_lord_speed:IsHidden() return false end
function modifier_custom_dark_lord_speed:IsPurgable() return false end
function modifier_custom_dark_lord_speed:GetTexture() return "buffs/Sonic_stack" end
function modifier_custom_dark_lord_speed:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.duration = self.parent:GetTalentValue("modifier_nevermore_darklord_5", "slow_duration")
self.speed = self.parent:GetTalentValue("modifier_nevermore_darklord_5", "speed")
self.radius = self.parent:GetTalentValue("modifier_nevermore_darklord_5", "radius")
self.targets = {}

if not IsServer() then return end

if not self.parent:HasTalent("modifier_nevermore_darklord_7") then
	self.ability:EndCd()
end

self.parent:EmitSound("Sf.Dark_speed")
self.parent:EmitSound("Sf.Dark_speed2")

self.effect_cast = ParticleManager:CreateParticle( "particles/sf_aura.vpcf",  PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(  self.radius, 0, 0 ))
self:AddParticle(self.effect_cast,false, false, -1, false, false)

self.parent:GenericParticle("particles/shadow_fiend/dark_speed.vpcf", self)
self.parent:GenericParticle("particles/sf_wings.vpcf", self)

self:StartIntervalThink(0.1)
end

function modifier_custom_dark_lord_speed:OnIntervalThink()
if not IsServer() then return end

for _,target in pairs(self.parent:FindTargets(self.radius)) do
	if not self.targets[target] then
		self.targets[target] = true
		target:EmitSound("Sf.Dark_slow_hit")
		target:GenericParticle("particles/shadow_fiend/dark_legendary_stun.vpcf")
		target:AddNewModifier(self.parent, self.ability, "modifier_custom_dark_lord_slow", {duration = (1 - target:GetStatusResistance())*self.duration})
	end
end

end


function modifier_custom_dark_lord_speed:OnDestroy()
if not IsServer() then return  end

if not self.parent:HasTalent("modifier_nevermore_darklord_7") then
	self.ability:StartCd()
end

end

function modifier_custom_dark_lord_speed:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_custom_dark_lord_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_custom_dark_lord_speed:GetModifierMoveSpeed_Absolute()
return self.speed
end

function modifier_custom_dark_lord_speed:GetActivityTranslationModifiers()
return "haste"
end

modifier_custom_dark_lord_slow = class({})
function modifier_custom_dark_lord_slow:IsHidden() return true end
function modifier_custom_dark_lord_slow:IsPurgable() return true end
function modifier_custom_dark_lord_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_nevermore_darklord_5", "slow")
end

function modifier_custom_dark_lord_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_dark_lord_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_custom_dark_lord_slow:CheckState()
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end

function modifier_custom_dark_lord_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_slark_shadow_dance.vpcf"
end

function modifier_custom_dark_lord_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end


modifier_custom_dark_lord_fear_cd = class({})
function modifier_custom_dark_lord_fear_cd:IsHidden() return true end
function modifier_custom_dark_lord_fear_cd:IsPurgable() return false end
function modifier_custom_dark_lord_fear_cd:RemoveOnDeath() return false end
function modifier_custom_dark_lord_fear_cd:OnCreated()
self.RemoveForDuel = true
end