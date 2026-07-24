--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_axe_counter_helix_custom", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_legendary", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_cd", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_armor", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_legendary_active", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_health_change", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_shield_cd", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_haste", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_scepter", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_scepter_cd", "abilities/axe/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )

axe_counter_helix_custom = class({})
axe_counter_helix_custom.talents = {}
axe_counter_helix_custom.attack_time = 0

function axe_counter_helix_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_axe/axe_counterhelix.vpcf", context )
PrecacheResource( "particle", "particles/items4_fx/ascetic_cap.vpcf", context )
PrecacheResource( "particle", "particles/axe_spin.vpcf", context )
PrecacheResource( "particle", "particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle", "particles/items3_fx/hook_root.vpcf", context )
PrecacheResource( "particle", "particles/axe/axe_charge.vpcf", context )
PrecacheResource( "particle", "particles/axe/helix_legendary_effect.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", context )
PrecacheResource( "particle", "particles/axe/helix_shield.vpcf", context )

PrecacheResource( "particle", "particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf", context )
end

function axe_counter_helix_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e1 = 0,
    e1_health = 0,
    e1_base = 0,
    
    has_e2 = 0,
    e2_radius = 0,
    e2_heal = 0,
    e2_base = 0,
    
    has_e3 = 0,
    e3_health_reduce = 0,
    e3_health = 0,
    e3_duration = caster:GetTalentValue("modifier_axe_helix_3", "duration", true),
    e3_max = caster:GetTalentValue("modifier_axe_helix_3", "max", true),
    e3_duration_creeps = caster:GetTalentValue("modifier_axe_helix_3", "duration_creeps", true),
    
    has_e4 = 0,
    e4_move = caster:GetTalentValue("modifier_axe_helix_4", "move", true),
    e4_duration = caster:GetTalentValue("modifier_axe_helix_4", "duration", true),
    e4_cd_items = caster:GetTalentValue("modifier_axe_helix_4", "cd_items", true),
    
    has_e7 = 0,
    e7_talent_cd = caster:GetTalentValue("modifier_axe_helix_7", "talent_cd", true),
    e7_interval = caster:GetTalentValue("modifier_axe_helix_7", "interval", true),
    e7_max = caster:GetTalentValue("modifier_axe_helix_7", "max", true),
    e7_damage = caster:GetTalentValue("modifier_axe_helix_7", "damage", true),
    e7_duration = caster:GetTalentValue("modifier_axe_helix_7", "duration", true),
    e7_status = caster:GetTalentValue("modifier_axe_helix_7", "status", true),
    
    has_h3 = 0,
    h3_magic = 0,
    h3_armor = 0,
    h3_duration = caster:GetTalentValue("modifier_axe_hero_3", "duration", true),
    h3_max = caster:GetTalentValue("modifier_axe_hero_3", "max", true),
    
    has_h5 = 0,
    h5_talent_cd = caster:GetTalentValue("modifier_axe_hero_5", "talent_cd", true),
    h5_cd_inc = caster:GetTalentValue("modifier_axe_hero_5", "cd_inc", true),
    h5_health = caster:GetTalentValue("modifier_axe_hero_5", "health", true),
    h5_shield = caster:GetTalentValue("modifier_axe_hero_5", "shield", true)/100,
    h5_duration = caster:GetTalentValue("modifier_axe_hero_5", "duration", true),  
  }
end

if caster:HasTalent("modifier_axe_helix_1") then
  self.talents.has_e1 = 1
  self.talents.e1_health = caster:GetTalentValue("modifier_axe_helix_1", "health")/100
  self.talents.e1_base = caster:GetTalentValue("modifier_axe_helix_1", "base")
end

if caster:HasTalent("modifier_axe_helix_2") then
  self.talents.has_e2 = 1
  self.talents.e2_radius = caster:GetTalentValue("modifier_axe_helix_2", "radius")
  self.talents.e2_heal = caster:GetTalentValue("modifier_axe_helix_2", "heal")/100
  self.talents.e2_base = caster:GetTalentValue("modifier_axe_helix_2", "base")
end

if caster:HasTalent("modifier_axe_helix_3") then
  self.talents.has_e3 = 1
  self.talents.e3_health_reduce = caster:GetTalentValue("modifier_axe_helix_3", "health_reduce")
  self.talents.e3_health = caster:GetTalentValue("modifier_axe_helix_3", "health")
