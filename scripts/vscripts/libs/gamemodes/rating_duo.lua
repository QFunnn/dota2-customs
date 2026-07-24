--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


------ Дуо
-- Запуск дуэли
function arena_system:StartDuelDuo()
	-- Переменные для дуэлей
	DUEL_ACTIVE = true
	DUEL_STARTED = true

	-- Если нет участников дуэли то мнгновенно ее закончить нужно
	if player_system.DUEL_PLAYERS == nil or #player_system.DUEL_PLAYERS < 2 then
		DUEL_ACTIVE = false
		DUEL_STARTED = false
		if DUEL_TIMER ~= nil then 
			Timers:RemoveTimer(DUEL_TIMER)
		end
		for id, betid in pairs(DUEL_PREDICT_PLAYERS) do
			CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playersbet", player_id = id, data = {bet = nil}})
		end
		DUEL_PREDICT_PLAYERS = {}
        CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "visibleicon", data = {visible = "false"}})
		return
	end

	-- Если один из участников дуэли отсутствует в таблице каким-то образом
	if (player_system.DUEL_PLAYERS[1] == nil or player_system.DUEL_PLAYERS[2] == nil) then
		DUEL_ACTIVE = false
		DUEL_STARTED = false
		if DUEL_TIMER ~= nil then 
			Timers:RemoveTimer(DUEL_TIMER)
		end
		for id,betid in pairs(DUEL_PREDICT_PLAYERS) do
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playersbet", player_id = id, data = {bet = nil}})
		end
		DUEL_PREDICT_PLAYERS = {}
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "visibleicon", data = {visible = "false"}})
		return
	end

	local players_connected_team_1 = false
	local players_connected_team_2 = false

	for _, player_id in pairs(player_system.DUEL_PLAYERS[1].players) do
		if PlayerResource:GetConnectionState(player_id) ~= DOTA_CONNECTION_STATE_ABANDONED or (PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_NOT_YET_CONNECTED and PlayerResource:IsFakeClient(player_id)) then
			players_connected_team_1 = true
		end
	end

	for _, player_id in pairs(player_system.DUEL_PLAYERS[2].players) do
		if PlayerResource:GetConnectionState(player_id) ~= DOTA_CONNECTION_STATE_ABANDONED or (PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_NOT_YET_CONNECTED and PlayerResource:IsFakeClient(player_id)) then
			players_connected_team_2 = true
		end
	end

	if not players_connected_team_1 or not players_connected_team_2 then
		DUEL_ACTIVE=false
		DUEL_STARTED=false
		if DUEL_TIMER ~= nil then 
			Timers:RemoveTimer(DUEL_TIMER)
		end
		for id,betid in pairs(DUEL_PREDICT_PLAYERS) do
			CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playersbet", player_id = id, data = {bet = nil}})
		end
		DUEL_PREDICT_PLAYERS = {}
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "visibleicon", data = {visible = "false"}})
		return
	end

	-- Если участники дуэли все таки есть, то выдаем ставки людям на выбранного героя
	if DUEL_PREDICT_PLAYERS then
		for id,betid in pairs(DUEL_PREDICT_PLAYERS) do 
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playersbet", player_id = id, data = {bet = betid}})
		end
	end

	-- Все игроки заполнение
	local players_heroes = {}
	for _, team_info in pairs(player_system.DUEL_PLAYERS) do
		for __, player_id in pairs(team_info.players) do
			table.insert(players_heroes, player_id)
		end
	end

	for i=#players_heroes,1,-1 do
		if players_heroes[i] == nil or player_system:IsLose(players_heroes[i]) or PlayerResource:GetConnectionState(players_heroes[i]) == DOTA_CONNECTION_STATE_ABANDONED then
			table.remove(players_heroes, i)
		end
	end

	if #players_heroes <= 0 then
		DUEL_ACTIVE=false
		DUEL_STARTED=false
		if DUEL_TIMER ~= nil then 
			Timers:RemoveTimer(DUEL_TIMER)
		end
		for id,betid in pairs(DUEL_PREDICT_PLAYERS) do
			CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playersbet", player_id = id, data = {bet = nil}})
		end
		DUEL_PREDICT_PLAYERS = {}
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "visibleicon", data = {visible = "false"}})
		return
	end

	-- Поиск поинтов и телепортация их на арены
	local points = 
	{
		"duelarena1",
		"duelarena2",
		"duelarena3",
		"duelarena4"
	}

	for _, player_id in pairs(players_heroes) do
		local player_hero = player_system:GetHero(player_id)
		player_system:SetDuel(player_id, true)
		if player_hero and not player_hero:IsNull() and player_hero:IsAlive() then
			player_hero:RemoveModifierByName("modifier_wodarelax")
			player_hero:RemoveModifierByName("modifier_fountain_invulnerability")
			player_hero:ResetCooldown()
			if player_hero.bear and not player_hero.bear:IsNull() and player_hero.bear:IsAlive() then
				player_hero.bear:ForceKill(false)
			end
		end
		local point_spawn = Entities:FindByName(nil, table.remove(points,RandomInt(1, #points)))
		if point_spawn then
			FindClearSpaceForUnit(player_hero, point_spawn:GetAbsOrigin(), true)
			player_hero:SetCamera(player_hero)
			player_hero:SetUnit(player_hero)
		end
		if player_hero and not player_hero:IsNull()  and player_hero:IsAlive() then
			player_hero:AddNewModifier(player_hero, nil, "modifier_wodaduel_duo", {})
		end
		CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(player_id), "event_new_area_duel", {} )
	end

	arena_system:SetMinimapForAllChoose(2)
	SetCustomTimeOfDay(0.5)

	-- Даем вижен командам в центр дуэли
	for team=2,13 do 
		if team ~= player_system.DUEL_PLAYERS[1].teamnumber and team ~= player_system.DUEL_PLAYERS[2].teamnumber then 
			AddFOWViewer(team, Vector(-1760,-1792,0), 2500, 1.1, false)
		end
	end

	-- Запускаем таймер дуэли с проверками
	local time = DUEL_DURATION
	CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time = time, full_time = DUEL_DURATION})
	DUEL_TIMER=Timers:CreateTimer(1, function()
		time = time - 1
        if time == DUEL_DURATION / 2 then
            SetCustomTimeOfDay(0.8)
        end
		for team=2,13 do 
			if team ~= player_system.DUEL_PLAYERS[1].teamnumber and team ~= player_system.DUEL_PLAYERS[2].teamnumber then 
				AddFOWViewer(team, Vector(-1760,-1792,0), 2500, 1.1, false)
			end
		end
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time=time,full_time=DUEL_DURATION})
		if time <= 0 then
			self:EndDuelDuo(true)
			return
		end
		return 1
	end)
