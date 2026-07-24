--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Illusion == nil then Illusion = class({}) end

function Illusion:Init()
	-- ListenToGameEvent("npc_spawned", Dynamic_Wrap(Illusion, "OnNPCSpawned"), self)
	Illusion.abilityException = {}
	Illusion.abilityException["monkey_king_wukongs_command"] = true
	--Illusion.abilityException["arc_warden_tempest_double_lua"] = true

	Illusion.particleException = {}
	Illusion.particleException["league_dog_ring"] = true
	Illusion.particleException["galaxy_core"] = true
	Illusion.particleException["blood_dance"] = true
	Illusion.particleException["legion_wings"] = true
	Illusion.particleException["legion_wings_vip"] = true
	Illusion.particleException["legion_wings_pink"] = true
	Illusion.particleException["slumber"] = true
	Illusion.particleException["golden_fish"] = true
	Illusion.particleException["nightstalker_gold"] = true
	Illusion.particleException["nightstalker_black"] = true

	Illusion.juxtaposeException = {}
	Illusion.juxtaposeException["drow_ranger_marksmanship_lua"] = true
	Illusion.juxtaposeException["medusa_split_shot"] = true
	Illusion.juxtaposeException["luna_moon_glaive"] = true
end


function Illusion:InitIllusion(hIllusion, hCaster)

	if not hIllusion or hIllusion:IsNull() then return end

	local hIllustionModifier = hIllusion:FindModifierByName("modifier_illusion")
	if not hIllustionModifier then return end

	if not hIllusion:IsHero() then return end

	local hOriginalHero = hCaster--hIllustionModifier:GetCaster()
	if not hOriginalHero then return end

	hIllusion:SetAbilityPoints(0)

	for i = 0, hIllusion:GetAbilityCount() - 1 do
		local hAbility = hIllusion:GetAbilityByIndex(i)
		if hAbility and not string.find(hAbility:GetAbilityName(), "special_bonus") then
			local sPassiveBuffName = hAbility:GetIntrinsicModifierName()
			hIllusion:RemoveAbility(hAbility:GetAbilityName())
			hIllusion:RemoveModifierByName(sPassiveBuffName or "")
		end
	end

	for i = 0, hOriginalHero:GetAbilityCount() - 1 do
		local hAbility = hOriginalHero:GetAbilityByIndex(i)
		if hAbility ~= nil then
			local AbilityName = hAbility:GetAbilityName()
			if string.find(AbilityName, "special_bonus") then
				if hAbility:GetLevel() >= 1 then
					local hIllusionAbility = hIllusion:FindAbilityByName(AbilityName)
					hIllusion:SetAbilityPoints(1)
					hIllusion:UpgradeAbility(hIllusionAbility)
				end
			end
		end
	end

	for i = 0, hOriginalHero:GetAbilityCount() - 1 do
		local hAbility = hOriginalHero:GetAbilityByIndex(i)
		if hAbility ~= nil then
			local AbilityName = hAbility:GetAbilityName()
			if (not string.find(AbilityName, "special_bonus")) then
				local hIllusionAbility = hIllusion:AddAbility(AbilityName)
				if IsValid(hIllusionAbility) then
					local sPassiveBuffName = hIllusionAbility:GetIntrinsicModifierName()
					hIllusion:RemoveModifierByName(sPassiveBuffName or "")
					hIllusionAbility:SetLevel(hAbility:GetLevel())
					local kv = hAbility:GetAbilityKeyValues()
					if IsKvFlagEnabled(kv.IsGrantedByScepter) and hOriginalHero:HasScepter() then
						hIllusionAbility:SetHidden(false)
					end
					if IsKvFlagEnabled(kv.IsGrantedByShard) and hOriginalHero:HasShard() and AbilityName ~= "crystal_maiden_freezing_field_stop" then
						hIllusionAbility:SetHidden(false)
					end
					if sPassiveBuffName and sPassiveBuffName ~= "" then
						local hbuff = hIllusion:FindModifierByName(sPassiveBuffName)
						if hbuff then
							if hbuff.AllowIllusionDuplicate and (not hbuff:AllowIllusionDuplicate()) then
								hIllusion:RemoveModifierByName(sPassiveBuffName or "")
							end
						end
					end
				end
			end
		end
	end
	Timers:CreateTimer(FrameTime(), function()
		if IsValid(hIllusion) then
			hIllusion:RemoveModifierByName("modifier_lua")
		end
	end)

	if hOriginalHero:HasModifier("modifier_item_ultimate_scepter_consumed") then
		if not hIllusion:HasModifier("modifier_item_ultimate_scepter_consumed") then
			-- hIllusion:AddItemByName("item_ultimate_scepter_2")
			hIllusion:AddNewModifier(hOriginalHero, nil, "modifier_item_ultimate_scepter_consumed", {})
		end
	end
	if hOriginalHero:HasModifier("modifier_item_aghanims_shard") then
		if not hIllusion:HasModifier("modifier_item_aghanims_shard") then
			-- hIllusion:AddItemByName("item_aghanims_shard")
			hIllusion:AddNewModifier(hOriginalHero, nil, "modifier_item_aghanims_shard", {})
		end
	end

	if not hIllusion:IsIllusion() then
		for index = 0, 16 do
			local hClone_item = hIllusion:GetItemInSlot(index)
			if hClone_item then
				UTIL_Remove(hClone_item)
			end
		end
		local neutralItem = hOriginalHero:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
		if neutralItem ~= nil and neutralItem:GetAbilityName() ~= "item_philosophers_stone" and not IsKvFlagDisabled(neutralItem:GetAbilityKeyValues().IsTempestDoubleClonable) then
			local hItem = hIllusion:AddItemByName(neutralItem:GetAbilityName())
			if hItem then
				hItem:SetCombineLocked(true)
			end
		end
		for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
			local item = hOriginalHero:GetItemInSlot(i)
			local item_name = ""
			if item ~= nil then
				item_name = item:GetAbilityName()
				local clonable = not IsKvFlagDisabled(item:GetAbilityKeyValues().IsTempestDoubleClonable) and (item_name ~= "item_philosophers_stone")
				if clonable then
					local new_item = hIllusion:AddItemByName(item_name)
					new_item:SetCombineLocked(true)
				end
			end
		end
	end
	hIllusion.bTreeTempGrab = false
end

function Illusion:ClearIllusion(hIllusion)
	if IsValid(hIllusion) then
		for i = 0, hIllusion:GetAbilityCount() - 1 do
			local hAbility = hIllusion:GetAbilityByIndex(i)
			if hAbility and not string.find(hAbility:GetAbilityName(), "special_bonus") then
				hIllusion:RemoveAbility(hAbility:GetAbilityName())
			end
		end
		for index = 0, 16 do
			local hClone_item = hIllusion:GetItemInSlot(index)
			if hClone_item then
				hIllusion:RemoveItem(hClone_item)
				-- UTIL_Remove(hClone_item)
			end
		end
		hIllusion:ForceKill(false)
		if IsValid(hIllusion) then
			hIllusion:RemoveSelf()
		end
	end
end