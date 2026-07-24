--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/units/heroes/hero_skywrath_mage/skywrath_mage_staff_ambient.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_staff",
			},
		},
	},
	["particles/units/heroes/hero_skywrath_mage/skywrath_mage_staff_ambient_generic.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_staff_generic",
			},
		},
	},
	["particles/econ/items/skywrath_mage/skywrath_mage_weapon_empyrean/skywrath_mage_staff_ambient_empyrean.vpcf"] = {
		["attach_type"] = "customorigin",
		["attach_entity"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_staff_generic",
			},
		},
	},
	["particles/econ/items/skywrath_mage/manticore/manticore_staff.vpcf"] = {
		["attach_type"] = "customorigin_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_fx_staff",
			},
		},
	},
	["particles/econ/items/skywrath_mage/manticore/wings_of_the_manticore_ambientfx.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/econ/items/skywrath_mage/hero_skywrath_dpits3_helm/skywrath_dpits3_helm.vpcf"] = {
		["attach_type"] = "customorigin_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "head_fx",
			},
		},
	},
}