--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


if HeroBuilder == nil then
	HeroBuilder = class({})
end

function HeroBuilder:Init()
	HeroBuilder.heroAbilityPool = {}
	HeroBuilder.abilityHeroMap = {}
	HeroBuilder.linkedAbilities = {}
	HeroBuilder.linkedAbilitiesLevel = {}
	HeroBuilder.subsidiaryAbilitiesList = {}
	HeroBuilder.pendingPrecache = {}
	HeroBuilder.precached = {}
	HeroBuilder.precachedHeroes = {}
	CustomGameEventManager:RegisterListener("AbilitySelected", Dynamic_Wrap(self, "AbilitySelected"))
	CustomGameEventManager:RegisterListener("GetSpeelsForSwapPanel", Dynamic_Wrap(self, "GetSpeelsForSwapPanel"))
	CustomGameEventManager:RegisterListener("spells_menu_swap_player_spells", Dynamic_Wrap(self, "SwapSpells"))
	CustomGameEventManager:RegisterListener("RerollAbility", Dynamic_Wrap(self, "RerollRemove"))

	local allAbilityNames = {}
	local abilityListKV = LoadKeyValues("scripts/npc/npc_abilities_list.txt")
	for szHeroName, data in pairs(abilityListKV) do
		HeroBuilder.heroAbilityPool["npc_dota_hero_" .. szHeroName] = {}
		local netTableData = {}
		if data and type(data) == "table" then
			for key, value in pairs(data) do
				if type(value) ~= "table" then
					table.insert(allAbilityNames, value)
					table.insert(HeroBuilder.heroAbilityPool["npc_dota_hero_" .. szHeroName], value)
					HeroBuilder.abilityHeroMap[value] = szHeroName
					table.insert(netTableData, value)
				else
					HeroBuilder.linkedAbilities[key] = {}
					for k, v in pairs(value) do
						table.insert(HeroBuilder.linkedAbilities[key], k)
						table.insert(HeroBuilder.subsidiaryAbilitiesList, k)
						HeroBuilder.linkedAbilitiesLevel[k] = tonumber(v)
					end
				end
			end
		end
	end
	HeroBuilder.allAbilityNames = allAbilityNames
	HeroBuilder.scepterOwners = {}
	_G.hero_skills = {}
	_G.hero_pool = {}
end

---------------------------------------------------------- BUILD HERO -----------------------

function HeroBuilder:InitPlayerHero(hHero)
	local pid = hHero:GetPlayerOwnerID()
	hHero.bInited = true
	hHero.count = 4
	_G.hero_skills[pid] = {}
	_G.hero_pool[pid] = _G.All_ABILITY

	if not table.contains(HeroBuilder.precachedHeroes, hHero:GetUnitName()) then
		table.insert(HeroBuilder.precachedHeroes, hHero:GetUnitName())
	end
	for i = 0, 8 do
		local ability = hHero:GetAbilityByIndex(i)
		if ability and not ability:IsNull() then
			local ability_name = ability:GetAbilityName()
			if
				not string.find(ability_name, "special_bonus")
				and not string.find(ability_name, "special_bonus_dado_tal")
				and not string.find(ability_name, "ability_capture_lua")
				and not string.find(ability_name, "new_year_snowball")
			then
				hHero:RemoveAbility(ability_name)
			end
		end
	end
	for i = 0, 5 do
		local hAbility = hHero:AddAbility("empty_" .. i)
		hAbility.nPlaceholder = i + 1
	end
	HeroBuilder:ShowAbilityForSelect(hHero, pid)
end

function HeroBuilder:ShowAbilityForSelect(hHero, pid)
	local pool = table.shuffle(_G.hero_pool[pid])
	if hHero.count > 0 then
		hHero.count = hHero.count - 1
		local t = {}
		for i = 1, 6 do
			local skill = table.remove(pool, 1)
			table.insert(t, skill)
		end
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "ShowSelectSkillsEvent", t)
	end
end

-----------------------------------------------------------------------ADD ABILITY------------------------------------------------------

function HeroBuilder:AbilitySelected(t)
	local sAbilityName = t.skill_name
	local nPlayerID = t.PlayerID
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	if not hHero then
		print("hHero is null in AbilitySelected")
		return
	end
	HeroBuilder:AddAbility(nPlayerID, sAbilityName, nil, nil)
end

