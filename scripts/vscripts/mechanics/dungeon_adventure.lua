--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "mechanics/dungeon_adventure"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArraySlice
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = { "gem" }
local l = {
	gem = {
		requestType = "gem_enter",
		requestText = {
			title = "#GemBattleRequestTitle",
			subtitle = "#GemBattleRequestSubtitle",
			cancel = "#Popup_Button_Rejected",
			pendingInitiator = "#GemBattleRequestWaiting",
			pendingOther = "#GemBattleRequestConfirm",
			success = "#GemBattleRequestAccepted",
			rejected = "#GemBattleRequestRejected",
			timeout = "#GemBattleRequestTimeout",
		},
		loadPositionOffset = 1,
		entrance = {
			npcName = "npc_farmer",
			positionOffset = Vector(-400, 400, 0),
			tooltip = "gem_entrance",
			icon = "city",
			npcKey = "gem_entrance",
			canOpen = function(m, n, o)
				return DungeonManager:IsFinalZone(n)
					and o == RoomType.STAIR
					and BattleGem:HasDifficultyConfig(GameRules:GetCustomGameDifficulty())
			end,
		},
		start = function(m, p, q)
			BattleGem:Start(GameRules:GetCustomGameDifficulty(), p, q)
		end,
		stop = function(m, r)
			BattleGem:Stop(r, { unloadScene = true })
		end,
		isRunning = function(m, s)
			return BattleGem:IsRunning(s)
		end,
		handleTeamDefeated = function()
			BattleGem:HandleAllPlayersDead()
		end,
	},
}
local t = c()
t.name = "CDungeonAdventure"
d(t, CModule)
function t.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.adventureRuntimes = {}
	self.entranceNpcs = {}
	self.entranceInteractIds = {}
	self.openedAdventureTypes = {}
end
function t.prototype.reset(self)
	self:Reset()
end
function t.prototype.Reset(self)
	self:StopAll("Reset")
end
function t.prototype.StopAll(self, r)
	self:ClearAdventureEntrances()
	do
		local u = 0
		while u < #k do
			local v = k[u + 1]
			l[v]:stop(r)
			u = u + 1
		end
	end
	self.adventureRuntimes = {}
