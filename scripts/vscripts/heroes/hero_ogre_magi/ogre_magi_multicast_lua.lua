--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ogre_magi_multicast_lua", "heroes/hero_ogre_magi/ogre_magi_multicast_lua.lua",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_multicast_lua_bonus", "heroes/hero_ogre_magi/modifier_ogre_multicast_lua_bonus.lua",
	LUA_MODIFIER_MOTION_NONE)
require("heroes.hero_ogre_magi.multicastfilter")


ogre_magi_multicast_lua = class({}) ---@class ogre_magi_multicast_lua : CDOTA_Ability_Lua

function ogre_magi_multicast_lua:GetIntrinsicModifierName()
	return "modifier_ogre_magi_multicast_lua"
end

function IsUltimateAbility(ability)
	return bit:_and(ability:GetAbilityType(), 1) == 1
end

globalAbilities = {
	invoker_sun_strike_lua = true,
	zuus_thundergods_wrath = true,
	furion_wrath_of_nature = true,
	zuus_cloud = true,
	ancient_apparition_ice_blast = true,
	spectre_haunt = true,
	silencer_global_silence = true
}

local MULTICAST_TYPE_NONE = 0
local MULTICAST_TYPE_SAME = 1      -- Like Fireblast
local MULTICAST_TYPE_DIFFERENT = 2 -- Like Ignite
local MULTICAST_TYPE_INSTANT = 3   -- Like Bloodlust
local MULTICAST_ABILITIES = {
	ogre_magi_fireblast = MULTICAST_TYPE_SAME,
	ogre_magi_unrefined_fireblast = MULTICAST_TYPE_SAME,
	ogre_magi_multicast_lua = MULTICAST_TYPE_NONE,

	item_manta_arena = MULTICAST_TYPE_NONE,
	item_diffusal_style = MULTICAST_TYPE_NONE,
	item_refresher_arena = MULTICAST_TYPE_NONE,
	item_refresher_core = MULTICAST_TYPE_NONE,
	item_refresher_lua = MULTICAST_TYPE_NONE,

	invoker_quas = MULTICAST_TYPE_NONE,
	invoker_wex = MULTICAST_TYPE_NONE,
	invoker_exort = MULTICAST_TYPE_NONE,
	invoker_invoke = MULTICAST_TYPE_NONE,
	alchemist_unstable_concoction = MULTICAST_TYPE_NONE,
	alchemist_unstable_concoction_throw = MULTICAST_TYPE_NONE,
	elder_titan_ancestral_spirit = MULTICAST_TYPE_NONE,
	elder_titan_return_spirit = MULTICAST_TYPE_NONE,
	monkey_king_tree_dance = MULTICAST_TYPE_NONE,
	monkey_king_primal_spring = MULTICAST_TYPE_NONE,
	monkey_king_primal_spring_early = MULTICAST_TYPE_NONE,
	wisp_spirits = MULTICAST_TYPE_NONE,
	wisp_spirits_in = MULTICAST_TYPE_NONE,
	wisp_spirits_out = MULTICAST_TYPE_NONE,
	arc_warden_tempest_double = MULTICAST_TYPE_NONE,
	arc_warden_tempest_double_lua = MULTICAST_TYPE_NONE,
	phoenix_sun_ray = MULTICAST_TYPE_NONE,
	phoenix_sun_ray_stop = MULTICAST_TYPE_NONE,
	phoenix_sun_ray_toggle_move = MULTICAST_TYPE_NONE,
	mars_bulwark = MULTICAST_TYPE_NONE,
	centaur_work_horse = MULTICAST_TYPE_NONE,

	terrorblade_conjure_image = MULTICAST_TYPE_INSTANT,
	terrorblade_reflection = MULTICAST_TYPE_INSTANT,
	magnataur_empower = MULTICAST_TYPE_INSTANT,
	oracle_purifying_flames = MULTICAST_TYPE_SAME,
	vengefulspirit_magic_missile = MULTICAST_TYPE_SAME,
	clinkz_death_pact = MULTICAST_TYPE_SAME,

	undying_tombstone_lua = MULTICAST_TYPE_NONE,
	earth_spirit_rolling_boulder = MULTICAST_TYPE_NONE,
	earth_spirit_petrify = MULTICAST_TYPE_NONE,
	bane_nightmare = MULTICAST_TYPE_NONE,
	-- bane_nightmare_end = MULTICAST_TYPE_NONE,
	naga_siren_song_of_the_siren = MULTICAST_TYPE_NONE,
	naga_siren_song_of_the_siren_cancel = MULTICAST_TYPE_NONE,
	spectre_haunted_night = MULTICAST_TYPE_NONE,
	doom_bringer_doom = MULTICAST_TYPE_NONE,
	enigma_demonic_conversion = MULTICAST_TYPE_NONE,
	techies_reactive_tazer = MULTICAST_TYPE_NONE,
	techies_reactive_tazer_stop = MULTICAST_TYPE_NONE,
	pudge_dismember = MULTICAST_TYPE_NONE,

	item_relearn_book_lua = MULTICAST_TYPE_NONE,
	item_relearn_torn_page_lua = MULTICAST_TYPE_NONE,
	item_paragon_book = MULTICAST_TYPE_NONE,
	item_book_of_strength = MULTICAST_TYPE_NONE,
	item_book_of_agility = MULTICAST_TYPE_NONE,
	item_book_of_intelligence = MULTICAST_TYPE_NONE,

	shredder_chakram_lua_return = MULTICAST_TYPE_NONE,
	shredder_chakram_lua_2_return = MULTICAST_TYPE_NONE,
	item_aegis_lua = MULTICAST_TYPE_NONE,
	tusk_walrus_punch = MULTICAST_TYPE_DIFFERENT,
	tusk_walrus_kick = MULTICAST_TYPE_NONE,

	warlock_fatal_bonds = MULTICAST_TYPE_NONE,
	nyx_assassin_burrow = MULTICAST_TYPE_NONE,
	nyx_assassin_unburrow = MULTICAST_TYPE_NONE,
	item_force_staff = MULTICAST_TYPE_DIFFERENT,
	item_hurricane_pike = MULTICAST_TYPE_DIFFERENT,
	item_black_king_bar = MULTICAST_TYPE_NONE,
	item_smoke_of_deceit = MULTICAST_TYPE_NONE,
	item_ward_sentry = MULTICAST_TYPE_NONE,
	item_smoke_of_deceit_lua = MULTICAST_TYPE_NONE,

	monkey_king_wukongs_command = MULTICAST_TYPE_NONE,
	wisp_tether = MULTICAST_TYPE_NONE,
	wisp_tether_break = MULTICAST_TYPE_NONE,
	phoenix_supernova = MULTICAST_TYPE_NONE,
	brewmaster_primal_split = MULTICAST_TYPE_NONE,

	item_ex_machina = MULTICAST_TYPE_NONE,
	item_manta = MULTICAST_TYPE_NONE,
	item_extra_creature_satyr_trickster = MULTICAST_TYPE_NONE,
	item_extra_creature_big_thunder_lizard = MULTICAST_TYPE_NONE,
	item_extra_creature_spider_range = MULTICAST_TYPE_NONE,
	item_extra_creature_dark_troll_warlord = MULTICAST_TYPE_NONE,
	item_extra_creature_ghost = MULTICAST_TYPE_NONE,
	item_extra_creature_centaur_khan = MULTICAST_TYPE_NONE,
	item_extra_creature_prowler_shaman = MULTICAST_TYPE_NONE,
	item_extra_creature_granite_golem = MULTICAST_TYPE_NONE,
	item_extra_creature_rock_golem = MULTICAST_TYPE_NONE,
	item_extra_creature_gnoll_assassin = MULTICAST_TYPE_NONE,
	item_extra_creature_kobold = MULTICAST_TYPE_NONE,
	item_extra_creature_timber_spider = MULTICAST_TYPE_NONE,
	item_extra_creature_explode_spider = MULTICAST_TYPE_NONE,

	item_dark_moon_shard = MULTICAST_TYPE_NONE,

	item_blink = MULTICAST_TYPE_NONE,
	item_swift_blink = MULTICAST_TYPE_NONE,
	item_overwhelming_blink = MULTICAST_TYPE_NONE,
	item_arcane_blink = MULTICAST_TYPE_NONE,

	item_greater_mango_lua = MULTICAST_TYPE_NONE,

	ancient_apparition_ice_blast = MULTICAST_TYPE_NONE,
	ancient_apparition_ice_blast_release = MULTICAST_TYPE_NONE,
	tiny_tree_grab_lua = MULTICAST_TYPE_NONE,
	tiny_tree_throw_lua = MULTICAST_TYPE_NONE,
	obsidian_destroyer_astral_imprisonment = MULTICAST_TYPE_NONE,
	obsidian_destroyer_arcane_orb = MULTICAST_TYPE_NONE,

	viper_nose_dive = MULTICAST_TYPE_NONE,
	brewmaster_drunken_brawler = MULTICAST_TYPE_NONE,
	tusk_launch_snowball_lua = MULTICAST_TYPE_NONE,
	pangolier_gyroshell_stop = MULTICAST_TYPE_NONE,
	crystal_maiden_freezing_field_stop = MULTICAST_TYPE_NONE,
	lone_druid_spirit_bear = MULTICAST_TYPE_NONE,
	item_demonicon = MULTICAST_TYPE_NONE,
	item_necronomicon = MULTICAST_TYPE_NONE,
	item_necronomicon_2 = MULTICAST_TYPE_NONE,
	item_necronomicon_3 = MULTICAST_TYPE_NONE,
	chen_holy_persuasion = MULTICAST_TYPE_NONE,

	hoodwink_sharpshooter = MULTICAST_TYPE_NONE,
	witch_doctor_voodoo_switcheroo = MULTICAST_TYPE_NONE,
	dawnbreaker_converge = MULTICAST_TYPE_NONE,
	dawnbreaker_solar_guardian = MULTICAST_TYPE_NONE,
	dawnbreaker_celestial_hammer = MULTICAST_TYPE_NONE,

	tinker_rearm_lua = MULTICAST_TYPE_NONE,
	faceless_void_chronosphere = MULTICAST_TYPE_NONE,

	item_madstone_bundle = MULTICAST_TYPE_NONE,
	tusk_snowball = MULTICAST_TYPE_NONE,
	axe_culling_blade = MULTICAST_TYPE_NONE,

	item_clarity = MULTICAST_TYPE_NONE,
	item_faerie_fire = MULTICAST_TYPE_NONE,
	item_flask = MULTICAST_TYPE_NONE,
	item_tango = MULTICAST_TYPE_NONE,
	item_dust = MULTICAST_TYPE_NONE,
	item_bottle = MULTICAST_TYPE_NONE,
	item_heal_ward = MULTICAST_TYPE_NONE,
	item_mana_ward = MULTICAST_TYPE_NONE,
	item_staff_of_sanctuary = MULTICAST_TYPE_NONE,
	item_omniscient_book = MULTICAST_TYPE_NONE,
	item_teleport_ticket_secretshop = MULTICAST_TYPE_NONE,
	item_rune_forge = MULTICAST_TYPE_NONE,

	item_power_treads = MULTICAST_TYPE_NONE,
	item_demonicon_custom = MULTICAST_TYPE_NONE,
}

