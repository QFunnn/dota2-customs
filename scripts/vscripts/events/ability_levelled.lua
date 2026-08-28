--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


-- This event exists to fix a case where taking specific multiplication talents
-- Does not apply its bonus to the stacks of upgrades it should affect
-- Until those upgrades are taken again.
function Events:OnAbilityLevelled(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not IsValidEntity(hero) then
		return
	end

	local ability_name = event.abilityname
	if not ability_name then
		return
	end
end