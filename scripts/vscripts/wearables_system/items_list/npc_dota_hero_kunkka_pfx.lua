--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


return {
	["particles/units/heroes/hero_kunkka/kunkka_weapon_glow_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_sword",
			},
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_tidebringer",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_tidebringer_2",
			},
		},
	},
	["particles/econ/items/kunkka/kunkka_weapon_bladebiter/kunkka_bladebiter_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_blade",
			},
		},
	},
	["particles/econ/items/kunkka/kunkka_leviathan_pipe/kunkka_leviation_pipe.vpcf"] = {
		["attach_type"] = "point_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_pipe",
			},
		},
	},
}