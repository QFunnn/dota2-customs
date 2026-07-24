--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["particles/econ/items/queen_of_pain/qop_wicked_wings/qop_wicked_wings_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
	["particles/econ/items/queen_of_pain/qop_searing_pain/qop_searing_pain.vpcf"] = {
		["attach_type"] = "point_follow",
		["attach_entity"] = "self",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "wing_fx",
			},
		},
	},
	["particles/econ/items/queen_of_pain/qop_bloody_raven_wings/qop_bloody_raven_ambient.vpcf"] = {
		["attach_type"] = "absorigin_follow",
		["attach_entity"] = "parent",
	},
    ["particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_whip_ambient.vpcf"] = {
		["attach_type"] = "point_follow",
		["attach_entity"] = "parent",
        ["mega_attach"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_whip_end",
			},
		},
	},
    ["particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_whip_ambient_v2.vpcf"] = {
		["attach_type"] = "point_follow",
		["attach_entity"] = "parent",
        ["mega_attach"] = "parent",
		["control_points"] = {
			{
				["control_point_index"] = "0",
				["attach_type"] = "point_follow",
				["attachment"] = "attach_whip_end",
			},
		},
	},
}