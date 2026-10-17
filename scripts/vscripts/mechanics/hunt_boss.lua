--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/hunt_boss"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__New
local f = b.__TS__ArrayIncludes
local g = b.__TS__NumberIsFinite
local h = b.__TS__ArrayFilter
local i = b.__TS__ArrayMap
local j = b.__TS__ArraySome
local k = b.__TS__ArraySplice
local l = b.__TS__ObjectAssign
local m = b.__TS__ArraySlice
local n = b.__TS__ArrayIndexOf
local o = b.__TS__Delete
local p = b.__TS__ArrayEvery
local q = b.__TS__StringStartsWith
local r = b.__TS__StringSubstring
local s = b.__TS__StringEndsWith
local t = b.__TS__DecorateLegacy
local u = {}
local v = require("class.weight_pool")
local w = v.CWeightPool
local x = require("lib.tstl-utils")
local y = x.reloadable
local z = require("mechanics.hunt_field_buff")
local A = z.CHuntBossFieldBuffManager
local B = "prefabs/gem_dungeon"
local C = "abyss"
local D = "gem_dungeon_enter"
local E = 64
local F = 30
local G = c()
G.name = "CHuntBossBattle"
d(G, CModule)
function G.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.logPrefix = "[HuntBossBattle]"
	self.runId = 0
	self.waveSpawnId = 0
	self.isLoading = false
	self.isRunning = false
	self.isFinished = false
	self.phase = "inactive"
	self.participantPlayerIds = {}
	self.activeParticipantPlayerIds = {}
	self.entryPositionsByPlayerId = {}
	self.intermissionReadyPlayerIds = {}
	self.enemyPools = {}
	self.levelConfigByNumber = {}
	self.healthFactor = 1
	self.damageFactor = 1
	self.difficultyCooldownReduction = 0
	self.difficultyBossGapAmplify = 0
	self.currentDifficulty = 0
	self.keyIntensitiesByPlayerId = {}
	self.currentLevel = 1
	self.currentWave = 0
	self.maxLevel = 1
	self.pendingEnemySpawnCount = 0
	self.enemies = {}
	self.bossSlots = {}
	self.fieldBuffManager = e(A)
end
function G.prototype.init(self, H)
	self:UnregisterEvents()
	self.startEventId = Event:Register("hunt_boss_start", self.Start, self)
	self.stopEventId = Event:Register("hunt_boss_stop", function(I, J)
		local K
		local L
		L = J.reason
		K = J.unloadScene
		return self:Stop(L, K ~= false)
	end, self)
	self.playerReviveFailedEventId = Event:Register("hunt_boss_player_revive_failed", function(I, M)
		return self:OnPlayerReviveFailed(M.playerID)
	end, self)
	self.intermissionReadyEventId = CustomUIEvent("hunt_boss_intermission_ready", function(M)
		return self:OnIntermissionReady(M.PlayerID)
	end)
	self.intermissionRetreatEventId = CustomUIEvent("hunt_boss_intermission_retreat", function(M)
		return self:OnIntermissionRetreat(M.PlayerID)
	end)
	if not H then
		self:ClearRuntimeState()
	end
end
function G.prototype.DebugStartHuntBoss(self, N)
	if not IsInToolsMode() then
		return
	end
	local O = GameModeManager:GetModeDifficultyProfile(GameModeEnum.HuntBoss)
	local P = O and O.configuredDifficulties
	if not (P and f(O and O.configuredDifficulties, N)) then
		self:error((self.logPrefix .. " invalid hunt difficulty=") .. tostring(N))
		return
	end
	local Q = toFiniteNumber
	local R = KeyValues.hunt_intelligence
	local S = R and R[tostring(N)]
	if S ~= nil then
		S = S.dungeon_diff
	end
	local T = Q(S, 0)
	self:DebugPrepareHuntSave(T, function(I, U, V)
		local W = {}
		self.debugPrepareRequest = W
		local X
		X = function(I, Y)
			if self.debugPrepareRequest ~= W then
				return
			end
			if Y >= #U then
				self.debugPrepareRequest = nil
				local Z = self:StartPreparedHuntBoss(U[1], N, V)
				if not Z.success then
					self:error(
						(
							(
								(((self.logPrefix .. " debug start difficulty=") .. tostring(N)) .. " code=")
								.. tostring(Z.code or "none")
							) .. " reason="
						) .. (Z.reason or "none")
					)
				end
				return
			end
			local _ = U[Y + 1]
			local a0 = math.max(0, 100 - PlayerData:GetServiceItemCount(_, "110025"))
			if a0 == 0 then
				X(nil, Y + 1)
				return
			end
			CommonService:CallAction(
				"/v1/gm/add_item",
				_,
				{ add_items = { { item_id = 110025, amounts = a0 } } },
				function(I, a1, a2)
					if self.debugPrepareRequest ~= W then
						return
					end
					if a2.code ~= 0 and a2.code ~= 200 then
						self.debugPrepareRequest = nil
						self:error(
							(
								(
									(
										((self.logPrefix .. " debug intelligence failed player=") .. tostring(_))
										.. " code="
									) .. tostring(a2.code)
								) .. " message="
							) .. (a2.message or "")
						)
						ErrorMessage("DemoHuntBoss_AddIntelligenceFailed", _)
						return
					end
					CommonService:CommonCallback(_, a2, false)
					X(nil, Y + 1)
				end,
				false
			)
		end
		X(nil, 0)
	end, N)
