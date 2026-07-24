--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


DisableHelp = DisableHelp or {}

EventStream:Listen("set_disable_help", function(data)
	local to = data.to;
	if PlayerResource:IsValidPlayerID(to) then
		local playerId = data.PlayerID;
		local disable = data.disable == 1
		PlayerResource:SetUnitShareMaskForPlayer(playerId, to, 4, disable)

		local disableHelp = CustomNetTables:GetTableValue("disable_help", tostring(playerId)) or {}
		disableHelp[tostring(to)] = disable
		DeepPrintTable(disableHelp)
		CustomNetTables:SetTableValue("disable_help", tostring(playerId), disableHelp)
	end
end)

local disabledModifiers = {
	modifier_tiny_toss = true,
}

local disabledModifiersNotInParty = {
	modifier_tiny_toss = true,
}

function DisableHelp.ModifierGainedFilter(filterTable)
	if disabledModifiers[filterTable.name_const] then
		local parent = EntIndexToHScript(filterTable.entindex_parent_const)
		local caster = EntIndexToHScript(filterTable.entindex_caster_const)
		local ability = EntIndexToHScript(filterTable.entindex_ability_const)

		if PlayerResource:IsDisableHelpSetForPlayerID(parent:GetPlayerOwnerID(), caster:GetPlayerOwnerID()) then
			ability:EndCooldown()
			ability:RefundManaCost()
			DisplayError(caster:GetPlayerOwnerID(), "dota_hud_error_target_has_disable_help")
			return false
		end
	end
	if disabledModifiersNotInParty[filterTable.name_const] then
		local parent = EntIndexToHScript(filterTable.entindex_parent_const)
		local caster = EntIndexToHScript(filterTable.entindex_caster_const)
		local ability = EntIndexToHScript(filterTable.entindex_ability_const)

		if
		parent:IsRealHero()
		and (parent:GetTeam() == caster:GetTeam())
		and PlayerResource:GetPartyID(parent:GetPlayerOwnerID()) ~= PlayerResource:GetPartyID(caster:GetPlayerOwnerID())
		then
			ability:EndCooldown()
			ability:RefundManaCost()
			DisplayError(caster:GetPlayerOwnerID(), "dota_hud_error_target_has_disable_help")
			return false
		end
	end
end

local disabledAbilities = {
	--[[ HEROES ]]--
	bane_nightmare = true,
	earth_spirit_boulder_smash = true,
	earth_spirit_geomagnetic_grip = true,
	earth_spirit_petrify = true,
	enigma_demonic_conversion_custom = true,
	furion_sprout_custom = true,
	wisp_tether = true,
	kunkka_x_marks_the_spot = true,
	life_stealer_infest = true,
	lycan_wolf_bite = true,
	marci_grapple = true,
	morphling_replicate = true,
	necrolyte_death_seeker = true,
	oracle_fates_edict = true,
	oracle_purifying_flames = true,
	obsidian_destroyer_astral_imprisonment = true,
	phoenix_supernova = true,
	pudge_dismember = true,
	pugna_decrepify = true,
	rubick_telekinesis = true,
	rubick_spell_steal = true,
	shadow_demon_disruption = true,
	snapfire_firesnap_cookie = true,
	snapfire_gobble_up = true,
	terrorblade_sunder = true,
	tiny_toss = true,
	troll_warlord_battle_trance = true,
	vengefulspirit_nether_swap = true,
	weaver_time_lapse = true,
	winter_wyvern_cold_embrace = true,

	--[[ ITEMS ]]--
	item_shadow_amulet = true,
	item_force_staff = true,
	item_wind_waker = true,
	item_ethereal_blade = true,
	item_hurricane_pike = true,
	item_lotus_orb = true,

	--[[ NEUTRAL ITEMS ]]--
	item_wand_of_the_brine = true,
	item_book_of_shadows = true,
}

function DisableHelp.ExecuteOrderFilter(orderType, ability, target, unit, orderVector, units)
	if not unit or not ability then
		return
	end
	if not ability or ability:IsNull() then return end

	local caster_id = unit:GetPlayerOwnerID()

	if ability:GetAbilityName() == "furion_sprout_custom" then
		if (
			orderType == DOTA_UNIT_ORDER_CAST_TARGET and
			target and
			target:IsRealHero() and
			target ~= unit and
			target:GetTeam() == unit:GetTeam()
		) then
			DisplayError(caster_id, "dota_hud_error_target_has_disable_help")
			return false
		else
			local enemies = FindUnitsInRadius(
				unit:GetTeam(),
				orderVector,
				nil,
				210,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			if #enemies == 0 then
				local allies = FindUnitsInRadius(
					unit:GetTeam(),
					orderVector,
					nil,
					160,
					DOTA_UNIT_TARGET_TEAM_FRIENDLY,
					DOTA_UNIT_TARGET_HERO,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				for i,x in pairs(allies) do
					if x==unit then allies[i] = nil end
				end
 				if #allies > 0 then
					DisplayError(caster_id, "dota_hud_error_target_has_disable_help")
					return false
				end
			end
		end
	elseif (
		orderType == DOTA_UNIT_ORDER_CAST_TARGET and
		target and
		disabledAbilities[ability:GetAbilityName()] and
		target:GetTeam() == unit:GetTeam() and
		PlayerResource:IsDisableHelpSetForPlayerID(target:GetPlayerOwnerID(), unit:GetPlayerOwnerID())
	) then
		DisplayError(unit:GetPlayerOwnerID(), "dota_hud_error_target_has_disable_help")
		return false
	end
end