---@param ability CDOTABaseAbility
---@return boolean
function IsGlobalAbility(ability)
	if ability then
		local abilityName = ability:GetAbilityName()
		return globalAbilities[abilityName] or false
	else
		return false
	end
end

---@param target CDOTA_BaseNPC
---@return integer
function ogre_magi_multicast_lua:CastFilterResultTarget(target)
	local caster = self:GetCaster()
	if caster == target or target:FindAbilityByName("ogre_magi_multicast_lua") then
		return UF_FAIL_CUSTOM
	end

	return UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		caster:GetTeamNumber()
	)
end

function ogre_magi_multicast_lua:GetCustomCastErrorTarget(target)
	if self:GetCaster() == target then
		return "#dota_hud_error_cant_cast_on_self"
	end
	if target:FindAbilityByName("ogre_magi_multicast_lua") then
		return "#dota_hud_error_cant_cast_on_other"
	end
	return ""
end

-------Modifier-----------------------------------------------------------------------------------
modifier_ogre_magi_multicast_lua = class({}) ---@class CDOTA_Modifier_Lua

function modifier_ogre_magi_multicast_lua:IsHidden() return true end

function modifier_ogre_magi_multicast_lua:IsPurgable() return false end

function modifier_ogre_magi_multicast_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_ogre_magi_multicast_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
	}
