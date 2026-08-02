--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_antimage_mana_break_lua", "heroes/hero_antimage/hero_antimage", LUA_MODIFIER_MOTION_NONE)

antimage_mana_break_lua = class({})

function antimage_mana_break_lua:GetIntrinsicModifierName()
	return "modifier_antimage_mana_break_lua"
end

----------------------------------------------------------------

modifier_antimage_mana_break_lua = class({})

function modifier_antimage_mana_break_lua:IsHidden()
	return true
end

function modifier_antimage_mana_break_lua:IsPurgable()
	return false
end

function modifier_antimage_mana_break_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_antimage_mana_break_lua:GetModifierProcAttack_BonusDamage_Physical(params)
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		local target = params.target
		local result = UnitFilter(
			target,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_CREEP,
			DOTA_UNIT_TARGET_FLAG_MANA_ONLY,
			self:GetParent():GetTeamNumber()
		)
		if result == UF_SUCCESS then
			local mana_burn = math.min(target:GetMana(), self:GetAbility():GetSpecialValueFor("mana_per_hit"))
			target:Script_ReduceMana(mana_burn, nil)
			self:PlayEffects(target)
			return mana_burn * self:GetAbility():GetSpecialValueFor("damage_per_burn")
		end
	end
end

function modifier_antimage_mana_break_lua:PlayEffects(target)
	local effect_cast =
		ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Antimage.ManaBreak", target)
end

----------------------------------------------------------------
----------------------------------------------------------------

LinkLuaModifier("modifier_after_illusion", "heroes/hero_antimage/hero_antimage", LUA_MODIFIER_MOTION_NONE)

antimage_blink_lua = class({})

function antimage_blink_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not target then
		return
	end

	local duration = self:GetSpecialValueFor("duration")
	local count = self:GetSpecialValueFor("count")

	local illusions = CreateIllusions(
		caster,
		caster,
		{ outgoing_damage = 0, duration = duration },
		count,
		caster:GetHullRadius(),
		true,
		true
	)
	if illusions then
		for _, illusion in pairs(illusions) do
			local pos = target:GetOrigin() + RandomVector(RandomInt(50, 150))

			local average_bonus_damage = caster:GetAverageTrueAttackDamage(nil)
			illusion:SetBaseDamageMin(average_bonus_damage - self:GetCaster():GetAgility())
			illusion:SetBaseDamageMax(average_bonus_damage - self:GetCaster():GetAgility())

			illusion:SetAbsOrigin(pos)
			FindClearSpaceForUnit(illusion, pos, true)
			illusion:AddNewModifier(caster, self, "modifier_after_illusion", {})
			illusion:SetForceAttackTarget(target)
		end
	end
end

---------------------------------------------------------

modifier_after_illusion = class({})

function modifier_after_illusion:IsHidden()
	return true
end
function modifier_after_illusion:IsPurgable()
	return false
end

function modifier_after_illusion:CheckState()
	return {
		[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
	}
end

----------------------------------------------------------------
----------------------------------------------------------------

LinkLuaModifier("modifier_antimage_spell_shield_lua", "heroes/hero_antimage/hero_antimage", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_antimage_spell_shield_lua_effect",
	"heroes/hero_antimage/hero_antimage",
	LUA_MODIFIER_MOTION_NONE
)

antimage_spell_shield_lua = class({})

function antimage_spell_shield_lua:GetIntrinsicModifierName()
	return "modifier_antimage_spell_shield_lua"
end

----------------------------------------------------------------

modifier_antimage_spell_shield_lua = class({})

function modifier_antimage_spell_shield_lua:IsHidden()
	return true
end
function modifier_antimage_spell_shield_lua:IsPurgable()
	return false
end

function modifier_antimage_spell_shield_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_antimage_spell_shield_lua:GetModifierMagicalResistanceBonus()
	if not self:GetParent():PassivesDisabled() then
		return self:GetAbility():GetSpecialValueFor("bonus_resist")
	end
end

function modifier_antimage_spell_shield_lua:IsAura()
	return not self:GetParent():PassivesDisabled()
end

function modifier_antimage_spell_shield_lua:GetModifierAura()
	return "modifier_antimage_spell_shield_lua_effect"
end

function modifier_antimage_spell_shield_lua:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_antimage_spell_shield_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_antimage_spell_shield_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC
end

----------------------------------------------------------------

modifier_antimage_spell_shield_lua_effect = class({})

function modifier_antimage_spell_shield_lua_effect:IsHidden()
	return false
end
function modifier_antimage_spell_shield_lua_effect:IsDebuff()
	return true
end
function modifier_antimage_spell_shield_lua_effect:IsPurgable()
	return false
end

function modifier_antimage_spell_shield_lua_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_antimage_spell_shield_lua_effect:GetModifierMagicalResistanceBonus()
	return -self:GetAbility():GetSpecialValueFor("bonus_resist_enemy")
end

----------------------------------------------------------------
----------------------------------------------------------------

LinkLuaModifier("modifier_sleep_time", "heroes/hero_antimage/hero_antimage", LUA_MODIFIER_MOTION_NONE)

antimage_mana_time_lua = class({})

function antimage_mana_time_lua:OnSpellStart()
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("damage")
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
		enemy:AddNewModifier(caster, self, "modifier_sleep_time", { duration = duration })
	end

	self:PlayEffects(caster, radius)
end

function antimage_mana_time_lua:PlayEffects(target, radius)
	local effect_target = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_antimage/antimage_manavoid.vpcf",
		PATTACH_POINT_FOLLOW,
		target
	)
	ParticleManager:SetParticleControl(effect_target, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_target)
	EmitSoundOn("Hero_Antimage.ManaVoid", target)
end

--------------------------------------------------------------------------------

modifier_sleep_time = class({})

function modifier_sleep_time:IsHidden()
	return false
end
function modifier_sleep_time:IsDebuff()
	return true
end
function modifier_sleep_time:IsPurgable()
	return false
end
function modifier_sleep_time:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_sleep_time:CheckState()
	return {
		[MODIFIER_STATE_NIGHTMARED] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_sleep_time:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_sleep_time:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end
function modifier_sleep_time:GetOverrideAnimationRate()
	return 0.55
end

function modifier_sleep_time:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_song_debuff.vpcf"
end

function modifier_sleep_time:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_sleep_time:GetStatusEffectName()
	return "particles/status_fx/status_effect_siren_song.vpcf"
end

function modifier_sleep_time:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end