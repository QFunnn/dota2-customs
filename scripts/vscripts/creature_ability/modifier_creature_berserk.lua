--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_creature_berserk = class({}) ---@class modifier_creature_berserk : CDOTA_Modifier_Lua

function modifier_creature_berserk:GetTexture()
	return "ogre_magi_bloodlust"
end

function modifier_creature_berserk:IsHidden()
	return false
end

function modifier_creature_berserk:IsDebuff()
	return false
end

function modifier_creature_berserk:IsPurgable()
	return false
end

function modifier_creature_berserk:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
end

function modifier_creature_berserk:OnCreated()
	if IsServer() then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_tower_truesight_aura", {})
		self:StartIntervalThink(1)
	end
	EmitSoundOn("Hero_OgreMagi.Bloodlust.Target", self:GetParent())
	EmitSoundOn("Hero_OgreMagi.Bloodlust.Target.FP", self:GetParent())
end

function modifier_creature_berserk:OnIntervalThink()
	self:SetStackCount(math.abs(GameMode.currentRound.roundTimeLimit))
	local parent = self:GetParent()
	if not IsValid(parent) then return end

	local ability = parent:FindAbilityByName("neutral_upgrade_lua")
	if not IsValid(ability) then return end

	if self:GetStackCount() > 60 then
		local flRadius = 550 + (self:GetStackCount() - 60) * 5
		local enemies = FindUnitsInRadius(
			DOTA_TEAM_NEUTRALS,
			self:GetParent():GetOrigin(),
			self:GetParent(),
			flRadius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
			DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
			FIND_CLOSEST,
			true
		)

		local damage_table = {
			attacker = self:GetParent(),
			damage_type = DAMAGE_TYPE_PURE,
			ability = ability,
			damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
		} ---@type ApplyDamageOptions

		for _, enemy in ipairs(enemies) do
			if enemy and (not enemy:HasModifier("modifier_hero_refreshing")) then
				damage_table.victim = enemy
				damage_table.damage = enemy:GetMaxHealth() * 0.005 * (self:GetStackCount() - 60)
				ApplyDamage(damage_table)
				local flManaBurn = enemy:GetMaxMana() * 0.005 * (self:GetStackCount() - 60)
				enemy:Script_ReduceMana(flManaBurn, self)
			end
		end
	end
end

function modifier_creature_berserk:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
		MODIFIER_PROPERTY_MODEL_SCALE
	}
end

function modifier_creature_berserk:CheckState()
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

function modifier_creature_berserk:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		local target = params.target
		if target ~= nil then
			local debuff = target:FindModifierByName("modifier_creature_berserk_debuff")
			if debuff == nil then
				debuff = target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_creature_berserk_debuff",
					{
						duration = 12
					})
				if debuff ~= nil then
					debuff:SetStackCount(0)
				end
			end
			if debuff ~= nil then
				debuff:SetStackCount(debuff:GetStackCount() + 1)
				debuff:SetDuration(12, true)
			end
		end
	end
	return 0
end

function modifier_creature_berserk:GetModifierAttackSpeedBonus_Constant(params)
	return self:GetStackCount() * 5
end

function modifier_creature_berserk:GetModifierDamageOutgoing_Percentage(params)
	return self:GetStackCount() * 15
end

function modifier_creature_berserk:GetModifierMoveSpeed_AbsoluteMin(params)
	return self:GetParent():GetBaseMoveSpeed() +
		math.floor(self:GetParent():GetBaseMoveSpeed() * self:GetStackCount() * 0.05)
end

function modifier_creature_berserk:GetModifierModelScale(params)
	return self:GetParent():IsRoshan() and 0 or 55  -- При скейле размера рошана багается звук, смерть воспроизводится много раз
end