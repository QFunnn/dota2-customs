--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_speed_legendary = class({})
LinkLuaModifier("modifier_item_speed_legendary", "items/neutral/item_speed_legendary", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_speed_legendary_effect", "items/neutral/item_speed_legendary", LUA_MODIFIER_MOTION_NONE)

function item_speed_legendary:GetIntrinsicModifierName()
	return "modifier_item_speed_legendary"
end

modifier_item_speed_legendary = class({})

function modifier_item_speed_legendary:IsHidden()
	return true
end

function modifier_item_speed_legendary:IsDebuff()
	return false
end

function modifier_item_speed_legendary:IsPurgable()
	return false
end

function modifier_item_speed_legendary:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_item_speed_legendary:GetModifierAura()
	return "modifier_item_speed_legendary_effect"
end

function modifier_item_speed_legendary:GetAuraRadius()
	return 700
end

function modifier_item_speed_legendary:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_speed_legendary:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

-------------------------------------------------------------------------------------------------------------------------------

modifier_item_speed_legendary_effect = class({})

function modifier_item_speed_legendary_effect:IsHidden()
	return false
end

function modifier_item_speed_legendary_effect:IsDebuff()
	return false
end

function modifier_item_speed_legendary_effect:IsPurgable()
	return false
end

function modifier_item_speed_legendary_effect:OnCreated(kv)
	self.speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed") -- special value
	self.speed2 = self:GetAbility():GetSpecialValueFor("bonus_attack_speed_tooltip") -- special value
end

function modifier_item_speed_legendary_effect:OnRefresh(kv)
	self.speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed") -- special value
	self.speed2 = self:GetAbility():GetSpecialValueFor("bonus_attack_speed_tooltip") -- special value
end

function modifier_item_speed_legendary_effect:OnDestroy(kv) end

function modifier_item_speed_legendary_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end
function modifier_item_speed_legendary_effect:GetModifierAttackSpeedBonus_Constant()
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if caster == parent then
		return self.speed2
	end
	return self.speed
end