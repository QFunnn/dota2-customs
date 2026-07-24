--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_morphling_morph_agi_custom_tracker", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_toggle", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_legendary_stack", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_legendary", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_legendary_attack", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_stun_cd", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_stats_inc", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_burn", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_double", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_morph_custom_double_damage", "abilities/morphling/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE )

morphling_morph_agi_custom = class({})
morphling_morph_agi_custom.talents = {}

function morphling_morph_agi_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_morph_str.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_morph_agi.vpcf", context )
PrecacheResource( "particle", "particles/morphling/attribute_legendary_stack.vpcf", context )
PrecacheResource( "particle", "particles/morphling/attribute_legendary_effect.vpcf", context )
PrecacheResource( "particle", "particles/morphling/attribute_legendary_active.vpcf", context )
PrecacheResource( "particle", "particles/morphling/attribute_double.vpcf", context )
PrecacheResource( "particle", "particles/morphling/double_attack.vpcf", context )
PrecacheResource( "particle", "particles/morphling/attack_cleave.vpcf", context )
PrecacheResource( "particle", "particles/morphling/adaptive_str_stun.vpcf", context )
PrecacheResource( "particle", "particles/morphling/attribute_burn.vpcf", context )
end

function morphling_morph_agi_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e1 = 0,
    e1_speed = 0,
    e1_damage = 0,
    e1_duration = caster:GetTalentValue("modifier_morphling_attribute_1", "duration", true),
    e1_damage_type = caster:GetTalentValue("modifier_morphling_attribute_1", "damage_type", true),

    has_e2 = 0,
    e2_range = 0,
    e2_damage = 0,
    e2_radius = caster:GetTalentValue("modifier_morphling_attribute_2", "radius", true),
    
    has_e3 = 0,
    e3_stats = 0,
    e3_damage = 0,
    e3_max_legendary = caster:GetTalentValue("modifier_morphling_attribute_3", "max_legendary", true),
    e3_max = caster:GetTalentValue("modifier_morphling_attribute_3", "max", true),
    e3_duration = caster:GetTalentValue("modifier_morphling_attribute_3", "duration", true),
    e3_stats_max = caster:GetTalentValue("modifier_morphling_attribute_3", "stats_max", true),
    e3_duration_creeps = caster:GetTalentValue("modifier_morphling_attribute_3", "duration_creeps", true),

    has_e4 = 0,
    e4_talent_cd = caster:GetTalentValue("modifier_morphling_attribute_4", "talent_cd", true),
    e4_chance = caster:GetTalentValue("modifier_morphling_attribute_4", "chance", true),
    e4_str = caster:GetTalentValue("modifier_morphling_attribute_4", "str", true),
    e4_max_stun = caster:GetTalentValue("modifier_morphling_attribute_4", "max_stun", true),
    e4_stun = caster:GetTalentValue("modifier_morphling_attribute_4", "stun", true),
    
    has_e7 = 0,
    e7_linger = caster:GetTalentValue("modifier_morphling_attribute_7", "linger", true),
    e7_talent_cd = caster:GetTalentValue("modifier_morphling_attribute_7", "talent_cd", true),
    e7_wave_cd = caster:GetTalentValue("modifier_morphling_attribute_7", "wave_cd", true)/100,
    e7_radius = caster:GetTalentValue("modifier_morphling_attribute_7", "radius", true),
    e7_max = caster:GetTalentValue("modifier_morphling_attribute_7", "max", true),
    e7_duration = caster:GetTalentValue("modifier_morphling_attribute_7", "duration", true),
    e7_duration_k = caster:GetTalentValue("modifier_morphling_attribute_7", "duration_k", true),
    e7_strike_duration = caster:GetTalentValue("modifier_morphling_attribute_7", "strike_duration", true),

    has_r7 = 0,
  }
end

