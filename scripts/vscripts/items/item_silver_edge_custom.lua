--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_silver_edge_custom_active", "items/item_silver_edge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_silver_edge_custom_passive", "items/item_silver_edge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_silver_edge_custom_break", "items/item_silver_edge_custom", LUA_MODIFIER_MOTION_NONE)

item_silver_edge_custom = class({})

function item_silver_edge_custom:GetIntrinsicModifierName() 
    return "modifier_item_silver_edge_custom_passive"
end

function item_silver_edge_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("DOTA_Item.InvisibilitySword.Activate")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_silver_edge_custom_active", {duration = self:GetSpecialValueFor("duration")})
end

modifier_item_silver_edge_custom_active = class({})

function modifier_item_silver_edge_custom_active:IsHidden() 
    return self:GetStackCount() > 0 
end

function modifier_item_silver_edge_custom_active:IsPurgable() return false end

function modifier_item_silver_edge_custom_active:OnCreated(table)
    self.speed = self:GetAbility():GetSpecialValueFor("movement_speed")
    self.damage = self:GetAbility():GetSpecialValueFor("windwalk_bonus_damage")
    self.proc = false
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/econ/courier/courier_trail_international_2014/courier_international_2014.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_item_silver_edge_custom_active:GetCritDamage() return self:GetAbility():GetSpecialValueFor( "crit_multiplier" ) end

function modifier_item_silver_edge_custom_active:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
    }
end

function modifier_item_silver_edge_custom_active:CheckState() 
    return 
    {
      [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
      [MODIFIER_STATE_CANNOT_MISS] = true
    }
end

function modifier_item_silver_edge_custom_active:GetModifierMoveSpeedBonus_Percentage() 
    if self.proc == true then return end	
    return self.speed 
end

function modifier_item_silver_edge_custom_active:OnAttack(params)
    if self:GetParent() ~= params.attacker then return end
    if self.proc == true then return end
    self.proc = true
    self.record = params.record
    self:SetStackCount(1) 
end

function modifier_item_silver_edge_custom_active:GetModifierProcAttack_BonusDamage_Physical(params)
    if params.attacker ~= self:GetParent() then return end
    if self.proc == false then return end
    if self.record ~= params.record then return end
    if params.target:IsMagicImmune() then return end
    params.target:EmitSound("DOTA_Item.SilverEdge.Target")
    params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_silver_edge_custom_break", {duration = (1 - params.target:GetStatusResistance())*self:GetAbility():GetSpecialValueFor("backstab_duration")})
    self:Destroy()
    return self.damage
end


modifier_item_silver_edge_custom_passive = class({})

function modifier_item_silver_edge_custom_passive:IsHidden() return true end

function modifier_item_silver_edge_custom_passive:IsPurgable() return false end
function modifier_item_silver_edge_custom_passive:IsPurgeException() return false end

function modifier_item_silver_edge_custom_passive:RemoveOnDeath() return false end

function modifier_item_silver_edge_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_silver_edge_custom_passive:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_item_silver_edge_custom_passive:GetModifierPreAttack_BonusDamage() return
    self:GetAbility():GetSpecialValueFor("bonus_damage")
end


function modifier_item_silver_edge_custom_passive:GetModifierAttackSpeedBonus_Constant() return
    self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

modifier_item_silver_edge_custom_break = class({})

function modifier_item_silver_edge_custom_break:IsHidden() return false end

function modifier_item_silver_edge_custom_break:IsPurgable() return false end

function modifier_item_silver_edge_custom_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end

function modifier_item_silver_edge_custom_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end

function modifier_item_silver_edge_custom_break:DeclareFunctions()
    return
    {
      MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_item_silver_edge_custom_break:OnCreated(table)
    self.speed = self:GetAbility():GetSpecialValueFor("move_slow")
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_break.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 1, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_item_silver_edge_custom_break:GetModifierMoveSpeedBonus_Percentage()
    return self.speed
end