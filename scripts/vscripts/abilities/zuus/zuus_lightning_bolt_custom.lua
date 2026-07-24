--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_lightning_bolt_custom_tracker", "abilities/zuus/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_lightning_bolt_custom_item_stack", "abilities/zuus/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_lightning_bolt_custom_legendary", "abilities/zuus/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_lightning_bolt_custom_legendary_stack_count", "abilities/zuus/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_lightning_bolt_custom_root", "abilities/zuus/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_lightning_bolt_custom_root_cd", "abilities/zuus/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_lightning_bolt_custom_root_heal_reduce", "abilities/zuus/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)

zuus_lightning_bolt_custom = class({})
zuus_lightning_bolt_custom.talents = {}

function zuus_lightning_bolt_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "zuus_lightning_bolt", self)
end

function zuus_lightning_bolt_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_arc_lightning_impact.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zeus/zeus_cloud.vpcf", context )
PrecacheResource( "particle","particles/zuus_attack_stack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf", context )
PrecacheResource( "particle","particles/zeus/bolt_disarm.vpcf", context )
PrecacheResource( "particle","particles/zeus/bolt_legendary_stack2.vpcf", context )
end

function zuus_lightning_bolt_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_w1 = 0,
    w1_cd = 0,
    
    has_w2 = 0,
    w2_damage = 0,
    w2_heal_reduce = 0,
    w2_duration = caster:GetTalentValue("modifier_zuus_bolt_2", "duration", true),
    
    has_w3 = 0,
    w3_damage = 0,
    w3_heal = 0,
    w3_delay = caster:GetTalentValue("modifier_zuus_bolt_3", "delay", true),
    w3_duration = caster:GetTalentValue("modifier_zuus_bolt_3", "duration", true),
    w3_radius = caster:GetTalentValue("modifier_zuus_bolt_3", "radius", true),
    w3_count = caster:GetTalentValue("modifier_zuus_bolt_3", "count", true),
    w3_stun = caster:GetTalentValue("modifier_zuus_bolt_3", "stun", true),
    
    has_w4 = 0,
    w4_talent_cd = caster:GetTalentValue("modifier_zuus_bolt_4", "talent_cd", true),
    w4_root = caster:GetTalentValue("modifier_zuus_bolt_4", "root", true),
    w4_cast = caster:GetTalentValue("modifier_zuus_bolt_4", "cast", true)/100,
    
    has_w7 = 0,
    w7_damage_inc = caster:GetTalentValue("modifier_zuus_bolt_7", "damage_inc", true)/100,
    w7_damage_k = caster:GetTalentValue("modifier_zuus_bolt_7", "damage_k", true),
    w7_max_stack = caster:GetTalentValue("modifier_zuus_bolt_7", "max_stack", true),
    
    has_h1 = 0,
    h1_slow = 0,
    h1_stun = 0,
  }
end

if caster:HasTalent("modifier_zuus_bolt_1") then
  self.talents.has_w1 = 1
  self.talents.w1_cd = caster:GetTalentValue("modifier_zuus_bolt_1", "cd")
end

if caster:HasTalent("modifier_zuus_bolt_2") then
  self.talents.has_w2 = 1
  self.talents.w2_damage = caster:GetTalentValue("modifier_zuus_bolt_2", "damage")/100
  self.talents.w2_heal_reduce = caster:GetTalentValue("modifier_zuus_bolt_2", "heal_reduce")
end

if caster:HasTalent("modifier_zuus_bolt_3") then
  self.talents.has_w3 = 1
  self.talents.w3_damage = caster:GetTalentValue("modifier_zuus_bolt_3", "damage")/100
  self.talents.w3_heal = caster:GetTalentValue("modifier_zuus_bolt_3", "heal")/100
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_zuus_bolt_4") then
  self.talents.has_w4 = 1
end

if caster:HasTalent("modifier_zuus_bolt_7") then
  self.talents.has_w7 = 1
end

