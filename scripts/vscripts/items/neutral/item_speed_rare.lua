--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_speed_rare = class({})
LinkLuaModifier("modifier_item_speed_rare", "items/neutral/item_speed_rare", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_speed_rare_effect", "items/neutral/item_speed_rare", LUA_MODIFIER_MOTION_NONE)

function item_speed_rare:GetIntrinsicModifierName()
	return "modifier_item_speed_rare"
end

modifier_item_speed_rare = class({})

function modifier_item_speed_rare:IsHidden()
	return true
end

function modifier_item_speed_rare:IsDebuff()
	return false
end

function modifier_item_speed_rare:IsPurgable()
	return false
end

function modifier_item_speed_rare:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_item_speed_rare:GetModifierAura()
	return "modifier_item_speed_rare_effect"
end

function modifier_item_speed_rare:GetAuraRadius()
	return 700
end

function modifier_item_speed_rare:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_speed_rare:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

-------------------------------------------------------------------------------------------------------------------------------

modifier_item_speed_rare_effect = class({})

function modifier_item_speed_rare_effect:IsHidden()
	return false
end

function modifier_item_speed_rare_effect:IsDebuff()
	return false
end

function modifier_item_speed_rare_effect:IsPurgable()
	return false
end

function modifier_item_speed_rare_effect:OnCreated(kv)
	self.speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed") -- special value
	self.speed2 = self:GetAbility():GetSpecialValueFor("bonus_attack_speed_tooltip") -- special value
end

function modifier_item_speed_rare_effect:OnRefresh(kv)
	self.speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed") -- special value
	self.speed2 = self:GetAbility():GetSpecialValueFor("bonus_attack_speed_tooltip") -- special value
end

function modifier_item_speed_rare_effect:OnDestroy(kv) end

function modifier_item_speed_rare_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end
function modifier_item_speed_rare_effect:GetModifierAttackSpeedBonus_Constant()
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if caster == parent then
		return self.speed2
	end
	return self.speed
end