function HeroBuilder:AddAbility(nPlayerID, sAbilityName, nLevel, flCoolDown)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	if hHero then
		PrecacheItemByNameAsync(sAbilityName, function()
			if hHero and not hHero:IsNull() then
				local bHasInvulnerable = false

				if hHero:HasModifier("modifier_hero_refreshing") then
					bHasInvulnerable = true
					hHero:RemoveModifierByName("modifier_hero_refreshing")
				end

				local hNewAbility = hHero:AddAbility(sAbilityName)

				table.remove_item(_G.hero_pool[nPlayerID], sAbilityName)
				table.insert(_G.hero_skills[nPlayerID], sAbilityName)

				if bHasInvulnerable then
					hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
				end

				if hNewAbility and (not hNewAbility:IsNull()) then
					hNewAbility:ClearInnateModifiers()
					hNewAbility:MarkAbilityButtonDirty()
					hHero:CalculateStatBonus(false)

					if flCoolDown and flCoolDown > 0 then
						hNewAbility:StartCooldown(flCoolDown)
					end

					if nLevel and nLevel > 0 then
						hNewAbility:SetLevel(nLevel)
					end

					Timers:CreateTimer(0.1, function()
						if not hNewAbility or hNewAbility:IsNull() then
							print("hNewAbility is null")
							return
						end

						if hNewAbility.sRemovalTimer then
							print("hNewAbility in RemovalTimer")
							return
						end

						HeroBuilder:SetAbilityToSlot(hHero, hNewAbility)
						HeroBuilder:AddLinkedAbilities(hHero, sAbilityName, nLevel)
						hHero:FindHotKeyForAbility(hNewAbility:GetAbilityName())
					end)

					local sHeroOwnerName = HeroBuilder.abilityHeroMap[sAbilityName]
					if
						sHeroOwnerName
						and not table.contains(HeroBuilder.pendingPrecache, sHeroOwnerName)
						and not HeroBuilder.precached[sHeroOwnerName]
					then
						table.insert(HeroBuilder.pendingPrecache, sHeroOwnerName)
					end
				end
			end
			-- CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(nPlayerID),"RegisterHoverableAbility",{ability_name=sAbilityName})
			HeroBuilder:ShowAbilityForSelect(hHero, nPlayerID)
		end)
	end
end

function HeroBuilder:GetSpeelsForSwapPanel(t)
	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(t.PlayerID),
		"GetPlayerSwapPanel",
		{ player_abilities = HeroBuilder:GetPlayerSpells(t.PlayerID) }
	)
end

function HeroBuilder:GetPlayerSpells(nPlayerID)
	local player = PlayerResource:GetPlayer(nPlayerID)
	if player and PlayerResource:HasSelectedHero(nPlayerID) then
		local hero = player:GetAssignedHero()
		local playerAbilities = {}
		for ability_id = 0, hero:GetAbilityCount() - 1 do
			local ability = hero:GetAbilityByIndex(ability_id)
			if
				ability
				and not ability:IsAttributeBonus()
				and not ability:IsHidden()
				and not string.find(ability:GetAbilityName(), "ability_capture_lua")
				and not string.find(ability:GetAbilityName(), "new_year_snowball")
			then
				local abilityName = ability:GetAbilityName()
				table.insert(playerAbilities, abilityName)
			end
		end
		return playerAbilities
	end
	return {}
end

function HeroBuilder:SwapSpells(t)
	local hero = PlayerResource:GetSelectedHeroEntity(t.PlayerID)
	hero:SwapAbilities(t.first_ability_name, t.second_ability_name, true, true)
end

function HeroBuilder:RerollRemove(t)
	HeroBuilder:RemoveAbility(t.PlayerID, t.AbilityName)
end

function HeroBuilder:RemoveAbility(nPlayerID, sAbilityName)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	local hAbility = hHero:FindAbilityByName(sAbilityName)

	if hAbility then
		local nAbilityLevel = hAbility:GetLevel()
		local nAbilityPoints = hHero:GetAbilityPoints()
		nAbilityPoints = nAbilityPoints + nAbilityLevel
		hHero:SetAbilityPoints(nAbilityPoints)
	end

	if hHero and hAbility then
		if HeroBuilder.linkedAbilities[sAbilityName] then
			for _, sLinkedAbilityName in ipairs(HeroBuilder.linkedAbilities[sAbilityName]) do
				local hLinkedAbility = hHero:FindAbilityByName(sLinkedAbilityName)
				local bStillUsing = false
				if hLinkedAbility and not bStillUsing then
					if hLinkedAbility:IsHidden() then
						hHero:RemoveAbilityForEmpty(sLinkedAbilityName)
					else
						hHero:RemoveAbilityWithRestructure(sLinkedAbilityName)
					end
				end
			end
		end

		hHero:RemoveAbilityForEmpty(sAbilityName)
		HeroBuilder:RemoveAbilityClean(hHero, sAbilityName)
		table.remove_item(_G.hero_skills[nPlayerID], sAbilityName)
		hHero.count = 1

		HeroBuilder:ShowAbilityForSelect(hHero, nPlayerID)
	end
	return true
end

function HeroBuilder:RemoveAbilityClean(hHero, sAbilityName)
	if sAbilityName == "broodmother_spin_web" then
		HeroBuilder:CleanWeb(hHero)
	end
	if sAbilityName == "witch_doctor_death_ward" then
		HeroBuilder:CleanDeathWard(hHero)
	end
	if sAbilityName == "visage_summon_familiars" then
		HeroBuilder:CleanFamiliar(hHero)
	end
