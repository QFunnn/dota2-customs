--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_juggernaut/juggernaut_blade_generic.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_sword",
			},
		},
	},
	["particles/econ/items/juggernaut/jugg_sword_default/jugg_weapon_glow.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "blade_attachment",
			},
		},
	},
	["particles/econ/items/juggernaut/lord_sword_ivory/jugg_weapon_glow_variation_ivory.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "blade_attachment",
			},
		},
	},
	["particles/econ/items/juggernaut/jugg_sword_fireborn_odachi/jugg_weapon_glow_variation_fireborn_odachi.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "blade_attachment",
			},
		},
	},
	["particles/econ/items/juggernaut/highplains_sword_longfang/jugg_weapon_glow_variation_longfang.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "blade_attachment",
			},
		},
	},
	["particles/econ/items/juggernaut/nomad_sword_grand_claive/jugg_weapon_glow_variation_grand_claive.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "blade_attachment",
			},
		},
	},
	["particles/econ/items/juggernaut/jugg_sword_jade/jugg_weapon_glow_variation_jade.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "blade_attachment",
			},
		},
	},
	["particles/econ/items/juggernaut/jugg_sword_script/jugg_weapon_glow_variation_script.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_sword",
			},
		},
	},
	["particles/econ/items/juggernaut/jugg_sword_dragon/juggernaut_blade_ambient_dragon.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/units/heroes/hero_juggernaut/juggernaut_blade_generic_econ.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_sword",
			},
		},
	},
	["particles/econ/items/juggernaut/bladekeeper_swordglow/dc_juggernaut_blade.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_jugg_blade",
			},
		},
	},
	["particles/econ/items/juggernaut/bladekeeper_headglow/dc_juggernaut_bladekeeper_head.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_jugg_head",
			},
		},
	},
	["particles/econ/items/juggernaut/jugg_serrakura/jugg_serrakurra_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_sword",
			},
		},
	},
	["particles/econ/items/pets/pet_frondillo/almond_ambient_gold.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_almond_fx",
			},
		},
	},
	["particles/econ/items/juggernaut/armor_of_the_favorite/juggernaut_favorite_shoulder_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/juggernaut/armor_of_the_favorite/juggernaut_favorite_eyes.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_l",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_r",
			},
		},
	},
	["particles/econ/items/juggernaut/armor_of_the_favorite/juggernaut_favorite_body_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_hitloc",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_belt",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
}