end

if caster:HasTalent("modifier_axe_helix_4") then
  self.talents.has_e4 = 1
end

if caster:HasTalent("modifier_axe_helix_7") then
  self.talents.has_e7 = 1
end

if caster:HasTalent("modifier_axe_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_magic = caster:GetTalentValue("modifier_axe_hero_3", "magic")
  self.talents.h3_armor = caster:GetTalentValue("modifier_axe_hero_3", "armor")
end

if caster:HasTalent("modifier_axe_hero_5") then
  self.talents.has_h5 = 1
  caster:AddDamageEvent_inc(self.tracker, true)
end

end

function axe_counter_helix_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "axe_counter_helix", self)
end

function axe_counter_helix_custom:Init()
self.caster = self:GetCaster()
end

function axe_counter_helix_custom:OnInventoryContentsChanged()
if not IsServer() then return end
if not self.tracker then return end
if not self.caster:HasScepter() then return end
if self.scepter_init then return end

self.tracker:ScepterInit()
end

function axe_counter_helix_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_axe_counter_helix_custom"
end

function axe_counter_helix_custom:GetCooldown(level)
if self.talents.has_e7 == 1 then 
	return self.talents.e7_talent_cd
end
return self.BaseClass.GetCooldown( self, level )
end


function axe_counter_helix_custom:GetBehavior()
return self.talents.has_e7 == 1 and (DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE) or DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function axe_counter_helix_custom:GetCastRange(vec, hTarget)
return self:GetSpecialValueFor("radius") + (self.talents.e2_radius and self.talents.e2_radius or 0) - self.caster:GetCastRangeBonus()
end

function axe_counter_helix_custom:OnSpellStart()
self.caster:AddNewModifier(self.caster, self, "modifier_axe_counter_helix_custom_legendary", {duration = self.talents.e7_duration})
end

function axe_counter_helix_custom:Spin(use_cd, ability)
if not IsServer() then return end
local anim_k = ability == "modifier_axe_helix_7" and 1.2 or 1

if ability ~= "modifier_axe_helix_7" then
	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_3)
end

self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, anim_k)

local radius = self:GetSpecialValueFor("radius") + self.talents.e2_radius
local damage = self:GetSpecialValueFor("damage") + self.talents.e1_base + self.talents.e1_health*self.caster:GetMaxHealth()
local shield_cd = self.caster:FindModifierByName("modifier_axe_counter_helix_custom_shield_cd")
if shield_cd then
	shield_cd:ReduceCd()
end

local damage_ability = nil
if ability then 
	damage_ability = ability
end 

local targets = self.caster:FindTargets(radius)

if self.talents.has_e2 == 1 then 
	self.caster:GenericHeal(self.caster:GetMaxHealth()*self.talents.e2_heal + self.talents.e2_base, self, false, nil, "modifier_axe_helix_2")
end

local attack = false
if #targets > 0 and self.caster:HasScepter() and (GameRules:GetDOTATime(false, false) - self.attack_time) >= self.scepter_attack_cd then
	attack = true
	self.attack_time = GameRules:GetDOTATime(false, false)
end

local damageTable = {attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self}

if self.talents.has_h3 == 1 then 
	self.caster:AddNewModifier(self.caster, self, "modifier_axe_counter_helix_custom_armor", {duration = self.talents.h3_duration})
end

if self.talents.has_e4 == 1 then
	self.caster:AddNewModifier(self.caster, self, "modifier_axe_counter_helix_custom_haste", {duration = self.talents.e4_duration})
	self.caster:CdItems(self.talents.e4_cd_items)
end

local hit_type = 0

for _,enemy in pairs(targets) do

	if self.talents.has_e3 == 1 then
		enemy:AddNewModifier(self.caster, self, "modifier_axe_counter_helix_custom_health_change", {duration = self.talents.e3_duration})
	end

	damageTable.victim = enemy
	DoDamage( damageTable, damage_ability )

	if hit_type == 0 then
		hit_type = 1
	end
	if enemy:IsRealHero() then
		hit_type = 2
	end

	if attack then
		local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, enemy)
		ParticleManager:SetParticleControlEnt(hit_effect, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), false) 
		ParticleManager:SetParticleControlEnt(hit_effect, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), false) 
		ParticleManager:Delete(hit_effect, 1)

		self.caster:PerformAttack(enemy, true, true, true, true, false, false, true)
	end
