--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function arena_system:Init()
	self:StartGame()
	self:CreepsInit()
end

function arena_system:StartGame()
	CreateModifierThinker(nil, nil, "modifier_events_thinker_woda", {}, Vector(0,0,0), DOTA_TEAM_NEUTRALS, false)
    SetCustomTimeOfDay(0.5)
	GameRules:ForceGameStart()
    local fillers = FindUnitsInRadius(2, Vector(0,0,0), nil, -1, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
	for _,filler in pairs(fillers) do 
		if filler:GetUnitName() == "npc_filler_woda" then
			filler:AddNewModifier(filler, nil, "modifier_ability_filler_woda", {})
		end
        if filler:GetUnitName() == "npc_dota_unit_twin_gate" then
            filler:AddNewModifier(filler, nil, "modifier_minimap_hidden", {})
        end
	end
	for id, player in pairs(PLAYERS) do 
		if player.hero ~= nil and not player.hero:IsNull() then
			player.hero:RemoveModifierByName("modifier_woda_stunned")
		end
	end
    if hero_select.IsTournamentMode then
        --CustomGameEventManager:Send_ServerToAllClients("notification_tournament_game", {})
    end
	if player_system.data_base_connected == false then
		CustomGameEventManager:Send_ServerToAllClients("notification_no_data_server", {server = "true"})
	elseif player_system:GetPlayerCountAll() < arena_system:GetMaxPlayersMode() then
		if string.find(GetMapName(), "rating") then
			CustomGameEventManager:Send_ServerToAllClients("notification_no_data_server", {server = "false"})
		end
	end
	CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name', {name="name_relax", })
	if GetMapName() == "rating" or GetMapName() == "rating_300" then
		for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
			if tonumber(player_info.has_report_kill) > 0 then
				CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(id), "notification_player_ban_die", {})
			end
		end
        player_system:DisconnectPlayerChecked(true)
	end
	Timers:CreateTimer(7, function()
		CustomGameEventManager:Send_ServerToAllClients("event_new_area_gamemode", {})
	end)
	local time = STARTGAME_DURATION
	Timers:CreateTimer(0, function()
		time = time-1
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time=time,full_time=STARTGAME_DURATION,relax=true, })
        if math.floor(time) == 3 then
            StartTeleportFXPlayers(3)
        end
		if time <= 0 then
            if TEST_LAST_DUEL_ONLY then
                self:StartEndDuel()
                return
            end
			self:StartArena()
			return
		end
        return 1
	end)
    Timers:CreateTimer(STARTGAME_DURATION+180, function()
        player_system:DisconnectPlayerChecked()
        player_system:DoubleTokenRelease()
    end)
end

-- Инициализация кэмпов крипов
function arena_system:CreepsInit()
	for arena_number,camp in pairs(NEUTRAL_CREEPS) do
		for trigger_name,creeps in pairs(camp) do
			for _, spawner in pairs(Entities:FindAllByClassname("npc_dota_neutral_spawner") or {}) do
                local trigger = Entities:FindByName(nil, trigger_name)
                if spawner and trigger then
                    if (spawner:GetAbsOrigin() - trigger:GetAbsOrigin()):Length2D() < 300 then
                        ARENA_CREEPSSPAWNPOINT[trigger:GetName()] = spawner:GetAbsOrigin()
                        ARENA_CREEPSSPAWNPOINTFORWARD[trigger:GetName()] = spawner:GetForwardVector()
                        UTIL_Remove(spawner)
                        break
                    end
                end
            end
        end
    end
end

-- Спавн босса
function arena_system:SpawnBoss()
	local time = 180
	Timers:CreateTimer(1,function()
		if CURRENT_ARENA == 3 or CURRENT_ARENA == 5 then 
			time = time-1
			if time == 31 then 
				CustomGameEventManager:Send_ServerToAllClients("notification_boss_spawn", {appear = "true"})
			end
			if time == 1 then 
				CustomGameEventManager:Send_ServerToAllClients("notification_boss_spawn", {appear = "false"})
			end
			if time <= 0 then
                local stages_counter = 3
				local point = Entities:FindByName(nil, "spawnboss_"..CURRENT_ARENA)
                if CURRENT_ARENA == 5 then
                    stages_counter = 5
                    point = Entities:FindByName(nil, "spawnboss_"..CURRENT_ARENA.."_"..RandomInt(1, 2))
                end
				if point then 
					local boss = CreateUnitByName("boss_"..CURRENT_ARENA, point:GetAbsOrigin(), false, nil, nil, 4)
					if boss then
                        boss:AddNewModifier(boss, nil, "modifier_boss_low_health", {stages = stages_counter})
						boss:AddNewModifier(boss, nil, "modifier_woda_boss_bar", {duration=179})
						boss:SetForwardVector(point:GetForwardVector())
						boss:SetMinimumGoldBounty(0)
						boss:SetMaximumGoldBounty(0)
						boss:SetDeathXP(0)
						boss.boss = true
                        table.insert(ARENA_CREEPSTABLE, boss)
					end
					return
				end
			end
			return 1
		end
	end)
end

