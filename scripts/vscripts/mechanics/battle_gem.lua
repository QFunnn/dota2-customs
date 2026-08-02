--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
local j = b.__TS__DecorateLegacy
local k = {}
local l = require("lib.tstl-utils")
local m = l.reloadable
local n = require("class.client_item")
local o = n.ClientItem
local p = require("class.dungeon_helper")
local q = p.AnalyzeCenterPositions
local r = p.ResolveSpawnGroupInfoTarget
local s = "gem_dungeon_enter"
local t = "gem_dungeon_exit"
local u = 64
local v = 30
local w = 3
local x = GRID_SIZE
local y = 50
local z = 320
local A = c()
A.name = "CBattleGem"
d(A, CModule)
function A.prototype.____constructor(self, ...)
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
	self.pendingEnemySpawnCount = 0
	self.currentLevelTotalEnemyCount = 0
	self.levelConfigByNumber = {}
	self.difficultyConfigByNumber = {}
	self.settlementRuntime = self:CreateSettlementRuntime()
end
function A.prototype.init(self, B)
	self:UnregisterModuleEvents()
	self.receiveRewardsEventId = CustomUIEvent("battle_gem_receive_rewards", function(self, ...)
		return self:OnReceiveRewards(...)
	end, self)
	if not B then
		self:ClearRuntimeState()
	end
	self:LoadDifficultyConfig()
	self:LoadLevelConfig()
	self:print((self.logPrefix .. " init reload=") .. tostring(B))
end
function A.prototype.reset(self)
	self:Stop("Reset", { unloadScene = true })
end
function A.prototype.HasDifficultyConfig(self, C)
	if self.difficultyConfigByNumber[C] ~= nil then
		return true
	end
	return self.difficultyConfigByNumber[C] ~= nil
end
function A.prototype.HandleAllPlayersDead(self)
	if self.state ~= "running" then
		return false
	end
	self:FinishBattle("failed", "AllPlayersDead")
	return true
end
function A.prototype.Start(self, C, D, E)
	self:Stop("Restart", { unloadScene = true })
	local F, G = self, "runId"
	local H = F[G] + 1
	F[G] = H
	local I = H
	self.state = "loading"
	self.difficulty = C
	self.participantPlayerIds = e(D)
	self:ResetBattleProgressState()
	self:ResetSettlementRuntime()
	do
		local J = 0
		while J < #self.participantPlayerIds do
			self:ClearPlayerSettlementPreview(self.participantPlayerIds[J + 1])
			J = J + 1
		end
	end
	self:CalculateDifficultyModifiers()
	local K = self.difficultyConfigByNumber[self.difficulty]
	if K == nil then
		self:error(
			(self.logPrefix .. " start failed: difficulty config missing difficulty=") .. tostring(self.difficulty)
		)
		self:Stop("DifficultyMissing", { unloadScene = true })
		return
	end
	self.maxLevel = K.maxLevel
	self.currentLevel = 1
	self:SyncState()
	self:print(
		(
			(
				(
					(
						((((self.logPrefix .. " start run=") .. tostring(I)) .. " difficulty=") .. tostring(C))
						.. " maxLevel="
					) .. tostring(self.maxLevel)
				) .. " players=["
			) .. table.concat(self.participantPlayerIds, ",")
		) .. "]"
	)
	self.battleCenter = Vector(E.x, E.y, E.z)
	local L = self:GetBattlePrefabName()
	DungeonManager:ShowLoadingScreen()
	self.spawnGroup = DOTA_SpawnMapAtPosition(L, E, true, function(M)
		if not self:IsActiveRun(I) then
			return
		end
		self:print(
			(
				(
					(
						(
							((((self.logPrefix .. " ready to spawn prefab=") .. L) .. " loadPoint=(") .. tostring(E.x))
							.. ","
						) .. tostring(E.y)
					) .. ","
				) .. tostring(E.z)
			) .. ")"
		)
		ManuallyTriggerSpawnGroupCompletion(M)
	end, function()
		if not self:IsActiveRun(I) then
			return
		end
		self:OnMapLoaded(I)
		DungeonManager:HideLoadingScreen()
	end, nil)
