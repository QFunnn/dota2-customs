--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
function F.prototype.HandleAllPlayersDead(self)
	if self.state ~= "running" then
		return false
	end
	self:FinishBattle("failed", "AllPlayersDead")
	return true
end
function F.prototype.Start(self, H, J, K)
	self:Stop("Restart", { unloadScene = true })
	local L, M = self, "runId"
	local N = L[M] + 1
	L[M] = N
	local O = N
	self.state = "loading"
	self.difficulty = H
	self.participantPlayerIds = f(J)
	self:ResetBattleProgressState()
	self:ResetSettlementRuntime()
	do
		local P = 0
		while P < #self.participantPlayerIds do
			self:ClearPlayerSettlementPreview(self.participantPlayerIds[P + 1])
			P = P + 1
		end
	end
	self:CalculateDifficultyModifiers()
	local Q = self.difficultyConfigByNumber[self.difficulty]
	if Q == nil then
		self:error(
			(self.logPrefix .. " start failed: difficulty config missing difficulty=") .. tostring(self.difficulty)
		)
		self:Stop("DifficultyMissing", { unloadScene = true })
		return
	end
	self.maxLevel = Q.maxLevel
	self.currentLevel = 1
	self:SyncState()
	self:print(
		(
			(
				(
					(
						((((self.logPrefix .. " start run=") .. tostring(O)) .. " difficulty=") .. tostring(H))
						.. " maxLevel="
					) .. tostring(self.maxLevel)
				) .. " players=["
			) .. table.concat(self.participantPlayerIds, ",")
		) .. "]"
	)
	self.battleCenter = Vector(K.x, K.y, K.z)
	local R = self:GetBattlePrefabName()
	DungeonManager:ShowLoadingScreen()
	self.spawnGroup = DOTA_SpawnMapAtPosition(R, K, true, function(S)
		if not self:IsActiveRun(O) then
			return
		end
		self:print(
			(
				(
					(
						(
							((((self.logPrefix .. " ready to spawn prefab=") .. R) .. " loadPoint=(") .. tostring(K.x))
							.. ","
						) .. tostring(K.y)
					) .. ","
				) .. tostring(K.z)
			) .. ")"
		)
		ManuallyTriggerSpawnGroupCompletion(S)
	end, function()
		if not self:IsActiveRun(O) then
			return
		end
		self:OnMapLoaded(O)
		DungeonManager:HideLoadingScreen()
	end, nil)
end
function F.prototype.Stop(self, T, U)
	if T == nil then
		T = "Manual"
	end
	local V = (U and U.unloadScene) ~= false
	local W = self:StopGameplay(T)
	local X = V and self:UnloadScene(T)
	if W or X then
		self:print((((self.logPrefix .. " stopped reason=") .. T) .. " unloadScene=") .. tostring(V))
	end
	if (W or X) and T ~= "ReceiveRewardsCompleted" and T ~= "AllPlayersReturned" and T ~= "Restart" then
		DungeonAdventure:CancelBattle("gem")
	end
end
function F.prototype.StopGameplay(self, T)
	if T == nil then
		T = "Manual"
	end
	local W = self.state == "loading" or self.state == "running"
	self.runId = self.runId + 1
	self.state = "finished"
	self:ClearRuntimeState()
	if W then
		self:print((self.logPrefix .. " gameplay stopped reason=") .. T)
	end
	return W
end
function F.prototype.UnloadScene(self, T)
	if T == nil then
		T = "Manual"
	end
	if self.spawnGroup == nil then
		return false
	end
	UnloadSpawnGroupByHandle(self.spawnGroup)
	self.spawnGroup = nil
	self:print((self.logPrefix .. " scene unloaded reason=") .. T)
	return true
