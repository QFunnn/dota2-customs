--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--Abilities
if item_surprise_gift == nil then
	item_surprise_gift = class({})
end
if item_surprise_gift.ITEM_LIST == nil then
	if IsServer() then
		item_surprise_gift.ITEM_LIST = {
			["item_clarity"] = 0,
			["item_faerie_fire"] = 0,
			["item_smoke_of_deceit_lua"] = 0,
			["item_enchanted_mango"] = 0,
			["item_flask"] = 0,
			["item_tango"] = 0,
			["item_blood_grenade"] = 0,
			["item_bottle"] = 0,
			["item_aghanims_shard"] = 0,
			["item_aegis_lua"] = 0,
			["item_book_of_strength"] = 0,
			["item_book_of_agility"] = 0,
			["item_book_of_intelligence"] = 0,
			["item_relearn_torn_page_lua"] = 0,
			["item_relearn_book_lua"] = 0,
			["item_summon_book_lua"] = 0,
			["item_paragon_book"] = 0,
			["item_extra_creature_kobold"] = 0,
			["item_extra_creature_gnoll_assassin"] = 0,
			["item_extra_creature_elf_wolf"] = 0,
			["item_extra_creature_timber_spider"] = 0,
			["item_extra_creature_rock_golem"] = 0,
			["item_branches"] = 0,
			["item_gauntlets"] = 0,
			["item_slippers"] = 0,
			["item_mantle"] = 0,
			["item_circlet"] = 0,
			["item_belt_of_strength"] = 0,
			["item_boots_of_elves"] = 0,
			["item_robe"] = 0,
			["item_crown"] = 0,
			["item_ogre_axe"] = 0,
			["item_blade_of_alacrity"] = 0,
			["item_staff_of_wizardry"] = 0,
			["item_diadem"] = 0,
			["item_extra_creature_explode_spider"] = 0,
			["item_extra_creature_satyr_trickster"] = 0,
			["item_extra_creature_ghost"] = 0,
			["item_extra_creature_dark_troll_warlord"] = 0,
			["item_extra_creature_centaur_khan"] = 0,
			["item_extra_creature_prowler_shaman"] = 0,
			["item_extra_creature_big_thunder_lizard"] = 0,
			["item_extra_creature_spider_range"] = 0,
			["item_extra_creature_granite_golem"] = 0,
			["item_quelling_blade"] = 0,
			["item_ring_of_protection"] = 0,
			["item_infused_raindrop"] = 0,
			["item_orb_of_venom"] = 0,
			["item_blight_stone"] = 0,
			["item_blades_of_attack"] = 0,
			["item_gloves"] = 0,
			["item_chainmail"] = 0,
			["item_helm_of_iron_will"] = 0,
			["item_broadsword"] = 0,
			["item_blitz_knuckles"] = 0,
			["item_javelin"] = 0,
			["item_claymore"] = 0,
			["item_mithril_hammer"] = 0,
			["item_ring_of_regen"] = 0,
			["item_sobi_mask"] = 0,
			["item_magic_stick"] = 0,
			["item_fluffy_hat"] = 0,
			["item_wind_lace"] = 0,
			["item_cloak"] = 0,
			["item_boots"] = 0,
			["item_gem"] = 0,
			["item_lifesteal"] = 0,
			["item_voodoo_mask"] = 0,
			["item_shadow_amulet"] = 0,
			["item_ghost"] = 0,
			["item_blink"] = 0,
			["item_ring_of_health"] = 0,
			["item_void_stone"] = 0,
			["item_noob_staff"] = 0,
			["item_magic_wand"] = 0,
			["item_null_talisman"] = 0,
			["item_wraith_band"] = 0,
			["item_bracer"] = 0,
			["item_soul_ring"] = 0,
			["item_orb_of_corrosion"] = 0,
			["item_falcon_blade"] = 0,
			["item_power_treads"] = 0,
			["item_phase_boots"] = 0,
			["item_oblivion_staff"] = 0,
			["item_pers"] = 0,
			["item_mask_of_madness"] = 0,
			["item_hand_of_midas_lua"] = 0,
			["item_helm_of_the_dominator"] = 0,
			["item_helm_of_the_overlord"] = 0,
			["item_gang_letter"] = 0,
			["item_gang_senior_letter"] = 0,
			["item_gang_ghost_letter"] = 0,
			["item_gang_dinner_invitation_letter"] = 0,
			["item_gang_gauntlet"] = 0,
			["item_gang_plane_ticket"] = 0,
			["item_moon_shard"] = 0,
			["item_dark_moon_shard"] = 0,
			["item_buckler"] = 0,
			["item_ring_of_basilius"] = 0,
			["item_headdress"] = 0,
			["item_urn_of_shadows"] = 0,
			["item_tranquil_boots"] = 0,
			["item_pavise"] = 0,
			["item_arcane_boots"] = 0,
			["item_ancient_janggo"] = 0,
			["item_mekansm"] = 0,
			["item_holy_locket"] = 0,
			["item_vladmir"] = 0,
			["item_spirit_vessel"] = 0,
			["item_pipe"] = 0,
			["item_guardian_greaves"] = 0,
			["item_boots_of_bearing"] = 0,
			["item_devastator"] = 0,
			["item_saw_wheel"] = 0,
			["item_torture_pipe_1_datadriven"] = 0,
			["item_torture_pipe_2_datadriven"] = 0,
			["item_veil_of_discord"] = 0,
			["item_glimmer_cape"] = 0,
			["item_necronomicon"] = 0,
			["item_force_staff"] = 0,
			["item_aether_lens"] = 0,
			["item_witch_blade"] = 0,
			["item_cyclone"] = 0,
			["item_rod_of_atos"] = 0,
			["item_orchid"] = 0,
			["item_solar_crest"] = 0,
			["item_ultimate_scepter"] = 0,
			["item_refresher_lua"] = 0,
			["item_octarine_core"] = 0,
			["item_sheepstick"] = 0,
			["item_gungir"] = 0,
			["item_wind_waker"] = 0,
			["item_demonicon"] = 0,
			["item_stargazing_staff"] = 0,
			["item_aluneth"] = 0,
			["item_azure_song"] = 0,
			["item_star_design"] = 0,
			["item_vanguard"] = 0,
			["item_blade_mail"] = 0,
			["item_aeon_disk_lua"] = 0,
			["item_soul_booster"] = 0,
			["item_eternal_shroud"] = 0,
			["item_crimson_guard"] = 0,
			["item_lotus_orb"] = 0,
			["item_black_king_bar"] = 0,
			["item_hurricane_pike"] = 0,
			["item_manta"] = 0,
			["item_sphere"] = 0,
			["item_shivas_guard"] = 0,
			["item_heart"] = 0,
			["item_assault"] = 0,
			["item_bloodstone"] = 0,
			["item_bloodstone_2"] = 0,
			["item_felling_shield_lua_2"] = 0,
			["item_felling_shield_lua_3"] = 0,
			["item_felling_axe_1_lua"] = 0,
			["item_felling_axe_2_lua"] = 0,
			["item_felling_axe_3_lua"] = 0,
			["item_felling_axe_4_lua"] = 0,
			["item_felling_axe_5_lua"] = 0,
			["item_ranged_cleave"] = 0,
			["item_ranged_cleave_2"] = 0,
			["item_lesser_crit"] = 0,
			["item_meteor_hammer"] = 0,
			["item_armlet"] = 0,
			["item_basher"] = 0,
			["item_invis_sword"] = 0,
			["item_desolator"] = 0,
			["item_bfury"] = 0,
			["item_ethereal_blade"] = 0,
			["item_nullifier"] = 0,
			["item_monkey_king_bar"] = 0,
			["item_butterfly"] = 0,
			["item_radiance"] = 0,
			["item_greater_crit"] = 0,
			["item_silver_edge"] = 0,
			["item_rapier"] = 0,
			["item_bloodthorn"] = 0,
			["item_abyssal_blade"] = 0,
			["item_revenants_brooch"] = 0,
			["item_disperser"] = 0,
			["item_angels_demise"] = 0,
			["item_dragon_lance"] = 0,
			["item_sange"] = 0,
			["item_yasha"] = 0,
			["item_kaya"] = 0,
			["item_echo_sabre"] = 0,
			["item_maelstrom"] = 0,
			["item_diffusal_blade"] = 0,
			["item_mage_slayer"] = 0,
			["item_phylactery"] = 0,
			["item_heavens_halberd"] = 0,
			["item_kaya_and_sange"] = 0,
			["item_sange_and_yasha"] = 0,
			["item_yasha_and_kaya"] = 0,
			["item_satanic"] = 0,
			["item_skadi"] = 0,
			["item_mjollnir"] = 0,
			["item_overwhelming_blink"] = 0,
			["item_swift_blink"] = 0,
			["item_arcane_blink"] = 0,
			["item_harpoon"] = 0,
			["item_ring_of_tarrasque"] = 0,
			["item_tiara_of_selemene"] = 0,
			["item_cornucopia"] = 0,
			["item_energy_booster"] = 0,
			["item_vitality_booster"] = 0,
			["item_point_booster"] = 0,
			["item_platemail"] = 0,
			["item_talisman_of_evasion"] = 0,
			["item_hyperstone"] = 0,
			["item_ultimate_orb"] = 0,
			["item_demon_edge"] = 0,
			["item_mystic_staff"] = 0,
			["item_reaver"] = 0,
			["item_eagle"] = 0,
			["item_relic"] = 0,
		}
		local t = {}
		local iTotalWeight = 0
		for itemName, itemCost in pairs(item_surprise_gift.ITEM_LIST) do
			local item = CreateItem(itemName, nil, nil)
			if IsValid(item) then
				local iCost = item:GetCost()
				if iCost >= 5000 then
					local fSub = iCost - 5000
					iCost = 5000 + fSub * 2
				end
				item_surprise_gift.ITEM_LIST[itemName] = iCost
				t[itemName] = 10000000 / math.pow(iCost, 1.5)
				iTotalWeight = iTotalWeight + t[itemName]
				item:RemoveSelf()
			end
		end

		item_surprise_gift.ITEM_POOL = WeightPool(t)
	end
