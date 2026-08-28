--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_health_bag = class({})

function item_health_bag:GetIntrinsicModifierName()
	return "modifier_item_health_bag"
end

function item_health_bag:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local duration = self:GetSpecialValueFor("duration")
	EmitSoundOn("DOTA_Item.UrnOfShadows.Activate", self:GetCaster())
	target:AddNewModifier(caster, self, "modifier_item_health_bag_buff", { duration = duration })
end

-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_health_bag", "items/d_items/item_health_bag", LUA_MODIFIER_MOTION_NONE)

modifier_item_health_bag = class({})

function modifier_item_health_bag:IsHidden()
	return true
end

function modifier_item_health_bag:GetTexture()
	return "health_bag_2"
end

function modifier_item_health_bag:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_health_bag:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
end

function modifier_item_health_bag:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_item_health_bag:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("hp_regen")
end

function modifier_item_health_bag:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_health_bag:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_health_bag:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_health_bag_buff", "items/d_items/item_health_bag", LUA_MODIFIER_MOTION_NONE)

modifier_item_health_bag_buff = class({})

function modifier_item_health_bag_buff:GetEffectName()
	return "particles/items2_fx/urn_of_shadows_heal.vpcf"
end

function modifier_item_health_bag_buff:GetTexture()
	return "health_bag"
end

if IsServer() then
	function modifier_item_health_bag_buff:OnCreated()
		local ability = self:GetAbility()

		if not ability then
			self:Destroy()
			return
		end

		self.base_heal = ability:GetSpecialValueFor("base_heal")
		self.heal_pct = ability:GetSpecialValueFor("heal_pct") * 0.01

		local think_interval = ability:GetSpecialValueFor("heal_interval")
		self:StartIntervalThink(think_interval)
	end

	function modifier_item_health_bag_buff:OnIntervalThink()
		local ability = self:GetAbility()
		local parent = self:GetParent()

		if ability and parent then
			local heal_amount = self.base_heal + (parent:GetMaxHealth() * self.heal_pct)
			parent:Heal(heal_amount, self:GetCaster())
		end
	end
end