--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


MatchOutboundApi = MatchOutboundApi or {}

---@param url string
---@param method "POST" | "GET"
---@param matchId integer|Uint64
---@param payload any
---@param callback function?
local function SendMatchRequest(url, method, matchId, payload, callback)
    payload.matchId = tostring(matchId)
    OutboundRequestSender:SendJson(method, url, payload, callback)
end

function MatchOutboundApi:StartMatch(matchId, startRequest, callback)
    SendMatchRequest("/match/start", "POST", matchId, startRequest, callback)
end

function MatchOutboundApi:EndMatch(matchId, callback)
    SendMatchRequest("/match/end", "POST", matchId, {}, callback)
end

function MatchOutboundApi:UpdateMatchPlayerRating(matchId, ratingRequest, callback)
    SendMatchRequest("/match/update-player-rating", "POST", matchId, ratingRequest, callback)
end

function MatchOutboundApi:GetMatchCommand(matchId, callback)
    SendMatchRequest("/match/get-next-command", "POST", matchId, {}, callback)
end

---@param matchId integer|Uint64
---@param matchState MatchState
---@param callback function?
function MatchOutboundApi:SaveMatchState(matchId, matchState, callback)
    SendMatchRequest("/match/save-state", "POST", matchId, matchState, callback)
end

---@param matchId integer|Uint64
---@param payload {connectedPlayers: integer, logs: string}
---@param callback function?
function MatchOutboundApi:Heartbeat(matchId, payload, callback)
    SendMatchRequest("/match/heartbeat", "POST", matchId, payload, callback)
end