end
function item_surprise_gift:OnSpellStart()
	local hCaster = self:GetCaster()

	if IsValid(hCaster) then
		local vFrogPos = GoodFrog:GetAbsOrigin()

		local itemName = self.ITEM_POOL:Random()
		self:SpendCharge()
		hCaster:AddItemByName(itemName)

		CustomGameEventManager:Send_ServerToAllClients("OpenSurpriseGift", { message = "OpenGiftNotify", player_id = hCaster:GetPlayerOwnerID(), string_itemname = itemName })

		local iCost = item_surprise_gift.ITEM_LIST[itemName]

		local fFireWorks = math.floor(math.sqrt(math.ceil(iCost / 50)))
		Timer(DoUniqueString("item_surprise_gift"), 0.1, function()
			fFireWorks = fFireWorks - 1
			local vPos = hCaster:GetAbsOrigin()

			local info = {
				EffectName = "particles/econ/events/frostivus/frostivus_fireworks.vpcf",
				Ability = self,
				Source = GoodFrog,
				Target = hCaster,
				iMoveSpeed = (vFrogPos - vPos):Length2D() / 1,
				bDodgeable = true,
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
				bProvidesVision = false,
				iVisionRadius = 200,
				iVisionTeamNumber = hCaster:GetTeamNumber(),
			}

			ProjectileManager:CreateTrackingProjectile(info)

			EmitSoundOn("FrostivusConsumable.Fireworks.Cast", GoodFrog)

			if fFireWorks > 0 then
				return RandomFloat(0.1, 0.5)
			else
				return nil
			end

		end)
	end
end
function item_surprise_gift:OnProjectileHit(hTarget, vLocation)
	local hCaster = self:GetCaster()
	EmitSoundOn("FrostivusConsumable.Fireworks.Explode", hCaster)
end