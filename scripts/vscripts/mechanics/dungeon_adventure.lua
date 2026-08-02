--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		handleTeamDefeated = function()
			BattleGem:HandleAllPlayersDead()
		end,
	},
}
local s = c()
s.name = "CDungeonAdventure"
d(s, CModule)
function s.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.adventureRuntimes = {}
	self.entranceNpcs = {}
	self.entranceInteractIds = {}
	self.openedAdventureTypes = {}
end
function s.prototype.reset(self)
	self:Reset()
end
function s.prototype.Reset(self)
	self:StopAll("Reset")
end
function s.prototype.StopAll(self, r)
	self:ClearAdventureEntrances()
	do
		local t = 0
		while t < #k do
			local u = k[t + 1]
			l[u]:stop(r)
			t = t + 1
		end
	end
	self.adventureRuntimes = {}
end
function s.prototype.OpenAdventure(self, n, o, v)
	self:ClearAdventureEntrances()
	do
		local t = 0
		while t < #k do
			do
				local u = k[t + 1]
				if self:IsAdventureLocked(u) then
					self:print("冒险入口已被配置关闭 type=" .. u)
					goto w
				end
				local x = l[u].entrance
				if not x:canOpen(n, o) then
					goto w
				end
				local y = v + x.positionOffset
				local z = CreateUnitByName(x.npcName, y, false, nil, nil, DOTA_TEAM_GOODGUYS)
				if not IsValid(z) then
					self:error((("创建冒险入口失败 type=" .. u) .. " npc=") .. x.npcName)
					goto w
				end
				z:AddNewModifier(nil, nil, "modifier_no_health_bar", {})
				local A = Interaction:RegisterInteract(z, InteractType.NPC, 200, function(m, B, C)
					self:EnterBattle(u, C)
				end, 99999999)
				if A ~= -1 then
					Interaction:UpdateInteract(A, { tooltip = x.tooltip, icon = x.icon })
					local D = self.entranceInteractIds
					D[#D + 1] = A
				end
				Npc:AddNpc(z:entindex(), x.npcKey)
				local E = self.entranceNpcs
				E[#E + 1] = z
				self.openedAdventureTypes[u] = true
				self:print((("创建冒险入口成功 type=" .. u) .. " npc=") .. x.npcName)
			end
			::w::
			t = t + 1
		end
	end
end
function s.prototype.ClearAdventureEntrances(self)
	do
		local t = 0
		while t < #self.entranceInteractIds do
			Interaction:UnregisterInteractable(self.entranceInteractIds[t + 1])
			t = t + 1
		end
	end
	self.entranceInteractIds = {}
	do
		local t = 0
		while t < #self.entranceNpcs do
			local F = self.entranceNpcs[t + 1]
			if IsValid(F) then
				F:SafeRemoveUnit()
			end
			t = t + 1
		end
	end
	self.entranceNpcs = {}
	self.openedAdventureTypes = {}
end
function s.prototype.EnterBattle(self, u, G)
	if self:IsAdventureLocked(u) then
		ErrorMessage("Interact_Lock", G)
		return false
	end
	local H = l[u]
	local I = self:GetAdventureRuntime(u)
	if I.state == "running" then
		ErrorMessage("error_adventure_in_progress", G)
		return false
	end
	if I.state == "completed" then
		ErrorMessage("error_adventure_completed", G)
		return false
	end
	if self.openedAdventureTypes[u] ~= true then
		ErrorMessage("Interact_Lock", G)
		return false
	end
	local J = TeamRequestManager:Request({
		requestType = H.requestType,
		requesterPlayerId = G,
		onSuccess = function(m, K)
			self:StartBattle(u, K)
		end,
	})
	if not J then
		ErrorMessage("Interact_Lock", G)
		return false
	end
	return true
end
function s.prototype.ExitBattle(self, u, C)
	local I = self:GetAdventureRuntime(u)
	if I.state ~= "running" then
		return
	end
	if I.returnedPlayerIds[C] == true then
		return
	end
	local L = I.returnPositions[C]
	if L == nil then
		return
	end
	local M = PlayerResource:GetSelectedHeroEntity(C)
	if IsValid(M) then
		FindClearSpaceForUnit(M, L, true)
		M:SetForwardVector(vec3_top)
		M:StartGesture(ACT_DOTA_TELEPORT_END)
	end
	local N = PlayerResource:GetPlayer(C)
	if N ~= nil then
		CustomGameEventManager:Send_ServerToPlayer(
			N,
			"camera_follow_hero",
			{ transitionDuration = 0.2, x = L.x, y = L.y, z = L.z }
		)
	end
	DungeonManager:HideLoadingScreen(C)
	I.returnedPlayerIds[C] = true
	do
		local t = 0
		while t < #I.participantPlayerIds do
			if I.returnedPlayerIds[I.participantPlayerIds[t + 1]] ~= true then
				return
			end
			t = t + 1
		end
	end
	local O = I.returnRoomIndex
	I.state = "completed"
	I.participantPlayerIds = {}
	I.returnPositions = {}
	I.returnRoomIndex = nil
	I.returnedPlayerIds = {}
	l[u]:stop("AllPlayersReturned")
	self:print((("冒险完成并返回 room=" .. tostring((O or -1) + 1)) .. " type=") .. u)
end
function s.prototype.CancelBattle(self, u)
	local I = self:GetAdventureRuntime(u)
	if I.state ~= "running" then
		return
	end
	I.state = "idle"
	I.returnRoomIndex = nil
	I.returnPositions = {}
	I.participantPlayerIds = {}
	I.returnedPlayerIds = {}
	self:print("冒险中断，已清理返回上下文 type=" .. u)
end
function s.prototype.HandleTeamDefeated(self)
	do
		local t = 0
		while t < #k do
			do
				local u = k[t + 1]
				local I = self:GetAdventureRuntime(u)
				if I.state ~= "running" then
					goto P
				end
				local Q
				Q = l[u]
				local R = Q.handleTeamDefeated
				if R ~= nil then
					R(Q)
				end
				return true
			end
			::P::
			t = t + 1
		end
	end
	return false
end
function s.prototype.StartBattle(self, u, p)
	if self:IsAdventureLocked(u) then
		return false
	end
	local H = l[u]
	local I = self:GetAdventureRuntime(u)
	if I.state ~= "idle" then
		return false
	end
	if self.openedAdventureTypes[u] ~= true then
		return false
	end
	local S = {}
	do
		local t = 0
		while t < #p do
			do
				local C = p[t + 1]
				local M = PlayerResource:GetSelectedHeroEntity(C)
				if not IsValid(M) or not M:IsRealHero() or M:GetTeamNumber() ~= DOTA_TEAM_GOODGUYS then
					goto T
				end
				local U = M:GetAbsOrigin()
				S[C] = Vector(U.x, U.y, U.z)
			end
			::T::
			t = t + 1
		end
	end
	if #p <= 0 then
		return false
	end
	local q = DungeonManager:GetAdventureLoadPosition(H.loadPositionOffset)
	if q == nil then
		self:error("冒险缺少可用战场位置 type=" .. u)
		return false
	end
	I.state = "running"
	I.returnRoomIndex = DungeonManager:GetRoomIndex()
	I.returnPositions = S
	I.participantPlayerIds = e(p)
	I.returnedPlayerIds = {}
	H:start(p, q)
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
											) .. u
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
function s.prototype.CreateAdventureRuntime(self)
	return { state = "idle", returnRoomIndex = nil, returnPositions = {}, participantPlayerIds = {}, returnedPlayerIds = {} }
end
function s.prototype.GetAdventureRuntime(self, u)
	if self.adventureRuntimes == nil then
		self.adventureRuntimes = {}
	end
	local V = self.adventureRuntimes[u]
	if V ~= nil then
		return V
	end
	local W = self:CreateAdventureRuntime()
	self.adventureRuntimes[u] = W
	return W
end
function s.prototype.IsAdventureLocked(self, u)
	return KeyValues.game_setting.adventureLocks[u] == true
end
s = f({ j }, s)
if DungeonAdventure == nil then
	DungeonAdventure = g(s)
end
return h