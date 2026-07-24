--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_leshrac/leshrac_ambient_glow.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/econ/items/leshrac/leshrac_spirethorn/leshrac_spirethorn_staff.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack1",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack2",
			},
		},
	},
	["particles/econ/items/leshrac/leshrac_tormented_staff/leshrac_tormented_staff.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack1",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack2",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_bot",
			},
		},
	},
}