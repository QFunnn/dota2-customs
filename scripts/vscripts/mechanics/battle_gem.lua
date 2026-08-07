--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/battle_gem"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArraySlice
local f = b.__TS__New
local g = b.__TS__ArrayForEach
local h = b.__TS__StringStartsWith
local i = b.__TS__StringSubstring
local j = b.__TS__ArrayFilter
local k = b.__TS__DecorateLegacy
local l = {}
local m = require("lib.tstl-utils")
local n = m.reloadable
local o = require("class.client_item")
local p = o.ClientItem
local q = require("class.dungeon_helper")
local r = q.AnalyzeCenterPositions
local s = q.ResolveSpawnGroupInfoTarget
local t = require("class.weight_pool")
local u = t.CWeightPool
local v = "gem_dungeon_enter"
local w = "gem_dungeon_exit"
local x = 64
local y = 60
local z = 3
local A = GRID_SIZE
local B = 50
local C = 320
local D = 800151
local E = c()
E.name = "CBattleGem"
d(E, CModule)
function E.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.logPrefix = "[BattleGem]"
	self.runId = 0
	self.state = "idle"
	self.participantPlayerIds = {}
	self.difficulty = 1
	self.difficultyHealthAmplify = 0
	self.difficultyDamageAmplify = 0
	self.maxLevel = 0
	self.currentLevel = 0
	self.validGridPositions = {}
	self.enemies = {}
	self.levelSpawnId = 0
	self.currentWave = 0
	self.pendingEnemySpawnCount = 0
	self.currentLevelTotalEnemyCount = 0
	self.levelConfigByNumber = {}
	self.difficultyConfigByNumber = {}
	self.settlementRuntime = self:CreateSettlementRuntime()
end
function E.prototype.init(self, F)
	self:UnregisterModuleEvents()
	self:EnsureSettlementActionPurchaseState()
	self.receiveRewardsEventId = CustomUIEvent("battle_gem_receive_rewards", function(self, ...)
		return self:OnReceiveRewards(...)
	end, self)
	self.buyActionsEventId = CustomUIEvent("battle_gem_buy_actions", function(self, ...)
		return self:OnBuyActions(...)
	end, self)
	if not F then
		self:ClearRuntimeState()
	end
	self:LoadDifficultyConfig()
	self:LoadLevelConfig()
	self:print((self.logPrefix .. " init reload=") .. tostring(F))
end
function E.prototype.reset(self)
	self:Stop("Reset", { unloadScene = true })
end
function E.prototype.HasDifficultyConfig(self, G)
	if self.difficultyConfigByNumber[G] ~= nil then
		return true
	end
	return self.difficultyConfigByNumber[G] ~= nil
end
function E.prototype.HandleAllPlayersDead(self)
	if self.state ~= "running" then
		return false
	end
	self:FinishBattle("failed", "AllPlayersDead")
	return true
end
function E.prototype.Start(self, G, H, I)
	self:Stop("Restart", { unloadScene = true })
	local J, K = self, "runId"
	local L = J[K] + 1
	J[K] = L
	local M = L
	self.state = "loading"
	self.difficulty = G
	self.participantPlayerIds = e(H)
	self:ResetBattleProgressState()
	self:ResetSettlementRuntime()
	do
		local N = 0
		while N < #self.participantPlayerIds do
			self:ClearPlayerSettlementPreview(self.participantPlayerIds[N + 1])
			N = N + 1
		end
	end
	self:CalculateDifficultyModifiers()
	local O = self.difficultyConfigByNumber[self.difficulty]
	if O == nil then
		self:error(
			(self.logPrefix .. " start failed: difficulty config missing difficulty=") .. tostring(self.difficulty)
		)
		self:Stop("DifficultyMissing", { unloadScene = true })
		return
	end
	self.maxLevel = O.maxLevel
	self.currentLevel = 1
	self:SyncState()
	self:print(
		(
			(
				(
					(
						((((self.logPrefix .. " start run=") .. tostring(M)) .. " difficulty=") .. tostring(G))
						.. " maxLevel="
					) .. tostring(self.maxLevel)
				) .. " players=["
			) .. table.concat(self.participantPlayerIds, ",")
		) .. "]"
	)
	self.battleCenter = Vector(I.x, I.y, I.z)
	local P = self:GetBattlePrefabName()
	DungeonManager:ShowLoadingScreen()
	self.spawnGroup = DOTA_SpawnMapAtPosition(P, I, true, function(Q)
		if not self:IsActiveRun(M) then
			return
		end
		self:print(
			(
				(
					(
						(
							((((self.logPrefix .. " ready to spawn prefab=") .. P) .. " loadPoint=(") .. tostring(I.x))
							.. ","
						) .. tostring(I.y)
					) .. ","
				) .. tostring(I.z)
			) .. ")"
		)
		ManuallyTriggerSpawnGroupCompletion(Q)
	end, function()
		if not self:IsActiveRun(M) then
			return
		end
		self:OnMapLoaded(M)
		DungeonManager:HideLoadingScreen()
	end, nil)
end
function E.prototype.Stop(self, R, S)
	if R == nil then
		R = "Manual"
	end
	local T = (S and S.unloadScene) ~= false
	local U = self:StopGameplay(R)
	local V = T and self:UnloadScene(R)
	if U or V then
		self:print((((self.logPrefix .. " stopped reason=") .. R) .. " unloadScene=") .. tostring(T))
	end
	if (U or V) and R ~= "ReceiveRewardsCompleted" and R ~= "AllPlayersReturned" and R ~= "Restart" then
		DungeonAdventure:CancelBattle("gem")
	end
