--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/econ/items/alchemist/alchemist_prison_ballchain/alchemist_ballchain_sparks.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_ballchain",
			},
		},
	},
	["particles/econ/items/alchemist/alchemist_aurelian_weapon/alchemist_ambient_aurelian_l.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_l",
			},
		},
	},
	["particles/econ/items/alchemist/alchemist_aurelian_weapon/alchemist_ambient_aurelian_r.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_r",
			},
		},
	},
	["particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_arms_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_knuckle_index",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_knuckle_middle",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_knuckle_pinky",
			},
		},
	},
	["particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_offhand_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_bottle_l",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_bottle_r",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_cloth",
			},
		},
	},
	["particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_shoulder_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_neck_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
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
				["attachment"] = "attach_cigar",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/alchemist/alchemist_midas_knuckles/alch_ambient_knuckles.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
}