end
function F.prototype.OnMapLoaded(self, O)
	local R = self:GetBattlePrefabName()
	self:print((self.logPrefix .. " prefab loaded prefab=") .. R)
	local Y = t(nil, self.spawnGroup, w)
	if Y == nil then
		self:error(((self.logPrefix .. " start failed: enter point '") .. w) .. "' not found in gem spawn group")
		self:Stop("EnterPointMissing", { unloadScene = true })
		return
	end
	self.enterPosition = Y.position
	self.entrancePrefix = Y.prefix
	local Z = t(nil, self.spawnGroup, x)
	self.exitPosition = Z and Z.position or self.enterPosition
	self.exitPrefix = Z and Z.prefix
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
											(((self.logPrefix .. " running run=") .. tostring(O)) .. " level=")
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
function F.prototype.TeleportPlayers(self, _)
	local a0 = self:GetParticipantHeroes()
	do
		local P = 0
		while P < #a0 do
			do
				local a1 = a0[P + 1]
				if not IsValid(a1) then
					goto a2
				end
				local a3 = _
				if #a0 > 1 then
					local a4 = (P - (#a0 - 1) / 2) * y
					a3 = Vector(_.x + a4, _.y, _.z)
				end
				FindClearSpaceForUnit(a1, a3, true)
				a1:SetForwardVector(vec3_top)
				a1:StartGesture(ACT_DOTA_TELEPORT_END)
				local a5 = PlayerResource:GetPlayer(a1:GetPlayerOwnerID())
				if a5 ~= nil then
					CustomGameEventManager:Send_ServerToPlayer(
						a5,
						"camera_follow_hero",
						{ transitionDuration = 0.2, x = a3.x, y = a3.y, z = a3.z }
					)
				end
				local a6 = a1:GetAbsOrigin()
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
																				.. a1:GetUnitName()
																			) .. " player="
																		)
																		.. tostring(a1:GetPlayerOwnerID())
																	) .. " targetPosition=("
																) .. tostring(a3.x)
															) .. ","
														) .. tostring(a3.y)
													) .. ","
												) .. tostring(a3.z)
											) .. ") position=("
										) .. tostring(a6.x)
									) .. ","
								) .. tostring(a6.y)
							) .. ","
						) .. tostring(a6.z)
					) .. ")"
				)
			end
			::a2::
			P = P + 1
		end
	end
