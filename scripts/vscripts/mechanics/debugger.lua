--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Debugger == nil then Debugger = class({}) end

local ADMIN_IDS

function Debugger:Init()
	ListenToGameEvent("player_chat", Dynamic_Wrap(Debugger, "OnPlayerSay"), self)
	ADMIN_IDS = CustomNetTables:GetTableValue("admin", "admins")
end

---Определяет админ ли это
---@param steamId integer
---@return boolean
function Debugger:IsAdmin(steamId)
	return table.contains(ADMIN_IDS, steamId)
end

---@class Event_PlayerChat
---@field playerid integer
---@field userid EntityIndex
---@field text string
---@field teamonly boolean

---Обработчик событий из чата
---@param event Event_PlayerChat
function Debugger:OnPlayerSay(event)
	local szText = string.trim(string.lower(event.text))
	local hPlayer = PlayerResource:GetPlayer(event.playerid)

	if not hPlayer or hPlayer:IsNull() then
		return
	end

	local playerId = hPlayer:GetPlayerID()
	local steamId = PlayerResource:GetSteamAccountID(playerId)

	if string.startsWith(szText, "bot") and GameRulesCustom:State_Get() == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP and (GameRulesCustom:IsCheatMode()) then
		local botsCount = tonumber(string.split(szText, " ")[2])
		GameMode:SetUpBots(botsCount)
		return
	end

	local hHero = hPlayer:GetAssignedHero()
	if not hHero then
		return
	end

	if not (self:IsAdmin(steamId) or (GameRulesCustom:IsCheatMode())) then return end

	if string.startsWith(szText, "toserver") then
		local command = string.trim(string.remove(szText, "toserver"))
		logger:Logf("Command = %s", command)
		SendToServerConsole(command)
		return
	end

	if szText == "mem" then
		logger:InternalLog(MemoryTracker:GetMemoryUsageMessage())
		return
	end

	if szText == "killbots" then
		local units = FindUnitsInRadius(
			PlayerResource:GetTeam(0),
			Vector(0, 0, 0),
			nil,
			FIND_UNITS_EVERYWHERE,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			FIND_ANY_ORDER,
			false
		)
		for _, unit in pairs(units) do
			if IsValid(unit) then
				unit:ForceKill(false)
			end
		end
		return
	end

	if szText == "suicide" then
		hHero:ForceKill(false)
		return
	end

	if szText == "teleportall" then
		local allUnits = FindUnitsInRadius(
			DOTA_TEAM_NEUTRALS,
			Vector(0, 0, 0),
			nil,
			FIND_UNITS_EVERYWHERE,
			DOTA_UNIT_TARGET_TEAM_BOTH,
			DOTA_UNIT_TARGET_ALL,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_DEAD,
			FIND_ANY_ORDER,
			false
		)
		local targetPos = hHero:GetAbsOrigin()
		for _, unit in ipairs(allUnits) do
			FindClearSpaceForUnit(unit, targetPos, true)
		end
		return
	end

	if szText == "sd" then
		local damageTable = {
			victim = hHero,
			attacker = hHero,
			damage = 99999,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage(damageTable)
		return
	end

	if szText == "imba" then
		local hAbility = hHero:AddAbility("test_zuus_lightning_bolt")
		hAbility:SetLevel(1)
		return
	end

	if szText == "imba2" then
		local hAbility = hHero:AddAbility("test_zuus_thundergods_wrath")
		hAbility:SetLevel(1)
		return
	end

	if szText == "testshop" then
		Shop:GiveTestDataToPlayer(event.playerid)
		return
	end
	if szText == "imba3" then
		local hAbility = hHero:AddAbility("test_kill_all_neutral")
		hAbility:SetLevel(1)
		return
	end
	if szText == "imba4" then
		local hAbility = hHero:AddAbility("test_kill_one")
		hAbility:SetLevel(1)
		return
	end
	if szText == "imba5" then
		local hAbility = hHero:AddAbility("test_oracle_purifying_flames")
		hAbility:SetLevel(1)
		return
	end

	if szText == "blink" then
		local hAbility = hHero:AddAbility("antimage_blink_test")
		hAbility:SetLevel(1)
		return
	end

	if szText == "0" then
		SendToServerConsole("cl_ent_text")
		return
	end
	if szText == "1" then
		SendToServerConsole("ent_text")
		return
	end
	if szText == "2" then
		local hHero = PlayerResource:GetPlayer(event.playerid):GetAssignedHero()
		logger:Log(hHero:GetRangedProjectileName())
		return
	end
	if szText == "3" then
		local hHero = PlayerResource:GetPlayer(event.playerid):GetAssignedHero()
		for i = 0, hHero:GetAbilityCount() - 1 do
			if IsValid(hHero:GetAbilityByIndex(i)) then
				logger:Log(i, hHero:GetAbilityByIndex(i):GetAbilityName(), hHero:GetAbilityByIndex(i):GetLevel(),
					hHero:GetAbilityByIndex(i):IsHidden())
			end
		end
		return
	end

	if string.find(szText, "item_") == 1 then
		local hNewItem = hHero:AddItemByName(szText)
		if IsValid(hNewItem) then
			hNewItem:SetSellable(true)
		end
		return
	end

	if string.find(szText, "other_item_") == 1 then
		local sItemName = string.sub(szText, 7, string.len(szText))
		for i = 0, 15 do
			if (i ~= playerId) then
				local hItemHero = PlayerResource:GetSelectedHeroEntity(i)
				if hItemHero then
					local hNewItem = hItemHero:AddItemByName(sItemName)
				end
			end
		end
		return
	end

	if string.match(szText, "^%-[r|R][o|O][u|U][n|N][d|D]%d+") ~= nil then
		local nRoundNumber = string.match(szText, "%d+")
		GameMode.currentRound:End()
		GameMode.currentRound = Round()
		GameMode.currentRound:Prepare(tonumber(nRoundNumber))
		return
	end

	if szText == "con" then
		logger:Log(PlayerResource:GetConnectionState(playerId))
		return
	end
	if szText == "lm" then
		ListModifiers(hHero)
		return
	end
	if szText == "li" then
		ListItems(hHero)
		return
	end

	if string.find(szText, "npc_dota_hero_") == 1 then
		hHero = PlayerResource:ReplaceHeroWith(playerId, szText, hHero:GetGold(), 0)
		HeroBuilder:InitPlayerHeroDebug(hHero)
		return
	end

	if string.find(szText, "allup") == 1 then
		for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
			if PlayerResource:IsValidPlayer(nPlayerID) then
				local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				if hHero then
					hHero:AddExperience(150000, 0, true, true)
				end
			end
		end
		return
	end

	if string.find(szText, "allgold") == 1 then
		for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
			if PlayerResource:IsValidPlayer(nPlayerID) then
				local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				if hHero then
					PlayerResource:ModifyGold(nPlayerID, 99999, true, DOTA_ModifyGold_GameTick)
				end
			end
		end
		return
	end
	if string.find(szText, "uh") == 1 then
		UnhideAbilities(hHero)
		return
	end

	if szText == "la" then
		ListAbilities(hHero)
		return
	end

	if szText == "report_slot" then
		for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
			if PlayerResource:IsValidPlayer(nPlayerID) then
				local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				if hHero then
					logger:Log(hHero:GetUnitName())
					for i = 1, 50 do
						local hItem = hHero:GetItemInSlot(i - 1)
						if hItem then
							logger:Log(i .. hItem:GetAbilityName())
						end
					end
				end
			end
		end
		return
	end

	if szText == "kickself" then
		local player = PlayerResource:GetPlayer(playerId)
		if not player then return end
		CustomGameEventManager:Send_ServerToPlayer(player, "KickPlayer",
			{
				security_key = Security:GetSecurityKey(playerId),
				player_id = playerId
			})
		return
	end
end