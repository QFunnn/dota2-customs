--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom", "abilities/crystal_maiden/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom_debuff", "abilities/crystal_maiden/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom_legendary", "abilities/crystal_maiden/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom_legendary_mini", "abilities/crystal_maiden/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom_tracker", "abilities/crystal_maiden/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom_knock_cd", "abilities/crystal_maiden/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom_cd_items", "abilities/crystal_maiden/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_freezing_field_custom = class({})
crystal_maiden_freezing_field_custom.talents = {}

function crystal_maiden_freezing_field_custom:CreateTalent()
self:ToggleAutoCast()
end

function crystal_maiden_freezing_field_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", context )
PrecacheResource( "particle", "particles/crystal_maiden/immunity_sphere_buff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/generic_slowed_cold.vpcf", context )
PrecacheResource( "particle", "particles/maiden_frostbite_slow.vpcf", context )
PrecacheResource( "particle", "particles/maiden_freezing_area.vpcf", context )
PrecacheResource( "particle", "particles/maiden_field_legendary.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_frosty_dire.vpcf", context )
PrecacheResource( "particle", "particles/crystal_maiden/freezing_shields.vpcf", context )
end

function crystal_maiden_freezing_field_custom:UpdateTalents()
local caster = self:GetCaster()

if not self.init then
  self.init = true

	self.talents =
	{
		damage_inc = 0,
		r1_base = 0,

		cd_inc = 0,
		linger_inc = 0,

		has_auto = 0,
		auto_damage = 0,
		r3_cdr = 0,
		auto_count = caster:GetTalentValue("modifier_maiden_freezing_3", "count", true),
		auto_radius = caster:GetTalentValue("modifier_maiden_freezing_3", "radius", true),

		has_silence = 0,
		silence_delay = caster:GetTalentValue("modifier_maiden_freezing_4", "delay", true),
		silence_cd = caster:GetTalentValue("modifier_maiden_freezing_4", "cd", true),
		silence_duration = caster:GetTalentValue("modifier_maiden_freezing_4", "silence", true),
		silence_distance_min = caster:GetTalentValue("modifier_maiden_freezing_4", "distance_min", true),
		silence_distance_max = caster:GetTalentValue("modifier_maiden_freezing_4", "distance_max", true),
		silence_pull_duration = caster:GetTalentValue("modifier_maiden_freezing_4", "duration", true),

		has_blink = 0,
		blink_range = caster:GetTalentValue("modifier_maiden_hero_4", "range", true),
		h4_invun = caster:GetTalentValue("modifier_maiden_hero_4", "invun", true),
		blink_reduce = caster:GetTalentValue("modifier_maiden_hero_4", "damage_reduce", true),

		has_legendary = 0,
		legendary_slow = caster:GetTalentValue("modifier_maiden_freezing_7", "slow", true),
		legendary_mana = caster:GetTalentValue("modifier_maiden_freezing_7", "mana_regen", true)/100,
		legendary_cd_inc = caster:GetTalentValue("modifier_maiden_freezing_7", "cd_inc", true)/100,

    has_w4 = 0,
    w4_cd_field = caster:GetTalentValue("modifier_maiden_frostbite_4", "cd_field", true)/100,
	}
end

if caster:HasTalent("modifier_maiden_freezing_1") then
  self.talents.damage_inc = caster:GetTalentValue("modifier_maiden_freezing_1", "damage")/100
  self.talents.r1_base = caster:GetTalentValue("modifier_maiden_freezing_1", "base")
end

if caster:HasTalent("modifier_maiden_freezing_2") then
	self.talents.has_linger = 1
  self.talents.cd_inc = caster:GetTalentValue("modifier_maiden_freezing_2", "cd")
  self.talents.linger_inc = caster:GetTalentValue("modifier_maiden_freezing_2", "linger")
end

if caster:HasTalent("modifier_maiden_freezing_3") then
	self.talents.has_auto = 1
  self.talents.auto_damage = caster:GetTalentValue("modifier_maiden_freezing_3", "auto")/100
  self.talents.r3_cdr = caster:GetTalentValue("modifier_maiden_freezing_3", "cdr")
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_maiden_freezing_4") then
	self.talents.has_silence = 1