end
function G.prototype.DebugPrepareHuntSave(self, T, a3, a4)
	if not IsInToolsMode() or self.debugPrepareRequest ~= nil then
		return
	end
	if GameModeManager:IsModeRunning() or GameModeManager:IsModeStarting() then
		self:error(self.logPrefix .. " finish the current game mode before preparing debug hunt saves")
		return
	end
	if not g(T) or T ~= math.floor(T) or T < 1 or T > MAX_DIFFICULTY or KeyValues.difficulty[tostring(T)] == nil then
		self:error((self.logPrefix .. " invalid common difficulty=") .. tostring(T))
		return
	end
	local U = {}
	Game:EachPlayer(function(I, _)
		U[#U + 1] = _
	end)
	if #U == 0 then
		return
	end
	local W = { sourceKey = self:SelectDebugSourceKey() }
	self.debugPrepareRequest = W
	local V = {}
	local X
	X = function(I, Y)
		if self.debugPrepareRequest ~= W then
			return
		end
		if Y >= #U then
			local function a5()
				self.debugPrepareRequest = nil
				if a3 ~= nil then
					a3(nil, U, V)
				end
			end
			if W.commonMatchID ~= nil then
				self:PrepareDebugMatchID(a5)
			else
				a5(nil)
			end
			return
		end
		local _ = U[Y + 1]
		self:EnsureDebugHuntSave(_, T, function(I, a6)
			if self.debugPrepareRequest ~= W then
				return
			end
			if a6 == nil then
				self.debugPrepareRequest = nil
				return
			end
			V[_] = a6
			X(nil, Y + 1)
		end, a4)
	end
	self:PrepareDebugMatchID(function()
		return X(nil, 0)
	end)
end
function G.prototype.PrepareDebugMatchID(self, a3)
	local W = self.debugPrepareRequest
	if not IsInToolsMode() or W == nil then
		return
	end
	if Match:AdvanceMatchID() == nil then
		self.debugPrepareRequest = nil
		self:error(self.logPrefix .. " debug match ID sequence allocation failed")
		return
	end
	a3(nil)
end
function G.prototype.SelectDebugSourceKey(self)
	local a7 = {}
	Game:EachPlayer(function(I, a8)
		local a9 = CommonService:GetPlayerServiceNetTable(a8, "player_keys") or {}
		for aa, ab in pairs(a9) do
			do
				if ab.id <= 0 then
					goto ac
				end
				a7[#a7 + 1] = { key = ab.id, owner_id = a8, key_data = ab }
			end
			::ac::
		end
	end)
	local ad = h(a7, function(I, ae)
		return ae.key_data.intensity >= 1 and ae.key_data.intensity <= 3
	end)
	local af = #ad > 0 and ad or a7
	return #af > 0 and af[RandomInt(0, #af - 1) + 1] or nil
end
function G.prototype.GetPlayerHuntSaves(self, a8)
	local ag = CommonService:GetPlayerServiceNetTable(a8, "player_hunt_save_datas") or {}
	local ah = {}
	for aa, ai in pairs(ag) do
		do
			if ai.diff <= 0 or ai.data == "" then
				goto aj
			end
			ah[tostring(ai.slot_id)] = ai
		end
		::aj::
	end
	return ah
end
function G.prototype.EnsureDebugHuntSave(self, a8, T, a3, a4)
	local W = self.debugPrepareRequest
	local ak
	if a4 ~= nil then
		ak = HuntSaveArchive:GetAutoSelectSlotID(a8, a4)
	else
		ak = nil
	end
	local al = ak
	if al ~= nil then
		a3(nil, al)
		return
	end
	local function am(I, L, an)
		if an == nil then
			an = "DemoHuntBoss_SaveFailed"
		end
		self:error((((self.logPrefix .. " debug save player=") .. tostring(a8)) .. " failed: ") .. L)
		ErrorMessage(an, a8)
		a3(nil)
	end
	local ah = self:GetPlayerHuntSaves(a8)
	local a6 = 1
	while a6 <= 5 and ah[tostring(a6)] ~= nil do
		a6 = a6 + 1
	end
	if a6 > 5 then
		am(nil, "all five save slots are occupied", "DemoHuntBoss_SaveSlotsFull")
		return
	end
	local ao = Player:GetHero(a8)
	if not IsValid(ao) then
		am(nil, "hero is not selected")
		return
	end
	local ap = math.floor(Login:GetServiceTimestamp())
	local aq = W and W.sourceKey
	local ar = aq and aq.key_data.intensity or 0
	local as = ao:GetUnitName()
	local at = math.floor
	local au = DamageCounter:GetPlayerDamageCount(a8)
	local av = {
		time = ap,
		strength = ar,
		hero_name = as,
		total_damage = at(au and au.totalDamage or 0),
		blessings = Bless:GetPlayerBlessDetails(a8),
		artifacts = i(
			h(ao:GetAllItems(), function(I, aw)
				return IsValid(aw) and KeyValues.artifact[aw:GetAbilityName()] ~= nil
			end),
			function(I, aw)
				return { item_name = aw:GetAbilityName(), level = aw:GetLevel() }
			end
		),
		ability_upgrades = i(
			h(AbilityUpgrade:GetAbilityUpgrades(ao), function(I, ax)
				return not AbilityUpgrade:IsServiceUpgrade(ax.name)
			end),
			function(I, ax)
				return { name = ax.name, level = ax.level }
			end
		),
		attributes = HuntSaveArchive:GetAttributes(a8),
	}
	for I, ay in ipairs(Bless:DrawBless(a8, 3) or {}) do
		local az = av.blessings
		az[#az + 1] = { name = ay.name, rarity = ay.rarity }
	end
	local aA = i(av.artifacts, function(I, aB)
		return aB.item_name
	end)
	for I, aB in ipairs(Artifact:DrawArtifact(a8, 3, aA) or {}) do
		local aC = av.artifacts
		aC[#aC + 1] = { item_name = aB.name, level = aB.rarity }
	end
	local aD = {}
	for aE, aF in pairs(AbilityUpgrade.kv) do
		do
			if type(aF) ~= "table" then
				goto aG
			end
			if toFiniteNumber(aF.Hidden, 0) == 1 or AbilityUpgrade:IsServiceUpgrade(aE) then
				goto aG
			end
			if
				not AbilityUpgrade:CanApplyAbilityUpgrade(ao, aE)
				or j(av.ability_upgrades, function(I, ax)
					return ax.name == aE
				end)
			then
				goto aG
			end
			aD[#aD + 1] = aE
		end
		::aG::
	end
	do
		local Y = 0
		while Y < 3 and #aD > 0 do
			local aH = RandomInt(0, #aD - 1)
			local aI = av.ability_upgrades
			aI[#aI + 1] = { name = aD[aH + 1], level = 1 }
			k(aD, aH, 1)
			Y = Y + 1
		end
	end
	local aJ = Match:GetMatchID()
	local function ai()
		local aK = { match_id = aJ, slot_id = a6, data = json.encode(av) }
		CommonService:CallAction("/v1/hunt/save_data", a8, aK, function(I, aL, aM)
			if self.debugPrepareRequest ~= W then
				return
			end
			if aM.code ~= 0 and aM.code ~= 200 then
				am(nil, (("save_data code=" .. tostring(aM.code)) .. " message=") .. (aM.message or ""))
				return
			end
			CommonService:CommonCallback(a8, aM, false)
			a3(nil, a6)
		end, false)
	end
	if (W and W.commonMatchID) == aJ then
		ai(nil)
		return
	end
	local aN = {}
	Game:EachPlayer(function(I, _)
		aN[tostring(PlayerResource:GetSteamAccountID(_))] = { hero_id = PlayerResource:GetSelectedHeroID(_) }
	end)
	local aO = { diff = T }
	if (W and W.sourceKey) ~= nil then
		aO.key_id = W.sourceKey.key
		aO.key_owner_uid = PlayerResource:GetSteamAccountID(W.sourceKey.owner_id)
	end
	local aP = false
	Match:SendMatchBeginRequest(
		{ match_id = aJ, match_type = "common", player_details = aN, common_match_detail = aO },
		function(I, aQ, aR, aS)
			if aP or self.debugPrepareRequest ~= W then
				return
			end
			aP = true
			if not aQ then
				am(nil, (("common match_begin code=" .. tostring(aR or "unknown")) .. " message=") .. (aS or ""))
				return
			end
			if Match:GetMatchID() ~= aJ then
				am(nil, "match_id changed while preparing the source match")
				return
			end
			if W ~= nil then
				W.commonMatchID = aJ
			end
			ai(nil)
		end
	)
end
function G.prototype.StartPreparedHuntBoss(self, a8, N, aT)
	if not IsInToolsMode() then
		return { success = false, reason = "Hunt debug start requires tools mode." }
	end
	local U = {}
	Game:EachPlayer(function(I, _)
		U[#U + 1] = _
	end)
	if not f(U, a8) then
		return {
			success = false,
			reason = ((("Initiator " .. tostring(a8)) .. " is no longer online; players=[") .. table.concat(U, ","))
				.. "].",
		}
	end
	if GameModeManager:IsModeRunning() or GameModeManager:IsModeStarting() then
		return { success = false, reason = "Finish the current game mode before starting a debug hunt." }
	end
	local V = {}
	for I, _ in ipairs(U) do
		local ao = Player:GetHero(_)
		if not IsValid(ao) then
			return { success = false, reason = ("Player " .. tostring(_)) .. " must select a hero first." }
		end
		local aU = aT and aT[_] or HuntSaveArchive:GetAutoSelectSlotID(_, N)
		if aU == nil then
			return { success = false, reason = ("Player " .. tostring(_)) .. " hunt save is not ready." }
		end
		V[_] = aU
	end
	local aV = GameModeManager:SelectMode(GameModeEnum.HuntBoss, a8)
	if not aV.success then
		return l({}, aV, { reason = "SelectMode: " .. (aV.reason or "request rejected") })
	end
	for I, _ in ipairs(U) do
		local Z = GameModeManager:SelectDifficulty(_, N)
		if not Z.success then
			return l(
				{},
				Z,
				{ reason = (("SelectDifficulty player=" .. tostring(_)) .. ": ") .. (Z.reason or "request rejected") }
			)
		end
	end
	local aW = GameModeManager:StartSelectedMode(0, { huntSlotIDs = V })
	return aW.success and aW or l({}, aW, { reason = "StartSelectedMode: " .. (aW.reason or "request rejected") })
end
function G.prototype.reset(self)
	self.debugPrepareRequest = nil
	self:Stop("Reset", true)
end
function G.prototype.Start(self, M)
	self:Stop("Restart", true)
	if not self:LoadConfigs(M.difficulty, #M.participantPlayerIds) then
		return
	end
	local aX, aY = self, "runId"
	local aZ = aX[aY] + 1
	aX[aY] = aZ
	local a_ = aZ
	self.currentDifficulty = M.difficulty
	self:CaptureSaveKeyIntensities(M)
	self.isLoading = true
	self.phase = "loading"
	self.participantPlayerIds = m(M.participantPlayerIds)
	self.activeParticipantPlayerIds = m(M.participantPlayerIds)
	local b0 = Entities:FindByName(nil, C)
	if not IsValid(b0) then
		self:error(((self.logPrefix .. " load point '") .. C) .. "' not found")
		self:Stop("LoadPointMissing", true)
		return
	end
	DungeonManager:ShowLoadingScreen()
	local b1 = b0:GetAbsOrigin()
	self.spawnGroup = DOTA_SpawnMapAtPosition(B, b1, true, function(b2)
		if self:IsActiveRun(a_) then
			ManuallyTriggerSpawnGroupCompletion(b2)
		end
	end, function()
		if self:IsActiveRun(a_) then
			self:OnMapLoaded(a_)
			DungeonManager:HideLoadingScreen()
		end
	end, nil)
end
function G.prototype.OnMapLoaded(self, a_)
	local b3 = self:FindInfoTarget(D)
	if not IsValid(b3) then
		self:error(((self.logPrefix .. " prefab entry '") .. D) .. "' not found")
		self:Stop("EnterPointMissing", true)
		return
	end
	self.battleCenter = b3:GetAbsOrigin()
	self:CaptureEntryPositions()
	self:TeleportPlayers(self.battleCenter)
	self.fieldBuffManager:StartRun(self:GetParticipantHeroes(), self.battleCenter, function()
		return self.enemies
	end)
	self.isLoading = false
	self.isRunning = true
	self.phase = "battle"
	self:RegisterKillListener()
	self:StartLevel(a_, 1)
end
function G.prototype.StartLevel(self, a_, b4)
	local aF = self.levelConfigByNumber[b4]
	if not self:IsActiveRun(a_) or not self.isRunning or aF == nil then
		self:FinishBattle("LevelConfigMissing")
		return
	end
	self.phase = "battle"
	self.currentLevel = b4
	self.currentWave = 0
	if not self.fieldBuffManager:PrepareLevel(b4) then
		self:FinishBattle("FieldBuffConfigInvalid")
		return
	end
	self:SyncState()
	self:StartNextWave(a_, aF)
end
function G.prototype.StartNextWave(self, a_, b5)
	local b6 = b5.waves
	local b7, b8 = self, "currentWave"
	local b9 = b7[b8]
	b7[b8] = b9 + 1
	local ba = b6[b9 + 1]
	if ba == nil then
		self:OnLevelCleared(a_)
		return
	end
	if self.battleCenter == nil or ba.enemyPoolWeights.ValidCount <= 0 then
		self:FinishBattle("WaveConfigInvalid")
		return
	end
	local bb = ba.enemyPoolWeights:Random()
	local bc
	if bb == nil then
		bc = {}
	else
		local bd = self.enemyPools[bb]
		bc = bd and bd:MultipleRandomWithoutReplacement(ba.enemyCount) or {}
	end
	local be = bc
	if #be ~= ba.enemyCount then
		self:FinishBattle("EnemyPoolRollFailed")
		return
	end
	self.fieldBuffManager:StartOrResumeBattle()
	local bf, bg = self, "waveSpawnId"
	local bh = bf[bg] + 1
	bf[bg] = bh
	local bi = bh
	self.pendingEnemySpawnCount = ba.enemyCount
	self.bossSlots = {}
	self:SyncState()
	do
		local Y = 0
		while Y < ba.enemyCount do
			self:SpawnBoss(a_, bi, Y, be[Y + 1], self:GetBossSpawnPosition(self.battleCenter, Y, ba.enemyCount), b5, ba)
			Y = Y + 1
		end
	end
end
function G.prototype.SpawnBoss(self, a_, bi, aU, bj, bk, b5, ba)
	CreateUnitByNameAsync(bj, bk, true, nil, nil, DOTA_TEAM_BADGUYS, function(bl)
		if IsValid(bl) then
			bl:AddNewModifier(bl, nil, "modifier_summon_disabled", {})
		end
		local bm = GameRules:GetGameTime() + 5
		Timer:GameTimer(0, function()
			if not self:IsActiveRun(a_) or not self.isRunning or self.waveSpawnId ~= bi then
				self:RemoveUnit(bl)
				return
			end
			if not IsValid(bl) then
				self:FinishBattle("BossSpawnFailed")
				return
			end
			if not bl.__isNotFirstSpawn or not bl:HasModifier("modifier_common") then
				if GameRules:GetGameTime() >= bm then
					self:error(
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
																		(
																			self.logPrefix
																			.. " boss initialization timed out unit="
																		) .. bj
																	) .. " entIndex="
																) .. tostring(bl:entindex())
															) .. " alive="
														) .. tostring(bl:IsAlive())
													) .. " firstSpawn="
												) .. tostring(bl.__isNotFirstSpawn)
											) .. " common="
										) .. tostring(bl:HasModifier("modifier_common"))
									) .. " engineHealth="
								) .. tostring(bl:GetHealth_Engine())
							) .. " engineMaxHealth="
						) .. tostring(bl:GetMaxHealth_Engine())
					)
					self:RemoveUnit(bl)
					self:FinishBattle("BossInitializationFailed")
					return
				end
				return 0.03
			end
			self.pendingEnemySpawnCount = math.max(0, self.pendingEnemySpawnCount - 1)
			FindClearSpaceForUnit(bl, bk, true)
			bl:SetForwardVector(RandomVector(1))
			self:ApplyBossModifiers(bl, b5, ba)
			do
				local Y = 0
				while Y < bl:GetAbilityCount() do
					do
						local bn = bl:GetAbilityByIndex(Y)
						if not IsValid(bn) then
							goto bo
						end
						bn:EndCooldown()
						bn:StartCooldown(1)
					end
					::bo::
					Y = Y + 1
				end
			end
			LargeNumberHealth:Refresh(bl)
			bl:SetHealth(bl:GetMaxHealth())
			local bp = self.enemies
			bp[#bp + 1] = bl
			self.bossSlots[aU + 1] = bl
			self:SyncState()
			self:TryCompleteCurrentWave(a_)
		end)
	end)
