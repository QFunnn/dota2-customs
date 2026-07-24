--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ogre_magi_fireblast_custom_tracker", "abilities/ogre_magi/ogre_magi_fireblast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_magi_fireblast_custom_speed", "abilities/ogre_magi/ogre_magi_fireblast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_magi_fireblast_custom_spell", "abilities/ogre_magi/ogre_magi_fireblast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_magi_fireblast_custom_legendary_damage", "abilities/ogre_magi/ogre_magi_fireblast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_magi_fireblast_custom_slow", "abilities/ogre_magi/ogre_magi_fireblast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_magi_fireblast_custom_magic", "abilities/ogre_magi/ogre_magi_fireblast", LUA_MODIFIER_MOTION_NONE )

ogre_magi_fireblast_custom_class = class({})

function ogre_magi_fireblast_custom_class:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self) + (self.talents.has_q4 == 1 and self.talents.q4_cast or 0)
end

function ogre_magi_fireblast_custom_class:GetCastRange(vLocation, hTarget)
if self.talents.has_q7 == 1 then 
	return IsClient() and self.caster.fireblast_ability.talents.q7_range or 99999
end
return self.BaseClass.GetCastRange(self , vLocation , hTarget)
end

function ogre_magi_fireblast_custom_class:GetBehavior()
if self.talents.has_q7 == 1 then
	return  DOTA_ABILITY_BEHAVIOR_POINT
end
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function ogre_magi_fireblast_custom_class:GetAOERadius()
return self.cleave_radius and self.cleave_radius or 0
end

function ogre_magi_fireblast_custom_class:GetAbilityTextureName()
if self.is_scepter then
	return wearables_system:GetAbilityIconReplacement(self.caster, "ogre_magi_unrefined_fireblast", self, "ogre_magi_fireblast_custom")
end
return wearables_system:GetAbilityIconReplacement(self.caster, "ogre_magi_fireblast", self)
end

function ogre_magi_fireblast_custom_class:GetParticle(type)

if type == 1 then
	if self.is_scepter then
		return wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_ogre_magi/ogre_magi_unr_fireblast.vpcf", self, "ogre_magi_fireblast_custom")
	else
		return wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast.vpcf", self)
	end
end

if type == 2 then 
	return self.is_scepter and "particles/ogre_fireball_agh.vpcf" or "particles/ogre_fireball.vpcf"
end

end

function ogre_magi_fireblast_custom_class:GetDamage(target)
local k = 1
local mod = target:FindModifierByName("modifier_ogre_magi_fireblast_custom_legendary_damage")
if mod then
	k = k + mod:GetStackCount()*self.talents.q7_damage
end
local result = (self.fireblast_damage + self.caster:GetMana()*(self.is_scepter and self.mana_damage or self.talents.q1_damage))*k
if self.creeps and target:IsCreep() then
	result = result * (1 + self.creeps)
end
return result
end

function ogre_magi_fireblast_custom_class:OnSpellStart()

self.caster:EmitSound("Hero_OgreMagi.Fireblast.Cast")

local pfx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast_cast.vpcf", self)
if pfx ~= "particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast_cast.vpcf" then
 	self.caster:GenericParticle(pfx)
end

if self.talents.has_q4 == 1 then 
	local cd_items = self.multicast_k and self.talents.q4_cd_items_inc or self.talents.q4_cd_items
	self.caster:CdItems(cd_items)
	self.caster:AddNewModifier(self.caster, self, "modifier_ogre_magi_fireblast_custom_speed", {duration = self.talents.q4_duration})
end	

local proc = 0
local damage_k = 1
local stun_k = 1

if self.multicast_k then
	damage_k = self.multicast_k
	if self.caster.multicast_ability then
		stun_k = 1 + self.caster.multicast_ability.fireblast_stun
	end
end

if self.talents.has_q3 == 1 and not self.multicast_k then
	local mod = self.caster:FindModifierByName("modifier_ogre_magi_fireblast_custom_spell")
	if mod and mod:GetStackCount() >= mod.max then
		mod:Destroy()
		proc = 1
	elseif self.caster.fireblast_ability then
		self.caster:AddNewModifier(self.caster, self.caster.fireblast_ability, "modifier_ogre_magi_fireblast_custom_spell", {duration = self.talents.q3_duration})
	end
end