if caster:HasTalent("modifier_zuus_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_slow = caster:GetTalentValue("modifier_zuus_hero_1", "slow")
  self.talents.h1_stun = caster:GetTalentValue("modifier_zuus_hero_1", "stun")
end

end

function zuus_lightning_bolt_custom:Init()
self.caster = self:GetCaster()
end

function zuus_lightning_bolt_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_zuus_lightning_bolt_custom_tracker"
end

function zuus_lightning_bolt_custom:OnAbilityPhaseStart()
local sound = wearables_system:GetSoundReplacement(self.caster, "Hero_Zuus.LightningBolt.Cast", self)
self.caster:EmitSound(sound)
return true
end

function zuus_lightning_bolt_custom:GetAOERadius()
return self.radius and self.radius or 0
end

function zuus_lightning_bolt_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.w1_cd and self.talents.w1_cd or 0)
end

function zuus_lightning_bolt_custom:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self)*(1 + (self.talents.has_w4 == 1 and self.talents.w4_cast or 0))
end

function zuus_lightning_bolt_custom:OnSpellStart()
local target = self:GetCursorTarget()
local point = target and target:GetAbsOrigin() or self:GetCursorPosition()

if target and target:TriggerSpellAbsorb(self) then
	return
end

if self.caster.wrath_ability then
	self.caster.wrath_ability:CreateCloud(point)
end

self:CastLightningBolt(point)
end

function zuus_lightning_bolt_custom:CastLightningBolt(point, damage_ability)
if not IsServer() then return end
local stun_duration = self.stun_duration + self.talents.h1_stun
local base_damage = self.damage + self.talents.w2_damage*self.caster:GetIntellect(false)

if damage_ability and damage_ability == "modifier_zuus_bolt_3" then
	base_damage = base_damage * self.talents.w3_damage
  stun_duration = self.talents.w3_stun
end
local legendary_damage = self.talents.w7_damage_inc

local z_pos = 3000
local targets = self.caster:FindTargets(self.radius, point)

AddFOWViewer(self.caster:GetTeamNumber(), point, self.true_sight_radius, self.sight_duration, false)

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, point)
ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)

local bolt_pfx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", self)
if bolt_pfx ~= "particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf" then
  local particle = ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_immortal_lightning.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(particle, 0, Vector(point.x, point.y, z_pos))
  ParticleManager:SetParticleControl(particle, 1, Vector(point.x, point.y, point.z))
  ParticleManager:SetParticleControl(particle, 3, Vector(point.x, point.y, point.z))
  ParticleManager:ReleaseParticleIndex(particle)

  local particle3 = ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lb_cfx_il.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(particle3, 0, Vector(point.x, point.y, point.z))
  ParticleManager:ReleaseParticleIndex(particle3)
else
  local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(particle, 0, Vector(point.x, point.y, z_pos))
  ParticleManager:SetParticleControl(particle, 1, Vector(point.x, point.y, point.z))
  ParticleManager:ReleaseParticleIndex(particle)
end

local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle2, 0, Vector(point.x, point.y, z_pos))
ParticleManager:SetParticleControl(particle2, 1, Vector(point.x, point.y, point.z))
ParticleManager:ReleaseParticleIndex(particle2)

local sound = wearables_system:GetSoundReplacement(self.caster, "Hero_Zuus.LightningBolt", self)
EmitSoundOnLocationWithCaster(point, sound, self.caster)

local hit_type = 0
local sum = 0

