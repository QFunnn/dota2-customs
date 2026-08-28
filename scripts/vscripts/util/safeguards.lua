--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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