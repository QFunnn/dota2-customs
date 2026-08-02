--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


return {
	["particles/econ/items/invoker/invoker_ti6/invoker_ti6_cape_ambient.vpcf"] = {
		["attach_type"] = "absorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_spine",
			},
		},
	},
	["particles/econ/items/invoker/invoker_apex/invoker_magus_apex_ambient.vpcf"] = {
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
				["attachment"] = "attach_eye_r",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_l",
			},
		},
	},
	["particles/econ/items/invoker/invoker_darklord/invoker_darklord_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_gem_front",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_gem_back",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder_l",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder_r",
			},
		},
	},
}