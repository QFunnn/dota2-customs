--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_quelling_song", "items/item_quelling_song", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_quelling_song_aura", "items/item_quelling_song", LUA_MODIFIER_MOTION_NONE)

item_quelling_song = class({})

function item_quelling_song:GetAOERadius()
	return self:GetSpecialValueFor("trees_destoy")
end

function item_quelling_song:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorPosition()
	GridNav:DestroyTreesAroundPoint(target, self:GetSpecialValueFor("trees_destoy"), true)
end

function item_quelling_song:GetIntrinsicModifierName()
	return "modifier_item_quelling_song"
end

modifier_item_quelling_song = class({})
function modifier_item_quelling_song:IsHidden() return true end
function modifier_item_quelling_song:IsPurgable() return false end
function modifier_item_quelling_song:IsPurgeException() return false end
function modifier_item_quelling_song:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_item_quelling_song:IsAura() return true end

function modifier_item_quelling_song:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_item_quelling_song:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_item_quelling_song:GetModifierAura()
	return "modifier_item_quelling_song_aura"
end

function modifier_item_quelling_song:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_quelling_song:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
end

function modifier_item_quelling_song:GetModifierAttackSpeedPercentage()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_quelling_song:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_str")
end

function modifier_item_quelling_song:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_int")
end

function modifier_item_quelling_song:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_quelling_song:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

modifier_item_quelling_song_aura = class({})

function modifier_item_quelling_song_aura:DeclareFunctions()
	return 
	{
        MODIFIER_PROPERTY_TOOLTIP
	}
end

function modifier_item_quelling_song_aura:OnTooltip()
    return self:GetAbility():GetSpecialValueFor("mana_regen_reduce")
end

function modifier_item_quelling_song_aura:GetModifierManaRegenPercentDecreaseCustom()
    return self:GetAbility():GetSpecialValueFor("mana_regen_reduce")
end