-- Старт арены из релакса
function arena_system:StartArena()
	local current_arena = CURRENT_ARENA
	CURRENT_MINIMAP = CURRENT_ARENA + 1

	-- Отключение дуэлей так как началась арена
	DUEL_ACTIVE = false
	DUEL_STARTED = false

	-- Если была сыграна последняя арена и эта осталась последней то все
	if current_arena > #ARENA_SPAWN_POINTS then 
		arena_system:CloseAndEndGame()
		return
	end

	arena_system:SetMinimapAll()

	-- Запуск функций арены
	CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name', {name="name_arena_"..CURRENT_ARENA, })
	self:StartSpawn()
	if CURRENT_ARENA == 3 or CURRENT_ARENA == 5 then 
		self:SpawnBoss()
	end
    if CURRENT_ARENA == 6 then
        CreateUnitByName("npc_dota_xp_granter_arena6", Vector(-1792.72, 7933.44, 320), false, nil, nil, DOTA_TEAM_NEUTRALS)
    end
	self:StartRune()

    local shrine_arena = Entities:FindAllByName("shrine_arena_"..current_arena)
    for _, shrine in pairs(shrine_arena) do
        local modifier_ability_filler_woda = shrine:FindModifierByName("modifier_ability_filler_woda")
        if modifier_ability_filler_woda then
            modifier_ability_filler_woda:SetStackCount(1)
        end
    end

    if CURRENT_ARENA == 4 then
        local fillers = FindUnitsInRadius(2, Vector(0,0,0), nil, -1, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
        for _,filler in pairs(fillers) do 
            if filler:GetUnitName() == "npc_dota_unit_twin_gate" then
                filler:RemoveModifierByName("modifier_minimap_hidden")
            end
        end
    end

	-- Телепортация игроков на арену
	for id, player in pairs(PLAYERS) do 
		if player.hero ~= nil and not player_system:IsLose(id) and not player.hero:IsNull() then
			local teleport_point = Entities:FindByName(nil, ARENA_SPAWN_POINTS[current_arena][RandomInt(1, #ARENA_SPAWN_POINTS[current_arena])])
			if teleport_point then
                local modifier_woda_handler_player = player.hero:FindModifierByName("modifier_woda_handler_player")
                if modifier_woda_handler_player then
                    modifier_woda_handler_player:FastUpdatePanel()
                end
				player.hero:ResetHealthAndMana()
				player.hero:ResetCooldown()

				Timers:CreateTimer({ endTime = 0.1, callback = function()
					if not player.hero:IsNull() and player.hero:IsAlive() then
		            	player.hero:RemoveModifierByName("modifier_wodarelax")
		            	if player.hero.bear and not player.hero.bear:IsNull() and player.hero.bear:IsAlive() then
		            		player.hero.bear:ForceKill(false)
		            	end
		            	--if not IsInToolsMode() then
                            CreateIllusions(player.hero, player.hero, {duration = FrameTime()}, 1, 1000, false, false) 
		            		player.hero:AddNewModifier(player.hero, nil, "modifier_wodawisp", {duration = WISP_DURATION})
		            	--end
						player.hero:AddNewModifier(player.hero, nil, "modifier_wisp_start_arena_stunned", {duration = STUNARENA_DURATION})
		            	FindClearSpaceForUnit(player.hero, teleport_point:GetAbsOrigin(), true)
						player.hero:SetCamera(player.hero, true)
						player.hero:SetUnit(player.hero)
                        local defuse_abuser_tick = 0
                        Timers:CreateTimer(0, function()
                            if defuse_abuser_tick >= 0.2 then return end
                            defuse_abuser_tick = defuse_abuser_tick + FrameTime()
                            FireGameEvent("woda_execute_console_command", {player_id = id, command = "+dota_camera_center_on_hero"})
                            FireGameEvent("woda_execute_console_command", {player_id = id, command = "-dota_camera_follow"})
                            return FrameTime()
                        end)
                        player.hero:Stop()

						if PlayerResource:GetPlayer(id) then 
							CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(id), "event_new_area", {arena=CURRENT_ARENA, })
						end
					else
						return 0.1
					end
		        end})
			end
		end
	end

	-- Запрет выхода за границы через 2 секунды после телепортации на арену
	ARENA_POSITION_TIMER = Timers:CreateTimer({ endTime = 2, callback = function()
		arena_system:ArenaPositionCheck()
		return 0.01
	end})


	-- Запуск отсчета времени арены + вызов ивентов по таймерам и после окончание арены
	local time = ARENA_DURATION

    SetCustomTimeOfDay(0.5)

	Timers:CreateTimer(0, function()
		time = time - 1
        if time == ARENA_DURATION / 2 then
            SetCustomTimeOfDay(0.8)
        end
		if time <= 90 then 
			CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "visibleicon", data = {visible = "true"}})
		end
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time = time, full_time = ARENA_DURATION, relax = false, duel = false})
		if math.floor(time) == 1 then
			for id,player in pairs(PLAYERS) do 
				if player.hero ~= nil and not player_system:IsLose(id) and not player.hero:IsNull() then
					player.hero:AddNewModifier(player.hero, nil, "modifier_wodarelax_invul", {duration = 2})
				end
			end
		end
        if math.floor(time) == 3 then
            StartTeleportFXPlayers(3)
        end
		if time<=0 then
			self:StartRelax()
			return
		end
        return 1
	end)
end

