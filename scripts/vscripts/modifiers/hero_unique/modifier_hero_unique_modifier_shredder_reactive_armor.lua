--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_shredder_reactive_armor = class({})
function modifier_hero_unique_modifier_shredder_reactive_armor:IsPurgable() return false end
function modifier_hero_unique_modifier_shredder_reactive_armor:IsHidden() return true end
function modifier_hero_unique_modifier_shredder_reactive_armor:IsPurgeException() return false end
function modifier_hero_unique_modifier_shredder_reactive_armor:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_shredder_reactive_armor:IsAura()
	return true and not self:GetParent():PassivesDisabled()
end

function modifier_hero_unique_modifier_shredder_reactive_armor:GetModifierAura()
	return "modifier_hero_unique_modifier_shredder_reactive_armor_debuff"
end

function modifier_hero_unique_modifier_shredder_reactive_armor:GetAuraRadius()
	return 800
end

function modifier_hero_unique_modifier_shredder_reactive_armor:GetAuraDuration()
	return 0
end

function modifier_hero_unique_modifier_shredder_reactive_armor:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_hero_unique_modifier_shredder_reactive_armor:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_hero_unique_modifier_shredder_reactive_armor:GetAuraEntityReject(hEntity)
    if hEntity:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
        return true
    end
    return false
end

modifier_hero_unique_modifier_shredder_reactive_armor_debuff = class({})
function modifier_hero_unique_modifier_shredder_reactive_armor_debuff:IsHidden() return false end
function modifier_hero_unique_modifier_shredder_reactive_armor_debuff:IsPurgable() return false end
function modifier_hero_unique_modifier_shredder_reactive_armor_debuff:IsDebuff() return true end
function modifier_hero_unique_modifier_shredder_reactive_armor_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}
end
function modifier_hero_unique_modifier_shredder_reactive_armor_debuff:GetModifierBaseDamageOutgoing_Percentage()
    return -60
end