end
function E.prototype.StopGameplay(self, R)
	if R == nil then
		R = "Manual"
	end
	local U = self.state == "loading" or self.state == "running"
	self.runId = self.runId + 1
	self.state = "finished"
	self:ClearRuntimeState()
	if U then
		self:print((self.logPrefix .. " gameplay stopped reason=") .. R)
	end
	return U
end
function E.prototype.UnloadScene(self, R)
	if R == nil then
		R = "Manual"
	end
	if self.spawnGroup == nil then
		return false
	end
	UnloadSpawnGroupByHandle(self.spawnGroup)
	self.spawnGroup = nil
	self:print((self.logPrefix .. " scene unloaded reason=") .. R)
	return true
end
function E.prototype.OnMapLoaded(self, M)
	local P = self:GetBattlePrefabName()
	self:print((self.logPrefix .. " prefab loaded prefab=") .. P)
	local W = s(nil, self.spawnGroup, v)
	if W == nil then
		self:error(((self.logPrefix .. " start failed: enter point '") .. v) .. "' not found in gem spawn group")
		self:Stop("EnterPointMissing", { unloadScene = true })
		return
	end
	self.enterPosition = W.position
	self.entrancePrefix = W.prefix
	local X = s(nil, self.spawnGroup, w)
	self.exitPosition = X and X.position or self.enterPosition
	self.exitPrefix = X and X.prefix
	self:AnalyzeGrid()
	self:TeleportPlayers(self.enterPosition)
	self.state = "running"
	self:RegisterKillListener()
	self:SyncState()
	self:StartCurrentLevel()
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
											(((self.logPrefix .. " running run=") .. tostring(M)) .. " level=")
											.. tostring(self.currentLevel)
										) .. " maxLevel="
									) .. tostring(self.maxLevel)
								) .. " enter=("
							) .. tostring(self.enterPosition.x)
						) .. ","
					) .. tostring(self.enterPosition.y)
				) .. ","
			) .. tostring(self.enterPosition.z)
		) .. ")"
	)
end
function E.prototype.TeleportPlayers(self, Y)
	local Z = self:GetParticipantHeroes()
	do
		local N = 0
		while N < #Z do
			do
				local _ = Z[N + 1]
				if not IsValid(_) then
					goto a0
				end
				local a1 = Y
				if #Z > 1 then
					local a2 = (N - (#Z - 1) / 2) * x
					a1 = Vector(Y.x + a2, Y.y, Y.z)
				end
				FindClearSpaceForUnit(_, a1, true)
				_:SetForwardVector(vec3_top)
				_:StartGesture(ACT_DOTA_TELEPORT_END)
				local a3 = PlayerResource:GetPlayer(_:GetPlayerOwnerID())
				if a3 ~= nil then
					CustomGameEventManager:Send_ServerToPlayer(
						a3,
						"camera_follow_hero",
						{ transitionDuration = 0.2, x = a1.x, y = a1.y, z = a1.z }
					)
				end
				local a4 = _:GetAbsOrigin()
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
																	(
																		(
																			(
																				(self.logPrefix .. " teleport hero=")
																				.. _:GetUnitName()
																			) .. " player="
																		)
																		.. tostring(_:GetPlayerOwnerID())
																	) .. " targetPosition=("
																) .. tostring(a1.x)
															) .. ","
														) .. tostring(a1.y)
													) .. ","
												) .. tostring(a1.z)
											) .. ") position=("
										) .. tostring(a4.x)
									) .. ","
								) .. tostring(a4.y)
							) .. ","
						) .. tostring(a4.z)
					) .. ")"
				)
			end
			::a0::
			N = N + 1
		end
	end
