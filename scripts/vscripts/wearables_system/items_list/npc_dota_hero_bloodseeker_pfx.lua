--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	--["particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_eztzhok_ambient.vpcf"] = {
	--	["attach_type"] = "customorigin",
	--	["attach_entity"] = "parent",
	--	["control_points"] = {
	--		{
	--			["control_point_index"] = "0",
	--			["attach_type"] = "point_follow",
	--			["attachment"] = "attach_attack2",
	--		},
	--	},
	--},
	--["particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon_offhand/bloodseeker_eztzhok_offhand_ambient.vpcf"] = {
	--	["attach_type"] = "customorigin",
	--	["attach_entity"] = "parent",
	--	["control_points"] = {
	--		{
	--			["control_point_index"] = "0",
	--			["attach_type"] = "point_follow",
	--			["attachment"] = "attach_attack1",
	--		},
	--	},
	--},
	["particles/econ/items/bloodseeker/bloodseeker_relentless_hunter/bloodseeker_relentless_hunter_ambient.vpcf"] = {
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
				["attachment"] = "attach_l_eye",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_r_eye",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_feathers",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_l_feathers",
			},
			{
				["control_point_index"] = "5",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_r_feathers",
			},
		},
	},
}