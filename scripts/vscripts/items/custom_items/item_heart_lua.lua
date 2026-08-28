--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_heart_lua1 = item_heart_lua1 or class({})
item_heart_lua2 = item_heart_lua1 or class({})
item_heart_lua3 = item_heart_lua1 or class({})

LinkLuaModifier("modifier_item_heart_lua", "items/custom_items/item_heart_lua.lua", LUA_MODIFIER_MOTION_NONE)

modifier_item_heart_lua = class({})

function item_heart_lua1:GetIntrinsicModifierName()
	return "modifier_item_heart_lua"
end

function modifier_item_heart_lua:IsHidden()
	return true
end

function modifier_item_heart_lua:IsPurgable()
	return false
end

function modifier_item_heart_lua:DestroyOnExpire()
	return false
end

function modifier_item_heart_lua:RemoveOnDeath()
	return false
end

function modifier_item_heart_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_heart_lua:OnCreated()
	--	if not IsServer() then return end
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.health_regen_pct = self:GetAbility():GetSpecialValueFor("health_regen_pct")
	self.bonus_health = self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_heart_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_item_heart_lua:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

function modifier_item_heart_lua:GetModifierHealthRegenPercentage()
	return self.health_regen_pct
end

function modifier_item_heart_lua:GetModifierHealthBonus()
	return self.bonus_health
end