end

-- Окончание дуэли
function arena_system:EndDuelDuo(is_timer)
	if not DUEL_ACTIVE then return end
	local team_win = nil
    local team_1_is_alive = 0
    local team_2_is_alive = 0
    local team_1_health = 0
    local team_2_health = 0
    local team_1_health_percent = 0
    local team_2_health_percent = 0
    -- Подсчет живых героев
    for _, player_id in pairs(player_system.DUEL_PLAYERS[1].players) do
        local hero = player_system:GetHero(player_id)
        if hero and not hero:IsNull() and (hero:IsAlive() or hero:IsReincarnating()) then
            team_1_is_alive = team_1_is_alive + 1
        end
    end
    for _, player_id in pairs(player_system.DUEL_PLAYERS[2].players) do
        local hero = player_system:GetHero(player_id)
        if hero and not hero:IsNull() and (hero:IsAlive() or hero:IsReincarnating()) then
            team_2_is_alive = team_2_is_alive + 1
        end
    end
    -- Если прям у команды все умерли
    if team_1_is_alive <= 0 then
        team_win = player_system.DUEL_PLAYERS[2].teamnumber
    elseif team_2_is_alive <= 0 then
        team_win = player_system.DUEL_PLAYERS[1].teamnumber
    end
    -- Проверка по окончанию времени
    if team_win == nil and is_timer then
        for _, player_id in pairs(player_system.DUEL_PLAYERS[1].players) do
            local hero = player_system:GetHero(player_id)
            if hero and not hero:IsNull() and (hero:IsAlive() or hero:IsReincarnating()) then
                team_1_health = team_1_health + hero:GetHealth()
                team_1_health_percent = team_1_health_percent + hero:GetHealthPercent()
            end
        end
        for _, player_id in pairs(player_system.DUEL_PLAYERS[2].players) do
            local hero = player_system:GetHero(player_id)
            if hero and not hero:IsNull() and (hero:IsAlive() or hero:IsReincarnating()) then
                team_2_health = team_2_health + hero:GetHealth()
                team_2_health_percent = team_2_health_percent + hero:GetHealthPercent()
            end
        end
        if team_1_is_alive > team_2_is_alive then
            team_win = player_system.DUEL_PLAYERS[1].teamnumber
        elseif team_2_is_alive > team_1_is_alive then
            team_win = player_system.DUEL_PLAYERS[2].teamnumber
        elseif team_1_is_alive == team_2_is_alive then
            if team_1_health_percent > team_2_health_percent then
                team_win = player_system.DUEL_PLAYERS[1].teamnumber
            elseif team_2_health_percent > team_1_health_percent then
                team_win = player_system.DUEL_PLAYERS[2].teamnumber
            elseif team_1_health_percent == team_2_health_percent then
                if team_1_health > team_2_health then
                    team_win = player_system.DUEL_PLAYERS[1].teamnumber
                elseif team_2_health >= team_1_health then
                    team_win = player_system.DUEL_PLAYERS[2].teamnumber
                end
            end
        end
    end
    if team_win == nil then return end
    
	DUEL_ACTIVE = false
	DUEL_STARTED = false

	if DUEL_TIMER ~= nil then 
		Timers:RemoveTimer(DUEL_TIMER)
	end

	-- Находим игроков что были на дуэли
	local players_in_duel = {}
    local winners = {}
    local losers = {}

    for id, info in pairs(PLAYERS) do
        if player_system:IsDuel(id) or player_system:IsDuelEnd(id) then
            table.insert(players_in_duel, id)
        end
    end

    -- сначала разделяем победителей и проигравших
    for _, id in pairs(players_in_duel) do
        local hero = player_system:GetHero(id)
        if hero then
            if hero:GetTeamNumber() == team_win then
                table.insert(winners, id)
            else
                table.insert(losers, id)
            end
        end
    end

    -- объединяем: сначала победители, потом проигравшие
    for _, id in ipairs(losers) do
        table.insert(winners, id)
    end

    -- основной проход
    for _, id in ipairs(winners) do
        local hero = player_system:GetHero(id)

        if hero:GetTeamNumber() ~= team_win then
            player_system:SetDuel(id, false)
            player_system:SetLoseDuo(id)

            local wardmodifier = hero:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
            if wardmodifier then
                wardmodifier:GetAbility():SetCurrentCharges(3)
                wardmodifier:GetAbility():SetSecondaryCharges(3)
            end

            if hero.fake_dazzle then
                local wardmodifier_dazzle = hero.fake_dazzle:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
                if wardmodifier_dazzle then
                    wardmodifier_dazzle:GetAbility():SetCurrentCharges(3)
                    wardmodifier_dazzle:GetAbility():SetSecondaryCharges(3)
                end
            end

            hero:RemoveModifierByName("modifier_wodaduel_duo")
            player_system:CheckAttributeQuest(id, 13, 35, 57, 79)

            if is_timer then
                hero:AddNewModifier(hero, nil, "modifier_wodarelax_invul", {duration = 2})
            end

            hero:RemoveAllUnitsOwnerPlayer()

        else
            hero:AddNewModifier(hero, nil, "modifier_wodarelax_invul", {duration = 2})
            player_system:SetDuel(id, false)
            hero:ResetHealthAndMana()
            hero:ResetCooldown()

            Timers:CreateTimer({
                endTime = 0.07,
                callback = function()
                    hero:RemoveModifierByName("modifier_wodaduel_duo")

                    local teleport_point = Entities:FindByName(nil, "relaxarena")
                    if teleport_point then
                        FindClearSpaceForUnit(hero, teleport_point:GetAbsOrigin(), true)
                    end

                    hero:AddNewModifier(hero, nil, "modifier_wodarelax", {})
                    hero:SetCamera(hero)
                    hero:SetUnit(hero)
                end
            })

            WodaTalents:AddPoint(id, 5)

            local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_OVERHEAD_FOLLOW, hero)
            ParticleManager:ReleaseParticleIndex(particle)

            hero:EmitSound("Hero_LegionCommander.Duel.Victory")

            local wardmodifier = hero:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
            if wardmodifier then
                wardmodifier:GetAbility():SetCurrentCharges(3)
                wardmodifier:GetAbility():SetSecondaryCharges(3)
            end

            if hero.fake_dazzle then
                local wardmodifier_dazzle = hero.fake_dazzle:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
                if wardmodifier_dazzle then
                    wardmodifier_dazzle:GetAbility():SetCurrentCharges(3)
                    wardmodifier_dazzle:GetAbility():SetSecondaryCharges(3)
                end
            end

            if PLAYERS[hero:GetPlayerOwnerID()] then
                PLAYERS[hero:GetPlayerOwnerID()].duel_streak = (PLAYERS[hero:GetPlayerOwnerID()].duel_streak or 0) + 1
                player_system:CheckAttributeQuest(hero:GetPlayerOwnerID(), 12, 34, 56, 78)
            end

            hero:RemoveAllUnitsOwnerPlayer()
        end
    end

	-- Раздаем награды победителям сюда + сюда
	if team_win ~= nil then 
		for id, betid in pairs(DUEL_PREDICT_PLAYERS) do
			if betid == team_win then
				WodaTalents:AddPoint(id, 8)
			end
		end
	end
	for id,betid in pairs(DUEL_PREDICT_PLAYERS) do
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playersbet", player_id = id, data = {bet = nil}})
	end
	DUEL_PREDICT_PLAYERS = {}
	CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "visibleicon", data = {visible = "false"}})
    arena_system:SetMinimapForAllChoose(1)
