--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--------- OVERTHROW --------------------------
_G.STARTGAME_DURATION_OVERTHROW = 10
_G.FULL_TIME_OVERHROW = 1200
_G.DEFAULT_KILLS_COUNT = 30
_G.NEUTRALS_TIERS_DELAY_START = 60
_G.NEUTRALS_TIERS_DELAY = 180
_G.CREEPS_SPAWN_POINTS_OVERTHROW = {}
_G.CREEPS_SPAWN_POINTS_OVERTHROW_FORWARD = {}
_G.OVERTHROW_SPHERE_CHANCE_BLUE = 6
_G.OVERTHROW_SPHERE_CHANCE_RED = 2
_G.OVERTHROW_KILLS_COUNT_TEAM = 
{
	[DOTA_TEAM_GOODGUYS] = 0,
	[DOTA_TEAM_BADGUYS] = 0,
	[DOTA_TEAM_CUSTOM_1] = 0,
	[DOTA_TEAM_CUSTOM_2] = 0,
	[DOTA_TEAM_CUSTOM_3] = 0,
	[DOTA_TEAM_CUSTOM_4] = 0,
	[DOTA_TEAM_CUSTOM_5] = 0,
	[DOTA_TEAM_CUSTOM_6] = 0,
}

function arena_system:StartGameOverthrow()
    CreateModifierThinker(nil, nil, "modifier_events_thinker_woda", {}, Vector(0,0,0), DOTA_TEAM_NEUTRALS, false)
    SetCustomTimeOfDay(0.5)

	player_system.starting_overthrow = true

	if player_system.data_base_connected == false then
		CustomGameEventManager:Send_ServerToAllClients("notification_no_data_server", {server = "true"})
	elseif player_system:GetPlayerCountAll() < arena_system:GetMaxPlayersMode() then
		
	end

	Timers:CreateTimer(7, function()
		CustomGameEventManager:Send_ServerToAllClients("event_new_area_gamemode", {})
	end)

	CustomGameEventManager:Send_ServerToAllClients( 'event_open_overthrow_settings', {})
	self:CreepsInitOverthrow()
	self:StartRune()

    if GameRules:IsCheatMode() then
        self:SpawnDummyOverthrow()
    end

	local time = STARTGAME_DURATION_OVERTHROW

	CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name', { name = "overhrow_start_game" })
	CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time=time, full_time=STARTGAME_DURATION_OVERTHROW, relax=true, duel = false })

	Timers:CreateTimer(1, function()
		time = time - 1
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time=time, full_time=STARTGAME_DURATION_OVERTHROW, relax=true, duel = false })
		if time <= 0 then
			self:StartEndTimeOverthrow()
			return
		end
		return 1
	end)
end

function arena_system:StartEndTimeOverthrow()
	GameRules:ForceGameStart()
	for id, player in pairs(PLAYERS) do 
		if player.hero ~= nil and not player.hero:IsNull() then
			player.hero:RemoveModifierByName("modifier_wodawispdeath")
			player.hero:RemoveModifierByName("modifier_woda_stunned")
			player.hero:RemoveModifierByName("modifier_wodarelax")
			player.hero:RemoveModifierByName("modifier_wodarelax_invul")
		end
	end
	local time = FULL_TIME_OVERHROW
	local neutrals_items_cd = NEUTRALS_TIERS_DELAY_START
	local current_tier = 1

	CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name_wave', { kills = DEFAULT_KILLS_COUNT })
	CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time = time, full_time = FULL_TIME_OVERHROW })
	CustomGameEventManager:Send_ServerToAllClients( 'event_close_overthrow_settings', {})

	self:StartSpawnCreepsOverthrow()

	Timers:CreateTimer(1, function()
		if time > 0 then
			time = time - 1
		end
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time = time, full_time = FULL_TIME_OVERHROW })
		if time == FULL_TIME_OVERHROW / 2 then
			Timers:CreateTimer(FrameTime(), function()
                for id,player in pairs(PLAYERS) do 
                    if player.hero ~= nil and not player_system:IsLose(id) and not player.hero:IsNull() then
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
            end)
		end
		Timers:CreateTimer(FrameTime(), function()
            self:DropSphere()
        end)
		if time <= 0 then
			if arena_system:EndGameTimeoutCheck() then
				return
			end
		end
		return 1
	end)

	Timers:CreateTimer(1, function()
		neutrals_items_cd = neutrals_items_cd - 1
		if neutrals_items_cd <= 0 then
			neutrals_reward:SpawnRandomNeutrals(current_tier)
			neutrals_items_cd = NEUTRALS_TIERS_DELAY
			current_tier = current_tier + 1
		end
		if current_tier > 6 then
			return
		end
		return 1
	end)
