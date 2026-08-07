--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/team_request_manager"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArraySlice
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = c()
k.name = "CTeamRequestManager"
d(k, CModule)
function k.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.logPrefix = "[TeamRequestManager]"
	self.closeDelaySeconds = 1.5
	self.requestSequence = 0
end
function k.prototype.init(self, l)
	if not l then
		self:ResetRuntimeState()
	end
	CustomUIEvent("team_request_response", function(self, ...)
		return self:OnTeamRequestResponse(...)
	end, self)
	self:SyncNetTable()
end
function k.prototype.reset(self)
	self:ResetRuntimeState()
	self:SyncNetTable()
end
function k.prototype.Request(self, m)
	if self.currentRequest ~= nil then
		return false
	end
	local n = m.invitedPlayerIds or self:GetOnlinePlayerIds()
	if not self:IsValidPlayerIdList(n) then
		return false
	end
	if not self:ContainsPlayerId(n, m.requesterPlayerId) then
		return false
	end
	self:StopTimeoutTimer()
	self:StopCloseTimer()
	local o = e(n)
	local p = {}
	do
		local q = 0
		while q < #o do
			p[o[q + 1]] = "Pending"
			q = q + 1
		end
	end
	local r = GameRules:GetGameTime()
	local s = m.durationSeconds or 10
	local t = tostring(self.requestSequence + 1)
	self.requestSequence = self.requestSequence + 1
	self.currentRequest = {
		requestId = t,
		requestType = m.requestType,
		requesterPlayerId = m.requesterPlayerId,
		invitedPlayerIds = o,
		playerResponses = p,
		startTime = r,
		endTime = r + s,
		state = "pending",
		successPolicy = m.successPolicy or "all",
		onSuccess = m.onSuccess,
		onFailed = m.onFailed,
	}
	self:print(
		(
			(
				(
					((((self.logPrefix .. " request start type=") .. m.requestType) .. " requestId=") .. t)
					.. " requester="
				) .. tostring(m.requesterPlayerId)
			) .. " invited="
		) .. table.concat(o, ",")
	)
	self:SyncNetTable()
	self.timeoutTimerId = Timer:GameTimer(s, function()
		self:ResolveCurrentRequest(false, "timeout")
	end)
	return true
end
function k.prototype.OnTeamRequestResponse(self, u)
	if self.currentRequest == nil or self.currentRequest.state ~= "pending" then
		return
	end
	if u.requestId ~= nil and u.requestId ~= self.currentRequest.requestId then
		return
	end
	if not self:ContainsPlayerId(self.currentRequest.invitedPlayerIds, u.PlayerID) then
		return
	end
	local v = self.currentRequest.playerResponses[u.PlayerID]
	if v ~= "Pending" then
		return
	end
	local w = u.result == "accepted" and "Ready" or "Rejected"
	self.currentRequest.playerResponses[u.PlayerID] = w
	local x = self:IsSuccessConditionMet()
	local y = self:HasRejected()
	self:print(
		(
			(
				(
					(
						(
							(
								(
									(
										(
											(
												(
													(
														(self.logPrefix .. " request response type=")
														.. self.currentRequest.requestType
													) .. " requestId="
												) .. self.currentRequest.requestId
											) .. " player="
										) .. tostring(u.PlayerID)
									) .. " response="
								) .. w
							) .. " successPolicy="
						) .. self.currentRequest.successPolicy
					) .. " successConditionMet="
				) .. tostring(x)
			) .. " hasRejected="
		) .. tostring(y)
	)
	self:SyncNetTable()
	if y then
		self:ResolveCurrentRequest(false, "rejected")
		return
	end
	if x then
		self:ResolveCurrentRequest(true)
	end
end
function k.prototype.ResolveCurrentRequest(self, z, A)
	if self.currentRequest == nil then
		return
	end
	self:StopTimeoutTimer()
	self:StopCloseTimer()
	if z then
		self.currentRequest.state = "success"
		self.currentRequest.failReason = nil
		self.currentRequest.closeTime = GameRules:GetGameTime() + self.closeDelaySeconds
		local n = e(self.currentRequest.invitedPlayerIds)
		local B = self.currentRequest.onSuccess
		self:print(
			(
				(
					(((self.logPrefix .. " request success type=") .. self.currentRequest.requestType) .. " requestId=")
					.. self.currentRequest.requestId
				) .. " invited="
			) .. table.concat(n, ",")
		)
		self:SyncNetTable()
		self.closeTimerId = Timer:GameTimer(self.closeDelaySeconds, function()
			self:ClearCurrentRequest()
			self:SyncNetTable()
		end)
		if B ~= nil then
			B(nil, n)
		end
		return
	end
	self.currentRequest.state = "failed"
	self.currentRequest.failReason = A
	self.currentRequest.closeTime = GameRules:GetGameTime() + self.closeDelaySeconds
	local C = self.currentRequest.onFailed
	self:print(
		(
			(
				(((self.logPrefix .. " request failed type=") .. self.currentRequest.requestType) .. " requestId=")
				.. self.currentRequest.requestId
			) .. " reason="
		) .. (A or "unknown")
	)
	self:SyncNetTable()
	self.closeTimerId = Timer:GameTimer(self.closeDelaySeconds, function()
		self:ClearCurrentRequest()
		self:SyncNetTable()
	end)
	if C ~= nil and A ~= nil then
		C(nil, A)
	end
