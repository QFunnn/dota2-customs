--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf"] = {
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
	["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf"] = {
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
	["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf"] = {
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
	["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf"] = {
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
	["particles/units/heroes/hero_terrorblade/terrorblade_ambient_eyes.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_r",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_l",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_mouth",
			},
		},
	},
	["particles/terrorblade_custom/terrorblade_feet_effects.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_ambient_body_arcana_horns.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_hitloc",
			},
		},
	},
	["particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf"] = {
		["attach_type"] = "absorigin_follow",
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
				["attachment"] = "attach_hitloc",
			},
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_r1",
			},
			{
				["control_point_index"] = "4",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_r2",
			},
			{
				["control_point_index"] = "5",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_r3",
			},
			{
				["control_point_index"] = "6",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_l1",
			},
			{
				["control_point_index"] = "7",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_l2",
			},
			{
				["control_point_index"] = "8",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_wing_l3",
			},
			{
				["control_point_index"] = "9",
				["attach_type"] = "worldorigin",
				["position"] = "0 0 0",
			},
			{
				["control_point_index"] = "15",
				["attach_type"] = "worldorigin",
				["position"] = "0 0 0",
			},
			{
				["control_point_index"] = "16",
				["attach_type"] = "worldorigin",
				["position"] = "0 0 0",
			},
		},
	},
	["particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_head.vpcf"] = {
		["attach_type"] = "point_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_r",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_eye_l",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_mouth",
			},
			{
				["control_point_index"] = "15",
				["attach_type"] = "worldorigin",
				["position"] = "0 0 0",
			},
			{
				["control_point_index"] = "16",
				["attach_type"] = "worldorigin",
				["position"] = "0 0 0",
			},
		},
	},
	["particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_corrupted_l.vpcf"] = {
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
	["particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_blade_corrupted.vpcf"] = {
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
	["particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_corrupted_r.vpcf"] = {
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
	["particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_blade_corrupted_2.vpcf"] = {
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
	["particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_back_ambient_ti8.vpcf"] = {
	},
}