end
function G.prototype.TryCompleteCurrentWave(self, a_)
	if not self.isRunning or self.pendingEnemySpawnCount > 0 or #self.enemies > 0 then
		return
	end
	local b5 = self.levelConfigByNumber[self.currentLevel]
	if b5 == nil then
		self:FinishBattle("LevelConfigMissing")
	elseif self.currentWave < #b5.waves then
		self.fieldBuffManager:PauseBattle()
		self:StartNextWave(a_, b5)
	else
		self:OnLevelCleared(a_)
	end
end
function G.prototype.OnLevelCleared(self, a_)
	self.fieldBuffManager:EndLevel()
	Match:SettleHunt(self.currentLevel, self.activeParticipantPlayerIds)
	if self.currentLevel >= self.maxLevel then
		self:FinishBattle("Completed")
	else
		self:BeginIntermission(a_)
	end
end
function G.prototype.BeginIntermission(self, a_)
	if not self:IsActiveRun(a_) or not self.isRunning then
		return
	end
	if #self.activeParticipantPlayerIds <= 0 then
		self:FinishBattle("AllPlayersRetreated")
		return
	end
	if not self.fieldBuffManager:PrepareNextLevel(self.currentLevel + 1) then
		self:FinishBattle("FieldBuffConfigInvalid")
		return
	end
	self.phase = "intermission"
	self.intermissionReadyPlayerIds = {}
	self.intermissionEndTime = GameRules:GetGameTime() + F
	self:ScheduleIntermissionTimer(a_)
	self:SyncState()