for _,unit in pairs(targets) do
	if hit_type < 2 then
		hit_type = unit:IsRealHero() and 2 or 1
	end

	unit:GenericParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_impact.vpcf")
	unit:AddNewModifier(self.caster, self, "modifier_generic_vision", {duration = self.sight_duration})
	unit:AddNewModifier(self.caster, self, "modifier_truesight", {duration = self.sight_duration})

	local legendary_mod = unit:FindModifierByName("modifier_zuus_lightning_bolt_custom_legendary_stack_count")
	local legendary_stack = legendary_mod and legendary_mod:GetStackCount() or 0

	if self.caster.static_ability then 
		self.caster.static_ability:DealDamage(unit)
	end

	local damage = base_damage*(1 + legendary_damage*math.pow(legendary_stack/self.talents.w7_max_stack, self.talents.w7_damage_k))
	local stun = (1 - unit:GetStatusResistance())*stun_duration
	unit:AddNewModifier(self.caster, self, "modifier_stunned", {duration = stun})

	if self.talents.has_w2 == 1 then
		unit:AddNewModifier(self.caster, self, "modifier_zuus_lightning_bolt_custom_root_heal_reduce", {duration = self.talents.w2_duration})
	end

	if self.talents.has_w4 == 1 and not unit:HasModifier("modifier_zuus_lightning_bolt_custom_root_cd") and not unit:IsDebuffImmune() then
		unit:AddNewModifier(self.caster, self, "modifier_zuus_lightning_bolt_custom_root", {duration = stun + (1 - unit:GetStatusResistance())*self.talents.w4_root})
		unit:AddNewModifier(self.caster, self, "modifier_zuus_lightning_bolt_custom_root_cd", {duration = self.talents.w4_talent_cd})
	end

  if unit:IsCreep() then
    damage = damage*(1 + self.creeps)
  end

	local real_damage = DoDamage({attacker = self.caster, ability = self, damage_type = DAMAGE_TYPE_MAGICAL, damage = damage, victim = unit}, damage_ability)
	if legendary_stack >= 6 then
		unit:SendNumber(6, real_damage)
	end

	local result = self.caster:CanLifesteal(unit)
	if result and self.talents.has_w3 == 1 then
		sum = sum + result*real_damage
	end
end

if self.talents.has_w3 == 1 and sum > 0 then
	self.caster:GenericHeal(sum*self.talents.w3_heal, self, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_zuus_bolt_3")
end

if hit_type ~= 0 and self.caster.jump_ability then
	self.caster.jump_ability:LegendaryStack(hit_type == 2)
end

end



modifier_zuus_lightning_bolt_custom_tracker = class(mod_hidden)
function modifier_zuus_lightning_bolt_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.legendary_ability = self.parent:FindAbilityByName("zuus_stormkeeper_custom")
if self.legendary_ability then
	self.legendary_ability:UpdateTalents()
end

self.parent.bolt_ability = self.ability

self.ability.damage  = self.ability:GetSpecialValueFor("damage")
self.ability.true_sight_radius = self.ability:GetSpecialValueFor("true_sight_radius")
self.ability.sight_duration = self.ability:GetSpecialValueFor("sight_duration")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
self.ability.creeps = self.ability:GetSpecialValueFor("creeps")/100
end 

function modifier_zuus_lightning_bolt_custom_tracker:OnRefresh()
self.ability.damage  = self.ability:GetSpecialValueFor("damage")
end

function modifier_zuus_lightning_bolt_custom_tracker:SpellEvent( params )
if not IsServer() then return end
if self.ability.talents.has_w3 == 0 then return end
if params.unit ~= self.parent then return end
if params.ability:IsItem() then return end

local index = nil
local delay = nil
if params.target then
	index = params.target:entindex()
end
if params.ability == self.ability then
	delay = self.ability.talents.w3_delay
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_zuus_lightning_bolt_custom_item_stack", {target = index, delay = delay, duration = self.ability.talents.w3_duration})
end


modifier_zuus_lightning_bolt_custom_item_stack = class(mod_visible)
function modifier_zuus_lightning_bolt_custom_item_stack:GetTexture() return "buffs/zeus/bolt_3" end
function modifier_zuus_lightning_bolt_custom_item_stack:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.w3_count 
self.radius = self.ability.talents.w3_radius
self.RemoveForDuel = true

self:SetStackCount(1)
end

function modifier_zuus_lightning_bolt_custom_item_stack:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() < self.max then return end

self.target = table.target and EntIndexToHScript(table.target) or nil
local delay = table.delay and table.delay or 0

self:StartIntervalThink(delay)
end

function modifier_zuus_lightning_bolt_custom_item_stack:OnIntervalThink()
if not IsServer() then return end

local point = nil
if not IsValid(self.target) then
	self.target = self.parent:RandomTarget(self.radius)
end
if self.target then
	point = self.target:GetAbsOrigin()
else
	point = self.parent:GetAbsOrigin() + RandomVector(350)
end

self.ability:CastLightningBolt(point, "modifier_zuus_bolt_3")
self:Destroy()
end



zuus_stormkeeper_custom = class({})
zuus_stormkeeper_custom.talents = {}

function zuus_stormkeeper_custom:CreateTalent()
self:SetHidden(false)
end

function zuus_stormkeeper_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    w7_stun = caster:GetTalentValue("modifier_zuus_bolt_7", "stun", true),
    w7_damage = caster:GetTalentValue("modifier_zuus_bolt_7", "damage", true),
    w7_max_stack = caster:GetTalentValue("modifier_zuus_bolt_7", "max_stack", true),
    w7_talent_cd = caster:GetTalentValue("modifier_zuus_bolt_7", "talent_cd", true),
    w7_radius = caster:GetTalentValue("modifier_zuus_bolt_7", "radius", true),
    w7_damage_inc = caster:GetTalentValue("modifier_zuus_bolt_7", "damage_inc", true)/100,
    w7_max = caster:GetTalentValue("modifier_zuus_bolt_7", "max", true),
    w7_interval = caster:GetTalentValue("modifier_zuus_bolt_7", "interval", true),
    w7_duration = caster:GetTalentValue("modifier_zuus_bolt_7", "duration", true),
  }