if caster:HasTalent("modifier_morphling_attribute_1") then
  self.talents.has_e1 = 1
  self.talents.e1_speed = caster:GetTalentValue("modifier_morphling_attribute_1", "speed")
  self.talents.e1_damage = caster:GetTalentValue("modifier_morphling_attribute_1", "damage")/100
  caster:AddAttackEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_morphling_attribute_2") then
  self.talents.has_e2 = 1
  self.talents.e2_range = caster:GetTalentValue("modifier_morphling_attribute_2", "range")
  self.talents.e2_damage = caster:GetTalentValue("modifier_morphling_attribute_2", "damage")/100
  caster:AddAttackEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_morphling_attribute_3") then
  self.talents.has_e3 = 1
  self.talents.e3_stats = caster:GetTalentValue("modifier_morphling_attribute_3", "stats")
  self.talents.e3_damage = caster:GetTalentValue("modifier_morphling_attribute_3", "damage")
  caster:AddAttackStartEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_morphling_attribute_4") then
  self.talents.has_e4 = 1
  if IsServer() then
  	self.tracker:OnIntervalThink()
  	caster:AddAttackEvent_out(self.tracker, true)
  end
end

if caster:HasTalent("modifier_morphling_attribute_7") then
  self.talents.has_e7 = 1
  caster:AddAttackEvent_out(self.tracker, true)
  if IsServer() then
  	self:SendJs()
  	self.tracker:UpdateUI()
  end
end

if caster:HasTalent("modifier_morphling_morph_7") then
  self.talents.has_r7 = 1
end

end

function morphling_morph_agi_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "morphling_morph_agi", self)
end

function morphling_morph_agi_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_morphling_morph_agi_custom_tracker"
end


function morphling_morph_agi_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasShard() then
	bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE  
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + bonus
end

function morphling_morph_agi_custom:SendJs()
if not IsServer() then return end
local caster = self:GetCaster()
CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(caster:GetId()), 'morph_stats_refresh', {has_legendary = self.talents.has_e7 == 1, agi = caster:GetBaseAgility(), str = caster:GetBaseStrength()}) 
end

function morphling_morph_agi_custom:OnToggle()
local caster = self:GetCaster()
local state = self:GetToggleState()
local str_ability = caster:FindAbilityByName("morphling_morph_str_custom")

caster:RemoveModifierByName("modifier_morphling_morph_custom_toggle")
if state then
	if str_ability and str_ability:GetToggleState() then
		str_ability:ToggleAbility()
	end
	caster:AddNewModifier(caster, self, "modifier_morphling_morph_custom_toggle", {mode = 0})
end

end

function morphling_morph_agi_custom:OnProjectileHit(target, location)
if not target then return end
local caster = self:GetCaster()

target:EmitSound("Morph.Attribute_double")

local hit_effect = ParticleManager:CreateParticle("particles/morphling/attribute_double.vpcf", PATTACH_CUSTOMORIGIN, target)
ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)

caster:AddNewModifier(target, self, "modifier_morphling_morph_custom_double_damage", {duration = FrameTime()})
caster:PerformAttack(target, true, true, true, true, false, false, false)
caster:RemoveModifierByName("modifier_morphling_morph_custom_double_damage")
end



morphling_morph_str_custom = class({})
morphling_morph_str_custom.talents = {}

function morphling_morph_str_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
  }
end

end

function morphling_morph_str_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "morphling_morph_str", self)
end

function morphling_morph_str_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasShard() then
	bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + bonus
end


function morphling_morph_str_custom:OnToggle()
local caster = self:GetCaster()
local state = self:GetToggleState()
local agi_ability = caster:FindAbilityByName("morphling_morph_agi_custom")

caster:RemoveModifierByName("modifier_morphling_morph_custom_toggle")
if state then
	if agi_ability and agi_ability:GetToggleState() then
		agi_ability:ToggleAbility()
	end
	caster:AddNewModifier(caster, self, "modifier_morphling_morph_custom_toggle", {mode = 1})
end

end


modifier_morphling_morph_custom_toggle = class(mod_visible)
function modifier_morphling_morph_custom_toggle:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()

if not IsServer() then return end

self.agi_ability = self.parent:FindAbilityByName("morphling_morph_agi_custom")
if self.agi_ability.tracker then
	self.agi_ability.tracker:OnIntervalThink()
end

self.mode = table.mode
self.sound = self.mode == 1 and "Hero_Morphling.MorphStrengh" or "Hero_Morphling.MorphAgility"
local effect = self.mode == 1 and "particles/units/heroes/hero_morphling/morphling_morph_str.vpcf" or "particles/units/heroes/hero_morphling/morphling_morph_agi.vpcf"

self.parent:GenericParticle(effect, self)
self.str_health = GameRules:GetGameModeEntity():GetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_HP)

