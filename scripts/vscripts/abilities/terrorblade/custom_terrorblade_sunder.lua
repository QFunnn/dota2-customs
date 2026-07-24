--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_terrorblade_sunder_legendary", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_tracker", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_stats", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_stats_self", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_rooted", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_damage", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_slow", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_cd", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_shield", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_lethal", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_sunder_lethal_cd", "abilities/terrorblade/custom_terrorblade_sunder", LUA_MODIFIER_MOTION_NONE)

custom_terrorblade_sunder = class({})

function custom_terrorblade_sunder:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "terrorblade_sunder", self)
end


function custom_terrorblade_sunder:CreateTalent()
self:ToggleAutoCast()
end

function custom_terrorblade_sunder:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", context )
PrecacheResource( "particle","particles/econ/events/spring_2021/blink_dagger_spring_2021_start_lvl2.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", context )
PrecacheResource( "particle","particles/econ/events/spring_2021/blink_dagger_spring_2021_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", context )
PrecacheResource( "particle","particles/items_fx/phylactery_target.vpcf", context )
PrecacheResource( "particle","particles/items_fx/phylactery.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/gleipnir_root.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf", context )
PrecacheResource( "particle","particles/terrorblade/sunder_lethal.vpcf", context )

end



function custom_terrorblade_sunder:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_terrorblade_sunder_tracker"
end


function custom_terrorblade_sunder:GetManaCost(level)
if self:GetCaster():HasTalent("modifier_terror_sunder_6") then
	return 0
end
return self.BaseClass.GetManaCost(self,level)
end

