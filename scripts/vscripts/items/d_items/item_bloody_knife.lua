--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_bloody_knife", "items/d_items/item_bloody_knife", LUA_MODIFIER_MOTION_NONE)

---------------------------------------------------------------------------------------------------------------------
item_bloody_knife = item_bloody_knife or class({})
item_bloody_knife2 = item_bloody_knife or class({})
item_bloody_knife3 = item_bloody_knife or class({})
item_bloody_knife4 = item_bloody_knife or class({})
item_bloody_knife5 = item_bloody_knife or class({})

function item_bloody_knife:GetIntrinsicModifierName()
	return "modifier_item_bloody_knife"
end

function item_bloody_knife:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_bloody_knife:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_bloody_knife:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

modifier_item_bloody_knife = class({})

function modifier_item_bloody_knife:IsHidden()
	return true
end

function modifier_item_bloody_knife:IsPurgable()
	return false
end

function modifier_item_bloody_knife:OnCreated(kv)
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_bloody_knife:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_item_bloody_knife:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_damage
end

function modifier_item_bloody_knife:GetModifierAttackSpeedBonus_Constant(params)
	return self.bonus_attack_speed
end