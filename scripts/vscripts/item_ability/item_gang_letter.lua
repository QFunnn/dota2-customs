--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gang_letter", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_effect", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_gang_letter == nil then
	item_gang_letter = class({})
end
function item_gang_letter:GetIntrinsicModifierName()
	return "modifier_item_gang_letter"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_gang_letter == nil then
	modifier_item_gang_letter = class({})
end
function modifier_item_gang_letter:IsDebuff(params)
	return false
end
function modifier_item_gang_letter:IsHidden(params)
	return true
end
function modifier_item_gang_letter:IsPurgable(params)
	return false
end
function modifier_item_gang_letter:IsPurgeException(params)
	return false
end
function modifier_item_gang_letter:RemoveOnDeath()
	return false
end
function modifier_item_gang_letter:IsAura()
	return true
end
function modifier_item_gang_letter:GetAuraRadius()
	return self.aura_radius
end
function modifier_item_gang_letter:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_item_gang_letter:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_gang_letter:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER
end
function modifier_item_gang_letter:GetModifierAura()
	return "modifier_item_gang_letter_effect"
end
function modifier_item_gang_letter:IsAuraActiveOnDeath()
	return true
end
function modifier_item_gang_letter:GetAuraEntityReject(hEntity)
	local hParent = self:GetParent()
	if hEntity:GetUnitLabel() == "spirit_bear" then
		return false
	end
	if hEntity:IsHero() then
		return true
	end
	if hParent:GetPlayerOwnerID() ~= hEntity:GetPlayerOwnerID() then
		return true
	end
	if (not hEntity:HasAttackCapability()) and (not hEntity:HasMovementCapability()) and (hEntity:GetUnitName() ~= "npc_dota_zeus_cloud") then
		return true
	end
	-- 神圣劝化单位不享受效果
	if hEntity.by_chen_holy_persuasion then
		return true
	end
	return false
end
function modifier_item_gang_letter:OnCreated(params)
	-- 静态属性
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_movement_speed = self:GetAbilitySpecialValueFor("bonus_movement_speed")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_spell_amp = self:GetAbilitySpecialValueFor("bonus_spell_amp")
	self.bonus_hp = self:GetAbilitySpecialValueFor("bonus_hp")
	self.bonus_hp_regen_pct = self:GetAbilitySpecialValueFor("bonus_hp_regen_pct")
	-- 光环相关
	self.aura_radius = self:GetAbilitySpecialValueFor("aura_radius")
	--鬼故事特有
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	-- 大餐特有
	self.link_damage = self:GetAbilitySpecialValueFor("link_damage")
	if IsServer() then
	end
end
function modifier_item_gang_letter:OnRefresh(params)
	-- 静态属性
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_movement_speed = self:GetAbilitySpecialValueFor("bonus_movement_speed")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_spell_amp = self:GetAbilitySpecialValueFor("bonus_spell_amp")
	self.bonus_hp = self:GetAbilitySpecialValueFor("bonus_hp")
	self.bonus_hp_regen_pct = self:GetAbilitySpecialValueFor("bonus_hp_regen_pct")
	-- 光环相关
	self.aura_radius = self:GetAbilitySpecialValueFor("aura_radius")
	--鬼故事特有
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	-- 大餐特有
	self.link_damage = self:GetAbilitySpecialValueFor("link_damage")
	if IsServer() then
	end
end
function modifier_item_gang_letter:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_gang_letter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function modifier_item_gang_letter:GetModifierBonusStats_Strength(params)
	return self.bonus_str
end
function modifier_item_gang_letter:GetModifierBonusStats_Agility(params)
	return self.bonus_agi
end
function modifier_item_gang_letter:GetModifierBonusStats_Intellect(params)
	return self.bonus_int
end
function modifier_item_gang_letter:GetModifierMoveSpeedBonus_Special_Boots(params)
	return self.bonus_movement_speed
end
function modifier_item_gang_letter:GetModifierAttackSpeedBonus_Constant(params)
	return self.bonus_attack_speed
end
function modifier_item_gang_letter:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_damage
end
function modifier_item_gang_letter:GetModifierSpellAmplify_Percentage(params)
	return self.bonus_spell_amp
end
function modifier_item_gang_letter:GetModifierHealthBonus(params)
	return self.bonus_hp