end
function E.prototype.GetParticipantHeroes(self)
	local Z = {}
	do
		local N = 0
		while N < #self.participantPlayerIds do
			local _ = PlayerResource:GetSelectedHeroEntity(self.participantPlayerIds[N + 1])
			if IsValid(_) and _:IsRealHero() and _:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
				Z[#Z + 1] = _
			end
			N = N + 1
		end
	end
	return Z
end
function E.prototype.StartCurrentLevel(self)
	local a5 = self.levelConfigByNumber[self.currentLevel]
	if a5 == nil then
		self:error((self.logPrefix .. " level config missing level=") .. tostring(self.currentLevel))
		self:FinishBattle("failed", "LevelConfigMissing")
		return
	end
	self:StopAttackTimer()
	local a6, a7 = self, "levelSpawnId"
	local a8 = a6[a7] + 1
	a6[a7] = a8
	local a9 = a8
	self.currentWave = 0
	self.pendingEnemySpawnCount = 0
	self:ClearEnemies()
	self.currentLevelTotalEnemyCount = 0
	self.attackEndTime = nil
	self:SyncState()
	self:StartNextWave(a5, a9)
	self:print(
		(
			(
				(
					(
						(((self.logPrefix .. " level started level=") .. tostring(self.currentLevel)) .. " waves=")
						.. tostring(#a5.waves)
					) .. " healthFactor="
				) .. tostring(a5.healthFactor)
			) .. " damageFactor="
		) .. tostring(a5.damageFactor)
	)
end
function E.prototype.StartNextWave(self, a5, a9)
	if self.state ~= "running" or self.levelSpawnId ~= a9 then
		return
	end
	self.currentWave = self.currentWave + 1
	self.pendingEnemySpawnCount = 0
	self.currentLevelTotalEnemyCount = 0
	local aa = a5.waves[self.currentWave]
	if aa == nil then
		self:OnLevelCleared()
		return
	end
	local ab = f(u, aa.enemyList)
	local ac = ab.ValidCount > 0 and aa.enemyCount or 0
	local ad = self.enterPosition
	local ae = {}
	if ad ~= nil then
		ae = self:GetValidSpawnPositions(ad, 300)
		if #ae < ac then
			ae = self:GetValidSpawnPositions(ad, 600)
		end
		if #ae < ac then
			ae = self:GetValidSpawnPositions(ad, 1200)
		end
	end
	if #ae <= 0 then
		do
			local N = 0
			while N < #self.validGridPositions do
				local a4 = self.validGridPositions[N + 1]
				if a4 ~= nil and self:IsValidSpawnPosition(a4) then
					ae[#ae + 1] = a4
				end
				N = N + 1
			end
		end
	end
	do
		local N = #ae - 1
		while N > 0 do
			local af = RandomInt(0, N)
			local ag = ae[N + 1]
			ae[N + 1] = ae[af + 1]
			ae[af + 1] = ag
			N = N - 1
		end
	end
	local ah = {}
	do
		local N = 0
		while N < ac do
			do
				local ai = ab:Random()
				if ai == nil then
					break
				end
				local aj = table.remove(ae) or self:FindRandomSpawnPosition()
				if aj == nil then
					self:print(
						(
							(
								(self.logPrefix .. " spawn skipped: no valid position level=")
								.. tostring(self.currentLevel)
							) .. " unit="
						) .. ai
					)
					goto ak
				end
				ah[#ah + 1] = { unitName = tostring(ai), spawnPos = aj }
			end
			::ak::
			N = N + 1
		end
	end
	if #ah <= 0 then
		self:print(
			(
				(
					(
						(
							(
								(
									(self.logPrefix .. " wave has no spawned enemies level=")
									.. tostring(self.currentLevel)
								) .. " wave="
							) .. tostring(self.currentWave)
						) .. "/"
					) .. tostring(#a5.waves)
				) .. " pool="
			) .. aa.poolName
		)
		self:TryCompleteCurrentWave()
		return
	end
	self.pendingEnemySpawnCount = #ah
	self.currentLevelTotalEnemyCount = #ah
	self:SyncState()
	do
		local N = 0
		while N < #ah do
			local al = ah[N + 1]
			self:SpawnEnemy(al.unitName, al.spawnPos, a5, aa, a9)
			N = N + 1
		end
	end
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
											((self.logPrefix .. " wave started level=") .. tostring(self.currentLevel))
											.. " wave="
										) .. tostring(self.currentWave)
									) .. "/"
								) .. tostring(#a5.waves)
							) .. " pool="
						) .. aa.poolName
					) .. " spawnRequests="
				) .. tostring(#ah)
			) .. " healthFactor="
		) .. tostring(aa.healthFactor)
	)
