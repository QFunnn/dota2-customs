--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- This event exists to fix a case where taking specific multiplication talents
-- Does not apply its bonus to the stacks of upgrades it should affect
-- Until those upgrades are taken again.
function Events:OnAbilityLevelled(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not IsValidEntity(hero) then return end

	local ability_name = event.abilityname
	if not ability_name then return end

	if UpgradesUtilities:IsTalentRegisteredForRefresh(ability_name) then

		local ability_upgrades_modifier = hero:FindModifierByName("modifier_ability_upgrades_controller")

		if ability_upgrades_modifier and not ability_upgrades_modifier:IsNull() then
			ability_upgrades_modifier:ForceRefresh()
		end
	end
end