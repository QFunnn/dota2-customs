--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/battle_gem"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__ArraySlice
local g = b.__TS__New
local h = b.__TS__ArrayForEach
local i = b.__TS__StringStartsWith
local j = b.__TS__StringSubstring
local k = b.__TS__ArrayFilter
local l = b.__TS__DecorateLegacy
local m = {}
local n = require("lib.tstl-utils")
local o = n.reloadable
local p = require("class.client_item")
local q = p.ClientItem
local r = require("class.dungeon_helper")
local s = r.AnalyzeCenterPositions
local t = r.ResolveSpawnGroupInfoTarget
local u = require("class.weight_pool")
local v = u.CWeightPool
local w = "gem_dungeon_enter"
local x = "gem_dungeon_exit"
local y = 64
local z = 60
local A = 3
local B = GRID_SIZE
local C = 320
local D = 800151
local E = 0.5
local F = c()
F.name = "CBattleGem"
d(F, CModule)
function F.prototype.____constructor(self, ...)
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
	self.currentWaveSuccessfulSpawnCount = 0
	self.levelTotalEnemyCount = 0
	self.levelConfigByNumber = {}
	self.difficultyConfigByNumber = {}
	self.settlementRuntime = self:CreateSettlementRuntime()
end
function F.prototype.init(self, G)
	self:UnregisterModuleEvents()
	self:EnsureSettlementActionPurchaseState()
	self.receiveRewardsEventId = CustomUIEvent("battle_gem_receive_rewards", function(self, ...)
		return self:OnReceiveRewards(...)
	end, self)
	self.buyActionsEventId = CustomUIEvent("battle_gem_buy_actions", function(self, ...)
		return self:OnBuyActions(...)
	end, self)
	if not G then
		self:ClearRuntimeState()
	end
	self:LoadDifficultyConfig()
	self:LoadLevelConfig()
	self:print((self.logPrefix .. " init reload=") .. tostring(G))
end
function F.prototype.reset(self)
	self:Stop("Reset", { unloadScene = true })
end
function F.prototype.HasDifficultyConfig(self, H)
	if self.difficultyConfigByNumber[H] ~= nil then
		return true
	end
	return self.difficultyConfigByNumber[H] ~= nil
end
function F.prototype.IsRunning(self, I)
	return self.state == "running" and e(self.participantPlayerIds, I)
end
function F.prototype.IsActiveEnemy(self, J)
	return self.state == "running" and e(self.enemies, J)
end
function F.prototype.HandleAllPlayersDead(self)
	if self.state ~= "running" then
		return false
	end
	self:FinishBattle("failed", "AllPlayersDead")
	return true
end
function F.prototype.Start(self, H, K, L)
	self:Stop("Restart", { unloadScene = true })
	local M, N = self, "runId"
	local O = M[N] + 1
	M[N] = O
	local P = O
	self.state = "loading"
	self.difficulty = H
	self.participantPlayerIds = f(K)
	self:ResetBattleProgressState()
	self:ResetSettlementRuntime()
	do
		local Q = 0
		while Q < #self.participantPlayerIds do
			self:ClearPlayerSettlementPreview(self.participantPlayerIds[Q + 1])
			Q = Q + 1
		end
	end
	self:CalculateDifficultyModifiers()
	local R = self.difficultyConfigByNumber[self.difficulty]
	if R == nil then
		self:error(
			(self.logPrefix .. " start failed: difficulty config missing difficulty=") .. tostring(self.difficulty)
		)
		self:Stop("DifficultyMissing", { unloadScene = true })
		return
	end
	self.maxLevel = R.maxLevel
	self.currentLevel = 1
	self:SyncState()
	self:print(
		(
			(
				(
					(
						((((self.logPrefix .. " start run=") .. tostring(P)) .. " difficulty=") .. tostring(H))
						.. " maxLevel="
					) .. tostring(self.maxLevel)
				) .. " players=["
			) .. table.concat(self.participantPlayerIds, ",")
		) .. "]"
	)
	self.battleCenter = Vector(L.x, L.y, L.z)
	local S = self:GetBattlePrefabName()
	DungeonManager:ShowLoadingScreen()
	self.spawnGroup = DOTA_SpawnMapAtPosition(S, L, true, function(T)
		if not self:IsActiveRun(P) then
			return
		end
		self:print(
			(
				(
					(
						(
							((((self.logPrefix .. " ready to spawn prefab=") .. S) .. " loadPoint=(") .. tostring(L.x))
							.. ","
						) .. tostring(L.y)
					) .. ","
				) .. tostring(L.z)
			) .. ")"
		)
		ManuallyTriggerSpawnGroupCompletion(T)
	end, function()
		if not self:IsActiveRun(P) then
			return
		end
		self:OnMapLoaded(P)
		DungeonManager:HideLoadingScreen()
	end, nil)
