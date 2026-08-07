--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "entity_script/collision_trigger"
local b = {}
local c = require("lib.dota_ts_adapter")
local d = c.registerEntityFunction
d(nil, "CollisionTrigger_OnStartTouch", function(e, f)
	local g = f.activator
	local h = thisEntity and thisEntity:GetName() or ""
	if g and h ~= "" then
		Event:Fire("collision_trigger", { activator = g, name = h, type = 1 })
	end
end)
d(nil, "CollisionTrigger_OnEndTouch", function(e, f)
	local g = f.activator
	local h = thisEntity and thisEntity:GetName() or ""
	if g and h ~= "" then
		Event:Fire("collision_trigger", { activator = g, name = h, type = 0 })
	end
end)
return b