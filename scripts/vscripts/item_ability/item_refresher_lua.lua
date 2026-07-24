--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_refresher_lua = class({})
LinkLuaModifier("modifier_item_refresher_lua", "item_ability/item_refresher_lua", LUA_MODIFIER_MOTION_NONE)
function item_refresher_lua:GetIntrinsicModifierName()
	return "modifier_item_refresher_lua"
end
function item_refresher_lua:OnSpellStart()
	local hCaster = self:GetCaster()

	for i = 0, hCaster:GetAbilityCount() - 1 do
		local hAbility = hCaster:GetAbilityByIndex(i)
		if IsValid(hAbility) then
			if hAbility:IsRefreshable() then
				hAbility:RefreshCharges()
				hAbility:EndCooldown()
			end
		end
	end

	for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_NEUTRAL_SLOT do
		local hItem = hCaster:GetItemInSlot(i)
		if IsValid(hItem) and (hItem:IsRefreshable() or hItem:GetAbilityName() == "item_hand_of_midas_lua") then
			hItem:EndCooldown()
		end
	end

end
function item_refresher_lua:IsRefreshable()
	return false
end
--=================================modifier_item_hand_of_midas_lua-----------------
modifier_item_refresher_lua = class({})
function modifier_item_refresher_lua:IsDebuff()
	return false
end
function modifier_item_refresher_lua:IsHidden()
	return true
end
function modifier_item_refresher_lua:RemoveOnDeath()
	return false
end
function modifier_item_refresher_lua:OnCreated(data)
	self.bonus_health_regen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
end
function modifier_item_refresher_lua:OnRefresh(data)
	self.bonus_health_regen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
end
function modifier_item_refresher_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end
function modifier_item_refresher_lua:GetModifierConstantHealthRegen()
	return self.bonus_health_regen
end
function modifier_item_refresher_lua:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end
function modifier_item_refresher_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_refresher_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end