self.init = false
local rate = self.ability.morph_rate_tooltip
self.stat = 1
if self.parent:HasShard() then
	self.stat = self.stat + self.ability.shard_speed
end

self.interval = 1/rate
self.mana = self.ability.mana_cost*self.interval

self:StartIntervalThink(self.interval)
end

function modifier_morphling_morph_custom_toggle:OnIntervalThink()
if not IsServer() then return end

if not self.init then
	self.init = true
	self.parent:EmitSound(self.sound)
end

if self.parent:GetMana() <= self.mana and not self.parent:HasShard() then return end

local agi = self.parent:GetBaseAgility()
local str = self.parent:GetBaseStrength()

if self.mode == 0 then
	local delta = math.min(self.stat, str)
	if delta <= 0 then return end
	self.parent:SetBaseStrength(math.max(0, str - delta))
	self.parent:SetBaseAgility(agi + delta)

	self.parent:SetHealth(math.max(1, self.parent:GetHealth() - delta*self.str_health*(1 - self.parent:GetHealthPercent()/100)))
else
	local delta = math.min(self.stat, agi)
	if delta <= 0 then return end
	self.parent:SetBaseAgility(math.max(0, agi - delta))
	self.parent:SetBaseStrength(str + delta)

	self.parent:GenericHeal(delta*self.str_health*(1 - self.parent:GetHealthPercent()/100), self.ability, true, "")
end

if not self.parent:HasShard() then
	self.parent:Script_ReduceMana(self.mana, self.ability)
end

if self.agi_ability then
	self.agi_ability:SendJs()
end

self.parent:CalculateStatBonus(true)
end


function modifier_morphling_morph_custom_toggle:OnDestroy()
if not IsServer() then return end
self.parent:StopSound(self.sound)
end





modifier_morphling_morph_agi_custom_tracker = class(mod_hidden)
function modifier_morphling_morph_agi_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.str_ability = self.parent:FindAbilityByName("morphling_morph_str_custom")
if self.str_ability then
	self.str_ability:UpdateTalents()
	self.str_ability.morph_rate_tooltip = self.ability:GetSpecialValueFor("morph_rate_tooltip")
	self.str_ability.mana_cost = self.ability:GetSpecialValueFor("mana_cost")   
	self.str_ability.shard_speed = self.ability:GetSpecialValueFor("shard_speed")/100    
end

self.legendary_ability = self.parent:FindAbilityByName("morphling_attribute_legendary_custom")
if self.legendary_ability then
	self.legendary_ability.strike_duration = self.legendary_ability:GetSpecialValueFor("strike_duration")
	self.legendary_ability.strike_bva = self.legendary_ability:GetSpecialValueFor("strike_bva")
	self.legendary_ability.strike_stun = self.legendary_ability:GetSpecialValueFor("strike_stun")
	self.legendary_ability.strike_cd = self.legendary_ability:GetSpecialValueFor("strike_cd")/100
end

self.parent.agi_ability = self.ability
self.parent.attribute_legendary = self.legendary_ability

self.ability.morph_rate_tooltip = self.ability:GetSpecialValueFor("morph_rate_tooltip")
self.ability.mana_cost = self.ability:GetSpecialValueFor("mana_cost")  
self.ability.shard_speed = self.ability:GetSpecialValueFor("shard_speed")/100          

if not IsServer() then return end
self.attack_count = 0
self.visual_max = 5
self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}
self.ability:SendJs()
self:SetHasCustomTransmitterData(true)
end

function modifier_morphling_morph_agi_custom_tracker:OnRefresh()
self.ability.morph_rate_tooltip = self.ability:GetSpecialValueFor("morph_rate_tooltip")

if self.str_ability then
	self.str_ability.morph_rate_tooltip = self.ability:GetSpecialValueFor("morph_rate_tooltip")
end

self.legendary_ability = self.parent:FindAbilityByName("morphling_attribute_legendary_custom")
if self.legendary_ability then
	self.legendary_ability.strike_duration = self.legendary_ability:GetSpecialValueFor("strike_duration")
	self.legendary_ability.strike_bva = self.legendary_ability:GetSpecialValueFor("strike_bva")
	self.legendary_ability.strike_stun = self.legendary_ability:GetSpecialValueFor("strike_stun")
	self.legendary_ability.strike_cd = self.legendary_ability:GetSpecialValueFor("strike_cd")/100
end