end
function modifier_item_gang_letter:GetModifierHealthRegenPercentage(params)
	return self.bonus_hp_regen_pct
end
function modifier_item_gang_letter:GetModifierPhysicalArmorBonus(params)
	return self.bonus_armor
end
function modifier_item_gang_letter:GetModifierIncomingDamage_Percentage(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local hAttacker = params.attacker
	local fDamage = params.damage
	local damage_type = params.damage_type
	local inflictor = params.inflictor
	if IsServer() then
		if self.link_damage > 0 and fDamage > 0 then
			if IsValid(hAbility) and hAbility:IsCooldownReady() and IsValid(hAttacker) and IsValid(hParent) then
				local hp_max = 0
				local hUnit
				local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.aura_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
				if #units > 0 then
					for _, unit in pairs(units) do
						if IsValid(unit) and unit:IsAlive() and unit:HasModifier("modifier_item_gang_letter_effect") then
							local hp = unit:GetHealth()
							if hp > hp_max then
								hp_max = hp
								hUnit = unit
							end
						end
					end
					if IsValid(hUnit) then
						local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
						ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
						ParticleManager:SetParticleControlEnt(iParticleID, 1, hUnit, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
						ParticleManager:ReleaseParticleIndex(iParticleID)

						ApplyDamage({
							victim = hUnit,
							attacker = hAttacker,
							damage = fDamage * self.link_damage * 0.01,
							damage_type = DAMAGE_TYPE_PURE,
							ability = inflictor,
							damage_flags = DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
						})
						EmitSoundOn("Hero_Warlock.FatalBondsDamage", hUnit)
						EmitSoundOn("Hero_Warlock.FatalBondsDamage", hParent)
						hAbility:UseResources(false, false, false, true)
						return -self.link_damage
					end
				end
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_gang_letter_effect == nil then
	modifier_item_gang_letter_effect = class({})
end
function modifier_item_gang_letter_effect:IsDebuff(params)
	return false
end
function modifier_item_gang_letter_effect:IsHidden(params)
	return false
end
function modifier_item_gang_letter_effect:IsPurgable(params)
	return false
end
function modifier_item_gang_letter_effect:IsPurgeException(params)
	return false
end
function modifier_item_gang_letter_effect:OnCreated(params)
	self.aura_bonus_damage_str = self:GetAbilitySpecialValueFor("aura_bonus_damage_str")
	self.aura_bonus_damage_int = self:GetAbilitySpecialValueFor("aura_bonus_damage_int")
	self.aura_bonus_damage_agi = self:GetAbilitySpecialValueFor("aura_bonus_damage_agi")
	self.aura_bonus_spell_amp_int = self:GetAbilitySpecialValueFor("aura_bonus_spell_amp_int")
	self.aura_bonus_magical_damage_int = self:GetAbilitySpecialValueFor("aura_bonus_magical_damage_int")
	self.aura_bonus_magical_resist_int = self:GetAbilitySpecialValueFor("aura_bonus_magical_resist_int")
	self.aura_bonus_attackspeed_agi = self:GetAbilitySpecialValueFor("aura_bonus_attackspeed_agi")
	self.aura_bonus_armor_agi = self:GetAbilitySpecialValueFor("aura_bonus_armor_agi")
	self.aura_bonus_hp_str = self:GetAbilitySpecialValueFor("aura_bonus_hp_str")
	self.aura_bonus_return_str = self:GetAbilitySpecialValueFor("aura_bonus_return_str")
	self.aura_bonus_return_str_cd = self:GetAbilitySpecialValueFor("aura_bonus_return_str_cd")
	self.aura_model_scale = self:GetAbilitySpecialValueFor("aura_model_scale")
	--幽灵特有
	self.aura_projectile_speed = self:GetAbilitySpecialValueFor("aura_projectile_speed")
	self.aura_spell_amp_constant = self:GetAbilitySpecialValueFor("aura_spell_amp_constant")
	--大餐特有
	self.aura_hp_regen_pct = self:GetAbilitySpecialValueFor("aura_hp_regen_pct")
	self.aura_lifesteal = self:GetAbilitySpecialValueFor("aura_lifesteal")
	self.aura_bonus_damage_pct = self:GetAbilitySpecialValueFor("aura_bonus_damage_pct")
	self.aura_bonus_armor = self:GetAbilitySpecialValueFor("aura_bonus_armor")
	self.aura_lifesteal_other = self:GetAbilitySpecialValueFor("aura_lifesteal_other")
	-- 战书特有
	self.aura_bash_chance = self:GetAbilitySpecialValueFor("aura_bash_chance")
	self.aura_bash_duration = self:GetAbilitySpecialValueFor("aura_bash_duration")
	self.aura_bash_cooldown = self:GetAbilitySpecialValueFor("aura_bash_cooldown")
	self.aura_accuracy_chance = self:GetAbilitySpecialValueFor("aura_accuracy_chance")
	--机票专有
	self.aura_crit_chance = self:GetAbilitySpecialValueFor("aura_crit_chance")
	self.aura_crit_damage = self:GetAbilitySpecialValueFor("aura_crit_damage")
	self.aura_attack_range = self:GetAbilitySpecialValueFor("aura_attack_range")
	self.aura_attack_range_melee = self:GetAbilitySpecialValueFor("aura_attack_range_melee")
	if IsServer() then
		local hParent = self:GetParent()
		self.LastTime = 0
		if IsValid(hParent) and hParent:IsRealHero() then
			self.bonus_health = 0
			self:SetHasCustomTransmitterData(true)
			self:StartIntervalThink(1)
			self:OnIntervalThink()
		end
	end
end
function modifier_item_gang_letter_effect:OnRefresh(params)
	self.aura_bonus_damage_str = self:GetAbilitySpecialValueFor("aura_bonus_damage_str")
	self.aura_bonus_damage_int = self:GetAbilitySpecialValueFor("aura_bonus_damage_int")
	self.aura_bonus_damage_agi = self:GetAbilitySpecialValueFor("aura_bonus_damage_agi")
	self.aura_bonus_spell_amp_int = self:GetAbilitySpecialValueFor("aura_bonus_spell_amp_int")
	self.aura_bonus_magical_damage_int = self:GetAbilitySpecialValueFor("aura_bonus_magical_damage_int")
	self.aura_bonus_magical_resist_int = self:GetAbilitySpecialValueFor("aura_bonus_magical_resist_int")
	self.aura_bonus_attackspeed_agi = self:GetAbilitySpecialValueFor("aura_bonus_attackspeed_agi")
	self.aura_bonus_armor_agi = self:GetAbilitySpecialValueFor("aura_bonus_armor_agi")
	self.aura_bonus_hp_str = self:GetAbilitySpecialValueFor("aura_bonus_hp_str")
	self.aura_bonus_return_str = self:GetAbilitySpecialValueFor("aura_bonus_return_str")
	self.aura_bonus_return_str_cd = self:GetAbilitySpecialValueFor("aura_bonus_return_str_cd")
	self.aura_model_scale = self:GetAbilitySpecialValueFor("aura_model_scale")
	--幽灵特有
	self.aura_projectile_speed = self:GetAbilitySpecialValueFor("aura_projectile_speed")
	self.aura_spell_amp_constant = self:GetAbilitySpecialValueFor("aura_spell_amp_constant")
	--大餐特有
	self.aura_hp_regen_pct = self:GetAbilitySpecialValueFor("aura_hp_regen_pct")
	self.aura_lifesteal = self:GetAbilitySpecialValueFor("aura_lifesteal")
	self.aura_bonus_damage_pct = self:GetAbilitySpecialValueFor("aura_bonus_damage_pct")
	self.aura_bonus_armor = self:GetAbilitySpecialValueFor("aura_bonus_armor")
	self.aura_lifesteal_other = self:GetAbilitySpecialValueFor("aura_lifesteal_other")
	-- 战书特有
	self.aura_bash_chance = self:GetAbilitySpecialValueFor("aura_bash_chance")
	self.aura_bash_duration = self:GetAbilitySpecialValueFor("aura_bash_duration")
	self.aura_bash_cooldown = self:GetAbilitySpecialValueFor("aura_bash_cooldown")
	self.aura_accuracy_chance = self:GetAbilitySpecialValueFor("aura_accuracy_chance")
	--机票专有
	self.aura_crit_chance = self:GetAbilitySpecialValueFor("aura_crit_chance")
	self.aura_crit_damage = self:GetAbilitySpecialValueFor("aura_crit_damage")
	self.aura_attack_range = self:GetAbilitySpecialValueFor("aura_attack_range")
	self.aura_attack_range_melee = self:GetAbilitySpecialValueFor("aura_attack_range_melee")
	if IsServer() then
		self.LastTime = 0
	end
end
function modifier_item_gang_letter_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_PRE_ATTACK,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
end
function modifier_item_gang_letter_effect:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = self.accuracy or false,
	}
end
function modifier_item_gang_letter_effect:OnIntervalThink()
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if IsValid(hCaster) and IsValid(hParent) then
		local fTrueMaxHealth = hParent:GetMaxHealth() - self.bonus_health
		self.bonus_health = math.floor(fTrueMaxHealth * hCaster:GetStrength() * self.aura_bonus_hp_str * 0.01)
		self:SendBuffRefreshToClients()
		hParent:CalculateStatBonus(true)
	end
end
function modifier_item_gang_letter_effect:AddCustomTransmitterData()
	return {
		bonus_health = self.bonus_health
	}
end
function modifier_item_gang_letter_effect:HandleCustomTransmitterData(t)
	self.bonus_health = t.bonus_health
end
function modifier_item_gang_letter_effect:GetModifierBaseDamageOutgoing_Percentage(params)
	local hCaster = self:GetCaster()
	if IsValid(hCaster) then
		return hCaster:GetStrength() * self.aura_bonus_damage_str + hCaster:GetIntellect(true) * self.aura_bonus_damage_int + hCaster:GetAgility() * self.aura_bonus_damage_agi + self.aura_bonus_damage_pct
	end
end
function modifier_item_gang_letter_effect:GetModifierExtraHealthPercentage(params)
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if IsValid(hCaster) and IsValid(hParent) then
		if not hParent:IsRealHero() then
			return hCaster:GetStrength() * self.aura_bonus_hp_str
		end
		if IsClient() then
			return hCaster:GetStrength() * self.aura_bonus_hp_str
		end
	end
end
function modifier_item_gang_letter_effect:GetModifierHealthBonus(params)
	return self.bonus_health or 0
end
function modifier_item_gang_letter_effect:GetModifierProcAttack_BonusDamage_Magical(params)
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	local hTarget = params.target
	if IsServer() then
		if IsValid(hCaster) then
			local fDamage = self.aura_bonus_magical_damage_int
			if hTarget:IsAttackImmune() and hParent:HasModifier("modifier_item_gang_ghost_letter") then
				fDamage = fDamage + hParent:GetAverageTrueAttackDamage(hParent)
			end
			fDamage = fDamage * (1 + hParent:GetSpellAmplification(false))
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, hTarget, fDamage, nil)
			return fDamage
		end
	end
