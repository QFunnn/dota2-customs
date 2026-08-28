--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function Events:OnEntityKilled(event)
	local killed = EntIndexToHScript(event.entindex_killed)
	local killer = EntIndexToHScript(event.entindex_attacker)
	local inflictor

	if event.entindex_inflictor then
		inflictor = EntIndexToHScript(event.entindex_inflictor)
	end

	EventDriver:Dispatch("Events:entity_killed", {
		killed = killed,
		killer = killer,
		inflictor = inflictor,
	})
end