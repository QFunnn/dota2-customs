--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


-- shortcut for PlayerResource check
function IsValidPlayerId(player_id)
	return player_id and PlayerResource:IsValidPlayerId(player_id)
end

-- shortcut entity check
function IsValidEntity(entity)
	return entity and not entity:IsNull()
end