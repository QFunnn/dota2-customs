--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_mage_destroyer", "items/item_mage_destroyer", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_orchid_custom_active", "items/item_orchid_custom", LUA_MODIFIER_MOTION_NONE )

item_mage_destroyer = class({})

function item_mage_destroyer:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("silence_duration")
    local silence_damage_percent = self:GetSpecialValueFor("silence_damage_percent")
	local target = self:GetCursorTarget()
    if target:IsMagicImmune() then return end
    if target:TriggerSpellAbsorb(self) then return end
    target:EmitSound("DOTA_Item.Orchid.Activate")
	target:AddNewModifier(self:GetCaster(), self, "modifier_item_orchid_custom_active", {duration = duration * (1 - target:GetStatusResistance())})
end

function item_mage_destroyer:GetIntrinsicModifierName() 
    return "modifier_item_mage_destroyer"
end

modifier_item_mage_destroyer = class({})

function modifier_item_mage_destroyer:IsHidden()
    return true
end

function modifier_item_mage_destroyer:IsPurgable() return false end
function modifier_item_mage_destroyer:IsPurgeException() return false end

function modifier_item_mage_destroyer:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_mage_destroyer:DeclareFunctions()
    return  
    {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
         
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    }
end

function modifier_item_mage_destroyer:GetModifierPreAttack_BonusDamage()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_damage")
	end
end

function modifier_item_mage_destroyer:GetModifierConstantManaRegen()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor('bonus_mana_regen')
	end
end

function modifier_item_mage_destroyer:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
	end
end

function modifier_item_mage_destroyer:GetModifierAttackSpeedBonus_Constant()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	end
end

function modifier_item_mage_destroyer:GetModifierMagicalResistanceBonus()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("magical_resistance")
    end
end

function modifier_item_mage_destroyer:GetModifierConstantHealthRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
    end
end

function modifier_item_mage_destroyer:OnAttackLanded(params)
    if params.attacker == self:GetParent() then

        if params.target:IsOther() then
            return nil
        end

        if self:GetParent():IsIllusion() then
            return nil
        end

        params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_mage_slayer_debuff", {duration = (1 - params.target:GetStatusResistance())*self:GetAbility():GetSpecialValueFor("mage_slayer_duration")})
    end
end