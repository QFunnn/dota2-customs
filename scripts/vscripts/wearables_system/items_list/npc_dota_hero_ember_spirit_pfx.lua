--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_head.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_eyes.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
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
		},
	},
	["particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_shoulder_glow.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder_glow_r",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder_glow_l",
			},
		},
	},
	["particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_armor_glow.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_armor_glow",
			},
		},
	},
	["particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_sword_primary.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_r",
			},
		},
	},
	["particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_sword_primary_blade.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_r",
			},
		},
	},
	["particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_sword_offhand.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_l",
			},
		},
	},
	["particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_sword_offhand_blade.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_l",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_lesser_greater_purifier/ember_spirit_ambient_greaterpurifier_primary_blade.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_r",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_lesser_greater_purifier/ember_spirit_ambient_lesserpurifier_offhand_blade.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_l",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_ashes/ember_spirit_ashes_ambient_armor_glow.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_armor_glow",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_ashes/ember_spirit_ashes_ambient_head.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_head",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_ashes/ember_spirit_ashes_ambient_sword_primary.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_r",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_ashes/ember_spirit_ashes_ambient_sword_primary_blade.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_r",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_ashes/ember_spirit_ashes_ambient_sword_offhand.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_l",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_ashes/ember_spirit_ashes_ambient_sword_offhand_blade.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_l",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_vanishing_flame/ember_spirit_vanishing_flame_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/ember_spirit/ember_spirit_vanishing_flame/ember_spirit_vanishing_flame_ambient_gem.vpcf"] = {
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
				["attachment"] = "attach_gem",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_glyph",
			},
		},
	},
}