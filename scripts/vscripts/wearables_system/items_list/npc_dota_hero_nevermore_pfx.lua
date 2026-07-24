--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_nevermore/shadow_fiend_ambient_eyes.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eyeL",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eyeR",
			},
		},
	},
	["particles/units/heroes/hero_nevermore/nevermore_trail.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_hitloc",
			},
		},
	},
	["particles/units/heroes/hero_nevermore/nevermore_ambient_glow.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_R0",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_R1",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_R2",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_L0",
			},
			{
				["control_point_index"] = "5",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_L1",
			},
			{
				["control_point_index"] = "6",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_L2",
			},
			{
				["control_point_index"] = "7",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_head",
			},
		},
	},
	["particles/econ/items/shadow_fiend/sf_desolation/shadow_fiend_desolation_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_arm_L",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_arm_R",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/shadow_fiend/sf_ferrum/shadow_fiend_ferrum_shoulder_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder_l",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder_r",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_arm_l",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_arm_r",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_hitloc",
			},
			{
				["control_point_index"] = "5",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/shadow_fiend/sf_ferrum/shadow_fiend_ferrum_head_ambient.vpcf"] = {
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
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_ambient_eyes.vpcf"] = {
		["attach_type"] = "customorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eyeL",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eyeR",
			},
		},
	},
}