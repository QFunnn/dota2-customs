--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_veil_desolator_custom", "items/item_veil_desolator_custom", LUA_MODIFIER_MOTION_NONE)

item_veil_desolator_custom = class({})

function item_veil_desolator_custom:GetIntrinsicModifierName()
	if self:GetCaster():IsIllusion() then return end
	return "modifier_item_veil_desolator_custom"
end

modifier_item_veil_desolator_custom = class({})

function modifier_item_veil_desolator_custom:IsHidden() return true end

function modifier_item_veil_desolator_custom:IsPurgable() return false end
function modifier_item_veil_desolator_custom:IsPurgeException() return false end

function modifier_item_veil_desolator_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_veil_desolator_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		 
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_item_veil_desolator_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_veil_desolator_custom:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_veil_desolator_custom:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_veil_desolator_custom:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_item_veil_desolator_custom:GetModifierAttackRangeBonusUnique()
	if not self:GetParent():IsRangedAttacker() then return 0 end
	return self:GetAbility():GetSpecialValueFor("bonus_range_attack") 
end

function modifier_item_veil_desolator_custom:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_veil_desolator_custom:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
    if params.target:IsOther() then return nil end
    local cleave_damage_percent = self:GetAbility():GetSpecialValueFor("cleave_damage_percent")
	local cleave_damage_percent_creep = self:GetAbility():GetSpecialValueFor("cleave_damage_percent_creep")
	local damage = params.original_damage / 100 * cleave_damage_percent
	if not params.target:IsHero() then
		damage = params.original_damage / 100 * cleave_damage_percent_creep
	end
	local particle = ParticleManager:CreateParticle("particles/custom/shrapnel.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, params.target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
    local enemies = FindUnitsInRadius(params.attacker:GetTeamNumber(), params.target:GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		if enemy ~= params.target then
			ApplyDamage({ victim = enemy, attacker = params.attacker, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, ability = self:GetAbility() })
		end
	end
end