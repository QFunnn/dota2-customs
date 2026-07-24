--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@param botsCount number?
function GameMode:SetUpBots(botsCount)
    if GameRulesCustom.bStartBoot then
        return
    end

    GameRulesCustom.bStartBoot = true;
    GameMode.teamSet = {}
    local playersPerTeam, teamCount = GameMode:GetAllTeamInfo()
    local total = botsCount or playersPerTeam * teamCount - PlayerResource:GetPlayerCount()
    for i = 1, total do
        local heroName = HeroSelectionService:RandomHeroFromPool()
        Tutorial:AddBot(heroName, '', '', true)
        GameMode.validPlayerCount = GameMode.validPlayerCount + 1
    end
    for i = 1, #GameMode.teamList do
        local teamNumber = GameMode.teamList[i]
        local teamPlayerCount = PlayerResource:GetPlayerCountForTeam(teamNumber)
        for _ = 1, teamCount - teamPlayerCount do
            GameMode:FillTeamWithBot(teamNumber)
        end
    end
end

--- @param teamNumber integer
function GameMode:FillTeamWithBot(teamNumber)
    for playerID = CHC_MAX_PLAYER_COUNT - 1, 0, -1 do
        if PlayerResource:IsFakeClient(playerID) and GameMode.teamSet[playerID] == nil then
            GameMode.teamSet[playerID] = true

            local prevTeam = PlayerResource:GetTeam(playerID)
            PlayerResource:SetCustomTeamAssignment(playerID, teamNumber)

            Timers:CreateTimer(0.05, function()
                local hero = PlayerResource:GetSelectedHeroEntity(playerID)
                if hero ~= nil then
                    hero:SetTeam(teamNumber)
                    return nil
                end
                return 0.01
            end)

            break
        end
    end
end