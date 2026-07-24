--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_echo_sabre_custom", "abilities/items/item_echo_sabre_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_echo_sabre_custom_speed", "abilities/items/item_echo_sabre_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_echo_sabre_custom_slow", "abilities/items/item_echo_sabre_custom", LUA_MODIFIER_MOTION_NONE)

item_echo_sabre_custom = class({})

function item_echo_sabre_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

end

function item_echo_sabre_custom:GetIntrinsicModifierName()
return "modifier_item_echo_sabre_custom"
end


modifier_item_echo_sabre_custom = class(mod_hidden)
function modifier_item_echo_sabre_custom:RemoveOnDeath() return false end
function modifier_item_echo_sabre_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
}
end


function modifier_item_echo_sabre_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if self.parent:IsRealHero() and not self.parent:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then
    self.parent:AddAttackStartEvent_out(self)
end

self.regen = self.ability:GetSpecialValueFor("bonus_mana_regen")
self.damage = self.ability:GetSpecialValueFor("bonus_damage")
self.str = self.ability:GetSpecialValueFor("bonus_strength")
self.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
end 


function modifier_item_echo_sabre_custom:StartSpeed(target, slow)
if not IsServer() then return end
if not self.parent:IsRealHero() then return end
if self.parent:HasModifier("modifier_marci_unleash_custom") then return end

self.ability:UseResources(false, false, false, true)
self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_echo_sabre_custom_speed", {})

if self.ability and target:IsUnit() and slow then 
    target:AddNewModifier(self:GetCaster(), self.ability, "modifier_item_echo_sabre_custom_slow", {duration = (1 - target:GetStatusResistance())*self.slow_duration})
end

end


function modifier_item_echo_sabre_custom:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if params.no_attack_cooldown then return end

local mod = self.parent:FindModifierByName("modifier_item_echo_sabre_custom_speed")
if mod then 
    params.target:AddNewModifier(self.parent, self.ability, "modifier_item_echo_sabre_custom_slow", {duration = (1 - params.target:GetStatusResistance())*self.slow_duration})
    mod:Destroy()
end 

if self.parent:HasModifier("modifier_item_harpoon_custom") then return end
if not self.ability:IsFullyCastable() then return end
if self.parent:IsRangedAttacker() then return end

self:StartSpeed(params.target, true)
end

function modifier_item_echo_sabre_custom:GetModifierConstantManaRegen()
return self.regen
end

function modifier_item_echo_sabre_custom:GetModifierPreAttack_BonusDamage()
return self.damage
end

function modifier_item_echo_sabre_custom:GetModifierBonusStats_Strength()
return self.str 
end




modifier_item_echo_sabre_custom_speed = class({})
function modifier_item_echo_sabre_custom_speed:IsHidden() return true end
function modifier_item_echo_sabre_custom_speed:IsPurgable() return false end
function modifier_item_echo_sabre_custom_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_item_echo_sabre_custom_speed:GetModifierAttackSpeedBonus_Constant(params)
if not params.target then return end
return self.speed
end

function modifier_item_echo_sabre_custom_speed:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.name = self.ability:GetName()

self.speed = self.ability:GetSpecialValueFor("speed")
if not IsServer() then return end
self:StartIntervalThink(0.2)
end

function modifier_item_echo_sabre_custom_speed:OnIntervalThink()
if not IsServer() then return end

local item = self.parent:FindItemInInventory(self.name)

if not item or item:IsInBackpack() or self.parent:IsRangedAttacker() or not self.ability then 
    self:Destroy()
end

end


modifier_item_echo_sabre_custom_slow = class({})
function modifier_item_echo_sabre_custom_slow:IsHidden() return false end
function modifier_item_echo_sabre_custom_slow:IsPurgable() return true end
function modifier_item_echo_sabre_custom_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_echo_sabre_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return -100
end