end
function F.prototype.Stop(self, U, V)
	if U == nil then
		U = "Manual"
	end
	local W = (V and V.unloadScene) ~= false
	local X = self:StopGameplay(U)
	local Y = W and self:UnloadScene(U)
	if X or Y then
		self:print((((self.logPrefix .. " stopped reason=") .. U) .. " unloadScene=") .. tostring(W))
	end
	if (X or Y) and U ~= "ReceiveRewardsCompleted" and U ~= "AllPlayersReturned" and U ~= "Restart" then
		DungeonAdventure:CancelBattle("gem")
	end
end
function F.prototype.StopGameplay(self, U)
	if U == nil then
		U = "Manual"
	end
	local X = self.state == "loading" or self.state == "running"
	self.runId = self.runId + 1
	self.state = "finished"
	self:ClearRuntimeState()
	if X then
		self:print((self.logPrefix .. " gameplay stopped reason=") .. U)
	end
	return X
end
function F.prototype.UnloadScene(self, U)
	if U == nil then
		U = "Manual"
	end
	if self.spawnGroup == nil then
		return false
	end
	UnloadSpawnGroupByHandle(self.spawnGroup)
	self.spawnGroup = nil
	self:print((self.logPrefix .. " scene unloaded reason=") .. U)
	return true
end
function F.prototype.OnMapLoaded(self, P)
	local S = self:GetBattlePrefabName()
	self:print((self.logPrefix .. " prefab loaded prefab=") .. S)
	local Z = t(nil, self.spawnGroup, w)
	if Z == nil then
		self:error(((self.logPrefix .. " start failed: enter point '") .. w) .. "' not found in gem spawn group")
		self:Stop("EnterPointMissing", { unloadScene = true })
		return
	end
	self.enterPosition = Z.position
	self.entrancePrefix = Z.prefix
	local _ = t(nil, self.spawnGroup, x)
	self.exitPosition = _ and _.position or self.enterPosition
	self.exitPrefix = _ and _.prefix
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
											(((self.logPrefix .. " running run=") .. tostring(P)) .. " level=")
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
function F.prototype.TeleportPlayers(self, a0)
	local a1 = self:GetParticipantHeroes()
	do
		local Q = 0
		while Q < #a1 do
			do
				local a2 = a1[Q + 1]
				if not IsValid(a2) then
					goto a3
				end
				local a4 = a0
				if #a1 > 1 then
					local a5 = (Q - (#a1 - 1) / 2) * y
					a4 = Vector(a0.x + a5, a0.y, a0.z)
				end
				FindClearSpaceForUnit(a2, a4, true)
				a2:SetForwardVector(vec3_top)
				a2:StartGesture(ACT_DOTA_TELEPORT_END)
				local a6 = PlayerResource:GetPlayer(a2:GetPlayerOwnerID())
				if a6 ~= nil then
					CustomGameEventManager:Send_ServerToPlayer(
						a6,
						"camera_follow_hero",
						{ transitionDuration = 0.2, x = a4.x, y = a4.y, z = a4.z }
					)
				end
				local a7 = a2:GetAbsOrigin()
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
																				.. a2:GetUnitName()
																			) .. " player="
																		)
																		.. tostring(a2:GetPlayerOwnerID())
																	) .. " targetPosition=("
																) .. tostring(a4.x)
															) .. ","
														) .. tostring(a4.y)
													) .. ","
												) .. tostring(a4.z)
											) .. ") position=("
										) .. tostring(a7.x)
									) .. ","
								) .. tostring(a7.y)
							) .. ","
						) .. tostring(a7.z)
					) .. ")"
				)
			end
			::a3::
			Q = Q + 1
		end
	end
