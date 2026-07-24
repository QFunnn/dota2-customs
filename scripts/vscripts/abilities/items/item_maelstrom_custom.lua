--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_maelstrom_custom", "abilities/items/item_maelstrom_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_maelstrom_custom_proc", "abilities/items/item_maelstrom_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_maelstrom_custom_passive", "abilities/items/item_maelstrom_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_maelstrom_custom_cd", "abilities/items/item_maelstrom_custom", LUA_MODIFIER_MOTION_NONE)

item_maelstrom_custom = class({})

function item_maelstrom_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/chain_lightning.vpcf", context ) 
end

function item_maelstrom_custom:GetIntrinsicModifierName()
return "modifier_item_maelstrom_custom"
end

modifier_item_maelstrom_custom = class(mod_hidden)
function modifier_item_maelstrom_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_maelstrom_custom:GetModifierPreAttack_BonusDamage()
return self.ability.bonus_damage
end

function modifier_item_maelstrom_custom:GetModifierAttackSpeedBonus_Constant()
return self.ability.bonus_attack_speed
end

function modifier_item_maelstrom_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_maelstrom_custom:CheckState()
if not IsValid(self.parent) then return end
if not self.parent:HasModifier("modifier_item_maelstrom_custom_proc") then return end 
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_item_maelstrom_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
self.ability.bonus_attack_speed = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.ability.chain_chance = self.ability:GetSpecialValueFor("chain_chance")
self.ability.chain_damage = self.ability:GetSpecialValueFor("chain_damage")
self.ability.chain_strikes = self.ability:GetSpecialValueFor("chain_strikes")
self.ability.chain_heal = self.ability:GetSpecialValueFor("chain_heal")
self.ability.chain_radius = self.ability:GetSpecialValueFor("chain_radius")
self.ability.chain_delay = self.ability:GetSpecialValueFor("chain_delay")
self.ability.chain_cooldown = self.ability:GetSpecialValueFor("chain_cooldown")
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.records = {}

if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self:RollProc()

self.parent:AddRecordDestroyEvent(self, true)
self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackEvent_out(self, true)
end

function modifier_item_maelstrom_custom:RecordDestroyEvent( params )
if not self.records[params.record] then return end
self.records[params.record] = nil
end

function modifier_item_maelstrom_custom:RollProc()
if not IsServer() then return end
if self.parent:HasModifier("modifier_item_mjollnir_custom") then return end
if self.parent:HasModifier("modifier_item_maelstrom_custom_cd") then return end
if not RollPseudoRandomPercentage(self.ability.chain_chance, 4259, self.parent) then return end 

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_maelstrom_custom_proc", {duration = 3})
end

function modifier_item_maelstrom_custom:AttackStartEvent_out(params)
if not IsServer() then return end 
if not params.target:IsUnit() then return end 
if self.parent ~= params.attacker then return end 

if self.parent:HasModifier("modifier_item_maelstrom_custom_proc") then 
    self.records[params.record] = true
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_maelstrom_custom_cd", {duration = self.ability.chain_cooldown})
end

self.parent:RemoveModifierByName("modifier_item_maelstrom_custom_proc")
self:RollProc()
end

function modifier_item_maelstrom_custom:AttackEvent_out(params)
if not IsServer() then return end 
if not params.target:IsUnit() then return end 
if self.parent ~= params.attacker then return end 
if not self.records[params.record] then return end

self.parent:GenericHeal(self.ability.chain_heal, self.ability, true, "")

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_maelstrom_custom_passive", {target = params.target:entindex()})
params.target:EmitSound("Item.Maelstrom.Chain_Lightning")
end

modifier_item_maelstrom_custom_passive = class(mod_hidden)
function modifier_item_maelstrom_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_maelstrom_custom_passive:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability.chain_radius
self.max = self.ability.chain_strikes
self.interval = self.ability.chain_delay

if not IsServer() then return end

self.last_target = self.parent
if table.target then
    self.first_target = EntIndexToHScript(table.target)
end
self.targets = {}

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_item_maelstrom_custom_passive:OnIntervalThink()
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

local player_id = self.parent:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_mjollnir")
local default_effect = "particles/items_fx/chain_lightning.vpcf"
if custom_effect_data then
    default_effect = custom_effect_data[2]
end

if self.last_target and not self.last_target:IsNull() then
    local nParticleIndex = ParticleManager:CreateParticle(default_effect, PATTACH_POINT_FOLLOW, self.last_target)
    ParticleManager:SetParticleControlEnt(nParticleIndex, 0, self.last_target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.last_target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(nParticleIndex, 1, new_unit, PATTACH_POINT_FOLLOW, "attach_hitloc", new_unit:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(nParticleIndex)
end

if self:GetStackCount() > 0 then
    new_unit:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
end

if IsValid(self.ability) then
    DoDamage({attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = self.ability.chain_damage, victim = new_unit})
end

self:IncrementStackCount()

if self:GetStackCount() >= self.max then
    self:Destroy()
    return
end

self.last_target = new_unit
end

modifier_item_maelstrom_custom_proc = class(mod_hidden)
modifier_item_maelstrom_custom_cd = class(mod_hidden)