end

if caster:HasTalent("modifier_maiden_hero_4") then
	self.talents.has_blink = 1
end

if caster:HasTalent("modifier_maiden_freezing_7") then
	self.talents.has_legendary = 1
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_maiden_frostbite_4") then
  self.talents.has_w4 = 1
end

end

function crystal_maiden_freezing_field_custom:GetAbilityTextureName()
local caster = self:GetCaster()

if caster:HasScepter() and caster:HasModifier("modifier_crystal_maiden_freezing_field_custom") then 
  return wearables_system:GetAbilityIconReplacement(self.caster, "crystal_maiden_freezing_field_stop", self)
else 
  return wearables_system:GetAbilityIconReplacement(self.caster, "crystal_maiden_freezing_field", self)
end 

end
 
function crystal_maiden_freezing_field_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_crystal_maiden_freezing_field_custom_tracker"
end

function crystal_maiden_freezing_field_custom:GetCastRange(vLocation, hTarget)
if self.talents.has_blink == 0 then return end
return self.talents.blink_range
end

function crystal_maiden_freezing_field_custom:GetAOERadius()
return self.radius
end

function crystal_maiden_freezing_field_custom:GetManaCost(level)
local caster = self:GetCaster()
if self.talents.has_legendary == 1 or (caster:HasScepter() and caster:HasModifier("modifier_crystal_maiden_freezing_field_custom")) then
	return 0
end
return self.BaseClass.GetManaCost(self, level)
end

function crystal_maiden_freezing_field_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.cd_inc and self.talents.cd_inc or 0)
end

function crystal_maiden_freezing_field_custom:GetBehavior()
local auto = 0
local caster = self:GetCaster()
if self.talents.has_silence == 1 then 
  auto = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end 
local base = DOTA_ABILITY_BEHAVIOR_NO_TARGET
if self.talents.has_blink == 1 and not caster:HasModifier("modifier_crystal_maiden_freezing_field_custom") then
	base = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end
if caster:HasScepter() then
  return base + auto
end
return base + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + auto
end

function crystal_maiden_freezing_field_custom:GetChannelTime()
if self:GetCaster():HasScepter() then
	return 0
end
return self.duration and self.duration or 0
end

function crystal_maiden_freezing_field_custom:OnSpellStart()
local caster = self:GetCaster()

local mod = caster:FindModifierByName("modifier_crystal_maiden_freezing_field_custom")
if mod then
	mod:EndEffect()
	return
end

if self.talents.has_blink == 1 and not caster:IsRooted() and not caster:IsLeashed() then
	local point = self:GetCursorPosition()
  EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "DOTA_Item.Arcane_Blink.Activate", caster)

  local effect_end = ParticleManager:CreateParticle( "particles/econ/events/winter_major_2016/blink_dagger_start_wm.vpcf", PATTACH_WORLDORIGIN, nil )
  ParticleManager:SetParticleControl( effect_end, 0, caster:GetAbsOrigin() )
  ParticleManager:ReleaseParticleIndex( effect_end )

  FindClearSpaceForUnit(caster, point, true)

  local effect_end = ParticleManager:CreateParticle( "particles/econ/events/winter_major_2016/blink_dagger_wm_end.vpcf", PATTACH_WORLDORIGIN, nil )
  ParticleManager:SetParticleControl( effect_end, 0, caster:GetAbsOrigin() )
  ParticleManager:ReleaseParticleIndex( effect_end )

  ProjectileManager:ProjectileDodge(caster)
  caster:EmitSound("Puck.Rift_Legendary")
  caster:AddNewModifier(caster, self, "modifier_crystal_maiden_crystal_nova_invun", {duration = self.talents.h4_invun})
end

caster:AddNewModifier(caster, self, "modifier_crystal_maiden_freezing_field_custom", {duration = self.duration + self.talents.linger_inc})

