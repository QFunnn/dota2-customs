--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_universal_lua", "items/d_items/item_universal_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_universal_lua_effect", "items/d_items/item_universal_lua", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_universal_lua = item_universal_lua or class({})
item_universal_lua2 = item_universal_lua or class({})
item_universal_lua3 = item_universal_lua or class({})
item_universal_lua4 = item_universal_lua or class({})
item_universal_lua5 = item_universal_lua or class({})

function item_universal_lua:GetIntrinsicModifierName()
	return "modifier_item_universal_lua"
end

function item_universal_lua:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_universal_lua:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_universal_lua:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------

modifier_item_universal_lua = class({})

function modifier_item_universal_lua:IsHidden()
	return true
end

function modifier_item_universal_lua:IsPurgable()
	return false
end

function modifier_item_universal_lua:IsAura()
	return true
end

function modifier_item_universal_lua:GetModifierAura()
	return "modifier_item_universal_lua_effect"
end

function modifier_item_universal_lua:GetTexture()
	return "universal"
end

function modifier_item_universal_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_universal_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end

function modifier_item_universal_lua:GetAuraRadius()
	return self.radius
end

function modifier_item_universal_lua:GetAuraEntityReject(hEntity)
	if IsServer() then
		if hEntity == self:GetCaster() then
			return true
		end
	end
	return false
end

function modifier_item_universal_lua:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("AbilityCastRange")
	self.bonus_all = self:GetAbility():GetSpecialValueFor("bonus_all")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_item_universal_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}
	return funcs
end

function modifier_item_universal_lua:GetModifierBonusStats_Strength(params)
	return self.bonus_all
end

function modifier_item_universal_lua:GetModifierBonusStats_Agility(params)
	return self.bonus_all
end

function modifier_item_universal_lua:GetModifierBonusStats_Intellect(params)
	return self.bonus_all
end

function modifier_item_universal_lua:GetModifierBaseAttack_BonusDamage(params)
	return self.damage
		* (self:GetCaster():GetAgility() + self:GetCaster():GetStrength() + self:GetCaster():GetIntellect(true))
end

--------------------------------------------------------------------------------

modifier_item_universal_lua_effect = class({})

function modifier_item_universal_lua_effect:GetTexture()
	return "universal"
end

function modifier_item_universal_lua_effect:OnCreated(kv)
	self.aura = self:GetAbility():GetSpecialValueFor("aura")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.ally = self.damage
		* (self:GetCaster():GetAgility() + self:GetCaster():GetStrength() + self:GetCaster():GetIntellect(true))
		* self.aura
		/ 100
end

function modifier_item_universal_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_universal_lua_effect:GetModifierBaseAttack_BonusDamage(params)
	return self.ally
end