end
function F.prototype.GetParticipantHeroes(self)
	local a0 = {}
	do
		local P = 0
		while P < #self.participantPlayerIds do
			local a1 = PlayerResource:GetSelectedHeroEntity(self.participantPlayerIds[P + 1])
			if IsValid(a1) and a1:IsRealHero() and a1:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
				a0[#a0 + 1] = a1
			end
			P = P + 1
		end
	end
	return a0
end
function F.prototype.StartCurrentLevel(self)
	local a7 = self.levelConfigByNumber[self.currentLevel]
	if a7 == nil then
		self:error((self.logPrefix .. " level config missing level=") .. tostring(self.currentLevel))
		self:FinishBattle("failed", "LevelConfigMissing")
		return
	end
	self:StopAttackTimer()
	local a8, a9 = self, "levelSpawnId"
	local aa = a8[a9] + 1
	a8[a9] = aa
	local ab = aa
	self.currentWave = 0
	self.pendingEnemySpawnCount = 0
	self:ClearEnemies()
	self.levelTotalEnemyCount = 0
	do
		local P = 0
		while P < #a7.waves do
			local ac, ad = self, "levelTotalEnemyCount"
			local ae = a7.waves[P + 1]
			ac[ad] = ac[ad] + (ae and ae.enemyCount or 0)
			P = P + 1
		end
	end
	self.attackEndTime = nil
	self:SyncState()
	self:StartNextWave(a7, ab)
	self:print(
		(
			(
				(
					(
						(((self.logPrefix .. " level started level=") .. tostring(self.currentLevel)) .. " waves=")
						.. tostring(#a7.waves)
					) .. " healthFactor="
				) .. tostring(a7.healthFactor)
			) .. " damageFactor="
		) .. tostring(a7.damageFactor)
	)
end
function F.prototype.StartNextWave(self, a7, ab)
	if self.state ~= "running" or self.levelSpawnId ~= ab then
		return
	end
	self.currentWave = self.currentWave + 1
	self.pendingEnemySpawnCount = 0
	self.currentWaveSuccessfulSpawnCount = 0
	local af = a7.waves[self.currentWave]
	if af == nil then
		self:OnLevelCleared()
		return
	end
	local ag = g(v, af.enemyList)
	if ag.ValidCount <= 0 then
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
					) .. tostring(#a7.waves)
				) .. " pool="
			) .. af.poolName
		)
		self:FinishBattle("failed", "EnemyPoolEmpty")
		return
	end
	local ah = af.enemyCount
	local ai = {}
	do
		local P = 0
		while P < #self.validGridPositions do
			local a6 = self.validGridPositions[P + 1]
			if a6 ~= nil and self:IsValidSpawnPosition(a6) then
				ai[#ai + 1] = a6
			end
			P = P + 1
		end
	end
	if #ai <= 0 then
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
					) .. tostring(#a7.waves)
				) .. " pool="
			) .. af.poolName
		)
		self:FinishBattle("failed", "NoValidSpawnPosition")
		return
	end
	local aj = {}
	do
		local P = 0
		while P < ah do
			do
				local ak = ag:Random()
				if ak == nil then
					break
				end
				local al = ai[P % #ai + 1]
				if al == nil then
					self:print(
						(
							(
								(self.logPrefix .. " spawn skipped: no valid position level=")
								.. tostring(self.currentLevel)
							) .. " unit="
						) .. ak
					)
					goto am
				end
				aj[#aj + 1] = { unitName = tostring(ak), spawnPos = al }
			end
			::am::
			P = P + 1
		end
	end
	if #aj ~= ah then
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
									) .. tostring(#a7.waves)
								) .. " pool="
							) .. af.poolName
						) .. " planned="
					) .. tostring(ah)
				) .. " actual="
			) .. tostring(#aj)
		)
		self:FinishBattle("failed", "SpawnRequestIncomplete")
		return
	end
	self.pendingEnemySpawnCount = #aj
	self:SyncState()
	do
		local P = 0
		while P < #aj do
			local an = aj[P + 1]
			self:SpawnEnemy(an.unitName, an.spawnPos, a7, af, ab)
			P = P + 1
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
								) .. tostring(#a7.waves)
							) .. " pool="
						) .. af.poolName
					) .. " spawnRequests="
				) .. tostring(#aj)
			) .. " healthFactor="
		) .. tostring(af.healthFactor)
	)
