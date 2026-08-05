--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_guild = class({})

function modifier_guild:IsHidden()
	return true
end

function modifier_guild:IsPurgable()
	return false
end

function modifier_guild:RemoveOnDeath()
	return false
end

function modifier_guild:SetupEmptyTalents()
	self.bossGold = 0
	self.bossExp = 0
	self.attributesPerLevel = 0
	self.increasedExp = 0
	self.doubleBuffChance = 0
	self.nonZeroStatsEquipmentChance = 0
	self.startingAegis = 0
end

function modifier_guild:SetupTalents(guildData)
	local talentsLevelLookup = {}

	local guildPowerMult = 1 + math.max(0, guilds:GetGuildPowerValue(guildData.talents.guild_power or 0) / 100)

	self.bossGold = guilds:GetConfigTalentValueByLevel("boss_gold", guildData.talents.boss_gold or 0) * guildPowerMult
	self.bossExp = guilds:GetConfigTalentValueByLevel("boss_exp", guildData.talents.boss_exp or 0) * guildPowerMult
	self.attributesPerLevel = guilds:GetConfigTalentValueByLevel(
		"attributes_per_level",
		guildData.talents.attributes_per_level or 0
	) * guildPowerMult
	self.increasedExp = guilds:GetConfigTalentValueByLevel("increased_exp", guildData.talents.increased_exp or 0)
		* guildPowerMult
	self.doubleBuffChance = math.floor(
		guilds:GetConfigTalentValueByLevel("double_buff_chance", guildData.talents.double_buff_chance or 0)
			* guildPowerMult
	)
	self.nonZeroStatsEquipmentChance = math.floor(
		guilds:GetConfigTalentValueByLevel(
			"non_zero_stats_equipment_chance",
			guildData.talents.non_zero_stats_equipment_chance or 0
		) * guildPowerMult
	)
	self.startingAegis = math.floor(
		guilds:GetConfigTalentValueByLevel("starting_aegis", guildData.talents.starting_aegis or 0) * guildPowerMult
	)
	self.startingGold = guilds:GetConfigTalentValueByLevel("starting_gold", guildData.talents.starting_gold or 0)
		* guildPowerMult
end

function modifier_guild:OnCreated()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if not parent or not parent.guildData then
		-- в теории не должно никогда случится
		self:SetupEmptyTalents()
		return
	end

	self:SetupTalents(parent.guildData)
	self:GiveSpawnBonus()
end

function modifier_guild:GiveSpawnBonus()
	if not IsServer() then
		return
	end

	parent = self:GetParent()
	if parent.__gotGuildSpawnBonus then
		return
	end

	parent.__gotGuildSpawnBonus = true

	if self.startingGold > 0 then
		parent:ModifyGold(self.startingGold, true, 0)
	end
	if self.startingAegis > 0 then
		local hModifierAegis = self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_aegis", {})
		hModifierAegis:SetStackCount(self.startingAegis)
	end
end

function modifier_guild:DeclareFunctions()
	local funcs = {
		-- MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
		-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function modifier_guild:OnBossKill()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if not parent then
		return
	end

	if self.bossGold > 0 then
		parent:ModifyGold(self.bossGold, true, 0)
	end
	if self.bossExp > 0 then
		parent:AddExperience(self.bossExp, DOTA_ModifyXP_Unspecified, false, false)
	end
end

if IsServer() then
	-- function modifier_guild:GetModifierIncomingDamage_Percentage()
	-- 	return -0.25*self.reward_2
	-- end

	function modifier_guild:GetModifierPercentageExpRateBoost()
		return increasedExp
	end

	-- function modifier_guild:GetModifierDamageOutgoing_Percentage()
	-- 	return 0.25*self.reward_5
	-- end

	function modifier_guild:GetModifierBonusStats_Agility()
		return self.attributesPerLevel * self:GetCaster():GetLevel()
	end

	function modifier_guild:GetModifierBonusStats_Strength()
		return self.attributesPerLevel * self:GetCaster():GetLevel()
	end

	function modifier_guild:GetModifierBonusStats_Intellect()
		return self.attributesPerLevel * self:GetCaster():GetLevel()
	end
end