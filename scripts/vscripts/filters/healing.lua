--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local HEALING_EXCLUDED_ABILITIES = {
	meepo_ransack = true,
	vengefulspirit_command_aura = true,
	bane_brain_sap = true,
	terrorblade_sunder = true,
}

function Filters:HealingFilter(event)
	local target = event.entindex_target_const ~= 0 and EntIndexToHScript(event.entindex_target_const) or nil
	local inflictor = (event.entindex_inflictor_const and event.entindex_inflictor_const ~= 0)and EntIndexToHScript(event.entindex_inflictor_const) or nil
	local healer = (event.entindex_healer_const and event.entindex_healer_const ~= 0) and EntIndexToHScript(event.entindex_healer_const) or nil

	local heal_value = event.heal

	if heal_value <= 0 then return true end
	if not IsValidEntity(healer) or not IsValidEntity(target) then return true end
	if target == healer then return true end

	local is_valid_inflictor = IsValidEntity(inflictor) and inflictor.GetAbilityName

	if is_valid_inflictor and HEALING_EXCLUDED_ABILITIES[inflictor:GetAbilityName()] then return true end

	-- DebugMessage(healer:GetUnitName(), "healed", target:GetUnitName(), "for", heal_value, "with", is_valid_inflictor and inflictor:GetAbilityName() or "<nil>")
	EndGameStats:Add_Heal(healer:GetPlayerOwnerID(), heal_value)

	return true
end