end
function k.prototype.SyncNetTable(self)
	if self.currentRequest == nil then
		CustomNetTables:SetNetData("common", "team_request", nil)
		return
	end
	CustomNetTables:SetNetData(
		"common",
		"team_request",
		{
			state = self.currentRequest.state,
			requestId = self.currentRequest.requestId,
			requestType = self.currentRequest.requestType,
			requesterPlayerId = self.currentRequest.requesterPlayerId,
			endTime = self.currentRequest.endTime,
			closeTime = self.currentRequest.closeTime,
			failReason = self.currentRequest.failReason,
			playerResponses = self:CloneResponses(),
		}
	)
end
function k.prototype.CloneResponses(self)
	local D = {}
	if self.currentRequest == nil then
		return D
	end
	do
		local q = 0
		while q < #self.currentRequest.invitedPlayerIds do
			local E = self.currentRequest.invitedPlayerIds[q + 1]
			local F = self.currentRequest.playerResponses[E]
			if F ~= nil then
				D[E] = F
			end
			q = q + 1
		end
	end
	return D
end
function k.prototype.IsAllReady(self)
	if self.currentRequest == nil then
		return false
	end
	do
		local q = 0
		while q < #self.currentRequest.invitedPlayerIds do
			local E = self.currentRequest.invitedPlayerIds[q + 1]
			if self.currentRequest.playerResponses[E] ~= "Ready" then
				return false
			end
			q = q + 1
		end
	end
	return true
end
function k.prototype.IsSuccessConditionMet(self)
	if self.currentRequest == nil then
		return false
	end
	if self.currentRequest.successPolicy ~= "any" then
		return self:IsAllReady()
	end
	do
		local q = 0
		while q < #self.currentRequest.invitedPlayerIds do
			local E = self.currentRequest.invitedPlayerIds[q + 1]
			if self.currentRequest.playerResponses[E] == "Ready" then
				return true
			end
			q = q + 1
		end
	end
	return false
end
function k.prototype.HasRejected(self)
	if self.currentRequest == nil then
		return false
	end
	do
		local q = 0
		while q < #self.currentRequest.invitedPlayerIds do
			local E = self.currentRequest.invitedPlayerIds[q + 1]
			if self.currentRequest.playerResponses[E] == "Rejected" then
				return true
			end
			q = q + 1
		end
	end
	return false
end
function k.prototype.ClearCurrentRequest(self)
	self.currentRequest = nil
	self:StopTimeoutTimer()
	self:StopCloseTimer()
end
function k.prototype.ResetRuntimeState(self)
	self:ClearCurrentRequest()
	self.requestSequence = 0
end
function k.prototype.StopTimeoutTimer(self)
	if self.timeoutTimerId ~= nil then
		Timer:StopTimer(self.timeoutTimerId)
		self.timeoutTimerId = nil
	end
end
function k.prototype.StopCloseTimer(self)
	if self.closeTimerId ~= nil then
		Timer:StopTimer(self.closeTimerId)
		self.closeTimerId = nil
	end
end
function k.prototype.IsValidPlayerIdList(self, G)
	if #G <= 0 then
		return false
	end
	do
		local q = 0
		while q < #G do
			if G[q + 1] == nil then
				return false
			end
			q = q + 1
		end
	end
	return true
end
function k.prototype.ContainsPlayerId(self, G, H)
	do
		local q = 0
		while q < #G do
			if G[q + 1] == H then
				return true
			end
			q = q + 1
		end
	end
	return false
end
function k.prototype.GetOnlinePlayerIds(self)
	local D = {}
	Game:EachPlayer(function(I, E)
		D[#D + 1] = E
	end)
	return D
end
k = f({ j }, k)
if TeamRequestManager == nil then
	TeamRequestManager = g(k)
end
return h