--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


item_refresher_2_lua = class({}) ---@class item_refresher_2_lua : CDOTA_Item_Lua

LinkLuaModifier("modifier_item_refresher_2_lua", "item_ability/item_refresher_2_lua", LUA_MODIFIER_MOTION_NONE)

local REFRESH_EXCEPTIONS = {
	item_ex_machina = true,
	item_ex_machina_custom = true,
	item_refresher = true,
	item_refresher_lua = true,
	item_refresher_2_lua = true,
	item_refresher_shard = true,
}

function item_refresher_2_lua:GetIntrinsicModifierName()
	return "modifier_item_refresher_2_lua"
end

function item_refresher_2_lua:OnSpellStart()
	local caster = self:GetCaster()

	EmitSoundOn("DOTA_Item.Refresher.Activate", caster)
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)

	for index = 0, caster:GetAbilityCount() - 1 do
		local ability = caster:GetAbilityByIndex(index)
		if IsValid(ability) and ability:IsRefreshable() then
			ability:RefreshCharges()
			ability:EndCooldown()
		end
	end

	for slot = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_9 do
		local item = caster:GetItemInSlot(slot)
		if IsValid(item) then
			local itemName = item:GetAbilityName()
			if not REFRESH_EXCEPTIONS[itemName] and itemName == "item_hand_of_midas_lua" then
				item:SetCurrentCharges(2)
				item:RefreshCharges()
				item:EndCooldown()
				item:MarkAbilityButtonDirty()
			elseif not REFRESH_EXCEPTIONS[itemName] and item:IsRefreshable() then
				item:RefreshCharges()
				item:EndCooldown()
			end
		end
	end

	local item = caster:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
	if IsValid(item) then
		local itemName = item:GetAbilityName()
		if not REFRESH_EXCEPTIONS[itemName] and item:IsRefreshable() then
			item:RefreshCharges()
			item:EndCooldown()
		end
	end
end

function item_refresher_2_lua:IsRefreshable()
	return false
end

modifier_item_refresher_2_lua = class({}) ---@class modifier_item_refresher_2_lua : CDOTA_Modifier_Lua

function modifier_item_refresher_2_lua:IsHidden()
	return true
end

function modifier_item_refresher_2_lua:IsDebuff()
	return false
end

function modifier_item_refresher_2_lua:IsPurgable()
	return false
end

function modifier_item_refresher_2_lua:RemoveOnDeath()
	return false
end

function modifier_item_refresher_2_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_refresher_2_lua:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.bonusHealthRegen = ability:GetSpecialValueFor("bonus_health_regen")
	self.bonusManaRegen = ability:GetSpecialValueFor("bonus_mana_regen")
	self.bonusArmor = ability:GetSpecialValueFor("bonus_armor")
end

function modifier_item_refresher_2_lua:OnRefresh()
	self:OnCreated()
end

function modifier_item_refresher_2_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_refresher_2_lua:GetModifierConstantHealthRegen()
	return self.bonusHealthRegen
end

function modifier_item_refresher_2_lua:GetModifierConstantManaRegen()
	return self.bonusManaRegen
end

function modifier_item_refresher_2_lua:GetModifierPhysicalArmorBonus()
	return self.bonusArmor
end