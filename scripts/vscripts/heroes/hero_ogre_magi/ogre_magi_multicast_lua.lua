--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ogre_magi_multicast_lua = 
{
	GetIntrinsicModifierName = function() return "modifier_multicast_lua" end,
}

function IsUltimateAbility(ability)
	return bit:_and(ability:GetAbilityType(), 1) == 1
end

function IsGlobalAbility(hAbility)
	if hAbility and ("invoker_sun_strike_lua"==hAbility:GetAbilityName() or "zuus_thundergods_wrath"==hAbility:GetAbilityName() or "furion_wrath_of_nature"==hAbility:GetAbilityName() or "zuus_cloud_custom"==hAbility:GetAbilityName() or "ancient_apparition_ice_blast"==hAbility:GetAbilityName()or "spectre_haunt"==hAbility:GetAbilityName()) then
      	return true
    else
      	return false
    end
end

function HasBehavior(behavior,ability)
	local abilityBehavior = tonumber(tostring(ability:GetBehavior()))
	return bit:_and(abilityBehavior, behavior) == behavior
end

if IsServer() then
	function ogre_magi_multicast_lua:OnSpellStart()
		local caster = self:GetCaster()
		if not caster:HasScepter() then return end
		local target = self:GetCursorTarget()
		local duration = self:GetSpecialValueFor("duration_ally_scepter")
		target:EmitSound("Hero_OgreMagi.Fireblast.x3")
		target:AddNewModifier(caster, self, "modifier_multicast_lua", { duration = duration })
	end
end

function ogre_magi_multicast_lua:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function ogre_magi_multicast_lua:GetManaCost(...)
	return self:GetCaster():HasScepter() and self.BaseClass.GetManaCost(self, ...) or 0
end

function ogre_magi_multicast_lua:GetCastRange(...)
	return self:GetCaster():HasScepter() and self.BaseClass.GetCastRange(self, ...) or 0
end

function ogre_magi_multicast_lua:CastFilterResultTarget(target)
	local caster = self:GetCaster()
	if caster == target or target:FindAbilityByName("ogre_magi_multicast_lua") then
		return UF_FAIL_CUSTOM
	end
	return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, caster:GetTeamNumber())
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

LinkLuaModifier("modifier_multicast_lua", "heroes/hero_ogre_magi/ogre_magi_multicast_lua.lua", LUA_MODIFIER_MOTION_NONE)

modifier_multicast_lua =
{
	IsPurgable = function() return false end,
	GetEffectAttachType = function() return PATTACH_ABSORIGIN_FOLLOW end,
}