if caster:HasScepter() then 
	self:StartCooldown(1)
else
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
end

end

function crystal_maiden_freezing_field_custom:OnChannelFinish( bInterrupted )
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_crystal_maiden_freezing_field_custom")

if not mod then return end

mod:EndEffect()
if not caster:HasScepter() then 
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
end

end

function crystal_maiden_freezing_field_custom:DealDamage(radius, point, damage_ability)
if not IsServer() then return end

local caster = self:GetCaster()
local damage = self.damage + self.talents.r1_base + caster:GetMaxMana()*self.talents.damage_inc
local slow_duration = damage_ability and self.talents.legendary_slow or self.slow_duration
local aura = caster:FindAbilityByName("crystal_maiden_arcane_aura_custom")

if damage_ability == "modifier_maiden_freezing_3" then
	damage = damage * self.talents.auto_damage
end

local damageTable = {attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self}
for _,enemy in pairs(caster:FindTargets(radius, point)) do
	damageTable.victim = enemy
	DoDamage(damageTable, damage_ability)
	enemy:AddNewModifier(caster, self, "modifier_crystal_maiden_freezing_field_custom_debuff", {duration = slow_duration})
end

if aura and aura:IsTrained() then
  aura:SearchClones(radius, point)
end

end

function crystal_maiden_freezing_field_custom:SummonShard(point, damage_ability)
if not IsServer() then return end
local caster = self:GetCaster()
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, point )
ParticleManager:ReleaseParticleIndex(effect_cast)

EmitSoundOnLocationWithCaster( point, "hero_Crystal.freezingField.explosion", caster )
CreateModifierThinker(caster, self, "modifier_crystal_maiden_freezing_field_custom_legendary_mini", {duration = 0.25, damage_ability = damage_ability}, point, caster:GetTeamNumber(), false)
end


modifier_crystal_maiden_freezing_field_custom = class(mod_visible)
function modifier_crystal_maiden_freezing_field_custom:OnCreated()	
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow_radius = self.ability.radius
self.slow_duration = self.ability.slow_duration
self.explosion_radius = self.ability.explosion_radius
self.explosion_interval = self.ability.explosion_interval
self.scepter_slow = self.ability.scepter_slow

self.explosion_min_dist = self.explosion_radius/2
self.explosion_max_dist = self.slow_radius - self.explosion_radius/2

self.quartal = -1

if not IsServer() then return end
self.ability:EndCd()
if self.parent:HasScepter() then
	self.ability:SetActivated(true)
	self.ability:StartCooldown(1)
end

if self.ability.talents.has_blink == 1 then
	self.parent:GenericParticle("particles/crystal_maiden/freezing_shields.vpcf", self)
end

if self.ability.talents.has_w4 == 1 then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_crystal_maiden_freezing_field_custom_cd_items", {})
end

self.RemoveForDuel = true
self:SetStackCount(0)

self.knock_max = self.parent:GetTalentValue("modifier_maiden_freezing_5", "cd", true)
self.knock_silence = self.parent:GetTalentValue("modifier_maiden_freezing_5", "silence", true)
self.knock_duration = self.parent:GetTalentValue("modifier_maiden_freezing_5", "duration", true)
self.knock_count = 0

local effect_name = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf", self)
self.shard_effect = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", self)

self.effect_cast = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.slow_radius, self.slow_radius, 1 ) )
self:AddParticle( self.effect_cast, false, false, -1, false, false )

self.sound = wearables_system:GetSoundReplacement(self.parent, "hero_Crystal.freezingField.wind", self)

self.parent:EmitSound(self.sound)
self:OnIntervalThink()
self:StartIntervalThink( self.explosion_interval )
end

function modifier_crystal_maiden_freezing_field_custom:OnDestroy()	
if not IsServer() then return end
self.ability:StartCd()

self.parent:RemoveModifierByName("modifier_crystal_maiden_freezing_field_custom_cd_items")

if self.parent.arcane_aura_ability and IsValid(self.parent.arcane_aura_ability.tracker) then
	self.parent.arcane_aura_ability.tracker:OnIntervalThink()
