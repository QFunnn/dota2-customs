--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local modifiers = {
	"modifier_invulnerable_custom",
	"modifier_event_proxy",
	"modifier_hidden_caster_dummy",
}

for _, modifier in pairs(modifiers) do
	LinkLuaModifier(modifier, "modifiers/" .. modifier, LUA_MODIFIER_MOTION_NONE)
end