end
function t.prototype.OpenAdventure(self, n, o, w)
	self:ClearAdventureEntrances()
	do
		local u = 0
		while u < #k do
			do
				local v = k[u + 1]
				if self:IsAdventureLocked(v) then
					self:print("冒险入口已被配置关闭 type=" .. v)
					goto x
				end
				local y = l[v].entrance
				if not y:canOpen(n, o) then
					goto x
				end
				local z = w + y.positionOffset
				local A = CreateUnitByName(y.npcName, z, false, nil, nil, DOTA_TEAM_GOODGUYS)
				if not IsValid(A) then
					self:error((("创建冒险入口失败 type=" .. v) .. " npc=") .. y.npcName)
					goto x
				end
				A:AddNewModifier(nil, nil, "modifier_no_health_bar", {})
				local B = Interaction:RegisterInteract(A, InteractType.NPC, 200, function(m, C, s)
					self:EnterBattle(v, s)
				end, 99999999)
				if B == -1 then
					self:error((("创建冒险入口交互失败 type=" .. v) .. " npc=") .. y.npcName)
					A:SafeRemoveUnit()
					goto x
				end
				Interaction:UpdateInteract(B, { tooltip = y.tooltip, icon = y.icon })
				local D = self.entranceInteractIds
				D[#D + 1] = B
				Npc:AddNpc(A:entindex(), y.npcKey)
				local E = self.entranceNpcs
				E[#E + 1] = A
				self.openedAdventureTypes[v] = true
				self:print((("创建冒险入口成功 type=" .. v) .. " npc=") .. y.npcName)
			end
			::x::
			u = u + 1
		end
	end
end
function t.prototype.ClearAdventureEntrances(self)
	do
		local u = 0
		while u < #self.entranceInteractIds do
			local F = self.entranceInteractIds[u + 1]
			Interaction:UnregisterInteractable(F)
			Npc:RemoveNpc(F)
			u = u + 1
		end
	end
	self.entranceInteractIds = {}
	do
		local u = 0
		while u < #self.entranceNpcs do
			local G = self.entranceNpcs[u + 1]
			if IsValid(G) then
				G:SafeRemoveUnit()
			end
			u = u + 1
		end
	end
	self.entranceNpcs = {}
	self.openedAdventureTypes = {}
end
function t.prototype.EnterBattle(self, v, H)
	local I = l[v]
	local J = self:GetAdventureRuntime(v)
	if J.state == "running" then
		ErrorMessage("error_adventure_in_progress", H)
		return false
	end
	if J.state == "completed" then
		ErrorMessage("error_adventure_completed", H)
		return false
	end
	local K = TeamRequestManager:Request({
		requestType = I.requestType,
		requesterPlayerId = H,
		text = I.requestText,
		successPolicy = "any",
		onSuccess = function(m, L)
			self:StartBattle(v, L)
		end,
		onFailed = function(m, r)
			if r == "rejected" then
				self:MarkAdventureCompletedAfterRejection(v)
			end
		end,
	})
	if not K then
		ErrorMessage("error_team_request_pedding", H)
		return false
	end
	return true
end
function t.prototype.AreOpenedAdventuresCompleted(self)
	do
		local u = 0
		while u < #k do
			local v = k[u + 1]
			if self.openedAdventureTypes[v] == true and not self:IsAdventureCompleted(v) then
				return false
			end
			u = u + 1
		end
	end
	return true
end
function t.prototype.IsAdventureCompleted(self, v)
	return self:GetAdventureRuntime(v).state == "completed"
end
function t.prototype.IsPlayerInRunningAdventure(self, s)
	if s == nil then
		return false
	end
	do
		local u = 0
		while u < #k do
			local v = k[u + 1]
			if l[v]:isRunning(s) then
				return true
			end
			u = u + 1
		end
	end
	return false
end
function t.prototype.ExitBattle(self, v, s)
	local J = self:GetAdventureRuntime(v)
	if J.state ~= "running" then
		return
	end
	if J.returnedPlayerIds[s] == true then
		return
	end
	local M = J.returnPositions[s]
	if M == nil then
		return
	end
	local N = PlayerResource:GetSelectedHeroEntity(s)
	if IsValid(N) then
		FindClearSpaceForUnit(N, M, true)
		N:SetForwardVector(vec3_top)
		N:StartGesture(ACT_DOTA_TELEPORT_END)
	end
	local O = PlayerResource:GetPlayer(s)
	if O ~= nil then
		CustomGameEventManager:Send_ServerToPlayer(
			O,
			"camera_follow_hero",
			{ transitionDuration = 0.2, x = M.x, y = M.y, z = M.z }
		)
	end
	DungeonManager:HideLoadingScreen(s)
	J.returnedPlayerIds[s] = true
	do
		local u = 0
		while u < #J.participantPlayerIds do
			if J.returnedPlayerIds[J.participantPlayerIds[u + 1]] ~= true then
				return
			end
			u = u + 1
		end
	end
	local P = J.returnRoomIndex
	J.state = "completed"
	J.participantPlayerIds = {}
	J.returnPositions = {}
	J.returnRoomIndex = nil
	J.returnedPlayerIds = {}
	l[v]:stop("AllPlayersReturned")
	self:print((("冒险完成并返回 room=" .. tostring((P or -1) + 1)) .. " type=") .. v)
end
function t.prototype.CancelBattle(self, v)
	local J = self:GetAdventureRuntime(v)
	if J.state ~= "running" then
		return
	end
	J.state = "idle"
	J.returnRoomIndex = nil
	J.returnPositions = {}
	J.participantPlayerIds = {}
	J.returnedPlayerIds = {}
	self:print("冒险中断，已清理返回上下文 type=" .. v)
end
function t.prototype.HandleTeamDefeated(self)
	do
		local u = 0
		while u < #k do
			do
				local v = k[u + 1]
				local J = self:GetAdventureRuntime(v)
				if J.state ~= "running" then
					goto Q
				end
				local R
				R = l[v]
				local S = R.handleTeamDefeated
				if S ~= nil then
					S(R)
				end
				return true
			end
			::Q::
			u = u + 1
		end
	end
	return false
end
function t.prototype.StartBattle(self, v, p)
	local I = l[v]
	local J = self:GetAdventureRuntime(v)
	if J.state ~= "idle" then
		return false
	end
	local T = {}
	do
		local u = 0
		while u < #p do
			do
				local s = p[u + 1]
				local N = PlayerResource:GetSelectedHeroEntity(s)
				if not IsValid(N) or not N:IsRealHero() or N:GetTeamNumber() ~= DOTA_TEAM_GOODGUYS then
					goto U
				end
				local V = N:GetAbsOrigin()
				T[s] = Vector(V.x, V.y, V.z)
			end
			::U::
			u = u + 1
		end
	end
	if #p <= 0 then
		return false
	end
	local q = DungeonManager:GetAdventureLoadPosition(I.loadPositionOffset)
	if q == nil then
		self:error("冒险缺少可用战场位置 type=" .. v)
		return false
	end
	J.state = "running"
	J.returnRoomIndex = DungeonManager:GetRoomIndex()
	J.returnPositions = T
	J.participantPlayerIds = e(p)
	J.returnedPlayerIds = {}
	I:start(p, q)
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
												("进入冒险 room=" .. tostring(DungeonManager:GetRoomIndex() + 1))
												.. " type="
											) .. v
										) .. " players="
									) .. table.concat(p, ",")
								) .. " load=("
							) .. tostring(q.x)
						) .. ","
					) .. tostring(q.y)
				) .. ","
			) .. tostring(q.z)
		) .. ")"
	)
	return true
end
function t.prototype.MarkAdventureCompletedAfterRejection(self, v)
	local J = self:GetAdventureRuntime(v)
	if J.state ~= "idle" then
		return
	end
	J.state = "completed"
	J.returnRoomIndex = nil
	J.returnPositions = {}
	J.participantPlayerIds = {}
	J.returnedPlayerIds = {}
	self:print("冒险请求被拒绝，标记为已完成 type=" .. v)
end
function t.prototype.CreateAdventureRuntime(self)
	return { state = "idle", returnRoomIndex = nil, returnPositions = {}, participantPlayerIds = {}, returnedPlayerIds = {} }
end
function t.prototype.GetAdventureRuntime(self, v)
	if self.adventureRuntimes == nil then
		self.adventureRuntimes = {}
	end
	local W = self.adventureRuntimes[v]
	if W ~= nil then
		return W
	end
	local X = self:CreateAdventureRuntime()
	self.adventureRuntimes[v] = X
	return X
end
function t.prototype.IsAdventureLocked(self, v)
	return KeyValues.game_setting.adventureLocks[v] == true
end
t = f({ j }, t)
if DungeonAdventure == nil then
	DungeonAdventure = g(t)
end
return h