end

function HeroBuilder:CleanWeb(hHero)
	local vWebs = Entities:FindAllByName("npc_dota_broodmother_web")
	for _, hWeb in pairs(vWebs) do
		if hWeb:GetOwner() == hHero then
			UTIL_Remove(hWeb)
		end
	end
end

function HeroBuilder:CleanDeathWard(hHero)
	local vWards = Entities:FindAllByName("npc_dota_witch_doctor_death_ward")
	for _, vWard in pairs(vWards) do
		if vWard:GetOwner() == hHero then
			UTIL_Remove(vWard)
		end
	end
end

function HeroBuilder:CleanFamiliar(hHero)
	local vFamiliars = Entities:FindAllByName("npc_dota_visage_familiar")
	for _, hFamiliar in pairs(vFamiliars) do
		if hFamiliar:GetOwner() == hHero then
			hFamiliar:ForceKill(false)
		end
	end
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HeroBuilder:SetAbilityToSlot(hHero, hAbility)
	if not hHero or hHero:IsNull() then
		return
	end
	if not hAbility or hAbility:IsNull() then
		return
	end

	for i = 0, 5 do
		local hSlotAbility = hHero:GetAbilityByIndex(i)

		if not hSlotAbility or hSlotAbility:IsNull() then
			print("[Error] Can't find hSlotAbility " .. i)
		end

		if hSlotAbility and hSlotAbility.nPlaceholder then
			hHero:SwapAbilities(hSlotAbility:GetAbilityName(), hAbility:GetAbilityName(), false, true)
			hAbility:SetAbilityIndex(hSlotAbility.nPlaceholder - 1)
			return
		end
	end
end

function HeroBuilder:AddLinkedAbilities(hHero, sAbilityName, nLevel)
	if HeroBuilder.linkedAbilities[sAbilityName] then
		for _, szLinkedAbilityName in ipairs(HeroBuilder.linkedAbilities[sAbilityName]) do
			if not hHero:HasAbility(szLinkedAbilityName) then
				local hNewLinkedAbility = hHero:AddAbility(szLinkedAbilityName)
				if
					szLinkedAbilityName == "lone_druid_true_form_druid"
					or szLinkedAbilityName == "lone_druid_true_form_battle_cry"
				then
					hNewLinkedAbility:SetHidden(false)
				end
				if HeroBuilder.linkedAbilitiesLevel[szLinkedAbilityName] > 0 then
					hNewLinkedAbility:SetLevel(HeroBuilder.linkedAbilitiesLevel[szLinkedAbilityName])
				end
				if nLevel and nLevel > 0 then
					hNewLinkedAbility:SetLevel(nLevel)
				end

				if hNewLinkedAbility and not hNewLinkedAbility:IsNull() then
					hNewLinkedAbility:MarkAbilityButtonDirty()
				end

				Timers:CreateTimer(0.1, function()
					if hNewLinkedAbility and not hNewLinkedAbility:IsNull() and not hNewLinkedAbility:IsHidden() then
						HeroBuilder:SetAbilityToSlot(hHero, hNewLinkedAbility)
					end
				end)
			end
		end
	end
end

function HeroBuilder:ProcessScepterOwners()
	for _, hHero in pairs(HeroBuilder.scepterOwners) do
		if hHero and not hHero:IsNull() and not hHero:HasScepter() then
			HeroBuilder:OnScepterLost(hHero)
		end
	end
end

function HeroBuilder:OnScepterLost(hHero)
	if not hHero or not hHero:IsMainHero() then
		return
	end
	HeroBuilder:UnregisterScepterOwner(hHero)

	for i = 0, hHero:GetAbilityCount() - 1 do
		local hAbility = hHero:GetAbilityByIndex(i)
		if hAbility and hAbility.bScepterAbility then
			local sAbilityName = hAbility:GetAbilityName()
			hHero:RemoveAbilityWithRestructure(sAbilityName)
		end
	end

	if hHero:HasModifier("modifier_bloodseeker_blood_mist") then
		hHero:RemoveModifierByName("modifier_bloodseeker_blood_mist")
	end
	print("Hero:scepter_lost")
end

function HeroBuilder:UnregisterScepterOwner(hHero)
	if not hHero or not hHero:IsMainHero() then
		return
	end
	if hHero:GetEntityIndex() and HeroBuilder.scepterOwners[hHero:GetEntityIndex()] then
		HeroBuilder.scepterOwners[hHero:GetEntityIndex()] = nil
	end
end

function HeroBuilder:RegisterScepterOwner(hHero)
	if not hHero or not hHero:IsMainHero() then
		return
	end
	HeroBuilder.scepterOwners[hHero:GetEntityIndex()] = hHero
end