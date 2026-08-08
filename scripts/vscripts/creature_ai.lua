--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


function Spawn(entityKeyValues)
	if not IsServer() then
		return
	end
	if thisEntity == nil then
		return
	end
	if thisEntity:GetTeam() ~= DOTA_TEAM_NEUTRALS then
		return
	end
	if not thisEntity:IsAlive() then
		return
	end

	for i = 0, thisEntity:GetAbilityCount() - 1 do
		local hAbility = thisEntity:GetAbilityByIndex(i)
		if hAbility and hAbility.IsPassive then
			if not hAbility:IsPassive() then
				hAbility:StartCooldown(RandomFloat(0.5, 1.5))
				if hAbility:GetName() == "golem_anti_blademail" then
					if thisEntity:GetUnitName() == "npc_dota_mud_golem" then
						hAbility:SetLevel(1)
					end
					if thisEntity:GetUnitName() == "npc_dota_rock_golem" then
						hAbility:SetLevel(2)
					end
					if thisEntity:GetUnitName() == "npc_dota_granite_golem" then
						hAbility:SetLevel(3)
					end
				end
			end
		end
	end

	Creeps:AddAIToCreep(thisEntity)
end