if not IsServer() then return end
self.ability:SendJs()
end

function modifier_morphling_morph_agi_custom_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if self.ability.talents.has_r7 == 1 then return end
if self.parent ~= params.attacker then return end

local target = params.target
if not target:IsUnit() then return end

if self.ability.talents.has_e3 == 1 and not params.no_attack_cooldown then
	self.attack_count = self.attack_count + 1
	if self.attack_count >= self.ability.talents.e3_max then
		self.attack_count = 0
		target:AddNewModifier(self.parent, self.ability, "modifier_morphling_morph_custom_double", {duration = 0.2})
		self:GiveStats(target:IsRealHero())
	end
end

end

function modifier_morphling_morph_agi_custom_tracker:GiveStats(hit_hero)
if not IsServer() then return end
local duration = hit_hero and self.ability.talents.e3_duration or self.ability.talents.e3_duration_creeps
local mod = self.parent:FindModifierByName("modifier_morphling_morph_custom_stats_inc")
if mod then
	duration = math.max(mod:GetRemainingTime(), duration)
end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_morphling_morph_custom_stats_inc", {duration = duration})
end

function modifier_morphling_morph_agi_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local target = params.target
if not target:IsUnit() then return end

if self.ability.talents.has_e1 == 1 then
	target:AddNewModifier(self.parent, self.ability, "modifier_morphling_morph_custom_burn", {})
end