end

---@param specialName string
---@return integer
function modifier_ogre_magi_multicast_lua:GetBaseNoOverride(specialName)
	local ability = self:GetAbility()
	if not ability then return 0 end

	local lvl = ability:GetLevel() - 1
	if lvl < 0 then lvl = 0 end

	return ability:GetLevelSpecialValueNoOverride(specialName, lvl)
end

---@param event ModifierOverrideAbilitySpecialEvent
---@return integer
function modifier_ogre_magi_multicast_lua:GetModifierOverrideAbilitySpecialValue(event)
	local ability = self:GetAbility()
	local caster = self:GetParent()
	if not ability or not caster or not caster:IsHero() then return 0 end ---@cast caster CDOTA_BaseNPC_Hero

	local name = event.ability_special_value

	local lvl = event.ability_special_level
	if lvl == nil then
		lvl = math.max(0, ability:GetLevel() - 1)
	end

	local base = ability:GetLevelSpecialValueNoOverride(name, lvl)

	local mult = ability:GetLevelSpecialValueNoOverride("strength_mult", lvl)
	base = base + caster:GetStrength() * mult

	return base
end

---@param event ModifierOverrideAbilitySpecialEvent
---@return integer
function modifier_ogre_magi_multicast_lua:GetModifierOverrideAbilitySpecial(event)
	if event.ability ~= self:GetAbility() then return 0 end

	local name = event.ability_special_value
	if name == "multicast_2_times" or name == "multicast_3_times" or name == "multicast_4_times" then
		return 1
	end

	return 0