end
function G.prototype.OnIntermissionReady(self, a8)
	if
		not self.isRunning
		or self.phase ~= "intermission"
		or not f(self.activeParticipantPlayerIds, a8)
		or self.intermissionReadyPlayerIds[tostring(a8)]
	then
		return
	end
	self.intermissionReadyPlayerIds[tostring(a8)] = true
	local bq = math.max(0, (self.intermissionEndTime or GameRules:GetGameTime()) - GameRules:GetGameTime())
	self.intermissionEndTime = GameRules:GetGameTime() + bq * 0.5
	if self:AreAllActivePlayersReady() then
		self:StartNextLevel(self.runId)
		return
	end
	self:ScheduleIntermissionTimer(self.runId)
	self:SyncState()
end
function G.prototype.OnIntermissionRetreat(self, a8)
	if not self.isRunning or self.phase ~= "intermission" or not f(self.activeParticipantPlayerIds, a8) then
		return
	end
	if not self:ReturnPlayerToLobby(a8) then
		self:error(((self.logPrefix .. " retreat failed player=") .. tostring(a8)) .. ": lobby position unavailable")
		return
	end
	k(self.activeParticipantPlayerIds, n(self.activeParticipantPlayerIds, a8), 1)
	o(self.intermissionReadyPlayerIds, tostring(a8))
	Event:Fire("hunt_boss_player_retreated", { playerID = a8, level = self.currentLevel })
	if #self.activeParticipantPlayerIds <= 0 then
		self:FinishBattle("AllPlayersRetreated")
		return
	end
	if self:AreAllActivePlayersReady() then
		self:StartNextLevel(self.runId)
		return
	end
	self:SyncState()
