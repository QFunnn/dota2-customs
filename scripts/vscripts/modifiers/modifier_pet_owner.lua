--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local base_stats = {
	arm = 1,
	as = 3,
	sdm = 0.8,
	hpmp = 40,
	stats = 0.5,
	dmg = 10,
	ms = 2,
	cd = 0.8,
	mr = 1,
	hpr = 3.3,
	eva = 0.8,
	crit = 2,
}

modifier_pet_owner = class({})

function modifier_pet_owner:IsHidden()
	return true
end

function modifier_pet_owner:IsPurgable()
	return false
end

function modifier_pet_owner:RemoveOnDeath()
	return false
end

function modifier_pet_owner:OnCreated(data)
	if not IsServer() then
		return
	end

	self.pets_boosts = {
		arm = 0, --
		as = 0, --
		sdm = 0, --
		hpmp = 0,
		stats = 0,
		dmg = 0, --
		ms = 0, --
		cd = 0, --
		mr = 0, --
		hpr = 3.3,
		eva = 0, --
		crit = 0,
	}

	tab = find_boost_by_name(data.pet)
	local multiplier = (data.pet == "item_jackpot_pet2") and 1.25 or 1.0
	for _, stat in ipairs(tab) do
		if base_stats[stat] then
			self.pets_boosts[stat] = base_stats[stat] * multiplier
		end
	end

	self.hero_pet = CreateUnitByName(
		string.gsub(data.pet, "item_", ""),
		self:GetParent():GetOrigin() + RandomVector(RandomInt(50, 150)),
		true,
		self:GetParent(),
		self:GetParent(),
		self:GetParent():GetTeam()
	)
	-- self.hero_pet:SetControllableByPlayer(self:GetParent():GetPlayerID(), true)
	self.hero_pet:SetOwner(self:GetParent())
	self.hero_pet:AddNewModifier(self.hero_pet, nil, "modifier_pets", {})
	self:SetHasCustomTransmitterData(true)
end

function modifier_pet_owner:AddCustomTransmitterData()
	return {
		pets_boosts = self.pets_boosts,
	}
end

function modifier_pet_owner:HandleCustomTransmitterData(data)
	self.pets_boosts = data.pets_boosts
end

function modifier_pet_owner:OnRemoved()
	UTIL_Remove(self.hero_pet)
end

function modifier_pet_owner:OnDestroy()
	UTIL_Remove(self.hero_pet)
end

function find_boost_by_name(pet)
	for tabNumber, tab in pairs(_G.game_shop) do
		for itemNumber, item in pairs(tab) do
			if type(item) == "table" and item.itemname == pet then
				return item.boost
			end
		end
	end
end

function modifier_pet_owner:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,

		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,

		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_EVASION_CONSTANT,

		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_pet_owner:GetModifierPhysicalArmorBonus()
	return self.pets_boosts.arm * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierAttackSpeedBonus_Constant()
	return self.pets_boosts.as * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierSpellAmplify_Percentage()
	return self.pets_boosts.sdm * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierHealthBonus()
	return self.pets_boosts.hpmp * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierManaBonus()
	return self.pets_boosts.hpmp * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierBonusStats_Strength()
	return self.pets_boosts.stats * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierBonusStats_Agility()
	return self.pets_boosts.stats * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierBonusStats_Intellect()
	return self.pets_boosts.stats * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierPreAttack_BonusDamage()
	return self.pets_boosts.dmg * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierMoveSpeedBonus_Constant()
	return self.pets_boosts.ms * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierPercentageCooldown()
	return self.pets_boosts.cd * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierMagicalResistanceBonus()
	return self.pets_boosts.mr * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierConstantHealthRegen()
	return self.pets_boosts.hpr * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierEvasion_Constant()
	return self.pets_boosts.eva * self:GetCaster():GetLevel()
end

function modifier_pet_owner:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return
		end
		if RandomInt(1, 100) < self.pets_boosts.crit * self:GetParent():GetLevel() then
			self.record = params.record
			return 210
		end
	end
end

function modifier_pet_owner:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		if self.record and self.record == params.record then
			self.record = nil
			EmitSoundOn("Hero_Juggernaut.BladeDance", params.target)
		end
	end
end