end

if self.talents.has_e3 == 1 and hit_type > 0 then 
	local duration = hit_type == 2 and self.talents.e3_duration or self.talents.e3_duration_creeps
	local mod = self.caster:FindModifierByName("modifier_axe_counter_helix_custom_health_change")
	if mod then
		duration = math.max(mod:GetRemainingTime(), duration)
	end
	self.caster:AddNewModifier(self.caster, self, "modifier_axe_counter_helix_custom_health_change", {duration = duration})
end

local sound = wearables_system:GetSoundReplacement(self.caster, "Hero_Axe.CounterHelix", self)
local particle_name = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_axe/axe_counterhelix.vpcf", self)
if proc_stun then
    sound = "Hero_Axe.CounterHelix_Blood_Chaser"
    particle_name = "particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf"
end
self.caster:GenericParticle(particle_name)
self.caster:EmitSound(sound)

if use_cd == 1 then 
	if self.talents.has_e7 == 1 then 
		self.caster:AddNewModifier(self.caster, self, "modifier_axe_counter_helix_custom_cd", {duration = self:GetSpecialValueFor("cooldown")*self.caster:GetCooldownReduction()})
	else 
		self:UseResources( false, false, false, true )
	end
end

end




modifier_axe_counter_helix_custom = class(mod_visible)
function modifier_axe_counter_helix_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.scepter_radius = self.ability:GetSpecialValueFor("scepter_radius")
self.ability.scepter_interval = self.ability:GetSpecialValueFor("scepter_interval")
self.ability.scepter_interval_inc = self.ability:GetSpecialValueFor("scepter_interval_inc")
self.ability.scepter_max = self.ability:GetSpecialValueFor("scepter_max")
self.ability.scepter_linger = self.ability:GetSpecialValueFor("scepter_linger")
self.ability.scepter_attack_cd = self.ability:GetSpecialValueFor("scepter_attack_cd")

self.scepter_init = false
self.interval = 0.5
if not IsServer() then return end
self.max = self.ability:GetSpecialValueFor("trigger_attacks")
self:ProcStack(true)

self:ScepterInit()
self.parent:AddAttackEvent_inc(self, true)
end 

function modifier_axe_counter_helix_custom:OnRefresh()
if not IsServer() then return end
self.max = self.ability:GetSpecialValueFor("trigger_attacks")
self:ProcStack(true)
end

function modifier_axe_counter_helix_custom:ProcStack(new)
if not IsServer() then return end

if new then
	self:SetStackCount(self.max)
	return
end

self:DecrementStackCount()
if self:GetStackCount() <= 0 then
	self:ProcStack(true)
	self.ability:Spin(1)
end

end

function modifier_axe_counter_helix_custom:ScepterInit()
if not IsServer() then return end
if not self.parent:HasScepter() then return end
if self.scepter_init then return end

self.scepter_init = true
self:StartIntervalThink(self.interval)
end

function modifier_axe_counter_helix_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if not self.parent:HasScepter() then return end

local targets = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.ability.scepter_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
local allow = false
for _,target in pairs(targets) do
	if target:IsUnit() then
		allow = true
		break
	end
end

if allow then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_axe_counter_helix_custom_scepter", {duration = self.ability.scepter_linger})
end

end

function modifier_axe_counter_helix_custom:DamageEvent_inc(params)
if not IsServer() then return end
if self.ability.talents.has_h5 == 0 then return end
if self.parent ~= params.unit then return end
if self.parent:PassivesDisabled() then return end
if self.parent:GetHealthPercent() > self.ability.talents.h5_health then return end
if self.parent:HasModifier("modifier_death") then return end
if self.parent:HasModifier("modifier_axe_counter_helix_custom_shield_cd") then return end

self.parent:Purge(false, true, false, true, true)
self.parent:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")

if IsValid(self.shield_mod) then
	self.shield_mod:Destroy()
end

self.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield", 
{
	duration = self.ability.talents.h5_duration,
	max_shield = self.parent:GetMaxHealth()*self.ability.talents.h5_shield,
	start_full = 1,
	shield_talent = "modifier_axe_hero_5"
})

