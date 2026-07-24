--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- DISABLED (perf hit) --
-- if you would ever want to filter / modify damage - reconsider, period
-- (rewrite ability, if needed)

function Filters:DamageFilter(event)
	local target = event.entindex_victim_const and EntIndexToHScript(event.entindex_victim_const)
	local attacker = event.entindex_attacker_const and EntIndexToHScript(event.entindex_attacker_const)
	local ability = event.entindex_inflictor_const and EntIndexToHScript(event.entindex_inflictor_const)

	if event.damage and target and not target:IsNull() and target:IsAlive() and attacker and not attacker:IsNull() and attacker:IsAlive() and attacker.GetPlayerOwnerID and attacker:GetPlayerOwnerID() then
		local attacker_id = attacker:GetPlayerOwnerID()

		if attacker_id >= 0 then
			if target.IsRealHero and target:IsRealHero() then
				EndGameStats:Add_HeroDamage(attacker_id, event.damage)
			end
		end
	end

	return true
end