if self.ability.talents.has_e4 == 1 and not target:HasModifier("modifier_morphling_morph_custom_stun_cd") and RollPseudoRandomPercentage(self.ability.talents.e4_chance, 1235, self.parent) then
	target:AddNewModifier(self.parent, self.ability, "modifier_morphling_morph_custom_stun_cd", {duration = self.ability.talents.e4_talent_cd})

	local stun = math.min(self.ability.talents.e4_max_stun, self.ability.talents.e4_stun*(self.parent:GetStrength()/self.ability.talents.e4_str))
	target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_bashed", {duration = (1 - target:GetStatusResistance())*stun})
	target:EmitSound("Morph.Attribute_stun")
	target:EmitSound("Morph.Attribute_stun2")

	local effect = ParticleManager:CreateParticle("particles/morphling/adaptive_str_stun.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 1, target:GetAbsOrigin())
	ParticleManager:SetParticleControlForward(effect, 2, (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized())
	ParticleManager:ReleaseParticleIndex(effect)
end

if self.ability.talents.has_e2 == 1 then
	self.damageTable.damage = params.damage*self.ability.talents.e2_damage
	local count = 0

	for _,aoe_target in pairs(self.parent:FindTargets(self.ability.talents.e2_radius, target:GetAbsOrigin())) do
		if target ~= aoe_target then 
			self.damageTable.victim = aoe_target
			DoDamage(self.damageTable, "modifier_morphling_attribute_2")
			count = 1
		end 
	end 

	if count ~= 0 then
		local particle = ParticleManager:CreateParticle("particles/morphling/attack_cleave.vpcf", PATTACH_WORLDORIGIN, nil)	
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle)
	end
end

if self.ability.talents.has_e7 == 0 then return end

if self.parent:HasModifier("modifier_morphling_morph_custom_legendary") then
	if IsValid(self.parent.wave_ability) and not params.no_attack_cooldown then
		self.parent:CdAbility(self.parent.wave_ability, nil, self.ability.talents.e7_wave_cd)
	end
	return
end

if not target:IsRealHero() then return end
if not self.legendary_ability or self.legendary_ability:GetCooldownTimeRemaining() > 0 then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_morphling_morph_custom_legendary_stack", {duration = self.ability.talents.e7_linger})
end


function modifier_morphling_morph_agi_custom_tracker:OnIntervalThink()
if not IsServer() then return end

if self.ability.talents.has_e4 == 1 then
	self:SetStackCount(self.parent:GetBaseStrength())
end

self:StartIntervalThink(self.parent:HasModifier("modifier_morphling_morph_custom_toggle") and 0.25 or 1)
end

function modifier_morphling_morph_agi_custom_tracker:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_e7 == 0 then return end

local stack = 0
local override = nil
local zero = nil
local active = 0
local max = self.ability.talents.e7_max
local mod = self.parent:FindModifierByName("modifier_morphling_morph_custom_legendary_stack")
local effect = self.parent:FindModifierByName("modifier_morphling_morph_custom_legendary")

if mod then
	stack = mod:GetStackCount()
end

if mod or effect then
	if self.particle then
		ParticleManager:DestroyParticle(self.particle, true)
		ParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
else
	if not self.particle then
		self.particle = self.parent:GenericParticle("particles/morphling/attribute_legendary_stack.vpcf", self, true)
		for i = 1,self.visual_max do 
			ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
		end
	end
end

if effect then
	active = 1
	zero = 1
	stack = effect:GetRemainingTime()
	override = effect:GetRemainingTime()
	max = self.ability.talents.e7_duration
else
	if self.legendary_ability and not self.legendary_ability:IsActivated() then
		self.legendary_ability:StartCd()
		self.ability:SetActivated(true)
		local str_ability = self.parent:FindAbilityByName("morphling_morph_str_custom")
		if str_ability then
			str_ability:SetActivated(true)
		end
	end
end

if self.legendary_ability and self.legendary_ability:GetCooldownTimeRemaining() > 0 then
	override = self.legendary_ability:GetCooldownTimeRemaining()
	stack = 0
end

self.parent:UpdateUIlong({stack = stack, max = max, override_stack = override, priority = 2, use_zero = zero, active = active, style = "MorphAttribute"})
end

function modifier_morphling_morph_agi_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_morphling_morph_agi_custom_tracker:GetModifierAttackSpeedBonus_Constant()
local bonus = self.ability.talents.e1_speed
if self.ability.talents.has_e4 == 1 and not self.parent:HasModifier("modifier_morphling_morph_custom_legendary") then 
	if IsClient() then 
		bonus = bonus + self:GetStackCount()
	else
		bonus = bonus + self.parent:GetBaseStrength()
	end
end
return bonus
end

function modifier_morphling_morph_agi_custom_tracker:GetModifierAttackRangeBonus()
return self.ability.talents.e2_range
end



modifier_morphling_morph_custom_legendary_stack = class(mod_hidden)
function modifier_morphling_morph_custom_legendary_stack:IsDebuff() return true end
function modifier_morphling_morph_custom_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.ability.talents.e7_max
self.radius = self.ability.talents.e7_radius
self.duration = self.ability.talents.e7_linger

if not IsServer() then return end
self.visual_max = 5
self.particle = self.parent:GenericParticle("particles/morphling/attribute_legendary_stack.vpcf", self, true)

self:SetStackCount(1)
self:StartIntervalThink(0.2)
end

function modifier_morphling_morph_custom_legendary_stack:OnIntervalThink()
if not IsServer() then return end
local targets = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #targets > 0 then
	self:SetDuration(self.duration, true)
end

end

function modifier_morphling_morph_custom_legendary_stack:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then

end

end

function modifier_morphling_morph_custom_legendary_stack:OnStackCountChanged()
if not IsServer() then return end

self.ability.tracker:UpdateUI()
if not self.particle then return end

for i = 1,self.visual_max do 
	if i <= math.floor(self:GetStackCount()/(self.max/self.visual_max)) then 
		ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))	
	else 
		ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
	end
end

end


function modifier_morphling_morph_custom_legendary_stack:OnDestroy()
if not IsServer() then return end
self.ability.tracker:UpdateUI()
end



morphling_attribute_legendary_custom = class({})
morphling_attribute_legendary_custom.talents = {}

function morphling_attribute_legendary_custom:CreateTalent()
if self:GetCaster():HasModifier("modifier_morphling_replicate_custom") then return end
self:SetHidden(false)
end

function morphling_attribute_legendary_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    e7_talent_cd = caster:GetTalentValue("modifier_morphling_attribute_7", "talent_cd", true),
    e7_max = caster:GetTalentValue("modifier_morphling_attribute_7", "max", true),
    e7_duration = caster:GetTalentValue("modifier_morphling_attribute_7", "duration", true),
    e7_duration_k = caster:GetTalentValue("modifier_morphling_attribute_7", "duration_k", true),
    e7_strike_duration = caster:GetTalentValue("modifier_morphling_attribute_7", "strike_duration", true),
  }
end

end

function morphling_attribute_legendary_custom:GetCooldown()
return self.talents.e7_talent_cd and self.talents.e7_talent_cd or 0
end