end

self.parent:StopSound(self.sound)
end

function modifier_crystal_maiden_freezing_field_custom:EndEffect()
if not IsServer() then return end
if self:GetStackCount() == 1 then return end

self:SetStackCount(1)
if self.ability.talents.has_linger == 1 then
	self.ability:EndCd()
	self:SetDuration(self.ability.talents.linger_inc, true)
else
	self:Destroy()
end

end

function modifier_crystal_maiden_freezing_field_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end

function modifier_crystal_maiden_freezing_field_custom:GetModifierIncomingDamage_Percentage()
if self.ability.talents.has_blink == 0 then return end
return self.ability.talents.blink_reduce
end

function modifier_crystal_maiden_freezing_field_custom:GetModifierMoveSpeedBonus_Percentage()
if not self.parent:HasScepter() or self:GetStackCount() == 1 then return end
return self.scepter_slow
end

function modifier_crystal_maiden_freezing_field_custom:OnIntervalThink()
if not IsServer() then return end
local origin = self.parent:GetAbsOrigin()
local knock = self.ability.talents.has_silence == 1 and self:GetElapsedTime() >= self.ability.talents.silence_delay

for _,enemy in pairs(self.parent:FindTargets(self.slow_radius)) do 
	enemy:AddNewModifier(self.parent, self.ability, "modifier_crystal_maiden_freezing_field_custom_debuff", {duration = self.slow_duration})

	if knock and not enemy:HasModifier("modifier_crystal_maiden_freezing_field_custom_knock_cd") and enemy:IsUnit() then 
		
		if self.ability:GetAutoCastState() then
			local target_point = enemy:GetAbsOrigin()
			if target_point == origin then
				target_point = target_point + enemy:GetForwardVector()*10
			end
			local direction = Vector(0, 0, 0)
			local distance = 0

			if (target_point - origin):Length2D() > self.ability.talents.silence_distance_min then
				local pull_point = origin + (target_point - origin):Normalized()*self.ability.talents.silence_distance_min
				direction = pull_point - target_point
				distance = math.min(self.ability.talents.silence_distance_max, direction:Length2D())
				direction = direction:Normalized()
			end

			local arc = enemy:AddNewModifier(self.parent, self.ability, "modifier_generic_arc",
			{ 
				dir_x = direction.x,
				dir_y = direction.y,
				duration = self.ability.talents.silence_pull_duration,
				distance = distance,
				fix_end = false,
				isStun = false,
				activity = ACT_DOTA_FLAIL,
			})
		end
		enemy:EmitSound("Maiden.Freezing_silence")
		enemy:AddNewModifier(self.parent, self.ability, "modifier_generic_silence", { duration = (1 - self.parent:GetStatusResistance())*self.ability.talents.silence_duration})
		enemy:AddNewModifier(self.parent, self.ability, "modifier_crystal_maiden_freezing_field_custom_knock_cd", {duration = self.ability.talents.silence_cd})
	end
end

if self.ability.talents.has_legendary == 1 then
	self.parent:GiveMana(self.ability.talents.legendary_mana*self.parent:GetMaxMana()*self.explosion_interval)
end

if self.parent:HasScepter() and self:GetRemainingTime() <= self.ability.talents.linger_inc and self.ability.talents.has_linger == 1 then
	self:EndEffect()
end

self.quartal = self.quartal + 1
if self.quartal > 3 then 
	self.quartal = 0 
end

local a = RandomInt(0,90) + self.quartal*90
local r = RandomInt(self.explosion_min_dist,self.explosion_max_dist)
local point = Vector( math.cos(a), math.sin(a), 0 ):Normalized() * r
point = origin + point

self.ability:DealDamage(self.explosion_radius, point)

local effect_cast = ParticleManager:CreateParticle( self.shard_effect, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, point )
ParticleManager:ReleaseParticleIndex(effect_cast)
EmitSoundOnLocationWithCaster( point, "hero_Crystal.freezingField.explosion", self.parent )
end


