--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


AF_POINTS_INIT = 450
AF_POINTS_MIN = 0
AF_POINTS_MAX = 1000
AF_POINTS_ON_KILL = -100
AF_POINTS_ON_ASSIST = -100
AF_POINTS_ON_BUILDING_DAMAGE = -100
AF_POINTS_ON_DEATH_CONST = 50

AF_TIME_FACTOR_INIT = 120
AF_TIME_FACTOR_DELAY = 60
AF_TIME_FACTOR_DRAIN = -2
AF_TIME_FACTOR_MIN = 0

AF_FEEDER_RESPAWN_TIME_MULTIPLIER_BY_POINTS = 0.1 -- Current points * coef. Example = 920 * 0.1 = 92sec
AF_FEEDER_ALIVE_DRAIN = -1
AF_FEEDER_POINT_TO_FREE = 600

AF_FORBIDDEN_ITEMS_TO_BUY = {
	item_smoke_of_deceit = true,
	item_ward_observer = true,
	item_ward_sentry = true,
}

AF_ALLY_FOUNTAIN_SAFE_ZONE = 3000
AF_BUILDING_DAMAGE_THRESHOLD = 1000

AF_ALLY_DEATH_IMPACT_MIN_DEATHS_THRESHOLD = 15
AF_ALLY_DEATH_IMPACT_CONST = 10