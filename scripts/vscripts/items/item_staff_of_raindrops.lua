--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_staff_of_raindrops", "items/item_staff_of_raindrops", LUA_MODIFIER_MOTION_NONE)

item_staff_of_raindrops = class({})

function item_staff_of_raindrops:GetIntrinsicModifierName()
	return "modifier_item_staff_of_raindrops"
end

modifier_item_staff_of_raindrops = class({})

function modifier_item_staff_of_raindrops:IsHidden() return true end
function modifier_item_staff_of_raindrops:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_item_staff_of_raindrops:IsPurgable() return false end
function modifier_item_staff_of_raindrops:IsPurgeException() return false end

function modifier_item_staff_of_raindrops:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
        MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_item_staff_of_raindrops:GetModifierTotalPercentageManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_item_staff_of_raindrops:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_str")
end

function modifier_item_staff_of_raindrops:GetModifierBonusStats_Agility()
    return self:GetAbility():GetSpecialValueFor("bonus_agi")
end

function modifier_item_staff_of_raindrops:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_staff_of_raindrops:GetModifierExtraManaPercentage()
    return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_staff_of_raindrops:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end
function modifier_item_staff_of_raindrops:GetModifierHealthBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_health")
end


function modifier_item_staff_of_raindrops:GetModifierTotal_ConstantBlock(params)
    if not IsServer() then return end
    
    if self:GetParent() == params.attacker then return end

 	if not self:GetAbility():IsFullyCastable() then return end
    
    if self:GetParent():FindAllModifiersByName("modifier_item_staff_of_raindrops")[1] ~= self then return end

    if params.damage < self:GetAbility():GetSpecialValueFor("damage_block_start") then return end

    if self:GetParent():IsIllusion() then return end

    self:GetAbility():UseResources(false, false, false, true)

    self:GetParent():EmitSound("DOTA_Item.InfusedRaindrop")

    SendOverheadEventMessage(self:GetParent(), OVERHEAD_ALERT_MAGICAL_BLOCK, self:GetParent(), self:GetAbility():GetSpecialValueFor("damage_block_magical"), nil)

    return self:GetAbility():GetSpecialValueFor("damage_block_magical")
end