--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_precache_dummy = class({})

function item_precache_dummy:Precache(context)
	local precache_list = table.remove(_G.PRECACHE_RESOURCE_LISTS, 1)

	if not precache_list then return end

	for resource, resource_type in pairs(precache_list) do
		print("[Precache Dummy] precaching", resource_type, resource)
		PrecacheResource(resource_type, resource, context)
	end
end