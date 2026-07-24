--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_essence_of_speed", "abilities/items/item_essence_of_speed", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_essence_of_speed_auto", "abilities/items/item_essence_of_speed", LUA_MODIFIER_MOTION_NONE)
item_essence_of_speed = class({})

function item_essence_of_speed:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_essence_of_speed_auto"
end

function item_essence_of_speed:OnAbilityPhaseStart()
if not IsServer() then return end
if self:GetCaster():HasModifier("modifier_item_essence_of_speed") then 
	 CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#essence_speed"})
   
	return false
end
return true
end

function item_essence_of_speed:OnSpellStart()
local caster = self:GetCaster()

if caster:HasModifier("modifier_item_essence_of_speed") then return end

caster:EmitSound("Item.MoonShard.Consume")
caster:AddNewModifier(caster, self, "modifier_item_essence_of_speed", {})
self:SpendCharge(0)
end


modifier_item_essence_of_speed_auto = class({})
function modifier_item_essence_of_speed_auto:IsHidden() return true end
function modifier_item_essence_of_speed_auto:IsPurgable() return false end
function modifier_item_essence_of_speed_auto:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self:StartIntervalThink(0.1)
self:OnIntervalThink()
end

function modifier_item_essence_of_speed_auto:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if not self.ability or self.ability:IsNull() then return end
if self.parent:HasModifier("modifier_item_essence_of_speed") then return end

self.ability:OnSpellStart()
end



modifier_item_essence_of_speed = class({})
function modifier_item_essence_of_speed:IsHidden() return false end
function modifier_item_essence_of_speed:IsPurgable() return false end
function modifier_item_essence_of_speed:GetTexture() return "items/essence_speed" end
function modifier_item_essence_of_speed:RemoveOnDeath() return false end
function modifier_item_essence_of_speed:OnCreated(table)

self.StackOnIllusion = true 
if not self:GetAbility()  then 
	self.speed = 50
else 
	self.speed = self:GetAbility():GetSpecialValueFor("speed_bonus")
end


end





function modifier_item_essence_of_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_item_essence_of_speed:GetModifierMoveSpeedBonus_Constant()
return self.speed
end