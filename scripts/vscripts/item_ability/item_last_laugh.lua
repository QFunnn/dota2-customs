--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_last_laugh", "item_ability/item_last_laugh.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_last_laugh_active", "item_ability/item_last_laugh.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_last_laugh_disable", "item_ability/item_last_laugh.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_last_laugh == nil then
	item_last_laugh = class({})
end
function item_last_laugh:OnSpellStart()
	local hCaster = self:GetCaster()
	if IsValid(hCaster) and hCaster:IsAlive() then
		local duration = self:GetSpecialValueFor("duration")
		hCaster:AddNewModifier(hCaster, self, "modifier_item_last_laugh_active", { duration = duration })
		EmitSoundOn("DOTA_Item.PhaseBoots.Activate", hCaster)
		-- EmitSoundOn("DOTA_Item.MaskOfMadness.Activate", hCaster)
	end
end
function item_last_laugh:GetIntrinsicModifierName()
	return "modifier_item_last_laugh"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_last_laugh == nil then
	modifier_item_last_laugh = class({})
end
function modifier_item_last_laugh:IsHidden()
	return true
end
function modifier_item_last_laugh:IsDebuff()
	return false
end
function modifier_item_last_laugh:IsPurgable()
	return false
end
function modifier_item_last_laugh:IsPurgeException()
	return false
end
function modifier_item_last_laugh:RemoveOnDeath()
	return false
end
function modifier_item_last_laugh:OnCreated(params)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_health_regen = self:GetAbilitySpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_movement_speed = self:GetAbilitySpecialValueFor("bonus_movement_speed")
	self.cleave_damage_percent = self:GetAbilitySpecialValueFor("cleave_damage_percent")
	self.cleave_damage_percent_ranged = self:GetAbilitySpecialValueFor("cleave_damage_percent_ranged")
	self.cleave_starting_width = self:GetAbilitySpecialValueFor("cleave_starting_width")
	self.cleave_ending_width = self:GetAbilitySpecialValueFor("cleave_ending_width")
	self.cleave_ending_width_ranged = self:GetAbilitySpecialValueFor("cleave_ending_width_ranged")
	self.cleave_distance = self:GetAbilitySpecialValueFor("cleave_distance")
	self.cleave_distance_ranged = self:GetAbilitySpecialValueFor("cleave_distance_ranged")
	self.quelling_bonus = self:GetAbilitySpecialValueFor("quelling_bonus")
	self.bonus_attack_range = self:GetAbilitySpecialValueFor("bonus_attack_range")
	self.bonus_attack_range_melee = self:GetAbilitySpecialValueFor("bonus_attack_range_melee")
	self.disable_duration = self:GetAbilitySpecialValueFor("disable_duration")
	self.hero_pct_reduction = self:GetAbilitySpecialValueFor("hero_pct_reduction")
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
	self.crit_multiplier = self:GetAbilitySpecialValueFor("crit_multiplier")
	if IsServer() then
		AddModifierEvents(MODIFIER_EVENT_ON_ATTACK_START, self, self:GetParent())
	end
end
function modifier_item_last_laugh:OnRefresh(params)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_health_regen = self:GetAbilitySpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_movement_speed = self:GetAbilitySpecialValueFor("bonus_movement_speed")
	self.cleave_damage_percent = self:GetAbilitySpecialValueFor("cleave_damage_percent")
	self.cleave_damage_percent_ranged = self:GetAbilitySpecialValueFor("cleave_damage_percent_ranged")
	self.cleave_starting_width = self:GetAbilitySpecialValueFor("cleave_starting_width")
	self.cleave_ending_width = self:GetAbilitySpecialValueFor("cleave_ending_width")
	self.cleave_ending_width_ranged = self:GetAbilitySpecialValueFor("cleave_ending_width_ranged")
	self.cleave_distance = self:GetAbilitySpecialValueFor("cleave_distance")
	self.cleave_distance_ranged = self:GetAbilitySpecialValueFor("cleave_distance_ranged")
	self.quelling_bonus = self:GetAbilitySpecialValueFor("quelling_bonus")
	self.bonus_attack_range = self:GetAbilitySpecialValueFor("bonus_attack_range")
	self.bonus_attack_range_melee = self:GetAbilitySpecialValueFor("bonus_attack_range_melee")
	self.disable_duration = self:GetAbilitySpecialValueFor("disable_duration")
	self.hero_pct_reduction = self:GetAbilitySpecialValueFor("hero_pct_reduction")
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
	self.crit_multiplier = self:GetAbilitySpecialValueFor("crit_multiplier")
	if IsServer() then
	end