if self.talents.has_q7 == 1 then 
	if not self.multicast_k then
		self.can_cd = true
	end
	local point = self.caster:CastPosition(self:GetCursorPosition())
	local origin = GetGroundPosition(self.caster:GetAbsOrigin(), nil)

	local direction = point - origin
	direction.z = 0
	direction = direction:Normalized()

	origin.z = origin.z + 100

	local info = {
		Source = self.caster,
		Ability = self,
		vSpawnOrigin = origin,

		bDeleteOnHit = false,

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

		EffectName = self:GetParticle(2),
		fDistance = self.talents.q7_range + self.caster:GetCastRangeBonus(),
		fStartRadius = self.talents.q7_width,
		fEndRadius = self.talents.q7_width,
		vVelocity = direction * self.talents.q7_speed,

		bProvidesVision = true,
		iVisionRadius = 280,
		iVisionTeamNumber = self.caster:GetTeamNumber(),
		ExtraData = 
		{
			x = origin.x,
			y = origin.y,
			proc = proc,
			is_multicast = self.multicast_k and 1 or 0,
			damage_k = damage_k,
			stun_k = stun_k,
		}
	}
	ProjectileManager:CreateLinearProjectile(info)
	return
end

local target = self:GetCursorTarget()
if target:TriggerSpellAbsorb( self ) then return end
self:Impact(target, proc, damage_k, stun_k)
end


function ogre_magi_fireblast_custom_class:Impact(target, proc, damage_k, stun_k)
if not IsServer() then return end

local duration = (self.stun_duration + self.talents.h1_stun)*stun_k
local damageTable = {attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL, ability = self}
local effect = self:GetParticle(1)
local is_attack = self.is_scepter and (self.talents.has_e7 == 1 or self.talents.has_w7 == 1)

if self.caster:GetQuest() == "Ogre.Quest_5" and target:IsRealHero() and not self.caster:QuestCompleted() then 
	self.caster:UpdateQuest(duration * (1 - target:GetStatusResistance()))
end

local targets = {}
if self.talents.has_q7 == 1 then
	table.insert(targets, target)
else
	targets = self.caster:FindTargets(self.cleave_radius, target:GetAbsOrigin())
end

if is_attack then
	self.caster.ogre_scepter_damage = self.attack_damage
end

