--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_sisters_shroud_custom", "abilities/items/neutral/item_sisters_shroud_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_sisters_shroud_custom_evasion", "abilities/items/neutral/item_sisters_shroud_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_sisters_shroud_custom_blocked", "abilities/items/neutral/item_sisters_shroud_custom", LUA_MODIFIER_MOTION_NONE)

item_sisters_shroud_custom = class({})

function item_sisters_shroud_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_sisters_shroud_custom"
end

function item_sisters_shroud_custom:GetAbilityTextureName()
if not self or not self:GetCaster() then return end 
if self:GetCaster():HasModifier("modifier_item_sisters_shroud_custom_blocked") then
    return "items/item_sisters_shroud_active"
end
return "item_sisters_shroud"
end



modifier_item_sisters_shroud_custom = class(mod_hidden)
function modifier_item_sisters_shroud_custom:RemoveOnDeath() return false end
function modifier_item_sisters_shroud_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.health_threshold = self.ability:GetSpecialValueFor("hp_threshold")
self.duration = self.ability:GetSpecialValueFor("max_duration")

if not IsServer() then return end
self.parent:AddDamageEvent_inc(self, true)
end



function modifier_item_sisters_shroud_custom:DamageEvent_inc(params)
if not IsServer() then return end
if not self.ability or self.ability:IsNull() then return end
if self.parent:HasModifier("modifier_item_sisters_shroud_custom_blocked") then return end
if self.parent ~= params.unit then return end
if not params.attacker:IsHero() then return end
if not self.ability:IsFullyCastable() then return end
if self.parent:HasModifier("modifier_death") then return end
if not self.parent:IsAlive() then return end
if self.parent:GetHealthPercent() > self.health_threshold then return end

self.parent:RemoveModifierByName("modifier_item_sisters_shroud_custom_evasion")
self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_sisters_shroud_custom_evasion", {duration = self.duration})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_sisters_shroud_custom_blocked", {})
end



modifier_item_sisters_shroud_custom_evasion = class(mod_visible)
function modifier_item_sisters_shroud_custom_evasion:GetTexture() return "item_sisters_shroud" end
function modifier_item_sisters_shroud_custom_evasion:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.evasion = self.ability:GetSpecialValueFor("evasion")

if not IsServer() then return end

self.parent:AddAttackFailEvent_inc(self)

self:SetStackCount(self.ability:GetSpecialValueFor("attacks"))
self.parent:EmitSound("DOTA_Item.Butterfly")
self.parent:GenericParticle("particles/items4_fx/veiled_sisters_pall.vpcf", self)
end

function modifier_item_sisters_shroud_custom_evasion:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_EVASION_CONSTANT
}
end

function modifier_item_sisters_shroud_custom_evasion:GetModifierEvasion_Constant()
return self.evasion
end


function modifier_item_sisters_shroud_custom_evasion:AttackFailEvent_inc(params)
if not IsServer() then return end
if params.fail_type ~= 3 and params.fail_type ~= 2 then return end

self:DecrementStackCount()
if self:GetStackCount() <= 0 then
    self:Destroy()
    return
end

end


modifier_item_sisters_shroud_custom_blocked = class(mod_hidden)
function modifier_item_sisters_shroud_custom_blocked:OnCreated()
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
end

function modifier_item_sisters_shroud_custom_blocked:DeathEvent(params)
if not IsServer() then return end

local attacker = params.attacker
if attacker.owner then
    attacker = attacker.owner
end

if attacker ~= self.parent then return end
if not params.unit:IsRealHero() then return end

self:Destroy()
end