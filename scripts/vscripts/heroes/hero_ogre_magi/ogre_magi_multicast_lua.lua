--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_multicast_lua", "heroes/hero_ogre_magi/ogre_magi_multicast_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_multicast_lua_bonus", "heroes/hero_ogre_magi/ogre_magi_multicast_lua.lua", LUA_MODIFIER_MOTION_NONE)
require("heroes/MultiCastFilter")
ogre_magi_multicast_lua = {
	GetIntrinsicModifierName = function() return "modifier_multicast_lua" end,
}

function IsUltimateAbility(ability)
	return bit:_and(ability:GetAbilityType(), 1) == 1
end


function IsGlobalAbility(hAbility)

	if hAbility and ("invoker_sun_strike_lua" == hAbility:GetAbilityName() or "zuus_thundergods_wrath" == hAbility:GetAbilityName()
	or "furion_wrath_of_nature" == hAbility:GetAbilityName() or "zuus_cloud" == hAbility:GetAbilityName() or "ancient_apparition_ice_blast" == hAbility:GetAbilityName()
	or "spectre_haunt" == hAbility:GetAbilityName()) then
		return true
	else
		return false
	end

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




modifier_multicast_lua = {
	IsPurgable = function() return false end,
	GetEffectName = function() return "particles/arena/units/heroes/hero_ogre_magi/multicast_aghanims_buff.vpcf" end,
	GetEffectAttachType = function() return PATTACH_ABSORIGIN_FOLLOW end,
	DeclareFunctions = function() return { MODIFIER_EVENT_ON_ABILITY_EXECUTED } end,
}

