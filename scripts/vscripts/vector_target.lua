--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if not VectorTarget then 
	VectorTarget = class({})
end

ListenToGameEvent("game_rules_state_change", function()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		VectorTarget:Init()
	end
end, nil)

function VectorTarget:Init()
	print("[VT] Initializing VectorTarget...")
	local mode = GameRules:GetGameModeEntity()
--	mode:SetExecuteOrderFilter(Dynamic_Wrap(VectorTarget, 'OrderFilter'), VectorTarget)
	ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(VectorTarget, 'OnAbilityLearned'), self)
	ListenToGameEvent('dota_item_purchased', Dynamic_Wrap(VectorTarget, 'OnItemBought'), self)
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(VectorTarget, 'OnItemPickup'), self)

	CustomGameEventManager:RegisterListener("check_ability", Dynamic_Wrap(VectorTarget, "OnAbilityCheck"))
end

function CDOTABaseAbility:GetTargetPositionCheck()
	return self.vectorTargetPoisitioncheck
end 

function VectorTarget:UpdateNettable(ability)
	local vectorData = {
		startWidth = ability:GetVectorTargetStartRadius(),
		endWidth = ability:GetVectorTargetEndRadius(),
		castLength = ability:GetVectorTargetRange(),
		dual = ability:IsDualVectorDirection(),
		ignoreArrow = ability:IgnoreVectorArrowWidth(),
	}
	CustomNetTables:SetTableValue("vector_targeting", tostring(ability:entindex()), vectorData)
end

function VectorTarget:OnAbilityLearned(event)
	local playerID = event.PlayerID
	local hero = PlayerResource:GetSelectedHeroEntity(playerID)
	local ability = hero:FindAbilityByName(event.abilityname)

	if not ability or not ability.GetBehaviorInt then return true end
	local behavior = ability:GetBehaviorInt()

	-- check if the ability exists and if it is Vector targeting
	if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) ~= 0 then
		VectorTarget:UpdateNettable(ability)
	end
end

function VectorTarget:OnItemPickup(event)
	local index = event.item_entindex
	if not index then
		index = event.ItemEntityIndex
	end
	local ability = EntIndexToHScript(index)

	if not ability or not ability.GetBehaviorInt then return true end
	local behavior = ability:GetBehaviorInt()

	-- check if the item exists and if it is Vector targeting
	if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) ~= 0 then
		VectorTarget:UpdateNettable(ability)
	end
end

function VectorTarget:OnItemBought(event)
	local playerID = event.PlayerID
	local hero = PlayerResource:GetSelectedHeroEntity(playerID)

	for i=0, 15 do
		local item = hero:GetItemInSlot(i)
		if item and item.GetBehaviorInt then
			local behavior = item:GetBehaviorInt()
			if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) ~= 0 then
				VectorTarget:UpdateNettable(item)
			end
		end
	end
end

function VectorTarget:OnAbilityCheck(event)
	if event.PlayerID == nil then return end
	local ability = EntIndexToHScript(event.abilityIndex)
	VectorTarget:UpdateNettable(ability)
end

function CDOTABaseAbility:GetVectorTargetRange()
	return 800
end 

function CDOTABaseAbility:GetVectorTargetStartRadius()
	return 125
end 

function CDOTABaseAbility:GetVectorTargetEndRadius()
	return self:GetVectorTargetStartRadius()
end 

function CDOTABaseAbility:GetVectorPosition()
	return self.vectorTargetPosition
end 

function CDOTABaseAbility:GetVector2Position() -- world click
	return self.vectorTargetPosition2
end 

function CDOTABaseAbility:GetVectorDirection()
	return self.vectorTargetDirection
end 

function CDOTABaseAbility:OnVectorCastStart(vStartLocation, vDirection)
	print("Vector Cast")
end

function CDOTABaseAbility:UpdateVectorValues()
	VectorTarget:UpdateNettable(self)
end

function CDOTABaseAbility:IsDualVectorDirection()
	return false
end

function CDOTABaseAbility:IgnoreVectorArrowWidth()
	return false
end