end

---@param times integer
---@return number
function modifier_ogre_magi_multicast_lua:GetMulticastChance(times)
	local ability = self:GetAbility()
	if not ability then return 0 end

	return ability:GetSpecialValueFor("multicast_" .. times .. "_times")
end

---@param castedAbility CDOTABaseAbility
function modifier_ogre_magi_multicast_lua:GetBaseAbilityMulticastMultiplier(castedAbility)
	local multiplier = 1
	local ability = self:GetAbility()
	if not ability then return multiplier end

	if IsUltimateAbility(castedAbility) then
		multiplier = multiplier * (ability:GetSpecialValueFor("ultimate_chance_decrease_pct") * 0.01)
	end

	if IsGlobalAbility(castedAbility) then
		multiplier = multiplier * (ability:GetSpecialValueFor("global_chance_decrease_pct") * 0.01)
	end

	return multiplier
end

---@param event ModifierAbilityEvent
function modifier_ogre_magi_multicast_lua:OnAbilityExecuted(event)
	if not IsServer() then return end
	local parent = self:GetParent()
	if parent ~= event.unit then return end
	local castedAbility = event.ability
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability then return end
	if caster:HasModifier("modifier_illusion") then
		return
	end

	local target = event.target or castedAbility:GetCursorTarget()
	local multicast_delay = ability:GetSpecialValueFor("multicast_delay")

	if not IsValid(target) and castedAbility:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT) and castedAbility:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
		target = castedAbility:GetCursorPosition()
	elseif castedAbility:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT) and (not castedAbility:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)) then
		target = castedAbility:GetCursorPosition()
	end

	if target ~= nil and target.x == 0 and target.y == 0 and target.z == 0 then
		return
	end

	local baseMultiplier = self:GetBaseAbilityMulticastMultiplier(castedAbility)
	local multicastTimes = 0

	if RollPercentage(math.floor(self:GetMulticastChance(4) * baseMultiplier)) then
		multicastTimes = 4
	elseif RollPercentage(math.floor(self:GetMulticastChance(3) * baseMultiplier)) then
		multicastTimes = 3
	elseif RollPercentage(math.floor(self:GetMulticastChance(2) * baseMultiplier)) then
		multicastTimes = 2
	end
	if multicastTimes ~= 0 then
		self:PreformMulticast(caster, castedAbility, multicastTimes, multicast_delay, target)
	end
end

---@param ability CDOTABaseAbility
---@return number
function modifier_ogre_magi_multicast_lua:GetAbilityMulticastType(ability)
	local name = ability:GetAbilityName()
	if MULTICAST_ABILITIES[name] then return MULTICAST_ABILITIES[name] end

	if ability:IsToggle() then return MULTICAST_TYPE_NONE end

	if ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_PASSIVE) then return MULTICAST_TYPE_NONE end

	return ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and MULTICAST_TYPE_DIFFERENT or MULTICAST_TYPE_SAME
end