end
function A.prototype.Stop(self, N, O)
	if N == nil then
		N = "Manual"
	end
	local P = (O and O.unloadScene) ~= false
	local Q = self:StopGameplay(N)
	local R = P and self:UnloadScene(N)
	if Q or R then
		self:print((((self.logPrefix .. " stopped reason=") .. N) .. " unloadScene=") .. tostring(P))
	end
	if (Q or R) and N ~= "ReceiveRewardsCompleted" and N ~= "AllPlayersReturned" and N ~= "Restart" then
		DungeonAdventure:CancelBattle("gem")
	end
end
function A.prototype.StopGameplay(self, N)
	if N == nil then
		N = "Manual"
	end
	local Q = self.state == "loading" or self.state == "running"
	self.runId = self.runId + 1
	self.state = "finished"
	self:ClearRuntimeState()
	if Q then
		self:print((self.logPrefix .. " gameplay stopped reason=") .. N)
	end
	return Q
end
function A.prototype.UnloadScene(self, N)
	if N == nil then
		N = "Manual"
	end
	if self.spawnGroup == nil then
		return false
	end
	UnloadSpawnGroupByHandle(self.spawnGroup)
	self.spawnGroup = nil
	self:print((self.logPrefix .. " scene unloaded reason=") .. N)
	return true
end
function A.prototype.OnMapLoaded(self, I)
	local L = self:GetBattlePrefabName()
	self:print((self.logPrefix .. " prefab loaded prefab=") .. L)
	local S = r(nil, self.spawnGroup, s)
	if S == nil then
		self:error(((self.logPrefix .. " start failed: enter point '") .. s) .. "' not found in gem spawn group")
		self:Stop("EnterPointMissing", { unloadScene = true })
		return
	end
	self.enterPosition = S.position
	self.entrancePrefix = S.prefix
	local T = r(nil, self.spawnGroup, t)
	self.exitPosition = T and T.position or self.enterPosition
	self.exitPrefix = T and T.prefix
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
											(((self.logPrefix .. " running run=") .. tostring(I)) .. " level=")
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
function A.prototype.TeleportPlayers(self, U)
	local V = self:GetParticipantHeroes()
	do
		local J = 0
		while J < #V do
			do
				local W = V[J + 1]
				if not IsValid(W) then
					goto X
				end
				local Y = U
				if #V > 1 then
					local Z = (J - (#V - 1) / 2) * u
					Y = Vector(U.x + Z, U.y, U.z)
				end
				FindClearSpaceForUnit(W, Y, true)
				W:SetForwardVector(vec3_top)
				W:StartGesture(ACT_DOTA_TELEPORT_END)
				local _ = W:GetAbsOrigin()
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
																				.. W:GetUnitName()
																			) .. " player="
																		)
																		.. tostring(W:GetPlayerOwnerID())
																	) .. " targetPosition=("
																) .. tostring(Y.x)
															) .. ","
														) .. tostring(Y.y)
													) .. ","
												) .. tostring(Y.z)
											) .. ") position=("
										) .. tostring(_.x)
									) .. ","
								) .. tostring(_.y)
							) .. ","
						) .. tostring(_.z)
					) .. ")"
				)
			end
			::X::
			J = J + 1
		end
	end
