--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_alchemist_gold_cuirass", "abilities/items/item_alchemist_gold_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_cuirass_shield", "abilities/items/item_alchemist_gold_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_cuirass_shield_cd", "abilities/items/item_alchemist_gold_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_cuirass_proc", "abilities/items/item_alchemist_gold_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_cuirass_cd", "abilities/items/item_alchemist_gold_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_cuirass_passive", "abilities/items/item_alchemist_gold_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_cuirass_armor_reduce", "abilities/items/item_alchemist_gold_cuirass", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_cuirass_shield_slow", "abilities/items/item_alchemist_gold_cuirass", LUA_MODIFIER_MOTION_NONE)

item_alchemist_gold_cuirass = class({})

function item_alchemist_gold_cuirass:GetIntrinsicModifierName()
	return "modifier_item_alchemist_gold_cuirass"
end

function item_alchemist_gold_cuirass:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/econ/events/ti10/mjollnir_shield_ti10.vpcf", context )
PrecacheResource( "particle","particles/econ/events/ti10/maelstrom_ti10.vpcf", context )
end


function item_alchemist_gold_cuirass:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("static_duration")

caster:EmitSound("DOTA_Item.Mjollnir.Activate")
caster:AddNewModifier(caster, self, "modifier_item_alchemist_gold_cuirass_shield", {duration = duration})
end





modifier_item_alchemist_gold_cuirass = class(mod_hidden)
function modifier_item_alchemist_gold_cuirass:RemoveOnDeath() return false end

function modifier_item_alchemist_gold_cuirass:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.radius = self.ability:GetSpecialValueFor("radius")

self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
self.bonus_attack_speed = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")

self.chance = self.ability:GetSpecialValueFor("chain_chance")
self.cd = self.ability:GetSpecialValueFor("chain_cooldown")

self.records = {}

if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self:RollProc()

self.parent:AddRecordDestroyEvent(self, true)
self.parent:AddAttackEvent_out(self, true)
self.parent:AddAttackStartEvent_out(self)
end

function modifier_item_alchemist_gold_cuirass:RecordDestroyEvent( params )
if not self.records[params.record] then return end
self.records[params.record] = nil
end

function modifier_item_alchemist_gold_cuirass:RollProc()
if not IsServer() then return end
if self.parent:HasModifier("modifier_item_mjollnir_custom") then return end
if self.parent:HasModifier("modifier_item_maelstrom_custom") then return end
if self.parent:HasModifier("modifier_item_alchemist_gold_cuirass_cd") then return end
if not RollPseudoRandomPercentage(self.chance,4259,self.parent) then return end 

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_alchemist_gold_cuirass_proc", {duration = 3})
end


function modifier_item_alchemist_gold_cuirass:AttackStartEvent_out(params)
if not IsServer() then return end 
if not params.target:IsUnit() then return end 
if self.parent ~= params.attacker then return end 

if self.parent:HasModifier("modifier_item_alchemist_gold_cuirass_proc") then 
    self.records[params.record] = true
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_alchemist_gold_cuirass_cd", {duration = self.cd})
end

self.parent:RemoveModifierByName("modifier_item_alchemist_gold_cuirass_proc")

self:RollProc()
end

function modifier_item_alchemist_gold_cuirass:AttackEvent_out(params)
if not IsServer() then return end 
if not params.target:IsUnit() then return end 
if self.parent ~= params.attacker then return end 
if not self.records[params.record] then return end

local mod = self.parent:FindModifierByName("modifier_item_alchemist_gold_cuirass_shield")
if mod then
	mod:IncrementStackCount()
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_alchemist_gold_cuirass_passive", {target = params.target:entindex()})
params.target:EmitSound("Item.Maelstrom.Chain_Lightning")
end


function modifier_item_alchemist_gold_cuirass:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_alchemist_gold_cuirass:GetModifierHealthBonus()
return self.bonus_health
end

function modifier_item_alchemist_gold_cuirass:GetModifierAttackSpeedBonus_Constant()
return self.bonus_attack_speed
end

function modifier_item_alchemist_gold_cuirass:GetModifierPhysicalArmorBonus()
return self.bonus_armor
end