if IsServer() then
	function modifier_multicast_lua:OnAbilityExecutedCustom(keys)
		local parent = self:GetParent()
		if parent ~= keys.unit then return end
		local castedAbility = keys.ability

		local caster = self:GetParent()
		local target = keys.target or caster:GetCursorPosition()
		local ability = self:GetAbility()

		local ogreAbilities = 
		{
			ogre_magi_bloodlust = true,
			ogre_magi_fireblast = true,
			ogre_magi_ignite = true,
			ogre_magi_unrefined_fireblast = true
		}

		if ogreAbilities[castedAbility:GetAbilityName()] then
			local mc = caster:AddAbility("ogre_magi_multicast")
			mc:SetHidden(true)
			mc:SetLevel(ability:GetLevel())
			Timers:CreateTimer(0.1, function() caster:RemoveAbility("ogre_magi_multicast") end)
			return
		end

		local multiplier = IsUltimateAbility(castedAbility) and 0.5 or 1

        if IsGlobalAbility(castedAbility) then
           multiplier = multiplier * 0.5
        end

        if "item_hand_of_midas_custom"==castedAbility:GetAbilityName() then
           multiplier = multiplier * 0.5
        end

		local multicast
		if RollPseudoRandomPercentage(math.floor(ability:GetSpecialValueFor("multicast_4_times") * multiplier), 210, self:GetParent()) then
			multicast = 4
		elseif RollPseudoRandomPercentage(math.floor(ability:GetSpecialValueFor("multicast_3_times") * multiplier), 210, self:GetParent())then
			multicast = 3
		elseif RollPseudoRandomPercentage(math.floor(ability:GetSpecialValueFor("multicast_2_times") * multiplier), 210, self:GetParent())then
			multicast = 2
		end
		if multicast then
			PreformMulticast(caster, castedAbility, multicast, ability:GetSpecialValueFor("multicast_delay"), target)
		end
	end

	local MULTICAST_TYPE_NONE = 0
	local MULTICAST_TYPE_SAME = 1 -- Fireblast
	local MULTICAST_TYPE_DIFFERENT = 2 -- Ignite
	local MULTICAST_TYPE_INSTANT = 3 -- Bloodlust
	local MULTICAST_ABILITIES = 
	{
		ogre_magi_bloodlust = MULTICAST_TYPE_NONE,
		ogre_magi_fireblast = MULTICAST_TYPE_NONE,
		ogre_magi_unrefined_fireblast = MULTICAST_TYPE_NONE,
		ogre_magi_multicast_lua = MULTICAST_TYPE_NONE,
		item_manta_arena = MULTICAST_TYPE_NONE,
		item_diffusal_style = MULTICAST_TYPE_NONE,
		rubick_spell_steal_custom = MULTICAST_TYPE_NONE,
		item_refresher_arena = MULTICAST_TYPE_NONE,
		item_refresher_core = MULTICAST_TYPE_NONE,
		abyssal_underlord_firestorm_custom = MULTICAST_TYPE_NONE,
		item_fallen_sky = MULTICAST_TYPE_NONE,
		mars_bulwark = MULTICAST_TYPE_NONE,
		beastmaster_wild_axes = MULTICAST_TYPE_INSTANT,
		doom_bringer_devour_custom = MULTICAST_TYPE_DIFFERENT,
		custom_phantom_assassin_fan_of_knives = MULTICAST_TYPE_SAME,
        frostivus2018_omniknight_purification = MULTICAST_TYPE_SAME,
		item_refresher_custom = MULTICAST_TYPE_NONE,
		invoker_deafening_blast_lua = MULTICAST_TYPE_DIFFERENT,
		sandking_burrowstrike = MULTICAST_TYPE_NONE,
		obsidian_destroyer_astral_imprisonment = MULTICAST_TYPE_NONE,
		item_book_of_shadows_custom = MULTICAST_TYPE_NONE,
		invoker_quas = MULTICAST_TYPE_NONE,
		invoker_wex = MULTICAST_TYPE_NONE,
		invoker_exort = MULTICAST_TYPE_NONE,
		invoker_invoke = MULTICAST_TYPE_NONE,
		ability_alchemist_unstable_concoction = MULTICAST_TYPE_NONE,
		ability_alchemist_unstable_concoction_throw = MULTICAST_TYPE_NONE,
		elder_titan_ancestral_spirit = MULTICAST_TYPE_NONE,
		elder_titan_return_spirit = MULTICAST_TYPE_NONE,
		ember_spirit_sleight_of_fist = MULTICAST_TYPE_NONE,
		monkey_king_tree_dance = MULTICAST_TYPE_NONE,
		monkey_king_primal_spring = MULTICAST_TYPE_NONE,
		monkey_king_primal_spring_early = MULTICAST_TYPE_NONE,
		arc_warden_tempest_double = MULTICAST_TYPE_NONE,
		arc_warden_tempest_double_lua = MULTICAST_TYPE_NONE,
		phoenix_sun_ray = MULTICAST_TYPE_NONE,
		phoenix_sun_ray_stop = MULTICAST_TYPE_NONE,
		phoenix_sun_ray_toggle_move = MULTICAST_TYPE_NONE,
		terrorblade_conjure_image = MULTICAST_TYPE_INSTANT,
		terrorblade_reflection = MULTICAST_TYPE_INSTANT,
		magnataur_empower_custom = MULTICAST_TYPE_INSTANT,
		oracle_purifying_flames = MULTICAST_TYPE_SAME,
		vengefulspirit_magic_missile_custom = MULTICAST_TYPE_SAME,
		undying_tombstone_lua = MULTICAST_TYPE_NONE,
		item_relearn_book_lua = MULTICAST_TYPE_NONE,
		item_relearn_torn_page_lua = MULTICAST_TYPE_NONE,
		item_paragon_book = MULTICAST_TYPE_NONE,
		item_paragon_book_2 = MULTICAST_TYPE_NONE,
		item_book_of_strength_custom = MULTICAST_TYPE_NONE,
		item_book_of_agility_custom = MULTICAST_TYPE_NONE,
		item_book_of_intelligence_custom = MULTICAST_TYPE_NONE,
		shredder_chakram_lua = MULTICAST_TYPE_NONE,
		shredder_chakram_2_lua = MULTICAST_TYPE_NONE,
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
        monkey_king_wukongs_command = MULTICAST_TYPE_NONE,
        wisp_tether = MULTICAST_TYPE_NONE,
        wisp_tether_break = MULTICAST_TYPE_NONE,
        ability_phoenix_supernova = MULTICAST_TYPE_NONE,
        brewmaster_primal_split = MULTICAST_TYPE_NONE,
        item_ex_machina_custom = MULTICAST_TYPE_NONE,
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
	    hoodwink_sharpshooter = MULTICAST_TYPE_NONE,
		witch_doctor_voodoo_switcheroo = MULTICAST_TYPE_NONE,
		dawnbreaker_converge = MULTICAST_TYPE_NONE,
		dawnbreaker_solar_guardian = MULTICAST_TYPE_NONE,
		dawnbreaker_celestial_hammer = MULTICAST_TYPE_NONE,
		crystal_maiden_freezing_field = MULTICAST_TYPE_NONE,
		shadow_demon_disseminate_custom = MULTICAST_TYPE_NONE,

		zuus_lightning_bolt_custom = MULTICAST_TYPE_SAME,
		zuus_cloud_custom = MULTICAST_TYPE_SAME,
		kunkka_torrent_storm_custom = MULTICAST_TYPE_SAME,
		
        grimstroke_ink_creature = MULTICAST_TYPE_NONE,
		faceless_void_chronosphere = MULTICAST_TYPE_NONE,
		timbersaw_chakram_lua = MULTICAST_TYPE_NONE,
		timbersaw_chakram_2_lua = MULTICAST_TYPE_NONE,
		custom_legion_commander_duel = MULTICAST_TYPE_NONE,
		tusk_snowball = MULTICAST_TYPE_NONE,
		earth_spirit_rolling_boulder = MULTICAST_TYPE_NONE,
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
        item_smoke_of_deceit_custom = MULTICAST_TYPE_NONE,
        item_vambrace = MULTICAST_TYPE_NONE,
        brewmaster_drunken_brawler = MULTICAST_TYPE_NONE,
        tiny_tree_grab_lua = MULTICAST_TYPE_NONE,
		tiny_tree_throw_lua = MULTICAST_TYPE_NONE,
		ancient_apparition_ice_blast = MULTICAST_TYPE_NONE,
		ancient_apparition_ice_blast_release = MULTICAST_TYPE_NONE,
		item_fusion_rune = MULTICAST_TYPE_NONE,
		item_blink = MULTICAST_TYPE_NONE,
        grimstroke_spirit_walk_custom = MULTICAST_TYPE_NONE,
		item_overwhelming_blink = MULTICAST_TYPE_NONE,
		item_swift_blink = MULTICAST_TYPE_NONE,
		item_arcane_blink = MULTICAST_TYPE_NONE,
		item_necronomicon = MULTICAST_TYPE_NONE,
		item_necronomicon_2 = MULTICAST_TYPE_NONE,
		item_necronomicon_3 = MULTICAST_TYPE_NONE,
		item_demonicon = MULTICAST_TYPE_NONE,
		item_elixer = MULTICAST_TYPE_NONE,
		item_royal_jelly = MULTICAST_TYPE_NONE,
		item_overflowing_elixir = MULTICAST_TYPE_NONE,
		item_fusion_rune_custom = MULTICAST_TYPE_NONE,
		chen_holy_persuasion_custom = MULTICAST_TYPE_NONE,
		razor_static_link = MULTICAST_TYPE_NONE,
		bounty_hunter_track = MULTICAST_TYPE_NONE,
		custom_terrorblade_metamorphosis = MULTICAST_TYPE_NONE,
		bane_nightmare  = MULTICAST_TYPE_NONE,
		visage_summon_familiars = MULTICAST_TYPE_NONE,
		lycan_summon_wolves = MULTICAST_TYPE_NONE,
		invoker_forge_spirit_lua = MULTICAST_TYPE_NONE,

        item_tier1_token_custom = MULTICAST_TYPE_NONE,
        item_tier2_token_custom = MULTICAST_TYPE_NONE,
        item_tier3_token_custom = MULTICAST_TYPE_NONE,
        item_tier4_token_custom = MULTICAST_TYPE_NONE,
        item_tier5_token_custom = MULTICAST_TYPE_NONE,
        item_tier5_token_roshan_custom = MULTICAST_TYPE_NONE,
        item_tier1_token = MULTICAST_TYPE_NONE,
        item_tier2_token = MULTICAST_TYPE_NONE,
        item_tier3_token = MULTICAST_TYPE_NONE,
        item_tier4_token = MULTICAST_TYPE_NONE,
        item_tier5_token = MULTICAST_TYPE_NONE,
		faceless_void_time_zone = MULTICAST_TYPE_NONE,
		juggernaut_blade_fury = MULTICAST_TYPE_NONE,
		legion_commander_press_the_attack_custom = MULTICAST_TYPE_NONE,
		life_stealer_rage = MULTICAST_TYPE_NONE,
		chen_hand_of_god_custom = MULTICAST_TYPE_NONE,
	}

	function GetAbilityMulticastType(ability)
		local name = ability:GetAbilityName()
		if MULTICAST_ABILITIES[name] then return MULTICAST_ABILITIES[name] end
		if ability:IsToggle() then return MULTICAST_TYPE_NONE end
		if HasBehavior(DOTA_ABILITY_BEHAVIOR_PASSIVE,ability) then return MULTICAST_TYPE_NONE end
		return HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET,ability) and MULTICAST_TYPE_DIFFERENT or MULTICAST_TYPE_SAME
	end

	function PreformMulticast(caster, ability_cast, multicast, multicast_delay, target)
		local multicast_type = GetAbilityMulticastType(ability_cast)
		if multicast_type ~= MULTICAST_TYPE_NONE then
			local prt = ParticleManager:CreateParticle('particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf', PATTACH_OVERHEAD_FOLLOW, caster)
			local multicast_flag_data = GetMulticastFlags(caster, ability_cast, multicast_type)
			local channelData = {}
			caster:AddEndChannelListener(function(interrupted)
				channelData.endTime = GameRules:GetGameTime()
				channelData.channelFailed = interrupted
			end)
			if multicast_type == MULTICAST_TYPE_INSTANT then
				Timers:CreateTimer(0.01,function()
					ParticleManager:SetParticleControl(prt, 1, Vector(multicast, 0, 0))
					ParticleManager:ReleaseParticleIndex(prt)
					local multicast_casted_data = {}
					for i=2,multicast do
						CastMulticastedSpellInstantly(caster, ability_cast, target, multicast_flag_data, multicast_casted_data, 0, channelData)
					end
				end)
			else
				CastMulticastedSpell(caster, ability_cast, target, multicast-1, multicast_type, multicast_flag_data, {}, multicast_delay, channelData, prt, 2)
			end
		end
	end

	function GetMulticastFlags(caster, ability, multicast_type)
		local rv = {}
		if multicast_type ~= MULTICAST_TYPE_SAME then
			local cast_range = ability:GetCastRange(caster:GetOrigin(), caster)
			local cast_range_bonus = caster:GetCastRangeBonus()
			rv.cast_range = cast_range + cast_range_bonus
			local abilityTarget = ability:GetAbilityTargetTeam()
			if abilityTarget == 0 then abilityTarget = DOTA_UNIT_TARGET_TEAM_ENEMY end
			rv.abilityTarget = abilityTarget
			local abilityTargetType = ability:GetAbilityTargetType()
			if abilityTargetType == 0 then abilityTargetType = DOTA_UNIT_TARGET_ALL
			elseif abilityTargetType == 2 and ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT) then abilityTargetType = 3 end
			rv.abilityTargetType = abilityTargetType
			rv.team = caster:GetTeam()
			rv.targetFlags = ability:GetAbilityTargetFlags()
		end
		return rv
	end

	function CastMulticastedSpellInstantly(caster, ability, target, multicast_flag_data, multicast_casted_data, delay, channelData)
		if (not caster) or (caster:IsNull()) then
			return
		end
		local candidates = FindUnitsInRadius(multicast_flag_data.team, caster:GetOrigin(), nil, multicast_flag_data.cast_range, multicast_flag_data.abilityTarget, multicast_flag_data.abilityTargetType, multicast_flag_data.targetFlags, FIND_ANY_ORDER, false)
		local Tier1 = {} --heroes
		local Tier2 = {} --creeps and self
		local Tier3 = {} --already casted
		local Tier4 = {} --dead stuff
		for k, v in pairs(candidates) do
			if caster:CanEntityBeSeenByMyTeam(v) then
				if multicast_casted_data[v] then
					Tier3[#Tier3 + 1] = v
				elseif not v:IsAlive() then
					Tier4[#Tier4 + 1] = v
				elseif v:IsHero() and v ~= caster then
					Tier1[#Tier1 + 1] = v
				else
					Tier2[#Tier2 + 1] = v
				end
			end
		end
		local castTarget = Tier1[math.random(#Tier1)] or Tier2[math.random(#Tier2)] or Tier3[math.random(#Tier3)] or Tier4[math.random(#Tier4)] or target
		multicast_casted_data[castTarget] = true
		CastAdditionalAbility(caster, ability, castTarget, delay, channelData)
		return multicast_casted_data
	end

	function CastMulticastedSpell(caster, ability, target, multicasts, multicast_type, multicast_flag_data, multicast_casted_data, delay, channelData, prt, prtNumber)
		if multicasts >= 1 then
			Timers:CreateTimer(delay, function()
				ParticleManager:DestroyParticle(prt, true)
				ParticleManager:ReleaseParticleIndex(prt)
				prt = ParticleManager:CreateParticle('particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf', PATTACH_OVERHEAD_FOLLOW, caster)
				ParticleManager:SetParticleControl(prt, 1, Vector(prtNumber, 0, 0))
				if multicast_type == MULTICAST_TYPE_SAME then
					CastAdditionalAbility(caster, ability, target, delay * (prtNumber - 1), channelData)
				else
					multicast_casted_data = CastMulticastedSpellInstantly(caster, ability, target, multicast_flag_data, multicast_casted_data, delay * (prtNumber - 1), channelData)
				end
				caster:EmitSound('Hero_OgreMagi.Fireblast.x'.. multicasts)
				if multicasts >= 2 then
					CastMulticastedSpell(caster, ability, target, multicasts - 1, multicast_type, multicast_flag_data, multicast_casted_data, delay, channelData, prt, prtNumber + 1)
				end
			end)
		else
			ParticleManager:DestroyParticle(prt, false)
			ParticleManager:ReleaseParticleIndex(prt)
		end
	end
end

function CastAdditionalAbility(caster, ability, target, delay, channelData)
	local skill = ability
	local unit = caster

	if not caster or caster:IsNull() or not caster.GetPlayerID then
	   return 
	end

	if not ability or ability:IsNull() then
		 return
	end

	local channelTime = ability:GetChannelTime() or 0
	if channelTime > 0 then
		if not caster.dummyCasters then
			caster.dummyCasters = {}
			caster.nextFreeDummyCaster = 1
			for i = 1, 8 do
				local dummy = CreateUnitByName("npc_dummy_caster", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
				if not dummy or dummy:IsNull() then
           return 
				end
				dummy:SetControllableByPlayer(caster:GetPlayerID(), true)
				dummy:AddNoDraw()
				dummy:MakeIllusion()
				table.insert(caster.dummyCasters, dummy)
			end
		end
		local dummy = caster.dummyCasters[caster.nextFreeDummyCaster]
    if not dummy or dummy:IsNull() then
       return 
		end

		skill = nil
		caster.nextFreeDummyCaster = caster.nextFreeDummyCaster % #caster.dummyCasters + 1
		local abilityName = ability:GetName()
		for i = 0, DOTA_ITEM_SLOT_9 do
			local ditem = dummy:GetItemInSlot(i)
			if ditem then
				ditem:Destroy()
			end
			local citem = caster:GetItemInSlot(i)
			if citem then
				local newditem = dummy:AddItem(CopyItem(citem))
				if newditem:GetName() == abilityName then
					skill = newditem
				end
			end
		end
		dummy:SetOwner(caster)
		dummy:SetAbsOrigin(caster:GetAbsOrigin())
		dummy:SetBaseStrength (caster:GetStrength())
		dummy:SetBaseAgility(caster:GetAgility())
		dummy:SetBaseIntellect(caster:GetIntellect(false))
		for _, v in pairs(caster:FindAllModifiers()) do
			local buffName = v:GetName()
			local buffAbility = v:GetAbility()
			local dummyModifier = dummy:FindModifierByName(buffName) or dummy:AddNewModifier(dummy, buffAbility, buffName, nil)
			if dummyModifier then dummyModifier:SetStackCount(v:GetStackCount()) end
		end
		Illusions:_copyAbilities(caster, dummy)
		skill = skill or dummy:FindAbilityByName(ability:GetName())
		skill:SetLevel(ability:GetLevel())
		skill.GetCaster = function() return ability:GetCaster() end
		unit = dummy
	end

	if HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET,skill) then
		if target and type(target) == "table" then
			unit:SetCursorCastTarget(target)
		end
	end

	local currentCursorPosition

	if HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT,skill) then
		if target then
			currentCursorPosition=unit:GetCursorPosition()
			if target.x and target.y and target.z then
				unit:SetCursorPosition(target)
			elseif target.GetOrigin then
				unit:SetCursorPosition(target:GetOrigin())
			end
		end
	end

	if skill:GetAbilityName() == "nevermore_shadowraze1_custom" or skill:GetAbilityName() == "nevermore_shadowraze2_custom" or skill:GetAbilityName() == "nevermore_shadowraze3_custom" or skill:GetAbilityName() == "doom_bringer_devour_custom" then
		skill:OnSpellStart(true)
    elseif skill:GetAbilityName() == "item_hand_of_midas" then
        skill:SetCurrentCharges(skill:GetCurrentCharges() + 1)
        skill:SetCurrentAbilityCharges(skill:GetCurrentAbilityCharges() + 1)
        skill:OnSpellStart()
    else
        if skill:GetAbilityName() == "ursa_enrage" then
            if unit:HasModifier("modifier_ursa_enrage") then
                unit:RemoveModifierByName("modifier_ursa_enrage")
            end
        end
		skill:OnSpellStart()
	end
	
	if currentCursorPosition then
	   unit:SetCursorPosition(currentCursorPosition)
	end
	if channelTime > 0 then
		if channelData.endTime then
			EndAdditionalAbilityChannel(caster, unit, skill, channelData.channelFailed, delay - GameRules:GetGameTime() + channelData.endTime)
		else
			caster:AddEndChannelListener(function(interrupted)
				EndAdditionalAbilityChannel(caster, unit, skill, interrupted, delay)
			end)
		end
	end
end