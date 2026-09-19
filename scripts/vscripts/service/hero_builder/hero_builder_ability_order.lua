--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- Порядок и раскладка способностей в панели: UI-синк порядка + вставка в слот.

---@param playerId integer
function HeroBuilderService:RefreshAbilityOrder(playerId)
	local player = PlayerResource:GetPlayer(playerId)
	local hero = PlayerResource:GetSelectedHeroEntity(playerId)
	if not (player and IsValid(hero)) then
		return
	end
	---@cast hero CDOTA_BaseNPC_Hero

	Timers:CreateTimer(0.1, function()
		if IsValid(hero) then
			hero.swapUiSecret = CreateSecretKey()
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"RefreshAbilityOrder",
				{ swap_ui_secret = hero.swapUiSecret }
			)
			CustomGameEventManager:Send_ServerToTeam(hero:GetTeamNumber(), "UpdateTeamPlayers", {})
		end
		return nil
	end)
end

---@param hero CDOTA_BaseNPC_Hero?
---@param ability CDOTABaseAbility?
function HeroBuilderService:SetAbilityToSlot(hero, ability)
	if not hero then
		return
	end
	if not ability then
		return
	end

	for i = 0, 5 do
		local slotAbility = hero:GetAbilityByIndex(i)

		if not slotAbility or slotAbility:IsNull() then
			logger:LogError("Can't find slotAbility")
		end

		if slotAbility and slotAbility.placeholderIndex then
			hero:SwapAbilities(slotAbility, ability, false, true)
			ability:SetAbilityIndex(slotAbility.placeholderIndex - 1)
			return
		end
	end
end

---Обновить порядок способностей на следующем кадре, когда движок применит изменения.
---@param hero CDOTA_BaseNPC_Hero?
function HeroBuilderService:RefreshAbilityOrderNextFrame(hero)
	Timers:CreateTimer(FrameTime(), function()
		if IsValid(hero) and hero.GetPlayerID and hero:GetPlayerID() then ---@cast hero CDOTA_BaseNPC_Hero
			self:RefreshAbilityOrder(hero:GetPlayerID())
		end
		return nil
	end)
end

---Показать скрытую способность после задержки и подобрать ей горячую клавишу.
---@param hero CDOTA_BaseNPC_Hero
---@param ability CDOTABaseAbility
---@param abilityName string
---@param delay number
function HeroBuilderService:RevealAbilityDelayed(hero, ability, abilityName, delay)
	Timers:CreateTimer(delay, function()
		if IsValid(ability) and ability:IsHidden() then
			ability:SetHidden(false)
			hero:FindHotKeyForAbility(abilityName)
		end
		return nil
	end)
end