if IsServer() then
	function modifier_multicast_lua:OnAbilityExecuted(keys)
		local parent = self:GetParent()
		if parent ~= keys.unit then return end
		local castedAbility = keys.ability
		local caster = self:GetParent()
		local target = castedAbility:GetCursorTarget()
		local ability = self:GetAbility()
		local multicast_delay = ability:GetSpecialValueFor("multicast_delay")

		local multicast_4_times = ability:GetSpecialValueFor("multicast_4_times")
		local multicast_3_times = ability:GetSpecialValueFor("multicast_3_times")
		local multicast_2_times = ability:GetSpecialValueFor("multicast_2_times")

		if caster:HasAbility("ogre_magi_dumb_luck") then
			multicast_4_times = multicast_4_times + math.floor(caster:GetStrength() / 20)
			multicast_3_times = multicast_3_times + math.floor(caster:GetStrength() / 20)
			multicast_2_times = multicast_2_times + math.floor(caster:GetStrength() / 20)
		end

		if caster:HasModifier("modifier_illusion") then
			return
		end

		if not IsValid(target) and HasBehavior(castedAbility, DOTA_ABILITY_BEHAVIOR_POINT) and HasBehavior(castedAbility, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
			target = castedAbility:GetCursorPosition()
		end

		if HasBehavior(castedAbility, DOTA_ABILITY_BEHAVIOR_POINT) and (not HasBehavior(castedAbility, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)) then
			target = castedAbility:GetCursorPosition()
		end

		if target ~= nil and target.x == 0 and target.y == 0 and target.z == 0 then
			return
		end

		-- local ogreAbilities = {
		--	 ogre_magi_bloodlust = true,
		--	 ogre_magi_fireblast = true,
		--	 ogre_magi_ignite = true,
		--	 ogre_magi_unrefined_fireblast = true
		-- }
		-- if ogreAbilities[castedAbility:GetAbilityName()] then
		--	 local mc = caster:AddAbility("ogre_magi_multicast")
		--	 mc:SetHidden(true)
		--	 mc:SetLevel(ability:GetLevel())
		--	 Timers:CreateTimer(0.1, function() caster:RemoveAbility("ogre_magi_multicast") end)
		--	 return
		-- end

		local multiplier = IsUltimateAbility(castedAbility) and 0.5 or 1

		if IsGlobalAbility(castedAbility) then
			multiplier = multiplier * 0.5
		end

		-- if "item_hand_of_midas" == castedAbility:GetAbilityName() then
		--	 multiplier = multiplier * 0.5
		-- end

		-- if "item_hand_of_midas_lua" == castedAbility:GetAbilityName() then
		--	 multiplier = multiplier * 0.5
		-- end

		--print(multiplier)

		local multicast

		if RollPercentage(math.floor(multicast_4_times * multiplier)) then
			multicast = 4
		elseif RollPercentage(math.floor(multicast_3_times * multiplier)) then
			multicast = 3
		elseif RollPercentage(math.floor(multicast_2_times * multiplier)) then
			multicast = 2
		end
		if multicast then
			PreformMulticast(caster, castedAbility, multicast, multicast_delay, target)
		end
	end

	local MULTICAST_TYPE_NONE = 0
	local MULTICAST_TYPE_SAME = 1 -- Fireblast
	local MULTICAST_TYPE_DIFFERENT = 2 -- Ignite
	local MULTICAST_TYPE_INSTANT = 3 -- Bloodlust
	local MULTICAST_ABILITIES = {
		-- ogre_magi_bloodlust = MULTICAST_TYPE_NONE,
		ogre_magi_fireblast = MULTICAST_TYPE_SAME,
		-- ogre_magi_ignite = MULTICAST_TYPE_NONE,
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
		-- ember_spirit_sleight_of_fist = MULTICAST_TYPE_NONE,
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

		terrorblade_conjure_image = MULTICAST_TYPE_INSTANT,
		terrorblade_reflection = MULTICAST_TYPE_INSTANT,
		magnataur_empower = MULTICAST_TYPE_INSTANT,
		oracle_purifying_flames = MULTICAST_TYPE_SAME,
		vengefulspirit_magic_missile = MULTICAST_TYPE_SAME,
		clinkz_death_pact = MULTICAST_TYPE_SAME,

		-- storm_spirit_ball_lightning_lua = MULTICAST_TYPE_NONE,

		undying_tombstone_lua = MULTICAST_TYPE_NONE,
		earth_spirit_rolling_boulder = MULTICAST_TYPE_NONE,
		bane_nightmare = MULTICAST_TYPE_NONE,
		bane_nightmare_end = MULTICAST_TYPE_NONE,
		naga_siren_song_of_the_siren = MULTICAST_TYPE_NONE,
		naga_siren_song_of_the_siren_cancel = MULTICAST_TYPE_NONE,
		spectre_haunted_night = MULTICAST_TYPE_NONE,
		doom_bringer_doom = MULTICAST_TYPE_NONE,
		enigma_demonic_conversion = MULTICAST_TYPE_NONE,
		techies_reactive_tazer = MULTICAST_TYPE_NONE,
		techies_reactive_tazer_stop = MULTICAST_TYPE_NONE,
		pudge_dismember = MULTICAST_TYPE_NONE,

		item_spell_book_empty_lua = MULTICAST_TYPE_NONE,
		item_spell_book_lua = MULTICAST_TYPE_NONE,
		item_relearn_book_lua = MULTICAST_TYPE_NONE,
		item_relearn_torn_page_lua = MULTICAST_TYPE_NONE,
		item_summon_book_lua = MULTICAST_TYPE_NONE,
		item_paragon_book = MULTICAST_TYPE_NONE,
		item_book_of_strength = MULTICAST_TYPE_NONE,
		item_book_of_agility = MULTICAST_TYPE_NONE,
		item_book_of_intelligence = MULTICAST_TYPE_NONE,
		item_chaos_scroll_lua = MULTICAST_TYPE_NONE,
		item_reroll_token_lua_tier1 = MULTICAST_TYPE_NONE,
		item_reroll_token_lua_tier2 = MULTICAST_TYPE_NONE,
		item_reroll_token_lua_tier3 = MULTICAST_TYPE_NONE,
		item_reroll_token_lua_tier4 = MULTICAST_TYPE_NONE,
		item_reroll_token_lua_tier5 = MULTICAST_TYPE_NONE,
		item_token_lua_tier1 = MULTICAST_TYPE_NONE,
		item_token_lua_tier2 = MULTICAST_TYPE_NONE,
		item_token_lua_tier3 = MULTICAST_TYPE_NONE,
		item_token_lua_tier4 = MULTICAST_TYPE_NONE,
		item_token_lua_tier5 = MULTICAST_TYPE_NONE,

		-- shredder_chakram_lua = MULTICAST_TYPE_NONE,
		-- shredder_chakram_2_lua = MULTICAST_TYPE_NONE,
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

		--取消跳刀多重
		item_blink = MULTICAST_TYPE_NONE,
		item_swift_blink = MULTICAST_TYPE_NONE,
		item_overwhelming_blink = MULTICAST_TYPE_NONE,
		item_arcane_blink = MULTICAST_TYPE_NONE,

		--超级芒果不能多重
		item_greater_mango_lua = MULTICAST_TYPE_NONE,

		--部分技能多重会吞键位
		ancient_apparition_ice_blast = MULTICAST_TYPE_NONE,
		ancient_apparition_ice_blast_release = MULTICAST_TYPE_NONE,
		-- phoenix_icarus_dive = MULTICAST_TYPE_NONE,
		tiny_tree_grab_lua = MULTICAST_TYPE_NONE,
		tiny_tree_throw_lua = MULTICAST_TYPE_NONE,

		--去掉一些没有意义或难以处理的多重
		-- bane_fiends_grip_lua = MULTICAST_TYPE_NONE,
		viper_nose_dive = MULTICAST_TYPE_NONE,
		brewmaster_drunken_brawler = MULTICAST_TYPE_NONE,
		-- witch_doctor_death_ward_lua = MULTICAST_TYPE_NONE,
		-- tusk_snowball_lua = MULTICAST_TYPE_NONE,
		tusk_launch_snowball_lua = MULTICAST_TYPE_NONE,
		pangolier_gyroshell_stop = MULTICAST_TYPE_NONE,
		crystal_maiden_freezing_field_stop = MULTICAST_TYPE_NONE,
		lone_druid_spirit_bear = MULTICAST_TYPE_NONE,
		item_demonicon = MULTICAST_TYPE_NONE,
		item_necronomicon = MULTICAST_TYPE_NONE,
		item_necronomicon_2 = MULTICAST_TYPE_NONE,
		item_necronomicon_3 = MULTICAST_TYPE_NONE,
		chen_holy_persuasion = MULTICAST_TYPE_NONE,

		--BUG
		hoodwink_sharpshooter = MULTICAST_TYPE_NONE,
		witch_doctor_voodoo_switcheroo = MULTICAST_TYPE_NONE,
		dawnbreaker_converge = MULTICAST_TYPE_NONE,
		dawnbreaker_solar_guardian = MULTICAST_TYPE_NONE,
		dawnbreaker_celestial_hammer = MULTICAST_TYPE_NONE,
		-- 炼金无限刷钱
		tinker_rearm_lua = MULTICAST_TYPE_NONE,
		-- crystal_maiden_freezing_field = MULTICAST_TYPE_NONE,
		faceless_void_chronosphere = MULTICAST_TYPE_NONE,
		chen_holy_persuasion = MULTICAST_TYPE_NONE,
		--炸房
		tusk_snowball = MULTICAST_TYPE_NONE,
		axe_culling_blade = MULTICAST_TYPE_NONE,

		--商店里面的消耗品不能多重施法(快速消耗)
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
	}

	function GetAbilityMulticastType(ability)
		local name = ability:GetAbilityName()
		if MULTICAST_ABILITIES[name] then return MULTICAST_ABILITIES[name] end
		if ability:IsToggle() then return MULTICAST_TYPE_NONE end

		if HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_PASSIVE) then return MULTICAST_TYPE_NONE end
		return HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and MULTICAST_TYPE_DIFFERENT or MULTICAST_TYPE_SAME
	end

	function PreformMulticast(caster, ability_cast, multicast, multicast_delay, target)
		local multicast_type = GetAbilityMulticastType(ability_cast)
		if multicast_type ~= MULTICAST_TYPE_NONE then
			local prt = ParticleManager:CreateParticle('particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf', PATTACH_OVERHEAD_FOLLOW, caster)
			local multicast_flag_data = GetMulticastFlags(caster, ability_cast, multicast_type)
			local channelData = {}
			-- caster:AddEndChannelListener(function(interrupted)
			--	 channelData.endTime = GameRules:GetGameTime()
			--	 channelData.channelFailed = interrupted
			-- end)
			if multicast_type == MULTICAST_TYPE_INSTANT then
				ParticleManager:SetParticleControl(prt, 1, Vector(multicast, 0, 0))
				ParticleManager:ReleaseParticleIndex(prt)
				local multicast_casted_data = {}
				for i = 2, multicast do
					CastMulticastedSpellInstantly(caster, ability_cast, target, multicast_flag_data, multicast_casted_data, 0, channelData)
				end
				-- Timers:CreateTimer(0.01, function()
				--	 ParticleManager:SetParticleControl(prt, 1, Vector(multicast, 0, 0))
				--	 ParticleManager:ReleaseParticleIndex(prt)
				--	 local multicast_casted_data = {}
				--	 for i = 2, multicast do
				--		 CastMulticastedSpellInstantly(caster, ability_cast, target, multicast_flag_data, multicast_casted_data, 0, channelData)
				--	 end
				-- end)
			else
				CastMulticastedSpell(caster, ability_cast, target, multicast - 1, multicast_type, multicast_flag_data, {}, multicast_delay, channelData, prt, 2)
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
			if abilityTarget == DOTA_UNIT_TARGET_TEAM_NONE then abilityTarget = DOTA_UNIT_TARGET_TEAM_ENEMY end
			rv.abilityTarget = abilityTarget
			local abilityTargetType = ability:GetAbilityTargetType()
			if abilityTargetType == DOTA_UNIT_TARGET_NONE then abilityTargetType = DOTA_UNIT_TARGET_ALL
			elseif abilityTargetType == DOTA_UNIT_TARGET_CREEP and HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_POINT) then abilityTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP end
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
		if castTarget ~= nil then
			multicast_casted_data[castTarget] = true
		end
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
				caster:EmitSound('Hero_OgreMagi.Fireblast.x' .. multicasts)
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
	local bCastDone = false
	if not caster or caster:IsNull() or not caster.GetPlayerID then
		return
	end
	if not ability or ability:IsNull() then
		return
	end
	if not caster:IsAlive() then
		return
	end

	local channelTime = ability:GetChannelTime() or 0
	local bChannelAbility = HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_CHANNELLED)
	local FilterResult = MultiCastFilter(caster, ability, target, target)
	if bChannelAbility or (type(FilterResult) ~= "boolean" and FilterResult.behavior == MULTICAST_BEHAVIOR_BONUS) then
		if (bChannelAbility and caster:IsChanneling()) or not bChannelAbility then
			if ((not ability:IsItem()) and caster:HasAbility(ability:GetAbilityName())) or (ability:IsItem() and caster:HasItemInInventory(ability:GetAbilityName())) then
				CreateUnitByNameAsync(caster:GetUnitName(), caster:GetAbsOrigin() + RandomVector(RandomFloat(150, 300)), true, caster, caster, caster:GetTeamNumber(), function(illusion)
					local illusion_duration = 0.5
					local bonus_duration = 10
					if bChannelAbility then
						illusion_duration = illusion_duration + channelTime
					else
						if FilterResult.duration ~= nil then
							bonus_duration = FilterResult.duration
						end
						illusion_duration = illusion_duration + bonus_duration
					end

					illusion:AddNewModifier(caster, caster:FindAbilityByName("ogre_magi_multicast_lua"), "modifier_illusion", { duration = illusion_duration })
					--如果技能已经不存在 直接杀死幻象
					if not IsValid(ability) then
						illusion:MakeIllusion()
						illusion:ForceKill(false)
						-- Illusion:ClearIllusion(illusion)
						return
					end
					illusion:AddNewModifier(caster, caster:FindAbilityByName("ogre_magi_multicast_lua"), "modifier_ogre_multicast_lua_bonus", { duration = illusion_duration, abilityindex = ability:entindex() })

					if (bChannelAbility and not caster:IsChanneling()) then
						illusion:MakeIllusion()
						illusion:ForceKill(false)
						-- Illusion:ClearIllusion(illusion)
						return
					end

					for i = 1, caster:GetLevel() - 1 do
						illusion:HeroLevelUp(false)
					end

					illusion:SetControllableByPlayer(caster:GetPlayerOwnerID(), false)
					illusion:SetContextThink(DoUniqueString("ogre_magi_multicast_lua"), function()
						local abilityindex
						local illusion_ability
						if ability:IsItem() then
							illusion_ability = illusion:FindItemInInventory(ability:GetAbilityName())
						else
							illusion_ability = illusion:FindAbilityByName(ability:GetAbilityName())
						end
						if illusion_ability ~= nil then
							abilityindex = illusion_ability:entindex()
							illusion_ability:SetHidden(false)
							if HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and IsValid(target) then
								illusion:SetForwardVector((target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized())
								ExecuteOrderFromTable({
									UnitIndex = illusion:entindex(),
									OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
									TargetIndex = target:entindex(),
									AbilityIndex = abilityindex,
									Queue = false,
								})
							elseif HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_POINT) and IsVector(target) then
								illusion:SetForwardVector((target - caster:GetAbsOrigin()):Normalized())
								ExecuteOrderFromTable({
									UnitIndex = illusion:entindex(),
									OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
									Position = target + RandomVector(RandomFloat(200, 350)),
									AbilityIndex = abilityindex,
									Queue = false,
								})
							elseif HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
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
						else
							illusion:MakeIllusion()
							illusion:ForceKill(false)
						end

						if IsValid(illusion) then
							illusion:MakeIllusion()
						end
						return nil
					end, 0)
				end)
			end
		end
		bCastDone = true
	end
	local currentCursorTarget = unit:GetCursorCastTarget()
	local currentCursorPosition = unit:GetCursorPosition()

	if HasBehavior(skill, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and not bCastDone then
		if IsValid(target) and type(target) == "table" and (target:IsAlive() or ability:GetName() == "doom_bringer_devour" or ability:GetName() == "clinkz_death_pact") then
			currentCursorTarget = unit:GetCursorCastTarget()
			currentCursorPosition = unit:GetCursorPosition()
			unit:SetCursorCastTarget(target)
			skill:OnSpellStart()
			bCastDone = true
		end
	end

	if target ~= nil and type(target) ~= "table" and HasBehavior(skill, DOTA_ABILITY_BEHAVIOR_POINT) and not bCastDone then
		if target then
			--保留好当前位置 使用完在马上复原
			currentCursorPosition = unit:GetCursorPosition()
			currentCursorTarget = unit:GetCursorCastTarget()
			if target.x and target.y and target.z then
				if not (target.x == 0 and target.y == 0 and target.z == 0) then
					unit:SetCursorCastTarget(nil)
					unit:SetCursorPosition(target)
					skill:OnSpellStart()
				end
				bCastDone = true
				-- elseif target.GetOrigin then
				--	 unit:SetCursorCastTarget(nil)
				--	 unit:SetCursorPosition(target:GetOrigin())
			end
		end
	end

	if not bCastDone then
		skill:OnSpellStart()
	end

	if currentCursorPosition then
		unit:SetCursorPosition(currentCursorPosition)
	end

	unit:SetCursorCastTarget(currentCursorTarget)

	-- if channelTime > 0 then
	--	 if channelData.endTime then
	--		 EndAdditionalAbilityChannel(caster, unit, skill, channelData.channelFailed, delay - GameRules:GetGameTime() + channelData.endTime)
	--	 else
	--		 caster:AddEndChannelListener(function(interrupted)
	--			 EndAdditionalAbilityChannel(caster, unit, skill, interrupted, delay)
	--		 end)
	--	 end
	-- end
end

---------------------------------------------------------------------
--Modifiers
if modifier_ogre_multicast_lua_bonus == nil then
	modifier_ogre_multicast_lua_bonus = class({})
end
function modifier_ogre_multicast_lua_bonus:IsHidden()
	return true
end
function modifier_ogre_multicast_lua_bonus:IsDebuff()
	return false
end
function modifier_ogre_multicast_lua_bonus:IsPurgable()
	return false
end
function modifier_ogre_multicast_lua_bonus:IsPurgeException()
	return false
end
function modifier_ogre_multicast_lua_bonus:IsStunDebuff()
	return false
end
function modifier_ogre_multicast_lua_bonus:AllowIllusionDuplicate()
	return true
end
function modifier_ogre_multicast_lua_bonus:GetPriority()
	return 99999
end
function modifier_ogre_multicast_lua_bonus:OnCreated(params)
	if IsServer() then
		self.abilityindex = params.abilityindex
		self:StartIntervalThink(0.3)
	end
end
function modifier_ogre_multicast_lua_bonus:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	-- [MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end
function modifier_ogre_multicast_lua_bonus:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function modifier_ogre_multicast_lua_bonus:OnIntervalThink()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	local hAbility = EntIndexToHScript(self.abilityindex)
	if not IsValid(hAbility) then
		self:Destroy()
	elseif HasBehavior(hAbility, DOTA_ABILITY_BEHAVIOR_CHANNELLED) and ((not hParent:IsChanneling()) or (not hCaster:IsChanneling())) then
		self:Destroy()
	end
end
function modifier_ogre_multicast_lua_bonus:OnDestroy()
	local hParent = self:GetParent()
	if IsServer() then
		hParent:InterruptChannel()
		hParent:MakeIllusion()
		hParent:ForceKill(false)
	end
end
function modifier_ogre_multicast_lua_bonus:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_SUPER_ILLUSION_WITH_ULTIMATE,
		MODIFIER_PROPERTY_SUPER_ILLUSION,
		MODIFIER_PROPERTY_STRONG_ILLUSION,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_IS_ILLUSION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end
function modifier_ogre_multicast_lua_bonus:GetIsIllusion()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierPercentageCasttime()
	return 100
end
function modifier_ogre_multicast_lua_bonus:GetModifierInvisibilityLevel()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierCastRangeBonusStacking()
	return 99999
end
function modifier_ogre_multicast_lua_bonus:GetModifierSuperIllusionWithUltimate()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierSuperIllusion()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierStrongIllusion()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierPercentageManacostStacking()
	return 100
end
function modifier_ogre_multicast_lua_bonus:GetModifierIgnoreCastAngle()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetOverrideAnimation()
	return ACT_DOTA_GENERIC_CHANNEL_1
end
function modifier_ogre_multicast_lua_bonus:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end