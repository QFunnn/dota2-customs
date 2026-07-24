--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_bane/bane_slime_trail.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/units/heroes/hero_bane/bane_hand_drip_right.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack2",
			},
		},
	},
	["particles/units/heroes/hero_bane/bane_hand_drip.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack1",
			},
		},
	},
	["particles/econ/items/bane/slumbering_terror/bane_slumbering_terror_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_elbow_r",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_elbow_l",
			},
			{
				["control_point_index"] = "0",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/bane/unhallowed_nightmares/bane_unhallowed_nightmares_back_infused.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_spine_01",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_spine_02",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_spine_03",
			},
		},
	},
	["particles/econ/items/bane/unhallowed_nightmares/bane_unhallowed_nightmares_back.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_spine_01",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_spine_02",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_spine_03",
			},
		},
	},
	["particles/econ/items/bane/unhallowed_nightmares/bane_unhallowed_nightmares_shoulder.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_l_orb",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_r_orb",
			},
		},
	},
}