modifier_crystal_maiden_freezing_field_custom_debuff = class({})
function modifier_crystal_maiden_freezing_field_custom_debuff:IsPurgable() return true end
function modifier_crystal_maiden_freezing_field_custom_debuff:IsHidden() return false end
function modifier_crystal_maiden_freezing_field_custom_debuff:OnCreated( kv )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.ms_slow = self.ability.movespeed_slow
self.as_slow = self.ability.attack_slow
self.parent:GenericParticle("particles/generic_gameplay/generic_slowed_cold.vpcf", self)
end

function modifier_crystal_maiden_freezing_field_custom_debuff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.ms_slow
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetModifierAttackSpeedBonus_Constant()
return self.as_slow
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetStatusEffectName()
return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_crystal_maiden_freezing_field_custom_debuff:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end



modifier_crystal_maiden_freezing_field_custom_tracker = class(mod_hidden)
function modifier_crystal_maiden_freezing_field_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.legendary_ability = self.parent:FindAbilityByName("crystal_maiden_freezing_field_legendary")
if self.legendary_ability then
	self.legendary_ability:UpdateTalents()
end

self.ability.duration = self.ability:GetSpecialValueFor("duration")          
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.explosion_radius = self.ability:GetSpecialValueFor("explosion_radius")  
self.ability.explosion_interval = self.ability:GetSpecialValueFor("explosion_interval")
self.ability.movespeed_slow = self.ability:GetSpecialValueFor("movespeed_slow")
self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
self.ability.damage = self.ability:GetSpecialValueFor("damage")  
self.ability.attack_slow = self.ability:GetSpecialValueFor("attack_slow")       
self.ability.scepter_slow = self.ability:GetSpecialValueFor("scepter_slow")   

self.spell_count = 0
end

function modifier_crystal_maiden_freezing_field_custom_tracker:OnRefresh()
self.ability.damage = self.ability:GetSpecialValueFor("damage")  
self.ability.attack_slow = self.ability:GetSpecialValueFor("attack_slow") 
end

function modifier_crystal_maiden_freezing_field_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
}
end

function modifier_crystal_maiden_freezing_field_custom_tracker:GetModifierPercentageCooldown()
return self.ability.talents.r3_cdr
end

function modifier_crystal_maiden_freezing_field_custom_tracker:SpellEvent( params )
if not IsServer() then return end
if params.unit~=self.parent then return end

if self.ability.talents.has_auto == 1 then
	self.spell_count = self.spell_count + 1
	if self.spell_count >= self.ability.talents.auto_count then
		self.spell_count = 0
		local point = nil
		local target = self.parent:RandomTarget(self.ability.talents.auto_radius)

		if target then
			point = target:GetAbsOrigin()
		else
			point = self.parent:GetAbsOrigin() + RandomVector(500)
		end
	  self.ability:SummonShard(point, "modifier_maiden_freezing_3")
	end
end


if self.ability.talents.has_legendary == 0 then return end
if not self.legendary_ability then return end
if params.ability == self.legendary_ability then return end

self.parent:CdAbility(self.legendary_ability, nil, self.ability.talents.legendary_cd_inc)
end


crystal_maiden_freezing_field_legendary = class({})

function crystal_maiden_freezing_field_legendary:CreateTalent()
self:SetHidden(false)
end

function crystal_maiden_freezing_field_legendary:UpdateTalents()
local caster = self:GetCaster()

if not self.init and caster:HasTalent("modifier_maiden_freezing_7") then
	self.init = true
	if IsServer() then
		self:SetLevel(1)
	end
	self.count = caster:GetTalentValue("modifier_maiden_freezing_7", "count", true)
	self.cd = caster:GetTalentValue("modifier_maiden_freezing_7", "talent_cd", true)
	self.mana = caster:GetTalentValue("modifier_maiden_freezing_7", "mana", true)/100
	self.radius = self:GetSpecialValueFor("radius")
	self.damage_interval = self:GetSpecialValueFor("damage_interval")
	self.start_interval = self:GetSpecialValueFor("delay")
