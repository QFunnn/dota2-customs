--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/econ/items/centaur/centaur_ti6/centaur_ti6_ambient.vpcf"] = {
		["attach_type"] = "customorigin_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_head",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_l",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_r",
			},
		},
	},
	["particles/econ/items/centaur/centaur_ti6_gold/centaur_ti6_ambient_gold.vpcf"] = {
		["attach_type"] = "customorigin_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_head",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_l",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_r",
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
	["particles/econ/items/centaur/battle_dress_of_the_proven/centaur_proven_head_eyes.vpcf"] = {
		["attach_type"] = "customorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_r",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_l",
			},
		},
	},
	["particles/econ/items/centaur/battle_dress_of_the_proven/centaur_proven_axe_eyes.vpcf"] = {
		["attach_type"] = "customorigin_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "axe_eyes",
			},
		},
	},
	["particles/econ/items/centaur/battle_dress_of_the_proven/centaur_proven_axe_edge.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon",
			},
		},
	},
}