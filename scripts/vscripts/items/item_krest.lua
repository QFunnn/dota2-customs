--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function last_chance(keys)
	local wws = keys.caster
	if not wws:IsRealHero() then
		return
	end

	if wws:HasModifier("modifier_guild_event") then
		return
	end

	local new_charges = keys.ability:GetCurrentCharges() - 1

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
			if PlayerResource:HasSelectedHero(nPlayerID) then
				local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				if not hero:HasModifier("modifier_guild_event") then
					hero.isTeleporting = true
					if not hero:IsAlive() then
						local point = wws:GetAbsOrigin()
						hero:RespawnHero(false, false)
						hero:SetAbsOrigin(point)
						FindClearSpaceForUnit(hero, point, true)
						hero:Stop()
					end
					hero:SetHealth(hero:GetMaxHealth())
					hero:SetMana(hero:GetMaxMana())
					hero:EmitSound("Hero_Omniknight.GuardianAngel.cast")
					hero:AddNewModifier(hero, nil, "modifier_omninight_guardian_angel", { duration = 2.5 })
					hero.isTeleporting = false
				end
			end
		end
	end

	if keys.ability:GetCurrentCharges() > 1 then
		keys.ability:SetCurrentCharges(keys.ability:GetCurrentCharges() - 1)
	else
		UTIL_Remove(keys.ability)
	end
end