end
function F.prototype.SpawnEnemy(self, ak, al, a7, af, ab)
	CreateUnitByNameAsync(ak, al, true, nil, nil, DOTA_TEAM_BADGUYS, function(ao)
		if self.state ~= "running" or self.levelSpawnId ~= ab then
			if IsValid(ao) then
				self:RemoveUnit(ao)
			end
			return
		end
		self.pendingEnemySpawnCount = math.max(0, self.pendingEnemySpawnCount - 1)
		if not IsValid(ao) then
			self:error((((self.logPrefix .. " spawn failed unit=") .. ak) .. " level=") .. tostring(self.currentLevel))
			if self.pendingEnemySpawnCount <= 0 and self.currentWaveSuccessfulSpawnCount <= 0 then
				self:FinishBattle("failed", "EnemyWaveSpawnFailed")
				return
			end
			self:TryCompleteCurrentWave()
			return
		end
		self.currentWaveSuccessfulSpawnCount = self.currentWaveSuccessfulSpawnCount + 1
		FindClearSpaceForUnit(ao, al, true)
		ao:SetForwardVector(RandomVector(1))
		self:ApplyLevelModifiers(ao, a7, af)
		local ap = self.enemies
		ap[#ap + 1] = ao
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
	local a7 = self.levelConfigByNumber[self.currentLevel]
	if a7 ~= nil and self.currentWave < #a7.waves then
		self:StartNextWave(a7, self.levelSpawnId)
		return
	end
	self:OnLevelCleared()
end
function F.prototype.ApplyLevelModifiers(self, ao, a7, af)
	local aq = DungeonManager:GetDifficultyKeyHealthFactor()
	local ar = DungeonManager:GetDifficultyKeyDamageFactor()
	local as = (1 + self.difficultyHealthAmplify / 100) * a7.healthFactor * af.healthFactor * aq
	local at = (1 + self.difficultyDamageAmplify / 100) * a7.damageFactor * ar
	local au = (as - 1) * 100
	local av = (at - 1) * 100
	if au ~= 0 then
		ao:AddProperty(PropertyFunction.HEALTH_AMPLIFY, au)
	end
	if av ~= 0 then
		ao:AddProperty(PropertyFunction.ATTACK_AMPLIFY, av)
	end
	DungeonManager:ApplyDifficultyKeyDebuffs(ao)
end
function F.prototype.CalculateDifficultyModifiers(self)
	local aw = KeyValues.difficulty[tostring(self.difficulty)]
	if aw == nil then
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		self:error(
			(self.logPrefix .. " difficulty config missing in KeyValues.difficulty difficulty=")
				.. tostring(self.difficulty)
		)
		return
	end
	local ax = toFiniteNumber(aw.HealthFactor, 1)
	local ay = toFiniteNumber(aw.DamageFactor, 1)
	self.difficultyHealthAmplify = (ax - 1) * 100
	self.difficultyDamageAmplify = (ay - 1) * 100
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
function F.prototype.OnEntityKilled(self, az)
	if self.state ~= "running" then
		return
	end
	local aA = EntIndexToHScript(az.entindex_killed)
	if not IsValid(aA) then
		return
	end
	do
		local P = 0
		while P < #self.enemies do
			do
				if self.enemies[P + 1] ~= aA then
					goto aB
				end
				table.remove(self.enemies, P + 1)
				self:SyncState()
				self:TryCompleteCurrentWave()
				return
			end
			::aB::
			P = P + 1
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
function F.prototype.FinishBattle(self, aC, T)
	if self.state == "finished" then
		return
	end
	self.state = "finished"
	self.result = aC
	self.levelSpawnId = self.levelSpawnId + 1
	self.pendingEnemySpawnCount = 0
	self:StopAttackTimer()
	self.attackEndTime = nil
	self:ClearEnemies()
	self.levelTotalEnemyCount = 0
	local aD = self.battleCenter or self.exitPosition or self.enterPosition
	self:StartSettlementReviveCheck(aD)
	self:CreateSettlementChests(aD)
	self:SyncState()
	self:print(
		(
			(
				(((((self.logPrefix .. " battle finished result=") .. aC) .. " reason=") .. T) .. " level=")
				.. tostring(self.currentLevel)
			) .. " maxLevel="
		) .. tostring(self.maxLevel)
	)
end
function F.prototype.StartSettlementReviveCheck(self, a6)
	self:StopSettlementReviveTimer()
	if a6 == nil then
		self:error(self.logPrefix .. " settlement failed: reward position is undefined")
		return
	end
	self.settlementReviveTimerId = Timer:GameTimer(E, function()
		self.settlementReviveTimerId = nil
		if self.state ~= "finished" then
			return
		end
		self:ReviveDeadParticipantsForSettlement(a6)
	end)
end
function F.prototype.ReviveDeadParticipantsForSettlement(self, a6)
	do
		local P = 0
		while P < #self.participantPlayerIds do
			do
				local I = self.participantPlayerIds[P + 1]
				local a1 = PlayerResource:GetSelectedHeroEntity(I)
				if not IsValid(a1) or not a1:IsRealHero() then
					goto aE
				end
				if a1:IsAlive() then
					goto aE
				end
				local a3 =
					GetGroundPosition(Vector(a6.x + (P - (#self.participantPlayerIds - 1) / 2) * y, a6.y, a6.z), nil)
				a1:SetRespawnPosition(a3)
				a1:AddNewModifier(a1, nil, "modifier_respawn", { duration = 3 }, AddModifierFlag.IGNORE_DEATH)
				a1:RespawnHero(false, false)
				a1:SetHealth(a1:GetMaxHealth())
				FindClearSpaceForUnit(a1, a3, true)
				a1:SetForwardVector(vec3_top)
				a1:StartGesture(ACT_DOTA_TELEPORT_END)
				local a5 = PlayerResource:GetPlayer(I)
				if a5 ~= nil then
					CustomGameEventManager:Send_ServerToPlayer(
						a5,
						"camera_follow_hero",
						{ transitionDuration = 0.2, x = a3.x, y = a3.y, z = a3.z }
					)
				end
				self:print((self.logPrefix .. " revived participant for settlement player=") .. tostring(I))
			end
			::aE::
			P = P + 1
		end
	end
end
function F.prototype.StopSettlementReviveTimer(self)
	if self.settlementReviveTimerId ~= nil then
		Timer:StopTimer(self.settlementReviveTimerId)
		self.settlementReviveTimerId = nil
	end
end
function F.prototype.CreateSettlementChests(self, a6)
	if a6 == nil then
		return
	end
	self:ClearSettlementChests()
	local aF = GetGroundPosition(a6, nil)
	do
		local P = 0
		while P < #self.participantPlayerIds do
			local I = self.participantPlayerIds[P + 1]
			local aG = g(q, I, "9900000", aF, { 0, 0 })
			EmitSoundOnLocationForPlayer("Drop.Gem", aF, I)
			local aH = self.settlementRuntime.clientItems
			aH[#aH + 1] = aG
			local aI = Interaction:RegisterInteract(aG.entity, InteractType.BossChest, 200, function()
				if not aG:IsLanded() then
					return false
				end
				return self:OpenSettlementChest(I, aG, aG:GetLandedPosition())
			end, nil, I)
			if aI ~= -1 then
				local aJ = self.settlementRuntime.registeredInteracts
				aJ[#aJ + 1] = aI
			end
			P = P + 1
		end
	end
end
function F.prototype.OpenSettlementChest(self, I, aG, aF)
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
	EmitSoundOnLocationForPlayer("Chess.Open", aF, I)
	local aK = { match_id = Match:GetMatchID(), layer = self.currentLevel }
	CommonService:CallAction("/v1/settle/preview_tower_rewards", I, aK, function(aL, aM, aN)
		self.settlementRuntime.rewardPreviewRequestingPlayers[I] = false
		if aN.code ~= 0 and aN.code ~= 200 then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", aF, I)
		CommonService:CommonCallback(I, aN)
		self.settlementRuntime.rewardPreviewOpenedPlayers[I] = true
		self:UnregisterSettlementChest(aG)
		h(aG.particleIDs, function(aL, aO)
			ParticleManager:DestroyParticle(aO, false)
		end)
		local a5 = PlayerResource:GetPlayer(I)
		if a5 ~= nil then
			local aP = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/boss_chest_open.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				a5
			)
			ParticleManager:SetParticleControl(aP, 0, aG.entity:GetAbsOrigin())
			local aQ = aG.particleIDs
			aQ[#aQ + 1] = aP
		end
	end, false)
	return true
end
function F.prototype.UnregisterSettlementChest(self, aG)
	local aR = aG:GetEntityIndex()
	local aS = {}
	do
		local P = 0
		while P < #self.settlementRuntime.registeredInteracts do
			do
				local aT = self.settlementRuntime.registeredInteracts[P + 1]
				if aT == aR then
					Interaction:UnregisterInteractable(aT)
					goto aU
				end
				aS[#aS + 1] = aT
			end
			::aU::
			P = P + 1
		end
	end
	self.settlementRuntime.registeredInteracts = aS
end
function F.prototype.ClearSettlementChests(self)
	do
		local P = 0
		while P < #self.settlementRuntime.registeredInteracts do
			Interaction:UnregisterInteractable(self.settlementRuntime.registeredInteracts[P + 1])
			P = P + 1
		end
	end
	self.settlementRuntime.registeredInteracts = {}
	do
		local P = 0
		while P < #self.settlementRuntime.clientItems do
			self.settlementRuntime.clientItems[P + 1]:dispose()
			P = P + 1
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
	local aV = GetGroundPosition(self.exitPosition, nil)
	local aW = CreateUnitByName("npc_crystal_gate", aV, false, nil, nil, DOTA_TEAM_GOODGUYS)
	if not IsValid(aW) then
		return
	end
	aW:AddNewModifier(aW, nil, "modifier_no_health_bar", {})
	aW:SetForwardVector(vec3_bottom)
	local aI = Interaction:RegisterInteract(aW, InteractType.NPC, 200, function(aL, aX, I)
		self:ClearReturnGateIndicator(I)
		DungeonAdventure:ExitBattle("gem", I)
	end, 99999999)
	if aI ~= -1 then
		self.settlementRuntime.returnInteractId = aI
	end
	self.settlementRuntime.returnNpc = aW
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
	local a1 = PlayerResource:GetSelectedHeroEntity(I)
	local aY = self.settlementRuntime.returnNpc
	if not IsValid(a1) or not IsValid(aY) then
		return
	end
	a1:AddNewModifier(a1, nil, "modifier_arrow_target", { targetEntIndex = aY:entindex() })
end
function F.prototype.ClearReturnGateIndicator(self, I)
	local a1 = PlayerResource:GetSelectedHeroEntity(I)
	if IsValid(a1) then
		a1:RemoveModifierByName("modifier_arrow_target")
	end
end
function F.prototype.ClearReturnGateIndicators(self)
	do
		local P = 0
		while P < #self.participantPlayerIds do
			self:ClearReturnGateIndicator(self.participantPlayerIds[P + 1])
			P = P + 1
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
function F.prototype.IsValidSpawnPosition(self, a6)
	local a0 = self:GetParticipantHeroes()
	do
		local P = 0
		while P < #a0 do
			local a1 = a0[P + 1]
			if IsValid(a1) and CalcDistance(a6, a1:GetAbsOrigin()) < C then
				return false
			end
			P = P + 1
		end
	end
	return true
end
function F.prototype.ClearEnemies(self)
	do
		local P = 0
		while P < #self.enemies do
			local ao = self.enemies[P + 1]
			if ao ~= nil then
				self:RemoveUnit(ao)
			end
			P = P + 1
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
function F.prototype.RemoveUnit(self, aW)
	if not IsValid(aW) then
		return
	end
	aW:RemoveAllModifiers(0, false, true, false)
	aW:ForceKill(false)
	aW:MakeIllusion()
	aW:AddNoDraw()
	aW:CallAbilityDestroy()
	UTIL_Remove(aW)
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
			for ak, b8 in pairs(b6) do
				local b9 = math.max(0, math.floor(toFiniteNumber(b8, 0)))
				if b9 > 0 then
					b7[tostring(ak)] = b9
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
					for ak, b8 in pairs(bf.EnemyList) do
						local b9 = math.max(0, math.floor(toFiniteNumber(b8, 0)))
						if b9 > 0 then
							b7[tostring(ak)] = b9
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
			actionPurchasingPlayerIds = k(self.participantPlayerIds, function(aL, I)
				return self.settlementRuntime.actionPurchasingPlayers[I] == true
			end),
			actionPurchasedPlayerIds = k(self.participantPlayerIds, function(aL, I)
				return self.settlementRuntime.actionPurchasedPlayers[I] == true
			end),
		}
	)
end
function F.prototype.GetCurrentBossEntIndex(self)
	do
		local P = 0
		while P < #self.enemies do
			local ao = self.enemies[P + 1]
			if IsValid(ao) and i(ao:GetUnitLabel(), "boss") then
				return ao:entindex()
			end
			P = P + 1
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
function F.prototype.IsActiveRun(self, O)
	return self.runId == O
end
function F.prototype.OnBuyActions(self, az)
	local I = az.PlayerID
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
	local O = self.runId
	self.settlementRuntime.actionPurchasingPlayers[I] = true
	self:SyncState()
	if az.buy_product == 1 then
		self:BuyActionProduct(I, O)
		return
	end
	self:RequestBuyActions(I, O)
end
function F.prototype.BuyActionProduct(self, I, O)
	CommonService:CallAction("/v1/shop/buy", I, { amounts = 1, product_id = D }, function(aL, aM, aN)
		local bB = aN.code == 0 or aN.code == 200
		if bB then
			CommonService:CommonCallback(I, aN)
		end
		if not self:IsActionPurchaseRequestActive(I, O) then
			return
		end
		if not bB then
			self:FinishBuyActions(I, false, aN.message)
			return
		end
		self:RequestBuyActions(I, O)
	end, false)
end
function F.prototype.RequestBuyActions(self, I, O)
	local aK = { match_id = Match:GetMatchID() }
	CommonService:CallAction("/v1/settle/buy_tower_actions", I, aK, function(aL, aM, aN)
		if not self:IsActionPurchaseRequestActive(I, O) then
			return
		end
		CommonService:CommonCallback(I, aN)
		local bB = aN.code == 0 or aN.code == 200
		self:FinishBuyActions(I, bB, aN.message)
	end, false)
end
function F.prototype.IsActionPurchaseRequestActive(self, I, O)
	return self:IsActiveRun(O)
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
function F.prototype.OnReceiveRewards(self, az)
	if self.state ~= "finished" then
		return
	end
	if TableFindKey(self.participantPlayerIds, az.PlayerID) == nil then
		return
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[az.PlayerID] == true
		or self.settlementRuntime.rewardReceivingPlayers[az.PlayerID] == true
	then
		return
	end
	if self.settlementRuntime.actionPurchasingPlayers[az.PlayerID] == true then
		return
	end
	if self.settlementRuntime.rewardPreviewOpenedPlayers[az.PlayerID] ~= true then
		return
	end
	local bD = {}
	if az.actions ~= nil and az.actions ~= "" then
		local bE, bF = pcall(function()
			return json.decode(az.actions)
		end)
		if bE ~= true or bF == nil then
			self:error(
				(
					(
						(self.logPrefix .. " receive rewards failed: invalid actions payload player=")
						.. tostring(az.PlayerID)
					) .. " raw="
				) .. az.actions
			)
			return
		end
		bD = bF
	end
	local aK = { match_id = Match:GetMatchID(), actions = bD }
	self.settlementRuntime.rewardReceivingPlayers[az.PlayerID] = true
	CommonService:CallAction("/v1/settle/receive_tower_rewards", az.PlayerID, aK, function(aL, aM, aN)
		self.settlementRuntime.rewardReceivingPlayers[az.PlayerID] = false
		CommonService:CommonCallback(az.PlayerID, aN)
		if aN.code ~= 0 and aN.code ~= 200 then
			return
		end
		self.settlementRuntime.rewardReceivedPlayers[az.PlayerID] = true
		self:ClearPlayerSettlementPreview(az.PlayerID)
		self:OpenReturnGates()
		self:ShowReturnGateIndicator(az.PlayerID)
		if not self:AreAllParticipantsRewardsReceived() then
			return
		end
		self:ClearSettlementChests()
	end, false)
end
function F.prototype.AreAllParticipantsRewardsReceived(self)
	do
		local P = 0
		while P < #self.participantPlayerIds do
			if self.settlementRuntime.rewardReceivedPlayers[self.participantPlayerIds[P + 1]] ~= true then
				return false
			end
			P = P + 1
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