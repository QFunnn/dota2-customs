--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GameMode:SetTeam()
    GameRulesCustom.sEarlyLeavePlayerSteamIds = {}

    self.teamList = {} ---@type table<integer, integer>
    self.teamPlayerMap = {}
    self.aliveTeamMap = {} ---@type table<integer, boolean>
    self.placeTeamMap = {}
    self.playerPlaceMap = {} ---@type table<integer, integer>

    self.place = 0
    self.validTeamNumber = 0
    self.validPlayerCount = 0
    self.teamLocationMap = {} ---@type table<integer, Vector>
    self.teamStartLocationMap = {} ---@type table<integer, Vector>

    local spawns = Entities:FindAllByClassname("info_player_start_dota") ---@type CBaseEntity[]
    for _, spawn  in pairs(spawns) do
        local teamID = spawn:GetTeam()
        table.insert(self.teamList, teamID)
        self.teamStartLocationMap[teamID] = spawn:GetOrigin()
    end

    local playersPerTeam = 1
    local matchType = self:GetMatchType()

    if matchType == MATCH_TYPE_SOLO then
        playersPerTeam = 1
    elseif matchType == MATCH_TYPE_DUO then
        playersPerTeam = 2
    end

    for _, teamID in ipairs(self.teamList) do
        GameRulesCustom:SetCustomGameTeamMaxPlayers(teamID, playersPerTeam)
        self.aliveTeamMap[teamID] = false
        self.teamPlayerMap[teamID] = {}

        local centerEntity = Entities:FindByName(nil, "center_" .. teamID)
        if IsValid(centerEntity) then ---@cast centerEntity CBaseEntity
            self.teamLocationMap[teamID] = centerEntity:GetOrigin()
        else
            logger:Log("[SetTeam] Warning: center_" .. teamID .. " not found.")
            self.teamLocationMap[teamID] = Vector(0, 0, 0)
        end

        ExtraCreature.teamCreatureMap[teamID] = {}
    end
end

function GameMode:ValidateTeams()
    for teamID, isAlive in pairs(self.aliveTeamMap) do
        if isAlive then
            local hasHeroes = false
            for i = 1, PlayerResource:GetPlayerCountForTeam(teamID) do
                local playerID = PlayerResource:GetNthPlayerIDOnTeam(teamID, i)
                local hero = PlayerResource:GetSelectedHeroEntity(playerID)
                if IsValid(hero) then
                    hasHeroes = true
                    break
                end
            end
            if not hasHeroes then
                self:TeamLose(teamID)
            end
        end
    end
end