-- Старт релакса из арены
function arena_system:StartRelax()
	CURRENT_MINIMAP = 1

    local shrine_arena = Entities:FindAllByName("shrine_arena_"..CURRENT_ARENA)
    for _, shrine in pairs(shrine_arena) do
        local modifier_ability_filler_woda = shrine:FindModifierByName("modifier_ability_filler_woda")
        if modifier_ability_filler_woda then
            modifier_ability_filler_woda:SetStackCount(0)
        end
    end

    local fillers = FindUnitsInRadius(2, Vector(0,0,0), nil, -1, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
	for _,filler in pairs(fillers) do 
        if filler:GetUnitName() == "npc_dota_unit_twin_gate" then
            filler:AddNewModifier(filler, nil, "modifier_minimap_hidden", {})
        end
	end

	-- Очистка арены
	self:EndSpawn()
	-- Подготовка к дуэли
	DUEL_ACTIVE = true
	-- Удаляем целей охоты
    arena_system.HUNT_PLAYERS_LIST = {}
    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "huntplayers", data = {}})
	-- Меняем название арены на релакс
	CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name', {name="name_relax", })
	-- Раздаем случайные нейтралки
	neutrals_reward:SpawnRandomNeutrals(CURRENT_ARENA)
	-- Повышаем уровень следующей арены
	CURRENT_ARENA = CURRENT_ARENA+1

	arena_system:SetMinimapAll()
	
	-- Телепортируем героев с арены на релакс
	for id,player in pairs(PLAYERS) do 
		if player.hero ~= nil and not player_system:IsLose(id) and not player.hero:IsNull() then
			local teleport_point=Entities:FindByName(nil,"relaxarena")
			if teleport_point then 
				player.hero:ResetHealthAndMana()
				player.hero:ResetCooldown()
				Timers:CreateTimer({ endTime = 0.1, callback = function()
		            if not player.hero:IsNull() and player.hero:IsAlive() then
			            player.hero:RemoveModifierByName("modifier_wodahunt")
						FindClearSpaceForUnit(player.hero, teleport_point:GetAbsOrigin(), true)
						player.hero:AddNewModifier(player.hero, nil, "modifier_wodarelax", {})
						player.hero:SetCamera(player.hero)
						player.hero:SetUnit(player.hero)
					else
						return 0.1
					end
				end})
				local wardmodifier = player.hero:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
				if wardmodifier then 
					wardmodifier:GetAbility():SetCurrentCharges(3)
    				wardmodifier:GetAbility():SetSecondaryCharges(3)
				end
                if player.hero.fake_dazzle then
                    local wardmodifier_dazzle = player.hero.fake_dazzle:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
                    if wardmodifier_dazzle then
                        wardmodifier_dazzle:GetAbility():SetCurrentCharges(3)
                        wardmodifier_dazzle:GetAbility():SetSecondaryCharges(3)
                    end
                end
			end
		end
	end

	-- Отсчет времени до старта дуэли и начала арены
	local start_duel = true
	local timerelax = RELAX_DURATION
    if (GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300") and CURRENT_ARENA >= 7 then
        start_duel = false
        timerelax = 1
    end

	-- Очищаем и собираем игроков на дуэль
	player_system.DUEL_PLAYERS = {}
	if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        player_system.DUEL_PLAYERS = player_system:GetPlayerLastNetworthsTeam()
    else
        player_system.DUEL_PLAYERS = player_system:GetPlayerLastNetworths()
    end

	if GetMapName() == "rating" or GetMapName() == "rating_300" then
		-- Если есть массив с игроками и там больше двух игроков собралось, то запускаем окно с выбором дуэли
		if player_system.DUEL_PLAYERS and #player_system.DUEL_PLAYERS >= 2 then 
			CustomGameEventManager:Send_ServerToAllClients( 'wodaset_startduel', {player_id_1 = player_system.DUEL_PLAYERS[2].id, player_id_2=player_system.DUEL_PLAYERS[1].id, lose = arena_system:IsLoseDuel(), time_start = GameRules:GetGameTime(), time_end = (GameRules:GetGameTime() + timerelax) - 1.5})
		end
	end

    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
		-- Если есть массив с игроками и там больше двух игроков собралось, то запускаем окно с выбором дуэли
		if player_system.DUEL_PLAYERS and #player_system.DUEL_PLAYERS >= 2 then 
			CustomGameEventManager:Send_ServerToAllClients( 'wodaset_startduel_duo', {players_id_1 = player_system.DUEL_PLAYERS[2], players_id_2=player_system.DUEL_PLAYERS[1], lose = not arena_system:IsLoseDuel(), time_start = GameRules:GetGameTime(), time_end = (GameRules:GetGameTime() + timerelax) - 1.5})
		end
	end

	Timers:CreateTimer(0, function()
		timerelax = timerelax - 1

		-- Создаем таймер дуэли или таймер отсчета до начала арены
		if not DUEL_STARTED then 
			CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time=timerelax, full_time=RELAX_DURATION, relax=true, duel=false })
		else
			CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time=timerelax, full_time=RELAX_DURATION, relax=true, duel=true })
		end

        if start_duel then
		    -- Тикает время
            local is_lose = arena_system:IsLoseDuel()
            if string.find(GetMapName(), "rating_duo") then
                is_lose = not is_lose
            end
		    CustomGameEventManager:Send_ServerToAllClients( 'wodaset_dueltimer', {time = timerelax, full_time = 19, lose = is_lose})
        end

        if math.floor(timerelax) == 3 and start_duel and player_system.DUEL_PLAYERS and #player_system.DUEL_PLAYERS >= 2 then
            StartTeleportFXPlayers(3, player_system.DUEL_PLAYERS)
        end

		-- Если время до дуэли закончилось и игроки есть, то стартуем дуэль
		if timerelax <= 0 and start_duel then 
			start_duel = false
			if player_system.DUEL_PLAYERS and #player_system.DUEL_PLAYERS >= 2 then
                if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
                    self:StartDuelDuo() -- старт дуэли
                else
				    self:StartDuel() -- старт дуэли
                end
				CustomGameEventManager:Send_ServerToAllClients( 'wodaset_removeduel', {})
			end
		end

		if timerelax <= 0 then
			self:StartTimerToNextArena()
			return nil
		end

        return 1
	end)
end