end

end

function crystal_maiden_freezing_field_legendary:GetAOERadius()
return self.radius and self.radius or 0
end

function crystal_maiden_freezing_field_legendary:GetCooldown()
return self.cd and self.cd or 0
end

function crystal_maiden_freezing_field_legendary:GetManaCost()
return self:GetCaster():GetMaxMana()*(self.mana and self.mana or 0)
end

function crystal_maiden_freezing_field_legendary:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()

CreateModifierThinker(caster, self, "modifier_crystal_maiden_freezing_field_custom_legendary", {}, point, caster:GetTeamNumber(), false)
end


modifier_crystal_maiden_freezing_field_custom_legendary = class(mod_hidden)
function modifier_crystal_maiden_freezing_field_custom_legendary:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.origin = self.parent:GetAbsOrigin()
self.ultimate = self.caster:FindAbilityByName("crystal_maiden_freezing_field_custom")

self.start_interval = self.ability.start_interval
self.damage_interval = self.ability.damage_interval
self.radius = self.ability.radius
self.max = self.ability.count

AddFOWViewer(self.caster:GetTeamNumber(), self.origin, self.radius, self.start_interval, false)

self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, self.radius, 1 ) )
self:AddParticle( self.effect_cast, false, false, -1, false, false )

EmitSoundOnLocationWithCaster( self.origin, "Maiden.Frostbite_stun", self.caster )

self.effect_timer = ParticleManager:CreateParticle("particles/maiden_freezing_area.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.effect_timer, 1, Vector(0, 0, 100))
ParticleManager:SetParticleControl(self.effect_timer, 5, Vector(self.radius, self.radius, self.radius))
self:AddParticle( self.effect_timer, false, false, -1, false, false )

self:SetStackCount(0)
self:StartIntervalThink(self.start_interval)
end

function modifier_crystal_maiden_freezing_field_custom_legendary:OnIntervalThink()
if not IsServer() then return end

local point = self.origin + RandomVector(RandomInt(1, self.radius))

if self.ultimate and self.ultimate:IsTrained() then
	self.ultimate:SummonShard(point, "modifier_maiden_freezing_7")
end

self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
	self:Destroy()
end

AddFOWViewer(self.caster:GetTeamNumber(), self.origin, self.radius, self.damage_interval, false)
self:StartIntervalThink(self.damage_interval)
end


modifier_crystal_maiden_freezing_field_custom_legendary_mini = class(mod_hidden)
function modifier_crystal_maiden_freezing_field_custom_legendary_mini:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.origin = self.parent:GetAbsOrigin()

self.radius = 250
self.damage_ability = table.damage_ability
self.duration = self.ability.slow_duration
end

function modifier_crystal_maiden_freezing_field_custom_legendary_mini:OnDestroy()
if not IsServer() then return end

local effect_cast2 = ParticleManager:CreateParticle( "particles/maiden_field_legendary.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast2, 0, self.origin )
ParticleManager:SetParticleControl( effect_cast2, 1, Vector( self.radius, 3, self.radius ) )
ParticleManager:ReleaseParticleIndex( effect_cast2 )

self.ability:DealDamage(self.radius, self.origin, self.damage_ability)

EmitSoundOnLocationWithCaster( self.origin, "Maiden.Freezing_damage", self:GetCaster() )
EmitSoundOnLocationWithCaster( self.origin, "Maiden.Freezing_damage2", self:GetCaster() )
end



modifier_crystal_maiden_freezing_field_custom_knock_cd = class(mod_hidden)

modifier_crystal_maiden_freezing_field_custom_cd_items = class(mod_hidden)
function modifier_crystal_maiden_freezing_field_custom_cd_items:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.interval = 0.5

self:StartIntervalThink(self.interval)
end

function modifier_crystal_maiden_freezing_field_custom_cd_items:OnIntervalThink()
if not IsServer() then return end
self.parent:CdItems(self.interval*self.ability.talents.w4_cd_field)
end