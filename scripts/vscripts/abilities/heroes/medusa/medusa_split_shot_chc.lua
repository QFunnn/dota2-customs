--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


medusa_split_shot_chc = medusa_split_shot_chc or class({})
modifier_medusa_split_shot_chc = modifier_medusa_split_shot_chc or class({})
LinkLuaModifier(
	"modifier_medusa_split_shot_chc",
	"abilities/heroes/medusa/medusa_split_shot_chc",
	LUA_MODIFIER_MOTION_NONE
)

function medusa_split_shot_chc:GetIntrinsicModifierName()
	return "modifier_medusa_split_shot_chc"
end
function medusa_split_shot_chc:ProcsMagicStick()
	return false
end

function medusa_split_shot_chc:OnToggle()
	self:RefreshIntrinsicModifier()
end

function medusa_split_shot_chc:ResetToggleOnRespawn()
	return false
end

function modifier_medusa_split_shot_chc:IsHidden()
	return true
end
function modifier_medusa_split_shot_chc:IsPurgable()
	return false
end
function modifier_medusa_split_shot_chc:RemoveOnDeath()
	return false
end

function modifier_medusa_split_shot_chc:OnRefresh()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	if not IsValidEntity(self.parent) then
		return
	end
	if not IsValidEntity(self.ability) then
		return
	end

	if self.parent:IsIllusion() then
		local owner_hero = PlayerResource:GetSelectedHeroEntity(self.parent:GetPlayerOwnerID())
		if not owner_hero or owner_hero:IsNull() then
			return
		end
		local split_shot = owner_hero:FindAbilityByName("medusa_split_shot_chc")
		if not split_shot or split_shot:IsNull() then
			return
		end

		if self.ability:GetToggleState() ~= split_shot:GetToggleState() then
			self.ability:ToggleAbility()

			return
		end
	end

	self.team = self:GetParent():GetTeamNumber()

	self.active = self.ability:GetToggleState()

	self.damage_modifier = self.ability:GetSpecialValueFor("damage_modifier")

	if IsClient() then
		return
	end

	self.split_shot_bonus_range = self.ability:GetSpecialValueFor("split_shot_bonus_range")
end

function modifier_medusa_split_shot_chc:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE, -- GetModifierDamageOutgoing_Percentage
		MODIFIER_PROPERTY_PRE_ATTACK, -- GetModifierPreAttack
		MODIFIER_EVENT_ON_ATTACK_CANCELLED, -- OnAttackCancelled
	}
end

function modifier_medusa_split_shot_chc:GetModifierDamageOutgoing_Percentage()
	return self.active and self.damage_modifier or 0
end

function modifier_medusa_split_shot_chc:GetModifierPreAttack(event)
	if self.lock_attack_event then
		return
	end
	if not self.active then
		return
	end
	if self.parent:PassivesDisabled() then
		return
	end
	if event.target:GetTeam() == self.parent:GetTeam() then
		return
	end

	local attack_point = self.parent:GetRealAttackPoint()
	local record = event.record
	self.record = event.record

	Timers:CreateTimer(attack_point, function()
		self:OnAttackCompleted(record, event.target)
	end)
end

function modifier_medusa_split_shot_chc:OnAttackCancelled(event)
	if self.parent ~= event.attacker then
		return
	end
	self.record = nil
end

function modifier_medusa_split_shot_chc:OnAttackCompleted(record, original_target)
	if record ~= self.record then
		return
	end
	if not IsValidEntity(self.ability) then
		return
	end

	local targets = FindUnitsInRadius(
		self.team,
		self.parent:GetAbsOrigin(),
		nil,
		self.parent:Script_GetAttackRange() + self.split_shot_bonus_range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_CLOSEST,
		false
	)

	self.arrow_count = self.ability:GetSpecialValueFor("arrow_count") -- this is the number of BONUS attacks, dependent on scepter
	self.apply_modifiers = self.ability:GetSpecialValueFor("apply_modifiers") == 1 -- scepter can be dropped and picked up, need to read the values just before the shot

	local split_count_remaining = self.arrow_count

	for _, target in pairs(targets or {}) do
		if IsValidEntity(target) and target ~= original_target then
			self.lock_attack_event = true
			self.parent:PerformAttack(target, false, self.apply_modifiers, true, true, true, false, false)
			self.lock_attack_event = false

			split_count_remaining = split_count_remaining - 1
			if split_count_remaining <= 0 then
				break
			end
		end
	end
end