end
function F.prototype.GetParticipantHeroes(self)
	local a1 = {}
	do
		local Q = 0
		while Q < #self.participantPlayerIds do
			local a2 = PlayerResource:GetSelectedHeroEntity(self.participantPlayerIds[Q + 1])
			if IsValid(a2) and a2:IsRealHero() and a2:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
				a1[#a1 + 1] = a2
			end
			Q = Q + 1
		end
	end
	return a1
end
function F.prototype.StartCurrentLevel(self)
	local a8 = self.levelConfigByNumber[self.currentLevel]
	if a8 == nil then
		self:error((self.logPrefix .. " level config missing level=") .. tostring(self.currentLevel))
		self:FinishBattle("failed", "LevelConfigMissing")
		return
	end
	self:StopAttackTimer()
	local a9, aa = self, "levelSpawnId"
	local ab = a9[aa] + 1
	a9[aa] = ab
	local ac = ab
	self.currentWave = 0
	self.pendingEnemySpawnCount = 0
	self:ClearEnemies()
	self.levelTotalEnemyCount = 0
	do
		local Q = 0
		while Q < #a8.waves do
			local ad, ae = self, "levelTotalEnemyCount"
			local af = a8.waves[Q + 1]
			ad[ae] = ad[ae] + (af and af.enemyCount or 0)
			Q = Q + 1
		end
	end
	self.attackEndTime = nil
	self:SyncState()
	self:StartNextWave(a8, ac)
	self:print(
		(
			(
				(
					(
						(((self.logPrefix .. " level started level=") .. tostring(self.currentLevel)) .. " waves=")
						.. tostring(#a8.waves)
					) .. " healthFactor="
				) .. tostring(a8.healthFactor)
			) .. " damageFactor="
		) .. tostring(a8.damageFactor)
	)
end
function F.prototype.StartNextWave(self, a8, ac)
	if self.state ~= "running" or self.levelSpawnId ~= ac then
		return
	end
	self.currentWave = self.currentWave + 1
	self.pendingEnemySpawnCount = 0
	self.currentWaveSuccessfulSpawnCount = 0
	local ag = a8.waves[self.currentWave]
	if ag == nil then
		self:OnLevelCleared()
		return
	end
	local ah = g(v, ag.enemyList)
	if ah.ValidCount <= 0 then
		self:error(
			(
				(
					(
						(
							(
								(
									(self.logPrefix .. " wave spawn failed: enemy pool is empty level=")
									.. tostring(self.currentLevel)
								) .. " wave="
							) .. tostring(self.currentWave)
						) .. "/"
					) .. tostring(#a8.waves)
				) .. " pool="
			) .. ag.poolName
		)
		self:FinishBattle("failed", "EnemyPoolEmpty")
		return
	end
	local ai = ag.enemyCount
	local aj = {}
	do
		local Q = 0
		while Q < #self.validGridPositions do
			local a7 = self.validGridPositions[Q + 1]
			if a7 ~= nil and self:IsValidSpawnPosition(a7) then
				aj[#aj + 1] = a7
			end
			Q = Q + 1
		end
	end
	if #aj <= 0 then
		self:error(
			(
				(
					(
						(
							(
								(
									(self.logPrefix .. " wave spawn failed: no valid position level=")
									.. tostring(self.currentLevel)
								) .. " wave="
							) .. tostring(self.currentWave)
						) .. "/"
					) .. tostring(#a8.waves)
				) .. " pool="
			) .. ag.poolName
		)
		self:FinishBattle("failed", "NoValidSpawnPosition")
		return
	end
	local ak = {}
	do
		local Q = 0
		while Q < ai do
			do
				local al = ah:Random()
				if al == nil then
					break
				end
				local am = aj[Q % #aj + 1]
				if am == nil then
					self:print(
						(
							(
								(self.logPrefix .. " spawn skipped: no valid position level=")
								.. tostring(self.currentLevel)
							) .. " unit="
						) .. al
					)
					goto an
				end
				ak[#ak + 1] = { unitName = tostring(al), spawnPos = am }
			end
			::an::
			Q = Q + 1
		end
	end
	if #ak ~= ai then
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
														self.logPrefix
														.. " wave spawn failed: incomplete spawn requests level="
													) .. tostring(self.currentLevel)
												) .. " wave="
											) .. tostring(self.currentWave)
										) .. "/"
									) .. tostring(#a8.waves)
								) .. " pool="
							) .. ag.poolName
						) .. " planned="
					) .. tostring(ai)
				) .. " actual="
			) .. tostring(#ak)
		)
		self:FinishBattle("failed", "SpawnRequestIncomplete")
		return
	end
	self.pendingEnemySpawnCount = #ak
	self:SyncState()
	do
		local Q = 0
		while Q < #ak do
			local ao = ak[Q + 1]
			self:SpawnEnemy(ao.unitName, ao.spawnPos, a8, ag, ac)
			Q = Q + 1
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
								) .. tostring(#a8.waves)
							) .. " pool="
						) .. ag.poolName
					) .. " spawnRequests="
				) .. tostring(#ak)
			) .. " healthFactor="
		) .. tostring(ag.healthFactor)
	)
