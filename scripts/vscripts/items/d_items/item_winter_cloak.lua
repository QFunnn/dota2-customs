--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_winter_cloak", "items/d_items/item_winter_cloak", LUA_MODIFIER_MOTION_NONE)

-------------------------------------------------------------------

item_winter_cloak = item_winter_cloak or class({})
item_winter_cloak2 = item_winter_cloak or class({})
item_winter_cloak3 = item_winter_cloak or class({})
item_winter_cloak4 = item_winter_cloak or class({})
item_winter_cloak5 = item_winter_cloak or class({})

function item_winter_cloak:GetIntrinsicModifierName()
	return "modifier_item_winter_cloak"
end

function item_winter_cloak:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_winter_cloak:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_winter_cloak:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

modifier_item_winter_cloak = class({})

function modifier_item_winter_cloak:IsHidden()
	return true
end

function modifier_item_winter_cloak:IsPurgable()
	return false
end

function modifier_item_winter_cloak:OnCreated(kv)
	self.bonus_health_regen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	self.bonus_agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
end

function modifier_item_winter_cloak:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_winter_cloak:GetModifierConstantHealthRegen(params)
	return self.bonus_health_regen
end

function modifier_item_winter_cloak:GetModifierBonusStats_Agility(params)
	return self.bonus_agility
end

function modifier_item_winter_cloak:OnTakeDamage(params)
	if IsServer() then
		if params.unit ~= self:GetParent() then
			return 0
		end

		local hAttacker = params.attacker
		if
			hAttacker ~= nil
			and hAttacker:IsMagicImmune() == false
			and hAttacker:IsInvulnerable() == false
			and params.damage_type == DAMAGE_TYPE_PHYSICAL
		then
			hAttacker:AddNewModifier(
				self:GetParent(),
				self:GetAbility(),
				"modifier_ogre_magi_frost_armor_slow",
				{ duration = self.slow_duration }
			)
		end
	end
	return 0
end