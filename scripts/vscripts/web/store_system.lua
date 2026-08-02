--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


if store_system == nil then
	_G.store_system = class({})
end

RequireFiles({
	"web/store_info",
	"web/events_system",
})

function store_system:Init()
	store_system.PauseCount = {}
	store_system.LeavePauseCount = {}
	store_system.PauseCooldown = 0
	store_system.PauseOwner = nil
	store_system.PlayerPauseCooldown = {}
	store_system.PlayerLeavePauseCooldown = {}
end