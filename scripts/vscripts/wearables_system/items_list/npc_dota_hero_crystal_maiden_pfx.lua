--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_crystalmaiden/maiden_ambient_mouth.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_mouth",
			},
		},
	},
	["particles/units/heroes/hero_crystalmaiden/maiden_ambient_hand.vpcf"] = {
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
	["particles/econ/items/crystal_maiden/crystal_maiden_snowowl/crystal_maiden_snowowl.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_orb_top",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_orb_bottom",
			},
		},
	},
	["particles/econ/items/crystal_maiden/crystal_maiden_pw_staff/crystal_maiden_pw_staff.vpcf"] = {
		["attach_type"] = "point_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "weapon_fx",
			},
		},
	},
	["particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/crystal_maiden_cowl_ambient.vpcf"] = {
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
	["particles/econ/items/crystal_maiden/crystal_maiden_ward_staff/crystal_maiden_ward_staff_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_staff_tip",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_staff_base",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "absorigin_follow",
			},
		},
	},
	["particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_arcana_body_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},


    
    ["particles/units/heroes/hero_crystalmaiden_persona/cm_persona_ambient_crystals.vpcf"] = 
    {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = 
        {
			{
				["control_point_index"] = "11",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_L_A",
			},
            {
				["control_point_index"] = "12",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_R_A",
			},
            {
				["control_point_index"] = "13",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_L_B",
			},
            {
				["control_point_index"] = "14",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_R_B",
			},
            {
				["control_point_index"] = "15",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_L_C",
			},
            {
				["control_point_index"] = "16",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_R_C",
			},
		},
	},
    ["particles/econ/items/crystal_maiden/cm_persona_avatar/cm_persona_avatar_crystals_ambient.vpcf"] = 
    {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = 
        {
			{
				["control_point_index"] = "11",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_L_A",
			},
            {
				["control_point_index"] = "12",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_R_A",
			},
            {
				["control_point_index"] = "13",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_L_B",
			},
            {
				["control_point_index"] = "14",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_R_B",
			},
            {
				["control_point_index"] = "15",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_L_C",
			},
            {
				["control_point_index"] = "16",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_crystal_R_C",
			},
		},
	},
    ["particles/units/heroes/hero_crystalmaiden_persona/cm_persona_ambient_armor.vpcf"] = 
    {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = 
        {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_collar",
			},
		},
	},
}