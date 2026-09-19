--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


item_ex_machina_custom = class({}) ---@class item_ex_machina_custom : CDOTA_Item_Lua

LinkLuaModifier("modifier_item_ex_machina", "item_ability/item_ex_machina", LUA_MODIFIER_MOTION_NONE)

local REFRESH_EXCEPTIONS = {
	item_ex_machina = true,
	item_ex_machina_custom = true,
	item_refresher = true,
	item_refresher_lua = true,
	item_refresher_2_lua = true,
	item_refresher_shard = true,
}

function item_ex_machina_custom:GetIntrinsicModifierName()
	return "modifier_item_ex_machina"
end

function item_ex_machina_custom:OnSpellStart()
	local caster = self:GetCaster()

	EmitSoundOn("DOTA_Item.Refresher.Activate", caster)

	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)

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

function item_ex_machina_custom:IsRefreshable()
	return false
end

modifier_item_ex_machina = class({}) ---@class modifier_item_ex_machina : CDOTA_Modifier_Lua

function modifier_item_ex_machina:IsHidden()
	return true
end

function modifier_item_ex_machina:IsDebuff()
	return false
end

function modifier_item_ex_machina:IsPurgable()
	return false
end

function modifier_item_ex_machina:RemoveOnDeath()
	return false
end

function modifier_item_ex_machina:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_ex_machina:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.bonusArmor = ability:GetSpecialValueFor("bonus_armor")
end

function modifier_item_ex_machina:OnRefresh()
	self:OnCreated()
end

function modifier_item_ex_machina:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_ex_machina:GetModifierPhysicalArmorBonus()
	return self.bonusArmor
end