for _,aoe_target in pairs(targets) do 
	local damage = self:GetDamage(aoe_target)
	if aoe_target ~= target then
		damage = damage*self.cleave_damage
	end
	damageTable.damage = damage*damage_k
	damageTable.victim = aoe_target

	if is_attack then
		self.caster:PerformAttack(aoe_target, true, true, true, true, false, false, true, {damage = "ogre_scepter"})
	else
		DoDamage(damageTable)
	end

	aoe_target:AddNewModifier(self.caster, self,  "modifier_stunned",  {duration = duration * (1 - aoe_target:GetStatusResistance())})

	local particle = ParticleManager:CreateParticle(effect, PATTACH_ABSORIGIN_FOLLOW, aoe_target)
	ParticleManager:SetParticleControlEnt( particle, 0, aoe_target, PATTACH_POINT_FOLLOW, "attach_hitloc", aoe_target:GetAbsOrigin(), true )
	ParticleManager:SetParticleControl( particle, 1, aoe_target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( particle )
	aoe_target:EmitSound("Hero_OgreMagi.Fireblast.Target")

	if proc == 1 then
		if (aoe_target == target or self.talents.has_q7 == 1) then
			local effect_cast = ParticleManager:CreateParticle("particles/ogre-magi/fireblast_proc.vpcf", PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl( effect_cast, 0, aoe_target:GetAbsOrigin())
			ParticleManager:SetParticleControl( effect_cast, 1, Vector(150, 0, 0 ))
			ParticleManager:ReleaseParticleIndex( effect_cast )
			aoe_target:EmitSound("Ogre.Fireblast_proc")
		end

		aoe_target:AddNewModifier(self.caster, self, "modifier_ogre_magi_fireblast_custom_magic", {duration = self.talents.q3_effect_duration})

		damageTable.damage = self:GetDamage(aoe_target)*self.talents.q3_damage
		local real_damage = DoDamage(damageTable, "modifier_ogremagi_blast_3")
		aoe_target:SendNumber(109, real_damage)
	end

	if self.talents.has_h1 == 1 then
		aoe_target:AddNewModifier(self.caster, self, "modifier_ogre_magi_fireblast_custom_slow", {duration = self.talents.h1_duration})
	end

	if IsValid(self.caster.ogre_innate) then
		self.caster.ogre_innate:AbilityTarget(aoe_target, self)
	end
end 

if is_attack then
	self.caster.ogre_scepter_damage = false
end

end

function ogre_magi_fireblast_custom_class:OnProjectileHit_ExtraData(target, location, data)

if not target then 
	if self.talents.has_q7 == 1 then
		local point = GetGroundPosition(location, nil) + Vector(0,0,70)
		local particle = ParticleManager:CreateParticle(self:GetParticle(1), PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl( particle, 0, point)
		ParticleManager:SetParticleControl( particle, 1, point)
		ParticleManager:ReleaseParticleIndex( particle )
		EmitSoundOnLocationWithCaster(location, "Hero_OgreMagi.Fireblast.Target", self.caster)
	end
	return
end

self:Impact(target, data.proc, data.damage_k, data.stun_k)

local dist = (target:GetAbsOrigin() - GetGroundPosition(Vector(data.x, data.y, 0), nil)):Length2D() 

if dist < self.talents.q7_distance then return end
if self.can_cd then
	self.can_cd = false
	self.caster:CdAbility(self, nil, self.talents.q7_cd)
end
target:AddNewModifier(self.caster, self, "modifier_ogre_magi_fireblast_custom_legendary_damage", {duration = self.talents.q7_duration})
end 

function ogre_magi_fireblast_custom_class:CheckInterval()
if not IsServer() then return end
if self.ability.talents.has_q7 == 0 then return end

self.multicast_delay = self.ability.talents.q7_interval
end


ogre_magi_fireblast_custom = class(ogre_magi_fireblast_custom_class)
ogre_magi_fireblast_custom.talents = {}

function ogre_magi_fireblast_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast.vpcf", context )
PrecacheResource( "particle","particles/ogre_fireball.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_ogre_magi/ogre_magi_unr_fireblast.vpcf", context )
PrecacheResource( "particle","particles/ogre_fireball_agh.vpcf", context )
PrecacheResource( "particle","particles/ogre_knockback.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf", context )
PrecacheResource( "particle","particles/ogre_fire_stack.vpcf", context )
PrecacheResource( "particle","particles/ogre_magi/fire_shield.vpcf", context )
PrecacheResource( "particle","particles/ogre_magichit.vpcf", context )
PrecacheResource( "particle","particles/ogre_hit.vpcf", context )
PrecacheResource( "particle","particles/ogre_magi/fireblast_stack.vpcf", context )
PrecacheResource( "particle","particles/lina_attack_slow.vpcf", context )
PrecacheResource( "particle","particles/ogre-magi/fireblast_proc.vpcf", context )
end

function ogre_magi_fireblast_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_spell = 0,
    q1_damage = 0,
    
    has_q2 = 0,
    q2_range = 0,
    q2_cd = 0,
    
    has_q3 = 0,
    q3_magic = 0,
    q3_damage = 0,
    q3_duration = caster:GetTalentValue("modifier_ogremagi_blast_3", "duration", true),
    q3_effect_duration = caster:GetTalentValue("modifier_ogremagi_blast_3", "effect_duration", true),
    q3_max = caster:GetTalentValue("modifier_ogremagi_blast_3", "max", true),
    
    has_q4 = 0,
    q4_duration = caster:GetTalentValue("modifier_ogremagi_blast_4", "duration", true),
    q4_cd_items = caster:GetTalentValue("modifier_ogremagi_blast_4", "cd_items", true),
    q4_cast = caster:GetTalentValue("modifier_ogremagi_blast_4", "cast", true),
    q4_move = caster:GetTalentValue("modifier_ogremagi_blast_4", "move", true),
    q4_cd_items_inc = caster:GetTalentValue("modifier_ogremagi_blast_4", "cd_items_inc", true),
    
    has_q7 = 0,
    q7_speed = caster:GetTalentValue("modifier_ogremagi_blast_7", "speed", true),
    q7_distance = caster:GetTalentValue("modifier_ogremagi_blast_7", "distance", true),
    q7_duration = caster:GetTalentValue("modifier_ogremagi_blast_7", "duration", true),
    q7_width = caster:GetTalentValue("modifier_ogremagi_blast_7", "width", true),
    q7_range = caster:GetTalentValue("modifier_ogremagi_blast_7", "range", true),
    q7_cd = caster:GetTalentValue("modifier_ogremagi_blast_7", "cd", true)/100,
    q7_max = caster:GetTalentValue("modifier_ogremagi_blast_7", "max", true),
    q7_mana = caster:GetTalentValue("modifier_ogremagi_blast_7", "mana", true)/100,
    q7_damage = caster:GetTalentValue("modifier_ogremagi_blast_7", "damage", true)/100,
    q7_interval = caster:GetTalentValue("modifier_ogremagi_blast_7", "interval", true),
    
    has_h1 = 0,
    h1_stun = 0,
    h1_slow = 0,
    h1_duration = caster:GetTalentValue("modifier_ogremagi_hero_1", "duration", true),
    
    has_w7 = 0,

    has_e7 = 0,
  }
end

if caster:HasTalent("modifier_ogremagi_blast_1") then
  self.talents.has_q1 = 1
  self.talents.q1_spell = caster:GetTalentValue("modifier_ogremagi_blast_1", "spell")
  self.talents.q1_damage = caster:GetTalentValue("modifier_ogremagi_blast_1", "damage")/100
end

if caster:HasTalent("modifier_ogremagi_blast_2") then
  self.talents.has_q2 = 1
  self.talents.q2_range = caster:GetTalentValue("modifier_ogremagi_blast_2", "range")
  self.talents.q2_cd = caster:GetTalentValue("modifier_ogremagi_blast_2", "cd")
end

if caster:HasTalent("modifier_ogremagi_blast_3") then
  self.talents.has_q3 = 1
  self.talents.q3_magic = caster:GetTalentValue("modifier_ogremagi_blast_3", "magic")
  self.talents.q3_damage = caster:GetTalentValue("modifier_ogremagi_blast_3", "damage")/100
  self.caster:AddSpellEvent(self.tracker, true)
  self.tracker:UpdateUI()
end

if caster:HasTalent("modifier_ogremagi_blast_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_ogremagi_blast_7") then
  self.talents.has_q7 = 1
  if IsServer() then
 	self:CheckInterval()
  	if self.caster.fireblast_scepter_ability then
  		self.caster.fireblast_scepter_ability:CheckInterval()
  	end
  end
end

if caster:HasTalent("modifier_ogremagi_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_stun = caster:GetTalentValue("modifier_ogremagi_hero_1", "stun")
  self.talents.h1_slow = caster:GetTalentValue("modifier_ogremagi_hero_1", "slow")
end

if caster:HasTalent("modifier_ogremagi_ignite_7") then
  self.talents.has_w7 = 1
end

if caster:HasTalent("modifier_ogremagi_bloodlust_7") then
  self.talents.has_e7 = 1
  self.tracker:UpdateUI()
end

end

function ogre_magi_fireblast_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_ogre_magi_fireblast_custom_tracker"
end

function ogre_magi_fireblast_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.q2_cd and self.talents.q2_cd or 0)
end

function ogre_magi_fireblast_custom:GetManaCost( level )
return self.BaseClass.GetManaCost(self, level) * (1 + (self.talents.has_q7 == 1 and self.talents.q7_mana or 0))
end


ogre_magi_unrefined_fireblast_custom = class(ogre_magi_fireblast_custom_class)
ogre_magi_unrefined_fireblast_custom.is_scepter = true
ogre_magi_unrefined_fireblast_custom.talents = {}

function ogre_magi_unrefined_fireblast_custom:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()
self.ability = self
self.parent = self.caster

self.stun_duration = self:GetLevelSpecialValueFor("stun_duration", 1)
self.fireblast_damage = self:GetLevelSpecialValueFor("fireblast_damage", 1)
self.multicast_delay = self:GetLevelSpecialValueFor("multicast_delay", 1)
self.mana_damage = self:GetLevelSpecialValueFor("mana_damage", 1)/100
self.cleave_damage = self:GetLevelSpecialValueFor("cleave_damage", 1)/100
self.cleave_radius = self:GetLevelSpecialValueFor("cleave_radius", 1)
self.scepter_mana = self:GetLevelSpecialValueFor("scepter_mana", 1)/100
self.attack_damage = self:GetLevelSpecialValueFor("attack_damage", 1) - 100
end

function ogre_magi_unrefined_fireblast_custom:GetManaCost( level )
if not self.scepter_mana then return end
return math.floor(self.caster:GetMana() * self.scepter_mana)
end



modifier_ogre_magi_fireblast_custom_tracker = class(mod_hidden)
function modifier_ogre_magi_fireblast_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.fireblast_ability = self.ability

self.parent.fireblast_scepter_ability = self.parent:FindAbilityByName("ogre_magi_unrefined_fireblast_custom")
if self.parent.fireblast_scepter_ability then
	self.parent.fireblast_scepter_ability.talents = self.ability.talents
end

self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
self.ability.fireblast_damage = self.ability:GetSpecialValueFor("fireblast_damage")
self.ability.multicast_delay = self.ability:GetSpecialValueFor("multicast_delay")
self.ability.mana_damage = self.ability:GetSpecialValueFor("mana_damage")
self.ability.cleave_damage = self.ability:GetSpecialValueFor("cleave_damage")/100
self.ability.cleave_radius = self.ability:GetSpecialValueFor("cleave_radius")
self.ability.creeps = self.ability:GetSpecialValueFor("creeps")/100
self.ability:CheckInterval()
end

function modifier_ogre_magi_fireblast_custom_tracker:OnRefresh()
self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
self.ability.fireblast_damage = self.ability:GetSpecialValueFor("fireblast_damage")
end

function modifier_ogre_magi_fireblast_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if self.ability.talents.has_q3 == 0 then return end
if self.parent ~= params.unit then return end
if params.ability == self.ability or params.ability == self.parent.fireblast_scepter_ability then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_ogre_magi_fireblast_custom_spell", {duration = self.ability.talents.q3_duration})
end

function modifier_ogre_magi_fireblast_custom_tracker:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_q3 == 0 then return end

local stack = 0
local max = self.ability.talents.q3_max
local mod = self.parent:FindModifierByName("modifier_ogre_magi_fireblast_custom_spell")
if mod then
	stack = mod:GetStackCount()
end

local hide = 0
if self.ability.talents.has_e7 == 1 then
	hide = 1
end

self.parent:UpdateUIlong({max = max, stack = stack, active = stack >= max and 1 or 0, hide = hide, style = "OgreFireblast"})
end

function modifier_ogre_magi_fireblast_custom_tracker:DeclareFunctions()
return
{
  	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_ogre_magi_fireblast_custom_tracker:GetModifierTotalDamageOutgoing_Percentage(params)
if not self.parent.ogre_scepter_damage then return end
if params.inflictor then return end
return self.parent.ogre_scepter_damage
end

function modifier_ogre_magi_fireblast_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end

function modifier_ogre_magi_fireblast_custom_tracker:GetModifierCastRangeBonusStacking()
return self.ability.talents.q2_range
end



modifier_ogre_magi_fireblast_custom_spell = class(mod_hidden)
function modifier_ogre_magi_fireblast_custom_spell:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.RemoveForDuel = true 
self.max = self.ability.talents.q3_max

if not IsServer() then return end
self:OnRefresh()
end

function modifier_ogre_magi_fireblast_custom_spell:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()

if self:GetStackCount() == self.max then 
	self.parent:EmitSound("Ogre.Multi_proc")
	self.parent:GenericParticle("particles/ogre_magichit.vpcf", self)
	self.parent:GenericParticle("particles/ogre_head.vpcf", self, true)
end

self.ability.tracker:UpdateUI()
end

function modifier_ogre_magi_fireblast_custom_spell:OnDestroy()
if not IsServer() then return end
self.ability.tracker:UpdateUI()
end


modifier_ogre_magi_fireblast_custom_legendary_damage = class(mod_visible)
function modifier_ogre_magi_fireblast_custom_legendary_damage:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_max

if not IsServer() then return end 
self.RemoveForDuel = true 

self.effect_cast = self.parent:GenericParticle("particles/ogre_magi/fireblast_stack.vpcf", self, true)
self:OnRefresh()
end

function modifier_ogre_magi_fireblast_custom_legendary_damage:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end

function modifier_ogre_magi_fireblast_custom_legendary_damage:OnStackCountChanged(iStackCount)
if not IsServer() then return end
local number_1 = self:GetStackCount()
local double = math.floor(number_1/10)
local number_2 = number_1 - double*10

ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(double, number_1, number_2))
end



modifier_ogre_magi_fireblast_custom_speed = class(mod_visible)
function modifier_ogre_magi_fireblast_custom_speed:GetTexture() return "buffs/ogre_magi/fireblast_4" end
function modifier_ogre_magi_fireblast_custom_speed:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.talents.q4_move
if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", self)
end

function modifier_ogre_magi_fireblast_custom_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_ogre_magi_fireblast_custom_speed:GetModifierMoveSpeedBonus_Percentage()
return self.move
end



modifier_ogre_magi_fireblast_custom_slow = class(mod_hidden)
function modifier_ogre_magi_fireblast_custom_slow:IsPurgable() return true end
function modifier_ogre_magi_fireblast_custom_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability.talents.h1_slow
if not IsServer() then return end
self.parent:GenericParticle("particles/lina_attack_slow.vpcf", self)
end

function modifier_ogre_magi_fireblast_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_ogre_magi_fireblast_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_ogre_magi_fireblast_custom_magic = class(mod_visible)
function modifier_ogre_magi_fireblast_custom_magic:GetTexture() return "buffs/ogre_magi/fireblast_3" end
function modifier_ogre_magi_fireblast_custom_magic:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:GenericParticle("particles/ember_spirit/guard_resist_max.vpcf", self)
end

function modifier_ogre_magi_fireblast_custom_magic:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_ogre_magi_fireblast_custom_magic:GetModifierMagicalResistanceBonus()
return self.ability.talents.q3_magic
end