end

-- Инициализация кэмпов крипов
function arena_system:CreepsInitOverthrow()

	local points = 
	{
		"overthrow_camp1",
		"overthrow_camp2",
		"overthrow_camp3",
		"overthrow_camp4",
		"overthrow_camp5",
		"overthrow_camp6",
		"overthrow_camp7",
		"overthrow_camp8",
	}

	for _, trigger_name in pairs(points) do
		for _, spawner in pairs(Entities:FindAllByClassname("npc_dota_neutral_spawner") or {}) do
            local trigger = Entities:FindByName(nil, trigger_name)
            if spawner and trigger then
                if (spawner:GetAbsOrigin() - trigger:GetAbsOrigin()):Length2D() < 300 then
                    CREEPS_SPAWN_POINTS_OVERTHROW[trigger:GetName()] = spawner:GetAbsOrigin()
                    CREEPS_SPAWN_POINTS_OVERTHROW_FORWARD[trigger:GetName()] = spawner:GetForwardVector()
                    UTIL_Remove(spawner)
                    break
                end
            end
        end
    end
end

-- Инициализация спавна крипов
function arena_system:StartSpawnCreepsOverthrow()
    local first = true
    local spawn_creeps = true
	ARENA_CREEPSTIMER = Timers:CreateTimer(0, function()
		if first then
			self:CheckForSpawnOverthrow(math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60))
			first = false
			return 2
		end
		if math.floor(GameRules:GetDOTATime(false, false)) % 60 == 0 then 
            if spawn_creeps then
			    self:CheckForSpawnOverthrow(math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60))
                spawn_creeps = false
			    return 2
            end
		end
        spawn_creeps = true
		return 0.5
	end)
end