---@param caster CDOTA_BaseNPC
---@param ability_cast CDOTABaseAbility
---@param multicast integer
---@param multicast_delay float
---@param target CDOTA_BaseNPC | Vector
function modifier_ogre_magi_multicast_lua:PreformMulticast(caster, ability_cast, multicast, multicast_delay, target)
	local multicast_type = self:GetAbilityMulticastType(ability_cast)
	if multicast_type ~= MULTICAST_TYPE_NONE then
		local prt = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			caster
		)
		local multicast_flag_data = self:GetMulticastFlags(caster, ability_cast, multicast_type)
		local channelData = {}
		if multicast_type == MULTICAST_TYPE_INSTANT then
			ParticleManager:SetParticleControl(prt, 1, Vector(multicast, 0, 0))
			ParticleManager:ReleaseParticleIndex(prt)
			local multicast_casted_data = {}
			for i = 2, multicast do
				self:CastMulticastedSpellInstantly(
					caster,
					ability_cast,
					target,
					multicast_flag_data,
					multicast_casted_data,
					0,
					channelData
				)
			end
		else
			self:CastMulticastedSpell(
				caster,
				ability_cast,
				target,
				multicast - 1,
				multicast_type,
				multicast_flag_data,
				{},
				multicast_delay,
				channelData,
				prt,
				2
			)
		end
	end
end

---@param caster CDOTA_BaseNPC
---@param ability CDOTABaseAbility
---@param multicast_type any
---@return {cast_range: integer, abilityTarget: DOTA_UNIT_TARGET_TEAM, abilityTargetType: DOTA_UNIT_TARGET_TYPE, team: DOTATeam_t, targetFlags: DOTA_UNIT_TARGET_FLAGS}
function modifier_ogre_magi_multicast_lua:GetMulticastFlags(caster, ability, multicast_type)
	local rv = {}
	if multicast_type == MULTICAST_TYPE_SAME then return rv end

	local cast_range = ability:GetCastRange(caster:GetOrigin(), caster)
	local cast_range_bonus = caster:GetCastRangeBonus()
	rv.cast_range = cast_range + cast_range_bonus
	local abilityTarget = ability:GetAbilityTargetTeam()
	if abilityTarget == DOTA_UNIT_TARGET_TEAM_NONE then
		abilityTarget = DOTA_UNIT_TARGET_TEAM_ENEMY
	end
	rv.abilityTarget = abilityTarget
	local abilityTargetType = ability:GetAbilityTargetType()

	if abilityTargetType == DOTA_UNIT_TARGET_NONE then
		abilityTargetType = DOTA_UNIT_TARGET_ALL
	elseif abilityTargetType == DOTA_UNIT_TARGET_CREEP and ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT) then
		abilityTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP
	end

	rv.abilityTargetType = abilityTargetType
	rv.team = caster:GetTeam()
	rv.targetFlags = ability:GetAbilityTargetFlags()

	return rv
end

---@param caster CDOTA_BaseNPC
---@param ability CDOTABaseAbility
---@param target Vector
---@param multicast_flag_data {cast_range: integer, abilityTarget: DOTA_UNIT_TARGET_TEAM, abilityTargetType: DOTA_UNIT_TARGET_TYPE, team: DOTATeam_t, targetFlags: DOTA_UNIT_TARGET_FLAGS}
---@param multicast_casted_data any
---@param delay number
---@param channelData any
---@return any
function modifier_ogre_magi_multicast_lua:CastMulticastedSpellInstantly(
	caster,
	ability,
	target,
	multicast_flag_data,
	multicast_casted_data,
	delay,
	channelData)
	if (not caster) or (caster:IsNull()) then return end

	local candidates = FindUnitsInRadius(
		multicast_flag_data.team,
		caster:GetOrigin(),
		nil,
		multicast_flag_data.cast_range,
		multicast_flag_data.abilityTarget,
		multicast_flag_data.abilityTargetType,
		multicast_flag_data.targetFlags,
		FIND_ANY_ORDER,
		false
	)

	local Tier1 = {} --heroes
	local Tier2 = {} --creeps and self
	local Tier3 = {} --already casted
	local Tier4 = {} --dead stuff

	for _, candidate in pairs(candidates) do
		if caster:CanEntityBeSeenByMyTeam(candidate) then
			if multicast_casted_data[candidate] then
				table.insert(Tier3, candidate)
			elseif not candidate:IsAlive() then
				table.insert(Tier4, candidate)
			elseif candidate:IsHero() and candidate ~= caster then
				table.insert(Tier1, candidate)
			else
				table.insert(Tier2, candidate)
			end
		end
	end

	local castTarget = table.random(Tier1) or table.random(Tier2) or table.random(Tier3) or table.random(Tier4) or target

	if castTarget ~= nil then
		multicast_casted_data[castTarget] = true
	end

	self:CastAdditionalAbility(caster, ability, castTarget, delay, channelData)
	return multicast_casted_data