end
function modifier_item_gang_letter_effect:GetModifierSpellAmplify_Percentage(params)
	local hCaster = self:GetCaster()
	local hInflictor = params.inflictor
	local hParent = self:GetParent()
	if IsValid(hCaster) then
		if IsServer() then
			if IsValid(hInflictor) and IsValid(hParent) then
				local sAbilityName = hInflictor:GetAbilityName()
				if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[sAbilityName] then
					return 0
				end
			end
		end
		return hCaster:GetIntellect(true) * self.aura_bonus_spell_amp_int + self.aura_spell_amp_constant
	end
end
function modifier_item_gang_letter_effect:GetModifierAttackSpeedBonus_Constant(params)
	local hCaster = self:GetCaster()
	if IsValid(hCaster) then
		return hCaster:GetAgility() * self.aura_bonus_attackspeed_agi
	end
end
function modifier_item_gang_letter_effect:GetModifierPhysicalArmorBonus(params)
	local hCaster = self:GetCaster()
	if IsValid(hCaster) then
		return hCaster:GetAgility() * self.aura_bonus_armor_agi + self.aura_bonus_armor
	end
end
function modifier_item_gang_letter_effect:GetModifierMagicalResistanceBonus(params)
	local hCaster = self:GetCaster()
	if IsValid(hCaster) then
		return hCaster:GetIntellect(true) * self.aura_bonus_magical_resist_int
	end
