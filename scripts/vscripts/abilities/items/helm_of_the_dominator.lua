--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_helm_of_the_dominator_custom = item_helm_of_the_dominator_custom or {
	GetIntrinsicModifierName = function() return "modifier_item_helm_of_the_dominator_custom" end,
	JUNGLE_UNITS = {
		--"npc_dota_neutral_kobold",
		--"npc_dota_neutral_kobold_tunneler",
		"npc_dota_neutral_kobold_taskmaster",
		--"npc_dota_neutral_centaur_outrunner",
		"npc_dota_neutral_centaur_khan",
		--"npc_dota_neutral_fel_beast",
		"npc_dota_neutral_polar_furbolg_champion",
		"npc_dota_neutral_polar_furbolg_ursa_warrior",
		"npc_dota_neutral_warpine_raider",
		"npc_dota_neutral_mud_golem",
		--"npc_dota_neutral_mud_golem_split",
		--"npc_dota_neutral_mud_golem_split_doom",
		--"npc_dota_neutral_ogre_mauler",
		"npc_dota_neutral_ogre_magi",
		--"npc_dota_neutral_giant_wolf",
		"npc_dota_neutral_alpha_wolf",
		--"npc_dota_neutral_wildkin",
		"npc_dota_neutral_enraged_wildkin",
		"npc_dota_neutral_satyr_soulstealer",
		"npc_dota_neutral_satyr_hellcaller",
		--"npc_dota_neutral_jungle_stalker",
		"npc_dota_neutral_gnoll_assassin",
		"npc_dota_neutral_ghost",
		--"npc_dota_neutral_dark_troll",
		"npc_dota_neutral_dark_troll_warlord",
		"npc_dota_neutral_satyr_trickster",
		--"npc_dota_neutral_forest_troll_berserker",
		"npc_dota_neutral_forest_troll_high_priest",
		--"npc_dota_neutral_harpy_scout",
		"npc_dota_neutral_harpy_storm",
	},
	JUNGLE_ANCIENT_UNITS = {
		"npc_dota_neutral_black_drake",
		"npc_dota_neutral_black_dragon",
		--"npc_dota_neutral_prowler_acolyte",		-- deprecated
		--"npc_dota_neutral_prowler_shaman",		-- deprecated
		"npc_dota_neutral_rock_golem",
		"npc_dota_neutral_granite_golem",
		"npc_dota_neutral_big_thunder_lizard",
		"npc_dota_neutral_small_thunder_lizard",
		"npc_dota_neutral_ice_shaman",
		"npc_dota_neutral_frostbitten_golem",
	},
}

item_helm_of_the_overlord_custom = item_helm_of_the_overlord_custom or item_helm_of_the_dominator_custom

