--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Votes == nil then
	Votes = class({})
end

function Votes:Init()
    print("[Votes] Module is active!")
    self.bStarted = true

    CustomGameEventManager:RegisterListener("votes_player_voted", function(source, event) self:OnPlayerVoted(event) end)

    self.VotesProgress = {}
end

function Votes:CreateVote(VoteName, Duration, Exceptions)
    if not VOTES_LIST[VoteName] then return end

    if Duration == nil then
        Duration = 0
    end

    if not self.VotesProgress[VoteName] or self.VotesProgress[VoteName].ended == true then
        self.VotesProgress[VoteName] = {
            default_option = VOTES_LIST[VoteName].default_option,
            force_default_option = VOTES_LIST[VoteName].force_default_option,
            no_one_voted_random_option = VOTES_LIST[VoteName].no_one_voted_random_option,
            ended = false,
            end_time = GameRules:GetGameTime() + Duration,
            exceptions = Exceptions,
            player_votes = {}
        }

        EmitGlobalSound("Loot_Drop_Stinger_Short")

        self:UpdateVoteNetTable(VoteName)

        Timers:CreateTimer(0.1, function()
            Votes:SetupDefaultPlayersVoteTo(VoteName)
        end)

        CustomNetTables:SetTableValue("globals", "vote_"..VoteName.."_settings", VOTES_LIST[VoteName])
    end
end

function Votes:EndVote(VoteName, bNotShowResults, bUseRating)
    if not self.VotesProgress[VoteName] then return 0, {}, 0 end

    local allRelevantVotes = {}
    local i = 0
    for _, VoteID in ipairs(VOTES_LIST[VoteName].options) do
        if not table.contains(self.VotesProgress[VoteName].exceptions, VoteID) then
            i = i + 1
            allRelevantVotes[i] = {
                id = VoteID,
                count = 0,
                rating = 0
            }
        end
    end

    local FindVote = function(VotedOption)
        for _, Info in ipairs(allRelevantVotes) do
            if Info.id == VotedOption then
                return Info
            end
        end
        return nil
    end

    local bAtleastOneVoted = false
    for PlayerID, PlayerVoteInfo in pairs(self.VotesProgress[VoteName].player_votes) do
        local Vote = FindVote(PlayerVoteInfo.voted_option)
        if Players:IsActivePlayer(PlayerID) and Vote ~= nil then
            Vote.count = Vote.count + 1
            Vote.rating = Vote.rating + Server:GetPlayerRating(PlayerID)
            --Для того, чтобы без сервера голос что-то весил
            if not Server:IsPlayerConnectedToServer(PlayerID) then
                Vote.rating = Vote.rating + 1
            end
            bAtleastOneVoted = true
        end
    end

    local SortBy = "count"

    if bUseRating then
        SortBy = "rating"
    end

    table.sort(allRelevantVotes, function(a, b)
        return a[SortBy] > b[SortBy]
	end)

    local ResultOption = allRelevantVotes[1].id
    
    if allRelevantVotes[2] ~= nil and allRelevantVotes[1][SortBy] == allRelevantVotes[2][SortBy] then
        local rOption = allRelevantVotes[RandomInt(1,2)].id
        ResultOption = rOption
    end

    if not bAtleastOneVoted then
        if self.VotesProgress[VoteName].no_one_voted_random_option then
            ResultOption = allRelevantVotes[RandomInt(1, #allRelevantVotes)].id
        else
            ResultOption = self.VotesProgress[VoteName].default_option
        end
    end

    if not bNotShowResults then
        CustomGameEventManager:Send_ServerToAllClients("vote_result_show", {
            vote = VoteName,
            option = ResultOption,
            values = self.VotesProgress[VoteName]
        })
    end

    local VotesCountForResult = 0
    for _, VoteInfo in ipairs(allRelevantVotes) do
        if VoteInfo.id == ResultOption then
            VotesCountForResult = VoteInfo.count
            break
        end
    end

    return ResultOption, self.VotesProgress[VoteName], VotesCountForResult
end

function Votes:ClearVote(VoteName)
    if not self.VotesProgress[VoteName] then return end

    self.VotesProgress[VoteName].ended = true
    self.VotesProgress[VoteName].player_votes = {}

    self:UpdateVoteNetTable(VoteName)
end

function Votes:SetupDefaultPlayerVotes(PlayerID)
    if not Players:IsActivePlayer(PlayerID) then return end

    for VoteName, VoteInfo in pairs(self.VotesProgress) do
        if VoteInfo.default_option ~= nil and VoteInfo.force_default_option == true and self.VotesProgress[VoteName].player_votes[PlayerID] == nil then

            if not table.contains(VoteInfo.exceptions, VoteInfo.default_option) then
                self.VotesProgress[VoteName].player_votes[PlayerID] = {
                    can_vote = true,
                    voted_option = VoteInfo.default_option
                }

                self:UpdateVoteNetTable(VoteName)
            end
        end
    end
end

function Votes:SetupDefaultPlayersVoteTo(VoteName)
    if not self.VotesProgress[VoteName] then return end
    if self.VotesProgress[VoteName].default_option == nil or not self.VotesProgress[VoteName].force_default_option then return end

    if table.contains(self.VotesProgress[VoteName].exceptions, self.VotesProgress[VoteName].default_option) then return end

    for _, PlayerID in ipairs(Players:GetAllActivePlayers(true)) do
        if self.VotesProgress[VoteName].player_votes[PlayerID] == nil then
            self.VotesProgress[VoteName].player_votes[PlayerID] = {
                can_vote = true,
                voted_option = self.VotesProgress[VoteName].default_option
            }
        end
    end

    self:UpdateVoteNetTable(VoteName)
end

function Votes:CancelPlayerVote(PlayerID)
    if Players:IsActivePlayer(PlayerID) then return end

    for VoteName, VoteInfo in pairs(self.VotesProgress) do
        if VoteInfo.player_votes and VoteInfo.player_votes[PlayerID] then
            self.VotesProgress[VoteName].player_votes[PlayerID] = nil

            self:UpdateVoteNetTable(VoteName)
        end
    end
end

function Votes:UpdateVoteNetTable(VoteName)
    if not self.VotesProgress[VoteName] then return end

    CustomNetTables:SetTableValue("globals", "vote_"..VoteName.."_info", self.VotesProgress[VoteName])
end

function Votes:OnPlayerVoted(event)
    local PlayerID = event.PlayerID
    local VoteName = event.VoteName
    local Option = tonumber(event.Option)

    if not Players:IsActivePlayer(PlayerID) then return end

    if not self.VotesProgress[VoteName] then return end

    if not table.contains(VOTES_LIST[VoteName].options, Option) then return end

    if table.contains(self.VotesProgress[VoteName].exceptions, Option) then return end

    if self.VotesProgress[VoteName].player_votes[PlayerID] and self.VotesProgress[VoteName].player_votes[PlayerID].can_vote == false then return end

    self.VotesProgress[VoteName].player_votes[PlayerID] = {
        can_vote = false,
        voted_option = Option
    }

    self:UpdateVoteNetTable(VoteName)
end

if not Votes.bStarted then Votes:Init() end