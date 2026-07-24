--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_skeletonking/wraith_king_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "absorigin_follow",
				["attachment"] = "attach_weapon",
			},
		},
	},
	["particles/econ/items/wraith_king/wraith_king_relic_weapon/wraith_king_relic_weapon.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_attack1",
			},
		},
	},
	["particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_witness_ambient.vpcf"] = {
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
				["attachment"] = "attach_palm",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_forearm",
			},
		},
	},
	["particles/econ/items/wraith_king/wraith_king_winterblight_weapon/wraith_king_winterblight_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_l",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_r",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_mouth",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon",
			},
		},
	},
	["particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_ambient.vpcf"] = {
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
				["attachment"] = "attach_palm",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_forearm",
			},
		},
	},
	["particles/econ/items/wraith_king/wraith_king_glory/wraith_king_glory_shoulder_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder_base",
			},
		},
	},
}