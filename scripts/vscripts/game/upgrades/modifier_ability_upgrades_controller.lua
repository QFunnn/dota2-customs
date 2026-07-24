--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ability_upgrades_controller = modifier_ability_upgrades_controller or class({})


function modifier_ability_upgrades_controller:IsHidden() return true end
function modifier_ability_upgrades_controller:IsPurgable() return false end
function modifier_ability_upgrades_controller:RemoveOnDeath() return false end
function modifier_ability_upgrades_controller:IsPermanent() return true end


SPELL_AMP_FILTER_EXCEPTIONS = {
	-- base damage is taken from AbilityDamage (so needs spell amp), but is scaled from distance
	storm_spirit_ball_lightning = true,

}

SPELL_AMP_FILTER_USE_PASSED_DAMAGE = {
	-- lvl 20 talent is not linked to anything in abilityvalues, and is added only on server inside ability
	winter_wyvern_splinter_blast = true,
}


function modifier_ability_upgrades_controller:OnCreated()
	self.parent = self:GetParent()

	if IsServer() then
		-- OnStackCountChanged is not invoked on client when changed on server, so syncing with transmitter
		self:SetHasCustomTransmitterData(true)
	end

	self:OnRefresh()
end


function modifier_ability_upgrades_controller:OnRefresh()
	self.cache = {}
	local player_id = self.parent:GetPlayerOwnerID()
	self.source_player_id = player_id

	-- sync upgrades for illusions/summons from player owner
	-- for main hero upgrades on server are predefined and should not be pulled again
	if not IsServer() then return end

	local owner_hero = GameLoop.hero_by_player_id[player_id]
	if not IsValidEntity(owner_hero) then return end

	if owner_hero ~= self.parent then
		-- now the fun begins - illusion can be of other hero, which should inherit upgrades of said hero
		-- not the owner
		local parent_name = self.parent:GetUnitName()
		if self.parent:IsHero() and not self.parent:IsSpiritBear() and parent_name ~= owner_hero:GetUnitName() then
			local actual_owner = GetIllusionSource(self.parent)
			self.parent.upgrades = actual_owner.upgrades or {}
			-- and update player ID for client to fetch upgrades from
			self.source_player_id = actual_owner:GetPlayerOwnerID()
		else
			self.parent.upgrades = owner_hero.upgrades or {}
		end
	end

	self:SendBuffRefreshToClients()
end


function modifier_ability_upgrades_controller:AddCustomTransmitterData()
	return {
		source_player_id = self.source_player_id
	}
end


function modifier_ability_upgrades_controller:HandleCustomTransmitterData(data)
	self.source_player_id = data.source_player_id
	self.parent = self.parent or self:GetParent()
	self.parent.upgrades = CustomNetTables:GetTableValue("ability_upgrades", tostring(self.source_player_id)) or {}
	self.cache = {}
end


function modifier_ability_upgrades_controller:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end


function modifier_ability_upgrades_controller:GetModifierOverrideAbilitySpecial(params)
	if not self.parent or self.parent:IsNull() then return 0 end
	if not params.ability then return 0 end
	if params.ability:IsItem() then return 0 end
	if not self.parent.upgrades then return 0 end

	local ability_name = params.ability:GetAbilityName()
	local special_value = params.ability_special_value

	if special_value == "#AbilityDamage" then
		special_value = "damage"
	end

	if special_value == "AbilityDuration" then
		special_value = "duration"
	end

	if not self.parent.upgrades[ability_name]
	or not self.parent.upgrades[ability_name][special_value]
	then
		return 0
	end

	return 1
end


