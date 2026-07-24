--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_drum_of_endurance", "items/item_drum_of_endurance", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_drum_of_endurance_buff", "items/item_drum_of_endurance", LUA_MODIFIER_MOTION_NONE)

item_drum_of_endurance = class({})

function item_drum_of_endurance:GetIntrinsicModifierName()
	return "modifier_item_drum_of_endurance"
end

modifier_item_drum_of_endurance = class({})

function modifier_item_drum_of_endurance:IsHidden() return true end
function modifier_item_drum_of_endurance:IsPurgable() return false end
function modifier_item_drum_of_endurance:IsPurgeException() return false end

function modifier_item_drum_of_endurance:IsAura()
	return true
end

function modifier_item_drum_of_endurance:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_drum_of_endurance:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("radius")
	end
end

function modifier_item_drum_of_endurance:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_drum_of_endurance:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_drum_of_endurance:GetModifierAura()
	return "modifier_item_drum_of_endurance_buff"
end

function modifier_item_drum_of_endurance:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
end

function modifier_item_drum_of_endurance:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_str")
end

function modifier_item_drum_of_endurance:GetAuraDuration()
	return 0
end

function modifier_item_drum_of_endurance:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_item_drum_of_endurance_buff = class({})

function modifier_item_drum_of_endurance_buff:OnCreated()
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.bonus_movement_speed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
    self.bonus_hp_regen = self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
end

function modifier_item_drum_of_endurance_buff:OnRefresh()
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.bonus_movement_speed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
    self.bonus_hp_regen = self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
end

function modifier_item_drum_of_endurance_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_drum_of_endurance_buff:GetModifierConstantHealthRegen()
    return self.bonus_hp_regen
end

function modifier_item_drum_of_endurance_buff:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_item_drum_of_endurance_buff:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_movement_speed
end