function item_helm_of_the_dominator_custom:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local casterTeam = caster:GetTeamNumber()

	if not caster.hotd_dominated_units then
		caster.hotd_dominated_units = {}
	end

	if #caster.hotd_dominated_units >= self:GetSpecialValueFor("count_limit") then
		for k, v in ipairs(caster.hotd_dominated_units) do
			if IsValidEntity(v) and v:IsAlive() then
				v:ForceKill(false)
				table.remove(caster.hotd_dominated_units, k)
				break
			end
		end
	end

	local unit = self:GetCursorTarget()
	local cast_gold_bounty = 0

	if IsValidEntity(unit) then
		unit:SetTeam(casterTeam)
		unit:SetOwner(caster)
		cast_gold_bounty = unit:GetGoldBounty()
	else
		local positionTarget = self:GetCursorPosition()
		local jungle

		-- include ancients for Helm of the dominator
		if self:GetLevel() == 2 then
			jungle = self.JUNGLE_ANCIENT_UNITS
		else
			jungle = self.JUNGLE_UNITS
		end

		if not self.unitNames or #self.unitNames == 0 then
			self.unitNames = table.shuffled(jungle)
		end

		local unitName = table.remove(self.unitNames)

		unit = CreateUnitByName(unitName, positionTarget, true, caster, caster, casterTeam)
		ParticleManager:CreateParticle("particles/dev/library/base_dust_hit.vpcf", PATTACH_ROOTBONE_FOLLOW, unit)

		cast_gold_bounty = unit:GetGoldBounty()
	end

	PlayerResource:ModifyGold(caster:GetPlayerOwnerID(), cast_gold_bounty, true, 0)
	SendOverheadEventMessage(caster, OVERHEAD_ALERT_GOLD, caster, cast_gold_bounty, nil)

	table.insert(caster.hotd_dominated_units, unit)

	unit:SetControllableByPlayer(caster:GetPlayerOwnerID(), true)
	unit:EmitSound("DOTA_Item.HotD.Activate")

	local goldBounty = self:GetSpecialValueFor("bounty_gold")
	local speedBase = self:GetSpecialValueFor("speed_base")
	local healthMin = self:GetSpecialValueFor("health_min")

	unit:SetMinimumGoldBounty(goldBounty)
	unit:SetMaximumGoldBounty(goldBounty)
	unit:SetBaseMoveSpeed(math.max(speedBase, unit:GetBaseMoveSpeed()))

	if unit:GetMaxHealth() < healthMin then
		unit:SetBaseMaxHealth(healthMin)
		unit:SetMaxHealth(healthMin)
		unit:SetHealth(healthMin)
	end

	local level = GetCreepAbilityLevel()
	if level > 1 then
		for i = 0, unit:GetAbilityCount() - 1 do
			local ability = unit:GetAbilityByIndex(i)
			if ability and not ability:IsHidden() then ability:SetLevel(level) end
		end
	end


	unit:AddNewModifier(self:GetCaster(), self, "modifier_item_helm_of_the_dominator_custom_dominated", {})
end

LinkLuaModifier("modifier_item_helm_of_the_dominator_custom", "abilities/items/helm_of_the_dominator", LUA_MODIFIER_MOTION_NONE)

modifier_item_helm_of_the_dominator_custom = modifier_item_helm_of_the_dominator_custom or {
	IsHidden = function() return true end,
	IsPurgable = function() return false end,
	RemoveOnDeath = function() return false end,
	GetAttributes = function() return MODIFIER_ATTRIBUTE_MULTIPLE end,

	-- IsAura = function(self)
	-- 	if self:GetCaster():HasModifier("modifier_item_vladmir_aura") == false and self:GetStackCount() == 2 then
	-- 		return true
	-- 	end

	-- 	return false
	-- end,
	-- GetModifierAura = function() return "modifier_item_helm_of_the_overlord_custom_aura" end,
	-- GetAuraRadius = function(self) return self.aura_radius or 0 end,
	-- GetAuraSearchTeam = function() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end,
	-- GetAuraSearchType = function() return DOTA_UNIT_TARGET_ALL end,

	GetModifierBonusStats_Strength = function(self) return self.bonus_stats end,
	GetModifierBonusStats_Agility = function(self) return self.bonus_stats end,
	GetModifierBonusStats_Intellect = function(self) return self.bonus_stats end,
	GetModifierPhysicalArmorBonus = function(self) return self.bonus_armor end,
	GetModifierConstantHealthRegen = function(self) return self.bonus_regen end,
}

function modifier_item_helm_of_the_dominator_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_helm_of_the_dominator_custom:OnCreated()
	if not IsServer() then return end

	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	-- self:SetStackCount(self:GetAbility():GetLevel())
	self:OnRefresh()
end

function modifier_item_helm_of_the_dominator_custom:OnRefresh()
	if not IsValidEntity(self.ability) then return end

	self.aura_radius = self.ability:GetSpecialValueFor("aura_radius")
	self.bonus_stats = self.ability:GetSpecialValueFor("bonus_stats")
	self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
	self.bonus_regen = self.ability:GetSpecialValueFor("bonus_regen")
end

function modifier_item_helm_of_the_dominator_custom:OnRemoved()
	if not IsServer() then return end

	for k, v in ipairs(self.caster.hotd_dominated_units or {}) do
		if IsValidEntity(v) and v:IsAlive() then
			v:ForceKill(false)
			table.remove(self.caster.hotd_dominated_units, k)
		end
	end
end