end
function F.prototype.SpawnEnemy(self, al, am, a8, ag, ac)
	CreateUnitByNameAsync(al, am, true, nil, nil, DOTA_TEAM_BADGUYS, function(ap)
		if self.state ~= "running" or self.levelSpawnId ~= ac then
			if IsValid(ap) then
				self:RemoveUnit(ap)
			end
			return
		end
		self.pendingEnemySpawnCount = math.max(0, self.pendingEnemySpawnCount - 1)
		if not IsValid(ap) then
			self:error((((self.logPrefix .. " spawn failed unit=") .. al) .. " level=") .. tostring(self.currentLevel))
			if self.pendingEnemySpawnCount <= 0 and self.currentWaveSuccessfulSpawnCount <= 0 then
				self:FinishBattle("failed", "EnemyWaveSpawnFailed")
				return
			end
			self:TryCompleteCurrentWave()
			return
		end
		self.currentWaveSuccessfulSpawnCount = self.currentWaveSuccessfulSpawnCount + 1
		FindClearSpaceForUnit(ap, am, true)
		ap:SetForwardVector(RandomVector(1))
		self:ApplyLevelModifiers(ap, a8, ag)
		local aq = self.enemies
		aq[#aq + 1] = ap
		if self.attackEndTime == nil then
			self:StartAttackTimer()
		end
		self:SyncState()
		self:TryCompleteCurrentWave()
	end)
end
function F.prototype.TryCompleteCurrentWave(self)
	if self.state ~= "running" or self.pendingEnemySpawnCount > 0 or #self.enemies > 0 then
		return
	end
	local a8 = self.levelConfigByNumber[self.currentLevel]
	if a8 ~= nil and self.currentWave < #a8.waves then
		self:StartNextWave(a8, self.levelSpawnId)
		return
	end
	self:OnLevelCleared()
end
function F.prototype.ApplyLevelModifiers(self, ap, a8, ag)
	local ar = DungeonManager:GetDifficultyKeyHealthFactor()
	local as = DungeonManager:GetDifficultyKeyDamageFactor()
	local at = (1 + self.difficultyHealthAmplify / 100) * a8.healthFactor * ag.healthFactor * ar
	local au = (1 + self.difficultyDamageAmplify / 100) * a8.damageFactor * as
	local av = (at - 1) * 100
	local aw = (au - 1) * 100
	if av ~= 0 then
		ap:AddProperty(PropertyFunction.HEALTH_AMPLIFY, av)
	end
	if aw ~= 0 then
		ap:AddProperty(PropertyFunction.ATTACK_AMPLIFY, aw)
	end
	DungeonManager:ApplyDifficultyKeyDebuffs(ap)
end
function F.prototype.CalculateDifficultyModifiers(self)
	local ax = KeyValues.difficulty[tostring(self.difficulty)]
	if ax == nil then
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		self:error(
			(self.logPrefix .. " difficulty config missing in KeyValues.difficulty difficulty=")
				.. tostring(self.difficulty)
		)
		return
	end
	local ay = toFiniteNumber(ax.HealthFactor, 1)
	local az = toFiniteNumber(ax.DamageFactor, 1)
	self.difficultyHealthAmplify = (ay - 1) * 100
	self.difficultyDamageAmplify = (az - 1) * 100
end
function F.prototype.StartAttackTimer(self)
	self:StopAttackTimer()
	self.attackEndTime = GameRules:GetGameTime() + z
	self:SyncState()
	self.attackTimerId = Timer:GameTimer(z, function()
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
function F.prototype.StopAttackTimer(self)
	if self.attackTimerId ~= nil then
		Timer:StopTimer(self.attackTimerId)
		self.attackTimerId = nil
	end
end
function F.prototype.RegisterKillListener(self)
	if self.killEventListenerId ~= nil then
		StopGameEvent(self.killEventListenerId)
	end
	self.killEventListenerId = GameEvent("entity_killed", function(self, ...)
		return self:OnEntityKilled(...)
	end, self)
end
function F.prototype.OnEntityKilled(self, aA)
	if self.state ~= "running" then
		return
	end
	local aB = EntIndexToHScript(aA.entindex_killed)
	if not IsValid(aB) then
		return
	end
	do
		local Q = 0
		while Q < #self.enemies do
			do
				if self.enemies[Q + 1] ~= aB then
					goto aC
				end
				table.remove(self.enemies, Q + 1)
				self:SyncState()
				self:TryCompleteCurrentWave()
				return
			end
			::aC::
			Q = Q + 1
		end
	end
end
function F.prototype.OnLevelCleared(self)
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
function F.prototype.FinishBattle(self, aD, U)
	if self.state == "finished" then
		return
	end
	self.state = "finished"
	self.result = aD
	self.levelSpawnId = self.levelSpawnId + 1
	self.pendingEnemySpawnCount = 0
	self:StopAttackTimer()
	self.attackEndTime = nil
	self:ClearEnemies()
	self.levelTotalEnemyCount = 0
	local aE = self.battleCenter or self.exitPosition or self.enterPosition
	self:StartSettlementReviveCheck(aE)
	self:CreateSettlementChests(aE)
	self:SyncState()
	self:print(
		(
			(
				(((((self.logPrefix .. " battle finished result=") .. aD) .. " reason=") .. U) .. " level=")
				.. tostring(self.currentLevel)
			) .. " maxLevel="
		) .. tostring(self.maxLevel)
	)
end
function F.prototype.StartSettlementReviveCheck(self, a7)
	self:StopSettlementReviveTimer()
	if a7 == nil then
		self:error(self.logPrefix .. " settlement failed: reward position is undefined")
		return
	end
	self.settlementReviveTimerId = Timer:GameTimer(E, function()
		self.settlementReviveTimerId = nil
		if self.state ~= "finished" then
			return
		end
		self:ReviveDeadParticipantsForSettlement(a7)
	end)
end
function F.prototype.ReviveDeadParticipantsForSettlement(self, a7)
	do
		local Q = 0
		while Q < #self.participantPlayerIds do
			do
				local I = self.participantPlayerIds[Q + 1]
				local a2 = PlayerResource:GetSelectedHeroEntity(I)
				if not IsValid(a2) or not a2:IsRealHero() then
					goto aF
				end
				if a2:IsAlive() then
					goto aF
				end
				local a4 =
					GetGroundPosition(Vector(a7.x + (Q - (#self.participantPlayerIds - 1) / 2) * y, a7.y, a7.z), nil)
				a2:SetRespawnPosition(a4)
				a2:AddNewModifier(a2, nil, "modifier_respawn", { duration = 3 }, AddModifierFlag.IGNORE_DEATH)
				a2:RespawnHero(false, false)
				a2:SetHealth(a2:GetMaxHealth())
				FindClearSpaceForUnit(a2, a4, true)
				a2:SetForwardVector(vec3_top)
				a2:StartGesture(ACT_DOTA_TELEPORT_END)
				local a6 = PlayerResource:GetPlayer(I)
				if a6 ~= nil then
					CustomGameEventManager:Send_ServerToPlayer(
						a6,
						"camera_follow_hero",
						{ transitionDuration = 0.2, x = a4.x, y = a4.y, z = a4.z }
					)
				end
				self:print((self.logPrefix .. " revived participant for settlement player=") .. tostring(I))
			end
			::aF::
			Q = Q + 1
		end
	end
end
function F.prototype.StopSettlementReviveTimer(self)
	if self.settlementReviveTimerId ~= nil then
		Timer:StopTimer(self.settlementReviveTimerId)
		self.settlementReviveTimerId = nil
	end
end
function F.prototype.CreateSettlementChests(self, a7)
	if a7 == nil then
		return
	end
	self:ClearSettlementChests()
	local aG = GetGroundPosition(a7, nil)
	do
		local Q = 0
		while Q < #self.participantPlayerIds do
			local I = self.participantPlayerIds[Q + 1]
			local aH = g(q, I, "9900000", aG, { 0, 0 })
			EmitSoundOnLocationForPlayer("Drop.Gem", aG, I)
			local aI = self.settlementRuntime.clientItems
			aI[#aI + 1] = aH
			local aJ = Interaction:RegisterInteract(aH.entity, InteractType.BossChest, 200, function()
				if not aH:IsLanded() then
					return false
				end
				return self:OpenSettlementChest(I, aH, aH:GetLandedPosition())
			end, nil, I)
			if aJ ~= -1 then
				local aK = self.settlementRuntime.registeredInteracts
				aK[#aK + 1] = aJ
			end
			Q = Q + 1
		end
	end
end
function F.prototype.OpenSettlementChest(self, I, aH, aG)
	if self.state ~= "finished" then
		return false
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[I] == true
		or self.settlementRuntime.rewardPreviewOpenedPlayers[I] == true
		or self.settlementRuntime.rewardPreviewRequestingPlayers[I] == true
	then
		return false
	end
	if Equipment:IsCapacityFull(I, "gem") then
		Equipment:ShowCapacityDialog(I, "gem", true)
		return false
	end
	self.settlementRuntime.rewardPreviewRequestingPlayers[I] = true
	EmitSoundOnLocationForPlayer("Chess.Open", aG, I)
	local aL = { match_id = Match:GetMatchID(), layer = self.currentLevel }
	CommonService:CallAction("/v1/settle/preview_tower_rewards", I, aL, function(aM, aN, aO)
		self.settlementRuntime.rewardPreviewRequestingPlayers[I] = false
		if aO.code ~= 0 and aO.code ~= 200 then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", aG, I)
		CommonService:CommonCallback(I, aO)
		self.settlementRuntime.rewardPreviewOpenedPlayers[I] = true
		self:UnregisterSettlementChest(aH)
		h(aH.particleIDs, function(aM, aP)
			ParticleManager:DestroyParticle(aP, false)
		end)
		local a6 = PlayerResource:GetPlayer(I)
		if a6 ~= nil then
			local aQ = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/boss_chest_open.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				a6
			)
			ParticleManager:SetParticleControl(aQ, 0, aH.entity:GetAbsOrigin())
			local aR = aH.particleIDs
			aR[#aR + 1] = aQ
		end
	end, false)
	return true
end
function F.prototype.UnregisterSettlementChest(self, aH)
	local aS = aH:GetEntityIndex()
	local aT = {}
	do
		local Q = 0
		while Q < #self.settlementRuntime.registeredInteracts do
			do
				local aU = self.settlementRuntime.registeredInteracts[Q + 1]
				if aU == aS then
					Interaction:UnregisterInteractable(aU)
					goto aV
				end
				aT[#aT + 1] = aU
			end
			::aV::
			Q = Q + 1
		end
	end
	self.settlementRuntime.registeredInteracts = aT
end
function F.prototype.ClearSettlementChests(self)
	do
		local Q = 0
		while Q < #self.settlementRuntime.registeredInteracts do
			Interaction:UnregisterInteractable(self.settlementRuntime.registeredInteracts[Q + 1])
			Q = Q + 1
		end
	end
	self.settlementRuntime.registeredInteracts = {}
	do
		local Q = 0
		while Q < #self.settlementRuntime.clientItems do
			self.settlementRuntime.clientItems[Q + 1]:dispose()
			Q = Q + 1
		end
	end
	self.settlementRuntime.clientItems = {}
end
function F.prototype.OpenReturnGates(self)
	if self.settlementRuntime.returnNpc ~= nil or self.exitPosition == nil then
		self:print(
			(self.logPrefix .. " return gate already opened or no exit position ") .. tostring(self.exitPosition)
		)
		return
	end
	local aW = GetGroundPosition(self.exitPosition, nil)
	local aX = CreateUnitByName("npc_crystal_gate", aW, false, nil, nil, DOTA_TEAM_GOODGUYS)
	if not IsValid(aX) then
		return
	end
	aX:AddNewModifier(aX, nil, "modifier_no_health_bar", {})
	aX:SetForwardVector(vec3_bottom)
	local aJ = Interaction:RegisterInteract(aX, InteractType.NPC, 200, function(aM, aY, I)
		self:ClearReturnGateIndicator(I)
		DungeonAdventure:ExitBattle("gem", I)
	end, 99999999)
	if aJ ~= -1 then
		self.settlementRuntime.returnInteractId = aJ
	end
	self.settlementRuntime.returnNpc = aX
end
function F.prototype.ClearReturnGate(self)
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
function F.prototype.ShowReturnGateIndicator(self, I)
	local a2 = PlayerResource:GetSelectedHeroEntity(I)
	local J = self.settlementRuntime.returnNpc
	if not IsValid(a2) or not IsValid(J) then
		return
	end
	a2:AddNewModifier(a2, nil, "modifier_arrow_target", { targetEntIndex = J:entindex() })
end
function F.prototype.ClearReturnGateIndicator(self, I)
	local a2 = PlayerResource:GetSelectedHeroEntity(I)
	if IsValid(a2) then
		a2:RemoveModifierByName("modifier_arrow_target")
	end
end
function F.prototype.ClearReturnGateIndicators(self)
	do
		local Q = 0
		while Q < #self.participantPlayerIds do
			self:ClearReturnGateIndicator(self.participantPlayerIds[Q + 1])
			Q = Q + 1
		end
	end
end
function F.prototype.GetBattlePrefabName(self)
	return "prefabs/gem_dungeon"
end
function F.prototype.AnalyzeGrid(self)
	if self.battleCenter == nil then
		self.validGridPositions = {}
		return
	end
	self.validGridPositions = s(nil, { center = self.battleCenter, rings = A, gridSize = B })
	self:print((self.logPrefix .. " grid analyzed count=") .. tostring(#self.validGridPositions))
end
function F.prototype.IsValidSpawnPosition(self, a7)
	local a1 = self:GetParticipantHeroes()
	do
		local Q = 0
		while Q < #a1 do
			local a2 = a1[Q + 1]
			if IsValid(a2) and CalcDistance(a7, a2:GetAbsOrigin()) < C then
				return false
			end
			Q = Q + 1
		end
	end
	return true
end
function F.prototype.ClearEnemies(self)
	do
		local Q = 0
		while Q < #self.enemies do
			local ap = self.enemies[Q + 1]
			if ap ~= nil then
				self:RemoveUnit(ap)
			end
			Q = Q + 1
		end
	end
	self.enemies = {}
end
function F.prototype.CreateSettlementRuntime(self)
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
function F.prototype.EnsureSettlementActionPurchaseState(self)
	local aZ, a_ = self.settlementRuntime, "actionPurchasedPlayers"
	if aZ[a_] == nil then
		aZ[a_] = {}
	end
	local b0, b1 = self.settlementRuntime, "actionPurchasingPlayers"
	if b0[b1] == nil then
		b0[b1] = {}
	end
end
function F.prototype.ResetBattleProgressState(self)
	self.result = nil
	self.attackEndTime = nil
	self.currentWave = 0
	self.levelTotalEnemyCount = 0
end
function F.prototype.ResetSettlementRuntime(self)
	self:ClearSettlementChests()
	self:ClearReturnGate()
	self.settlementRuntime = self:CreateSettlementRuntime()
end
function F.prototype.RemoveUnit(self, aX)
	if not IsValid(aX) then
		return
	end
	aX:RemoveAllModifiers(0, false, true, false)
	aX:ForceKill(false)
	aX:MakeIllusion()
	aX:AddNoDraw()
	aX:CallAbilityDestroy()
	UTIL_Remove(aX)
end
function F.prototype.LoadLevelConfig(self)
	self.levelConfigByNumber = {}
	local b2 = KeyValues.battle_gem_levels
	if b2 == nil then
		self:error(self.logPrefix .. " battle_gem_levels config not found")
		return false
	end
	local b3 = {}
	local b4 = b2.EnemyPools
	if b4 ~= nil then
		for b5, b6 in pairs(b4) do
			local b7 = {}
			for al, b8 in pairs(b6) do
				local b9 = math.max(0, math.floor(toFiniteNumber(b8, 0)))
				if b9 > 0 then
					b7[tostring(al)] = b9
				end
			end
			b3[tostring(b5)] = b7
		end
	end
	for ba, bb in pairs(b2) do
		do
			local bc = tostring(ba)
			if not i(bc, "level_") then
				goto bd
			end
			local be = toFiniteNumber(j(bc, #"level_"), -1)
			if be == nil or bb == nil then
				goto bd
			end
			if be < 1 then
				goto bd
			end
			local bf = bb
			local bg = {}
			if bf.WaveList ~= nil then
				do
					local bh = 1
					while true do
						local bi = bf.WaveList[tostring(bh)]
						if bi == nil then
							break
						end
						local bj = tostring
						local bk = bi.EnemyPool
						if bk == nil then
							bk = "creep"
						end
						local b5 = bj(bk)
						bg[#bg + 1] = {
							poolName = b5,
							enemyCount = math.max(1, math.floor(toFiniteNumber(bi.EnemyCount, 1))),
							healthFactor = math.max(0.01, toFiniteNumber(bi.HealthFactor, 1)),
							enemyList = b3[b5] or {},
						}
						bh = bh + 1
					end
				end
			end
			if #bg <= 0 then
				local b7 = {}
				if bf.EnemyList ~= nil then
					for al, b8 in pairs(bf.EnemyList) do
						local b9 = math.max(0, math.floor(toFiniteNumber(b8, 0)))
						if b9 > 0 then
							b7[tostring(al)] = b9
						end
					end
				end
				local bl = math.max(1, math.floor(toFiniteNumber(bf.WaveCount, 1)))
				local bm = math.max(1, math.floor(toFiniteNumber(bf.EnemyCountPerWave, 1)))
				do
					local bh = 1
					while bh <= bl do
						bg[#bg + 1] = { poolName = "legacy", enemyCount = bm, healthFactor = 1, enemyList = b7 }
						bh = bh + 1
					end
				end
			end
			self.levelConfigByNumber[be] = {
				level = be,
				healthFactor = math.max(0.1, toFiniteNumber(bf.HealthFactor, 1)),
				damageFactor = math.max(0.1, toFiniteNumber(bf.DamageFactor, 1)),
				waves = bg,
			}
		end
		::bd::
	end
	if self.levelConfigByNumber[1] == nil then
		self:error(self.logPrefix .. " level_1 missing in battle_gem_levels config")
		return false
	end
	return true
end
function F.prototype.LoadDifficultyConfig(self)
	self.difficultyConfigByNumber = {}
	local b2 = KeyValues.battle_gem_difficulty
	if b2 == nil then
		self:error(self.logPrefix .. " battle_gem_difficulty config not found")
		return false
	end
	for bn, bo in pairs(b2) do
		do
			if bo == nil then
				goto bp
			end
			local H = toFiniteNumber(bn, -1)
			if H < 1 then
				goto bp
			end
			local bf = bo
			self.difficultyConfigByNumber[H] =
				{ maxLevel = math.max(1, math.floor(toFiniteNumber(bf.layers_limit, 1))) }
		end
		::bp::
	end
	return true
end
function F.prototype.SyncState(self)
	local bq = CustomNetTables.SetNetData
	local br = self.state == "running"
	local bs = self.state == "loading"
	local bt = self.state == "finished"
	local bu = self.difficulty
	local bv = self.currentLevel
	local bw = self.maxLevel
	local bx = self.result
	local by = self.attackEndTime
	local bz = self.currentWave
	local bA = self.levelConfigByNumber[self.currentLevel]
	bq(
		CustomNetTables,
		"common",
		"battle_gem_state",
		{
			isRunning = br,
			isLoading = bs,
			isFinished = bt,
			difficulty = bu,
			currentLevel = bv,
			maxLevel = bw,
			result = bx,
			attackDuration = z,
			attackEndTime = by,
			currentWave = bz,
			totalWaveCount = bA and #bA.waves or 0,
			aliveEnemyCount = #self.enemies,
			totalEnemyCount = self.levelTotalEnemyCount,
			bossEntIndex = self:GetCurrentBossEntIndex(),
			participantPlayerIds = f(self.participantPlayerIds),
			actionPurchasingPlayerIds = k(self.participantPlayerIds, function(aM, I)
				return self.settlementRuntime.actionPurchasingPlayers[I] == true
			end),
			actionPurchasedPlayerIds = k(self.participantPlayerIds, function(aM, I)
				return self.settlementRuntime.actionPurchasedPlayers[I] == true
			end),
		}
	)
end
function F.prototype.GetCurrentBossEntIndex(self)
	do
		local Q = 0
		while Q < #self.enemies do
			local ap = self.enemies[Q + 1]
			if IsValid(ap) and i(ap:GetUnitLabel(), "boss") then
				return ap:entindex()
			end
			Q = Q + 1
		end
	end
	return nil
end
function F.prototype.ClearRuntimeState(self)
	self:StopAttackTimer()
	self:StopSettlementReviveTimer()
	self.levelSpawnId = self.levelSpawnId + 1
	self.currentWave = 0
	self.pendingEnemySpawnCount = 0
	self.currentWaveSuccessfulSpawnCount = 0
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
function F.prototype.IsActiveRun(self, P)
	return self.runId == P
end
function F.prototype.OnBuyActions(self, aA)
	local I = aA.PlayerID
	if self.state ~= "finished" then
		return
	end
	if TableFindKey(self.participantPlayerIds, I) == nil then
		return
	end
	if self.settlementRuntime.rewardPreviewOpenedPlayers[I] ~= true then
		return
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[I] == true
		or self.settlementRuntime.rewardReceivingPlayers[I] == true
	then
		return
	end
	if
		self.settlementRuntime.actionPurchasedPlayers[I] == true
		or self.settlementRuntime.actionPurchasingPlayers[I] == true
	then
		return
	end
	local P = self.runId
	self.settlementRuntime.actionPurchasingPlayers[I] = true
	self:SyncState()
	if aA.buy_product == 1 then
		self:BuyActionProduct(I, P)
		return
	end
	self:RequestBuyActions(I, P)
end
function F.prototype.BuyActionProduct(self, I, P)
	CommonService:CallAction("/v1/shop/buy", I, { amounts = 1, product_id = D }, function(aM, aN, aO)
		local bB = aO.code == 0 or aO.code == 200
		if bB then
			CommonService:CommonCallback(I, aO)
		end
		if not self:IsActionPurchaseRequestActive(I, P) then
			return
		end
		if not bB then
			self:FinishBuyActions(I, false, aO.message)
			return
		end
		self:RequestBuyActions(I, P)
	end, false)
end
function F.prototype.RequestBuyActions(self, I, P)
	local aL = { match_id = Match:GetMatchID() }
	CommonService:CallAction("/v1/settle/buy_tower_actions", I, aL, function(aM, aN, aO)
		if not self:IsActionPurchaseRequestActive(I, P) then
			return
		end
		CommonService:CommonCallback(I, aO)
		local bB = aO.code == 0 or aO.code == 200
		self:FinishBuyActions(I, bB, aO.message)
	end, false)
end
function F.prototype.IsActionPurchaseRequestActive(self, I, P)
	return self:IsActiveRun(P)
		and self.state == "finished"
		and self.settlementRuntime.actionPurchasingPlayers[I] == true
end
function F.prototype.FinishBuyActions(self, I, bB, bC)
	self.settlementRuntime.actionPurchasingPlayers[I] = false
	if bB then
		self.settlementRuntime.actionPurchasedPlayers[I] = true
	else
		ErrorMessage(bC, I)
	end
	self:SyncState()
end
function F.prototype.OnReceiveRewards(self, aA)
	if self.state ~= "finished" then
		return
	end
	if TableFindKey(self.participantPlayerIds, aA.PlayerID) == nil then
		return
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[aA.PlayerID] == true
		or self.settlementRuntime.rewardReceivingPlayers[aA.PlayerID] == true
	then
		return
	end
	if self.settlementRuntime.actionPurchasingPlayers[aA.PlayerID] == true then
		return
	end
	if self.settlementRuntime.rewardPreviewOpenedPlayers[aA.PlayerID] ~= true then
		return
	end
	local bD = {}
	if aA.actions ~= nil and aA.actions ~= "" then
		local bE, bF = pcall(function()
			return json.decode(aA.actions)
		end)
		if bE ~= true or bF == nil then
			self:error(
				(
					(
						(self.logPrefix .. " receive rewards failed: invalid actions payload player=")
						.. tostring(aA.PlayerID)
					) .. " raw="
				) .. aA.actions
			)
			return
		end
		bD = bF
	end
	local aL = { match_id = Match:GetMatchID(), actions = bD }
	self.settlementRuntime.rewardReceivingPlayers[aA.PlayerID] = true
	CommonService:CallAction("/v1/settle/receive_tower_rewards", aA.PlayerID, aL, function(aM, aN, aO)
		self.settlementRuntime.rewardReceivingPlayers[aA.PlayerID] = false
		CommonService:CommonCallback(aA.PlayerID, aO)
		if aO.code ~= 0 and aO.code ~= 200 then
			return
		end
		self.settlementRuntime.rewardReceivedPlayers[aA.PlayerID] = true
		self:ClearPlayerSettlementPreview(aA.PlayerID)
		self:OpenReturnGates()
		self:ShowReturnGateIndicator(aA.PlayerID)
		if not self:AreAllParticipantsRewardsReceived() then
			return
		end
		self:ClearSettlementChests()
	end, false)
end
function F.prototype.AreAllParticipantsRewardsReceived(self)
	do
		local Q = 0
		while Q < #self.participantPlayerIds do
			if self.settlementRuntime.rewardReceivedPlayers[self.participantPlayerIds[Q + 1]] ~= true then
				return false
			end
			Q = Q + 1
		end
	end
	return true
end
function F.prototype.ClearPlayerSettlementPreview(self, I)
	CommonService:SetPlayerServiceNetData(I, "player_tower_rewards_preview", nil, true)
end
function F.prototype.UnregisterModuleEvents(self)
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
F = l({ o }, F)
if BattleGem == nil then
	BattleGem = g(F)
end
return m