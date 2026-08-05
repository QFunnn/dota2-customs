--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dark_mist_aura_self", "items/d_items/item_dark_mist", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dark_mist_aura_radius", "items/d_items/item_dark_mist", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dark_mist_active", "items/d_items/item_dark_mist", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_dark_mist = item_dark_mist or class({})
item_dark_mist2 = item_dark_mist or class({})
item_dark_mist3 = item_dark_mist or class({})
item_dark_mist4 = item_dark_mist or class({})
item_dark_mist5 = item_dark_mist or class({})

function item_dark_mist:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_dark_mist:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_dark_mist:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

function item_dark_mist:ProcsMagicStick()
	return false
end

function item_dark_mist:GetIntrinsicModifierName()
	return "modifier_item_dark_mist_aura_self"
end

function item_dark_mist:OnSpellStart()
	if IsServer() then
		EmitSoundOn("Item.CrimsonGuard.Cast", self:GetCaster())

		local nearby_allied_units = FindUnitsInRadius(
			self:GetCaster():GetTeam(),
			self:GetCaster():GetAbsOrigin(),
			self:GetCaster(),
			self:GetSpecialValueFor("aura_radius"),
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for i, nearby_ally in ipairs(nearby_allied_units) do
			nearby_ally:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_item_dark_mist_active",
				{ duration = self:GetSpecialValueFor("active_duration") }
			)
		end
	end
end

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

modifier_item_dark_mist_active = class({})

function modifier_item_dark_mist_active:IsHidden()
	return true
end

function modifier_item_dark_mist_active:IsPurgable()
	return false
end

function modifier_item_dark_mist_active:OnCreated(params)
	if IsServer() then
		self:GetParent():Purge(false, true, false, true, false)
	end
end

function modifier_item_dark_mist_active:GetEffectName()
	return "particles/avernos_mist.vpcf"
end

function modifier_item_dark_mist_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_dark_mist_active:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		MODIFIER_ATTRIBUTE_NONE,
	}

	return funcs
end

function modifier_item_dark_mist_active:GetModifierIncomingDamage_Percentage(params)
	return self:GetAbility():GetSpecialValueFor("incom_damage") * -1
end

function modifier_item_dark_mist_active:GetModifierHealthRegenPercentage(params)
	return self:GetAbility():GetSpecialValueFor("active_hp_regen")
end

function modifier_item_dark_mist_active:GetModifierTotalPercentageManaRegen(params)
	return self:GetAbility():GetSpecialValueFor("active_mana_regen")
end

--------------------------------------------------------------------------------------------------------------------

modifier_item_dark_mist_aura_self = class({})

function modifier_item_dark_mist_aura_self:IsHidden()
	return true
end

function modifier_item_dark_mist_aura_self:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_dark_mist_aura_self:GetModifierBonusStats_Intellect(params)
	local hAbility = self:GetAbility()
	return hAbility:GetSpecialValueFor("bonus_int")
end

function modifier_item_dark_mist_aura_self:GetModifierManaBonus(params)
	local hAbility = self:GetAbility()
	return hAbility:GetSpecialValueFor("bonus_mana")
end