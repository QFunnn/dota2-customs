--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_orb_of_corrosion_custom", "abilities/items/item_orb_of_corrosion_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_corrosion_custom_active_slow", "abilities/items/item_orb_of_corrosion_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_corrosion_custom_passive_slow", "abilities/items/item_orb_of_corrosion_custom", LUA_MODIFIER_MOTION_NONE)

item_orb_of_corrosion_custom = class({})

function item_orb_of_corrosion_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/corrosion_custom.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_poison_dazzle.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf", context )
end

function item_orb_of_corrosion_custom:GetIntrinsicModifierName()
return "modifier_item_orb_of_corrosion_custom"
end

function item_orb_of_corrosion_custom:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("Item.Paintball.Cast")


local info = {
   Target = self:GetCursorTarget(),
   Source = self:GetCaster(),
   Ability = self, 
   EffectName = "particles/corrosion_custom.vpcf",
   iMoveSpeed = 900,
   bReplaceExisting = false,                         
   bProvidesVision = true,                           
   iVisionRadius = 30,        
   iVisionTeamNumber = self:GetCaster():GetTeamNumber()      
    }
ProjectileManager:CreateTrackingProjectile(info)


end


function item_orb_of_corrosion_custom:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if hTarget==nil then return end
if hTarget:IsInvulnerable() then return end
if hTarget:IsMagicImmune() then return end

hTarget:AddNewModifier(self:GetCaster(), self, "modifier_item_orb_of_corrosion_custom_active_slow", {duration = self:GetSpecialValueFor("duration")})
hTarget:EmitSound("Item.Paintball.Target")
hTarget:EmitSound("Corrosion.Target")

end



modifier_item_orb_of_corrosion_custom_active_slow = class({})
function modifier_item_orb_of_corrosion_custom_active_slow:IsHidden() return false end
function modifier_item_orb_of_corrosion_custom_active_slow:IsPurgable() return true end
function modifier_item_orb_of_corrosion_custom_active_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_poison_dazzle.vpcf"
end 

function modifier_item_orb_of_corrosion_custom_active_slow:GetEffectName()
return "particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf"
end 


function modifier_item_orb_of_corrosion_custom_active_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end

function modifier_item_orb_of_corrosion_custom_active_slow:OnCreated(table)
self.max_slow = self:GetAbility():GetSpecialValueFor("max_slow")
self.tick = self.max_slow/self:GetRemainingTime()
self.damage = self:GetAbility():GetSpecialValueFor("total_damage")/(self:GetAbility():GetSpecialValueFor("duration") + 1)
self.damageTable = { attacker = self:GetCaster(), victim = self:GetParent(), damage = self.damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility() }


if not IsServer() then return end
self:OnIntervalThink()
self:StartIntervalThink(1)
end

function modifier_item_orb_of_corrosion_custom_active_slow:OnIntervalThink()

DoDamage(self.damageTable)
SendOverheadEventMessage(self:GetParent(), 4, self:GetParent(), self.damage, nil)
self:IncrementStackCount()
end


function modifier_item_orb_of_corrosion_custom_active_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_item_orb_of_corrosion_custom_active_slow:GetModifierMoveSpeedBonus_Percentage()
return self.tick*self:GetStackCount()
end



modifier_item_orb_of_corrosion_custom_passive_slow = class({})
function modifier_item_orb_of_corrosion_custom_passive_slow:IsHidden() return false end
function modifier_item_orb_of_corrosion_custom_passive_slow:IsPurgable() return true end
function modifier_item_orb_of_corrosion_custom_passive_slow:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.slow = self.ability:GetSpecialValueFor("melee_slow")
if self.parent:IsRangedAttacker() then 
  self.slow = self.ability:GetSpecialValueFor("ranged_slow")
end

self.armor = self.ability:GetSpecialValueFor("armor_reduce") 
self.heal_reduction = self.ability:GetSpecialValueFor("heal_reduction")

end

function modifier_item_orb_of_corrosion_custom_passive_slow:OnRefresh(table)
self.slow = self.ability:GetSpecialValueFor("melee_slow")
if self.parent:IsRangedAttacker() then 
  self.slow = self.ability:GetSpecialValueFor("ranged_slow")
end

end


function modifier_item_orb_of_corrosion_custom_passive_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_item_orb_of_corrosion_custom_passive_slow:GetModifierPhysicalArmorBonus() 
return self.armor
end

function modifier_item_orb_of_corrosion_custom_passive_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_item_orb_of_corrosion_custom_passive_slow:GetModifierLifestealRegenAmplify_Percentage()
return self.heal_reduction
end

function modifier_item_orb_of_corrosion_custom_passive_slow:GetModifierHealChange()
return self.heal_reduction
end

function modifier_item_orb_of_corrosion_custom_passive_slow:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduction
end








modifier_item_orb_of_corrosion_custom = class({})
function modifier_item_orb_of_corrosion_custom:IsHidden() return true end
function modifier_item_orb_of_corrosion_custom:IsPurgable() return false end
function modifier_item_orb_of_corrosion_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATS_AGILITY_BONUS
}
end

function modifier_item_orb_of_corrosion_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddAttackEvent_out(self, true)
self.agility = self.ability:GetSpecialValueFor("agi_bonus")
self.duration = self.ability:GetSpecialValueFor("duration_passive")
end


function modifier_item_orb_of_corrosion_custom:GetModifierBonusStats_Agility()
return self.agility
end

function modifier_item_orb_of_corrosion_custom:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if self.parent:HasModifier("modifier_item_orb_of_venom") then return end

params.target:AddNewModifier(self.parent, self.ability, "modifier_item_orb_of_corrosion_custom_passive_slow", {duration = self.duration})

end

