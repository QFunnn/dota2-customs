--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_antimage_blink = class({})
function modifier_hero_unique_modifier_antimage_blink:IsHidden() return true end
function modifier_hero_unique_modifier_antimage_blink:IsPurgable() return false end
function modifier_hero_unique_modifier_antimage_blink:IsPurgeException() return false end
function modifier_hero_unique_modifier_antimage_blink:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_antimage_blink:IsAura()
	return true
end

function modifier_hero_unique_modifier_antimage_blink:GetModifierAura()
	return "modifier_hero_unique_modifier_antimage_blink_debuff"
end

function modifier_hero_unique_modifier_antimage_blink:GetAuraRadius()
	return 1000
end

function modifier_hero_unique_modifier_antimage_blink:GetAuraDuration()
	return 0
end

function modifier_hero_unique_modifier_antimage_blink:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_hero_unique_modifier_antimage_blink:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

modifier_hero_unique_modifier_antimage_blink_debuff = class({})
function modifier_hero_unique_modifier_antimage_blink_debuff:IsHidden() return false end
function modifier_hero_unique_modifier_antimage_blink_debuff:IsPurgable() return false end
function modifier_hero_unique_modifier_antimage_blink_debuff:IsDebuff() return true end
function modifier_hero_unique_modifier_antimage_blink_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
	}
end
function modifier_hero_unique_modifier_antimage_blink_debuff:GetModifierCastRangeBonusStacking(params)
    if not self:GetParent():IsHero() then return end
    if self:GetParent():IsDebuffImmune() then return end
	if params.ability then
		if params.ability.GetCastRange then
			local new = params.ability:GetCastRange(params.ability:GetCaster():GetAbsOrigin(), params.ability:GetCaster()) + self:GetParent():GetCastRangeBonus()
			if new > 0 then
				return (new * 0.5) * -1
			end
		end
	end
end