--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function Events:OnItemPickUp(event)
	local item = EntIndexToHScript(event.ItemEntityIndex)
	local item_name = event.itemname
	local owner_entindex = event.HeroEntityIndex or event.UnitEntityIndex or nil
	local owner = (owner_entindex and EntIndexToHScript(owner_entindex)) or nil
end