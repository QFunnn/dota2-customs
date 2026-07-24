--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/econ/items/axe/axe_weapon_bloodchaser/axe_drag_sparks.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/econ/items/axe/axe_weapon_wyvernguard_edge/axe_weapon_eyes_wyvernguard_edge.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_axe_head",
			},
		},
	},
	["particles/econ/items/axe/axe_weapon_practos/axe_practos_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon",
			},
		},
	},
	["particles/econ/items/axe/axe_helm_shoutmask/axe_shout_mask_ambient.vpcf"] = {
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
		},
	},
	["particles/econ/items/axe/axe_armor_molten_claw/axe_molten_claw_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/econ/items/axe/axe_weapon_dragon_axe/axe_dragon_axe.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_weapon",
			},
		},
	},
	["particles/econ/items/pets/pet_frondillo/almond_ambient_gold.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_almond_fx",
			},
		},
	},
	["particles/econ/items/axe/axe_cinder/axe_cinder_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/econ/items/axe/axe_cinder/axe_cinder_ambient_alt.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "3",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_hitloc",
			},
		},
	},
}