end

end

function zuus_stormkeeper_custom:Init()
self.caster = self:GetCaster()
end

function zuus_stormkeeper_custom:GetAOERadius()
return self.talents.w7_radius and self.talents.w7_radius or 0
end

function zuus_stormkeeper_custom:GetChannelTime()
return self.talents.w7_interval*(self.talents.w7_max - 1) + 0.1
end

function zuus_stormkeeper_custom:GetCooldown()
return self.talents.w7_talent_cd and self.talents.w7_talent_cd or 0
end

function zuus_stormkeeper_custom:OnSpellStart()
local point = self:GetCursorPosition()

if self.caster.wrath_ability then
	self.caster.wrath_ability:CreateCloud(point)
end

self.caster:AddNewModifier(self.caster, self, "modifier_zuus_lightning_bolt_custom_legendary", {x = point.x, y = point.y})
end

function zuus_stormkeeper_custom:OnChannelFinish( bInterrupted )
if not IsServer() then return end
self.caster:RemoveModifierByName("modifier_zuus_lightning_bolt_custom_legendary")
end


modifier_zuus_lightning_bolt_custom_legendary = class(mod_hidden)
function modifier_zuus_lightning_bolt_custom_legendary:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability:EndCd()

self.parent:StartGesture(ACT_DOTA_GENERIC_CHANNEL_1)

self.radius = self.ability.talents.w7_radius
self.max = self.ability.talents.w7_max
self.damage = self.ability.talents.w7_damage
self.stun = self.ability.talents.w7_stun
self.duration = self.ability.talents.w7_duration

self.channel = self.ability.talents.w7_interval*self.ability.talents.w7_max

self:SetStackCount(self.max)
self.target_point = GetGroundPosition(Vector(table.x, table.y, 0), nil)

self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = self.damage}

AddFOWViewer(self.parent:GetTeamNumber(), self.target_point, self.radius, self.channel, false)
self.zuus_nimbus_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 0, self.target_point)
ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 1, Vector(self.radius, 0, 0))
self:AddParticle(self.zuus_nimbus_particle, false, false, -1, false, false)

self:OnIntervalThink()
self:StartIntervalThink(self.ability.talents.w7_interval)
end
function modifier_zuus_lightning_bolt_custom_legendary:OnIntervalThink()
if not IsServer() then return end

local units = self.parent:FindTargets(self.radius, self.target_point)