end

---@param caster any
---@param ability any
---@param target any
---@param multicasts any
---@param multicast_type any
---@param multicast_flag_data any
---@param multicast_casted_data any
---@param delay number
---@param channelData any
---@param prt any
---@param prtNumber any
function modifier_ogre_magi_multicast_lua:CastMulticastedSpell(
	caster,
	ability,
	target,
	multicasts,
	multicast_type,
	multicast_flag_data,
	multicast_casted_data,
	delay,
	channelData,
	prt,
	prtNumber)
	local selfRef = self
	if multicasts >= 1 then
		Timers:CreateTimer(delay, function()
			ParticleManager:DestroyParticle(prt, true)
			ParticleManager:ReleaseParticleIndex(prt)
			prt = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				caster
			)
			ParticleManager:SetParticleControl(prt, 1, Vector(prtNumber, 0, 0))

			if multicast_type == MULTICAST_TYPE_SAME then
				selfRef:CastAdditionalAbility(
					caster,
					ability,
					target,
					delay * (prtNumber - 1),
					channelData
				)
			else
				multicast_casted_data = selfRef:CastMulticastedSpellInstantly(
					caster,
					ability,
					target,
					multicast_flag_data,
					multicast_casted_data,
					delay * (prtNumber - 1),
					channelData
				)
			end

			caster:EmitSound("Hero_OgreMagi.Fireblast.x" .. multicasts)

			if multicasts >= 2 then
				selfRef:CastMulticastedSpell(
					caster,
					ability,
					target,
					multicasts - 1,
					multicast_type,
					multicast_flag_data,
					multicast_casted_data,
					delay,
					channelData,
					prt,
					prtNumber + 1
				)
			end
			return nil
		end
		)
	else
		ParticleManager:DestroyParticle(prt, false)
		ParticleManager:ReleaseParticleIndex(prt)
	end
end

---@param skill CDOTABaseAbility
function modifier_ogre_magi_multicast_lua:CastMulticastSpellStart(skill)
	local previousFlag = skill.isFromMulticast
	skill.isFromMulticast = true
	skill:OnSpellStart()
	skill.isFromMulticast = previousFlag
end