end
function modifier_item_gang_letter_effect:GetModifierModelScale()
	return self.aura_model_scale
end
function modifier_item_gang_letter_effect:GetModifierProjectileSpeedBonus()
	return self.aura_projectile_speed
end
function modifier_item_gang_letter_effect:GetModifierHealthRegenPercentage(params)
	return self.aura_hp_regen_pct
end
function modifier_item_gang_letter_effect:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	local fDamage = params.original_damage
	local hAbility = self:GetAbility()
	local hTarget = params.target

	if IsServer() then
		if IsValid(hParent) and IsValid(hAbility) and IsValid(hCaster) then
			if IsValid(hTarget) and hTarget:IsAlive() then
				if self.accuracy then
					EmitSoundOn("DOTA_Item.MKB.melee", hTarget)
				end
				if hAbility:IsCooldownReady() and self.aura_bash_chance > 0 and PRD(hCaster, self.aura_bash_chance, "modifier_item_gang_letter_effect") then
					hTarget:AddNewModifier(hTarget, hAbility, "modifier_bashed", { duration = self.aura_bash_duration * hTarget:GetStatusResistanceFactor(hParent) })
					if hTarget:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
						hAbility:UseResources(false, false, false, true)
					end
					EmitSoundOn("DOTA_Item.SkullBasher", hTarget)
				end
			end

			-- 如果伤害大于0则吸血
			if fDamage > 0 and self.aura_lifesteal > 0 then
				local fHealAmount = 1
				local fHealAmount_hero = 1

				if not hParent:IsOther() then
					fHealAmount = fDamage * self.aura_lifesteal * 0.01
					fHealAmount_hero = fHealAmount
				else
					fHealAmount_hero = fDamage * self.aura_lifesteal * 0.01 * (100 - self.aura_lifesteal_other) * 0.01
				end

				local iParticleID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
				ParticleManager:ReleaseParticleIndex(iParticleID)

				hParent:HealWithParams(fHealAmount, hAbility, true, true, hParent, false)

				local iParticleID2 = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
				ParticleManager:SetParticleControlEnt(iParticleID2, 1, hParent, PATTACH_ABSORIGIN_FOLLOW, nil, hParent:GetAbsOrigin(), true)
				ParticleManager:ReleaseParticleIndex(iParticleID2)

				hCaster:HealWithParams(fHealAmount_hero, hAbility, true, true, hParent, false)
			end
		end
	end
