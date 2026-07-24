--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_pudge/pudge_ambient_flies.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/units/heroes/hero_pudge/pudge_ambient_chain.vpcf"] = {
		["attach_type"] = "absorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_chain_lf",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_arm_chain_lf",
			},
		},
	},
	["particles/units/heroes/hero_pudge/pudge_ambient_chain_right.vpcf"] = {
		["attach_type"] = "absorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_chain_rt",
			},
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_arm_chain_rt",
			},
		},
	},
	["particles/econ/items/pudge/pudge_ftp_crow/pudge_ftp_back_crow.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_shoulder",
			},
		},
	},
	["particles/econ/items/pudge/pudge_insatiable_bonesaw/pudge_insatiable_bonesaw.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon_L",
			},
		},
	},
	["particles/econ/items/pudge/pudge_scorching_talon/pudge_scorching_talon_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "1",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_hook",
			},
		},
	},
	["particles/econ/items/pudge/pudge_bloodlust_fork/pudge_bloodlust_fork.vpcf"] = {
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
	["particles/econ/items/pudge/pudge_trapper_beam_chain/pudge_nx_cleaver_drip.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_particle",
			},
		},
	},
	["particles/econ/items/pudge/pudge_demon_queller/pudge_demon_queller_head_ambient.vpcf"] = {
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
				["attachment"] = "attach_l_feather",
			},
			{
				["control_point_index"] = "2",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_r_feather",
			},
		},
	},
	["particles/econ/items/pudge/pudge_demon_queller/pudge_demon_queller_ambient.vpcf"] = {
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
				["attachment"] = "attach_fan",
			},
		},
	},
	["particles/econ/items/pudge/pudge_ti6_immortal/pudge_ti6_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_harpoon_base",
			},
		},
	},
	["particles/econ/items/pudge/pudge_ti6_immortal/pudge_ti6_witness_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_harpoon_base",
			},
		},
	},
	["particles/econ/items/pudge/pudge_ti6_immortal_gold/pudge_ti6_ambient_gold.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_harpoon_base",
			},
		},
	},
}