function custom_terrorblade_sunder:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_terror_sunder_5") then 
    bonus = self:GetCaster():GetTalentValue("modifier_terror_sunder_5", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end

function custom_terrorblade_sunder:GetCastRange(vLocation, hTarget)
return self.BaseClass.GetCastRange(self , vLocation , hTarget) 
end

function custom_terrorblade_sunder:GetCooldown(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_terror_sunder_3") then
	bonus = self:GetCaster():GetTalentValue("modifier_terror_sunder_3", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function custom_terrorblade_sunder:GetAbilityTargetFlags()
if self:GetCaster():HasTalent("modifier_terror_sunder_6") then 
  return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end
return DOTA_UNIT_TARGET_FLAG_NONE
end

function custom_terrorblade_sunder:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_terror_sunder_7") then 
	bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + bonus
end



function custom_terrorblade_sunder:CastFilterResultTarget(target)
if target == self:GetCaster() then
	return UF_FAIL_CUSTOM
end

if target ~= nil and target:HasModifier("modifier_generic_debuff_immune") and not self:GetCaster():HasTalent("modifier_terror_sunder_6") then
	return UF_FAIL_MAGIC_IMMUNE_ENEMY
end

if self:GetCaster():HasTalent("modifier_terror_sunder_7") then 
	return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP, self:GetCaster():GetTeamNumber())
end
return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP, self:GetCaster():GetTeamNumber())
end

function custom_terrorblade_sunder:GetCustomCastErrorTarget(target)
if target == self:GetCaster() then
	return "#dota_hud_error_cant_cast_on_self"
end

end


function custom_terrorblade_sunder:PlayEffect(target)
if not IsServer() then return end

local caster = self:GetCaster()
caster:EmitSound("Hero_Terrorblade.Sunder.Cast")
target:EmitSound("Hero_Terrorblade.Sunder.Target")
local effect_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", self)

local sunder_particle_1 = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt(sunder_particle_1, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(sunder_particle_1, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(sunder_particle_1, 2, target:GetAbsOrigin())
if caster.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
    local color = caster:GetTerrorbladeColor()
    ParticleManager:SetParticleControl(sunder_particle_1, 15, color)
    ParticleManager:SetParticleControl(sunder_particle_1, 16, Vector(1,0,0))
else
    ParticleManager:SetParticleControl(sunder_particle_1, 15, Vector(0,152,255))
    ParticleManager:SetParticleControl(sunder_particle_1, 16, Vector(1,0,0))
end
ParticleManager:ReleaseParticleIndex(sunder_particle_1)

local sunder_particle_2 = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, caster)
ParticleManager:SetParticleControlEnt(sunder_particle_2, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(sunder_particle_2, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(sunder_particle_2, 2, caster:GetAbsOrigin())
if caster.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
    local color = caster:GetTerrorbladeColor()
    ParticleManager:SetParticleControl(sunder_particle_2, 15, color)
    ParticleManager:SetParticleControl(sunder_particle_2, 16, Vector(1,0,0))
else
    ParticleManager:SetParticleControl(sunder_particle_2, 15, Vector(0,152,255))
    ParticleManager:SetParticleControl(sunder_particle_2, 16, Vector(1,0,0))
end
ParticleManager:ReleaseParticleIndex(sunder_particle_2)
end




function custom_terrorblade_sunder:OnSpellStart()

local caster = self:GetCaster()
local target = self:GetCursorTarget()

local is_enemy = caster:GetTeamNumber() ~= target:GetTeamNumber()

if is_enemy then
	if target:TriggerSpellAbsorb(self) then return end
end

if caster:HasTalent("modifier_terror_sunder_6") and is_enemy then 
	local stun = 0
	if caster:GetHealthPercent() <= caster:GetTalentValue("modifier_terror_sunder_6", "health") then
		stun = 1
	end
	target:AddNewModifier(caster, caster:BkbAbility(self,true), "modifier_custom_terrorblade_sunder_rooted", {stun = stun, duration = (1 - target:GetStatusResistance())*caster:GetTalentValue("modifier_terror_sunder_6", "root")})
end

if caster:HasTalent("modifier_terror_sunder_7") and target ~= nil and is_enemy then 
	caster:AddNewModifier(caster, self, "modifier_custom_terrorblade_sunder_legendary", {target = target:entindex()})
else 
	local caster_health_percent	= caster:GetHealthPercent()
	local target_health_percent	= target:GetHealthPercent()

	local current_health = caster:GetHealth()

	self:PlayEffect(target)

	caster:SetHealth(caster:GetMaxHealth() * math.max(target_health_percent, self:GetSpecialValueFor("hit_point_minimum_pct")) * 0.01)
	
	caster:AddHealingInfo({ability_name = self:GetName(), inflictor = self, healing = caster:GetHealth() - current_health})

	if caster:GetHealth() > current_health and caster:GetQuest() == "Terr.Quest_8" and not caster:QuestCompleted() and target:IsRealHero() and target:GetTeamNumber() ~= caster:GetTeamNumber() then 
		caster:UpdateQuest(caster:GetHealth() - current_health)
	end

	target:SetHealth(target:GetMaxHealth() * math.max(caster_health_percent, self:GetSpecialValueFor("hit_point_minimum_pct")) * 0.01)
end

if caster:HasTalent("modifier_terror_sunder_4") and is_enemy then 

	caster:RemoveModifierByName("modifier_custom_terrorblade_sunder_stats_self")
	caster:RemoveModifierByName("modifier_custom_terrorblade_sunder_stats")
	target:RemoveModifierByName("modifier_custom_terrorblade_sunder_stats")

	local stats_target = target
	if stats_target:IsCreep() then 
		stats_target = caster
	end

	stats_target:AddNewModifier(caster, self, "modifier_custom_terrorblade_sunder_stats", {duration = caster:GetTalentValue("modifier_terror_sunder_4", "duration")})  
end


if caster:HasTalent("modifier_terror_sunder_1") and is_enemy then 
	target:AddNewModifier(caster, self, "modifier_custom_terrorblade_sunder_damage", {})
end

if caster:HasTalent("modifier_terror_sunder_2") then
	caster:AddNewModifier(caster, self, "modifier_custom_terrorblade_sunder_shield", {duration = caster:GetTalentValue("modifier_terror_sunder_2", "duration")})
end

end





modifier_custom_terrorblade_sunder_legendary = class({})
function modifier_custom_terrorblade_sunder_legendary:IsHidden() return true end
function modifier_custom_terrorblade_sunder_legendary:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_legendary:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end

if table.target then 
	self.target = EntIndexToHScript(table.target)
end

self.heal = self.parent:GetTalentValue("modifier_terror_sunder_7", "heal")/100
self.interval = self.parent:GetTalentValue("modifier_terror_sunder_7", "interval")
self.max = self.parent:GetTalentValue("modifier_terror_sunder_7", "max")

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_custom_terrorblade_sunder_legendary:OnIntervalThink()
if not IsServer() then return end
if not self.target or self.target:IsNull() or not self.target:IsAlive() then
	self:Destroy()
	return
end

local current_health = self.parent:GetHealth()
local heal = (self.parent:GetMaxHealth() - current_health)*self.heal

self.parent:SetHealth(math.min(self.parent:GetMaxHealth(), self.parent:GetHealth() + heal))

self.parent:AddHealingInfo({ability_name = self.ability:GetName(), inflictor = self.ability, healing = self.parent:GetHealth() - current_health})

if self.parent:GetHealth() > current_health and self.parent:GetQuest() == "Terr.Quest_8" and not self.parent:QuestCompleted() and self.target:IsRealHero() and self.target:GetTeamNumber() ~= self.parent:GetTeamNumber() then 
	self.parent:UpdateQuest(self.parent:GetHealth() - current_health)
end

SendOverheadEventMessage(self.parent, 10, self.parent, heal, nil)
DoDamage({victim = self.target, damage = heal, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self.parent, ability = self.ability})
self.ability:PlayEffect(self.target)

self:IncrementStackCount()
if self:GetStackCount() >= self.max then
	self:Destroy()
	return
end

end





modifier_custom_terrorblade_sunder_tracker = class({})
function modifier_custom_terrorblade_sunder_tracker:IsHidden() return true end
function modifier_custom_terrorblade_sunder_tracker:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_tracker:RemoveOnDeath() return false end
function modifier_custom_terrorblade_sunder_tracker:DeclareFunctions()
return
{
  	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  	MODIFIER_PROPERTY_MIN_HEALTH,
}
end

function modifier_custom_terrorblade_sunder_tracker:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_terror_sunder_3") then return end 
return self.range_bonus
end

function modifier_custom_terrorblade_sunder_tracker:UpdateTalent()
self.range_bonus = self.parent:GetTalentValue("modifier_terror_sunder_3", "range")
self:SendBuffRefreshToClients()
end

function modifier_custom_terrorblade_sunder_tracker:AddCustomTransmitterData() 
return 
{
    range_bonus = self.range_bonus,
} 
end

function modifier_custom_terrorblade_sunder_tracker:HandleCustomTransmitterData(data)
self.range_bonus = data.range_bonus
end


function modifier_custom_terrorblade_sunder_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_cd = self.parent:GetTalentValue("modifier_terror_sunder_7", "cd", true)
self.legendary_health = self.parent:GetTalentValue("modifier_terror_sunder_7", "cost", true)/100
self.legendary_slow = self.parent:GetTalentValue("modifier_terror_sunder_7", "slow_duration", true)
self.legendary_radius = self.parent:GetTalentValue("modifier_terror_sunder_7", "radius", true)

self.lethal_cd = self.parent:GetTalentValue("modifier_terror_sunder_5", "cd", true)
self.lethal_duration = self.parent:GetTalentValue("modifier_terror_sunder_5", "duration", true)

if not IsServer() then return end
self.parent:AddDamageEvent_inc(self)
self.parent:AddAttackEvent_out(self)
self:UpdateTalent()
self:SetHasCustomTransmitterData(true)
end




function modifier_custom_terrorblade_sunder_tracker:AttackEvent_out(params)
if not IsServer() then return end
if params.attacker ~= self.parent then return end
if not params.target:IsUnit() then return end

local target = params.target

if self.parent:HasTalent("modifier_terror_sunder_4") then
	local mod = target:FindModifierByName("modifier_custom_terrorblade_sunder_stats")
	if not mod then
		mod = self.parent:FindModifierByName("modifier_custom_terrorblade_sunder_stats")
	end

	if mod and mod.max and mod:GetCaster() == self.parent and mod:GetStackCount() < mod.max then 
		mod:IncrementStackCount()
	end
end


if not self.parent:HasTalent("modifier_terror_sunder_7") then return end
if self.parent:HasModifier("modifier_custom_terrorblade_sunder_cd") then return end
if not self.ability:GetAutoCastState() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_sunder_cd", {duration = self.legendary_cd})

local sunder_particle_1 = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt(sunder_particle_1, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(sunder_particle_1, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
ParticleManager:SetParticleControl(sunder_particle_1, 2, target:GetAbsOrigin())
ParticleManager:SetParticleControl(sunder_particle_1, 15, Vector(191, 100, 255))
ParticleManager:SetParticleControl(sunder_particle_1, 16, Vector(1,0,0))
ParticleManager:ReleaseParticleIndex(sunder_particle_1)

local damage = self.parent:GetMaxHealth()*self.legendary_health
self.parent:SetHealth(math.max(1, self.parent:GetHealth() - damage))
local damage_table = {damage = damage, damage_type = DAMAGE_TYPE_PURE, attacker = self.parent, ability = self.ability}

for _,aoe_target in pairs(self.parent:FindTargets(self.legendary_radius, target:GetAbsOrigin())) do
	damage_table.victim = aoe_target
	local real_damage = DoDamage(damage_table, "modifier_terror_sunder_7")
	aoe_target:SendNumber(4, real_damage)
	aoe_target:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_sunder_slow", {duration = (1 - aoe_target:GetStatusResistance())*self.legendary_slow})

	local particle_2 = ParticleManager:CreateParticle("particles/items_fx/phylactery_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle_2, 1, aoe_target, PATTACH_POINT_FOLLOW, "attach_hitloc", aoe_target:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle_2)
end

target:EmitSound("TB.Sunder_attack")
end



function modifier_custom_terrorblade_sunder_tracker:DamageEvent_inc(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_terror_sunder_5") then return end
if self.parent ~= params.unit then return end
if self.parent:GetHealth() > 1 then return end 
if self.parent:PassivesDisabled() then return end
if not self.parent:IsAlive() then return end
if self.parent:HasModifier("modifier_death") then return end
if self.parent:HasModifier("modifier_custom_terrorblade_sunder_lethal_cd") then return end

self.parent:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_custom_terrorblade_sunder_lethal",  {duration = self.lethal_duration})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_sunder_lethal_cd",  {duration = self.lethal_cd})
end


function modifier_custom_terrorblade_sunder_tracker:GetMinHealth()
if not self.parent:HasTalent("modifier_terror_sunder_5") then return end
if self.parent:PassivesDisabled() then return end
if self.parent:LethalDisabled() then return end
if self.parent:HasModifier("modifier_custom_terrorblade_sunder_lethal_cd") then return end
if not self.parent:IsAlive() then return end
return 1
end




modifier_custom_terrorblade_sunder_slow = class({})
function modifier_custom_terrorblade_sunder_slow:IsHidden() return true end
function modifier_custom_terrorblade_sunder_slow:IsPurgable() return true end
function modifier_custom_terrorblade_sunder_slow:GetEffectName() return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf" end
function modifier_custom_terrorblade_sunder_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end
function modifier_custom_terrorblade_sunder_slow:GetModifierMoveSpeedBonus_Percentage() return self.slow end
function modifier_custom_terrorblade_sunder_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_terror_sunder_7", "slow")
end


modifier_custom_terrorblade_sunder_cd = class({})
function modifier_custom_terrorblade_sunder_cd:IsHidden() return false end
function modifier_custom_terrorblade_sunder_cd:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_cd:RemoveOnDeath() return false end
function modifier_custom_terrorblade_sunder_cd:IsDebuff() return true end
function modifier_custom_terrorblade_sunder_cd:GetTexture() return "buffs/sunder_stats" end
function modifier_custom_terrorblade_sunder_cd:OnCreated(table)
self.RemoveForDuel = true
end





modifier_custom_terrorblade_sunder_stats = class({})
function modifier_custom_terrorblade_sunder_stats:IsHidden() return false end
function modifier_custom_terrorblade_sunder_stats:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_stats:GetTexture() return "buffs/sunder_heal" end
function modifier_custom_terrorblade_sunder_stats:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.is_self = self.parent == self.caster

self.init = self.caster:GetTalentValue("modifier_terror_sunder_4", "init")/100
self.max = self.caster:GetTalentValue("modifier_terror_sunder_4", "max")
self.inc = self.init/self.max

if not self.is_self then 
	self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_custom_terrorblade_sunder_stats_self", {duration = self:GetRemainingTime()})
end

self.k = 1
if not self.is_self then
	self.k = -1
end
self.strength = 0
self.agility = 0
self.int = 0

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end



function modifier_custom_terrorblade_sunder_stats:OnIntervalThink()
if not IsServer() then return end

self.strength = 0
self.agility = 0
self.int = 0

self.strength = self.parent:GetStrength() * (self.init + self.inc*self:GetStackCount())
self.agility = self.parent:GetAgility() * (self.init + self.inc*self:GetStackCount())
self.int = self.parent:GetIntellect(false) * (self.init + self.inc*self:GetStackCount())

self.parent:CalculateStatBonus(true)

if self.is_self then return end

local mod = self.caster:FindModifierByName("modifier_custom_terrorblade_sunder_stats_self")
if mod then 
	mod.strength = self.strength
	mod.agility = self.agility
	mod.int = self.int

	mod:SetStackCount(self:GetStackCount())
	self.caster:CalculateStatBonus(true)
end

end

function modifier_custom_terrorblade_sunder_stats:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
}
end

function modifier_custom_terrorblade_sunder_stats:GetModifierBonusStats_Strength()
return self.k*self.strength
end

function modifier_custom_terrorblade_sunder_stats:GetModifierBonusStats_Agility()
return self.k*self.agility
end

function modifier_custom_terrorblade_sunder_stats:GetModifierBonusStats_Intellect()
return self.k*self.int
end



modifier_custom_terrorblade_sunder_stats_self = class({})
function modifier_custom_terrorblade_sunder_stats_self:IsHidden() return false end
function modifier_custom_terrorblade_sunder_stats_self:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_stats_self:GetTexture() return "buffs/sunder_heal" end
function modifier_custom_terrorblade_sunder_stats_self:OnCreated(table)
if not IsServer() then return end
self.strength = 0
self.agility = 0
self.int = 0
end

function modifier_custom_terrorblade_sunder_stats_self:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
}
end

function modifier_custom_terrorblade_sunder_stats_self:GetModifierBonusStats_Strength()
return self.strength
end

function modifier_custom_terrorblade_sunder_stats_self:GetModifierBonusStats_Agility()
return self.agility
end

function modifier_custom_terrorblade_sunder_stats_self:GetModifierBonusStats_Intellect()
return self.int
end








modifier_custom_terrorblade_sunder_rooted = class({})
function modifier_custom_terrorblade_sunder_rooted:IsHidden() return true end
function modifier_custom_terrorblade_sunder_rooted:IsPurgable() return true end
function modifier_custom_terrorblade_sunder_rooted:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end
function modifier_custom_terrorblade_sunder_rooted:GetEffectName() return "particles/items3_fx/gleipnir_root.vpcf" end

function modifier_custom_terrorblade_sunder_rooted:OnCreated(table)
if not IsServer() then return end
if table.stun == 0 then return end
 
self.parent = self:GetParent()
self.parent:EmitSound("TB.Sunder_stun")
self.parent:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = self:GetRemainingTime()})
end




modifier_custom_terrorblade_sunder_damage = class({})
function modifier_custom_terrorblade_sunder_damage:IsHidden() return true end
function modifier_custom_terrorblade_sunder_damage:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_damage:GetTexture() return "buffs/sunder_damage" end

function modifier_custom_terrorblade_sunder_damage:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.duration = self.caster:GetTalentValue("modifier_terror_sunder_1", "duration")
self.damage = self.caster:GetTalentValue("modifier_terror_sunder_1", "damage")/100
self.interval = 1
self.heal_reduce = self.caster:GetTalentValue("modifier_terror_sunder_1", "heal_reduce")

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_PURE}

if not IsServer() then return end
self.parent:GenericParticle("particles/items4_fx/spirit_vessel_damage.vpcf", self)
self:StartIntervalThink(self.interval)
end

function modifier_custom_terrorblade_sunder_damage:OnIntervalThink()
if not IsServer() then return end

self.damageTable.damage = (self.damage/self.duration)*self.caster:GetMaxHealth() 
local damage = DoDamage(self.damageTable, "modifier_terror_sunder_1")
self.parent:SendNumber(4, damage)

self:IncrementStackCount()
if self:GetStackCount() >= self.duration then
	self:Destroy()
	return
end

end

function modifier_custom_terrorblade_sunder_damage:DeclareFunctions()
return 
{
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end


function modifier_custom_terrorblade_sunder_damage:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_custom_terrorblade_sunder_damage:GetModifierHealChange()
return self.heal_reduce
end

function modifier_custom_terrorblade_sunder_damage:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end






modifier_custom_terrorblade_sunder_shield = class({})
function modifier_custom_terrorblade_sunder_shield:IsHidden() return true end
function modifier_custom_terrorblade_sunder_shield:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_shield:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_custom_terrorblade_sunder_shield:OnCreated(table)
self.parent = self:GetParent()
self.shield_talent = "modifier_terror_sunder_2"
self.max_shield = self.parent:GetTalentValue("modifier_terror_sunder_2", "shield")*self.parent:GetMaxHealth()/100

if not IsServer() then return end

self:SetStackCount(self.max_shield)
end

function modifier_custom_terrorblade_sunder_shield:GetModifierIncomingDamageConstant( params )
if self:GetStackCount() == 0 then return end

if IsClient() then 
  if params.report_max then 
  	return self.max_shield
  else 
	  return self:GetStackCount()
	end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end






modifier_custom_terrorblade_sunder_lethal = class({})
function modifier_custom_terrorblade_sunder_lethal:IsHidden() return true end
function modifier_custom_terrorblade_sunder_lethal:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_lethal:IsDebuff() return true end
function modifier_custom_terrorblade_sunder_lethal:CheckState()
return
{
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_UNSLOWABLE] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
	[MODIFIER_STATE_MUTED] = true,
	[MODIFIER_STATE_DISARMED] = true
}
end

function modifier_custom_terrorblade_sunder_lethal:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.parent:GetTalentValue("modifier_terror_sunder_5", "speed")

if not IsServer() then return end

self.parent:EmitSound("TB.Sunder_lethal")
self.parent:EmitSound("TB.Sunder_lethal2")

self.effect_cast = ParticleManager:CreateParticle( "particles/terrorblade/sunder_lethal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
self:AddParticle(self.effect_cast,false, false, -1, false, false)
end

function modifier_custom_terrorblade_sunder_lethal:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_terrorblade_sunder_lethal:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

function modifier_custom_terrorblade_sunder_lethal:GetStatusEffectName()
return "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf"
end

function modifier_custom_terrorblade_sunder_lethal:StatusEffectPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA 
end




modifier_custom_terrorblade_sunder_lethal_cd = class({})
function modifier_custom_terrorblade_sunder_lethal_cd:IsHidden() return false end
function modifier_custom_terrorblade_sunder_lethal_cd:IsPurgable() return false end
function modifier_custom_terrorblade_sunder_lethal_cd:GetTexture() return "buffs/midnight_haste" end
function modifier_custom_terrorblade_sunder_lethal_cd:RemoveOnDeath() return false end
function modifier_custom_terrorblade_sunder_lethal_cd:IsDebuff() return true end
function modifier_custom_terrorblade_sunder_lethal_cd:OnCreated()
self.RemoveForDuel = true
end