end
function modifier_item_gang_letter_effect:GetModifierIncomingDamage_Percentage(params)
	local hAttacker = params.attacker
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local damage_category = params.damage_category
	if IsServer() then
		if GameRules:GetGameTime() > self.LastTime + self.aura_bonus_return_str_cd then
			if damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and IsValid(hAttacker) and IsValid(hParent) and IsValid(hCaster) and IsValid(hAbility) and hAttacker:GetTeamNumber() ~= hParent:GetTeamNumber() then

				local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_return.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
				ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
				ParticleManager:SetParticleControlEnt(iParticleID, 1, hAttacker, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
				ParticleManager:ReleaseParticleIndex(iParticleID)
				ApplyDamage({
					victim = hAttacker,
					attacker = hParent,
					damage = hCaster:GetStrength() * self.aura_bonus_return_str,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					ability = hAbility,
					damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
				})
				self.LastTime = GameRules:GetGameTime()
			end
		end
	end
end
function modifier_item_gang_letter_effect:GetModifierPreAttack(params)
	if IsServer() then
		local hParent = self:GetParent()
		self.accuracy = PRD(hParent, self.aura_accuracy_chance, "modifier_item_gang_letter_effect")
	end
end
function modifier_item_gang_letter_effect:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() then
		local hParent = self:GetParent()
		local hTarget = params.target
		if IsValid(hParent) and IsValid(hTarget) and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
			if hTarget:IsFeared() or PRD(hParent, self.aura_crit_chance, "modifier_item_gang_letter_effect") then
				return self.aura_crit_damage
			end
		end
	end
end
function modifier_item_gang_letter_effect:GetModifierAttackRangeBonus(params)
	if IsServer() then
		local hParent = self:GetParent()
		if hParent:IsRangedAttacker() then
			return self.aura_attack_range
		else
			return self.aura_attack_range_melee
		end
	end
end