end
function A.prototype.GetParticipantHeroes(self)
	local V = {}
	do
		local J = 0
		while J < #self.participantPlayerIds do
			local W = PlayerResource:GetSelectedHeroEntity(self.participantPlayerIds[J + 1])
			if IsValid(W) and W:IsRealHero() and W:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
				V[#V + 1] = W
			end
			J = J + 1
		end
	end
	return V
end
function A.prototype.StartCurrentLevel(self)
	local a0 = self.levelConfigByNumber[self.currentLevel]
	if a0 == nil then
		self:error((self.logPrefix .. " level config missing level=") .. tostring(self.currentLevel))
		self:FinishBattle("failed", "LevelConfigMissing")
		return
	end
	self:StopAttackTimer()
	local a1, a2 = self, "levelSpawnId"
	local a3 = a1[a2] + 1
	a1[a2] = a3
	local a4 = a3
	self.pendingEnemySpawnCount = 0
	self:ClearEnemies()
	self.currentLevelTotalEnemyCount = 0
	self.attackEndTime = nil
	self:SyncState()
	local a5 = 0
	for a6, a7 in pairs(a0.enemyList) do
		a5 = a5 + math.max(0, math.floor(toFiniteNumber(a7, 0)))
	end
	local a8 = self.enterPosition
	local a9 = {}
	if a8 ~= nil then
		a9 = self:GetValidSpawnPositions(a8, 300)
		if #a9 < a5 then
			a9 = self:GetValidSpawnPositions(a8, 600)
		end
		if #a9 < a5 then
			a9 = self:GetValidSpawnPositions(a8, 1200)
		end
	end
	if #a9 <= 0 then
		do
			local J = 0
			while J < #self.validGridPositions do
				local _ = self.validGridPositions[J + 1]
				if _ ~= nil and self:IsValidSpawnPosition(_) then
					a9[#a9 + 1] = _
				end
				J = J + 1
			end
		end
	end
	do
		local J = #a9 - 1
		while J > 0 do
			local aa = RandomInt(0, J)
			local ab = a9[J + 1]
			a9[J + 1] = a9[aa + 1]
			a9[aa + 1] = ab
			J = J - 1
		end
	end
	local ac = {}
	for ad, a7 in pairs(a0.enemyList) do
		local ae = math.max(0, math.floor(toFiniteNumber(a7, 0)))
		do
			local J = 0
			while J < ae do
				do
					local af = table.remove(a9) or self:FindRandomSpawnPosition()
					if af == nil then
						self:print(
							(
								(
									(self.logPrefix .. " spawn skipped: no valid position level=")
									.. tostring(self.currentLevel)
								) .. " unit="
							) .. ad
						)
						goto ag
					end
					ac[#ac + 1] = { unitName = tostring(ad), spawnPos = af }
				end
				::ag::
				J = J + 1
			end
		end
	end
	if #ac <= 0 then
		self:print((self.logPrefix .. " level has no spawned enemies level=") .. tostring(self.currentLevel))
		self:OnLevelCleared()
		return
	end
	self.pendingEnemySpawnCount = #ac
	self.currentLevelTotalEnemyCount = #ac
	self:SyncState()
	do
		local J = 0
		while J < #ac do
			local ah = ac[J + 1]
			self:SpawnEnemy(ah.unitName, ah.spawnPos, a0, a4)
			J = J + 1
		end
	end
	self:print(
		(
			(
				(
					(
						(
							((self.logPrefix .. " level started level=") .. tostring(self.currentLevel))
							.. " spawnRequests="
						) .. tostring(#ac)
					) .. " healthFactor="
				) .. tostring(a0.healthFactor)
			) .. " damageFactor="
		) .. tostring(a0.damageFactor)
	)
end
function A.prototype.GetValidSpawnPositions(self, ai, aj)
	local ak = {}
	do
		local J = 0
		while J < #self.validGridPositions do
			do
				local _ = self.validGridPositions[J + 1]
				if _ == nil then
					goto al
				end
				if CalcDistance(_, ai) < aj and self:IsValidSpawnPosition(_) then
					ak[#ak + 1] = _
				end
			end
			::al::
			J = J + 1
		end
	end
	return ak
end
function A.prototype.SpawnEnemy(self, ad, af, a0, a4)
	CreateUnitByNameAsync(ad, af, true, nil, nil, DOTA_TEAM_BADGUYS, function(am)
		if self.state ~= "running" or self.levelSpawnId ~= a4 then
			if IsValid(am) then
				self:RemoveUnit(am)
			end
			return
		end
		self.pendingEnemySpawnCount = math.max(0, self.pendingEnemySpawnCount - 1)
		if not IsValid(am) then
			self.currentLevelTotalEnemyCount = math.max(0, self.currentLevelTotalEnemyCount - 1)
			self:print((((self.logPrefix .. " spawn failed unit=") .. ad) .. " level=") .. tostring(self.currentLevel))
			self:TryCompleteCurrentLevel()
			return
		end
		FindClearSpaceForUnit(am, af, true)
		am:SetForwardVector(RandomVector(1))
		self:ApplyLevelModifiers(am, a0)
		local an = self.enemies
		an[#an + 1] = am
		if self.attackEndTime == nil then
			self:StartAttackTimer()
		end
		self:SyncState()
		self:TryCompleteCurrentLevel()
	end)
end
function A.prototype.TryCompleteCurrentLevel(self)
	if self.state ~= "running" or self.pendingEnemySpawnCount > 0 or #self.enemies > 0 then
		return
	end
	self:OnLevelCleared()
end
function A.prototype.ApplyLevelModifiers(self, am, a0)
	local ao = (1 + self.difficultyHealthAmplify / 100) * a0.healthFactor
	local ap = (1 + self.difficultyDamageAmplify / 100) * a0.damageFactor
	local aq = (ao - 1) * 100
	local ar = (ap - 1) * 100
	if aq ~= 0 then
		am:AddProperty(PropertyFunction.HEALTH_AMPLIFY, aq)
	end
	if ar ~= 0 then
		am:AddProperty(PropertyFunction.ATTACK_AMPLIFY, ar)
	end
end
function A.prototype.CalculateDifficultyModifiers(self)
	local as = KeyValues.difficulty[tostring(self.difficulty)]
	if as == nil then
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		self:error(
			(self.logPrefix .. " difficulty config missing in KeyValues.difficulty difficulty=")
				.. tostring(self.difficulty)
		)
		return
	end
	local at = toFiniteNumber(as.HealthFactor, 1)
	local au = toFiniteNumber(as.DamageFactor, 1)
	self.difficultyHealthAmplify = (at - 1) * 100
	self.difficultyDamageAmplify = (au - 1) * 100
end
function A.prototype.StartAttackTimer(self)
	self:StopAttackTimer()
	self.attackEndTime = GameRules:GetGameTime() + v
	self:SyncState()
	self.attackTimerId = Timer:GameTimer(v, function()
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
function A.prototype.StopAttackTimer(self)
	if self.attackTimerId ~= nil then
		Timer:StopTimer(self.attackTimerId)
		self.attackTimerId = nil
	end
end
function A.prototype.RegisterKillListener(self)
	if self.killEventListenerId ~= nil then
		StopGameEvent(self.killEventListenerId)
	end
	self.killEventListenerId = GameEvent("entity_killed", function(self, ...)
		return self:OnEntityKilled(...)
	end, self)
end
function A.prototype.OnEntityKilled(self, av)
	if self.state ~= "running" then
		return
	end
	local aw = EntIndexToHScript(av.entindex_killed)
	if not IsValid(aw) then
		return
	end
	do
		local J = 0
		while J < #self.enemies do
			do
				if self.enemies[J + 1] ~= aw then
					goto ax
				end
				table.remove(self.enemies, J + 1)
				self:SyncState()
				self:TryCompleteCurrentLevel()
				return
			end
			::ax::
			J = J + 1
		end
	end
end
function A.prototype.OnLevelCleared(self)
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
function A.prototype.FinishBattle(self, ay, N)
	if self.state == "finished" then
		return
	end
	self.state = "finished"
	self.result = ay
	self.levelSpawnId = self.levelSpawnId + 1
	self.pendingEnemySpawnCount = 0
	self:StopAttackTimer()
	self.attackEndTime = nil
	self:ClearEnemies()
	self.currentLevelTotalEnemyCount = 0
	local az = self.battleCenter or self.exitPosition or self.enterPosition
	self:CreateSettlementChests(az)
	self:SyncState()
	self:print(
		(
			(
				(((((self.logPrefix .. " battle finished result=") .. ay) .. " reason=") .. N) .. " level=")
				.. tostring(self.currentLevel)
			) .. " maxLevel="
		) .. tostring(self.maxLevel)
	)
end
function A.prototype.CreateSettlementChests(self, _)
	if _ == nil then
		return
	end
	self:ClearSettlementChests()
	local aA = GetGroundPosition(_, nil)
	do
		local J = 0
		while J < #self.participantPlayerIds do
			local aB = self.participantPlayerIds[J + 1]
			local aC = f(o, aB, "9900000", aA, { 0, 0 })
			EmitSoundOnLocationForPlayer("Drop.Gem", aA, aB)
			local aD = self.settlementRuntime.clientItems
			aD[#aD + 1] = aC
			local aE = Interaction:RegisterInteract(aC.entity, InteractType.BossChest, 200, function()
				if not aC:IsLanded() then
					return false
				end
				return self:OpenSettlementChest(aB, aC, aC:GetLandedPosition())
			end, nil, aB)
			if aE ~= -1 then
				local aF = self.settlementRuntime.registeredInteracts
				aF[#aF + 1] = aE
			end
			J = J + 1
		end
	end
end
function A.prototype.OpenSettlementChest(self, aB, aC, aA)
	if self.state ~= "finished" then
		return false
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[aB] == true
		or self.settlementRuntime.rewardPreviewOpenedPlayers[aB] == true
		or self.settlementRuntime.rewardPreviewRequestingPlayers[aB] == true
	then
		return false
	end
	self.settlementRuntime.rewardPreviewRequestingPlayers[aB] = true
	EmitSoundOnLocationForPlayer("Chess.Open", aA, aB)
	local aG = { match_id = Match:GetMatchID(), layer = self.currentLevel }
	CommonService:CallAction("/v1/settle/preview_tower_rewards", aB, aG, function(aH, aI, aJ)
		self.settlementRuntime.rewardPreviewRequestingPlayers[aB] = false
		if aJ.code ~= 0 and aJ.code ~= 200 then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", aA, aB)
		CommonService:CommonCallback(aB, aJ)
		self.settlementRuntime.rewardPreviewOpenedPlayers[aB] = true
		self:UnregisterSettlementChest(aC)
		g(aC.particleIDs, function(aH, aK)
			ParticleManager:DestroyParticle(aK, false)
		end)
		local aL = PlayerResource:GetPlayer(aB)
		if aL ~= nil then
			local aM = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/boss_chest_open.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				aL
			)
			ParticleManager:SetParticleControl(aM, 0, aC.entity:GetAbsOrigin())
			local aN = aC.particleIDs
			aN[#aN + 1] = aM
		end
	end, false)
	return true
end
function A.prototype.UnregisterSettlementChest(self, aC)
	local aO = aC:GetEntityIndex()
	local aP = {}
	do
		local J = 0
		while J < #self.settlementRuntime.registeredInteracts do
			do
				local aQ = self.settlementRuntime.registeredInteracts[J + 1]
				if aQ == aO then
					Interaction:UnregisterInteractable(aQ)
					goto aR
				end
				aP[#aP + 1] = aQ
			end
			::aR::
			J = J + 1
		end
	end
	self.settlementRuntime.registeredInteracts = aP
end
function A.prototype.ClearSettlementChests(self)
	do
		local J = 0
		while J < #self.settlementRuntime.registeredInteracts do
			Interaction:UnregisterInteractable(self.settlementRuntime.registeredInteracts[J + 1])
			J = J + 1
		end
	end
	self.settlementRuntime.registeredInteracts = {}
	do
		local J = 0
		while J < #self.settlementRuntime.clientItems do
			self.settlementRuntime.clientItems[J + 1]:dispose()
			J = J + 1
		end
	end
	self.settlementRuntime.clientItems = {}
end
function A.prototype.OpenReturnGates(self)
	if self.settlementRuntime.returnNpc ~= nil or self.exitPosition == nil then
		self:print(
			(self.logPrefix .. " return gate already opened or no exit position ") .. tostring(self.exitPosition)
		)
		return
	end
	local aS = GetGroundPosition(self.exitPosition, nil)
	local aT = CreateUnitByName("npc_crystal_gate", aS, false, nil, nil, DOTA_TEAM_GOODGUYS)
	if not IsValid(aT) then
		return
	end
	aT:AddNewModifier(aT, nil, "modifier_no_health_bar", {})
	aT:SetForwardVector(vec3_bottom)
	local aE = Interaction:RegisterInteract(aT, InteractType.NPC, 200, function(aH, aU, aB)
		self:ClearReturnGateIndicator(aB)
		DungeonAdventure:ExitBattle("gem", aB)
	end, 99999999)
	if aE ~= -1 then
		self.settlementRuntime.returnInteractId = aE
	end
	self.settlementRuntime.returnNpc = aT
end
function A.prototype.ClearReturnGate(self)
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
function A.prototype.ShowReturnGateIndicator(self, aB)
	local W = PlayerResource:GetSelectedHeroEntity(aB)
	local aV = self.settlementRuntime.returnNpc
	if not IsValid(W) or not IsValid(aV) then
		return
	end
	W:AddNewModifier(W, nil, "modifier_arrow_target", { targetEntIndex = aV:entindex() })
end
function A.prototype.ClearReturnGateIndicator(self, aB)
	local W = PlayerResource:GetSelectedHeroEntity(aB)
	if IsValid(W) then
		W:RemoveModifierByName("modifier_arrow_target")
	end
end
function A.prototype.ClearReturnGateIndicators(self)
	do
		local J = 0
		while J < #self.participantPlayerIds do
			self:ClearReturnGateIndicator(self.participantPlayerIds[J + 1])
			J = J + 1
		end
	end
end
function A.prototype.GetBattlePrefabName(self)
	return "prefabs/gem_dungeon"
end
function A.prototype.AnalyzeGrid(self)
	if self.battleCenter == nil then
		self.validGridPositions = {}
		return
	end
	self.validGridPositions = q(nil, { center = self.battleCenter, rings = w, gridSize = x })
	self:print((self.logPrefix .. " grid analyzed count=") .. tostring(#self.validGridPositions))
end
function A.prototype.FindRandomSpawnPosition(self)
	if #self.validGridPositions <= 0 then
		return nil
	end
	do
		local J = 0
		while J < y do
			local _ = self.validGridPositions[RandomInt(0, #self.validGridPositions - 1) + 1]
			if _ ~= nil and self:IsValidSpawnPosition(_) then
				return _
			end
			J = J + 1
		end
	end
end
function A.prototype.IsValidSpawnPosition(self, _)
	local V = self:GetParticipantHeroes()
	do
		local J = 0
		while J < #V do
			local W = V[J + 1]
			if IsValid(W) and CalcDistance(_, W:GetAbsOrigin()) < z then
				return false
			end
			J = J + 1
		end
	end
	return true
end
function A.prototype.ClearEnemies(self)
	do
		local J = 0
		while J < #self.enemies do
			local am = self.enemies[J + 1]
			if am ~= nil then
				self:RemoveUnit(am)
			end
			J = J + 1
		end
	end
	self.enemies = {}
end
function A.prototype.CreateSettlementRuntime(self)
	return {
		clientItems = {},
		registeredInteracts = {},
		returnInteractId = nil,
		rewardReceivedPlayers = {},
		rewardReceivingPlayers = {},
		rewardPreviewOpenedPlayers = {},
		rewardPreviewRequestingPlayers = {},
	}
end
function A.prototype.ResetBattleProgressState(self)
	self.result = nil
	self.attackEndTime = nil
	self.currentLevelTotalEnemyCount = 0
end
function A.prototype.ResetSettlementRuntime(self)
	self:ClearSettlementChests()
	self:ClearReturnGate()
	self.settlementRuntime = self:CreateSettlementRuntime()
end
function A.prototype.RemoveUnit(self, aT)
	if not IsValid(aT) then
		return
	end
	aT:RemoveAllModifiers(0, false, true, false)
	aT:ForceKill(false)
	aT:MakeIllusion()
	aT:AddNoDraw()
	aT:CallAbilityDestroy()
	UTIL_Remove(aT)
end
function A.prototype.LoadLevelConfig(self)
	self.levelConfigByNumber = {}
	local aW = KeyValues.battle_gem_levels
	if aW == nil then
		self:error(self.logPrefix .. " battle_gem_levels config not found")
		return false
	end
	for aX, aY in pairs(aW) do
		do
			local aZ = tostring(aX)
			if not h(aZ, "level_") then
				goto a_
			end
			local b0 = toFiniteNumber(i(aZ, #"level_"), -1)
			if b0 == nil or aY == nil then
				goto a_
			end
			if b0 < 1 then
				goto a_
			end
			local b1 = aY
			local b2 = {}
			if b1.EnemyList ~= nil then
				for ad, a7 in pairs(b1.EnemyList) do
					local b3 = math.max(0, math.floor(toFiniteNumber(a7, 0)))
					if b3 > 0 then
						b2[tostring(ad)] = b3
					end
				end
			end
			self.levelConfigByNumber[b0] = {
				level = b0,
				healthFactor = math.max(0.1, toFiniteNumber(b1.HealthFactor, 1)),
				damageFactor = math.max(0.1, toFiniteNumber(b1.DamageFactor, 1)),
				enemyList = b2,
			}
		end
		::a_::
	end
	if self.levelConfigByNumber[1] == nil then
		self:error(self.logPrefix .. " level_1 missing in battle_gem_levels config")
		return false
	end
	return true
end
function A.prototype.LoadDifficultyConfig(self)
	self.difficultyConfigByNumber = {}
	local aW = KeyValues.battle_gem_difficulty
	if aW == nil then
		self:error(self.logPrefix .. " battle_gem_difficulty config not found")
		return false
	end
	for b4, b5 in pairs(aW) do
		do
			if b5 == nil then
				goto b6
			end
			local C = toFiniteNumber(b4, -1)
			if C < 1 then
				goto b6
			end
			local b1 = b5
			self.difficultyConfigByNumber[C] =
				{ maxLevel = math.max(1, math.floor(toFiniteNumber(b1.layers_limit, 1))) }
		end
		::b6::
	end
	print(self.logPrefix .. " difficulty config:")
	DeepPrintTable(self.difficultyConfigByNumber)
	return true
end
function A.prototype.SyncState(self)
	CustomNetTables:SetNetData(
		"common",
		"battle_gem_state",
		{
			isRunning = self.state == "running",
			isLoading = self.state == "loading",
			isFinished = self.state == "finished",
			difficulty = self.difficulty,
			currentLevel = self.currentLevel,
			maxLevel = self.maxLevel,
			result = self.result,
			attackDuration = v,
			attackEndTime = self.attackEndTime,
			aliveEnemyCount = #self.enemies,
			totalEnemyCount = self.currentLevelTotalEnemyCount,
			participantPlayerIds = e(self.participantPlayerIds),
		}
	)
end
function A.prototype.ClearRuntimeState(self)
	self:StopAttackTimer()
	self.levelSpawnId = self.levelSpawnId + 1
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
function A.prototype.IsActiveRun(self, I)
	return self.runId == I
end
function A.prototype.OnReceiveRewards(self, av)
	if self.state ~= "finished" then
		return
	end
	if TableFindKey(self.participantPlayerIds, av.PlayerID) == nil then
		return
	end
	if
		self.settlementRuntime.rewardReceivedPlayers[av.PlayerID] == true
		or self.settlementRuntime.rewardReceivingPlayers[av.PlayerID] == true
	then
		return
	end
	if self.settlementRuntime.rewardPreviewOpenedPlayers[av.PlayerID] ~= true then
		return
	end
	local b7 = {}
	if av.actions ~= nil and av.actions ~= "" then
		local b8, b9 = pcall(function()
			return json.decode(av.actions)
		end)
		if b8 ~= true or b9 == nil then
			self:error(
				(
					(
						(self.logPrefix .. " receive rewards failed: invalid actions payload player=")
						.. tostring(av.PlayerID)
					) .. " raw="
				) .. av.actions
			)
			return
		end
		b7 = b9
	end
	local aG = { match_id = Match:GetMatchID(), actions = b7 }
	self.settlementRuntime.rewardReceivingPlayers[av.PlayerID] = true
	CommonService:CallAction("/v1/settle/receive_tower_rewards", av.PlayerID, aG, function(aH, aI, aJ)
		self.settlementRuntime.rewardReceivingPlayers[av.PlayerID] = false
		CommonService:CommonCallback(av.PlayerID, aJ)
		if aJ.code ~= 0 and aJ.code ~= 200 then
			return
		end
		self.settlementRuntime.rewardReceivedPlayers[av.PlayerID] = true
		self:ClearPlayerSettlementPreview(av.PlayerID)
		self:OpenReturnGates()
		self:ShowReturnGateIndicator(av.PlayerID)
		if not self:AreAllParticipantsRewardsReceived() then
			return
		end
		self:ClearSettlementChests()
	end, false)
end
function A.prototype.AreAllParticipantsRewardsReceived(self)
	do
		local J = 0
		while J < #self.participantPlayerIds do
			if self.settlementRuntime.rewardReceivedPlayers[self.participantPlayerIds[J + 1]] ~= true then
				return false
			end
			J = J + 1
		end
	end
	return true
end
function A.prototype.ClearPlayerSettlementPreview(self, aB)
	CommonService:SetPlayerServiceNetData(aB, "player_tower_rewards_preview", nil, true)
end
function A.prototype.UnregisterModuleEvents(self)
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
end
A = j({ m }, A)
if BattleGem == nil then
	BattleGem = f(A)
end
return k