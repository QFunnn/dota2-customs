--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_mirror_shield_custom", "abilities/items/neutral/item_mirror_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_mirror_shield_custom_status", "abilities/items/neutral/item_mirror_shield_custom", LUA_MODIFIER_MOTION_NONE)

item_mirror_shield_custom = class({})

function item_mirror_shield_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_mirror_shield_custom"
end



modifier_item_mirror_shield_custom = class({})
function modifier_item_mirror_shield_custom:IsHidden() return true end
function modifier_item_mirror_shield_custom:IsPurgable() return false end
function modifier_item_mirror_shield_custom:RemoveOnDeath() return false end
function modifier_item_mirror_shield_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.duration = self.ability:GetSpecialValueFor("duration")
self.cd = self.ability:GetSpecialValueFor("cd")
end

function modifier_item_mirror_shield_custom:DeclareFunctions()
return
{
   MODIFIER_PROPERTY_ABSORB_SPELL
}
end


function modifier_item_mirror_shield_custom:GetAbsorbSpell(params)
if not IsServer() then return end
if self.parent:IsIllusion() then return end
if self.parent:HasModifier("modifier_antimage_counterspell_custom_active") then return 0 end
if self.parent:IsInvulnerable() then return end
if not self.ability:IsFullyCastable() then return 0 end

local attacker = params.ability:GetCaster()

if not attacker then return end
if attacker:IsCreep() then return end
if attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return 0 end

local particle = ParticleManager:CreateParticle("particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

particle = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_mirror_shield_custom_status", {duration = self.duration})

self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
self.parent:EmitSound("Item.LotusOrb.Activate")
self.ability:StartCooldown(self.cd)
return 1 
end


modifier_item_mirror_shield_custom_status = class(mod_hidden)
function modifier_item_mirror_shield_custom_status:GetEffectName() return "particles/puck/orb_status.vpcf" end
function modifier_item_mirror_shield_custom_status:OnCreated()
self.status = self:GetAbility():GetSpecialValueFor("status")
end

function modifier_item_mirror_shield_custom_status:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_item_mirror_shield_custom_status:GetModifierStatusResistanceStacking() 
return self.status
end

function modifier_item_mirror_shield_custom_status:GetStatusEffectName()
return "particles/units/heroes/hero_kez/status_effect_kez_afterimage_buff.vpcf"
end
 
function modifier_item_mirror_shield_custom_status:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH
end