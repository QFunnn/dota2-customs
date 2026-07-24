--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_kobold_cup_custom", "abilities/items/neutral/item_kobold_cup_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_kobold_cup_custom_movespeed", "abilities/items/neutral/item_kobold_cup_custom", LUA_MODIFIER_MOTION_NONE)

item_kobold_cup_custom = class({})

function item_kobold_cup_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items5_fx/kobold_cup.vpcf", context )

end


function item_kobold_cup_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("item_kobold_cup.activate")
caster:RemoveModifierByName("modifier_item_kobold_cup_custom")
caster:AddNewModifier(caster, self, "modifier_item_kobold_cup_custom", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_kobold_cup_custom = class(mod_visible)
function modifier_item_kobold_cup_custom:IsAura() return true end
function modifier_item_kobold_cup_custom:GetAuraDuration() return 0 end
function modifier_item_kobold_cup_custom:GetAuraRadius() return self.radius end
function modifier_item_kobold_cup_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_item_kobold_cup_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_item_kobold_cup_custom:GetModifierAura() return "modifier_item_kobold_cup_custom_movespeed" end
function modifier_item_kobold_cup_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.radius = self.ability:GetSpecialValueFor("radius")
self.linger = self.ability:GetSpecialValueFor("linger")
self.parent:AddAttackEvent_inc(self, true)
end

function modifier_item_kobold_cup_custom:AttackEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.target then return end
if self.ended then return end
self.ended = true
self:SetDuration(self.linger, true)
end


modifier_item_kobold_cup_custom_movespeed = class(mod_hidden)
function modifier_item_kobold_cup_custom_movespeed:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.movespeed = self.ability:GetSpecialValueFor("movespeed")
self.evasion = self.ability:GetSpecialValueFor("evasion")

if not IsServer() then return end
self.parent:GenericParticle("particles/items5_fx/kobold_cup.vpcf", self)
end

function modifier_item_kobold_cup_custom_movespeed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_EVASION_CONSTANT
}
end

function modifier_item_kobold_cup_custom_movespeed:GetModifierMoveSpeedBonus_Percentage()
return self.movespeed
end

function modifier_item_kobold_cup_custom_movespeed:GetModifierEvasion_Constant()
return self.evasion
end