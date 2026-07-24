--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_discord_robe", "items/item_discord_robe", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_discord_robe_debuff", "items/item_discord_robe", LUA_MODIFIER_MOTION_NONE)

item_discord_robe = class({})

function item_discord_robe:GetIntrinsicModifierName()
	return "modifier_item_discord_robe"
end

modifier_item_discord_robe = class({})

function modifier_item_discord_robe:IsHidden() return true end
function modifier_item_discord_robe:IsPurgable() return false end
function modifier_item_discord_robe:IsPurgeException() return false end
function modifier_item_discord_robe:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_discord_robe:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
end

function modifier_item_discord_robe:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_discord_robe:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_discord_robe:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_discord_robe:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_discord_robe:IsAura() return true end

function modifier_item_discord_robe:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_item_discord_robe:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_item_discord_robe:GetModifierAura()
	return "modifier_item_discord_robe_debuff"
end

function modifier_item_discord_robe:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

modifier_item_discord_robe_debuff = class({})

function modifier_item_discord_robe_debuff:IsPurgable() return false end

function modifier_item_discord_robe_debuff:DeclareFunctions()
	return 
	{ 
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, 
	} 
end

function modifier_item_discord_robe_debuff:GetModifierIncomingDamage_Percentage(keys)
	if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then
		return self:GetAbility():GetSpecialValueFor("bonus_damage_magical")
	end
end

function modifier_item_discord_robe_debuff:GetEffectName()
	return "particles/items2_fx/veil_of_discord_debuff.vpcf"
end

function modifier_item_discord_robe_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end