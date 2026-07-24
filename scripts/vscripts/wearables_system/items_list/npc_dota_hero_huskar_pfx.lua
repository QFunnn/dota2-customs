--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/econ/items/huskar/huskar_searing_dominator/huskar_searing_dominator_backhair.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "fx_hair",
			},
		},
	},
	["particles/econ/items/huskar/huskar_searing_dominator/huskar_searing_dominator_feather.vpcf"] = {
		["attach_type"] = "customorigin_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "fx_tuft",
			},
		},
	},
	["particles/econ/items/huskar/huskar_searing_dominator/huskar_searing_dominator_eyes.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "fx_eyes_l",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "fx_eyes_r",
			},
		},
	},
	["particles/econ/items/huskar/huskar_searing_dominator/huskar_searingdom_ambient_glows.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
}