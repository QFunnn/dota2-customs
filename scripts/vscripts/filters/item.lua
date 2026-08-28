--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function Filters:ItemAddedToInventoryFilter(event)
	if not event.item_entindex_const then
		return true
	end
	if not event.inventory_parent_entindex_const then
		return true
	end

	local inventory_parent = EntIndexToHScript(event.inventory_parent_entindex_const)
	if not IsValidEntity(inventory_parent) or not inventory_parent.GetPlayerOwnerID then
		return true
	end

	local player_id = inventory_parent:GetPlayerOwnerID()
	if player_id and Kicks:IsPlayerKicked(player_id) then
		return false
	end

	local punishment_level = WebPlayer:GetPunishmentLevel(player_id)
	if punishment_level == 10 then
		return false
	end

	return true
end