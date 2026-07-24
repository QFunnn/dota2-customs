--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Debugger == nil then 
    Debugger = class({}) 
end

function Debugger:Init()
    ListenToGameEvent("player_chat", Dynamic_Wrap(Debugger, "OnPlayerSay"), self)
    
    -- Флаг для отслеживания состояния команды -allstop
    self.allStopActive = false
    
    -- Сохраняем информацию о центрах арен для новых крипов
    self.playerArenas = {}
end

function Debugger:OnPlayerSay(keys)
    local szText = string.trim(string.lower(keys.text))
    local hPlayer = PlayerResource:GetPlayer(keys.playerid)
    if not hPlayer or hPlayer:IsNull() then return end
    local nPlayerId = hPlayer:GetPlayerID()
    local nSteamID = PlayerResource:GetSteamAccountID(nPlayerId)
    local hero = hPlayer:GetAssignedHero()
    if not hero then return end
    if GameMode.nValidTeamNumber == 1 and szText == "-suicide" then
        hero:ForceKill(false)
    end

    if szText == "-gglose" then
        if Players:IsActivePlayer(nPlayerId) then
            Players:UpdatePlayerState(nPlayerId, PLAYER_STATE.LOSER)
        end
    end

    if Admins:IsAdmin(nSteamID) or (GameRules:IsCheatMode()) then

        if szText == "-spec" then
            PlayerResource:SetCustomTeamAssignment(nPlayerId, 1)
            Players:LoadSpectator(nPlayerId)
        end

        if szText == "-modifiers" then
            if hero then
                GameRules:SendCustomMessage("=== Модификаторы героя " .. hero:GetUnitName() .. " ===", 0, 0)
                for i = 0, hero:GetModifierCount() - 1 do
                    local modifier = hero:GetModifierNameByIndex(i)
                    if modifier then
                        GameRules:SendCustomMessage("Модификатор " .. i .. ": " .. modifier, 0, 0)
                    end
                end
                GameRules:SendCustomMessage("=== Конец списка модификаторов ===", 0, 0)
            end
        end

        if szText == "-pall" then
            for i = 0, 24 do
                if PlayerResource:IsValidPlayerID(i) then
                    GameRules:SendCustomMessage("Существует игрок с PlayerID = "..i, 0, 0)
                    local PlayerInfo = Players:GetPlayer(i)
                    if PlayerInfo then
                        GameRules:SendCustomMessage("Players Lib: bIsBot = "..tostring(PlayerInfo.is_bot).." Team = "..PlayerInfo.team, 0, 0)
                    end
                    GameRules:SendCustomMessage("PlayerResource Team = "..PlayerResource:GetTeam(i), 0, 0)
                end
            end
        end

        if szText == "-pdump" then
            for PlayerID, PlayerInfo in pairs(Players:GetAllPlayers()) do
                GameRules:SendCustomMessage("Игрок "..PlayerID.." команда "..PlayerInfo.team.." bIsBot = "..tostring(PlayerInfo.is_bot), 0, 0)
            end
        end

        if szText == "-tdump" then
            for TeamID, TeamInfo in pairs(Players:GetAllTeams()) do
                GameRules:SendCustomMessage("Команда "..TeamID.." состояние "..TeamInfo.state.." кол-во игроков = "..#TeamInfo.players, 0, 0)
                for _, PlayerID in ipairs(TeamInfo.players) do
                    GameRules:SendCustomMessage("Игрок "..PlayerID, 0, 0)
                end
            end
        end

        if szText == "-cdump" then
            for _, DumpInfo in ipairs(Players.Dump) do
                GameRules:SendCustomMessage(json.encode(DumpInfo), 0, 0)
            end
        end

        local forceMatch = string.match(szText, "^%-forceround%s+(%d+)")
        if forceMatch then
            local roundNum = tonumber(forceMatch)
            if roundNum and roundNum >= 1 and roundNum <= GAME_MAX_ROUNDS and GAME_ROUNDS_LIST[roundNum] then
                GameRules:SendCustomMessage("[FORCEROUND] Принудительно запускается раунд " .. roundNum .. " (" .. (GAME_ROUNDS_LIST[roundNum].name or "Unknown") .. ")", 0, 0)
                local currentRoundNum = Rounds:GetCurrentRound()
                Rounds:EndRound(false)
                Rounds.FixedRoundOverride = roundNum
                Rounds:PrepareRound(currentRoundNum)
            else
                GameRules:SendCustomMessage("[ERROR] Неверный номер раунда: " .. (forceMatch or "nil") .. ". Используйте: -forceround 1-" .. GAME_MAX_ROUNDS, 0, 0)
            end
        end
        
        if szText == "-duelinfo" then
            local activePlayersCount = #Players:GetAllActivePlayers(true)
            local allActiveTeams = Players:GetAllActiveTeams(true)
            local allActivePlayers = Players:GetAllActivePlayers()
            local nextRoundNum = Rounds:GetCurrentRound() + 1
            local nextRoundInfo = Rounds:GetRoundInfo(nextRoundNum)
            local canHaveDuel = Rounds:CanRoundHaveDuel(nextRoundInfo)
            local shouldHaveDuel = Rounds:ShouldRoundHaveDuel(nextRoundNum, nextRoundInfo)
            
            GameRules:SendCustomMessage("[DUELINFO] Текущий раунд: " .. Rounds:GetCurrentRound() .. " | Следующий: " .. nextRoundNum .. " | Игроков: " .. activePlayersCount, 0, 0)
            GameRules:SendCustomMessage("[DUELINFO] Команд: " .. #allActiveTeams .. " | Последняя дуэль: " .. Rounds.LastDuelRound .. " | Разница: " .. (nextRoundNum - Rounds.LastDuelRound), 0, 0)
            GameRules:SendCustomMessage("[DUELINFO] Команды: " .. table.concat(allActiveTeams, ", ") .. " | PVP пар: " .. #Rounds.PVPPairs, 0, 0)
            GameRules:SendCustomMessage("[DUELINFO] Может дуэль: " .. (canHaveDuel and "Да" or "Нет") .. " | Будет дуэль: " .. (shouldHaveDuel and "Да" or "Нет") .. " | has_duel=" .. tostring(nextRoundInfo and nextRoundInfo.has_duel), 0, 0)
            
            for playerID, playerInfo in pairs(allActivePlayers) do
                GameRules:SendCustomMessage("[DUELINFO] Игрок " .. playerID .. " в команде " .. playerInfo.team, 0, 0)
            end
        end

        if szText == "-sdi" then
            CustomNetTables:SetTableValue("globals", "duel_info", {
                state="PREPARING",
                fTeamID=2,
                sTeamID=3,
                PlayersList={{PlayerID = 0, TeamID = 2}, {PlayerID = 1, TeamID = 3}}
            })
        end

        if szText == "-cdi" then
            CustomNetTables:SetTableValue("globals", "duel_info", {
                state="FINISHED"
            })
        end

        if szText == "-leave" then
            Players:OnPlayerDisconnected({PlayerID = 0})
        end

        if szText == "-test" then
            PlayerResource:SetCustomTeamAssignment(nPlayerId, 1)
        end

        if szText == "-errors" then
            DeepPrintTable(ErrorTracking.errors)
            for _, Error in pairs(ErrorTracking.errors) do
                GameRules:SendCustomMessage(Error, 0, 0)
            end
        end

        if szText == "-sa" then
            STOP_ALL_ORDERS = true
        end

        if szText == "-sr" then
            STOP_ALL_ORDERS = false
        end

        if szText == "-bl" then
            DisconnectClient(1, true)
        end

        if szText == "-bp" then
            Players:OnPlayerWantPauseGame({PlayerID = 1})
        end

        if szText == "-tbl" then
            Players:UpdatePlayerState(1, PLAYER_STATE.ABANDONED)
        end

        if szText == "-tbpl" then
            Players:UpdatePlayerState(1, PLAYER_STATE.LEAVED)
        end

        if szText == "-tl" then
            Players:UpdatePlayerState(0, PLAYER_STATE.ABANDONED)
        end

        if szText == "-cr" then
            CreateItemOnPositionSync(Vector(-5000, 4600, 128), CreateItem("item_custom_rune_haste", nil, nil))
            CreateItemOnPositionSync(Vector(-5100, 4600, 128), CreateItem("item_custom_rune_double_damage", nil, nil))
            CreateItemOnPositionSync(Vector(-4900, 4600, 128), CreateItem("item_custom_rune_illusion", nil, nil))
            CreateItemOnPositionSync(Vector(-5000, 4700, 128), CreateItem("item_custom_rune_invisibility", nil, nil))
            CreateItemOnPositionSync(Vector(-5000, 4500, 128), CreateItem("item_custom_rune_regeneration", nil, nil))
            CreateItemOnPositionSync(Vector(-4900, 4500, 128), CreateItem("item_custom_rune_arcane", nil, nil))
            CreateItemOnPositionSync(Vector(-5100, 4700, 128), CreateItem("item_custom_rune_shield", nil, nil))
        end

        if szText == "-lc" then
            hero:AddNewModifier(hero, nil, "modifier_loser_curse", {}):SetStackCount(5)
        end

        if szText == "-pau" then
            local All = FindUnitsInRadius(
                DOTA_TEAM_GOODGUYS, 
                Vector(0,0,0), 
                nil, 
                999999, 
                DOTA_UNIT_TARGET_TEAM_BOTH, 
                DOTA_UNIT_TARGET_ALL, 
                DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 
                FIND_ANY_ORDER, 
                false
            )

            for _, unit in ipairs(All) do
                print(unit:GetUnitName(), unit:GetSpawnGroupHandle(), unit)
            end
        end

        if szText == "-pds" then
            if Creeps.DeleteSchedule ~= nil then
                for _, UnitInfo in ipairs(Creeps.DeleteSchedule) do
                    print(UnitInfo.unit_name, UnitInfo.spawngroup, UnitInfo.unit)
                end
            end
        end

        if szText == "-gw" then
            Players:MakeTeamWin(2)
        end

        if szText == "-wb" then
            HeroBuilder:UpdateMinigamesWins(0, 1)
        end
        if szText == "-wbm" then
            HeroBuilder:UpdateMinigamesWins(0, -1)
        end

        if szText == "-tgn" then
            NeutralItems:GiveNeutral(1)
            NeutralItems:OnPlayerCraftNeutralItem({PlayerID = 1, item = "item_trusty_shovel", enchant = "item_enhancement_mystical"})
            NeutralItems:ClearNeutral(1)
        end

        if szText == "-tpvp" then
            CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowPvpBet", {players={{playerID=0, teamID=2},{playerID=1, teamID=3}},firstTeamId=2,secondTeamId=3} )
        end

        if szText == "-tdm" then
            CustomNetTables:SetTableValue("players", "player_0_duel_info", {
                bCanBeShowed = true,
                LastTime = GameRules:GetGameTime()+10,
                EnemyPlayerID = 1,
            })
        end

        if szText == "-tb" then
            local PlayerInfo = Players:GetPlayer(0)
            if PlayerInfo then
                table.insert(PlayerInfo.bet_history, {
                    winner_team = 2,
                    loser_team = 3,
                    winners = {{PlayerID = 0, TeamID = 2}},
                    losers = {{PlayerID = 1, TeamID = 3}},
                    value = 300
                })

                Players:UpdatePlayerNetTable(0)
            end
        end

        if szText == "-tb2" then
            local PlayerInfo = Players:GetPlayer(0)
            if PlayerInfo then
                table.insert(PlayerInfo.bet_history, {
                    winner_team = 3,
                    loser_team = 2,
                    winners = {{PlayerID = 1, TeamID = 3}},
                    losers = {{PlayerID = 0, TeamID = 2}},
                    value = -300
                })

                Players:UpdatePlayerNetTable(0)
            end
        end

        if szText == "-pt" then
            DeepPrintTable(Map.UnitsTriggerData)
        end

        if szText == "-tbv" then
            Votes:OnPlayerVoted({PlayerID = 1, VoteName = "ROUND_MODE", Option = 0})
        end

        if szText == "-vs" then
            Votes:CreateVote("ROUND_MODE")
        end

        if szText == "-vh" then
            Votes:ClearVote("ROUND_MODE")
        end

        if szText == "-ng" then
            NeutralItems:GiveNeutral(nPlayerId)
        end

        if szText == "-nr" then
            NeutralItems:ClearNeutral(nPlayerId)
        end

        if szText == "-nu" then
            NeutralItems:IncreaseNeutralTier(nPlayerId)
        end

        if string.sub(szText, 1, 4) == "-tpc" then
            local Code = string.sub(szText, 6, string.len(szText))
            Server:OnPlayerAttemptUsePromocode({PlayerID=nPlayerId, code=Code})
        end

        local Splitted = string.split(szText, " ")
        if #Splitted > 0 and Splitted[1] == "-bg" then
            local PID = Splitted[2]
            local Gold = Splitted[3]
            if Gold ~= nil and PID ~= nil then
                local Num = tonumber(Gold)
                local PIDNUM = tonumber(PID)

                if Num ~= nil and PIDNUM ~= nil then
                    Players:ModifyPlayerNetworth(PIDNUM, Num)
                end
            end
        end

        if szText == "-end_table" then
            Server:CreatePlayerData(0, 1)
            GameRules:SetGameWinner(2)
        end

        if szText == "-buy_battle_pass" then
            Server:OnAttemptBuyBattlePass(0, 30, 250)
        end

        if szText == "-spawngroups" then
            print(GetActiveSpawnGroupHandle())
        end

        if szText == "-tra" then
            HeroBuilder:RemoveAbility(1, Players:GetPlayer(1).hero:GetAbilityByIndex(0):GetAbilityName())
        end

        -- if string.match(szText, "^%-[r|R][o|O][u|U][n|N][d|D]%d+") ~= nil then
        --     local nRoundNumber = string.match(szText, "%d+")
        --     if GameMode.currentRound then GameMode.currentRound:End() end
        --     GameMode.currentRound = Round()
        --     GameMode.currentRound:Prepare(tonumber(nRoundNumber))
        -- end

        if szText == "-panel" then
            CustomUI:DynamicHud_Create( nPlayerId, "Hero_Demo", "file://{resources}/layout/custom_game/hud_hero_demo/hud_hero_demo.xml", nil )
        end

        if szText == "-abilities" then
            for i=0,hero:GetAbilityCount()-1 do
                local ability_name = hero:GetAbilityByIndex(i)
                if ability_name then
                    print(i, ability_name:GetAbilityName(), "can be enabled:", ability_name:IsShouldEnabledInSwap())
                    print(ability_name:PrintBehaviorFlags())
                end
            end
        end

        if szText == "-reconnect" then
            GameMode:OnPlayerReconnected({PlayerID = nPlayerId})
        end

        if szText == "-mods" then
            for _, mod in pairs(hero:FindAllModifiers()) do
                print(mod:GetName())
            end
        end
        
        if string.find(szText, "other_") == 1 then
            local sAbilityName = string.sub(szText, 7, string.len(szText))
            local AbilityInfo2 = KeyValues.AbilitiesList[sAbilityName]
            if AbilityInfo2 then
                for i = 0, 10 do
                    if (i ~= nPlayerId) then
                        local hOtherHero =
                            PlayerResource:GetSelectedHeroEntity(i)
                        if hOtherHero then
                            HeroBuilder:AddAbility(i, sAbilityName)
                            hOtherHero.nAbilityNumber =
                                hOtherHero.nAbilityNumber + 1
                            table.insert(hOtherHero.abilitiesList, sAbilityName)
                        end
                    end
                end
            end
        end

        if string.find(szText, "npc_dota_hero_") == 1 then
            hero = PlayerResource:ReplaceHeroWith(nPlayerId, szText, hero:GetGold(), 0)
            HeroBuilder:InitPlayerHero(hero)
        end
        
        -- Команда -allstop для управления крипами
        if szText == "-allstop" then
            self.allStopActive = true
            
            if self.allStopActive then
                -- Получаем информацию о всех аренах игроков
                self.playerArenas = {}
                local allTeams = Players:GetAllTeams(true)
                
                -- Собираем информацию о центрах арен для каждой команды
                for _, teamID in ipairs(allTeams) do
                    local teamInfo = Players:GetTeam(teamID)
                    if teamInfo and teamInfo.arena then
                        local arenaInfo = Map:GetArenaInfo(teamInfo.arena)
                        if arenaInfo and arenaInfo.center then
                            self.playerArenas[teamID] = arenaInfo.center
                        end
                    end
                end
                
                -- Если не нашли ни одной арены игроков, используем основную арену
                if table.count(self.playerArenas) == 0 then
                    local mainArenaInfo = Map:GetArenaInfo("MAIN")
                    if mainArenaInfo then
                        self.playerArenas["default"] = mainArenaInfo.center
                    else
                        GameRules:SendCustomMessage("Ошибка: не удалось найти информацию об аренах.", 0, 0)
                        return
                    end
                end
                
                -- Добавляем модификатор всем крипам
                local allCreeps = FindUnitsInRadius(
                    DOTA_TEAM_NEUTRALS,
                    Vector(0,0,0),
                    nil,
                    FIND_UNITS_EVERYWHERE,
                    DOTA_UNIT_TARGET_TEAM_BOTH,
                    DOTA_UNIT_TARGET_BASIC,
                    DOTA_UNIT_TARGET_FLAG_NONE,
                    FIND_ANY_ORDER,
                    false
                )
                
                local creepCount = 0
                for _, creep in pairs(allCreeps) do
                    if creep and not creep:IsNull() and creep:IsAlive() then
                        -- Определяем, к какой арене относится крип
                        local creepPos = creep:GetAbsOrigin()
                        local creepArena = Map:GetPositionArena(creepPos)
                        local targetPos = nil
                        
                        -- Если крип находится на арене игрока, отправляем его в центр этой арены
                        if creepArena and self.playerArenas[creepArena] then
                            targetPos = self.playerArenas[creepArena]
                        else
                            -- Если не можем определить арену крипа, отправляем его на ближайшую арену
                            local closestDist = 999999
                            local closestArena = nil
                            
                            for _, centerPos in pairs(self.playerArenas) do
                                local dist = (creepPos - centerPos):Length2D()
                                if dist < closestDist then
                                    closestDist = dist
                                    closestArena = centerPos
                                end
                            end
                            
                            if closestArena then
                                targetPos = closestArena
                            elseif self.playerArenas["default"] then
                                targetPos = self.playerArenas["default"]
                            end
                        end
                        
                        if targetPos then
                            -- Отправляем крипа в центр соответствующей арены
                            ExecuteOrderFromTable({
                                UnitIndex = creep:entindex(),
                                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                                Position = targetPos,
                                Queue = false
                            })
                            
                            -- Сохраняем целевую позицию для крипа
                            creep.allStopTargetPos = targetPos
                            
                            -- Останавливаем AI крипа
                            creep.allStopActive = true
                            creepCount = creepCount + 1
                        end
                    end
                end
                
                GameRules:SendCustomMessage("Команда -allstop АКТИВИРОВАНА. Крипы (" .. creepCount .. ") направляются в центры арен.", 0, 0)
            else
                -- Деактивируем режим -allstop
                local allCreeps = FindUnitsInRadius(
                    DOTA_TEAM_NEUTRALS,
                    Vector(0,0,0),
                    nil,
                    FIND_UNITS_EVERYWHERE,
                    DOTA_UNIT_TARGET_TEAM_BOTH,
                    DOTA_UNIT_TARGET_BASIC,
                    DOTA_UNIT_TARGET_FLAG_NONE,
                    FIND_ANY_ORDER,
                    false
                )
                
                local creepCount = 0
                for _, creep in pairs(allCreeps) do
                    if creep and not creep:IsNull() and creep:IsAlive() then
                        -- Возвращаем крипу нормальное поведение
                        creep.allStopActive = false
                        creep.allStopTargetPos = nil
                        creep.reachedCenter = false
                        creepCount = creepCount + 1
                    end
                end
                
                GameRules:SendCustomMessage("Команда -allstop ДЕАКТИВИРОВАНА. Крипы (" .. creepCount .. ") вернулись к обычному поведению.", 0, 0)
            end
        end
        
        -- Команда -allstart для деактивации режима -allstop
        if szText == "-allstart" then
            -- Проверяем, активен ли режим -allstop
            if self.allStopActive then
                self.allStopActive = false
                
                -- Деактивируем режим -allstop
                local allCreeps = FindUnitsInRadius(
                    DOTA_TEAM_NEUTRALS,
                    Vector(0,0,0),
                    nil,
                    FIND_UNITS_EVERYWHERE,
                    DOTA_UNIT_TARGET_TEAM_BOTH,
                    DOTA_UNIT_TARGET_BASIC,
                    DOTA_UNIT_TARGET_FLAG_NONE,
                    FIND_ANY_ORDER,
                    false
                )
                
                local creepCount = 0
                for _, creep in pairs(allCreeps) do
                    if creep and not creep:IsNull() and creep:IsAlive() then
                        -- Возвращаем крипу нормальное поведение
                        creep.allStopActive = false
                        creep.allStopTargetPos = nil
                        creep.reachedCenter = false
                        creepCount = creepCount + 1
                    end
                end
                
                GameRules:SendCustomMessage("Команда -allstart АКТИВИРОВАНА. Крипы (" .. creepCount .. ") вернулись к обычному поведению.", 0, 0)
            else
                GameRules:SendCustomMessage("Режим -allstop не активен. Используйте сначала команду -allstop.", 0, 0)
            end
        end

        if not GameRules:IsCheatMode() then
            if szText == "-respawn" then
                hero:RespawnHero(false, false)
            end
            if szText == "-suicide" then
                hero:Kill(nil, hero)
            end
            if string.match(szText, "^%-[l|L][v|V][l|L][u|U][p|P]%d+") ~= nil then
                local number = string.match(szText, "%d+")
                for i=1, tonumber(number) do
                    hero:HeroLevelUp(false)
                end
            end
            if string.match(szText, "^%-[g|G][o|O][l|L][d|D]%d+") ~= nil then
                local number = string.match(szText, "%d+")
                hero:ModifyGold(tonumber(number), true, 0)
            end
            if szText == "-refresh" then
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
        end
    end
    
    -- Команда для отладки слотов (работает только в cheat mode)
    if GameRules:IsCheatMode() and (szText == "-itemslots" or szText == "-slots") then
        print("=== ITEM SLOTS DEBUG for " .. hero:GetUnitName() .. " ===")
        print("SLOT CONSTANTS: MAIN=0-5, BACKPACK=6-8, STASH=9-14, NEUTRAL=16")
        print("Has Techies Stash: " .. (hero:HasAbility("techies_spoons_stash_custom") and "YES" or "NO"))
        print("")
        
        -- Основные слоты (0-5)
        for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
            local item = hero:GetItemInSlot(i)
            if item then
                print(string.format("Slot %d (MAIN): %s | State: %d | HasModifier: %s", 
                    i, 
                    item:GetAbilityName(), 
                    item:GetItemState(),
                    hero:HasModifier("modifier_" .. item:GetAbilityName()) and "YES" or "NO"
                ))
            else
                print(string.format("Slot %d (MAIN): EMPTY", i))
            end
        end
        
        -- Слоты рюкзака (6-8) / Techies дополнительные слоты (7-8)
        for i = DOTA_ITEM_SLOT_7, DOTA_ITEM_SLOT_9 do
            local item = hero:GetItemInSlot(i)
            if item then
                print(string.format("Slot %d (BACKPACK/TECHIES): %s | State: %d | HasModifier: %s", 
                    i, 
                    item:GetAbilityName(), 
                    item:GetItemState(),
                    hero:HasModifier("modifier_" .. item:GetAbilityName()) and "YES" or "NO"
                ))
            else
                print(string.format("Slot %d (BACKPACK/TECHIES): EMPTY", i))
            end
        end
        
        -- Нейтральный слот (16)
        local item_neutral = hero:GetItemInSlot(16)
        if item_neutral then
            print(string.format("Slot %d (NEUTRAL): %s | State: %d | HasModifier: %s", 
                16, 
                item_neutral:GetAbilityName(), 
                item_neutral:GetItemState(),
                hero:HasModifier("modifier_" .. item_neutral:GetAbilityName()) and "YES" or "NO"
            ))
        else
            print(string.format("Slot %d (NEUTRAL): EMPTY", 16))
        end
        
        -- Слоты стэша (9-14)
        for i = DOTA_STASH_SLOT_1, DOTA_STASH_SLOT_6 do
            local item = hero:GetItemInSlot(i)
            if item then
                print(string.format("Slot %d (STASH): %s | State: %d | HasModifier: %s", 
                    i, 
                    item:GetAbilityName(), 
                    item:GetItemState(),
                    hero:HasModifier("modifier_" .. item:GetAbilityName()) and "YES" or "NO"
                ))
            end
        end
        
        print("=== END ITEM SLOTS DEBUG ===")
    end
end