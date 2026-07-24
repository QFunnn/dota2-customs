--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- naming it PrecacheManager because plain `Precache` is a reserved function name for addon_game_mode entity
PrecacheManager = {}


PrecacheManager.particles = {
	"particles/leader/leader_overhead.vpcf",
	"particles/orb_common.vpcf",
	"particles/orb_rare.vpcf",
	"particles/orb_epic.vpcf",
	"particles/treasure_courier_death.vpcf",
	"particles/capture_point_ring/capture_point_ring.vpcf",
	"particles/capture_point_ring/capture_point_ring_capturing.vpcf",
	"particles/capture_point_ring/capture_point_ring_clock.vpcf",
	"particles/orb_common_christmas.vpcf",
	"particles/orb_rare_christmas.vpcf",
	"particles/orb_christmas.vpcf",
	"particles/orb_spree/orb_spree_shockwave.vpcf",
	"particles/epic_pathfinder.vpcf",
	"particles/ui/fountain_range/fountain_range.vpcf",

	"particles/custom/generics/status_res_on_debuff/generic_status_res_on_debuff.vpcf",

	"particles/econ/courier/courier_ti10/courier_flying_rad_ti10_cloud.vpcf",

	"particles/econ/events/new_bloom/firecracker.vpcf",
	"particles/econ/events/new_bloom/firecracker_explode_cracker_intact.vpcf",
	"particles/econ/events/new_bloom/firecracker_intact.vpcf",
	"particles/econ/events/new_bloom/firecracker_explode.vpcf",
	"particles/econ/events/ti9/ti9_monkey_clap.vpcf",
	"particles/econ/events/ti9/ti9_monkey_expire_dirt.vpcf",
	"particles/econ/events/new_bloom/lion_dance_eyes_group.vpcf",
	"particles/econ/events/new_bloom/dragon_cast.vpcf",
	"particles/econ/events/frostivus/frostivus_snowman_cast.vpcf",
	"particles/econ/events/frostivus/frostivus_fireworks.vpcf",
	"particles/econ/events/frostivus/frostivus_fireworks_ability_illumination.vpcf",
	"particles/econ/events/ti9/shovel_dig.vpcf",
	"particles/econ/events/ti9/ti9_monkey_spawn.vpcf",
	"particles/econ/events/ti9/ti9_monkey_projectile.vpcf",

	"particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", --oracle prognosticate
}


PrecacheManager.soundevents = {
	"soundevents/game_sounds.vsndevts",
	"soundevents/soundevents_custom.vsndevts",
	"soundevents/custom_soundboard_soundevents.vsndevts",
	"soundevents/game_sounds_hero_demo.vsndevts",
	"soundevents/stickers/soundevents_stickers_season11.vsndevts",
	"soundevents/stickers/soundevents_stickers_season12.vsndevts",
}


PrecacheManager.models = {
	"models/props_gameplay/rat_balloon.vmdl",
	"models/props_gameplay/rat_balloon_fx.vmdl",
	"models/props_consumables/fatsnake/fatsnake.vmdl",
	"models/props_frostivus/frostivus_snowman.vmdl",
	"models/props_frostivus/frostivus_snowman_break.vmdl",
	"models/props_gameplay/firecracker_single.vmdl",
	"models/props_gameplay/lion_dance.vmdl",
	"models/props_gameplay/consumable_drums.vmdl",
	"models/props_gameplay/ti9_consumables_monkey.vmdl",
	"models/courier/lockjaw/lockjaw_flying.vmdl",
}


function PrecacheManager:PrecacheWebInventory(context)
	if not ITEM_DEFINITIONS then print("[Precache Manager] no definitions on precache run!") return end
	for item_name, data in pairs(ITEM_DEFINITIONS or {}) do
		if data.particles then
			for _, particle_data in pairs(data.particles) do
				print("[Precache Manager] precaching particle", particle_data.path)
				PrecacheResource("particle", particle_data.path, context)
			end
		end
		if data.particle_variants then
			for _, particle_data in pairs(data.particle_variants) do
				print("[Precache Manager] precaching particle variant", particle_data.path)
				PrecacheResource("particle", particle_data.path, context)
			end
		end
		if data.blink_particles then
			if data.blink_particles.start_name then
				PrecacheResource("particle", data.blink_particles.start_name, context)
			end
			if data.blink_particles.end_name then
				PrecacheResource("particle", data.blink_particles.end_name, context)
			end
		end

		if data.model_path then
			print("[Precache Manager] precaching model", data.model_path)
			PrecacheResource("model", data.model_path, context)
		end
	end
end


function PrecacheManager:Run(context)
	-- PrecacheManager:PrecacheWebInventory(context)

	for _, particle in pairs(PrecacheManager.particles) do
		print("[Precache] particle", particle)
		PrecacheResource("particle", particle, context)
	end

	for _, sound in pairs(PrecacheManager.soundevents) do
		print("[Precache] sound file", sound)
		PrecacheResource("soundfile", sound, context)
	end

	for _, model in pairs(PrecacheManager.models) do
		print("[Precache] model", model)
		PrecacheResource("model", model, context)
	end

	PrecacheUnitByNameSync("npc_dota_hero_target_dummy", context)
end


_G.PRECACHE_RESOURCE_LISTS = {}
function PrecacheManager:PrecacheResourceListAsync(resource_list, callback)
	if table.count(resource_list) > 0 then
		table.insert(_G.PRECACHE_RESOURCE_LISTS, resource_list)
		PrecacheItemByNameAsync("item_precache_dummy", callback)
	else
		callback()
	end
end