end

-- Последняя дуэль
function arena_system:StartEndDuelDuo()
	DUEL_ACTIVE=true
	DUEL_STARTED=true
	player_system.DUEL_PLAYERS = {}
    player_system.DUEL_PLAYERS = player_system:GetPlayerLastNetworthsTeam()

	-- Если нет участников дуэли то мнгновенно ее закончить нужно
	if player_system.DUEL_PLAYERS == nil or #player_system.DUEL_PLAYERS < 2 then
        arena_system:CloseAndEndGame()
		return
	end

    -- Если один из участников дуэли отсутствует в таблице каким-то образом
    if (player_system.DUEL_PLAYERS[1] == nil or player_system.DUEL_PLAYERS[2] == nil) then
        arena_system:CloseAndEndGame()
        return
    end

	local players_connected_team_1 = false
	local players_connected_team_2 = false

	for _, player_id in pairs(player_system.DUEL_PLAYERS[1].players) do
		if PlayerResource:GetConnectionState(player_id) ~= DOTA_CONNECTION_STATE_ABANDONED or (PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_NOT_YET_CONNECTED and PlayerResource:IsFakeClient(player_id)) then
			players_connected_team_1 = true
		end
	end

	for _, player_id in pairs(player_system.DUEL_PLAYERS[2].players) do
		if PlayerResource:GetConnectionState(player_id) ~= DOTA_CONNECTION_STATE_ABANDONED or (PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_NOT_YET_CONNECTED and PlayerResource:IsFakeClient(player_id)) then
			players_connected_team_2 = true
		end
	end

	if not players_connected_team_1 or not players_connected_team_2 then
        arena_system:CloseAndEndGame()
		return
	end

    -- Все игроки заполнение
    local players_heroes = {}
    for _, team_info in pairs(player_system.DUEL_PLAYERS) do
        for __, player_id in pairs(team_info.players) do
            table.insert(players_heroes, player_id)
        end
    end

	for i=#players_heroes,1,-1 do
		if players_heroes[i] == nil or player_system:IsLose(players_heroes[i]) or PlayerResource:GetConnectionState(players_heroes[i]) == DOTA_CONNECTION_STATE_ABANDONED then
			table.remove(players_heroes, i)
		end
	end

	if #players_heroes <= 0 then
        arena_system:CloseAndEndGame()
		return
	end

    -- Поиск поинтов и телепортация их на арены
    local points = 
    {
        "finalduelarena1",
        "finalduelarena2",
        "finalduelarena3",
        "finalduelarena4"
    }

    for _, player_id in pairs(players_heroes) do
		local player_hero = player_system:GetHero(player_id)
        player_system:SetDuelEnd(player_id, true)
        if player_hero and not player_hero:IsNull() then
            player_hero:ResetHealthAndMana()
            player_hero:ResetCooldown()
            player_hero:Stop()
        end
        Timers:CreateTimer({ endTime = 0.07, callback = function()
            if not player_hero:IsAlive() then
                return 0.07
            end
            if player_hero and not player_hero:IsNull() then
                player_hero:RemoveModifierByName("modifier_wodarelax")
                player_hero:RemoveModifierByName("modifier_wodaduel_duo")
                player_hero:RemoveModifierByName("modifier_wodawispdeath")
                player_hero:RemoveModifierByName("modifier_fountain_invulnerability")
                if player_hero.bear and not player_hero.bear:IsNull() and player_hero.bear:IsAlive() then
                    player_hero.bear:ForceKill(false)
                end
            end
            local spawn_point = Entities:FindByName(nil, table.remove(points,RandomInt(1, #points)))
            if spawn_point then
                FindClearSpaceForUnit(player_hero, spawn_point:GetAbsOrigin(), true)
			    player_hero:SetCamera(player_hero)
			    player_hero:SetUnit(player_hero)
			    player_hero:Stop()
                Timers:CreateTimer(0, function()
                    FindClearSpaceForUnit(player_hero, spawn_point:GetAbsOrigin(), true)
                    if not player_hero:IsAlive() then
                        return 0.1
                    end
                end)
            end
            player_hero:AddNewModifier(player_hero, nil, "modifier_wodaduel_duo", {end_duel = true})
        end})
	end

    arena_system:SetMinimapForAllChoose(3)

    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_score", key = "player_1", data = {score = FINAL_DUEL_POINTS[player_system.DUEL_PLAYERS[1].teamnumber], team = player_system.DUEL_PLAYERS[1].teamnumber}})
    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_score", key = "player_2", data = {score = FINAL_DUEL_POINTS[player_system.DUEL_PLAYERS[2].teamnumber], team = player_system.DUEL_PLAYERS[2].teamnumber}})

	local time = LASTDUEL_DURATION
    SetCustomTimeOfDay(0.5)
	CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time=time, full_time=LASTDUEL_DURATION})
	DUEL_TIMER=Timers:CreateTimer(1, function()
		time = time - 1
        if time == math.floor(LASTDUEL_DURATION / 2) then
            SetCustomTimeOfDay(0.8)
        end
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time=time, full_time=LASTDUEL_DURATION, })
		if time <= 0 then
			self:EndGameDuo(true)
			return
		end
		return 1
	end)