function morphling_attribute_legendary_custom:OnAbilityPhaseStart()
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_morphling_morph_custom_legendary_stack")
if not mod or mod:GetStackCount() <= 0 then
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer( caster:GetPlayerOwnerID() ), "CreateIngameErrorMessage", {message = "#dota_hud_error_no_charges"})
	return false
end
return true
end

function morphling_attribute_legendary_custom:OnSpellStart()
local caster = self:GetCaster()

local mod = caster:FindModifierByName("modifier_morphling_morph_custom_legendary_stack")
if not mod or mod:GetStackCount() <= 0 then return end

local duration = self.talents.e7_duration*math.pow(mod:GetStackCount()/self.talents.e7_max, self.talents.e7_duration_k)
caster:AddNewModifier(caster, self, "modifier_morphling_morph_custom_legendary", {duration = duration})
caster:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1.2)
mod:Destroy()
end

modifier_morphling_morph_custom_legendary = class(mod_hidden)
function modifier_morphling_morph_custom_legendary:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end

self.RemoveForDuel = true

local agility = self.parent:GetBaseAgility()
local strength = self.parent:GetBaseStrength()

self.str_bonus = agility > strength and (agility - strength) or 0
self.agi_bonus = strength > agility and (strength - agility) or 0

self.agi_ability = self.parent:FindAbilityByName("morphling_morph_agi_custom")
self.str_ability = self.parent:FindAbilityByName("morphling_morph_str_custom")

if self.agi_ability then
	if self.agi_ability:GetToggleState() then
		self.agi_ability:ToggleAbility()
	end
	self.agi_ability:SetActivated(false)
end

if self.str_ability then
	if self.str_ability:GetToggleState() then
		self.str_ability:ToggleAbility()
	end
	self.str_ability:SetActivated(false)
end

self.parent:GenericParticle("particles/morphling/attribute_legendary_effect.vpcf", self)
self.parent:GenericParticle("particles/units/heroes/hero_morphling/morphling_morph_str.vpcf", self)

self.max = self.ability.talents.e7_max
self.time_max = self.ability.talents.e7_duration
self.visual_max = 5

self.particle = self.parent:GenericParticle("particles/morphling/attribute_legendary_stack.vpcf", self, true)

local radius = 250
local effect2 = ParticleManager:CreateParticle("particles/morphling/attribute_legendary_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(effect2, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(effect2, 1, Vector(radius, radius, radius))
ParticleManager:ReleaseParticleIndex(effect2)

self.parent:EmitSound("Morph.Attribute_legendary_cast")
self.parent:EmitSound("Morph.Attribute_legendary_cast2")
self.parent:EmitSound("Morph.Attribute_legendary_loop")

self.ability:EndCd()
self.parent:CalculateStatBonus(true)

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_morphling_morph_custom_legendary:OnIntervalThink()
if not IsServer() then return end

if self.agi_ability.tracker then
	self.agi_ability.tracker:UpdateUI()
end

if not self.particle then return end

for i = 1,self.visual_max do 
	if i <= (math.floor((self:GetRemainingTime() - 0.1)/(self.time_max/self.visual_max)) + 1) then 
		ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))	
	else 
		ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
	end
end

end

function modifier_morphling_morph_custom_legendary:OnDestroy()
if not IsServer() then return end

if self.agi_ability.tracker then
	self.agi_ability.tracker:UpdateUI()
end

self.parent:StopSound("Morph.Attribute_legendary_loop")

self.ability:StartCd()

if self.agi_ability then
	self.agi_ability:SetActivated(true)
end

if self.str_ability then
	self.str_ability:SetActivated(true)
end

end

function modifier_morphling_morph_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS
}
end

function modifier_morphling_morph_custom_legendary:GetModifierModelScale()
return 35
end

function modifier_morphling_morph_custom_legendary:GetModifierBonusStats_Strength()
return self.str_bonus
end

function modifier_morphling_morph_custom_legendary:GetModifierBonusStats_Agility()
return self.agi_bonus
end

function modifier_morphling_morph_custom_legendary:GetStatusEffectName()
return "particles/butterfly_status.vpcf" 
end

function modifier_morphling_morph_custom_legendary:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end



modifier_morphling_morph_custom_legendary_attack = class(mod_visible)
function modifier_morphling_morph_custom_legendary_attack:GetTexture() return "attribute_legendary" end
function modifier_morphling_morph_custom_legendary_attack:OnCreated()
self.ability = self:GetAbility()
self.bva = self.ability.strike_bva
end