if #units == 0 then 
	local target_point = self.target_point + RandomVector(RandomInt(1, self.radius))

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack"..RandomInt(1, 2), self.parent:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle, 1, target_point)
	ParticleManager:ReleaseParticleIndex(particle)
else 
	for _,unit in pairs(units) do 
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
		ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack"..RandomInt(1, 2), self.parent:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(particle)
		
		unit:AddNewModifier(self.parent, self.ability, "modifier_zuus_lightning_bolt_custom_legendary_stack_count", {duration = self.duration})
		unit:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = self.stun})

		self.damageTable.victim = unit
		DoDamage(self.damageTable)
	end
end

EmitSoundOnLocationWithCaster(self.target_point, "Hero_Zuus.LightningBolt", self.parent)

self:DecrementStackCount()
if self:GetStackCount() == 0 then 
	self:Destroy()
end

end

function modifier_zuus_lightning_bolt_custom_legendary:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
self.parent:FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
end



modifier_zuus_lightning_bolt_custom_legendary_stack_count = class(mod_visible)
function modifier_zuus_lightning_bolt_custom_legendary_stack_count:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage = self.ability.talents.w7_damage_inc
self.max = self.ability.talents.w7_max_stack

if not IsServer() then return end
self.duration = self:GetRemainingTime()
self.RemoveForDuel = true
self.particle = self.parent:GenericParticle("particles/zuus_attack_stack.vpcf", self, true)
self:SetStackCount(1)
end

function modifier_zuus_lightning_bolt_custom_legendary_stack_count:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_zuus_lightning_bolt_custom_legendary_stack_count:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if self:GetStackCount() >= 10 then
	if self.particle then
		ParticleManager:Delete(self.particle, 2)
		self.particle = nil
		self.particle_2 = self.parent:GenericParticle("particles/zeus/bolt_legendary_stack2.vpcf", self, true)
	end
	local k1 = math.floor(self:GetStackCount() / 10)
	ParticleManager:SetParticleControl( self.particle_2, 1, Vector(k1, self:GetStackCount() - k1*10, 0))
else
	ParticleManager:SetParticleControl( self.particle, 1, Vector( 0, self:GetStackCount(), 0 ) )
end

end

function modifier_zuus_lightning_bolt_custom_legendary_stack_count:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_zuus_lightning_bolt_custom_legendary_stack_count:OnTooltip()
return self.damage*self:GetStackCount()
end



modifier_zuus_lightning_bolt_custom_root_cd = class(mod_hidden)
function modifier_zuus_lightning_bolt_custom_root_cd:RemoveOnDeath() return false end
function modifier_zuus_lightning_bolt_custom_root_cd:OnCreated()
self.RemoveForDuel = true
end


modifier_zuus_lightning_bolt_custom_root = class({})
function modifier_zuus_lightning_bolt_custom_root:IsHidden() return true end
function modifier_zuus_lightning_bolt_custom_root:IsPurgable() return true end
function modifier_zuus_lightning_bolt_custom_root:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true,
	[MODIFIER_STATE_DISARMED] = true
}
end

function modifier_zuus_lightning_bolt_custom_root:GetEffectName() return "particles/items3_fx/gleipnir_root.vpcf" end
function modifier_zuus_lightning_bolt_custom_root:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:GenericParticle("particles/zeus/bolt_disarm.vpcf", self, true)
end


modifier_zuus_lightning_bolt_custom_root_heal_reduce = class(mod_hidden)
function modifier_zuus_lightning_bolt_custom_root_heal_reduce:OnCreated()
self.ability = self:GetAbility()
self.heal_reduce = self.ability.talents.w2_heal_reduce
end

function modifier_zuus_lightning_bolt_custom_root_heal_reduce:DeclareFunctions()
return
{
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_zuus_lightning_bolt_custom_root_heal_reduce:GetModifierLifestealRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_zuus_lightning_bolt_custom_root_heal_reduce:GetModifierHealChange()
return self.heal_reduce
end

function modifier_zuus_lightning_bolt_custom_root_heal_reduce:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end