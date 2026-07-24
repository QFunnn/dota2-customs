--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


enchantress_enchant_custom = class({})
LinkLuaModifier("modifier_enchantress_rabblerouser_lua", "abilities/heroes/enchantress/enchantress_enchant", LUA_MODIFIER_MOTION_NONE)

-- the list is the same as helm of dominator/overlord
enchantress_enchant_custom.JUNGLE_UNITS = {
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
}


function enchantress_enchant_custom:Spawn()
	if not IsServer() then return end
	self.enchanted_units = {}
end


function enchantress_enchant_custom:GetIntrinsicModifierName()
	return "modifier_enchantress_enchant_intrinsic"
end


function enchantress_enchant_custom:CastFilterResultTarget(target)
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end

	if caster == target then
		return UF_SUCCESS
	end

	if target:HasModifier("modifier_enchantress_enchant_controlled") then
		return UF_FAIL_CUSTOM
	end

	if target:IsAncient() and not caster:HasTalent("special_enchant_ancients_chance") then
		return UF_FAIL_ANCIENT
	end

	if target:GetTeamNumber() == caster:GetTeamNumber() then
		return UF_FAIL_FRIENDLY
	end

	if IsClient() then return end

	return UnitFilter(target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), caster:GetTeamNumber())
end


function enchantress_enchant_custom:GetCustomCastErrorTarget(target)
	return "hud_error_enchant_cast_again"
end


function enchantress_enchant_custom:GetCurrentEnchantedUnitsCount()
	local count = 0

	local base_length = #self.enchanted_units

	-- iterating in REVERSE, because `remove` shifts table
	-- otherwise for every remove we'd be skipping next index
	for i = base_length, 1, -1 do
		local unit = self.enchanted_units[i]

		if IsValidEntity(unit) and unit:IsAlive() then
			count = count + 1
		else
			-- exclude invalid from index
			table.remove(self.enchanted_units, i)
		end
	end

	return count
end


function enchantress_enchant_custom:RemoveExcessiveUnits(current_unit_count, max_count)
	if current_unit_count < max_count then return end

	local removed = table.remove(self.enchanted_units, 1)
	removed:ForceKill(false)
end


function enchantress_enchant_custom:PrepareUnit(unit, duration, owner)
	unit:SetControllableByPlayer(owner:GetPlayerOwnerID(), false)
	unit:AddNewModifier(owner, self, "modifier_enchantress_enchant_controlled", {duration = duration}) -- this one handles enchant_health and enchant_damage
	unit:AddNewModifier(owner, self, "modifier_enchantress_rabblerouser_lua", {duration = duration}) -- this one handles bonus_armor, bonus_health and bonus_attackspeed
	unit:AddNewModifier(owner, self, "modifier_dominated", {duration = duration})
	unit:AddNewModifier(owner, self, "modifier_kill", {duration = duration})

	local abilities_level = GetCreepAbilityLevel() + (self:GetSpecialValueFor("bonus_creep_level") or 0)

	for i = 0, 10 do
		local ability = unit:GetAbilityByIndex(i)
		if IsValidEntity(ability) then
			ability:SetLevel(abilities_level)
		end
	end

	table.insert(self.enchanted_units, unit)
end


function enchantress_enchant_custom:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not caster or caster:IsNull() then return end
	if not target or target:IsNull() then return end

	if target:TriggerSpellAbsorb(self) then return end

	-- Ability Values
	local dominate_duration = self:GetSpecialValueFor("dominate_duration")
	local slow_duration = self:GetSpecialValueFor("slow_duration")

	local max_units = self:GetSpecialValueFor("max_creeps")
	local current_enchanted_units = self:GetCurrentEnchantedUnitsCount()

	if (not target:IsConsideredHero() or target:IsIllusion()) and not target:HasModifier("modifier_vengefulspirit_hybrid_special") then
		self:RemoveExcessiveUnits(current_enchanted_units, max_units)

		target:Purge(true, true, false, false, false)
		target:RemoveModifierByName("modifier_chen_holy_persuasion_lua")
		target:SetOwner(caster)
		target:SetTeam(caster:GetTeam())
		target:Heal(target:GetMaxHealth(), caster)

		self:PrepareUnit(target, dominate_duration, caster)
	elseif caster == target then
		self:RemoveExcessiveUnits(current_enchanted_units, max_units)

		local unit_name = table.random(self.JUNGLE_UNITS)

		local min_distance, max_distance = 140, 210
		local spawn_point = GetRandomPathablePositionWithin(caster:GetAbsOrigin(), max_distance, min_distance)
		spawn_point.z = 0

		local new_unit = CreateUnitByName(unit_name, spawn_point, false, caster, caster, caster:GetTeamNumber())
		FindClearSpaceForUnit(new_unit, spawn_point, true)

		self:PrepareUnit(new_unit, dominate_duration, caster)
	else
		target:Purge(true, false, false, false, false)	-- Basic dispel (just buffs)
		target:AddNewModifier(caster, self, "modifier_enchantress_enchant_slow", {duration = slow_duration * (1 - target:GetStatusResistance())})
	end

	caster:EmitSound("Hero_Enchantress.EnchantCast")
end


------------------------------------------------------------------------------------------------------------------------------------------------


modifier_enchantress_rabblerouser_lua = class({})

function modifier_enchantress_rabblerouser_lua:IsHidden() return false end
function modifier_enchantress_rabblerouser_lua:IsDebuff() return false end
function modifier_enchantress_rabblerouser_lua:IsPurgable() return false end

function modifier_enchantress_rabblerouser_lua:OnCreated(keys)
	self.parent = self:GetParent()
	if not IsValidEntity(self.parent) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end

	self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor") or 0
	self.bonus_health = self.ability:GetSpecialValueFor("bonus_health") or 0
	self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage") or 0
	self.bonus_attackspeed = self.ability:GetSpecialValueFor("bonus_attackspeed") or 0

	if not IsServer() then return end

	if self.listener then return end
	self.listener = ListenToGameEvent("dota_player_learned_ability", self.OnAbilityLevelled, self)
end

function modifier_enchantress_rabblerouser_lua:OnRefresh(keys)
	self:OnCreated(keys)
end


function modifier_enchantress_rabblerouser_lua:OnDestroy(kv)
	if not self.listener then return end
	StopListeningToGameEvent(self.listener)
end

modifier_enchantress_rabblerouser_lua.talent_names = {
	special_bonus_unique_enchantress_enchant_armor = true,
	special_bonus_unique_enchantress_enchant_health_damage = true,
	special_bonus_unique_enchantress_enchant_attackspeed = true,
}

function modifier_enchantress_rabblerouser_lua:OnAbilityLevelled(event)
	if not event then return end
	local ability_name = event.abilityname
	if not ability_name then return end
	if not self.talent_names[ability_name] then return end

	self:ForceRefresh()
	self:SendBuffRefreshToClients()
end

function modifier_enchantress_rabblerouser_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_enchantress_rabblerouser_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_enchantress_rabblerouser_lua:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_enchantress_rabblerouser_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_enchantress_rabblerouser_lua:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attackspeed
end