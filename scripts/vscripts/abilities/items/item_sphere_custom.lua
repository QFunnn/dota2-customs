--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("item_sphere_custom_passive", "abilities/items/item_sphere_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("item_sphere_custom_status", "abilities/items/item_sphere_custom", LUA_MODIFIER_MOTION_NONE)


item_sphere_custom = class({})

function item_sphere_custom:GetIntrinsicModifierName() 
return "item_sphere_custom_passive"
end

function item_sphere_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/immunity_sphere.vpcf", context )
PrecacheResource( "particle","particles/puck/orb_status.vpcf" , context )
end

function item_sphere_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level )/self:GetCaster():GetCooldownReduction()
end

item_sphere_custom_passive = class(mod_hidden)
function item_sphere_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function item_sphere_custom_passive:RemoveOnDeath() return false end
function item_sphere_custom_passive:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,

    MODIFIER_PROPERTY_ABSORB_SPELL
}
end

function item_sphere_custom_passive:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_all_stats = self.ability:GetSpecialValueFor("bonus_all_stats")      
self.bonus_health_regen = self.ability:GetSpecialValueFor("bonus_health_regen")
self.bonus_mana_regen = self.ability:GetSpecialValueFor("bonus_mana_regen")  
self.block_cooldown = self.ability:GetSpecialValueFor("block_cooldown")             
self.status_duration = self.ability:GetSpecialValueFor("status_duration")  
   
self.ability.status_bonus = self.ability:GetSpecialValueFor("status_bonus")    
end


function item_sphere_custom_passive:GetModifierBonusStats_Agility() 
return self.bonus_all_stats
end

function item_sphere_custom_passive:GetModifierBonusStats_Strength()
return self.bonus_all_stats
end

function item_sphere_custom_passive:GetModifierBonusStats_Intellect()
return self.bonus_all_stats
end

function item_sphere_custom_passive:GetModifierConstantManaRegen() 
return self.bonus_mana_regen
end

function item_sphere_custom_passive:GetModifierConstantHealthRegen()
return self.bonus_health_regen
end

function item_sphere_custom_passive:GetAbsorbSpell(params)
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

self.parent:AddNewModifier(self.parent, self.ability, "item_sphere_custom_status", {duration = self.status_duration})

self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
self.ability:StartCooldown(self.block_cooldown)
return 1 
end



item_sphere_custom_status = class(mod_visible)
function item_sphere_custom_status:GetEffectName() return "particles/puck/orb_status.vpcf" end
function item_sphere_custom_status:OnCreated()
self.status = self:GetAbility().status_bonus
end

function item_sphere_custom_status:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function item_sphere_custom_status:GetModifierStatusResistanceStacking() 
return self.status
end

function item_sphere_custom_status:GetStatusEffectName()
return "particles/units/heroes/hero_kez/status_effect_kez_afterimage_buff.vpcf"
end
 
function item_sphere_custom_status:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH
end