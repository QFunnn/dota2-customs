--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_razor/razor_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "energyCore",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/units/heroes/hero_razor/razor_ambient_main.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "energyCore",
			},
		},
	},
	["particles/units/heroes/hero_razor/razor_whip.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_whip",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_whip1",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_whip2",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_whip3",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_whip4",
			},
			{
				["control_point_index"] = "5",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_whip5",
			},
		},
	},
	["particles/econ/items/razor/razor_punctured_crest/razor_helmet_blade_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_head",
			},
		},
	},
	["particles/econ/items/razor/razor_punctured_crest_golden/razor_helmet_blade_ambient_golden.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_head",
			},
		},
	},
    ["particles/econ/items/razor/razor_arcana/razor_arcana_base_ambient_game.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
        ["mega_attach"] = "parent",
		["control_points"] = 
        {

		},
	},
    ["particles/econ/items/razor/razor_arcana/razor_arcana_base_ambient_game_v2.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
        ["mega_attach"] = "parent",
		["control_points"] = 
        {

		},
	},
}