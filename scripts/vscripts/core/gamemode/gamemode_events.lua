--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--- Подписка на игровые и кастомные события
function GameMode:RegisterEventListeners()
    logger:Log("[RegisterEventListeners] Started")
    ListenToGameEvent("game_rules_state_change", function(_) self:OnGameRulesStateChange() end, nil)
    ListenToGameEvent("dota_player_gained_level", function(event) self:OnHeroLevelUp(event) end, nil)
    ListenToGameEvent("dota_player_used_ability", function(event) self:OnPlayerUsedAbility(event) end, nil)
    -- ListenToGameEvent("dota_player_learned_ability", function (event) self:OnHeroLearnAbility(event) end, nil)
    ListenToGameEvent("npc_spawned", function(event) self:OnNPCSpawned(event) end, nil)
    ListenToGameEvent("player_connect_full", function(event) self:OnPlayerConnectFull(event) end, nil)
    ListenToGameEvent("player_reconnected", function(event) self:OnPlayerReconnected(event) end, nil)
    logger:Log("[RegisterEventListeners] Ended")
end

--- @param event table
function GameMode:OnPlayerConnectFull(event)
    local uid = GetSteamID(event.PlayerID)
    Security:StartSendingSecurityKeyToPlayer(event.PlayerID)
    Settings:Apply(event.PlayerID, nil, true) -- инициализация дефолтов, если логин не пройдет
    PlayerOutboundApi:Login(uid, function(res)
        local resBody = json.decode(res.Body)
        self:KickBannedPlayer(uid, resBody.banned)
        self:UpdateRankTable(uid, resBody.ratingInfos)
        self:UpdateRecentBans(uid, resBody.bans)
        self:UpdateBanPresets(uid, resBody.banPresets)
		self:UpdatePlayerTag(uid, resBody.tag)
        Settings:Apply(event.PlayerID, resBody.settings, true)
    end)
end

function GameMode:OnPlayerReconnected(event)
    Security:StartSendingSecurityKeyToPlayer(event.PlayerID)
    AbilitySelectionService:ReEmit(event.PlayerID)
    local bannedPlayersTable = CustomNetTables:GetTableValue("service", "banned_players") or {}
    if table.contains(bannedPlayersTable, event.PlayerID) then
        local player = PlayerResource:GetPlayer(event.PlayerID)
        if not player then return end
        CustomGameEventManager:Send_ServerToPlayer(player, "KickPlayer", {
            security_key = Security:GetSecurityKey(event.PlayerID),
            player_id = event.PlayerID
        })
    end
end

function GameMode:OnNPCSpawned(event)
    local spawnedUnit = EntIndexToHScript(event.entindex) ---@type CDOTA_BaseNPC | nil
    if not spawnedUnit then return end

    if spawnedUnit:GetUnitName() == "npc_dota_roshan" then
        spawnedUnit:RemoveAbility("roshan_grab_and_throw")
    end

    if spawnedUnit:GetOwner() and spawnedUnit:GetOwner().IsTempestDouble and spawnedUnit:GetOwner():IsTempestDouble() then
        local owner = spawnedUnit:GetOwner()
        owner.__summon = owner.__summon or {}
        owner.__summon[spawnedUnit:entindex()] = true
    end

    if spawnedUnit:GetName() == "npc_dota_companion" and spawnedUnit:GetOwner() ~=
        PlayerResource:GetSelectedHeroEntity(spawnedUnit:GetPlayerOwnerID()) then
        spawnedUnit:RemoveSelf()
    end

    if string.find(spawnedUnit:GetUnitName(), "npc_dota_lone_druid_bear") then
        Timers:CreateTimer(FrameTime(), function()
            spawnedUnit:RemoveModifierByName("modifier_lone_druid_spirit_bear_attack_check")
            return nil
        end)
    end

    if spawnedUnit:IsIllusion() and spawnedUnit:GetUnitName() == "npc_dota_hero_muerta" then
        Timers:CreateTimer(FrameTime(), function()
            spawnedUnit:RemoveAbility("muerta_supernatural")
            spawnedUnit:RemoveAbility("muerta_pierce_the_veil")
            spawnedUnit:RemoveModifierByName("modifier_muerta_supernatural")
            spawnedUnit:RemoveModifierByName("modifier_muerta_gunslinger")
            spawnedUnit:RemoveModifierByName("modifier_muerta_pierce_the_veil")
            spawnedUnit:RemoveModifierByName("modifier_muerta_pierce_the_veil_buff")
            return nil
        end)
    end
    if spawnedUnit:IsHero() and spawnedUnit:GetTeam() ~= DOTA_TEAM_NEUTRALS then
        if not Features:GetFeatureState(Features.Keys.EscapeControllerDisabled) then
            if spawnedUnit:IsRealHero() then
                spawnedUnit:AddNewModifier(spawnedUnit, nil, "modifier_escape_controller", {})
            end
            if spawnedUnit:GetUnitName() == "npc_dota_roshan" then
                spawnedUnit:AddNewModifier(spawnedUnit, nil, "modifier_escape_controller", {})
            end
            local playerId = spawnedUnit:GetPlayerOwnerID()
            local hero = PlayerResource:GetSelectedHeroEntity(playerId)
            if playerId ~= -1 and hero ~= nil then
                if hero:HasModifier("modifier_hero_refreshing") then
                    if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
                        spawnedUnit:AddNewModifier(spawnedUnit, nil, "modifier_hero_refreshing", {})
                    end
                end
            end
        end
    end
end

function GameMode:OnPlayerUsedAbility(event)
    -- logger:LogTable(event)
    HeroBuilder:RefreshAbilityOrder(event.PlayerID)
end

--- @param event table
function GameMode:OnItemPurchased(event)
    local player = PlayerResource:GetPlayer(event.PlayerID)
    if not player then
        return
    end

    CustomGameEventManager:Send_ServerToPlayer(player, "UpdateBetInput", {})
end

--- @param event table
function GameMode:OnHeroLevelUp(event)
    local playerID = event.player_id
    local hero = PlayerResource:GetSelectedHeroEntity(playerID)
    if not IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
        return
    end

    local currentLevel = hero:GetLevel()

    if event.level == currentLevel then
        if currentLevel > 25 then
            local abilityPoints = hero:GetAbilityPoints()
            hero:SetAbilityPoints(abilityPoints + 1)
        end
    end
end