if self.shield_mod then
	self.parent:EmitSound("Axe.Helix_shield")
	self.parent:GenericParticle("particles/axe/helix_shield.vpcf", self.shield_mod)
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_axe_counter_helix_custom_shield_cd", {})
end

function modifier_axe_counter_helix_custom:AttackEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.target then return end
if params.attacker:GetTeamNumber()==params.target:GetTeamNumber() then return end
self:CheckStack()
end

function modifier_axe_counter_helix_custom:CheckStack()
if not IsServer() then return end
if self.parent:PassivesDisabled() then return end
if self.parent:HasModifier("modifier_axe_counter_helix_custom_legendary_active") then return end

if self.ability.talents.has_e7 == 1 then
	if self.parent:HasModifier("modifier_axe_counter_helix_custom_cd") then return end
else
	if not self.ability:IsFullyCastable() then return end
end

self:ProcStack()
end



modifier_axe_counter_helix_custom_legendary = class(mod_hidden)
function modifier_axe_counter_helix_custom_legendary:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max_time = self.ability.talents.e7_duration

if not IsServer() then return end
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_1, 1.3)
self.parent:GenericParticle("particles/axe/helix_legendary_effect.vpcf", self, true)
self.parent:GenericParticle("particles/axe/calling_legendary_cast.vpcf")
self.parent:EmitSound("Axe.Helix_legendary1")
self.parent:EmitSound("Axe.Helix_legendary2")

self.count = 0
self.parent:AddDamageEvent_inc(self)
self.ability:EndCd()

self.RemoveForDuel = true
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_axe_counter_helix_custom_legendary:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
self.count = self.count + params.original_damage
end

function modifier_axe_counter_helix_custom_legendary:OnIntervalThink()
if not IsServer() then return end
local stack = math.min(self.ability.talents.e7_max, math.floor(self.count/self.ability.talents.e7_damage))
self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetElapsedTime(), stack = stack, style = "AxeHelix"})
end

function modifier_axe_counter_helix_custom_legendary:GetStatusEffectName()
return "particles/status_fx/status_effect_beserkers_call.vpcf"
end

function modifier_axe_counter_helix_custom_legendary:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end

function modifier_axe_counter_helix_custom_legendary:OnDestroy()
if not IsServer() then return end

self.ability:StartCd()
local stack = math.min(self.ability.talents.e7_max, math.floor(self.count/self.ability.talents.e7_damage))

if not self.parent:IsAlive() or stack <= 0 then
	self.parent:UpdateUIshort({hide = 1, style = "AxeHelix"})
	return 
end

self.parent:Purge(false, true, false, true, true)
self.parent:AddNewModifier(self.parent, self.ability, "modifier_axe_counter_helix_custom_legendary_active", {stack = stack})
end

function modifier_axe_counter_helix_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE,
}
end

function modifier_axe_counter_helix_custom_legendary:GetModifierModelScale()
return 20
end

modifier_axe_counter_helix_custom_legendary_active = class(mod_hidden)
function modifier_axe_counter_helix_custom_legendary_active:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self:SetStackCount(table.stack)

self.interval = self.ability.talents.e7_interval
self.max_stack = table.stack

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_axe_counter_helix_custom_legendary_active:OnIntervalThink()
if not IsServer() then return end
self.parent:GenericParticle("particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf")
self.ability:Spin(0, "modifier_axe_helix_7")

self:DecrementStackCount()
self.parent:UpdateUIshort({max_time = self.max_stack, time = self:GetStackCount(), stack = self:GetStackCount(), priority = 1, style = "AxeHelix"})

if self:GetStackCount() <= 0 then
	self:Destroy()
end

end

function modifier_axe_counter_helix_custom_legendary_active:OnDestroy()
if not IsServer() then return end
self.parent:UpdateUIshort({hide = 1, priority = 1, style = "AxeHelix"})

end

function modifier_axe_counter_helix_custom_legendary_active:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true,
}
end

function modifier_axe_counter_helix_custom_legendary_active:GetStatusEffectName()
return "particles/status_fx/status_effect_beserkers_call.vpcf"
end

function modifier_axe_counter_helix_custom_legendary_active:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end