end
function G.prototype.OnPlayerReviveFailed(self, a8)
	if
		not self.isRunning
		or self.phase ~= "battle" and self.phase ~= "intermission"
		or not f(self.activeParticipantPlayerIds, a8)
		or not GameModeHuntBoss:IsParticipantActive(a8)
	then
		return
	end
	k(self.activeParticipantPlayerIds, n(self.activeParticipantPlayerIds, a8), 1)
	o(self.intermissionReadyPlayerIds, tostring(a8))
	Event:Fire("hunt_boss_player_failed", { playerID = a8, level = self.currentLevel })
	if not self:ReturnPlayerToLobby(a8, true) then
		self:error((self.logPrefix .. " failed player return to lobby unavailable player=") .. tostring(a8))
	end
	if #self.activeParticipantPlayerIds <= 0 then
		self:FinishBattle("AllPlayersDead")
		return
	end
	if self.phase == "intermission" and self:AreAllActivePlayersReady() then
		self:StartNextLevel(self.runId)
		return
	end
	self:SyncState()
end
function G.prototype.AreAllActivePlayersReady(self)
	return p(self.activeParticipantPlayerIds, function(I, a8)
		return self.intermissionReadyPlayerIds[tostring(a8)] == true
	end)
end
function G.prototype.ScheduleIntermissionTimer(self, a_)
	if self.intermissionTimerId ~= nil then
		Timer:StopTimer(self.intermissionTimerId)
	end
	local br = math.max(0, (self.intermissionEndTime or GameRules:GetGameTime()) - GameRules:GetGameTime())
	self.intermissionTimerId = Timer:GameTimer(br, function()
		self.intermissionTimerId = nil
		if not self:IsActiveRun(a_) or not self.isRunning or self.phase ~= "intermission" then
			return
		end
		for I, a8 in ipairs(self.activeParticipantPlayerIds) do
			self.intermissionReadyPlayerIds[tostring(a8)] = true
		end
		self:StartNextLevel(a_)
	end)