function arena_system:StartTimerToNextArena()
	local time = RELAX_DURATION + 1

	local last_arena_notification = true

	Timers:CreateTimer(FrameTime(), function()
		if DUEL_STARTED == false then
			time = time - 1

			-- Создаем таймер дуэли или таймер отсчета до начала арены
			if not DUEL_STARTED then 
				CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time=time, full_time=RELAX_DURATION, relax=true, duel=false })
			else
				CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time=time, full_time=RELAX_DURATION, relax=true, duel=true })
			end

			if last_arena_notification and CURRENT_ARENA > 6 then
				last_arena_notification = false
				player_system.DUEL_PLAYERS = {}
                if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
                    player_system.DUEL_PLAYERS = player_system:GetPlayerLastNetworthsTeam()
                else
                    player_system.DUEL_PLAYERS = player_system:GetPlayerLastNetworths()
                end

                if GetMapName() == "rating" or GetMapName() == "rating_300" then
                    -- Если есть массив с игроками и там больше двух игроков собралось, то запускаем окно с выбором дуэли
                    if player_system.DUEL_PLAYERS and #player_system.DUEL_PLAYERS >= 2 then 
                        CustomGameEventManager:Send_ServerToAllClients( 'wodaset_startduel', {player_id_1 = player_system.DUEL_PLAYERS[2].id, player_id_2=player_system.DUEL_PLAYERS[1].id, lose = arena_system:IsLoseDuel()})
                    end
                end

                if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
                    -- Если есть массив с игроками и там больше двух игроков собралось, то запускаем окно с выбором дуэли
                    if player_system.DUEL_PLAYERS and #player_system.DUEL_PLAYERS >= 2 then 
                        CustomGameEventManager:Send_ServerToAllClients( 'wodaset_startduel_duo', {players_id_1 = player_system.DUEL_PLAYERS[2], players_id_2=player_system.DUEL_PLAYERS[1], lose = not arena_system:IsLoseDuel()})
                    end
                end
			end

			CustomGameEventManager:Send_ServerToAllClients( 'wodaset_dueltimer', {time=time, full_time=19})
            
            if math.floor(time) == 3 and CURRENT_ARENA <= 6 then
                StartTeleportFXPlayers(3)
            end

            if math.floor(time) == 3 and CURRENT_ARENA > 6 and player_system.DUEL_PLAYERS and #player_system.DUEL_PLAYERS >= 2 then
                StartTeleportFXPlayers(3, player_system.DUEL_PLAYERS)
            end
            
			-- Если еще не последняя арена, то запускаем ее, если арена последняя и игроков осталось 2, то запускаем конечную дуэль или заканчиваем игру
			if time <= 0 then
				if CURRENT_ARENA <= 6 then
					self:StartArena() -- запуск арены
					return
				else
                    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
                        self:StartEndDuelDuo()
                    else
                        self:StartEndDuel()
                    end
					CustomGameEventManager:Send_ServerToAllClients( 'wodaset_removeduel', {})
					return
				end
			end

			return 1
		end
		return FrameTime()
	end)
end

-- Функция которая производит чистку арены
function arena_system:EndSpawn()

	if ARENA_CREEPSTIMER ~= nil then 
		Timers:RemoveTimer(ARENA_CREEPSTIMER)
	end

	if ARENA_POSITION_TIMER ~= nil then 
		Timers:RemoveTimer(ARENA_POSITION_TIMER)
	end

	if ARENA_RUNETIMER ~= nil then 
		Timers:RemoveTimer(ARENA_RUNETIMER)
	end

	for _,creep in pairs(ARENA_CREEPSTABLE) do
		if creep and not creep:IsNull() and creep:IsAlive() then
			creep:ForceKill(false)
            UTIL_Remove(creep)
		end
	end

	for id,camp_icon in pairs(CAMPS_ICONS) do
		if camp_icon then 
			UTIL_Remove(camp_icon)
		end
	end
    
    ARENA_CREEPSTABLE = {}
	CAMPS_ICONS = {}
end

-- Инициализация спавна крипов
function arena_system:StartSpawn()
	local first = true
    local spawn_creeps = true
	ARENA_CREEPSTIMER = Timers:CreateTimer(0, function()
		if first then
			self:CheckForSpawn()
			first = false
			return 2
		end
		if math.floor(GameRules:GetDOTATime(false, false)) % 60 == 0 then
            if spawn_creeps then
			    self:CheckForSpawn()
                spawn_creeps = false
            end
			return 2
		end
        spawn_creeps = true
		return 0.5
	end)
end

-- Функция создания кэмпа с последюущим спавном крипов
function arena_system:CheckForSpawn()
    for trigger_name, tier_name in pairs(NEUTRAL_CREEPS[CURRENT_ARENA]) do
        local trigger = Entities:FindByName(nil, trigger_name)
        if trigger then
       		local length = (trigger:GetBoundingMins() - trigger:GetBoundingMaxs()):Length2D()
       		local creeps = FindUnitsInRadius(2, trigger:GetAbsOrigin(), nil, length, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
       		local creeps_in_trigger = 0
       		for _, creep in pairs(creeps) do
       		    if trigger:IsTouching(creep) and creep:GetUnitName() ~= "npc_dota_bounty_hunter_gold_bag" and creep:GetUnitName() ~= "npc_woda_wisp_death" then
       		        creeps_in_trigger = creeps_in_trigger + 1
       		    end
       		end
       		local pos = ARENA_CREEPSSPAWNPOINT[trigger_name]
       		local forward = ARENA_CREEPSSPAWNPOINTFORWARD[trigger_name]
       		local pfx_name = "particles/world_environmental_fx/radiant_creep_spawn.vpcf"
       		if creeps_in_trigger == 0 then
       		    local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_WORLDORIGIN, nil)
       		    ParticleManager:SetParticleControl(pfx, 0, pos)
       		    ParticleManager:ReleaseParticleIndex(pfx)
       		    self:Spawn(trigger, pos, tier_name, forward)
       		end
       		self:UpdateIcons(pos)
       	end
    end
end

