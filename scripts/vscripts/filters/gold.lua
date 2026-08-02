--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


-- NOTE: this filter is disabled
function Filters:ModifyGoldFilter(event)
	local player_id = event.player_id_const
	local hero = (player_id and PlayerResource:GetSelectedHeroEntity(player_id)) or nil

	return true
end