-- Функция создания кэмпа с последюущим спавном крипов
function arena_system:CheckForSpawnOverthrow(time)
	local tiers = 
	{
		[0] = "tier1",
		[1] = "tier1",
		[2] = "tier2",
		[3] = "tier2",
		[4] = "tier2",
		[5] = "tier3",
		[6] = "tier3",
		[7] = "tier3",
		[8] = "tier4",
		[9] = "tier4",
		[10] = "tier4",
		[11] = "tier5",
		[12] = "tier5",
		[13] = "tier5",
		[14] = "tier6",
		[15] = "tier6",
		[16] = "tier6",
		[17] = "tier6",
		[18] = "tier6",
		[19] = "tier6",
		[20] = "tier6",
		[21] = "tier6",
		[22] = "tier6",
		[23] = "tier6",
		[24] = "tier6",
		[25] = "tier6",
		[26] = "tier6",
		[27] = "tier6",
		[28] = "tier6",
	}

	local tier_name = tiers[time]
	local points = 
	{
		"overthrow_camp1",
		"overthrow_camp2",
		"overthrow_camp3",
		"overthrow_camp4",
		"overthrow_camp5",
		"overthrow_camp6",
		"overthrow_camp7",
		"overthrow_camp8",
	}

    for _, trigger_name in pairs(points) do
        local trigger = Entities:FindByName(nil, trigger_name)
        if trigger then
       		local length = (trigger:GetBoundingMins() - trigger:GetBoundingMaxs()):Length2D()
       		local creeps = FindUnitsInRadius(2, trigger:GetAbsOrigin(), nil, length, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
       		local creeps_in_trigger = 0
       		for _, creep in pairs(creeps) do
       		    if trigger:IsTouching(creep) and creep:GetUnitName() ~= "npc_dota_bounty_hunter_gold_bag" then
       		        creeps_in_trigger = creeps_in_trigger + 1
       		    end
       		end
       		local pos = CREEPS_SPAWN_POINTS_OVERTHROW[trigger_name]
       		local forward = CREEPS_SPAWN_POINTS_OVERTHROW_FORWARD[trigger_name]
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

function arena_system:OverthrowSettingsPlus(data)
	if data.PlayerID == nil then return end
	DEFAULT_KILLS_COUNT = DEFAULT_KILLS_COUNT + 2
	FULL_TIME_OVERHROW = FULL_TIME_OVERHROW + 60
end

function arena_system:DropSphere()
	if RollPercentage(OVERTHROW_SPHERE_CHANCE_BLUE) then
		self:DropSphereStart("blue")
	elseif RollPercentage(OVERTHROW_SPHERE_CHANCE_RED) then
		self:DropSphereStart("red")
	end
end

function arena_system:DropSphereStart(sphere_type)
    if IsInToolsMode() then return end
    if GameRules:IsCheatMode() then return end
	local overBoss = Entities:FindByName( nil, "@overboss" )
    if overBoss then
        if sphere_type == "blue" then
            local dota_ability_throw_sphere_blue = overBoss:FindAbilityByName( 'dota_ability_throw_sphere_blue' )
            if dota_ability_throw_sphere_blue then
                overBoss:CastAbilityNoTarget( dota_ability_throw_sphere_blue, -1 )
            end
        end
        if sphere_type == "red" then
            local dota_ability_throw_sphere_red = overBoss:FindAbilityByName( 'dota_ability_throw_sphere_red' )
            if dota_ability_throw_sphere_red then
                overBoss:CastAbilityNoTarget( dota_ability_throw_sphere_red, -1 )
            end
        end
    end
end

function arena_system:SpawnSphereBlue(point)
	EmitGlobalSound("Item.PickUpGemWorld")
	local capture_point = CreateUnitByName("npc_dota_companion", point, false, nil, nil, DOTA_TEAM_NEUTRALS)
	capture_point:SetAbsOrigin(point)
	capture_point:AddNewModifier(capture_point, nil, "capture_point_area", { orb_type = "blue", should_launch = true })
	capture_point.orb_fx = ParticleManager:CreateParticle("particles/orb_rare.vpcf", PATTACH_ABSORIGIN_FOLLOW, capture_point)
end

function arena_system:SpawnSphereRed(point)
	EmitGlobalSound("Item.PickUpGemWorld")
	local capture_point = CreateUnitByName("npc_dota_companion", point, false, nil, nil, DOTA_TEAM_NEUTRALS)
	capture_point:SetAbsOrigin(point)
	capture_point:AddNewModifier(capture_point, nil, "capture_point_area", { orb_type = "red", should_launch = true })
	capture_point.orb_fx = ParticleManager:CreateParticle("particles/orb_rare_red.vpcf", PATTACH_ABSORIGIN_FOLLOW, capture_point)
end

function arena_system:GiveRewardSphere(team, sphere_type)
	local player_id = nil

	for id, player in pairs(PLAYERS) do 
		if player.hero ~= nil and not player_system:IsLose(id) and not player.hero:IsNull() then
			if player.hero:GetTeamNumber() == team then
				player_id = id
				break
			end
		end
	end

	if player_id == nil then return end

	if sphere_type == "red" then
		WodaTalents:AddPoint(player_id, 3)
	else
		WodaTalents:AddPoint(player_id, 1)
	end
end

function arena_system:AddScoreToTeam( Team, AddScore )
	local team_kills = 0

	if OVERTHROW_KILLS_COUNT_TEAM[Team] then
		OVERTHROW_KILLS_COUNT_TEAM[Team] = OVERTHROW_KILLS_COUNT_TEAM[Team] + AddScore
	end

	local teams = {}

	for team_n, kills in pairs(OVERTHROW_KILLS_COUNT_TEAM) do
        table.insert(teams, {id = team_n, kills = kills} )
    end

    table.sort( teams, function(x,y) return y.kills < x.kills end )

    if teams[1] and teams[1].kills >= DEFAULT_KILLS_COUNT then
    	arena_system:CloseAndEndGameOverthrow(teams[1].id)
    end
end

function arena_system:EndGameTimeoutCheck()
	local teams = {}
	for team_n, kills in pairs(OVERTHROW_KILLS_COUNT_TEAM) do
        table.insert(teams, {id = team_n, kills = kills} )
    end
    table.sort( teams, function(x,y) return y.kills < x.kills end )
    if teams[1] then
    	if teams[2] and teams[1].kills == teams[2].kills then
    		return false
    	end
    	arena_system:CloseAndEndGameOverthrow(teams[1].id, teams)
    	return true
    end
end

function arena_system:CloseAndEndGameOverthrow(team_winner, teams_table)
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
    damage_system:EndGameUpdate()
    Timers:CreateTimer({ endTime = 0.25, callback = function()
        player_system:SendDataToServerOverthrow()
		player_system:SendDataPlayersHeroStats()
    end})
    Timers:CreateTimer({ endTime = 0.5, callback = function()
        GameRules:SetGameWinner(team_winner)
    end})
end

function arena_system:SpawnDummyOverthrow()
    Timers:CreateTimer(0.03,function()
        local hHero = PlayerResource:GetSelectedHeroEntity(0)
        if not hHero then
            return 0.03
        end
        hHero:SetAbilityPoints(100)
        for i=1,29 do
            hHero:HeroLevelUp(false)
        end
        for i=1, 10 do
            Timers:CreateTimer(0.1*i, function()
                WodaTalents:AddPoint(hHero:GetPlayerOwnerID(), 100, true)
            end)
        end
        hHero:AddItemByName("item_blink")
        local hPlayer = PlayerResource:GetPlayer(0)
        local npc_dota_hero_target_dummy = CreateUnitByName( "npc_dota_hero_target_dummy", Vector(-265.921, -712.218, 43.3432), true, nil, nil, hHero:GetTeamNumber() == DOTA_TEAM_GOODGUYS and DOTA_TEAM_BADGUYS or DOTA_TEAM_GOODGUYS )
        npc_dota_hero_target_dummy:AddNewModifier(npc_dota_hero_target_dummy, nil, "modifier_disarmed", {})
        npc_dota_hero_target_dummy:SetBaseMagicalResistanceValue(0)

        local pos2 = Vector(-265.921, -712.218, 43.3432) + RandomVector(250)
        DebugCreateUnit( hPlayer, "npc_dota_hero_pudge", DOTA_TEAM_BADGUYS, false,
        function( hEnemy )
            hEnemy:SetControllableByPlayer( 0, false )
            hEnemy:SetRespawnPosition( pos2 )
            FindClearSpaceForUnit( hEnemy, pos2, false )
            hEnemy:Hold()
            hEnemy:SetIdleAcquire( false )
            hEnemy:SetAcquisitionRange( 0 )
            hEnemy:SetContextThink("43242423", function(hEnemy)
                if not hEnemy:IsAlive() then
                    hEnemy:SetRespawnPosition( hEnemy:GetAbsOrigin() )
                    hEnemy:SetTimeUntilRespawn(1)
                    return 2
                end
                return 0.1
            end, 0.1)
        end )
        DebugCreateUnit( hPlayer, "npc_dota_hero_axe", DOTA_TEAM_CUSTOM_2, false,
        function( hEnemy )
            hEnemy:SetControllableByPlayer( 0, false )
            hEnemy:SetRespawnPosition( pos2 )
            FindClearSpaceForUnit( hEnemy, pos2, false )
            hEnemy:Hold()
            hEnemy:SetIdleAcquire( false )
            hEnemy:SetAcquisitionRange( 0 )
            for i=1,29 do
                hEnemy:HeroLevelUp(false)
            end
            hEnemy:SetContextThink("43242423", function(hEnemy)
                if not hEnemy:IsAlive() then
                    hEnemy:SetRespawnPosition( hEnemy:GetAbsOrigin() )
                    hEnemy:SetTimeUntilRespawn(1)
                    return 2
                end
                return 0.1
            end, 0.1)
        end )
    end)
end