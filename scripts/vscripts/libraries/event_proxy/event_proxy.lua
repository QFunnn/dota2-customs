--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


EventProxy = EventProxy or {}

function EventProxy:Init()
	if not EventProxy.dummy then
		local dummy = CreateUnitByName("npc_dota_thinker", Vector(0, 0, 0), false, nil, nil, DOTA_TEAM_NEUTRALS)
		local m = dummy:AddNewModifier(dummy, nil, "modifier_event_proxy", nil)

		dummy.proxy_modifier = m

		print("[EventProxy] created dummy and added modifier:", dummy, m)

		EventProxy.dummy = dummy
	end
end