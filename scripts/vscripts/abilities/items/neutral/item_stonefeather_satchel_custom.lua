--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_stonefeather_satchel_custom", "abilities/items/neutral/item_stonefeather_satchel_custom", LUA_MODIFIER_MOTION_NONE)

item_stonefeather_satchel_custom = class({})

function item_stonefeather_satchel_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items7_fx/archimedes_satchel.vpcf", context )
PrecacheResource( "particle", "particles/items7_fx/archimedes_satchel_speed.vpcf", context )

end

function item_stonefeather_satchel_custom:GetIntrinsicModifierName()
return "modifier_item_stonefeather_satchel_custom"
end

function item_stonefeather_satchel_custom:GetAbilityTextureName()
if IsValid(self.tracker) and self.tracker:GetStackCount() == 1 then
    return "item_stonefeather_satchel_rocks"
end
return "stonefeather_satchel_feathers"
end

function item_stonefeather_satchel_custom:OnSpellStart()
local caster = self:GetCaster()
if self.tracker then
    self.tracker:ChangeState()
end

end

modifier_item_stonefeather_satchel_custom = class(mod_hidden)
function modifier_item_stonefeather_satchel_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self

self.speed = self.ability:GetSpecialValueFor("feather_movespeed")
self.armor = self.ability:GetSpecialValueFor("rocks_armor")
if not IsServer() then return end
self:SetStackCount(1)
self:ChangeState() 
end

function modifier_item_stonefeather_satchel_custom:ChangeState()
if not IsServer() then return end
local effect
local sound

if self:GetStackCount() == 0 then
    self:SetStackCount(1)
    effect = "particles/items7_fx/archimedes_satchel_armor.vpcf"
    sound = "item_stonefeather.armor"
else
    effect = "particles/items7_fx/archimedes_satchel_speed.vpcf"
    sound = "item_stonefeather.speed"
    self:SetStackCount(0)
end
self.parent:GenericParticle(effect, self)
self.parent:EmitSound(sound)
end

function modifier_item_stonefeather_satchel_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_item_stonefeather_satchel_custom:GetModifierMoveSpeedBonus_Constant()
if self:GetStackCount() == 1 then return end
return self.speed
end

function modifier_item_stonefeather_satchel_custom:GetModifierPhysicalArmorBonus()
if self:GetStackCount() == 0 then return end
return self.armor
end



