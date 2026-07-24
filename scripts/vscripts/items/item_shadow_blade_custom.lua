--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_shadow_blade_custom_active", "items/item_shadow_blade_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_shadow_blade_custom_passive", "items/item_shadow_blade_custom", LUA_MODIFIER_MOTION_NONE)

item_shadow_blade_custom = class({})

function item_shadow_blade_custom:GetIntrinsicModifierName() 
    return "modifier_item_shadow_blade_custom_passive"
end

function item_shadow_blade_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("DOTA_Item.InvisibilitySword.Activate")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_shadow_blade_custom_active", {duration = self:GetSpecialValueFor("duration")})
end

modifier_item_shadow_blade_custom_passive = class({})

function modifier_item_shadow_blade_custom_passive:IsHidden() return true end

function modifier_item_shadow_blade_custom_passive:IsPurgable() return false end
function modifier_item_shadow_blade_custom_passive:IsPurgeException() return false end

function modifier_item_shadow_blade_custom_passive:RemoveOnDeath() return false end

function modifier_item_shadow_blade_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_shadow_blade_custom_passive:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_item_shadow_blade_custom_passive:GetModifierPreAttack_BonusDamage() return
    self:GetAbility():GetSpecialValueFor("bonus_damage")
end


function modifier_item_shadow_blade_custom_passive:GetModifierAttackSpeedBonus_Constant() return
    self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end


modifier_item_shadow_blade_custom_active = class({})

function modifier_item_shadow_blade_custom_active:IsHidden()     return false end
function modifier_item_shadow_blade_custom_active:IsPurgable()   return false end

function modifier_item_shadow_blade_custom_active:OnCreated(table)
    self.speed = self:GetAbility():GetSpecialValueFor("movement_speed")
    self.damage = self:GetAbility():GetSpecialValueFor("windwalk_bonus_damage")
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/econ/courier/courier_trail_international_2014/courier_international_2014.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_item_shadow_blade_custom_active:CheckState() 
  return 
  {
      [MODIFIER_STATE_NO_UNIT_COLLISION] = true
  }
end

function modifier_item_shadow_blade_custom_active:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
    }
end

function modifier_item_shadow_blade_custom_active:GetModifierMoveSpeedBonus_Percentage() return self.speed end

function modifier_item_shadow_blade_custom_active:GetModifierProcAttack_BonusDamage_Physical(params)
    if params.attacker == self:GetParent() then 
        self:Destroy()
        return self.damage
    end
end