end
function E.prototype.GetValidSpawnPositions(self, am, an)
	local ao = {}
	do
		local N = 0
		while N < #self.validGridPositions do
			do
				local a4 = self.validGridPositions[N + 1]
				if a4 == nil then
					goto ap
				end
				if CalcDistance(a4, am) < an and self:IsValidSpawnPosition(a4) then
					ao[#ao + 1] = a4
				end
			end
			::ap::
			N = N + 1
		end
	end
	return ao
end
function E.prototype.SpawnEnemy(self, ai, aj, a5, aa, a9)
	CreateUnitByNameAsync(ai, aj, true, nil, nil, DOTA_TEAM_BADGUYS, function(aq)
		if self.state ~= "running" or self.levelSpawnId ~= a9 then
			if IsValid(aq) then
				self:RemoveUnit(aq)
			end
			return
		end
		self.pendingEnemySpawnCount = math.max(0, self.pendingEnemySpawnCount - 1)
		if not IsValid(aq) then
			self.currentLevelTotalEnemyCount = math.max(0, self.currentLevelTotalEnemyCount - 1)
			self:print((((self.logPrefix .. " spawn failed unit=") .. ai) .. " level=") .. tostring(self.currentLevel))
			self:TryCompleteCurrentWave()
			return
		end
		FindClearSpaceForUnit(aq, aj, true)
		aq:SetForwardVector(RandomVector(1))
		self:ApplyLevelModifiers(aq, a5, aa)
		local ar = self.enemies
		ar[#ar + 1] = aq
		if self.attackEndTime == nil then
			self:StartAttackTimer()
		end
		self:SyncState()
		self:TryCompleteCurrentWave()
	end)
end
function E.prototype.TryCompleteCurrentWave(self)
	if self.state ~= "running" or self.pendingEnemySpawnCount > 0 or #self.enemies > 0 then
		return
	end
	local a5 = self.levelConfigByNumber[self.currentLevel]
	if a5 ~= nil and self.currentWave < #a5.waves then
		self:StartNextWave(a5, self.levelSpawnId)
		return
	end
	self:OnLevelCleared()
end
function E.prototype.ApplyLevelModifiers(self, aq, a5, aa)
	local as = DungeonManager:GetDifficultyKeyHealthFactor()
	local at = DungeonManager:GetDifficultyKeyDamageFactor()
	local au = (1 + self.difficultyHealthAmplify / 100) * a5.healthFactor * aa.healthFactor * as
	local av = (1 + self.difficultyDamageAmplify / 100) * a5.damageFactor * at
	local aw = (au - 1) * 100
	local ax = (av - 1) * 100
	if aw ~= 0 then
		aq:AddProperty(PropertyFunction.HEALTH_AMPLIFY, aw)
	end
	if ax ~= 0 then
		aq:AddProperty(PropertyFunction.ATTACK_AMPLIFY, ax)
	end
	DungeonManager:ApplyDifficultyKeyDebuffs(aq)
end
function E.prototype.CalculateDifficultyModifiers(self)
	local ay = KeyValues.difficulty[tostring(self.difficulty)]
	if ay == nil then
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		self:error(
			(self.logPrefix .. " difficulty config missing in KeyValues.difficulty difficulty=")
				.. tostring(self.difficulty)
		)
		return
	end
	local az = toFiniteNumber(ay.HealthFactor, 1)
	local aA = toFiniteNumber(ay.DamageFactor, 1)
	self.difficultyHealthAmplify = (az - 1) * 100
	self.difficultyDamageAmplify = (aA - 1) * 100
end
function E.prototype.StartAttackTimer(self)
	self:StopAttackTimer()
	self.attackEndTime = GameRules:GetGameTime() + y
	self:SyncState()
	self.attackTimerId = Timer:GameTimer(y, function()
		if self.state ~= "running" then
			return
		end
		self:print((self.logPrefix .. " attack timeout level=") .. tostring(self.currentLevel))
		self:FinishBattle("failed", "Timeout")
	end)
	self:print(
		(((self.logPrefix .. " attack timer started level=") .. tostring(self.currentLevel)) .. " endTime=")
			.. tostring(self.attackEndTime)
	)
end
function E.prototype.StopAttackTimer(self)
	if self.attackTimerId ~= nil then
		Timer:StopTimer(self.attackTimerId)
		self.attackTimerId = nil
	end
end
function E.prototype.RegisterKillListener(self)
	if self.killEventListenerId ~= nil then
		StopGameEvent(self.killEventListenerId)
	end
	self.killEventListenerId = GameEvent("entity_killed", function(self, ...)
		return self:OnEntityKilled(...)
	end, self)
end
function E.prototype.OnEntityKilled(self, aB)
	if self.state ~= "running" then
		return
	end
	local aC = EntIndexToHScript(aB.entindex_killed)
	if not IsValid(aC) then
		return
	end
	do
		local N = 0
		while N < #self.enemies do
			do
				if self.enemies[N + 1] ~= aC then
					goto aD
				end
				table.remove(self.enemies, N + 1)
				self:SyncState()
				self:TryCompleteCurrentWave()
				return
			end
			::aD::
			N = N + 1
		end
	end
end
function E.prototype.OnLevelCleared(self)
	if self.state ~= "running" then
		return
	end
	self:StopAttackTimer()
	self.attackEndTime = nil
	self:SyncState()
	if self.currentLevel >= self.maxLevel then
		self:FinishBattle("success", "MaxLevelReached")
		return
	end
	self.currentLevel = self.currentLevel + 1
	self:SyncState()
	self:print((self.logPrefix .. " level cleared nextLevel=") .. tostring(self.currentLevel))
	self:StartCurrentLevel()
end
function E.prototype.FinishBattle(self, aE, R)
	if self.state == "finished" then
		return
	end
	self.state = "finished"
	self.result = aE
	self.levelSpawnId = self.levelSpawnId + 1
	self.pendingEnemySpawnCount = 0
	self:StopAttackTimer()
	self.attackEndTime = nil
	self:ClearEnemies()
	self.currentLevelTotalEnemyCount = 0
	local aF = self.battleCenter or self.exitPosition or self.enterPosition
	self:ReviveDeadParticipantsForSettlement(aF)
	self:CreateSettlementChests(aF)
	self:SyncState()
	self:print(
		(
			(
				(((((self.logPrefix .. " battle finished result=") .. aE) .. " reason=") .. R) .. " level=")
				.. tostring(self.currentLevel)
			) .. " maxLevel="
		) .. tostring(self.maxLevel)
	)
end
function E.prototype.ReviveDeadParticipantsForSettlement(self, a4)
	if a4 == nil then
		return
	end
	local aG = {}
	do
		local N = 0
		while N < #self.participantPlayerIds do
			local _ = PlayerResource:GetSelectedHeroEntity(self.participantPlayerIds[N + 1])
			if IsValid(_) and _:IsRealHero() and not _:IsAlive() then
				aG[#aG + 1] = _
			end
			N = N + 1
		end
	end
	do
		local N = 0
		while N < #aG do
			local _ = aG[N + 1]
			local a1 = Vector(a4.x + (N - (#aG - 1) / 2) * x, a4.y, a4.z)
			_:SetRespawnPosition(a1)
			_:RespawnHero(false, false)
			_:SetHealth(_:GetMaxHealth())
			FindClearSpaceForUnit(_, a1, true)
			_:SetForwardVector(vec3_top)
			_:StartGesture(ACT_DOTA_TELEPORT_END)
			local aH = _:GetPlayerOwnerID()
			local a3 = PlayerResource:GetPlayer(aH)
			if a3 ~= nil then
				CustomGameEventManager:Send_ServerToPlayer(
					a3,
					"camera_follow_hero",
					{ transitionDuration = 0.2, x = a1.x, y = a1.y, z = a1.z }
				)
			end
			self:print((self.logPrefix .. " revived participant for settlement player=") .. tostring(aH))
			N = N + 1
		end
	end
end
function E.prototype.CreateSettlementChests(self, a4)
	if a4 == nil then
		return
	end
	self:ClearSettlementChests()
	local aI = GetGroundPosition(a4, nil)
	do
		local N = 0
		while N < #self.participantPlayerIds do
			local aH = self.participantPlayerIds[N + 1]
			local aJ = f(p, aH, "9900000", aI, { 0, 0 })
			EmitSoundOnLocationForPlayer("Drop.Gem", aI, aH)
			local aK = self.settlementRuntime.clientItems
			aK[#aK + 1] = aJ
			local aL = Interaction:RegisterInteract(aJ.entity, InteractType.BossChest, 200, function()
				if not aJ:IsLanded() then
					return false
				end
				return self:OpenSettlementChest(aH, aJ, aJ:GetLandedPosition())
			end, nil, aH)
			if aL ~= -1 then
				local aM = self.settlementRuntime.registeredInteracts
				aM[#aM + 1] = aL
			end
			N = N + 1
		end
	end
end
function E.prototype.OpenSettlementChest(self, aH, aJ, aI)
	if self.state ~= "finished" then
		return false
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[aH] == true
		or self.settlementRuntime.rewardPreviewOpenedPlayers[aH] == true
		or self.settlementRuntime.rewardPreviewRequestingPlayers[aH] == true
	then
		return false
	end
	if Equipment:IsCapacityFull(aH, "gem") then
		Equipment:ShowCapacityDialog(aH, "gem", true)
		return false
	end
	self.settlementRuntime.rewardPreviewRequestingPlayers[aH] = true
	EmitSoundOnLocationForPlayer("Chess.Open", aI, aH)
	local aN = { match_id = Match:GetMatchID(), layer = self.currentLevel }
	CommonService:CallAction("/v1/settle/preview_tower_rewards", aH, aN, function(aO, aP, aQ)
		self.settlementRuntime.rewardPreviewRequestingPlayers[aH] = false
		if aQ.code ~= 0 and aQ.code ~= 200 then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", aI, aH)
		CommonService:CommonCallback(aH, aQ)
		self.settlementRuntime.rewardPreviewOpenedPlayers[aH] = true
		self:UnregisterSettlementChest(aJ)
		g(aJ.particleIDs, function(aO, aR)
			ParticleManager:DestroyParticle(aR, false)
		end)
		local a3 = PlayerResource:GetPlayer(aH)
		if a3 ~= nil then
			local aS = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/boss_chest_open.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				a3
			)
			ParticleManager:SetParticleControl(aS, 0, aJ.entity:GetAbsOrigin())
			local aT = aJ.particleIDs
			aT[#aT + 1] = aS
		end
	end, false)
	return true
end
function E.prototype.UnregisterSettlementChest(self, aJ)
	local aU = aJ:GetEntityIndex()
	local aV = {}
	do
		local N = 0
		while N < #self.settlementRuntime.registeredInteracts do
			do
				local aW = self.settlementRuntime.registeredInteracts[N + 1]
				if aW == aU then
					Interaction:UnregisterInteractable(aW)
					goto aX
				end
				aV[#aV + 1] = aW
			end
			::aX::
			N = N + 1
		end
	end
	self.settlementRuntime.registeredInteracts = aV
end
function E.prototype.ClearSettlementChests(self)
	do
		local N = 0
		while N < #self.settlementRuntime.registeredInteracts do
			Interaction:UnregisterInteractable(self.settlementRuntime.registeredInteracts[N + 1])
			N = N + 1
		end
	end
	self.settlementRuntime.registeredInteracts = {}
	do
		local N = 0
		while N < #self.settlementRuntime.clientItems do
			self.settlementRuntime.clientItems[N + 1]:dispose()
			N = N + 1
		end
	end
	self.settlementRuntime.clientItems = {}
end
function E.prototype.OpenReturnGates(self)
	if self.settlementRuntime.returnNpc ~= nil or self.exitPosition == nil then
		self:print(
			(self.logPrefix .. " return gate already opened or no exit position ") .. tostring(self.exitPosition)
		)
		return
	end
	local aY = GetGroundPosition(self.exitPosition, nil)
	local aZ = CreateUnitByName("npc_crystal_gate", aY, false, nil, nil, DOTA_TEAM_GOODGUYS)
	if not IsValid(aZ) then
		return
	end
	aZ:AddNewModifier(aZ, nil, "modifier_no_health_bar", {})
	aZ:SetForwardVector(vec3_bottom)
	local aL = Interaction:RegisterInteract(aZ, InteractType.NPC, 200, function(aO, a_, aH)
		self:ClearReturnGateIndicator(aH)
		DungeonAdventure:ExitBattle("gem", aH)
	end, 99999999)
	if aL ~= -1 then
		self.settlementRuntime.returnInteractId = aL
	end
	self.settlementRuntime.returnNpc = aZ
end
function E.prototype.ClearReturnGate(self)
	self:ClearReturnGateIndicators()
	if self.settlementRuntime.returnInteractId ~= nil then
		Interaction:UnregisterInteractable(self.settlementRuntime.returnInteractId)
		self.settlementRuntime.returnInteractId = nil
	end
	if self.settlementRuntime.returnNpc ~= nil then
		self:RemoveUnit(self.settlementRuntime.returnNpc)
		self.settlementRuntime.returnNpc = nil
	end
end
function E.prototype.ShowReturnGateIndicator(self, aH)
	local _ = PlayerResource:GetSelectedHeroEntity(aH)
	local b0 = self.settlementRuntime.returnNpc
	if not IsValid(_) or not IsValid(b0) then
		return
	end
	_:AddNewModifier(_, nil, "modifier_arrow_target", { targetEntIndex = b0:entindex() })
end
function E.prototype.ClearReturnGateIndicator(self, aH)
	local _ = PlayerResource:GetSelectedHeroEntity(aH)
	if IsValid(_) then
		_:RemoveModifierByName("modifier_arrow_target")
	end
end
function E.prototype.ClearReturnGateIndicators(self)
	do
		local N = 0
		while N < #self.participantPlayerIds do
			self:ClearReturnGateIndicator(self.participantPlayerIds[N + 1])
			N = N + 1
		end
	end
end
function E.prototype.GetBattlePrefabName(self)
	return "prefabs/gem_dungeon"
end
function E.prototype.AnalyzeGrid(self)
	if self.battleCenter == nil then
		self.validGridPositions = {}
		return
	end
	self.validGridPositions = r(nil, { center = self.battleCenter, rings = z, gridSize = A })
	self:print((self.logPrefix .. " grid analyzed count=") .. tostring(#self.validGridPositions))
end
function E.prototype.FindRandomSpawnPosition(self)
	if #self.validGridPositions <= 0 then
		return nil
	end
	do
		local N = 0
		while N < B do
			local a4 = self.validGridPositions[RandomInt(0, #self.validGridPositions - 1) + 1]
			if a4 ~= nil and self:IsValidSpawnPosition(a4) then
				return a4
			end
			N = N + 1
		end
	end
end
function E.prototype.IsValidSpawnPosition(self, a4)
	local Z = self:GetParticipantHeroes()
	do
		local N = 0
		while N < #Z do
			local _ = Z[N + 1]
			if IsValid(_) and CalcDistance(a4, _:GetAbsOrigin()) < C then
				return false
			end
			N = N + 1
		end
	end
	return true
end
function E.prototype.ClearEnemies(self)
	do
		local N = 0
		while N < #self.enemies do
			local aq = self.enemies[N + 1]
			if aq ~= nil then
				self:RemoveUnit(aq)
			end
			N = N + 1
		end
	end
	self.enemies = {}
end
function E.prototype.CreateSettlementRuntime(self)
	return {
		clientItems = {},
		registeredInteracts = {},
		returnInteractId = nil,
		rewardReceivedPlayers = {},
		rewardReceivingPlayers = {},
		rewardPreviewOpenedPlayers = {},
		rewardPreviewRequestingPlayers = {},
		actionPurchasedPlayers = {},
		actionPurchasingPlayers = {},
	}
end
function E.prototype.EnsureSettlementActionPurchaseState(self)
	local b1, b2 = self.settlementRuntime, "actionPurchasedPlayers"
	if b1[b2] == nil then
		b1[b2] = {}
	end
	local b3, b4 = self.settlementRuntime, "actionPurchasingPlayers"
	if b3[b4] == nil then
		b3[b4] = {}
	end
end
function E.prototype.ResetBattleProgressState(self)
	self.result = nil
	self.attackEndTime = nil
	self.currentWave = 0
	self.currentLevelTotalEnemyCount = 0
end
function E.prototype.ResetSettlementRuntime(self)
	self:ClearSettlementChests()
	self:ClearReturnGate()
	self.settlementRuntime = self:CreateSettlementRuntime()
end
function E.prototype.RemoveUnit(self, aZ)
	if not IsValid(aZ) then
		return
	end
	aZ:RemoveAllModifiers(0, false, true, false)
	aZ:ForceKill(false)
	aZ:MakeIllusion()
	aZ:AddNoDraw()
	aZ:CallAbilityDestroy()
	UTIL_Remove(aZ)
end
function E.prototype.LoadLevelConfig(self)
	self.levelConfigByNumber = {}
	local b5 = KeyValues.battle_gem_levels
	if b5 == nil then
		self:error(self.logPrefix .. " battle_gem_levels config not found")
		return false
	end
	local b6 = {}
	local b7 = b5.EnemyPools
	if b7 ~= nil then
		for b8, b9 in pairs(b7) do
			local ba = {}
			for ai, bb in pairs(b9) do
				local bc = math.max(0, math.floor(toFiniteNumber(bb, 0)))
				if bc > 0 then
					ba[tostring(ai)] = bc
				end
			end
			b6[tostring(b8)] = ba
		end
	end
	for bd, be in pairs(b5) do
		do
			local bf = tostring(bd)
			if not h(bf, "level_") then
				goto bg
			end
			local bh = toFiniteNumber(i(bf, #"level_"), -1)
			if bh == nil or be == nil then
				goto bg
			end
			if bh < 1 then
				goto bg
			end
			local bi = be
			local bj = {}
			if bi.WaveList ~= nil then
				do
					local bk = 1
					while true do
						local bl = bi.WaveList[tostring(bk)]
						if bl == nil then
							break
						end
						local bm = tostring
						local bn = bl.EnemyPool
						if bn == nil then
							bn = "creep"
						end
						local b8 = bm(bn)
						bj[#bj + 1] = {
							poolName = b8,
							enemyCount = math.max(1, math.floor(toFiniteNumber(bl.EnemyCount, 1))),
							healthFactor = math.max(0.01, toFiniteNumber(bl.HealthFactor, 1)),
							enemyList = b6[b8] or {},
						}
						bk = bk + 1
					end
				end
			end
			if #bj <= 0 then
				local ba = {}
				if bi.EnemyList ~= nil then
					for ai, bb in pairs(bi.EnemyList) do
						local bc = math.max(0, math.floor(toFiniteNumber(bb, 0)))
						if bc > 0 then
							ba[tostring(ai)] = bc
						end
					end
				end
				local bo = math.max(1, math.floor(toFiniteNumber(bi.WaveCount, 1)))
				local bp = math.max(1, math.floor(toFiniteNumber(bi.EnemyCountPerWave, 1)))
				do
					local bk = 1
					while bk <= bo do
						bj[#bj + 1] = { poolName = "legacy", enemyCount = bp, healthFactor = 1, enemyList = ba }
						bk = bk + 1
					end
				end
			end
			self.levelConfigByNumber[bh] = {
				level = bh,
				healthFactor = math.max(0.1, toFiniteNumber(bi.HealthFactor, 1)),
				damageFactor = math.max(0.1, toFiniteNumber(bi.DamageFactor, 1)),
				waves = bj,
			}
		end
		::bg::
	end
	if self.levelConfigByNumber[1] == nil then
		self:error(self.logPrefix .. " level_1 missing in battle_gem_levels config")
		return false
	end
	return true
end
function E.prototype.LoadDifficultyConfig(self)
	self.difficultyConfigByNumber = {}
	local b5 = KeyValues.battle_gem_difficulty
	if b5 == nil then
		self:error(self.logPrefix .. " battle_gem_difficulty config not found")
		return false
	end
	for bq, br in pairs(b5) do
		do
			if br == nil then
				goto bs
			end
			local G = toFiniteNumber(bq, -1)
			if G < 1 then
				goto bs
			end
			local bi = br
			self.difficultyConfigByNumber[G] =
				{ maxLevel = math.max(1, math.floor(toFiniteNumber(bi.layers_limit, 1))) }
		end
		::bs::
	end
	print(self.logPrefix .. " difficulty config:")
	DeepPrintTable(self.difficultyConfigByNumber)
	return true
end
function E.prototype.SyncState(self)
	local bt = CustomNetTables.SetNetData
	local bu = self.state == "running"
	local bv = self.state == "loading"
	local bw = self.state == "finished"
	local bx = self.difficulty
	local by = self.currentLevel
	local bz = self.maxLevel
	local bA = self.result
	local bB = self.attackEndTime
	local bC = self.currentWave
	local bD = self.levelConfigByNumber[self.currentLevel]
	bt(
		CustomNetTables,
		"common",
		"battle_gem_state",
		{
			isRunning = bu,
			isLoading = bv,
			isFinished = bw,
			difficulty = bx,
			currentLevel = by,
			maxLevel = bz,
			result = bA,
			attackDuration = y,
			attackEndTime = bB,
			currentWave = bC,
			totalWaveCount = bD and #bD.waves or 0,
			aliveEnemyCount = #self.enemies,
			totalEnemyCount = self.currentLevelTotalEnemyCount,
			bossEntIndex = self:GetCurrentBossEntIndex(),
			participantPlayerIds = e(self.participantPlayerIds),
			actionPurchasingPlayerIds = j(self.participantPlayerIds, function(aO, aH)
				return self.settlementRuntime.actionPurchasingPlayers[aH] == true
			end),
			actionPurchasedPlayerIds = j(self.participantPlayerIds, function(aO, aH)
				return self.settlementRuntime.actionPurchasedPlayers[aH] == true
			end),
		}
	)
end
function E.prototype.GetCurrentBossEntIndex(self)
	do
		local N = 0
		while N < #self.enemies do
			local aq = self.enemies[N + 1]
			if IsValid(aq) and h(aq:GetUnitLabel(), "boss") then
				return aq:entindex()
			end
			N = N + 1
		end
	end
	return nil
end
function E.prototype.ClearRuntimeState(self)
	self:StopAttackTimer()
	self.levelSpawnId = self.levelSpawnId + 1
	self.currentWave = 0
	self.pendingEnemySpawnCount = 0
	if self.killEventListenerId ~= nil then
		StopGameEvent(self.killEventListenerId)
		self.killEventListenerId = nil
	end
	self:ClearEnemies()
	self.difficulty = 1
	self.difficultyHealthAmplify = 0
	self.difficultyDamageAmplify = 0
	self.maxLevel = 0
	self.currentLevel = 0
	self:ResetBattleProgressState()
	self:ResetSettlementRuntime()
	self.validGridPositions = {}
	self.participantPlayerIds = {}
	self.battleCenter = nil
	self.enterPosition = nil
	self.exitPosition = nil
	self.entrancePrefix = nil
	self.exitPrefix = nil
	self.state = "idle"
	self:SyncState()
end
function E.prototype.IsActiveRun(self, M)
	return self.runId == M
end
function E.prototype.OnBuyActions(self, aB)
	local aH = aB.PlayerID
	if self.state ~= "finished" then
		return
	end
	if TableFindKey(self.participantPlayerIds, aH) == nil then
		return
	end
	if self.settlementRuntime.rewardPreviewOpenedPlayers[aH] ~= true then
		return
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[aH] == true
		or self.settlementRuntime.rewardReceivingPlayers[aH] == true
	then
		return
	end
	if
		self.settlementRuntime.actionPurchasedPlayers[aH] == true
		or self.settlementRuntime.actionPurchasingPlayers[aH] == true
	then
		return
	end
	local M = self.runId
	self.settlementRuntime.actionPurchasingPlayers[aH] = true
	self:SyncState()
	if aB.buy_product == 1 then
		self:BuyActionProduct(aH, M)
		return
	end
	self:RequestBuyActions(aH, M)
end
function E.prototype.BuyActionProduct(self, aH, M)
	CommonService:CallAction("/v1/shop/buy", aH, { amounts = 1, product_id = D }, function(aO, aP, aQ)
		local bE = aQ.code == 0 or aQ.code == 200
		if bE then
			CommonService:CommonCallback(aH, aQ)
		end
		if not self:IsActionPurchaseRequestActive(aH, M) then
			return
		end
		if not bE then
			self:FinishBuyActions(aH, false, aQ.message)
			return
		end
		self:RequestBuyActions(aH, M)
	end, false)
end
function E.prototype.RequestBuyActions(self, aH, M)
	local aN = { match_id = Match:GetMatchID() }
	CommonService:CallAction("/v1/settle/buy_tower_actions", aH, aN, function(aO, aP, aQ)
		if not self:IsActionPurchaseRequestActive(aH, M) then
			return
		end
		CommonService:CommonCallback(aH, aQ)
		local bE = aQ.code == 0 or aQ.code == 200
		self:FinishBuyActions(aH, bE, aQ.message)
	end, false)
end
function E.prototype.IsActionPurchaseRequestActive(self, aH, M)
	return self:IsActiveRun(M)
		and self.state == "finished"
		and self.settlementRuntime.actionPurchasingPlayers[aH] == true
end
function E.prototype.FinishBuyActions(self, aH, bE, bF)
	self.settlementRuntime.actionPurchasingPlayers[aH] = false
	if bE then
		self.settlementRuntime.actionPurchasedPlayers[aH] = true
	else
		ErrorMessage(bF, aH)
	end
	self:SyncState()
end
function E.prototype.OnReceiveRewards(self, aB)
	if self.state ~= "finished" then
		return
	end
	if TableFindKey(self.participantPlayerIds, aB.PlayerID) == nil then
		return
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[aB.PlayerID] == true
		or self.settlementRuntime.rewardReceivingPlayers[aB.PlayerID] == true
	then
		return
	end
	if self.settlementRuntime.actionPurchasingPlayers[aB.PlayerID] == true then
		return
	end
	if self.settlementRuntime.rewardPreviewOpenedPlayers[aB.PlayerID] ~= true then
		return
	end
	local bG = {}
	if aB.actions ~= nil and aB.actions ~= "" then
		local bH, bI = pcall(function()
			return json.decode(aB.actions)
		end)
		if bH ~= true or bI == nil then
			self:error(
				(
					(
						(self.logPrefix .. " receive rewards failed: invalid actions payload player=")
						.. tostring(aB.PlayerID)
					) .. " raw="
				) .. aB.actions
			)
			return
		end
		bG = bI
	end
	local aN = { match_id = Match:GetMatchID(), actions = bG }
	self.settlementRuntime.rewardReceivingPlayers[aB.PlayerID] = true
	CommonService:CallAction("/v1/settle/receive_tower_rewards", aB.PlayerID, aN, function(aO, aP, aQ)
		self.settlementRuntime.rewardReceivingPlayers[aB.PlayerID] = false
		CommonService:CommonCallback(aB.PlayerID, aQ)
		if aQ.code ~= 0 and aQ.code ~= 200 then
			return
		end
		self.settlementRuntime.rewardReceivedPlayers[aB.PlayerID] = true
		self:ClearPlayerSettlementPreview(aB.PlayerID)
		self:OpenReturnGates()
		self:ShowReturnGateIndicator(aB.PlayerID)
		if not self:AreAllParticipantsRewardsReceived() then
			return
		end
		self:ClearSettlementChests()
	end, false)
end
function E.prototype.AreAllParticipantsRewardsReceived(self)
	do
		local N = 0
		while N < #self.participantPlayerIds do
			if self.settlementRuntime.rewardReceivedPlayers[self.participantPlayerIds[N + 1]] ~= true then
				return false
			end
			N = N + 1
		end
	end
	return true
end
function E.prototype.ClearPlayerSettlementPreview(self, aH)
	CommonService:SetPlayerServiceNetData(aH, "player_tower_rewards_preview", nil, true)
end
function E.prototype.UnregisterModuleEvents(self)
	if self.startEventId ~= nil then
		Event:Unregister(self.startEventId)
		self.startEventId = nil
	end
	if self.stopEventId ~= nil then
		Event:Unregister(self.stopEventId)
		self.stopEventId = nil
	end
	if self.receiveRewardsEventId ~= nil then
		StopCustomUIEvent(self.receiveRewardsEventId)
		self.receiveRewardsEventId = nil
	end
	if self.buyActionsEventId ~= nil then
		StopCustomUIEvent(self.buyActionsEventId)
		self.buyActionsEventId = nil
	end
end
E = k({ n }, E)
if BattleGem == nil then
	BattleGem = f(E)
end
return l