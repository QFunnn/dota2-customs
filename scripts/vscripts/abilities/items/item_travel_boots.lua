--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_travel_boots_custom", "abilities/items/item_travel_boots", LUA_MODIFIER_MOTION_NONE)
item_travel_boots_custom = class({})

function item_travel_boots_custom:GetIntrinsicModifierName()
return "modifier_item_travel_boots_custom"
end

function item_travel_boots_custom:GetAbilityTextureName()
if not self or not self:GetCaster() then return end 
return wearables_system:GetAbilityIconReplacement(self.caster, "item_travel_boots", self)
end



modifier_item_travel_boots_custom = class({})
function modifier_item_travel_boots_custom:IsHidden() return true end
function modifier_item_travel_boots_custom:IsPurgable() return false end

function modifier_item_travel_boots_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
}
end

function modifier_item_travel_boots_custom:GetModifierMoveSpeedBonus_Special_Boots() 
return self.speed
end


function modifier_item_travel_boots_custom:OnCreated(table)
self.speed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end


---------------------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_travel_boots_2_custom", "abilities/items/item_travel_boots", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_travel_boots_2_perma", "abilities/items/item_travel_boots", LUA_MODIFIER_MOTION_NONE)

item_travel_boots_2_custom = class({})

function item_travel_boots_2_custom:GetIntrinsicModifierName()
return "modifier_item_travel_boots_2_custom"
end

function item_travel_boots_2_custom:OnAbilityPhaseStart()
if not IsServer() then return end
if self:GetCaster():HasModifier("modifier_item_travel_boots_2_perma") then 
     CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#essence_speed"})
    return false
end
return true
end


function item_travel_boots_2_custom:OnSpellStart()
local caster = self:GetCaster()

if caster:HasModifier("modifier_item_travel_boots_2_perma") then return end

caster:EmitSound("Item.MoonShard.Consume")
caster:AddNewModifier(caster, self, "modifier_item_travel_boots_2_perma", {})
self:Destroy()
end



modifier_item_travel_boots_2_custom = class({})
function modifier_item_travel_boots_2_custom:IsHidden() return true end
function modifier_item_travel_boots_2_custom:IsPurgable() return false end

function modifier_item_travel_boots_2_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
}
end

function modifier_item_travel_boots_2_custom:GetModifierMoveSpeedBonus_Special_Boots() 
return self.speed
end

function modifier_item_travel_boots_2_custom:OnCreated(table)
self.speed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end





modifier_item_travel_boots_2_perma = class({})
function modifier_item_travel_boots_2_perma:IsHidden() return false end
function modifier_item_travel_boots_2_perma:IsPurgable() return false end
function modifier_item_travel_boots_2_perma:GetTexture() return "item_travel_boots_2" end
function modifier_item_travel_boots_2_perma:RemoveOnDeath() return false end
function modifier_item_travel_boots_2_perma:OnCreated(table)

self.StackOnIllusion = true 
if not self:GetAbility()  then 
    self.speed = 50
else 
    self.speed = self:GetAbility():GetSpecialValueFor("perma_bonus")
end

end


function modifier_item_travel_boots_2_perma:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE
}
end

function modifier_item_travel_boots_2_perma:GetModifierMoveSpeedBonus_Special_Boots()
return self.speed
end