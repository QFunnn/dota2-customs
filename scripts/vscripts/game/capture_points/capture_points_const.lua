--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


CAPTURE_POINT_PATH = "particles/capture_point_ring/"
INVISIBLE_MODEL = "models/development/invisiblebox.vmdl"
CAPTURE_POINT_RADIUS = TEAMS_LAYOUTS[GetMapName()]["capture_point_radius"]
TIME_FOR_CAPTURE_POINT = TEAMS_LAYOUTS[GetMapName()]["capture_point_time"]
BASE_COLOR = Vector(220,220,220)
INTERVAL_THINK = 0
INIT_POSITION_FOR_ITEM = Vector(0,0,0)

TEAMS_COLORS = {
	[DOTA_TEAM_GOODGUYS] = Vector(61, 210, 150),
	[DOTA_TEAM_BADGUYS]  = Vector(243, 201, 9),
	[DOTA_TEAM_CUSTOM_1] = Vector(197, 77, 168),
	[DOTA_TEAM_CUSTOM_2] = Vector(255, 108, 0),
	[DOTA_TEAM_CUSTOM_3] = Vector(52, 85, 255),
	[DOTA_TEAM_CUSTOM_4] = Vector(101, 212, 19),
	[DOTA_TEAM_CUSTOM_5] = Vector(129, 83, 54),
	[DOTA_TEAM_CUSTOM_6] = Vector(27, 192, 216),
	[DOTA_TEAM_CUSTOM_7] = Vector(199, 228, 13),
	[DOTA_TEAM_CUSTOM_8] = Vector(140, 42, 244),
	[DOTA_TEAM_NEUTRALS] = BASE_COLOR,
}