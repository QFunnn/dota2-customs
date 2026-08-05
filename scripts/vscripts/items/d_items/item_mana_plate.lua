--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_mana_plate = item_mana_plate or class({})
item_mana_plate2 = item_mana_plate or class({})
item_mana_plate3 = item_mana_plate or class({})
item_mana_plate4 = item_mana_plate or class({})
item_mana_plate5 = item_mana_plate or class({})

function item_mana_plate:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_mana_plate:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_mana_plate:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

function item_mana_plate:GetIntrinsicModifierName()
	return "modifier_item_mana_plate"
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_mana_plate", "items/d_items/item_mana_plate", LUA_MODIFIER_MOTION_NONE)

modifier_item_mana_plate = class({})

function modifier_item_mana_plate:IsHidden()
	return true
end

function modifier_item_mana_plate:IsPurgable()
	return false
end

function modifier_item_mana_plate:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_mana_plate:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_ATTRIBUTE_NONE,
	}
end

function modifier_item_mana_plate:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_mana_plate:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_mana_plate:OnTakeDamage(keys)
	if IsServer() then
		local unit = keys.unit
		local attacker = keys.attacker

		if unit == self:GetParent() and unit ~= attacker then
			local damage = keys.original_damage
			local ability = self:GetAbility()

			if damage and damage > 0 and ability then
				local damage_to_mana = ability:GetSpecialValueFor("damage_to_mana")
				unit:GiveMana(damage * damage_to_mana * 0.01)

				local particle =
					ParticleManager:CreateParticle("particles/custom/manasteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
				ParticleManager:ReleaseParticleIndex(particle)
			end
		end
	end
end