LinkLuaModifier("modifier_item_helm_of_the_dominator_custom_dominated", "abilities/items/helm_of_the_dominator", LUA_MODIFIER_MOTION_NONE)

modifier_item_helm_of_the_dominator_custom_dominated = {
	IsHidden = function(self) return true end,
	IsPurgable = function(self) return false end,
	GetModifierPreAttack_BonusDamage = function(self) return self.creep_bonus_damage end,
	GetModifierConstantHealthRegen = function(self) return self.creep_bonus_hp_regen end,
	GetModifierConstantManaRegen = function(self) return self.creep_bonus_mp_regen end,
	GetModifierPhysicalArmorBonus = function(self) return self.creep_bonus_armor end,
	GetModifierModelScale = function(self) return self.bonus_model_scale end,
	GetEffectName = function(self) return "particles/items5_fx/helm_of_the_dominator_buff.vpcf" end,
}

function modifier_item_helm_of_the_dominator_custom_dominated:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_item_helm_of_the_dominator_custom_dominated:CheckState()
	return {
		[MODIFIER_STATE_DOMINATED] = true,
	}
end

function modifier_item_helm_of_the_dominator_custom_dominated:OnCreated()
	local ability = self:GetAbility()

	self.creep_bonus_damage = ability:GetSpecialValueFor("creep_bonus_damage")
	self.creep_bonus_hp_regen = ability:GetSpecialValueFor("creep_bonus_hp_regen")
	self.creep_bonus_mp_regen = ability:GetSpecialValueFor("creep_bonus_mp_regen")
	self.creep_bonus_armor = ability:GetSpecialValueFor("creep_bonus_armor")
	self.bonus_model_scale = ability:GetSpecialValueFor("bonus_model_scale")
end

-- LinkLuaModifier("modifier_item_helm_of_the_overlord_custom_aura", "abilities/items/helm_of_the_dominator", LUA_MODIFIER_MOTION_NONE)

-- modifier_item_helm_of_the_overlord_custom_aura = modifier_item_helm_of_the_overlord_custom_aura or {
-- 	GetModifierPhysicalArmorBonus = function(self) return self.armor_aura end,
-- 	GetModifierConstantManaRegen = function(self) return self.mana_regen_aura end,
-- 	GetModifierAttackSpeedBonus_Constant = function(self) return self.lifesteal_aura end,
-- 	GetModifierBaseDamageOutgoing_Percentage = function(self) return self.damage_aura end,
-- 	OnTooltip = function(self) return self.lifesteal_aura end,
-- }

-- function modifier_item_helm_of_the_overlord_custom_aura:DeclareFunctions()
-- 	return {
-- 		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
-- 		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
-- 		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
-- 		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
-- 		MODIFIER_PROPERTY_TOOLTIP,
-- 	}
-- end

-- function modifier_item_helm_of_the_overlord_custom_aura:OnCreated()
-- 	local ability = self:GetAbility()

-- 	self.armor_aura = ability:GetSpecialValueFor("armor_aura")
-- 	self.mana_regen_aura = ability:GetSpecialValueFor("mana_regen_aura")
-- 	self.lifesteal_aura = ability:GetSpecialValueFor("lifesteal_aura")
-- 	self.damage_aura = ability:GetSpecialValueFor("damage_aura")
-- 	self.creep_reduction = ability:GetSpecialValueFor("creep_lifesteal_reduction_pct") * 0.01
-- end

-- function modifier_item_helm_of_the_overlord_custom_aura:GetModifierProcAttack_Feedback(kv)
-- 	if not IsServer() then return end
-- 	if kv.damage <= 0 then return end
-- 	if kv.target:IsBuilding() then return end

-- 	local steal = kv.damage * (self.lifesteal_aura / 100)

-- 	if kv.target:IsCreep() then
-- 		steal = steal * self.creep_reduction
-- 	end

-- 	kv.attacker:HealWithParams(steal, kv.attacker, true, true, kv.attacker, false) -- this function still doesn't do its particle magic

-- 	local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_OVERHEAD_FOLLOW, kv.attacker)
-- 	ParticleManager:SetParticleControl(particle, 0, kv.attacker:GetAbsOrigin())
-- 	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, kv.attacker, steal, nil)
-- end