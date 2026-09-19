--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function GameMode:SetTeam()
	GameRulesCustom.sEarlyLeavePlayerSteamIds = {}

	local match = self:GetMatch()
	match:ResetRoster()

	local spawns = Entities:FindAllByClassname("info_player_start_dota") ---@type CBaseEntity[]
	for _, spawn in pairs(spawns) do
		local team = match:AddTeam(spawn:GetTeam())
		team:SetStartLocation(spawn:GetOrigin())
	end

	local playersPerTeam = 1
	local matchType = self:GetMatchType()

	if matchType == MATCH_TYPE_SOLO then
		playersPerTeam = 1
	elseif matchType == MATCH_TYPE_DUO then
		playersPerTeam = 2
	end

	for teamId, team in pairs(match:GetTeams()) do
		GameRulesCustom:SetCustomGameTeamMaxPlayers(teamId, playersPerTeam)

		local centerEntity = Entities:FindByName(nil, "center_" .. teamId)
		if IsValid(centerEntity) then ---@cast centerEntity CBaseEntity
			team:SetLocation(centerEntity:GetOrigin())
		else
			logger:Log("[SetTeam] Warning: center_" .. teamId .. " not found.")
			team:SetLocation(Vector(0, 0, 0))
		end

		ExtraCreature.teamCreatureMap[teamId] = {}
	end
end

function GameMode:ValidateTeams()
	for teamId, team in pairs(self:GetMatch():GetTeams()) do
		if team:IsAlive() then
			local hasHeroes = false
			for i = 1, PlayerResource:GetPlayerCountForTeam(teamId) do
				local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, i)
				local hero = PlayerResource:GetSelectedHeroEntity(playerId)
				if IsValid(hero) or HeroSelectionService:HasPendingForcedHero(playerId) then
					hasHeroes = true
					break
				end
			end
			if not hasHeroes then
				MatchLifecycleService:TeamLose(teamId)
			end
		end
	end
end