end
function G.prototype.StartNextLevel(self, a_)
	if not self:IsActiveRun(a_) or not self.isRunning or self.phase ~= "intermission" then
		return
	end
	if self.intermissionTimerId ~= nil then
		Timer:StopTimer(self.intermissionTimerId)
		self.intermissionTimerId = nil
	end
	self.intermissionEndTime = nil
	self:StartLevel(a_, self.currentLevel + 1)
end
function G.prototype.ApplyBossModifiers(self, bl, b5, ba)
	bl:AddNewModifier(bl, nil, "modifier_boss_custom", { control_immune = 1 })
	if self.difficultyCooldownReduction ~= 0 then
		bl:AddProperty(PropertyFunction.COOLDOWN_REDUCTION, self.difficultyCooldownReduction)
	end
	if self.difficultyBossGapAmplify ~= 0 then
		bl:AddProperty(PropertyFunction.BOSS_GAP_AMPLIFY, self.difficultyBossGapAmplify)
	end
	local bs = self.healthFactor * b5.healthFactor * ba.healthFactor
	local bt = self.damageFactor * b5.damageFactor
	if bs ~= 1 then
		bl:AddProperty(PropertyFunction.HEALTH_AMPLIFY, (bs - 1) * 100)
	end
	if bt ~= 1 then
		bl:AddProperty(PropertyFunction.ATTACK_AMPLIFY, (bt - 1) * 100)
	end
end
function G.prototype.FinishBattle(self, L)
	if self.isFinished then
		return
	end
	self.isFinished = true
	self.isRunning = false
	self.phase = "finished"
	self.finishReason = L
	self.waveSpawnId = self.waveSpawnId + 1
	if self.intermissionTimerId ~= nil then
		Timer:StopTimer(self.intermissionTimerId)
		self.intermissionTimerId = nil
	end
	self.intermissionEndTime = nil
	for I, bl in ipairs(self.enemies) do
		self:RemoveUnit(bl)
	end
	self.enemies = {}
	self.bossSlots = {}
	self.fieldBuffManager:Reset()
	self:SyncState()
	Event:Fire("hunt_boss_battle_finished", { reason = L, level = self.currentLevel })
end
function G.prototype.RegisterKillListener(self)
	if self.killEventListenerId ~= nil then
		StopGameEvent(self.killEventListenerId)
	end
	self.killEventListenerId = GameEvent("entity_killed", function(self, ...)
		return self:OnEntityKilled(...)
	end, self)
end
function G.prototype.OnEntityKilled(self, M)
	if not self.isRunning then
		return
	end
	local bu = EntIndexToHScript(M.entindex_killed)
	local Y = IsValid(bu) and n(self.enemies, bu) or -1
	if Y >= 0 then
		k(self.enemies, Y, 1)
		local aU = n(self.bossSlots, bu)
		if aU >= 0 then
			self.bossSlots[aU + 1] = nil
		end
		self:SyncState()
		self:TryCompleteCurrentWave(self.runId)
	end