function modifier_morphling_morph_custom_legendary_attack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT
}
end

function modifier_morphling_morph_custom_legendary_attack:GetModifierBaseAttackTimeConstant()
return self.bva
end


modifier_morphling_morph_custom_stats_inc = class(mod_visible)
function modifier_morphling_morph_custom_stats_inc:GetTexture() return "buffs/morphling/attribute_3" end
function modifier_morphling_morph_custom_stats_inc:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.e3_max
self.stats = self.ability.talents.e3_stats
if not IsServer() then return end
self:OnRefresh()
end

function modifier_morphling_morph_custom_stats_inc:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
self.parent:CalculateStatBonus(true)
end

function modifier_morphling_morph_custom_stats_inc:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_morphling_morph_custom_stats_inc:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
}
end

function modifier_morphling_morph_custom_stats_inc:GetModifierBonusStats_Agility()
return self.stats*self:GetStackCount()
end

function modifier_morphling_morph_custom_stats_inc:GetModifierBonusStats_Strength()
return self.stats*self:GetStackCount()
end



modifier_morphling_morph_custom_stun_cd = class(mod_hidden)


modifier_morphling_morph_custom_burn = class(mod_hidden)
function modifier_morphling_morph_custom_burn:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.duration = self.ability.talents.e1_duration
self.damage = self.ability.talents.e1_damage/self.duration
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = self.ability.talents.e1_damage_type, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}
if not IsServer() then return end
self.count = 0
self.parent:GenericParticle("particles/morphling/attribute_burn.vpcf", self)
self:StartIntervalThink(1)
end

function modifier_morphling_morph_custom_burn:OnRefresh() 
if not IsServer() then return end
self.count = 0
end

function modifier_morphling_morph_custom_burn:OnIntervalThink()
if not IsServer() then return end

self.damageTable.damage = self.damage*(self.caster:GetStrength() + self.caster:GetAgility())
DoDamage(self.damageTable, "modifier_morphling_attribute_1")

self.count = self.count + 1
if self.count >= self.ability.talents.e1_duration then
	self:Destroy()
	return
end

end

function modifier_morphling_morph_custom_burn:GetStatusEffectName()
return "particles/status_fx/status_effect_naga_riptide.vpcf"
end

function modifier_morphling_morph_custom_burn:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH
end




modifier_morphling_morph_custom_double = class(mod_hidden)
function modifier_morphling_morph_custom_double:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_morphling_morph_custom_double:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

if not IsServer() then return end
self.caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 3)
local size = 110
if self.caster:HasModifier("modifier_morphling_morph_custom_legendary") then
	size = 145
end
local dir =  (self.parent:GetOrigin() - self.caster:GetOrigin() ):Normalized()
local particle = ParticleManager:CreateParticle( "particles/morphling/double_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster )
ParticleManager:SetParticleControl( particle, 0, self.caster:GetAbsOrigin() )
ParticleManager:SetParticleControl( particle, 1, self.caster:GetAbsOrigin() )
ParticleManager:SetParticleControl( particle, 2, Vector(size, 0, 0))
ParticleManager:SetParticleControlForward( particle, 1, dir)
ParticleManager:SetParticleControlForward( particle, 5, dir )
ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_morphling_morph_custom_double:OnDestroy()
if not IsServer() then return end
if not self.caster:IsAlive() then return end

self.info = 
{
	EffectName = "particles/units/heroes/hero_morphling/morphling_base_attack.vpcf",
	Ability = self.ability,
	iMoveSpeed = self.caster:GetProjectileSpeed(),
	Source = self.caster,
	Target = self.parent,
	bDodgeable = true,
	bProvidesVision = true,
	iVisionTeamNumber = self.caster:GetTeamNumber(),
	iVisionRadius = 50,
	iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1, 
}
self.caster:EmitSound("Morph.Double_attack")
ProjectileManager:CreateTrackingProjectile( self.info )
end




modifier_morphling_morph_custom_double_damage = class(mod_hidden)
function modifier_morphling_morph_custom_double_damage:OnCreated()
self.damage = self:GetAbility().talents.e3_damage - 100
end

function modifier_morphling_morph_custom_double_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_morphling_morph_custom_double_damage:GetModifierDamageOutgoing_Percentage()
return self.damage
end
