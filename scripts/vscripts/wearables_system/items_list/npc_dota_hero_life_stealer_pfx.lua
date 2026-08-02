--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


return {
	["particles/units/heroes/hero_life_stealer/life_stealer_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "absorigin_follow",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_hitloc",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack1",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack2",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_jaw",
			},
		},
	},
}