-- Запуск дуэли
function arena_system:StartDuel()
	-- Переменные для дуэлей
	DUEL_ACTIVE=true
	DUEL_STARTED=true

	-- Если нет участников дуэли то мнгновенно ее закончить нужно
	if player_system.DUEL_PLAYERS == nil or #player_system.DUEL_PLAYERS < 2 then
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

	-- Если один из участников дуэли отсутствует в таблице каким-то образом
	if (player_system.DUEL_PLAYERS[1] == nil or player_system.DUEL_PLAYERS[2] == nil) then
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

	-- Если один из участников полностью ливнул, то отменяем дуэль
	if (PlayerResource:GetConnectionState(player_system.DUEL_PLAYERS[1].id) == DOTA_CONNECTION_STATE_ABANDONED or PlayerResource:GetConnectionState(player_system.DUEL_PLAYERS[2].id) == DOTA_CONNECTION_STATE_ABANDONED) then
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

	-- Получаем героев от обоих игроков
	local firsthero = player_system:GetHero(player_system.DUEL_PLAYERS[1].id)
	local secondhero = player_system:GetHero(player_system.DUEL_PLAYERS[2].id)

	-- Устанавливаем им переменную, что они сейчас в дуэли
	player_system:SetDuel(player_system.DUEL_PLAYERS[1].id, true)
	player_system:SetDuel(player_system.DUEL_PLAYERS[2].id, true)

	arena_system:SetMinimapForAllChoose(2)

	-- Удаляем им модификаторы релакса если герои существуют
	if firsthero and not firsthero:IsNull() and firsthero:IsAlive() then
		firsthero:RemoveModifierByName("modifier_wodarelax")
		firsthero:RemoveModifierByName("modifier_fountain_invulnerability")
		firsthero:ResetCooldown()
		if firsthero.bear and not firsthero.bear:IsNull() and firsthero.bear:IsAlive() then
    		firsthero.bear:ForceKill(false)
    	end
	end
	if secondhero and not secondhero:IsNull() and secondhero:IsAlive() then
		secondhero:RemoveModifierByName("modifier_fountain_invulnerability")
		secondhero:RemoveModifierByName("modifier_wodarelax")
		secondhero:ResetCooldown()
		if secondhero.bear and not secondhero.bear:IsNull() and secondhero.bear:IsAlive() then
    		secondhero.bear:ForceKill(false)
    	end
	end

	-- Поиск поинтов и телепортация их на арены
	local points = 
	{
		"duelarena1",
		"duelarena2",
		"duelarena3",
		"duelarena4"
	}

	local firstpoint = Entities:FindByName(nil, table.remove(points,RandomInt(1, #points)))
	local secondpoint = Entities:FindByName(nil, table.remove(points,RandomInt(1, #points)))

	if firstpoint then
		FindClearSpaceForUnit(firsthero, firstpoint:GetAbsOrigin(), true)
		firsthero:SetCamera(firsthero)
		firsthero:SetUnit(firsthero)
	end

	if secondpoint then
		FindClearSpaceForUnit(secondhero, secondpoint:GetAbsOrigin(), true)
		secondhero:SetCamera(secondhero)
		secondhero:SetUnit(secondhero)
	end

	-- Добавляем им модификаторы дуэли на друг друга
	if firsthero and not firsthero:IsNull()  and firsthero:IsAlive() then
		firsthero:AddNewModifier(firsthero, nil, "modifier_wodaduel1", {enemy=secondhero:entindex()})
	end
	if secondhero and not secondhero:IsNull() and secondhero:IsAlive() then
		secondhero:AddNewModifier(secondhero, nil, "modifier_wodaduel1", {enemy=firsthero:entindex()})
	end

	-- Оповещение на экране
	CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(firsthero:GetPlayerOwnerID()), "event_new_area_duel", {} )
	CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(secondhero:GetPlayerOwnerID()), "event_new_area_duel", {} )


	-- Запускаем таймер дуэли с проверками
	local time = DUEL_DURATION

	CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time=time, full_time=DUEL_DURATION, })

	local first_team = firsthero:GetTeamNumber()
	local second_team = secondhero:GetTeamNumber()

	-- даем вижен командам в центр дуэли
	for team=2,13 do 
		if team ~= first_team and team ~= second_team then 
			AddFOWViewer(team, Vector(-1760,-1792,0), 2500, 1.1, false)
		end
	end

    SetCustomTimeOfDay(0.5)

	DUEL_TIMER=Timers:CreateTimer(1, function()
		time = time - 1
        if time == DUEL_DURATION / 2 then
            SetCustomTimeOfDay(0.8)
        end
		for team=2,13 do 
			if team ~= first_team and team ~= second_team then 
				AddFOWViewer(team, Vector(-1760,-1792,0), 2500, 1.1, false)
			end
		end
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time=time,full_time=DUEL_DURATION, })
		if time <= 0 then
			self:EndDuel()
			return
		end
		return 1
	end)
end

function arena_system:IsLoseDuel()
    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        if arena_system:GetArena() == 3 and player_system:GetTeamCountAlive() >= 4 then
            return true
        end
        if arena_system:GetArena() == 5 and player_system:GetTeamCountAlive() >= 3 then
            return true
        end
        if CURRENT_ARENA >= 7 then
            return true
        end
        return false
    end
	if (8 - player_system:GetPlayerCount() ) < arena_system:GetArena() then
		return false
	end
	if CURRENT_ARENA >= 7 then
		return false
	end
	return true
end

