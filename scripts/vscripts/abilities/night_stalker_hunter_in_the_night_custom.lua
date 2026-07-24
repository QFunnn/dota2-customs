--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_hunter_in_the_night_custom", "abilities/night_stalker_hunter_in_the_night_custom", LUA_MODIFIER_MOTION_NONE)

night_stalker_hunter_in_the_night_custom = class({})

function night_stalker_hunter_in_the_night_custom:GetIntrinsicModifierName()
	return "modifier_night_stalker_hunter_in_the_night_custom"
end

function night_stalker_hunter_in_the_night_custom:GetBehavior()
	if self:GetCaster():HasShard() then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function night_stalker_hunter_in_the_night_custom:GetCooldown(iLevel)
	if self:GetCaster():HasShard() then
		return self:GetSpecialValueFor("shard_cooldown")
	end
	return 0
end

function night_stalker_hunter_in_the_night_custom:GetCastRange(vLocation, hTarget)
	if self:GetCaster():HasShard() then
		return self:GetSpecialValueFor("shard_cast_range")
	end
	return 0
end

function night_stalker_hunter_in_the_night_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
    local health = self:GetCaster():GetMaxHealth()
    local mana = self:GetCaster():GetMaxMana()

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_shard_hunter.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())

    local heal_restore = health / 100 * self:GetSpecialValueFor("shard_hp_restore_pct")
    local mana_restore = mana / 100 * self:GetSpecialValueFor("shard_mana_restore_pct")

    self:GetCaster():GiveMana(mana_restore)
    self:GetCaster():Heal(heal_restore, self)

    target:Kill(self, self:GetCaster())
end

modifier_night_stalker_hunter_in_the_night_custom = class({})
function modifier_night_stalker_hunter_in_the_night_custom:IsHidden() return true end
function modifier_night_stalker_hunter_in_the_night_custom:IsPurgable() return false end
function modifier_night_stalker_hunter_in_the_night_custom:IsPurgeException() return false end
function modifier_night_stalker_hunter_in_the_night_custom:RemoveOnDeath() return false end

function modifier_night_stalker_hunter_in_the_night_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_night_stalker_hunter_in_the_night_custom:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed_pct_night")
end

function modifier_night_stalker_hunter_in_the_night_custom:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed_night")
end

function modifier_night_stalker_hunter_in_the_night_custom:GetModifierStatusResistanceStacking()
	return self:GetAbility():GetSpecialValueFor("bonus_status_resist_night")
end

night_stalker_darkness_passive = class({})

function night_stalker_darkness_passive:GetIntrinsicModifierName()
	return "modifier_night_stalker_hunter_in_the_night_custom"
end