function modifier_ability_upgrades_controller:GetModifierOverrideAbilitySpecialValue(params)
	if not params.ability or params.ability:IsNull() then return end
	if string.find(params.ability_special_value, "scepter") and not self:GetParent():HasScepter() then return end

	local ability_name = params.ability:GetAbilityName()
	local special_value_name = params.ability_special_value
	local special_value_level = params.ability_special_level

	-- print("special value", ability_name, special_value_name, special_value_level, IsServer())

	local base_value = params.ability:GetLevelSpecialValueNoOverride(special_value_name, special_value_level)

	if special_value_name == "#AbilityDamage" then
		base_value = params.ability:GetLevelSpecialValueNoOverride("#AbilityDamage", special_value_level)
		special_value_name = "damage"
		-- print(ability_name, "is using AbilityDamage, switching to damage")
	end

	if special_value_name == "AbilityDuration" then
		special_value_name = "duration"
	end

	if not self.parent.upgrades[ability_name]
	or not self.parent.upgrades[ability_name][special_value_name]
	then
		return base_value
	end

	if self.cache[ability_name] and self.cache[ability_name][special_value_name] and self.cache[ability_name][special_value_name][special_value_level] then
		-- print("using cache for", ability_name, special_value_name, base_value + self.cache[ability_name][special_value_name][special_value_level])
		return base_value + self.cache[ability_name][special_value_name][special_value_level]
	end

	local upgrade_data = self.parent.upgrades[ability_name][special_value_name]

	if upgrade_data.requires_scepter and not self.parent:HasScepter() then return base_value end
	if upgrade_data.requires_shard and not self.parent:HasShard() then return base_value end

	local added_value = UpgradesUtilities:CalculateUpgradeValue(
		self.parent, upgrade_data.value, upgrade_data.count, upgrade_data, special_value_level, ability_name, special_value_name
	)

	self.cache[ability_name] = self.cache[ability_name] or {}
	self.cache[ability_name][special_value_name] = self.cache[ability_name][special_value_name] or {}
	self.cache[ability_name][special_value_name][special_value_level] = added_value

	return base_value + added_value
end


function modifier_ability_upgrades_controller:GetModifierPercentageCooldown(params)
	if not params.ability or params.ability:IsItem() then return 0 end
	if not self.parent.upgrades then return 0 end

	local ability_name = params.ability:GetAbilityName()

	if not self.parent.upgrades[ability_name]
	or not self.parent.upgrades[ability_name].cooldown_and_manacost
	then
		return 0
	end

	if self.cache[ability_name] and self.cache[ability_name].cooldown_and_manacost then
		-- print("using cache for", ability_name, "cooldown")
		return self.cache[ability_name].cooldown_and_manacost
	end

	local upgrade_data = self.parent.upgrades[ability_name].cooldown_and_manacost

	local added_value = UpgradesUtilities:CalculateUpgradeValue(self.parent, upgrade_data.value, upgrade_data.count, upgrade_data)

	self.cache[ability_name] = self.cache[ability_name] or {}
	self.cache[ability_name].cooldown_and_manacost = added_value
	-- print("calculated cooldown stacking as: ", final_cooldown_reduction, "from", upgrades_data.count)

	return added_value
end


function modifier_ability_upgrades_controller:GetModifierPercentageManacostStacking(params)
	return self:GetModifierPercentageCooldown(params)
end

--- Spell amp workaround to apply damage upgrades to abilities driven by AbilityDamage
--- Which can't be directly overriden as it's not a special value per se (so it works only for client)
---@param params any
function modifier_ability_upgrades_controller:GetModifierSpellAmplify_Percentage(params)
	if IsClient() then return 0 end
	if self.spell_amp_lock then return 0 end

	local attacker = self:GetParent()
	local ability = params.inflictor
	if not IsValidEntity(ability) or not IsValidEntity(attacker) then return 0 end

	local ability_name = ability:GetAbilityName()

	local ability_upgrades = attacker.upgrades and attacker.upgrades[ability_name] or {}
	if not ability_upgrades or not ability_upgrades.damage then return 0 end

	-- discard damage instances that come not from AbilityDamage
	if params.original_damage ~= ability:GetAbilityDamage()
	and not SPELL_AMP_FILTER_EXCEPTIONS[ability_name]
	and not SPELL_AMP_FILTER_USE_PASSED_DAMAGE[ability_name] then
		return 0
	end

	local ability_damage_kv = ability:GetAbilityDamage()
	local ability_damage_special = ability:GetSpecialValueFor("damage")

	if SPELL_AMP_FILTER_USE_PASSED_DAMAGE[ability_name] then
		ability_damage_kv = params.original_damage
	end

	-- print("AbilityDamage:", ability_damage_kv)
	-- print("damage (special value):", ability_damage_special)
	if ability_damage_kv and (not ability_damage_special or ability_damage_special == 0) then
		local damage_upgrade = ability_upgrades.damage or {}

		local base_damage = damage_upgrade.value
		local upgrade_count = damage_upgrade.count

		if base_damage and upgrade_count then
			self.spell_amp_lock = true
			local current_spell_amp = attacker:GetSpellAmplification(false)
			self.spell_amp_lock = false

			local upgrade_value = UpgradesUtilities:CalculateUpgradeValue(attacker, base_damage, upgrade_count, damage_upgrade, ability:GetLevel(), ability_name, "damage")

			return upgrade_value * 100 * (1 + current_spell_amp) / ability_damage_kv
		end
	end

	return 0
end