---@param caster CDOTA_BaseNPC
---@param ability CDOTABaseAbility
---@param target any
---@param delay number
---@param channelData any
function modifier_ogre_magi_multicast_lua:CastAdditionalAbility(caster, ability, target, delay, channelData)
	local skill = ability
	local unit = caster
	local isCastDone = false

	if not caster or caster:IsNull() or not caster.GetPlayerID then return end
	if not skill or skill:IsNull() then return end
	if not caster:IsAlive() then return end

	if skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
		if not IsValid(target) then
			if skill:GetAbilityTargetTeam() == DOTA_UNIT_TARGET_TEAM_FRIENDLY then
				target = caster
			else
				return
			end
		end
	end

	if skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT) and (not skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)) then
		if not IsVector(target) then
			return
		end
		if target.x == 0 and target.y == 0 and target.z == 0 then
			return
		end
	end

	local channelTime = skill:GetChannelTime() or 0
	local isChannelAbility = skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_CHANNELLED)
	local FilterResult = MultiCastFilter(skill)
	local loserCurse = caster:FindModifierByName("modifier_loser_curse")
	local curseCount = 0
	if loserCurse then
		curseCount = loserCurse:GetStackCount()
	end

	if isChannelAbility or (FilterResult ~= nil and FilterResult.behavior == MULTICAST_BEHAVIOR_BONUS) then
		if (isChannelAbility and caster:IsChanneling()) or not isChannelAbility then
			if ((not skill:IsItem()) and caster:HasAbility(skill:GetAbilityName())) or (skill:IsItem() and caster:HasItemInInventory(skill:GetAbilityName())) then
				CreateUnitByNameAsync(
					caster:GetUnitName(),
					caster:GetAbsOrigin() + RandomVector(RandomFloat(150, 300)),
					true,
					caster,
					caster,
					caster:GetTeamNumber(),
					function(illusion)
						local illusion_duration = 0.5
						local bonus_duration = 10

						if isChannelAbility then
							illusion_duration = illusion_duration + channelTime
						else
							if FilterResult.duration ~= nil then
								bonus_duration = FilterResult.duration
							end
							illusion_duration = illusion_duration + bonus_duration
						end

						illusion:AddNewModifier(caster, caster:FindAbilityByName("ogre_magi_multicast_lua"),
						"modifier_illusion", {
							duration = illusion_duration
						})

						if curseCount > 0 then
							illusion:AddNewModifier(caster, nil, "modifier_loser_curse", {}):SetStackCount(curseCount)
						end

						if not IsValid(skill) then
							illusion:MakeIllusion()
							illusion:ForceKill(false)
							return
						end

						illusion:AddNewModifier(
							caster,
							caster:FindAbilityByName("ogre_magi_multicast_lua"),
							"modifier_ogre_multicast_lua_bonus",
							{ duration = illusion_duration, abilityindex = skill:entindex() }
						)

						if isChannelAbility and not caster:IsChanneling() then
							illusion:MakeIllusion()
							illusion:ForceKill(false)
							return
						end

						for i = 1, caster:GetLevel() - 1 do
							illusion:HeroLevelUp(false)
						end

						illusion:SetControllableByPlayer(caster:GetPlayerOwnerID(), false)
						illusion:SetContextThink(DoUniqueString("ogre_magi_multicast_lua"), function()
							local illusion_ability
							if skill:IsItem() then
								illusion_ability = illusion:FindItemInInventory(skill:GetAbilityName())
							else
								illusion_ability = illusion:FindAbilityByName(skill:GetAbilityName())
							end

							if illusion_ability == nil then
								illusion:MakeIllusion()
								illusion:ForceKill(false)
								return nil
							end

							local abilityindex = illusion_ability:entindex()
							illusion_ability:SetHidden(false)

							if skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and IsValid(target) then
								illusion:SetForwardVector((target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized())
								ExecuteOrderFromTable({
									UnitIndex = illusion:entindex(),
									OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
									TargetIndex = target:entindex(),
									AbilityIndex = abilityindex,
									Queue = false,
								})
							elseif skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT) and IsVector(target) then
								illusion:SetForwardVector((target - caster:GetAbsOrigin()):Normalized())
								ExecuteOrderFromTable({
									UnitIndex = illusion:entindex(),
									OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
									Position = target + RandomVector(RandomFloat(200, 350)),
									AbilityIndex = abilityindex,
									Queue = false,
								})
							elseif skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
								illusion:SetForwardVector(caster:GetForwardVector())
								ExecuteOrderFromTable({
									UnitIndex = illusion:entindex(),
									OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
									AbilityIndex = abilityindex,
									Queue = false,
								})
								ExecuteOrderFromTable({
									UnitIndex = illusion:entindex(),
									OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
									TargetIndex = caster:entindex(),
									Queue = true,
								})
							end

							if IsValid(illusion) then
								illusion:MakeIllusion()
							end
							return nil
						end, 0)
					end
				)
			end
		end

		isCastDone = true
	end

	local currentCursorTarget = unit:GetCursorCastTarget()
	local currentCursorPosition = unit:GetCursorPosition()

	if skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and not isCastDone then
		if IsValid(target) and type(target) == "table"
			and (target:IsAlive() or skill:GetName() == "doom_bringer_devour" or skill:GetName() == "clinkz_death_pact") then
			unit:SetCursorCastTarget(target)
			self:CastMulticastSpellStart(skill)
			isCastDone = true
		else
			isCastDone = true
		end
	end

	if skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT) and not isCastDone then
		if IsVector(target) and not (target.x == 0 and target.y == 0 and target.z == 0) then
			unit:SetCursorCastTarget(nil)
			unit:SetCursorPosition(target)
			self:CastMulticastSpellStart(skill)
			isCastDone = true
		else
			isCastDone = true
		end
	end

	if skill:HasBehavior(DOTA_ABILITY_BEHAVIOR_NO_TARGET) and not isCastDone then
		self:CastMulticastSpellStart(skill)
		isCastDone = true
	end

	if currentCursorPosition then
		unit:SetCursorPosition(currentCursorPosition)
	end
	unit:SetCursorCastTarget(currentCursorTarget)
end