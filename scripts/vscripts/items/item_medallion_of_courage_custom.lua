--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_medallion_of_courage_custom", "items/item_medallion_of_courage_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_medallion_of_courage_custom_buff", "items/item_medallion_of_courage_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_medallion_of_courage_custom_debuff", "items/item_medallion_of_courage_custom.lua", LUA_MODIFIER_MOTION_NONE)

item_medallion_of_courage_custom = class({})

function item_medallion_of_courage_custom:GetIntrinsicModifierName()
	return "modifier_item_medallion_of_courage_custom"
end

function item_medallion_of_courage_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	   
    local target = self:GetCursorTarget()

    self:GetCaster():EmitSound("DOTA_Item.MedallionOfCourage.Activate")

    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        target:AddNewModifier(self:GetCaster(), self, "modifier_item_medallion_of_courage_custom_buff", {duration = duration})
    else
        target:AddNewModifier(self:GetCaster(), self, "modifier_item_medallion_of_courage_custom_debuff", {duration = duration * (1 - target:GetStatusResistance())})
    end
end

modifier_item_medallion_of_courage_custom = class({})

function modifier_item_medallion_of_courage_custom:IsHidden() return true end
function modifier_item_medallion_of_courage_custom:IsPurgable() return false end
function modifier_item_medallion_of_courage_custom:IsPurgeException() return false end
function modifier_item_medallion_of_courage_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_medallion_of_courage_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_item_medallion_of_courage_custom:GetModifierPhysicalArmorBonus()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_armor")
    end
end

function modifier_item_medallion_of_courage_custom:GetModifierConstantManaRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
    end
end

modifier_item_medallion_of_courage_custom_buff = class({})

function modifier_item_medallion_of_courage_custom_buff:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return decFuncs
end

function modifier_item_medallion_of_courage_custom_buff:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("armor_active")
end

function modifier_item_medallion_of_courage_custom_buff:GetEffectName()
    return "particles/items2_fx/medallion_of_courage_friend.vpcf" end

function modifier_item_medallion_of_courage_custom_buff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW end


modifier_item_medallion_of_courage_custom_debuff = class({})

function modifier_item_medallion_of_courage_custom_debuff:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return decFuncs
end

function modifier_item_medallion_of_courage_custom_debuff:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("armor_active") * -1
end

function modifier_item_medallion_of_courage_custom_debuff:GetEffectName()
    return "particles/items2_fx/medallion_of_courage.vpcf" end

function modifier_item_medallion_of_courage_custom_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW end