--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local ____exports = {}
local precacheEveryResourceInKV, precacheResource, precacheResString, precacheUnits, precacheItems, precacheEverythingFromTable, getAllHeroSoundEventFiles, collectHeroNamesFromKV
local ____models_autogen = require("utils.models_autogen")
local modelsAuto = ____models_autogen.default
local ____particles_autogen = require("utils.particles_autogen")
local particlesAuto = ____particles_autogen.default
function precacheEveryResourceInKV(kvFileList, context)
	__TS__ArrayForEach(kvFileList, function(____, file)
		local kvTable = LoadKeyValues(file)
		precacheEverythingFromTable(kvTable, context)
	end)
end
function precacheResource(resourceList, context)
	__TS__ArrayForEach(resourceList, function(____, resource)
		precacheResString(resource, context)
	end)
end
function precacheResString(res, context)
	if __TS__StringEndsWith(res, ".vpcf") then
		PrecacheResource("particle", res, context)
	elseif __TS__StringEndsWith(res, ".vsndevts") then
		PrecacheResource("soundfile", res, context)
	elseif __TS__StringEndsWith(res, ".vmdl") then
		PrecacheResource("model", res, context)
	end
end
function precacheUnits(unitNamesList, context)
	if context ~= nil then
		__TS__ArrayForEach(unitNamesList, function(____, unitName)
			PrecacheUnitByNameSync(unitName, context)
		end)
	else
		__TS__ArrayForEach(unitNamesList, function(____, unitName)
			PrecacheUnitByNameAsync(unitName, function() end)
		end)
	end
end
function precacheItems(itemList, context)
	__TS__ArrayForEach(itemList, function(____, itemName)
		PrecacheItemByNameSync(itemName, context)
	end)
end
function precacheEverythingFromTable(kvTable, context)
	for k, v in pairs(kvTable) do
		if type(v) == "table" then
			precacheEverythingFromTable(v, context)
		elseif type(v) == "string" then
			precacheResString(v, context)
		end
	end
end
function getAllHeroSoundEventFiles()
	local heroListKV = LoadKeyValues("scripts/npc/hero_list.txt")
	local heroNameSet = {}
	collectHeroNamesFromKV(heroListKV, heroNameSet)
	local soundFiles = {}
	for heroUnitNameRaw in pairs(heroNameSet) do
		local heroUnitName = tostring(heroUnitNameRaw)
		local heroName = __TS__StringReplace(heroUnitName, "npc_dota_hero_", "")
		soundFiles[#soundFiles + 1] = ("soundevents/game_sounds_heroes/game_sounds_" .. heroName) .. ".vsndevts"
	end
	return soundFiles
end
function collectHeroNamesFromKV(kvTable, heroNameSet)
	if type(kvTable) ~= "table" then
		return
	end
	for k, v in pairs(kvTable) do
		if type(k) == "string" then
			local key = tostring(k)
			if __TS__StringStartsWith(key, "npc_dota_hero_") then
				heroNameSet[key] = true
			end
		end
		if type(v) == "table" then
			collectHeroNamesFromKV(v, heroNameSet)
		end
	end
end
function ____exports.default(context)
	local heroSoundEventFiles = getAllHeroSoundEventFiles()
	print("开始预加载....")
	local ____precacheResource_1 = precacheResource
	local ____array_0 = __TS__SparseArrayNew(
		"soundevents/custom_game/event_cs.vsndevts",
		"soundevents/custom_game/open_door.vsndevts",
		"soundevents/custom_game/key_1.vsndevts",
		"soundevents/custom_game/ak_bgm.vsndevts",
		"soundevents/game_sounds_music.vsndevts",
		unpack(heroSoundEventFiles or {})
	)
	__TS__SparseArrayPush(
		____array_0,
		"models/props_gameplay/dummy/dummy_large.vmdl",
		"models/props_tree/frostivus_tree.vmdl",
		"particles/props_frostivus/frostivus_snowman_idle.vpcf",
		"particles/bb/es_earthshaker_arcana_aftershock_screen.vpcf",
		"soundevents/game_sounds_heroes/game_sounds_skeletonking.vsndevts",
		"soundevents/game_sounds_heroes/game_sounds_sandking.vsndevts",
		"soundevents/game_sounds_heroes/game_sounds_doombringer.vsndevts",
		"soundevents/game_sounds_heroes/game_sounds_skywrath_mage.vsndevts",
		"soundevents/game_sounds_creeps/game_sounds_creeps.vsndevts",
		"soundevents/game_sounds_heroes/game_sounds_witchdoctor.vsndevts",
		"soundevents/game_sounds_heroes/game_sounds_primalbeast.vsndevts",
		"soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts",
		"sounds/vo/dark_seer/dkseer_attack_06.vsnd",
		"sounds/ui/item_pickup_shop.vsnd",
		"soundevents/game_sounds_billiards.vsndevts",
		"models/billiards/lp_billiards_table.vmdl",
		"models/king_tableball/king_tableball_bone_01.vmdl",
		"models/king_tableball/king_tableball_rune_01.vmdl",
		"models/lp_eight_ball.vmdl",
		"models/lp_billiards_pocket_blocker.vmdl",
		"models/test/lp_empty_carrier.vmdl",
		"models/heroes/ringmaster/ringmaster_box.vmdl",
		"particles/econ/events/ti10/portal/portal_open_good_parent.vpcf",
		"particles/huskar_2021_immortal_burning_spear_debuff_2.vpcf",
		"particles/range_finder_linear_1.vpcf",
		"particles/range_finder_linear_2.vpcf",
		"particles/ui/ui_accept_billow_smoke.vpcf",
		"particles/events/crownfall/exclamation.vpcf",
		"particles/courier_snapjaw_ambient_rocket_explosion_flashb.vpcf",
		"particles/hero/pa/phantom_assassin_mark_overhead_counterb.vpcf",
		"particles/minigame/selectdrag_selected_ring.vpcf",
		"particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf",
		"soundevents/game_sounds_heroes/game_sounds_stormspirit.vsndevts",
		"particles/ui/ui_accept_billow_smoke_y.vpcf",
		"particles/dd/neutral_item_drop_lvl4.vpcf",
		"particles/bristleback_warpath_active_screenfx_2.vpcf",
		"models/events/crownfall/survivors/particles/crownfall_palace_brazier_fire.vpcf",
		"models/props_structures/tower_upgrade/tower_upgrade.vmdl",
		"models/custom_game/package/realm/cube/rubick_cube_01a.vmdl",
		"models/custom_game/package/realm/cube/rubick_cube_01b.vmdl",
		"models/custom_game/package/realm/cube/rubick_cube_01c.vmdl",
		"models/custom_game/package/realm/cube/rubick_cube_01d.vmdl",
		"particles/traps/pendulum/wheel_scrape_ember_r.vpcf",
		"particles/traps/pendulum/wheel_scrape_shake.vpcf",
		"particles/traps/pendulum/wheel_scrape.vpcf",
		"particles/traps/pendulum/blade_trails.vpcf",
		"particles/traps/pendulum/blade_trails_flat.vpcf",
		"models/props/traps/hooded_fang/hooded_fang.vmdl",
		"models/props/traps/barking_dog/barking_dog.vmdl",
		"models/props_structures/ancient_trigger001.vmdl",
		"models/props/traps/pendulum/pendulum_extended.vmdl",
		"particles/world_tower/tower_upgrade/ti7_radiant_tower_orb.vpcf",
		"particles/units/heroes/hero_invoker/invoker_ice_wall_debuff_frost.vpcf",
		"sounds/misc/crownfall/xp_pickup.vsnd",
		"particles/units/heroes/hero_tinker/tinker_laser.vpcf",
		"particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf",
		"soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts",
		"particles/units/heroes/hero_pugna/pugna_life_drain.vpcf",
		unpack(particlesAuto or {})
	)
	__TS__SparseArrayPush(____array_0, unpack(modelsAuto or {}))
	____precacheResource_1({ __TS__SparseArraySpread(____array_0) }, context)
	precacheEveryResourceInKV({}, context)
	precacheUnits({
		"npc_dota_hero_axe",
		"npc_dota_hero_lina",
		"npc_dota_hero_ogre_magi",
		"npc_dota_hero_rubick",
		"npc_dota_hero_ringmaster",
		"npc_dota_hero_phantom_assassin",
		"npc_dota_hero_drow_ranger",
		"npc_dota_hero_crystal_maiden",
		"npc_dota_hero_marci",
		"npc_dota_hero_enigma",
		"monster_11309_eidolon",
		"monster_11316_meteor",
		"npc_dota_custom_pool_ball_1",
		"npc_dota_custom_pool_ball_2",
		"npc_dota_custom_pool_ball_3",
		"npc_dota_custom_pool_ball_4",
		"npc_dota_custom_pool_ball_5",
		"npc_dota_custom_pool_ball_6",
		"npc_dota_custom_pool_ball_7",
		"npc_dota_custom_pool_ball_8",
		"npc_dota_custom_pool_ball_9",
		"npc_dota_custom_pool_ball_10",
		"npc_dota_custom_pool_ball_11",
		"npc_dota_custom_pool_ball_12",
		"npc_dota_custom_pool_ball_13",
		"npc_dota_custom_pool_ball_14",
		"npc_dota_custom_pool_ball_15",
		"npc_dota_custom_billiards_pocket_blocker",
	}, context)
	precacheItems({}, context)
	print("[Precache] 预加载完成.")
end
return ____exports