--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_elbow_L",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_elbow_R",
			},
		},
	},
	["particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_ambient_wing.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "absorigin_follow",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_L",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_R",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_inner_L",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_inner_R",
			},
			{
				["control_point_index"] = "5",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_innerB_L",
			},
			{
				["control_point_index"] = "6",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_innerB_R",
			},
			{
				["control_point_index"] = "7",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_outer_L",
			},
			{
				["control_point_index"] = "8",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_outer_R",
			},
		},
	},
	["particles/econ/items/nightstalker/nightstalker_evil_eyed_wings/nightstalker_ambient_evil_eyed_wings.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "absorigin_follow",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_l_tip_01",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_l_tip_02",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_l_tip_03",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_l_tip_04",
			},
			{
				["control_point_index"] = "5",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_r_tip_01",
			},
			{
				["control_point_index"] = "6",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_r_tip_02",
			},
			{
				["control_point_index"] = "7",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_r_tip_03",
			},
			{
				["control_point_index"] = "8",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_r_tip_04",
			},
		},
	},
}