-- Окончание дуэли
function arena_system:EndDuel(death_hero)
	-- Death hero существует если вызвано убийством на дуэли, если кончилось время то его нет
	local hero_kicked = nil -- Кого кикаем

	if death_hero ~= nil then 
		hero_kicked = death_hero 
	end

	-- Отключаем переменные дуэлей и удаляем таймер
	DUEL_ACTIVE = false
	DUEL_STARTED = false

	if DUEL_TIMER ~= nil then 
		Timers:RemoveTimer(DUEL_TIMER)
	end

	-- Находим игроков что были на дуэли
	local heroes = {}
	for id,info in pairs(PLAYERS) do
		if player_system:IsDuel(id) then
			table.insert(heroes, info.hero)
		end
	end

	-- Сверяем их по здоровью и выбираем того, кого надо кикнуть
	if hero_kicked == nil then
		table.sort(heroes, function(x,y) return y:GetHealthPercent() < x:GetHealthPercent() end)
		if heroes[1]:GetHealthPercent() == heroes[2]:GetHealthPercent() then
			table.sort(heroes, function(x,y) return y:GetMaxHealth() < x:GetMaxHealth() end)
		end
		if hero_kicked == nil then
		 	hero_kicked = heroes[#heroes]
		end
	end

	arena_system:SetMinimapForAllChoose(1)

	local winnerid = nil
	local winner = nil
    local loser = nil
    local loser_id = nil

    for id, info in pairs(PLAYERS) do
        if player_system:IsDuel(id) then
            if info.hero == hero_kicked then
                loser_id = id
			    loser = info.hero
            else
                winnerid = id
			    winner = info.hero
            end
        end
        if loser ~= nil and winner ~= nil then 
            break 
        end
    end
    
    if winner then
        winner:AddNewModifier(winner, nil, "modifier_wodarelax_invul", {duration = 2})
        winner:RemoveAllUnitsOwnerPlayer()
        player_system:SetDuel(winnerid, false)
        winner:ResetHealthAndMana()
        winner:ResetCooldown()
        Timers:CreateTimer({ endTime = 0.07, callback = function()
            winner:RemoveModifierByName("modifier_wodaduel1")
            local teleport_point = Entities:FindByName(nil,"relaxarena")
            if teleport_point then 
                FindClearSpaceForUnit(winner, teleport_point:GetAbsOrigin(), true)
            end
            winner:AddNewModifier(winner, nil, "modifier_wodarelax", {})
            winner:SetCamera(winner)
            winner:SetUnit(winner)
        end})
        if death_hero then 
            WodaTalents:AddPoint(winnerid, 3)
        else
            WodaTalents:AddPoint(winnerid, 5)
        end
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_OVERHEAD_FOLLOW, winner)
        ParticleManager:ReleaseParticleIndex(particle)
        winner:EmitSound("Hero_LegionCommander.Duel.Victory")

        local wardmodifier = winner:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
        if wardmodifier then
            wardmodifier:GetAbility():SetCurrentCharges(3)
            wardmodifier:GetAbility():SetSecondaryCharges(3)
        end

        if winner.fake_dazzle then
            local wardmodifier_dazzle = winner.fake_dazzle:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
            if wardmodifier_dazzle then
                wardmodifier_dazzle:GetAbility():SetCurrentCharges(3)
                wardmodifier_dazzle:GetAbility():SetSecondaryCharges(3)
            end
        end

        if PLAYERS[winnerid] then
            PLAYERS[winnerid].duel_streak = (PLAYERS[winnerid].duel_streak or 0) + 1
            player_system:CheckAttributeQuest(winnerid, 12, 34, 56, 78)
        end
    end

    if loser then
        Timers:CreateTimer(FrameTime(), function()
            local wardmodifier = loser:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
            if wardmodifier then
                wardmodifier:GetAbility():SetCurrentCharges(3)
                wardmodifier:GetAbility():SetSecondaryCharges(3)
            end
            if loser.fake_dazzle then
                local wardmodifier_dazzle = loser.fake_dazzle:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
                if wardmodifier_dazzle then
                    wardmodifier_dazzle:GetAbility():SetCurrentCharges(3)
                    wardmodifier_dazzle:GetAbility():SetSecondaryCharges(3)
                end
            end
        end)
        loser:RemoveAllUnitsOwnerPlayer()
        player_system:SetDuel(loser_id, false) 
        player_system:SetLose(loser_id)
        player_system:CheckAttributeQuest(loser_id, 13, 35, 57, 79)
    end

	-- Раздаем награды победителям сюда + сюда
	if winnerid ~= nil then 
		for id,betid in pairs(DUEL_PREDICT_PLAYERS) do
			if betid == winnerid then
				WodaTalents:AddPoint(id,4)
			end
		end
	end

	-- Обнуляем ставки 
	for id,betid in pairs(DUEL_PREDICT_PLAYERS) do
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playersbet", player_id = id, data = {bet = nil}})
	end

	DUEL_PREDICT_PLAYERS = {}

	CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "visibleicon", data = {visible = "false"}})
end