end

function arena_system:EndGameDuo(is_timer)
	if not DUEL_ACTIVE then return end
	local team_win = nil
    local team_1_is_alive = 0
    local team_2_is_alive = 0
    local team_1_health = 0
    local team_2_health = 0
    local team_1_health_percent = 0
    local team_2_health_percent = 0
    -- Подсчет живых героев
    for _, player_id in pairs(player_system.DUEL_PLAYERS[1].players) do
        local hero = player_system:GetHero(player_id)
        if hero and not hero:IsNull() and (hero:IsAlive() or hero:IsReincarnating()) then
            team_1_is_alive = team_1_is_alive + 1
        end
    end
    for _, player_id in pairs(player_system.DUEL_PLAYERS[2].players) do
        local hero = player_system:GetHero(player_id)
        if hero and not hero:IsNull() and (hero:IsAlive() or hero:IsReincarnating()) then
            team_2_is_alive = team_2_is_alive + 1
        end
    end
    -- Если прям у команды все умерли
    if team_1_is_alive <= 0 then
        team_win = player_system.DUEL_PLAYERS[2].teamnumber
    elseif team_2_is_alive <= 0 then
        team_win = player_system.DUEL_PLAYERS[1].teamnumber
    end
    -- Проверка по окончанию времени
    if team_win == nil and is_timer then
        for _, player_id in pairs(player_system.DUEL_PLAYERS[1].players) do
            local hero = player_system:GetHero(player_id)
            if hero and not hero:IsNull() and (hero:IsAlive() or hero:IsReincarnating()) then
                team_1_health = team_1_health + hero:GetHealth()
                team_1_health_percent = team_1_health_percent + hero:GetHealthPercent()
            end
        end
        for _, player_id in pairs(player_system.DUEL_PLAYERS[2].players) do
            local hero = player_system:GetHero(player_id)
            if hero and not hero:IsNull() and (hero:IsAlive() or hero:IsReincarnating()) then
                team_2_health = team_2_health + hero:GetHealth()
                team_2_health_percent = team_2_health_percent + hero:GetHealthPercent()
            end
        end
        if team_1_is_alive > team_2_is_alive then
            team_win = player_system.DUEL_PLAYERS[1].teamnumber
        elseif team_2_is_alive > team_1_is_alive then
            team_win = player_system.DUEL_PLAYERS[2].teamnumber
        elseif team_1_is_alive == team_2_is_alive then
            if team_1_health_percent > team_2_health_percent then
                team_win = player_system.DUEL_PLAYERS[1].teamnumber
            elseif team_2_health_percent > team_1_health_percent then
                team_win = player_system.DUEL_PLAYERS[2].teamnumber
            elseif team_1_health_percent == team_2_health_percent then
                if team_1_health > team_2_health then
                    team_win = player_system.DUEL_PLAYERS[1].teamnumber
                elseif team_2_health >= team_1_health then
                    team_win = player_system.DUEL_PLAYERS[2].teamnumber
                end
            end
        end
    end
    if team_win == nil then return end

	DUEL_ACTIVE=false

	if DUEL_TIMER ~= nil then 
		Timers:RemoveTimer(DUEL_TIMER)
	end

	-- Находим игроков, что были на дуэли
    local players_in_duel = {}
    local winners = {}
    local losers = {}
    for id, info in pairs(PLAYERS) do
        if player_system:IsDuel(id) or player_system:IsDuelEnd(id) then
            table.insert(players_in_duel, id)
        end
    end

    -- Разделяем на победителей и проигравших
    for _, id in ipairs(players_in_duel) do
        local hero = player_system:GetHero(id)
        if hero then
            if hero:GetTeamNumber() == team_win then
                table.insert(winners, id)
            else
                table.insert(losers, id)
            end
        end
    end

    -- Сначала победители
    for _, id in ipairs(winners) do
        local hero = player_system:GetHero(id)
        hero:AddNewModifier(hero, nil, "modifier_wodarelax_invul", {duration = 3})
        hero:ResetHealthAndMana()
        if PLAYERS[hero:GetPlayerOwnerID()] then
            PLAYERS[hero:GetPlayerOwnerID()].duel_streak = (PLAYERS[hero:GetPlayerOwnerID()].duel_streak or 0) + 1
            player_system:CheckAttributeQuest(hero:GetPlayerOwnerID(), 12, 34, 56, 78)
        end
        hero:RemoveAllUnitsOwnerPlayer()
    end

    -- Потом проигравшие
    for _, id in ipairs(losers) do
        local hero = player_system:GetHero(id)
        hero:AddNewModifier(hero, nil, "modifier_wodarelax_invul", {duration = 3})
        player_system:CheckAttributeQuest(hero:GetPlayerOwnerID(), 13, 35, 57, 79)
        hero:RemoveAllUnitsOwnerPlayer()
    end
	
	if FINAL_DUEL_POINTS[team_win] == nil then
		FINAL_DUEL_POINTS[team_win] = 1
	else
		FINAL_DUEL_POINTS[team_win] = FINAL_DUEL_POINTS[team_win] + 1
	end

    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_score", key = "player_1", data = {score = FINAL_DUEL_POINTS[player_system.DUEL_PLAYERS[1].teamnumber], team = player_system.DUEL_PLAYERS[1].teamnumber}})
    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_score", key = "player_2", data = {score = FINAL_DUEL_POINTS[player_system.DUEL_PLAYERS[2].teamnumber], team = player_system.DUEL_PLAYERS[2].teamnumber}})

	if FINAL_DUEL_POINTS[team_win] >= 2 and not TEST_LAST_DUEL_ONLY then
		for id, info in pairs(PLAYERS) do
            local hero = info.hero
            if hero:GetTeamNumber() ~= team_win then
                if hero:GetTeamNumber() == player_system.DUEL_PLAYERS[1].teamnumber or hero:GetTeamNumber() == player_system.DUEL_PLAYERS[2].teamnumber then
                    player_system:SetLosePlayer(id)
                    PLAYERS[id].pause = 0
	                PLAYERS[id].place = 2
                    player_system:PlayerUnBanLeaved(id)
                end
            else
                PLAYERS[id].pause = 0
                PLAYERS[id].place = 1
                player_system:PlayerUnBanLeaved(id)
            end
        end 
        player_system:NetWorthUpdate()
        Timers:CreateTimer({ endTime = 0.1, callback = function()
            arena_system:CloseAndEndGame(team_win)
        end})
	else
        Timers:CreateTimer({ endTime = 3, callback = function()
		    self:StartEndDuelDuo()
        end})
	end