end
function G.prototype.LoadConfigs(self, N, bv)
	self.enemyPools = {}
	self.levelConfigByNumber = {}
	if not self.fieldBuffManager:LoadConfigs(N) then
		return false
	end
	local bw = KeyValues.hunt_enemy_pools
	local bx = bw.EnemyPools
	if bx == nil then
		self:error(self.logPrefix .. " hunt_enemy_pools missing")
		return false
	end
	for bb, by in pairs(bx) do
		do
			local bz = e(w)
			if by == nil then
				goto bA
			end
			for bj, bB in pairs(by) do
				bz:Set(tostring(bj), toFiniteNumber(bB, 0))
			end
			if bz.ValidCount > 0 then
				self.enemyPools[tostring(bb)] = bz
			end
		end
		::bA::
	end
	local bC = KeyValues.hunt_levels
	if bC == nil then
		self:error(self.logPrefix .. " hunt_levels missing")
		return false
	end
	for bD, bE in pairs(bC) do
		do
			local ae = tostring(bD)
			if not q(ae, "level_") then
				goto bF
			end
			local b4 = toFiniteNumber(r(ae, #"level_"), 0)
			local bG = {}
			if bE == nil then
				goto bF
			end
			local bH = bE.WaveList
			do
				local bI = 1
				while (bH and bH[tostring(bI)]) ~= nil do
					do
						local bJ = bH[tostring(bI)]
						if bJ == nil then
							goto bK
						end
						local bL = e(w)
						for bb, bB in pairs(bJ.EnemyPoolWeights or {}) do
							local aE = tostring(bb)
							if self.enemyPools[aE] == nil then
								self:error(
									(
										(
											(
												((self.logPrefix .. " invalid pool reference level=") .. tostring(b4))
												.. " wave="
											) .. tostring(bI)
										) .. " pool="
									) .. aE
								)
								return false
							end
							bL:Set(aE, toFiniteNumber(bB, 0))
						end
						local bM = math.floor(toFiniteNumber(bJ.EnemyCount, 0))
						if bL.ValidCount <= 0 or bM <= 0 then
							self:error(
								(((self.logPrefix .. " invalid wave level=") .. tostring(b4)) .. " wave=")
									.. tostring(bI)
							)
							return false
						end
						bG[#bG + 1] = {
							enemyPoolWeights = bL,
							enemyCount = bM,
							healthFactor = math.max(0.01, toFiniteNumber(bJ.HealthFactor, 1)),
						}
					end
					::bK::
					bI = bI + 1
				end
			end
			if b4 >= 1 and #bG > 0 then
				self.levelConfigByNumber[b4] = {
					healthFactor = math.max(0.01, toFiniteNumber(bE.HealthFactor, 1)),
					damageFactor = math.max(0.01, toFiniteNumber(bE.DamageFactor, 1)),
					waves = bG,
				}
			end
		end
		::bF::
	end
	local bN = KeyValues.hunt_difficulty
	local bO = bN and bN[tostring(N)]
	if bO == nil then
		self:error((self.logPrefix .. " hunt_difficulty missing difficulty=") .. tostring(N))
		return false
	end
	local bP = KeyValues.hunt_intelligence
	local bQ = bP and bP[tostring(N)]
	local bR = toFiniteNumber
	local bS
	if bQ ~= nil then
		bS = bQ.level_max
	end
	self.maxLevel = bR(bS, 0)
	if self.maxLevel <= 0 or self.maxLevel ~= math.floor(self.maxLevel) then
		self:error((self.logPrefix .. " hunt_intelligence invalid level_max difficulty=") .. tostring(N))
		return false
	end
	do
		local b4 = 1
		while b4 <= self.maxLevel do
			if self.levelConfigByNumber[b4] == nil then
				self:error(
					(
						(
							(self.logPrefix .. " hunt_levels missing valid level configuration difficulty=")
							.. tostring(N)
						) .. " level="
					) .. tostring(b4)
				)
				return false
			end
			b4 = b4 + 1
		end
	end
	local bT = math.min(math.max(bv, 1), 4)
	self.healthFactor = toFiniteNumber(bO.HealthFactor, 1)
		* (bT >= 2 and toFiniteNumber(bO[("Player" .. tostring(bT)) .. "HealthFactor"], 1) or 1)
	self.damageFactor = toFiniteNumber(bO.DamageFactor, 1)
		* (bT >= 2 and toFiniteNumber(bO[("Player" .. tostring(bT)) .. "DamageFactor"], 1) or 1)
	self.difficultyCooldownReduction = math.min(99, math.max(0, toFiniteNumber(bO.BossCooldownReduction, 0)))
	self.difficultyBossGapAmplify = -self.difficultyCooldownReduction
	return true
end
function G.prototype.GetBossSpawnPosition(self, bU, Y, bV)
	return Vector(bU.x + (Y - (bV - 1) / 2) * 720, bU.y + 480, bU.z)
end
function G.prototype.Stop(self, L, K)
	local bW = self.isLoading
	self.runId = self.runId + 1
	self.waveSpawnId = self.waveSpawnId + 1
	if self.killEventListenerId ~= nil then
		StopGameEvent(self.killEventListenerId)
		self.killEventListenerId = nil
	end
	for I, bl in ipairs(self.enemies) do
		self:RemoveUnit(bl)
	end
	if K and self.spawnGroup ~= nil then
		UnloadSpawnGroupByHandle(self.spawnGroup)
	end
	self:ClearRuntimeState()
	if bW then
		DungeonManager:HideLoadingScreen()
	end
end
function G.prototype.TeleportPlayers(self, bk)
	local bX = self:GetParticipantHeroes()
	do
		local bY = 0
		while bY < #bX do
			local bZ = Vector(bk.x + (bY - (#bX - 1) / 2) * E, bk.y, bk.z)
			FindClearSpaceForUnit(bX[bY + 1], bZ, true)
			bX[bY + 1]:SetForwardVector(vec3_top)
			bY = bY + 1
		end
	end
end
function G.prototype.ReturnPlayerToLobby(self, a8, b_)
	if b_ == nil then
		b_ = false
	end
	local ao = PlayerResource:GetSelectedHeroEntity(a8)
	if not IsValid(ao) then
		return false
	end
	local bk = self.entryPositionsByPlayerId[tostring(a8)]
	if bk == nil then
		return false
	end
	self.fieldBuffManager:RemoveHero(ao)
	ao:SetRespawnPosition(bk)
	Npc:SetPlayerArea(a8, "lobby")
	if b_ and not ao:IsAlive() then
		ao:RespawnHero(false, false)
	end
	FindClearSpaceForUnit(ao, bk, true)
	Event:Fire("teleport", { caster = ao, target = "lobby" })
	return true
end
function G.prototype.CaptureSaveKeyIntensities(self, M)
	self.keyIntensitiesByPlayerId = {}
	for I, a8 in ipairs(M.participantPlayerIds) do
		do
			local c0 = M.huntSlotIDs
			local a6 = c0 and c0[a8]
			if a6 == nil then
				goto c1
			end
			local ai = HuntSaveArchive:GetSelectedSave(a8, a6)
			if ai == nil then
				goto c1
			end
			local c2 = json.decode(ai.data)
			local av = c2
			if (av and av.strength) == nil then
				goto c1
			end
			local c3 = toFiniteNumber(av.strength, -1)
			if c3 >= 0 then
				self.keyIntensitiesByPlayerId[tostring(a8)] = math.floor(c3)
			end
		end
		::c1::
	end
end
function G.prototype.CaptureEntryPositions(self)
	self.entryPositionsByPlayerId = {}
	for I, a8 in ipairs(self.participantPlayerIds) do
		local ao = PlayerResource:GetSelectedHeroEntity(a8)
		if IsValid(ao) then
			self.entryPositionsByPlayerId[tostring(a8)] = ao:GetAbsOrigin()
		end
	end
end
function G.prototype.SyncState(self)
	local c4 = {}
	local c5 = {}
	for I, a8 in ipairs(self.activeParticipantPlayerIds) do
		c4[tostring(a8)] = self.intermissionReadyPlayerIds[tostring(a8)] == true
	end
	do
		local aU = 0
		while aU < #self.bossSlots do
			local c6 = self.bossSlots[aU + 1]
			if c6 ~= nil and IsValid(c6) then
				c5[#c5 + 1] = { slot = aU, ent_index = c6:entindex() }
			end
			aU = aU + 1
		end
	end
	local c7 = {
		phase = self.phase,
		finish_reason = self.finishReason,
		difficulty = self.currentDifficulty,
		key_intensities = self.keyIntensitiesByPlayerId,
		level = self.currentLevel,
		wave = self.currentWave,
		active_player_ids = self.activeParticipantPlayerIds,
		ready_player_ids = c4,
		intermission_end_time = self.intermissionEndTime or 0,
		intermission_duration = F,
		bosses = c5,
		fixed_buffs = self.fieldBuffManager:GetFixedBuffs(),
		current_level_buffs = self.fieldBuffManager:GetCurrentLevelBuffs(),
		next_level_buffs = self.phase == "intermission" and self.fieldBuffManager:GetNextLevelBuffs() or {},
	}
	CustomNetTables:SetNetData("hunt_boss", "state", c7)
end
function G.prototype.GetParticipantHeroes(self)
	local bX = {}
	for I, c8 in ipairs(self.participantPlayerIds) do
		local ao = PlayerResource:GetSelectedHeroEntity(c8)
		if IsValid(ao) and ao:IsRealHero() and ao:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
			bX[#bX + 1] = ao
		end
	end
	return bX
end
function G.prototype.FindInfoTarget(self, aE)
	if self.spawnGroup == nil then
		return nil
	end
	for I, c9 in ipairs(Entities:FindAllByClassname("info_target")) do
		if c9:GetSpawnGroupHandle() == self.spawnGroup and s(c9:GetName(), aE) then
			return c9
		end
	end
	return nil
end
function G.prototype.IsActiveRun(self, a_)
	return self.runId == a_
end
function G.prototype.RemoveUnit(self, ca)
	if not IsValid(ca) then
		return
	end
	ca:ForceKill(false)
	ca:MakeIllusion()
	ca:AddNoDraw()
	ca:CallAbilityDestroy()
	UTIL_Remove(ca)
end
function G.prototype.ClearRuntimeState(self)
	self.fieldBuffManager:Reset()
	if self.intermissionTimerId ~= nil then
		Timer:StopTimer(self.intermissionTimerId)
		self.intermissionTimerId = nil
	end
	self.isLoading = false
	self.isRunning = false
	self.isFinished = false
	self.phase = "inactive"
	self.finishReason = nil
	self.participantPlayerIds = {}
	self.activeParticipantPlayerIds = {}
	self.entryPositionsByPlayerId = {}
	self.intermissionReadyPlayerIds = {}
	self.intermissionEndTime = nil
	self.enemyPools = {}
	self.levelConfigByNumber = {}
	self.healthFactor = 1
	self.damageFactor = 1
	self.difficultyCooldownReduction = 0
	self.difficultyBossGapAmplify = 0
	self.currentDifficulty = 0
	self.keyIntensitiesByPlayerId = {}
	self.currentLevel = 1
	self.currentWave = 0
	self.maxLevel = 1
	self.pendingEnemySpawnCount = 0
	self.enemies = {}
	self.bossSlots = {}
	self.battleCenter = nil
	self.spawnGroup = nil
	self:SyncState()
end
function G.prototype.UnregisterEvents(self)
	if self.startEventId ~= nil then
		Event:Unregister(self.startEventId)
	end
	if self.stopEventId ~= nil then
		Event:Unregister(self.stopEventId)
	end
	if self.playerReviveFailedEventId ~= nil then
		Event:Unregister(self.playerReviveFailedEventId)
	end
	if self.intermissionReadyEventId ~= nil then
		StopCustomUIEvent(self.intermissionReadyEventId)
	end
	if self.intermissionRetreatEventId ~= nil then
		StopCustomUIEvent(self.intermissionRetreatEventId)
	end
	self.startEventId = nil
	self.stopEventId = nil
	self.playerReviveFailedEventId = nil
	self.intermissionReadyEventId = nil
	self.intermissionRetreatEventId = nil
end
G = t({ y }, G)
if HuntBossBattle == nil then
	HuntBossBattle = e(G)
end
return u