end
function modifier_item_last_laugh:OnDestroy()
	if IsServer() then
		RemoveModifierEvents(MODIFIER_EVENT_ON_ATTACK_START, self, self:GetParent())
	end
end
function modifier_item_last_laugh:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end
function modifier_item_last_laugh:OnAttackStart(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local hTarget = params.target
	local hAttacker = params.attacker

	if IsValid(hParent) and IsValid(hAbility) and IsValid(hTarget) and hParent == hAttacker then
		if hTarget:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
			hParent:AddNewModifier(hParent, hAbility, "modifier_item_last_laugh_disable", { duration = self.disable_duration })
		end
	end
end
function modifier_item_last_laugh:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	local fDamage = params.damage
	if IsValid(hParent) and IsValid(hTarget) and IsValid(hAbility) and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
		local fCleavePct = self.cleave_damage_percent
		local fDistance = self.cleave_distance
		local fCleaveEndWidth = self.cleave_ending_width
		if hParent:IsRangedAttacker() then
			fCleavePct = self.cleave_damage_percent_ranged
			fDistance = self.cleave_distance_ranged
			fCleaveEndWidth = self.cleave_ending_width_ranged
		end
		local fCleaveDamage = params.damage * fCleavePct * 0.01

		DoCleaveAttack(hParent, hTarget, hAbility, fCleaveDamage, self.cleave_starting_width, fCleaveEndWidth, fDistance, "particles/items_fx/battlefury_cleave.vpcf")

		if self.crit_chance > 0 then
			local iParticleID = ParticleManager:CreateParticle("particles/items/flame_reaper.vpcf", PATTACH_CUSTOMORIGIN, hParent)
			ParticleManager:SetParticleControlTransformForward(iParticleID, 0, hParent:GetAbsOrigin(), (hTarget:GetAbsOrigin() - hParent:GetAbsOrigin()):Normalized())
			if hParent:IsRangedAttacker() then
				ParticleManager:SetParticleControl(iParticleID, 1, Vector(0.06, 0, 0))
			else
				ParticleManager:SetParticleControl(iParticleID, 1, Vector(0.12, 0, 0))
			end
			ParticleManager:ReleaseParticleIndex(iParticleID)
		end

		if IsInToolsMode() then
			--绘制分裂区域
			local vStart = hParent:GetAbsOrigin()
			local vDirection = hTarget:GetAbsOrigin() - vStart
			vDirection.z = 0
			vDirection = vDirection:Normalized()
			if vDirection == Vector(0, 0, 0) then
				vDirection = hParent:GetForwardVector()
			end

			local vEnd = vStart + vDirection * fDistance
			local v = Rotation2D(vDirection, math.rad(90))
			local tPolygon = {
				vStart + v * self.cleave_starting_width,
				vEnd + v * fCleaveEndWidth,
				vEnd - v * fCleaveEndWidth,
				vStart - v * self.cleave_starting_width
			}
			DebugDrawLine(tPolygon[1], tPolygon[2], 255, 255, 255, true, hParent:GetSecondsPerAttack(false))
			DebugDrawLine(tPolygon[2], tPolygon[3], 255, 255, 255, true, hParent:GetSecondsPerAttack(false))
			DebugDrawLine(tPolygon[3], tPolygon[4], 255, 255, 255, true, hParent:GetSecondsPerAttack(false))
			DebugDrawLine(tPolygon[4], tPolygon[1], 255, 255, 255, true, hParent:GetSecondsPerAttack(false))
		end

		if hTarget:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
			hParent:AddNewModifier(hParent, hAbility, "modifier_item_last_laugh_disable", { duration = self.disable_duration })
		end
	end
end
function modifier_item_last_laugh:GetModifierDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	if IsServer() then
		local hTarget = params.target
		if IsValid(hTarget) and IsValid(hParent) then
			if hTarget:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS and not hParent:HasModifier("modifier_item_last_laugh_disable") then
				hParent:AddNewModifier(hParent, hAbility, "modifier_item_last_laugh_disable", { duration = self.disable_duration })
			end
		end
	end
	if IsValid(hParent) and hParent:HasModifier("modifier_item_last_laugh_disable") then
		return self.quelling_bonus * (100 - self.hero_pct_reduction) * 0.01
	else
		return self.quelling_bonus
	end
end
function modifier_item_last_laugh:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_damage
end
function modifier_item_last_laugh:GetModifierPhysicalArmorBonus(params)
	return self.bonus_armor
end
function modifier_item_last_laugh:GetModifierAttackSpeedBonus_Constant(params)
	return self.bonus_attack_speed
end
function modifier_item_last_laugh:GetModifierMoveSpeedBonus_Special_Boots()
	return self.bonus_movement_speed
end
function modifier_item_last_laugh:GetModifierAttackRangeBonus()
	local hParent = self:GetParent()
	if IsValid(hParent) then
		if hParent:IsRangedAttacker() then
			return self.bonus_attack_range
		else
			return self.bonus_attack_range_melee
		end
	end
end
function modifier_item_last_laugh:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movement_speed_pct
end
function modifier_item_last_laugh:GetModifierPreAttack_CriticalStrike(params)
	local hParent = self:GetParent()
	local fChance = self.crit_chance
	local fDamage = self.crit_multiplier

	if PRD(hParent, fChance, "modifier_item_last_laugh") then
		return fDamage
	end
end
function modifier_item_last_laugh:GetModifierConstantHealthRegen()
	return self.bonus_health_regen
end
function modifier_item_last_laugh:GetModifierConstantHealthRegen()
	return self.bonus_mana_regen
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_last_laugh_active == nil then
	modifier_item_last_laugh_active = class({})
end
function modifier_item_last_laugh_active:IsHidden()
	return false
end
function modifier_item_last_laugh_active:IsDebuff()
	return false
end
function modifier_item_last_laugh_active:IsPurgable()
	return false
end
function modifier_item_last_laugh_active:IsPurgeException()
	return false
end
function modifier_item_last_laugh_active:OnCreated(params)
	self.phase_movement_speed_pct = self:GetAbilitySpecialValueFor("phase_movement_speed_pct")
	if IsServer() then
	end
end
function modifier_item_last_laugh_active:OnRefresh(params)
	self.phase_movement_speed_pct = self:GetAbilitySpecialValueFor("phase_movement_speed_pct")
	if IsServer() then
	end
end
function modifier_item_last_laugh_active:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_last_laugh_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TURN_RATE_OVERRIDE,
	}
end
function modifier_item_last_laugh_active:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
	}
end
function modifier_item_last_laugh_active:GetModifierTurnRate_Override()
	return 1
end
function modifier_item_last_laugh_active:GetModifierMoveSpeedBonus_Percentage()
	return self.phase_movement_speed_pct
end
function modifier_item_last_laugh_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_last_laugh_active:GetEffectName()
	return "particles/items2_fx/phase_boots.vpcf"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_last_laugh_disable == nil then
	modifier_item_last_laugh_disable = class({})
end
function modifier_item_last_laugh_disable:IsHidden()
	return false
end
function modifier_item_last_laugh_disable:IsDebuff()
	return true
end
function modifier_item_last_laugh_disable:IsPurgable()
	return false
end
function modifier_item_last_laugh_disable:IsPurgeException()
	return false
end