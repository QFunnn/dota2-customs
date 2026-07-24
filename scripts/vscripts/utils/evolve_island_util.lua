--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function AddTinyBody(hUnit)


	if hUnit:GetUnitName() == "npc_dota_creature_tiny_01" or hUnit:GetUnitName() == "npc_dota_creature_player_tiny_01" then
		local hTorso = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_01/tiny_01_body.vmdl" })
		hTorso:FollowEntity(hUnit, true)
		local hLeft_arm = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_01/tiny_01_left_arm.vmdl" })
		hLeft_arm:FollowEntity(hUnit, true)
		local hRight_arm = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_01/tiny_01_right_arm.vmdl" })
		hRight_arm:FollowEntity(hUnit, true)
	end


	if hUnit:GetUnitName() == "npc_dota_creature_tiny_02" or hUnit:GetUnitName() == "npc_dota_creature_player_tiny_02" then
		local hTorso = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_02/tiny_02_body.vmdl" })
		hTorso:FollowEntity(hUnit, true)
		local hLeft_arm = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_02/tiny_02_left_arm.vmdl" })
		hLeft_arm:FollowEntity(hUnit, true)
		local hRight_arm = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_02/tiny_02_right_arm.vmdl" })
		hRight_arm:FollowEntity(hUnit, true)
	end

	if hUnit:GetUnitName() == "npc_dota_creature_tiny_03" or hUnit:GetUnitName() == "npc_dota_creature_player_tiny_03" then
		local hTorso = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_04/tiny_04_body.vmdl" })
		hTorso:FollowEntity(hUnit, true)
		local hLeft_arm = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_04/tiny_04_left_arm.vmdl" })
		hLeft_arm:FollowEntity(hUnit, true)
		local hRight_arm = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_04/tiny_04_right_arm.vmdl" })
		hRight_arm:FollowEntity(hUnit, true)
	end

	if hUnit:GetUnitName() == "npc_dota_creature_tiny_04" or hUnit:GetUnitName() == "npc_dota_creature_player_tiny_04" then
		local hTorso = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_04/tiny_04_body.vmdl" })
		hTorso:FollowEntity(hUnit, true)
		local hLeft_arm = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_04/tiny_04_left_arm.vmdl" })
		hLeft_arm:FollowEntity(hUnit, true)
		local hRight_arm = SpawnEntityFromTableSynchronous("prop_dynamic", { model = "models/heroes/tiny_04/tiny_04_right_arm.vmdl" })
		hRight_arm:FollowEntity(hUnit, true)
	end
end


--创建幻象
function CreateIllusion(hUnit, nDuration, nIncomeDamage, nOutDamage, vLocation, vModifiers, hAbility)

	if vLocation == nil then
		vLocation = hUnit:GetAbsOrigin() + RandomVector(RandomInt(50, 100))
	else
		vLocation = vLocation + RandomVector(RandomInt(50, 100))
	end

	local hIllusion = CreateUnitByName(hUnit:GetUnitName(), vLocation, true, hUnit, hUnit, hUnit:GetTeamNumber())

	FindClearSpaceForUnit(hIllusion, hIllusion:GetAbsOrigin(), true)

	hIllusion:SetBaseMaxHealth(hUnit:GetMaxHealth())
	hIllusion:SetMaxHealth(hUnit:GetMaxHealth())
	hIllusion:SetHealth(hUnit:GetHealth())
	hIllusion:SetMana(hUnit:GetMana())

	hIllusion:SetBaseAttackTime(hUnit:GetBaseAttackTime())
	hIllusion:SetBaseMoveSpeed(hUnit:GetIdealSpeed())

	hIllusion:SetOriginalModel(hUnit:GetModelName())
	hIllusion:SetModel(hUnit:GetModelName())
	hIllusion:SetModelScale(hUnit:GetModelScale())

	hIllusion:SetUnitName(hUnit:GetUnitName())

	if hUnit:IsRangedAttacker() then
		hIllusion:SetRangedProjectileName(hUnit:GetRangedProjectileName())
	end

	hIllusion:SetForwardVector(hUnit:GetForwardVector())
	hIllusion:AddNewModifier(hUnit, hAbility, "modifier_kill", { duration = nDuration })
	hIllusion:AddNewModifier(hUnit, hAbility, "modifier_illusion", { duration = nDuration, outgoing_damage = nOutDamage, incoming_damage = nIncomeDamage })
	hIllusion:SetControllableByPlayer(hUnit:GetMainControllingPlayer(), true)
	hIllusion:SetOwner(PlayerResource:GetSelectedHeroEntity(hUnit:GetMainControllingPlayer()))
	hIllusion:SetMaximumGoldBounty(0)
	hIllusion:SetMinimumGoldBounty(0)

	for i = 0, hUnit:GetAbilityCount() - 1 do
		local hAbility = hUnit:GetAbilityByIndex(i)
		if hAbility ~= nil then
			local nAbilityLevel = hAbility:GetLevel()
			local sAbilityName = hAbility:GetAbilityName()
			local hIllusionAbility = hIllusion:FindAbilityByName(sAbilityName)


			if hIllusionAbility then
				if hIllusionAbility:IsPassive() then
					hIllusionAbility:SetLevel(nAbilityLevel)
				else
					hIllusion:RemoveAbility(sAbilityName)
				end
			end
		end
	end

	if vModifiers then
		for _, sModifierName in pairs(vModifiers) do
			illusion:AddNewModifier(self, hAbility, sModifierName, {})
		end
	end

	hIllusion:MakeIllusion()
	FindClearSpaceForUnit(hIllusion, vLocation, false)

	return hIllusion
end