function modifier_item_alchemist_gold_cuirass:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_alchemist_gold_cuirass:CheckState()
if not IsValid(self.parent) or not self.parent:HasModifier("modifier_item_alchemist_gold_cuirass_proc") then return end 
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_item_alchemist_gold_cuirass:GetAuraRadius() return self.radius end
function modifier_item_alchemist_gold_cuirass:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_item_alchemist_gold_cuirass:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_alchemist_gold_cuirass:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_alchemist_gold_cuirass:GetModifierAura() return "modifier_item_alchemist_gold_cuirass_armor_reduce" end
function modifier_item_alchemist_gold_cuirass:IsAura() return true end



modifier_item_alchemist_gold_cuirass_armor_reduce = class(mod_visible)

function modifier_item_alchemist_gold_cuirass_armor_reduce:OnCreated()
self.ability = self:GetAbility()
self.armor = self.ability:GetSpecialValueFor("aura_negative_armor")
self.aura_heal_reduce = self.ability:GetSpecialValueFor("aura_heal_reduce")
self.resist = self.ability:GetSpecialValueFor("aura_resist")
end

function modifier_item_alchemist_gold_cuirass_armor_reduce:DeclareFunctions()
return 
{	
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_item_alchemist_gold_cuirass_armor_reduce:GetModifierHealChange()
return self.aura_heal_reduce
end

function modifier_item_alchemist_gold_cuirass_armor_reduce:GetModifierHPRegenAmplify_Percentage()
return self.aura_heal_reduce
end

function modifier_item_alchemist_gold_cuirass_armor_reduce:GetModifierMagicalResistanceBonus()
return self.resist
end

function modifier_item_alchemist_gold_cuirass_armor_reduce:GetModifierPhysicalArmorBonus()
return self.armor
end






modifier_item_alchemist_gold_cuirass_shield = class(mod_visible)
function modifier_item_alchemist_gold_cuirass_shield:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_speed = self.ability:GetSpecialValueFor("bonus_speed")

self.damage = self.ability:GetSpecialValueFor("chain_damage")

self.chance = self.ability:GetSpecialValueFor("chain_chance")
self.duration = self.ability:GetSpecialValueFor("slow_duration")
self.heal = self.ability:GetSpecialValueFor("proc_heal")/100

self.cd = self.ability:GetSpecialValueFor("static_cooldown")

self.damageTable = {attacker = self.parent, ability = self.ability, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL}

if not IsServer() then return end
self.RemoveForDuel = true
self.parent:EmitSound("DOTA_Item.Mjollnir.Loop")
self.parent:GenericParticle("particles/econ/events/ti10/mjollnir_shield_ti10.vpcf", self)
self.parent:AddDamageEvent_inc(self, true)
end

function modifier_item_alchemist_gold_cuirass_shield:DealDamage(target)
if not IsServer() then return end
self:IncrementStackCount()

self.damageTable.victim = target
DoDamage(self.damageTable)

self.parent:GenericHeal(self.parent:GetMaxHealth()*self.heal, self.ability)
target:AddNewModifier(self.parent, self.ability, "modifier_item_alchemist_gold_cuirass_shield_slow", {duration = self.duration})
target:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")

local nParticleIndex = ParticleManager:CreateParticle("particles/econ/events/ti10/maelstrom_ti10.vpcf", PATTACH_POINT_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(nParticleIndex, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(nParticleIndex, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(nParticleIndex)
end


function modifier_item_alchemist_gold_cuirass_shield:DamageEvent_inc(params)
if not IsServer() then return end
if params.attacker:HasModifier("modifier_item_alchemist_gold_cuirass_shield_cd") then return end
if self.parent ~= params.unit then return end
if self.parent:GetTeamNumber() == params.attacker:GetTeamNumber() then return end
if not params.attacker:IsUnit() then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
if not RollPseudoRandomPercentage(self.chance, 4260, self.parent) then return end 

self:DealDamage(params.attacker)
params.attacker:AddNewModifier(self.parent, self.ability, "modifier_item_alchemist_gold_cuirass_shield_cd", {duration = self.cd})
end

function modifier_item_alchemist_gold_cuirass_shield:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("DOTA_Item.Mjollnir.Loop")
self.parent:EmitSound("DOTA_Item.Mjollnir.DeActivate")
end

function modifier_item_alchemist_gold_cuirass_shield:GetStatusEffectName()
return "particles/status_fx/status_effect_mjollnir_shield.vpcf"
end

function modifier_item_alchemist_gold_cuirass_shield:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end

function modifier_item_alchemist_gold_cuirass_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_item_alchemist_gold_cuirass_shield:GetModifierAttackSpeedBonus_Constant()
return self.bonus_speed*self:GetStackCount()
end





modifier_item_alchemist_gold_cuirass_shield_slow = class({})
function modifier_item_alchemist_gold_cuirass_shield_slow:IsHidden() return true end
function modifier_item_alchemist_gold_cuirass_shield_slow:IsPurgable() return false end
function modifier_item_alchemist_gold_cuirass_shield_slow:OnCreated()
self.slow = self:GetAbility():GetSpecialValueFor("slow_proc")
end

function modifier_item_alchemist_gold_cuirass_shield_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_alchemist_gold_cuirass_shield_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end





modifier_item_alchemist_gold_cuirass_passive = class({})
function modifier_item_alchemist_gold_cuirass_passive:IsHidden() return true end
function modifier_item_alchemist_gold_cuirass_passive:IsPurgable() return false end
function modifier_item_alchemist_gold_cuirass_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_alchemist_gold_cuirass_passive:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability:GetSpecialValueFor("chain_damage")
self.radius = self.ability:GetSpecialValueFor("chain_radius")
self.max = self.ability:GetSpecialValueFor("chain_strikes")
self.interval = self.ability:GetSpecialValueFor("chain_delay")

self.duration = self.ability:GetSpecialValueFor("slow_duration")

self.damageTable = {attacker = self.parent, ability = self.ability, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, damage = self.damage}
if not IsServer() then return end

if self.parent:HasModifier("modifier_item_alchemist_gold_cuirass_shield") then
    self.parent:GenericHeal(self.parent:GetMaxHealth()*self.ability:GetSpecialValueFor("proc_heal")/100, self.ability)
end

self.last_target = self.parent
if table.target then
    self.first_target = EntIndexToHScript(table.target)
end
self.targets = {}

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_item_alchemist_gold_cuirass_passive:OnIntervalThink()
if not IsServer() then return end

local pos = self.last_target:GetAbsOrigin()
if self.first_target then
    pos = self.first_target:GetAbsOrigin()
    self.first_target = nil
end

local targets = self.parent:FindTargets(self.radius, pos)
local new_unit = nil

for _,target in pairs(targets) do
    if not self.targets[target:entindex()] then
        self.targets[target:entindex()] = true
        new_unit = target
        break
    end
end

if not new_unit then
    self:Destroy()
    return
end

self.damageTable.victim = new_unit

if self.last_target and not self.last_target:IsNull() then
    local nParticleIndex = ParticleManager:CreateParticle("particles/econ/events/ti10/maelstrom_ti10.vpcf", PATTACH_POINT_FOLLOW, self.last_target)
    ParticleManager:SetParticleControlEnt(nParticleIndex, 0, self.last_target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.last_target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(nParticleIndex, 1, new_unit, PATTACH_POINT_FOLLOW, "attach_hitloc", new_unit:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(nParticleIndex)
end

if self:GetStackCount() > 0 then
    new_unit:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
end

if self.parent:HasModifier("modifier_item_alchemist_gold_cuirass_shield") then
	new_unit:AddNewModifier(self.parent, self.ability, "modifier_item_alchemist_gold_cuirass_shield_slow", {duration = self.duration})
end

DoDamage(self.damageTable)
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
    self:Destroy()
    return
end

self.last_target = new_unit
end

modifier_item_alchemist_gold_cuirass_shield_cd = class(mod_hidden)
modifier_item_alchemist_gold_cuirass_proc = class(mod_hidden)
modifier_item_alchemist_gold_cuirass_cd = class(mod_hidden)