-- Последняя дуэль
function arena_system:StartEndDuel(retry)
	-- Переменные для дуэлей
	DUEL_ACTIVE=true
	DUEL_STARTED=true

	player_system.DUEL_PLAYERS = {}

	if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        player_system.DUEL_PLAYERS = player_system:GetPlayerLastNetworthsTeam()
    else
        player_system.DUEL_PLAYERS = player_system:GetPlayerLastNetworths()
    end

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

	-- Если один из участников полностью ливнул, то отменяем дуэль
	if (PlayerResource:GetConnectionState(player_system.DUEL_PLAYERS[1].id) == DOTA_CONNECTION_STATE_ABANDONED or PlayerResource:GetConnectionState(player_system.DUEL_PLAYERS[2].id) == DOTA_CONNECTION_STATE_ABANDONED) then
		arena_system:CloseAndEndGame()
		return
	end

	-- Получаем героев от обоих игроков
	local firsthero = player_system:GetHero(player_system.DUEL_PLAYERS[1].id)
	local secondhero = player_system:GetHero(player_system.DUEL_PLAYERS[2].id)

	-- Устанавливаем им переменную, что они сейчас в дуэли
	player_system:SetDuelEnd(player_system.DUEL_PLAYERS[1].id, true)
	player_system:SetDuelEnd(player_system.DUEL_PLAYERS[2].id, true)

	arena_system:SetMinimapForAllChoose(3)

	if firsthero and not firsthero:IsNull() then
		firsthero:ResetHealthAndMana()
        firsthero:ResetCooldown()
		firsthero:Stop()
	end

	if secondhero and not secondhero:IsNull() then
		secondhero:ResetHealthAndMana()
        secondhero:ResetCooldown()
		secondhero:Stop()
	end

    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_score", key = "player_1", data = {score = FINAL_DUEL_POINTS[firsthero:GetPlayerOwnerID()], hero = firsthero:GetUnitName()}})
    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_score", key = "player_2", data = {score = FINAL_DUEL_POINTS[secondhero:GetPlayerOwnerID()], hero = secondhero:GetUnitName()}})

	Timers:CreateTimer({ endTime = 0.07, callback = function()
		if not firsthero:IsAlive() and not secondhero:IsAlive() then
			return 0.07
		end
		-- Удаляем им модификаторы релакса если герои существуют
		-- Удаляем модификаторы дуэли и вновь передобавлявем + удаляем на виспа ибо нахер он уже нужен
		if firsthero and not firsthero:IsNull() then
			firsthero:RemoveModifierByName("modifier_wodarelax")
			firsthero:RemoveModifierByName("modifier_wodaduel2")
			firsthero:RemoveModifierByName("modifier_wodawispdeath")
			firsthero:RemoveModifierByName("modifier_fountain_invulnerability")
			if firsthero.bear and not firsthero.bear:IsNull() and firsthero.bear:IsAlive() then
	    		firsthero.bear:ForceKill(false)
	    	end
		end

		if secondhero and not secondhero:IsNull() then
			secondhero:RemoveModifierByName("modifier_wodarelax")
			secondhero:RemoveModifierByName("modifier_wodaduel2")
			secondhero:RemoveModifierByName("modifier_wodawispdeath")
			secondhero:RemoveModifierByName("modifier_fountain_invulnerability")
			if secondhero.bear and not secondhero.bear:IsNull() and secondhero.bear:IsAlive() then
	    		secondhero.bear:ForceKill(false)
	    	end 
		end

		local points = {
			"finalduelarena1",
			"finalduelarena2",
			"finalduelarena3",
			"finalduelarena4"
		}

		local firstpoint = Entities:FindByName(nil, table.remove(points,RandomInt(1, #points)))
		local secondpoint = Entities:FindByName(nil, table.remove(points,RandomInt(1, #points)))

		if firstpoint then
			FindClearSpaceForUnit(firsthero, firstpoint:GetAbsOrigin(), true)
			firsthero:SetCamera(firsthero)
			firsthero:SetUnit(secondhero)
			firsthero:Stop()
		end

		if secondpoint then
			FindClearSpaceForUnit(secondhero, secondpoint:GetAbsOrigin(), true)
			secondhero:SetCamera(secondhero)
			secondhero:SetUnit(secondhero)
			secondhero:Stop()
		end

		firsthero:AddNewModifier(firsthero, nil, "modifier_wodaduel2", {enemy=secondhero:entindex()})
		secondhero:AddNewModifier(secondhero, nil, "modifier_wodaduel2", {enemy=firsthero:entindex()})

        if firstpoint then
			FindClearSpaceForUnit(firsthero, firstpoint:GetAbsOrigin(), true)
		end

		if secondpoint then
			FindClearSpaceForUnit(secondhero, secondpoint:GetAbsOrigin(), true)
		end

        if firstpoint then
            Timers:CreateTimer(0, function()
                FindClearSpaceForUnit(firsthero, firstpoint:GetAbsOrigin(), true)
                if not firsthero:IsAlive() then
                    return 0.1
                end
            end)
		end
		if secondpoint then
            Timers:CreateTimer(0, function()
                FindClearSpaceForUnit(secondhero, secondpoint:GetAbsOrigin(), true)
                if not secondhero:IsAlive() then
                    return 0.1
                end
            end)
		end
	end})

	local time = LASTDUEL_DURATION

    SetCustomTimeOfDay(0.5)

	CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time=time, full_time=LASTDUEL_DURATION, })

	DUEL_TIMER=Timers:CreateTimer(1, function()
		time = time - 1
        if time == math.floor(LASTDUEL_DURATION / 2) then
            SetCustomTimeOfDay(0.8)
        end
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time=time, full_time=LASTDUEL_DURATION, })
		if time <= 0 then
			self:EndGame()
			return
		end
		return 1
	end)
end

function arena_system:EndGame(death_hero)
	-- Death hero существует если вызвано убийством на дуэли, если кончилось время то его нет
	local hero_kicked = nil -- Кого кикаем

	if death_hero ~= nil then 
		hero_kicked = death_hero 
	end

	-- Отключаем переменные дуэлей и удаляем таймер
	DUEL_ACTIVE=false

	if DUEL_TIMER ~= nil then 
		Timers:RemoveTimer(DUEL_TIMER)
	end

	-- Находим игроков что были на дуэли
	local heroes = {}
	for id,info in pairs(PLAYERS) do
		if player_system:IsDuelEnd(id) then
			table.insert(heroes, info.hero)
		end
	end

	-- Сверяем их по здоровью и выбираем того, кого надо кикнуть
	if hero_kicked == nil then
		table.sort(heroes, function(x,y) return y:GetHealthPercent() < x:GetHealthPercent() end)
		if heroes[1] and heroes[2] and heroes[1]:GetHealthPercent() == heroes[2]:GetHealthPercent() then
			table.sort(heroes, function(x,y) return y:GetMaxHealth() < x:GetMaxHealth() end)
		end
		if hero_kicked == nil then
		 	hero_kicked = heroes[#heroes]
		end
	end

	-- Ищем победителя дуэли ( кривовато немного кажется здесь )
	local winnerid = nil
	local winner = nil
    local loser = nil
    local loser_id = nil

    for id, info in pairs(PLAYERS) do
        if player_system:IsDuelEnd(id) then
            if info.hero == hero_kicked then
                loser_id = id
			    loser = info.hero
            else
                winnerid = id
			    winner = info.hero
            end
        end
        if loser ~= nil and winner ~= nil then 
            break 
        end
    end

	if winner then
		winner:AddNewModifier(winner, nil, "modifier_wodarelax_invul", {duration = 3})
        winner:ResetHealthAndMana()
	end
    
    if hero_kicked and hero_kicked:IsAlive() then
        hero_kicked:AddNewModifier(hero_kicked, nil, "modifier_wodarelax_invul", {duration = 3})
        hero_kicked:ResetHealthAndMana()
        player_system:CheckAttributeQuest(hero_kicked:GetPlayerOwnerID(), 13, 35, 57, 79)
    end

    if death_hero == nil and winner and hero_kicked then
        local modifier_woda_handler_player = winner:FindModifierByName("modifier_woda_handler_player")
        if modifier_woda_handler_player then
            modifier_woda_handler_player:LeaderOnDeath({attacker = winner, unit = hero_kicked})
        end
        local modifier_woda_handler_player = hero_kicked:FindModifierByName("modifier_woda_handler_player")
        if modifier_woda_handler_player then
            modifier_woda_handler_player:LeaderOnDeath({attacker = winner, unit = hero_kicked})
        end
    end

	if FINAL_DUEL_POINTS[winner:GetPlayerOwnerID()] == nil then
		FINAL_DUEL_POINTS[winner:GetPlayerOwnerID()] = 1
	else
		FINAL_DUEL_POINTS[winner:GetPlayerOwnerID()] = FINAL_DUEL_POINTS[winner:GetPlayerOwnerID()] + 1
	end

    local firsthero = nil
    local secondhero = nil
    if player_system.DUEL_PLAYERS[1] then
        firsthero = player_system:GetHero(player_system.DUEL_PLAYERS[1].id)
    end
    if player_system.DUEL_PLAYERS[2] then
        secondhero = player_system:GetHero(player_system.DUEL_PLAYERS[2].id)
    end

    if firsthero and secondhero then
        CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_score", key = "player_1", data = {score = FINAL_DUEL_POINTS[firsthero:GetPlayerOwnerID()], hero = firsthero:GetUnitName()}})
        CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_score", key = "player_2", data = {score = FINAL_DUEL_POINTS[secondhero:GetPlayerOwnerID()], hero = secondhero:GetUnitName()}})
        firsthero:RemoveAllUnitsOwnerPlayer()
        secondhero:RemoveAllUnitsOwnerPlayer()
    end

    if winner and PLAYERS[winner:GetPlayerOwnerID()] then
        PLAYERS[winner:GetPlayerOwnerID()].duel_streak = (PLAYERS[winner:GetPlayerOwnerID()].duel_streak or 0) + 1
        player_system:CheckAttributeQuest(winner:GetPlayerOwnerID(), 12, 34, 56, 78)
    end

	if winner and FINAL_DUEL_POINTS[winner:GetPlayerOwnerID()] >= 2 then
		-- Проигравший в луз и удаление
        PLAYERS[hero_kicked:GetPlayerOwnerID()].pause = 0
	    PLAYERS[hero_kicked:GetPlayerOwnerID()].place = 2
		player_system:SetLosePlayer(hero_kicked:GetPlayerOwnerID())

	    if string.find(GetMapName(), "rating") then
	    	player_system:PlayerUnBanLeaved(hero_kicked:GetPlayerOwnerID())
	   	end
	    -- Виннер 1 место офк
		PLAYERS[winner:GetPlayerOwnerID()].pause = 0
	    PLAYERS[winner:GetPlayerOwnerID()].place = 1
        player_system:NetWorthUpdate()
	    Timers:CreateTimer({ endTime = 0.1, callback = function()
			arena_system:CloseAndEndGame(winner)
		end})
	else
        Timers:CreateTimer({ endTime = 3, callback = function()
		    self:StartEndDuel()
        end})
	end
end

function arena_system:CloseAndEndGame(winner)
    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        arena_system:CloseAndEndGameDuo(winner)
        return
    end
	if winner == nil then
		for id, info in pairs(PLAYERS) do
			if not player_system:IsLose(id) and PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_CONNECTED and PLAYERS[id] and PLAYERS[id].place == nil then
				PLAYERS[id].place = 1
				winner = info.hero
				break
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

	if player_system:GetPlayerCountAll() >= 7 and not GameRules:IsCheatMode() and ( player_system.PLAYERS_GLOBAL_INFORMATION[winner:GetPlayerOwnerID()] and player_system.PLAYERS_GLOBAL_INFORMATION[winner:GetPlayerOwnerID()].last_leave == 1 ) then
		if string.find(GetMapName(), "rating") then
			player_system:PlayerUnBanLeaved(winner:GetPlayerOwnerID())
		end
	end

	Timers:CreateTimer({ endTime = 0.1, callback = function()
        player_system:SendQuestToServer()
		player_system:SendDataToServer()
		player_system:SendDataPlayersHeroStats()
		player_system:SendDataPlayerReports()
	end})
	Timers:CreateTimer({ endTime = 0.25, callback = function()
        if arena_system.IS_GAME_END then return end
        arena_system.IS_GAME_END = true
		GameRules:SetGameWinner(winner:GetTeamNumber())
	end})
end