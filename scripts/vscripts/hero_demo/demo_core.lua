--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if HeroDemo == nil then
	_G.HeroDemo = class({})
end

require("hero_demo/demo_events")

function HeroDemo:Init()
    if self.init then return end
    self.init = true

    CustomGameEventManager:RegisterListener( "RequestInitialSpawnHeroID", function(...) return self:OnRequestInitialSpawnHeroID( ... ) end )
    CustomGameEventManager:RegisterListener( "WelcomePanelDismissed", function(...) return self:OnWelcomePanelDismissed( ... ) end )
    CustomGameEventManager:RegisterListener( "LevelUpButtonPressed", function(...) return self:OnLevelUpButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "UltraMaxLevelButtonPressed", function(...) return self:OnUltraMaxLevelButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "FreeSpellsButtonPressed", function(...) return self:OnFreeSpellsButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "CombatLogButtonPressed", function(...) return self:CombatLogButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SelectMainHeroButtonPressed", function(...) return self:OnSelectMainHeroButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SelectSpawnHeroButtonPressed", function(...) return self:OnSelectSpawnHeroButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "RemoveHeroButtonPressed", function(...) return self:OnRemoveHeroButtonPressed( ... ) end )	
    CustomGameEventManager:RegisterListener( "LevelUpHero", function(...) return self:OnLevelUpHero( ... ) end )
    CustomGameEventManager:RegisterListener( "MaxLevelUpHero", function(...) return self:OnMaxLevelUpHero( ... ) end )
    CustomGameEventManager:RegisterListener( "ScepterHero", function(...) return self:OnScepterHero( ... ) end )
    CustomGameEventManager:RegisterListener( "ShardHero", function(...) return self:OnShardHero( ... ) end )
    CustomGameEventManager:RegisterListener( "ResetHero", function(...) return self:OnResetHero( ... ) end )
    CustomGameEventManager:RegisterListener( "ToggleInvulnerabilityHero", function(...) return self:OnSetInvulnerabilityHero( nil, ... ) end )
    CustomGameEventManager:RegisterListener( "InvulnOnHero", function(...) return self:OnSetInvulnerabilityHero( true, ... ) end )
    CustomGameEventManager:RegisterListener( "InvulnOffHero", function(...) return self:OnSetInvulnerabilityHero( false, ... ) end )
    CustomGameEventManager:RegisterListener( "DummyTargetButtonPressed", function(...) return self:OnDummyTargetButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "TestNotification", function(...) return self:TestNotification( ... ) end )
    CustomGameEventManager:RegisterListener( "TestNotificationRight", function(...) return self:TestNotificationRight( ... ) end )
    CustomGameEventManager:RegisterListener( "ChangeHeroButtonPressed", function(...) return self:OnChangeHeroButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "ChangeCosmeticsButtonPressed", function(...) return self:OnChangeCosmeticsButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SpawnCreepsButtonPressed", function(...) return self:OnSpawnCreepsButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SpawnSingleCreepWaveButtonPressed", function(...) return self:OnSpawnSingleCreepWaveButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "TowersEnabledButtonPressed", function(...) return self:OnTowersEnabledButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "PauseButtonPressed", function(...) return self:OnPauseButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "LeaveButtonPressed", function(...) return self:OnLeaveButtonPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SpawnRuneDoubleDamagePressed", function(...) return self:OnSpawnRuneDoubleDamagePressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SpawnRuneHastePressed", function(...) return self:OnSpawnRuneHastePressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SpawnRuneIllusionPressed", function(...) return self:OnSpawnRuneIllusionPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SpawnRuneInvisibilityPressed", function(...) return self:OnSpawnRuneInvisibilityPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SpawnRuneRegenerationPressed", function(...) return self:OnSpawnRuneRegenerationPressed( ... ) end )
    CustomGameEventManager:RegisterListener( "SpawnRuneArcanePressed", function(...) return self:OnSpawnRuneArcanePressed( ... ) end )
    CustomGameEventManager:RegisterListener( "CreateDemoChest", function(...) return self:CreateDemoChest( ... ) end )
    CustomGameEventManager:RegisterListener( "RespawnHeroDemo", function(...) return self:RespawnHeroDemo( ... ) end )
    CustomGameEventManager:RegisterListener( "SuicideHeroDemo", function(...) return self:SuicideHeroDemo( ... ) end )
    CustomGameEventManager:RegisterListener( "RefreshHeroDemo", function(...) return self:RefreshHeroDemo( ... ) end )
    CustomGameEventManager:RegisterListener( "ChooseSkillDemo", function(...) return self:ChooseSkillDemo( ... ) end )
    CustomGameEventManager:RegisterListener( "debugger_add_quick_skill", function(...) return self:AddQuickSkill( ... ) end )

    CustomGameEventManager:RegisterListener( "NewNotifications", function(...) return self:NewNotifications( ... ) end )
    CustomGameEventManager:RegisterListener( "OldNotifications", function(...) return self:OldNotifications( ... ) end )
    CustomGameEventManager:RegisterListener( "DamageTable", function(...) return self:DamageTable( ... ) end )
    CustomGameEventManager:RegisterListener( "BetTable", function(...) return self:BetTable( ... ) end )

    CustomGameEventManager:RegisterListener( "QueueRounds", function(...) return self:QueueRounds( ... ) end )

    CustomGameEventManager:RegisterListener( "CreateBot", function(...) return self:CreateBot( ... ) end )

    CustomGameEventManager:RegisterListener( "DamageReduction", function(...) return self:DamageReduction( ... ) end )

    CustomGameEventManager:RegisterListener( "debugger_start_round", function(source, event) return self:StartRound(event) end )
    CustomGameEventManager:RegisterListener( "debugger_create_dummy", function(source, event) return self:CreateDummy(event) end )
    CustomGameEventManager:RegisterListener( "debugger_delete_dummy", function(source, event) return self:DeleteDummy(event) end )

    CustomGameEventManager:RegisterListener( "debugger_give_item_to_dummy_from_shop", function(source, event) return self:GiveItemToDummy(event) end )

	CustomGameEventManager:RegisterListener('debugger_add_item', function(source, event) return self:AddItemToUnit(event) end)
	CustomGameEventManager:RegisterListener('debugger_add_ability', function(source, event) return self:AddAbilityToUnit(event) end)

	CustomGameEventManager:RegisterListener('debugger_craft_neutral', function(source, event) return self:CraftNeutral(event) end)

	CustomGameEventManager:RegisterListener('debugger_set_timescale', function(source, event) return self:SetTimeScale(event) end)

	CustomGameEventManager:RegisterListener('debugger_set_max_health', function(source, event) return self:SetMaxHealth(event) end)

	CustomGameEventManager:RegisterListener('debugger_replace_main_hero', function(source, event) return self:ReplaceMainHero(event) end)

	CustomGameEventManager:RegisterListener('debugger_spawn_creep', function(source, event) return self:SpawnDebugCreep(event) end)
	CustomGameEventManager:RegisterListener('debugger_delete_creep', function(source, event) return self:DeleteDebugCreep(event) end)
	CustomGameEventManager:RegisterListener('debugger_delete_all_creeps', function(source, event) return self:DeleteAllDebugCreeps(event) end)
	CustomGameEventManager:RegisterListener('debugger_modify_creep_stats', function(source, event) return self:ModifyDebugCreepStats(event) end)
	CustomGameEventManager:RegisterListener('debugger_reset_creep_damage', function(source, event) return self:ResetDebugCreepDamage(event) end)

	CustomGameEventManager:RegisterListener('debugger_give_loser_curse', function(source, event) return self:GiveLoserCurse(event) end)
	CustomGameEventManager:RegisterListener('debugger_clear_loser_curse', function(source, event) return self:ClearLoserCurse(event) end)
	CustomGameEventManager:RegisterListener('debugger_give_report_curse', function(source, event) return self:GiveReportCurse(event) end)
	CustomGameEventManager:RegisterListener('debugger_give_report_warning', function(source, event) return self:GiveReportWarning(event) end)
	CustomGameEventManager:RegisterListener('debugger_clear_punishments', function(source, event) return self:ClearPunishments(event) end)

	self.m_bFreeSpellsEnabled = false
	self.m_bInvulnerabilityEnabled = false
end

-- Чит-панель: выдать/снять проклятие проигравшего (для теста −исходящего урона по стакам).
function HeroDemo:GiveLoserCurse(event)
	local unit = event.unit and EntIndexToHScript(event.unit) or nil
	if not unit or unit:IsNull() then return end
	local mod = unit:FindModifierByName("modifier_loser_curse")
	if mod == nil then
		mod = unit:AddNewModifier(unit, nil, "modifier_loser_curse", {})
		if mod then mod:SetStackCount(0) end
	end
	if mod then mod:SetStackCount(mod:GetStackCount() + 1) end
end

function HeroDemo:ClearLoserCurse(event)
	local unit = event.unit and EntIndexToHScript(event.unit) or nil
	if not unit or unit:IsNull() then return end
	unit:RemoveModifierByName("modifier_loser_curse")
end

-- Чит-панель: тест штраф-системы (MF-2) в тулзмоде без БД. Вешаем report-курсу/предупреждение
-- прямо на юнит и публикуем статус в net table (для затемнения/бейджа в окне дуэли).
function HeroDemo:PublishPunishmentFromHero(unit)
	if not unit or unit:IsNull() then return end
	local pid = unit:GetPlayerOwnerID()
	if pid == nil or pid < 0 then return end
	local curseStacks = 0
	for _, m in pairs(unit:FindAllModifiers()) do
		if m and m.GetName and m:GetName() == "modifier_report_curse" then
			curseStacks = curseStacks + (m:GetStackCount() or 0)
		end
	end
	local hasWarning = unit:HasModifier("modifier_report_warning")
	-- Тестовая дата снятия (в реале сервер отдаёт expires_text из БД).
	local until_text = (curseStacks > 0 or hasWarning) and "23.07.2026 18:00" or ""
	CustomNetTables:SetTableValue("punishments", "player_"..pid, {
		warning = hasWarning,
		warning_until = hasWarning and until_text or "",
		curse = curseStacks > 0,
		curse_stacks = curseStacks,
		curse_until = curseStacks > 0 and until_text or "",
	})
end

function HeroDemo:GiveReportCurse(event)
	local unit = event.unit and EntIndexToHScript(event.unit) or nil
	if not unit or unit:IsNull() then return end
	-- report-курса — MULTIPLE: каждый вызов создаёт новый экземпляр (эмулируем строку наказания).
	-- БЕЗ длительности: срок живёт в БД, в игре показываем ДАТУ снятия в меню дуэли.
	local mod = unit:AddNewModifier(unit, nil, "modifier_report_curse", {})
	if mod then mod:SetStackCount(1) end
	self:PublishPunishmentFromHero(unit)
end

function HeroDemo:GiveReportWarning(event)
	local unit = event.unit and EntIndexToHScript(event.unit) or nil
	if not unit or unit:IsNull() then return end
	if not unit:HasModifier("modifier_report_warning") then
		unit:AddNewModifier(unit, nil, "modifier_report_warning", {})
	end
	self:PublishPunishmentFromHero(unit)
end

function HeroDemo:ClearPunishments(event)
	local unit = event.unit and EntIndexToHScript(event.unit) or nil
	if not unit or unit:IsNull() then return end
	-- modifier_report_curse — MULTIPLE: RemoveModifierByName снимает ОДИН экземпляр, а кнопка
	-- «дать курсу» создаёт по одному за нажатие. Снимаем все в цикле (идиома из репо).
	while unit:HasModifier("modifier_report_curse") do
		unit:RemoveModifierByName("modifier_report_curse")
	end
	unit:RemoveModifierByName("modifier_report_warning")
	self:PublishPunishmentFromHero(unit)
end

function HeroDemo:QueueRounds(event)
	GAME_QUEUE_ROUNDS_ENABLED = not GAME_QUEUE_ROUNDS_ENABLED

	local State = GAME_QUEUE_ROUNDS_ENABLED and "включен" or "выключен"

	if GAME_NOTIFICATIONS_ENABLED == false then
		Notifications:ClearNotifications()
	end

	Say(nil, "Режим очередей в раундах "..State, false)
end

function HeroDemo:NewNotifications(event)
	GAME_NOTIFICATIONS_ENABLED = not GAME_NOTIFICATIONS_ENABLED

	local State = GAME_NOTIFICATIONS_ENABLED and "включены" or "выключены"

	if GAME_NOTIFICATIONS_ENABLED == false then
		Notifications:ClearNotifications()
	end

	Say(nil, "Новые уведомления "..State, false)
end

function HeroDemo:OldNotifications(event)
	GAME_BARRAGE_ENABLED = not GAME_BARRAGE_ENABLED

	local State = GAME_BARRAGE_ENABLED and "включены" or "выключены"

	Say(nil, "Старые уведомления "..State, false)
end

function HeroDemo:DamageTable(event)
	if GAME_DAMAGE_TABLE_ENABLED then
		Players:ClearPlayersNetTableDamage()
	end

	GAME_DAMAGE_TABLE_ENABLED = not GAME_DAMAGE_TABLE_ENABLED

	local State = GAME_DAMAGE_TABLE_ENABLED and "включена" or "выключена"

	Say(nil, "Таблица урона "..State, false)
end

function HeroDemo:BetTable(event)
	GAME_BETS_HISTORY_ENABLED = not GAME_BETS_HISTORY_ENABLED

	local State = GAME_BETS_HISTORY_ENABLED and "включена" or "выключена"

	if GAME_BETS_HISTORY_ENABLED == false then
		Players:ClearBets()
	end

	Say(nil, "История ставок "..State, false)
end

function HeroDemo:DamageReduction(event)
	GAME_DAMAGE_REDUCTION_ENABLED = not GAME_DAMAGE_REDUCTION_ENABLED

	local State = GAME_DAMAGE_REDUCTION_ENABLED and "включено" or "выключено"

	Say(nil, "Снижение урона "..State, false)
end

function HeroDemo:TestNotification(event)
	Notifications:AddNotification(NOTIFICATION_TYPE.LAST_PLACE_BONUS_WITH_SMOKE, 1, {
		player1 = 0,
		item1 = "item_relearn_book_lua",
		item2 = "item_relearn_torn_page_lua",
		item3 = "item_smoke_of_deceit_custom"
	})
end

function HeroDemo:TestNotificationRight(event)
	Notifications:AddNotification(NOTIFICATION_TYPE.LAST_PLACE_BONUS_WITH_SMOKE, 1, {
		player1 = 0,
		item1 = "item_relearn_book_lua",
		item2 = "item_relearn_torn_page_lua",
		item3 = "item_smoke_of_deceit_custom"
	})
	Notifications:AddNotification(NOTIFICATION_TYPE.LAST_PLACE_BONUS_WITH_SMOKE, 1, {
		player1 = 0,
		item1 = "item_relearn_torn_page_lua",
		item2 = "item_smoke_of_deceit_custom",
		item3 = "item_relearn_book_lua"
	})
	Notifications:AddNotification(NOTIFICATION_TYPE.LAST_PLACE_BONUS, 1, {
		player1 = 0,
		item1 = "item_relearn_book_lua",
		item2 = "item_relearn_torn_page_lua",
		item3 = "item_smoke_of_deceit_custom"
	})
	Notifications:AddNotification(NOTIFICATION_TYPE.LAST_PLACE_BONUS_WITH_SMOKE, 1, {
		player1 = 0,
		item1 = "item_smoke_of_deceit_custom",
		item2 = "item_relearn_book_lua",
		item3 = "item_relearn_torn_page_lua"
	})
	Notifications:AddNotification(NOTIFICATION_TYPE.LAST_PLACE_BONUS_WITH_SMOKE, 1, {
		player1 = 0,
		item1 = "item_relearn_book_lua",
		item2 = "item_relearn_torn_page_lua",
		item3 = "item_smoke_of_deceit_custom"
	})
end

function HeroDemo:SetTimeScale(event)
	local ScaleNum = event.scale

	if ScaleNum == nil then return end

	if ScaleNum <= 0 then
		ScaleNum = 0.01
	end
	if ScaleNum > 10 then
		ScaleNum = 10
	end

	Convars:SetFloat("host_timescale", ScaleNum)
end

function HeroDemo:SetMaxHealth(event)
	local MaxHealth = event.max_health

	if MaxHealth == nil then return end

	if MaxHealth <= 0 then
		ScaleNum = 1
	end
	if MaxHealth > 1000000000 then
		MaxHealth = 1000000000
	end

	MAX_CREEP_HEALTH = MaxHealth
end

function HeroDemo:ReplaceMainHero(event)
	local PlayerID = event.PlayerID
	local HeroID = event.heroid
	local hPlayer = PlayerResource:GetPlayer(PlayerID)
    if hPlayer == nil then
        print("Unable to find player entity by index "..tostring(PlayerID)..".")
        return
    end

	local HeroName = DOTAGameManager:GetHeroUnitNameByID(HeroID)
	if HeroName == nil then
		print("Unable to find hero by index "..tostring(HeroID)..".")
		return
	end

	local OldHero = PlayerResource:GetSelectedHeroEntity(PlayerID)
	local SpawnPos = Vector(0,0,0)
	if OldHero then
		SpawnPos = OldHero:GetAbsOrigin()
	end
	local PlayerInfo = Players:GetPlayer(PlayerID)
	if PlayerInfo and SpawnPos == Vector(0,0,0) then
		SpawnPos = PlayerInfo.position
	end

	DebugCreateHeroWithVariant(hPlayer, HeroName, 0, DOTA_TEAM_CUSTOM_6, false,
		function(NewHero)
			if not NewHero then 
				print("Unable create hero "..tostring(HeroName)..".")
				return 
			end

			local tempPlayerId = NewHero:GetPlayerID()
			local botPlayer = PlayerResource:GetPlayer(tempPlayerId)

			NewHero.REPLACING_HERO = true

			Timers:CreateTimer(0.1, function()
				NewHero.REPLACING_HERO = nil

				if Rounds:IsTeamInPVPDuel(DOTA_TEAM_CUSTOM_6) then
					Rounds:EndPVPPair(DOTA_TEAM_CUSTOM_6, Rounds:StateIs(GAME_STATES.PREPARING))
				end

				Rounds:ClearTeamPVPPairs(DOTA_TEAM_CUSTOM_6)

				Rounds:EndTeam(DOTA_TEAM_CUSTOM_6)

				GameRules:ResetPlayer(PlayerID)

				NewHero:SetPlayerID(PlayerID)

				PlayerInfo.hero = NewHero

				NewHero:SetControllableByPlayer(PlayerID, true)
	
				NewHero:SetTeam(Players:GetPlayerTeamNumber(PlayerID))

				hPlayer:SetAssignedHeroEntity(NewHero)

				NewHero:SetOwner(hPlayer)

				NewHero:SetRespawnPosition(SpawnPos)
				FindClearSpaceForUnit(NewHero, SpawnPos, true)

				HeroBuilder:InitPlayerHero( NewHero )

				PlayerSelectUnit(PlayerID, NewHero, false)

				if botPlayer then
					botPlayer:SetAssignedHeroEntity(nil)
					botPlayer:SetSelectedHero("npc_dota_hero_axe")
					-- PlayerResource:SetCustomTeamAssignment(tempPlayerId, DOTA_TEAM_NOTEAM)
				end
				Players:UnregisterPlayer(tempPlayerId)
				if botPlayer then
					PlayerResource:SetCustomTeamAssignment(tempPlayerId, DOTA_TEAM_CUSTOM_6)
				end
				GameRules:ResetPlayer(tempPlayerId)
				DisconnectClient(tempPlayerId, true)
			end)
		end
	)
end

function HeroDemo:FillLobyWithBots()
	local PlayerID = 0

	local hPlayer = PlayerResource:GetPlayer(PlayerID)
    if hPlayer == nil then
        print("Unable to find player entity by index "..tostring(PlayerID)..".")
        return
    end

	for _, TeamID in ipairs(Players:GetAllTeams(true)) do
		if TeamID ~= DOTA_TEAM_GOODGUYS then
			Timers:CreateTimer(0.1*_, function()
				DebugCreateHeroWithVariant(hPlayer, "npc_dota_hero_axe", 0, TeamID, false, function(NewHero)
					NewHero:SetControllableByPlayer(PlayerID, true)
				end)
			end)
		end
	end
end

function HeroDemo:CreateBot(s, event)
	local PlayerID = event.PlayerID

	local hPlayer = PlayerResource:GetPlayer(PlayerID)
    if hPlayer == nil then
        print("Unable to find player entity by index "..tostring(PlayerID)..".")
        return
    end

	local Team = Players:GetFreeTeam()
	if Team ~= nil then
		DebugCreateHeroWithVariant(hPlayer, "npc_dota_hero_axe", 0, Team, false, function(NewHero)
			NewHero:SetControllableByPlayer(PlayerID, true)
		end)
	end
end

function HeroDemo:CraftNeutral(event)
	local TierNum = event.tier
	local PlayerID = event.PlayerID

	if TierNum == nil then return end

	NeutralItems:ClearNeutral(PlayerID)
	NeutralItems:GiveNeutral(PlayerID, TierNum)
end

function HeroDemo:AddItemToUnit(event)
	local itemName = event.itemName
	local unit = EntIndexToHScript(event.unit)
	if (unit and not unit:IsNull()) then
		unit:AddItemByName(itemName)
	end
end

function HeroDemo:AddAbilityToUnit(event)
	local AbilityName = event.abilityName
	local unit = EntIndexToHScript(event.unit)
	if (unit and not unit:IsNull()) then
		local RealUnit = GetRealUnit(unit)
		if RealUnit and RealUnit:IsRealHero() then
			local PlayerID = RealUnit:GetPlayerID()
			table.insert(HeroBuilder.Players[PlayerID].abilities_list, AbilityName)
			local CurrentRound = math.max(1, Rounds:GetCurrentRound())
			HeroBuilder.Players[PlayerID].abilities_list_server[AbilityName] = CurrentRound
		end
		HeroBuilder:AddAbilityToUnit(unit, AbilityName)
	end
end

function HeroDemo:CreateDummy(event)
	-- [TEMP DEBUG] Диагностика "кнопка создать мишень не реагирует". Удалить после починки.
	print("[HeroDemo/Dummy] CreateDummy called: event.PlayerID=" .. tostring(event and event.PlayerID))

	local PlayerID = event.PlayerID

	self._dummies = self._dummies or {}
	self._dummies[PlayerID] = self._dummies[PlayerID] or {}

	local PlayerHero = PlayerResource:GetSelectedHeroEntity(PlayerID)
	print("[HeroDemo/Dummy] PlayerHero=" .. tostring(PlayerHero) ..
	      " IsNull=" .. tostring(PlayerHero and PlayerHero.IsNull and PlayerHero:IsNull()))

	if PlayerHero then
		print("[HeroDemo/Dummy] Calling PrecacheUnitByNameAsync for npc_dota_hero_target_dummy")
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			print("[HeroDemo/Dummy] Precache callback fired, calling CreateUnitByName")
			local dummy = CreateUnitByName(
				"npc_dota_hero_target_dummy",
				PlayerHero:GetAbsOrigin(),
				true,
				PlayerHero,
				PlayerHero:GetPlayerOwner(),
				DOTA_TEAM_NEUTRALS
			)
			print("[HeroDemo/Dummy] dummy=" .. tostring(dummy))
			if dummy then
				dummy:SetControllableByPlayer(PlayerID, true)
				table.insert(self._dummies[PlayerID], dummy)
				print("[HeroDemo/Dummy] dummy created and stored, count=" .. #self._dummies[PlayerID])
			end
		end)
	else
		print("[HeroDemo/Dummy] PlayerHero is nil -- CreateDummy aborted")
	end
end

function HeroDemo:DeleteDummy(event)
	local PlayerID = event.PlayerID

	if not self._dummies or not self._dummies[PlayerID] or #self._dummies[PlayerID] == 0 then
		return
	end

	local lastDummy = self._dummies[PlayerID][#self._dummies[PlayerID]]
	if lastDummy and not lastDummy:IsNull() then
		UTIL_Remove(lastDummy)
	end
	table.remove(self._dummies[PlayerID])
end

function HeroDemo:GiveItemToDummy(event)
	local ItemName = event.ItemName
	local DummyEnt = event.DummyEnt

	local hDummy = EntIndexToHScript(DummyEnt)
	if hDummy and ItemName ~= nil and ItemName ~= "" and self:HasFreeSpaceInInventory(hDummy) then
		hDummy:AddItemByName(ItemName)
	end
end

function HeroDemo:HasFreeSpaceInInventory(Unit)
	for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_9 do
		local Item = Unit:GetItemInSlot(i)
		if Item == nil then
			return true
		end
	end
	return false
end

function HeroDemo:StartRound(event)
	local RoundNum = event.round_num

	Rounds:EndRound()

    for _, PlayerID in ipairs(Players:GetAllPlayers(true)) do
		if Players:IsActivePlayer(PlayerID) and Rounds:GetRoundInfo(RoundNum) == nil then
			Players:UpdateArena(PlayerID, "MAIN", nil)
		end
    end

	Rounds:PrepareRound(RoundNum)
    Util:ThinkerClean()
end

function HeroDemo:RespawnHeroDemo(eventSourceIndex, data)
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
    hPlayerHero:RespawnHero(false, false)
end

function HeroDemo:SuicideHeroDemo(eventSourceIndex, data)
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
    hPlayerHero:Kill(nil, hPlayerHero)
end

function HeroDemo:RefreshHeroDemo(eventSourceIndex, data)
	local hero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hero == nil then return end
    for i=0, hero:GetAbilityCount()-1 do
        local ability = hero:GetAbilityByIndex( i )
        if ability and ability:GetAbilityType()~=ABILITY_TYPE_ATTRIBUTES then
            ability:RefreshCharges()
            ability:EndCooldown()
        end
    end
    for i=0,5 do
        local item = hero:GetItemInSlot(i)
        if item then
            item:EndCooldown()
            item:RefreshCharges()
        end
    end
    local item_neutral = hero:GetItemInSlot(16)
    if item_neutral then
        item_neutral:EndCooldown()
    end
    hero:SetHealth(hero:GetMaxHealth())
    hero:SetMana(hero:GetMaxMana())
end

function HeroDemo:ChooseSkillDemo(eventSourceIndex, data)
    HeroBuilder:ShowRandomSkillSelectionFree(data.PlayerID)
end

function HeroDemo:AddQuickSkill(eventSourceIndex, data)
    local PlayerID = data.PlayerID
    local SkillName = data.skill_name
    local Count = data.count or 1

    if SKILLS_LIST_TABLE[SkillName] == nil or not HeroBuilder.Players[PlayerID] then return end

    local Hero = HeroBuilder.Players[PlayerID].selected_hero_ent
    if Hero == nil then return end

    if HeroBuilder.Players[PlayerID].skills_list == nil then
        HeroBuilder.Players[PlayerID].skills_list = {}
    end

    if HeroBuilder.Players[PlayerID].skills_list[SkillName] == nil then
        HeroBuilder.Players[PlayerID].skills_list[SkillName] = 0
    end

    for i = 1, Count do
        HeroBuilder.Players[PlayerID].skills_list[SkillName] = HeroBuilder.Players[PlayerID].skills_list[SkillName] + 1
    end

    PlayerTables:SetTableValue("player_"..PlayerID.."_global", "skills", HeroBuilder.Players[PlayerID].skills_list)
    Hero:AddNewModifier(Hero, nil, "modifier_skills_bonuses", {})

    print("[DEBUG] Added " .. Count .. "x " .. SkillName .. " to player " .. PlayerID)
end

function HeroDemo:CreateDemoChest(eventSourceIndex, data)
	if not HeroBuilder:IsPlayerSelectAbilities(data.PlayerID) and HeroBuilder:IsPlayerHasAbilities(data.PlayerID) then
		HeroBuilder:AddAbilitiesSelectionToSchedule(data.PlayerID, ABILITY_SELECTION_TYPE.DEV)
	end
end

function HeroDemo:SpawnHeroDemo( data )
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
	local hPlayer = PlayerResource:GetPlayer( data.PlayerID )
	local sHeroToSpawn = tostring(data.hero_name)
	local team = tonumber(data.team)

	DebugCreateUnit( hPlayer, sHeroToSpawn, team, false,
	function( hAlly )
		hAlly:SetControllableByPlayer( hPlayerHero:GetPlayerID(), false )
		hAlly:SetRespawnPosition( hPlayerHero:GetAbsOrigin() )
		FindClearSpaceForUnit( hAlly, hPlayerHero:GetAbsOrigin(), false )
		hAlly:Hold()
		hAlly:SetIdleAcquire( false )
		hAlly:SetAcquisitionRange( 0 )
	end )
end

function HeroDemo:ChangeHeroDemo( data )
	local PlayerID = data.PlayerID
	if HeroBuilder.Players[PlayerID] then
		HeroBuilder.Players[PlayerID].abilities_list = {}
		HeroBuilder.Players[PlayerID].abilities_list_server = {}
		HeroBuilder.Players[PlayerID].skills_list = {}
		HeroBuilder.Players[PlayerID].skills_points = 0
		HeroBuilder.Players[PlayerID].skills_current_selecting = nil
		PlayerTables:SetTableValue("player_"..PlayerID.."_global", "skills", {})
	end
	local hHero = PlayerResource:ReplaceHeroWith(PlayerID, data.hero_name, 99999, 0)
	HeroBuilder:InitPlayerHero(hHero)
end

function HeroDemo:OnWelcomePanelDismissed( event )

end

-- ПЛЮС 1 УРОВЕНЬ
function HeroDemo:OnLevelUpButtonPressed( eventSourceIndex )
	local AllHeroes = HeroList:GetAllHeroes()
	for count, hero in ipairs(AllHeroes) do
		hero:HeroLevelUp(false)
	end
end

-- МАКС. УРОВЕНЬ
function HeroDemo:OnUltraMaxLevelButtonPressed( eventSourceIndex, data )
	local AllHeroes = HeroList:GetAllHeroes()
	for count, hero in ipairs(AllHeroes) do
		for i=1,25 do
			hero:HeroLevelUp(false)
		end
	end
end

-- втф режим
function HeroDemo:OnFreeSpellsButtonPressed( eventSourceIndex )
    local nWTFEnabledEnabled = Convars:GetInt("dota_ability_debug") 

	if nWTFEnabledEnabled == 0 then	
		Convars:SetInt("dota_ability_debug", 1)
		self.m_bFreeSpellsEnabled = true
		local AllHeroes = HeroList:GetAllHeroes()
		for count, hero in ipairs(AllHeroes) do
			for i=0, hero:GetAbilityCount()-1 do
		        local ability = hero:GetAbilityByIndex( i )
		        if ability and ability:GetAbilityType()~=ABILITY_TYPE_ATTRIBUTES then
		            ability:RefreshCharges()
		            ability:EndCooldown()
		        end
		    end

		    for i=0,8 do
		        local item = hero:GetItemInSlot(i)
		        if item then
		            item:EndCooldown()
		        end
		    end
		end
		self:BroadcastMsg( "#FreeSpellsOn_Msg" )
	elseif nWTFEnabledEnabled == 1 then
		Convars:SetInt("dota_ability_debug", 0)
		self.m_bFreeSpellsEnabled = false
		self:BroadcastMsg( "#FreeSpellsOff_Msg" )
	end
end

function HeroDemo:CombatLogButtonPressed( eventSourceIndex )

end

-- ИНВУЛ
function HeroDemo:OnSetInvulnerabilityHero( bInvuln, eventSourceIndex, data )
	local nHeroEntIndex = tonumber( data.str )
	local hHero = EntIndexToHScript( nHeroEntIndex )
	if ( hHero ~= nil and hHero:IsNull() == false ) then
		local hAllUnits = {}
		if hHero:IsRealHero() then
			hAllUnits = hHero:GetAdditionalOwnedUnits()
		end
		table.insert( hAllUnits, hHero )

		if bInvuln == nil then
			bInvuln = hHero:FindModifierByName( "modifier_stranger_test" ) == nil
		end

		if bInvuln then
			for _, hUnit in pairs( hAllUnits ) do
				hUnit:AddNewModifier( hHero, nil, "modifier_stranger_test", nil )
			end
		else
			for _, hUnit in pairs( hAllUnits ) do
				hUnit:RemoveModifierByName( "modifier_stranger_test" )
			end
		end
	end
end

function HeroDemo:OnRequestInitialSpawnHeroID( eventSourceIndex, data )

end

function HeroDemo:OnSelectMainHeroButtonPressed( eventSourceIndex, data )

end

function HeroDemo:OnSelectSpawnHeroButtonPressed( eventSourceIndex, data )

end

function HeroDemo:OnRemoveHeroButtonPressed( eventSourceIndex, data )

end

function HeroDemo:OnLevelUpHero( eventSourceIndex, data )
	local nHeroEntIndex = tonumber( data.str )
	local hHero = EntIndexToHScript( nHeroEntIndex )
	if ( hHero ~= nil and hHero:IsNull() == false ) then
		if hHero.HeroLevelUp then
			hHero:HeroLevelUp( true )
		end
	end
end

-- Максимальный уровнень
function HeroDemo:OnMaxLevelUpHero( eventSourceIndex, data )
	local nHeroEntIndex = tonumber( data.str )
	local hHero = EntIndexToHScript( nHeroEntIndex )
	if ( hHero ~= nil and hHero:IsNull() == false ) then
		if hHero.AddExperience then
			hHero:AddExperience( GameRules.xpTable[#GameRules.xpTable], false, false )
			for i = 0, hHero:GetAbilityCount()-1 do
				local hAbility = hHero:GetAbilityByIndex( i )
				if hAbility and not hAbility:IsAttributeBonus() then
					while hAbility:GetLevel() < hAbility:GetMaxLevel() and hAbility:CanAbilityBeUpgraded () == ABILITY_CAN_BE_UPGRADED and not hAbility:IsHidden()  do
						hHero:UpgradeAbility( hAbility )
					end
				end
			end
		end
	end
end

function HeroDemo:OnScepterHero( eventSourceIndex, data )
	local nHeroEntIndex = tonumber( data.str )
	local hHero = EntIndexToHScript( nHeroEntIndex )
	if ( hHero ~= nil and hHero:IsNull() == false ) then
		if not hHero:FindModifierByName( "modifier_item_ultimate_scepter_consumed" ) then
			hHero:AddNewModifier(hHero, nil, "modifier_item_ultimate_scepter_consumed", {})
		end
	end
end

function HeroDemo:OnShardHero( eventSourceIndex, data )
	local nHeroEntIndex = tonumber( data.str )
	local hHero = EntIndexToHScript( nHeroEntIndex )
	if ( hHero ~= nil and hHero:IsNull() == false ) then
		if not hHero:FindModifierByName( "modifier_item_aghanims_shard" ) then
			hHero:AddItemByName( "item_aghanims_shard" )
		end
	end
end

-- РЕСЕТ ХИРО
function HeroDemo:OnResetHero( eventSourceIndex, data )
	local nHeroEntIndex = tonumber( data.str )
	local hHero = EntIndexToHScript( nHeroEntIndex )
	if ( hHero ~= nil and hHero:IsNull() == false ) then
		local PlayerID = hHero:GetPlayerOwnerID()
		GameRules:SetSpeechUseSpawnInsteadOfRespawnConcept( true )
        hHero = PlayerResource:ReplaceHeroWith(PlayerID, hHero:GetUnitName(), -1, 0)
        if HeroBuilder.Players[PlayerID] then
            HeroBuilder.Players[PlayerID].abilities_list = {}
            HeroBuilder.Players[PlayerID].abilities_list_server = {}
            HeroBuilder.Players[PlayerID].skills_list = {}
            HeroBuilder.Players[PlayerID].skills_points = 0
            HeroBuilder.Players[PlayerID].skills_current_selecting = nil
            PlayerTables:SetTableValue("player_"..PlayerID.."_global", "skills", {})
        end
        HeroBuilder:InitPlayerHero(hHero)
		GameRules:SetSpeechUseSpawnInsteadOfRespawnConcept( false )
	end
end

-- СПАВН ДУММИ
function HeroDemo:OnDummyTargetButtonPressed( eventSourceIndex, data )
	Players:ModifyPlayerGold(data.PlayerID, 999999, true, true, true)
end

function HeroDemo:OnTowersEnabledButtonPressed( eventSourceIndex )

end

function HeroDemo:SetTowersEnabled( bEnabled )
	
end

function HeroDemo:FindTowers()

end

function HeroDemo:OnSpawnCreepsButtonPressed( eventSourceIndex )

end

function HeroDemo:OnSpawnSingleCreepWaveButtonPressed( eventSourceIndex )

end

function HeroDemo:RemoveCreeps()

end

-- СПАВН РУНЫ
function HeroDemo:SpawnRuneInFrontOfUnit( hUnit, runeType )
	if hUnit == nil then
		return
	end

	local fDistance = 200.0
	local fMinSeparation = 50.0
	local fRingOffset = fMinSeparation + 20.0
	local vDir = hUnit:GetForwardVector()
	local vInitialTarget = hUnit:GetAbsOrigin() + vDir * fDistance
	vInitialTarget.z = GetGroundHeight( vInitialTarget, nil )
	local vTarget = vInitialTarget
	local nRemainingAttempts = 100
	local fAngle = 2 * math.pi
	local fOffset = 0.0
	local bDone = false

	local vecRunes = Entities:FindAllByClassname( "dota_item_rune" )
	while ( not bDone and nRemainingAttempts > 0 ) do
		bDone = true
		-- Too close to other runes?
		for i=1, #vecRunes do
			if ( vecRunes[i]:GetAbsOrigin() - vTarget ):Length() < fMinSeparation then
				bDone = false
				break
			end
		end
		if not GridNav:CanFindPath( hUnit:GetAbsOrigin(), vTarget ) then
			bDone = false
		end 
		if not bDone then
			fAngle = fAngle + 2 * math.pi / 8
			if fAngle >= 2 * math.pi then
				fOffset = fOffset + fRingOffset
				fAngle = 0
			end
			vTarget = vInitialTarget + fOffset * Vector( math.cos( fAngle ), math.sin( fAngle), 0.0 )
			vTarget.z = GetGroundHeight( vTarget, nil )
		end
		nRemainingAttempts = nRemainingAttempts - 1
	end

	CreateRune( vTarget, runeType )
end

function HeroDemo:OnSpawnRuneDoubleDamagePressed( eventSourceIndex, data )
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
	self:SpawnRuneInFrontOfUnit( hPlayerHero, DOTA_RUNE_DOUBLEDAMAGE )
	EmitGlobalSound( "UI.Button.Pressed" )
end

function HeroDemo:OnSpawnRuneHastePressed( eventSourceIndex, data )
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
	self:SpawnRuneInFrontOfUnit( hPlayerHero, DOTA_RUNE_HASTE )
	EmitGlobalSound( "UI.Button.Pressed" )
end

function HeroDemo:OnSpawnRuneIllusionPressed( eventSourceIndex, data )
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
	self:SpawnRuneInFrontOfUnit( hPlayerHero, DOTA_RUNE_ILLUSION )
	EmitGlobalSound( "UI.Button.Pressed" )
end

function HeroDemo:OnSpawnRuneInvisibilityPressed( eventSourceIndex, data )
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
	self:SpawnRuneInFrontOfUnit( hPlayerHero, DOTA_RUNE_INVISIBILITY )
	EmitGlobalSound( "UI.Button.Pressed" )
end

function HeroDemo:GetRuneSpawnLocation()

end

function HeroDemo:OnSpawnRuneRegenerationPressed( eventSourceIndex, data )
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
	self:SpawnRuneInFrontOfUnit( hPlayerHero, DOTA_RUNE_REGENERATION )
	EmitGlobalSound( "UI.Button.Pressed" )
end

function HeroDemo:OnSpawnRuneArcanePressed( eventSourceIndex, data )
	local hPlayerHero = PlayerResource:GetSelectedHeroEntity( data.PlayerID )
	if hPlayerHero == nil then return end
	self:SpawnRuneInFrontOfUnit( hPlayerHero, DOTA_RUNE_ARCANE )
end

function HeroDemo:OnChangeCosmeticsButtonPressed( eventSourceIndex )

end

function HeroDemo:OnChangeHeroButtonPressed( eventSourceIndex, data )

end

function HeroDemo:OnPauseButtonPressed( eventSourceIndex )

end

function HeroDemo:OnLeaveButtonPressed( eventSourceIndex )

end

function HeroDemo:BroadcastMsg( sMsg )
	-- Display a message about the button action that took place
	local buttonEventMessage = sMsg
	--print( buttonEventMessage )
	local centerMessage = {
		message = buttonEventMessage,
		duration = 1.0,
		clearQueue = true -- this doesn't seem to work
	}
	FireGameEvent( "show_center_message", centerMessage )
end

-- Debug Creep Spawner

function HeroDemo:SpawnDebugCreep(event)
	local PlayerID = event.PlayerID
	local creepItemName = event.creep_name

	if not creepItemName then return end

	-- Support both EXTRA_CREATURES_LIST items and direct unit names (Roshan, Nian)
	local DEBUG_EXTRA_CREATURES = {
		["debug_creature_roshan"] = "npc_dota_roshan",
		["debug_creature_nian"] = "npc_dota_nian",
	}

	local unitName = EXTRA_CREATURES_LIST[creepItemName] or DEBUG_EXTRA_CREATURES[creepItemName]
	if not unitName then return end
	local hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
	if not hero then return end

	self._debug_creeps = self._debug_creeps or {}
	self._debug_creeps[PlayerID] = self._debug_creeps[PlayerID] or {}

	PrecacheUnitByNameAsync(unitName, function()
		local creep = CreateUnitByName(
			unitName,
			hero:GetAbsOrigin(),
			true,
			hero,
			hero:GetPlayerOwner(),
			DOTA_TEAM_NEUTRALS
		)
		if not creep then return end

		creep:SetControllableByPlayer(PlayerID, true)
		creep:SetIdleAcquire(false)
		creep:SetAcquisitionRange(0)
		creep:Hold()

		-- Apply wave-scaled stats
		local RoundNum = math.max(1, Rounds:GetCurrentRound())

		local MaxHealth = RoundController:CalculateHealth(creep:GetMaxHealth(), RoundNum)
		creep:SetBaseMaxHealth(MaxHealth)
		creep:SetMaxHealth(MaxHealth)
		creep:SetHealth(MaxHealth)

		local armorBonus = GetGameSetting("CREEP_BONUS_ARMOR_PER_LATE_ROUND") * math.max(0, RoundNum - 50)
		creep:SetPhysicalArmorBaseValue(creep:GetPhysicalArmorBaseValue() + armorBonus)

		local flDamageMin = RoundController:CalculateDamage(creep:GetBaseDamageMin(), RoundNum)
		creep:SetBaseDamageMin(flDamageMin)

		local flDamageMax = RoundController:CalculateDamage(creep:GetBaseDamageMax(), RoundNum)
		creep:SetBaseDamageMax(flDamageMax)

		local flSpeedMultiple = math.pow(1.062, RoundNum)
		creep:SetBaseAttackTime(GetUnitBaseAttackTime(creep) / flSpeedMultiple)

		-- Apply damage tracker
		creep._debug_owner_player_id = PlayerID
		creep:AddNewModifier(creep, nil, "modifier_debug_creep_damage_tracker", {})

		local entIndex = creep:entindex()
		table.insert(self._debug_creeps[PlayerID], creep)

		-- Send creep info with actual stats to client
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(PlayerID),
			"debugger_creep_spawned",
			{
				entindex = entIndex,
				unit_name = unitName,
				item_name = creepItemName,
				stats = {
					health = MaxHealth,
					damage_min = flDamageMin,
					damage_max = flDamageMax,
					armor = string.format("%.1f", creep:GetPhysicalArmorBaseValue()),
					magic_resist = string.format("%.1f", creep:GetBaseMagicalResistanceValue()),
					attack_speed = string.format("%.2f", GetUnitBaseAttackTime(creep)),
					move_speed = creep:GetBaseMoveSpeed(),
				}
			}
		)
	end)
end

function HeroDemo:DeleteDebugCreep(event)
	local PlayerID = event.PlayerID
	local entIndex = event.entindex

	if not self._debug_creeps or not self._debug_creeps[PlayerID] then return end

	for i, creep in ipairs(self._debug_creeps[PlayerID]) do
		if creep and not creep:IsNull() and creep:entindex() == entIndex then
			UTIL_Remove(creep)
			table.remove(self._debug_creeps[PlayerID], i)
			return
		end
	end
end

function HeroDemo:DeleteAllDebugCreeps(event)
	local PlayerID = event.PlayerID

	if not self._debug_creeps or not self._debug_creeps[PlayerID] then return end

	for _, creep in ipairs(self._debug_creeps[PlayerID]) do
		if creep and not creep:IsNull() then
			UTIL_Remove(creep)
		end
	end

	self._debug_creeps[PlayerID] = {}
end

function HeroDemo:ModifyDebugCreepStats(event)
	local PlayerID = event.PlayerID
	local entIndex = event.entindex
	local stat = event.stat
	local value = tonumber(event.value)

	if not entIndex or not stat or not value then return end

	local unit = EntIndexToHScript(entIndex)
	if not unit or unit:IsNull() then return end

	if stat == "health" then
		unit:SetBaseMaxHealth(value)
		unit:SetMaxHealth(value)
		unit:SetHealth(value)
	elseif stat == "damage_min" then
		unit:SetBaseDamageMin(value)
	elseif stat == "damage_max" then
		unit:SetBaseDamageMax(value)
	elseif stat == "armor" then
		unit:SetPhysicalArmorBaseValue(value)
	elseif stat == "magic_resist" then
		unit:SetBaseMagicalResistanceValue(value)
	elseif stat == "attack_speed" then
		unit:SetBaseAttackTime(value)
	elseif stat == "move_speed" then
		unit:SetBaseMoveSpeed(value)
	end
end

function HeroDemo:ResetDebugCreepDamage(event)
	local entIndex = event.entindex

	if not entIndex then return end

	local unit = EntIndexToHScript(entIndex)
	if not unit or unit:IsNull() then return end

	local tracker = unit:FindModifierByName("modifier_debug_creep_damage_tracker")
	if tracker then
		tracker:ResetStats()
	end
end