function modifier_axe_counter_helix_custom_legendary_active:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end

function modifier_axe_counter_helix_custom_legendary_active:GetModifierStatusResistanceStacking()
return self.ability.talents.e7_status
end

function modifier_axe_counter_helix_custom_legendary_active:GetModifierModelScale()
return 20
end



modifier_axe_counter_helix_custom_armor = class(mod_visible)
function modifier_axe_counter_helix_custom_armor:GetTexture() return "buffs/axe/helix_1" end
function modifier_axe_counter_helix_custom_armor:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.h3_max
self.armor = self.ability.talents.h3_armor/self.max
self.magic = self.ability.talents.h3_magic/self.max

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_axe_counter_helix_custom_armor:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_axe_counter_helix_custom_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_axe_counter_helix_custom_armor:GetModifierPhysicalArmorBonus()
return self:GetStackCount()*self.armor
end

function modifier_axe_counter_helix_custom_armor:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.magic
end



modifier_axe_counter_helix_custom_shield_cd = class(mod_cd)
function modifier_axe_counter_helix_custom_shield_cd:GetTexture() return "buffs/axe/hero_7" end
function modifier_axe_counter_helix_custom_shield_cd:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.RemoveForDuel = true

if not IsServer() then return end
self:SetStackCount(self.ability.talents.h5_talent_cd)
self:StartIntervalThink(1)
end

function modifier_axe_counter_helix_custom_shield_cd:OnIntervalThink()
if not IsServer() then return end
self:ReduceCd()
end

function modifier_axe_counter_helix_custom_shield_cd:ReduceCd() 
if not IsServer() then return end

self:DecrementStackCount()
if self:GetStackCount() <= 0 then
	self:Destroy()
end

end


modifier_axe_counter_helix_custom_cd = class(mod_hidden)
function modifier_axe_counter_helix_custom_cd:IsDebuff() return true end


modifier_axe_counter_helix_custom_health_change = class(mod_visible)
function modifier_axe_counter_helix_custom_health_change:GetTexture() return "buffs/axe/helix_3" end
function modifier_axe_counter_helix_custom_health_change:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.is_enemy = self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber()
self.max = self.ability.talents.e3_max
self.health_change = self.is_enemy and self.ability.talents.e3_health_reduce or self.ability.talents.e3_health

if not IsServer() then return end
self:OnRefresh()
end

function modifier_axe_counter_helix_custom_health_change:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self.parent:IsHero() then
	self.parent:CalculateStatBonus(true)
end

if self.is_enemy and self:GetStackCount() >= self.max then
	self.parent:GenericParticle("particles/items4_fx/spirit_vessel_damage.vpcf", self)
end

end

function modifier_axe_counter_helix_custom_health_change:OnDestroy()
if not IsServer() then return end

if self.parent:IsHero() then
	self.parent:CalculateStatBonus(true)
end

end

function modifier_axe_counter_helix_custom_health_change:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
}
end

function modifier_axe_counter_helix_custom_health_change:GetModifierExtraHealthPercentage()
return self.health_change*self:GetStackCount()
end

modifier_axe_counter_helix_custom_haste = class(mod_hidden)
function modifier_axe_counter_helix_custom_haste:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.talents.e4_move
if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_thirst_owner.vpcf", self)
end

function modifier_axe_counter_helix_custom_haste:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_axe_counter_helix_custom_haste:GetModifierMoveSpeedBonus_Percentage()
return self.move
end


modifier_axe_counter_helix_custom_scepter = class(mod_visible)
function modifier_axe_counter_helix_custom_scepter:IsDebuff() return true end
function modifier_axe_counter_helix_custom_scepter:GetTexture() return "item_ultimate_scepter" end
function modifier_axe_counter_helix_custom_scepter:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.interval = self.ability.scepter_interval
self:StartIntervalThink(self.interval)
end

function modifier_axe_counter_helix_custom_scepter:OnIntervalThink()
if not IsServer() then return end

if not self.parent:HasModifier("modifier_axe_counter_helix_custom_legendary_active") then
	self.ability:Spin(0, "scepter")
end

if self:GetStackCount() < self.ability.scepter_max then
	self:IncrementStackCount()
end

self:StartIntervalThink(self.interval + self:GetStackCount()*self.ability.scepter_interval_inc)
end