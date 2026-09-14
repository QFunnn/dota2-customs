--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


function Events:OnGameRulesStateChange(event)
	local new_state = GameRules:State_Get()

	EventDriver:Dispatch("Events:state_changed", {
		state = new_state,
	})
end