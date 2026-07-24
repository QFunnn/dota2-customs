--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_raindrop_ring", "items/item_raindrop_ring", LUA_MODIFIER_MOTION_NONE)

item_raindrop_ring = class({})

function item_raindrop_ring:GetIntrinsicModifierName()
	return "modifier_item_raindrop_ring"
end

modifier_item_raindrop_ring = class({})

function modifier_item_raindrop_ring:IsHidden() return true end
function modifier_item_raindrop_ring:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_raindrop_ring:IsPurgable() return false end
function modifier_item_raindrop_ring:IsPurgeException() return false end

function modifier_item_raindrop_ring:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
end

function modifier_item_raindrop_ring:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_raindrop_ring:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_item_raindrop_ring:GetModifierTotal_ConstantBlock(params)
    if not IsServer() then return end

    if self:GetParent() == params.attacker then return end

 	if not self:GetAbility():IsFullyCastable() then return end

 	if self:GetParent():FindItemInInventory("item_staff_of_raindrops") then
 		if self:GetParent():FindItemInInventory("item_staff_of_raindrops"):IsFullyCastable() then
 			return
 		end
 	end

 	if self:GetParent():FindAllModifiersByName("modifier_item_raindrop_ring")[1] ~= self then return end

    if params.damage_type ~= DAMAGE_TYPE_MAGICAL then return end

    if params.damage < self:GetAbility():GetSpecialValueFor("damage_block_start") then return end

    self:GetAbility():UseResources(false, false, false, true)

    self:GetParent():EmitSound("DOTA_Item.InfusedRaindrop")

    SendOverheadEventMessage(self:GetParent(), OVERHEAD_ALERT_MAGICAL_BLOCK, self:GetParent(), self:GetAbility():GetSpecialValueFor("damage_block_magical"), nil)

    return self:GetAbility():GetSpecialValueFor("damage_block_magical")
end