end

function arena_system:CloseAndEndGameDuo(winner)
	if winner == nil then
		for id, info in pairs(PLAYERS) do
			if not player_system:IsLose(id) and PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_CONNECTED then
				PLAYERS[id].place = 1
				winner = info.hero:GetTeamNumber()
			end
		end
	end

	for id, info in pairs(PLAYERS) do
		local player_items = {}
		if info.hero ~= nil then
			for i = 0, 18 do
				local item = info.hero:GetItemInSlot(i)
				local name = ""
				if item then
					name = item:GetName()
				end
				player_items[i] = name
			end
		end
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_items", player_id = id, data = player_items})
	end

    if hero_select.IsTournamentMode then
        local data_tournament = {}
        data_tournament["IsTournamentGame"] = true
        data_tournament["bans_counter"] = hero_select.BANS_COUNTER_SAVE
        if hero_select.IsRandomHeroes then
            data_tournament["random"] = true 
        end
        CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "tournament_data", data = data_tournament})
    end

    damage_system:EndGameUpdate()

	Timers:CreateTimer({ endTime = 0.1, callback = function()
        player_system:SendQuestToServer()
		player_system:SendDataToServer()
		player_system:SendDataPlayersHeroStats()
		player_system:SendDataPlayerReports()
	end})

	Timers:CreateTimer({ endTime = 0.25, callback = function()
        if arena_system.IS_GAME_END then return end
        arena_system.IS_GAME_END = true
		GameRules:SetGameWinner(winner)
	end})
end