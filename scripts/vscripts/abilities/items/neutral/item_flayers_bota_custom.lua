--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_flayers_bota_custom", "abilities/items/neutral/item_flayers_bota_custom", LUA_MODIFIER_MOTION_NONE)

item_flayers_bota_custom = class({})

function item_flayers_bota_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items6_fx/flayers_bota.vpcf", context )

end


function item_flayers_bota_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("item_flayers_bota")

local cost = caster:GetHealth()*self:GetSpecialValueFor("cost")/100
caster:SetHealth(math.max(1, caster:GetHealth() - cost))

caster:AddNewModifier(caster, self, "modifier_item_flayers_bota_custom", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_flayers_bota_custom = class(mod_visible)
function modifier_item_flayers_bota_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability:GetSpecialValueFor("damage")
self.speed = self.ability:GetSpecialValueFor("speed")

if not IsServer() then return end
self.parent:GenericParticle("particles/items6_fx/flayers_bota.vpcf", self)
end

function modifier_item_flayers_bota_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_item_flayers_bota_custom:GetModifierBaseDamageOutgoing_Percentage()
return self.damage
end

function modifier_item_flayers_bota_custom:GetModifierAttackSpeedBonus_Constant()
return self.speed
end



