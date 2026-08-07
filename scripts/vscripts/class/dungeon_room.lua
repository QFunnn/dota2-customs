--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "class/dungeon_room"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__New
local e = b.__TS__ArrayForEach
local f = b.__TS__Delete
local g = b.__TS__StringSplit
local h = b.__TS__ArraySort
local i = b.__TS__ArraySlice
local j = b.__TS__StringTrim
local k = b.__TS__ArrayMap
local l = b.__TS__ObjectAssign
local m = b.__TS__ArrayIncludes
local n = b.__TS__ArrayFilter
local o = b.__TS__StringEndsWith
local p = b.Set
local q = b.__TS__StringStartsWith
local r = b.__TS__ArrayFind
local s = b.__TS__ArrayFrom
local t = b.__TS__NumberToFixed
local u = {}
local v = require("class.client_item")
local w = v.ClientItem
local x = require("class.dungeon_trap")
local y = x.DungeonTrap
local z = require("class.drop_item")
local A = z.DropItem
local B = require("class.shop_item")
local C = B.ShopItem
local D = require("class.weight_pool")
local E = D.CWeightPool
local F = {
	[RoomType.BOSS] = "particles/generic_gameplay/rune/rune_boss.vpcf",
	[RoomType.SHOP] = "particles/generic_gameplay/rune/rune_store.vpcf",
	[RoomType.TAVERN] = "particles/generic_gameplay/rune/rune_tavern.vpcf",
	[RoomType.STAIR] = "particles/generic_gameplay/rune/rune_stair_exit.vpcf",
	[RoomType.INVALID] = "particles/generic_gameplay/rune/rune_stair_exit.vpcf",
}
local G = {
	WishingPool = "particles/generic_gameplay/rune/wishing_pool_exit.vpcf",
	RegenWell = "particles/generic_gameplay/rune/regen_well_exit.vpcf",
	Book = "particles/generic_gameplay/rune/book_exit.vpcf",
	Smithy = "particles/generic_gameplay/rune/smithy_exit.vpcf",
}
local H = "TravelingMerchant"
local I = 320
local J = {
	[RoomRewardType.BOON] = "particles/generic_gameplay/rune/rune_blessings.vpcf",
	[RoomRewardType.DOUBLE_BOON] = "particles/generic_gameplay/rune/rune_blessings.vpcf",
	[RoomRewardType.HERO_UPGRADE] = "particles/generic_gameplay/rune/rune_experience.vpcf",
	[RoomRewardType.POM] = "particles/generic_gameplay/rune/rune_property.vpcf",
	[RoomRewardType.GOLD] = "particles/generic_gameplay/rune/rune_bounty_first.vpcf",
	[RoomRewardType.TREASURE] = "particles/generic_gameplay/rune/rune_treasure.vpcf",
}
u.DungeonRoom = c()
local K = u.DungeonRoom
K.name = "DungeonRoom"
function K.prototype.____constructor(self, L, M, N, O, P, Q, R, S, T, U, V, W)
	self.validGridPositions = {}
	self.occupiedPositions = {}
	self.breakables = {}
	self.items = {}
	self.shopItems = {}
	self.dropItems = {}
	self.clientItems = {}
	self.previewRewardDrops = {}
	self.npcs = {}
	self.enemies = {}
	self.simulateEnemies = {}
	self.aliveEnemyCount = 0
	self.playerKilledEnemyCount = 0
	self.hasReportedUnitManagerGuard = false
	self.currentWave = 0
	self.gatesOpened = false
	self.isSpawnComplete = false
	self.isPrepare = false
	self.isActived = false
	self.isComplete = false
	self.isCombatEnd = false
	self.isDispose = false
	self.previewRewardSlots = {}
	self.enemyPreviewRewards = {}
	self.previewRewardAssignedEnemyCount = 0
	self.itemNameByItemID = {}
	self.droppedPreviewRewards = {}
	self.stairChestPlayers = {}
	self.stairChestCompletedPlayers = {}
	self.stairChestAutoClaimingPlayers = {}
	self.stairChestOpeningPlayers = {}
	self.stairChestIgnoredPlayers = {}
	self.entrancePrefix = ""
	self.exitInfos = {}
	self.registeredInteracts = {}
	self.travelingMerchantForward = vec3_bottom
	self.travelingMerchantAngles = "0 -90 0"
	self.difficultyHealthAmplify = 0
	self.difficultyDamageAmplify = 0
	self.difficultyCooldownReduction = 0
	self.difficultyBossGapAmplify = 0
	self.wishingPoolCount = 1
	self.shopRefreshCount = 0
	self.isSecretRoomCreated = false
	self.zoneID = L
	self.terrainThemeKey = S
	self.roomID = M
	self.mapName = N
	self.rewardType = P
	self.roomType = O
	self.position = Q
	self.bossName = T
	self.shopRarityPoolName = V or ""
	self.specialKind = W
	self.spawnInfo = self:CreateSpawnInfo(R, S)
	self.guaranteedDrops = {}
	self:CalculateDifficultyModifiers()
	if U ~= nil then
		local X = d(E)
		if U.ItemList ~= nil then
			for Y, Z in pairs(U.ItemList) do
				X:Add(tostring(Y), toFiniteNumber(Z))
			end
		end
		self.dropPool = { dropChance = toFiniteNumber(U.DropChance), itemPool = X }
	end
	self.spawnGroup = DOTA_SpawnMapAtPosition(N, Q, true, function(_)
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "-") .. R) .. "] onReadyToSpawn")
		ManuallyTriggerSpawnGroupCompletion(_)
	end, function()
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "-") .. R) .. "] onSpawnComplete")
		self.isSpawnComplete = true
	end, nil)
	self.dungeonTrap = d(y, {
		getRoomID = function()
			return self.roomID
		end,
		getSpawnGroup = function()
			return self.spawnGroup
		end,
		getPosition = function()
			return self:GetPosition()
		end,
		getTerrainThemeKey = function()
			return self.terrainThemeKey
		end,
		isDisposed = function()
			return self.isDispose
		end,
		isCombatEnd = function()
			return self.isCombatEnd
		end,
		isCombatRoom = function()
			return self:IsCombatRoom()
		end,
		isBossRoom = function()
			return self:IsBossRoom()
		end,
		getRandomValidGridPosition = function()
			return self:GetRandomValidGridPosition()
		end,
		removeUnit = function(a0, a1)
			return self:RemoveUnit(a1)
		end,
	})
end
function K.prototype.RollShopRarity(self)
	if self.shopRarityPoolName == nil or self.shopRarityPoolName == "" then
		return 1
	end
	local a2 = DrawPool:Draw(self.shopRarityPoolName)
	if a2 == nil then
		return 1
	end
	local a3 = 0
	Game:EachPlayer(function(a0, a4)
		a3 = a3 + GetShopItemRarity(a4) + GetArtifactItemRarity(a4)
	end)
	local a5 = math.floor(a3 / 100)
	if math.random(1, 100) <= a3 % 100 then
		a5 = a5 + 1
	end
	local a6 = toFiniteNumber(a2, 1) + a5
	if a6 < 1 then
		return 1
	end
	if a6 > 5 then
		return 5
	end
	return a6
end
function K.prototype.dispose(self)
	if self.isDispose then
		return
	end
	self.isDispose = true
	self.previewRewardSlots = {}
	self.enemyPreviewRewards = {}
	self.previewRewardAssignedEnemyCount = 0
	self.previewRewardDrops = {}
	self.droppedPreviewRewards = {}
	self:StopStairChestStateWatcher()
	self:StopUnitManagerGuardTimer()
	self.stairChestPlayers = {}
	self.stairChestCompletedPlayers = {}
	self.stairChestAutoClaimingPlayers = {}
	self.stairChestOpeningPlayers = {}
	self.stairChestIgnoredPlayers = {}
	self.stairChestItemPos = nil
	self.aliveEnemyCount = 0
	e(self.breakables, function(a0, a7)
		self:RemoveUnit(a7)
	end)
	e(self.npcs, function(a0, a7)
		self:RemoveUnit(a7)
	end)
	e(self.enemies, function(a0, a7)
		self:RemoveUnit(a7)
	end)
	e(self.simulateEnemies, function(a0, a7)
		a7:dispose()
	end)
	e(self.items, function(a0, a7)
		if IsValid(a7) then
			local a8 = a7:GetContainedItem()
			if IsValid(a8) then
				UTIL_Remove(a8)
			end
			UTIL_Remove(a7)
		end
	end)
	e(self.dropItems, function(a0, a7)
		a7:dispose()
	end)
	e(self.clientItems, function(a0, a7)
		a7:dispose()
	end)
	e(self.shopItems, function(a0, a7)
		a7:dispose()
	end)
	for a0, a9 in ipairs(self.exitInfos) do
		if a9.rewardParticleID ~= nil then
			ParticleManager:DestroyParticle(a9.rewardParticleID, true)
			ParticleManager:ReleaseParticleIndex(a9.rewardParticleID)
		end
		if a9.eliteParticleID ~= nil then
			ParticleManager:DestroyParticle(a9.eliteParticleID, true)
			ParticleManager:ReleaseParticleIndex(a9.eliteParticleID)
		end
	end
	self.exitInfos = {}
	self:ClearFirstRoomRewardGuide()
	if self.timerID ~= nil then
		Timer:StopTimer(self.timerID)
		self.timerID = nil
	end
	if self.eventListenerID ~= nil then
		StopGameEvent(self.eventListenerID)
		self.eventListenerID = nil
	end
	self.dungeonTrap:Dispose()
	if IsValid(self.travelingMerchantPlaceholder) then
		self.travelingMerchantPlaceholder:RemoveSelf()
		self.travelingMerchantPlaceholder = nil
	end
	do
		local aa = 0
		while aa < #self.registeredInteracts do
			Interaction:UnregisterInteractable(self.registeredInteracts[aa + 1])
			aa = aa + 1
		end
	end
	self.registeredInteracts = {}
	self.breakables = {}
	self.npcs = {}
	self.enemies = {}
	self.simulateEnemies = {}
	self.items = {}
	self.dropItems = {}
	self.clientItems = {}
	if self.secretRoomSpawnGroup ~= nil then
		UnloadSpawnGroupByHandle(self.secretRoomSpawnGroup)
		self.secretRoomSpawnGroup = nil
	end
	if self.secretRoomGate ~= nil and IsValid(self.secretRoomGate) then
		self:RemoveUnit(self.secretRoomGate)
		self.secretRoomGate = nil
	end
	self.secretRoomPrefix = nil
	self.secretRoomDoorPosition = nil
	self.secretRoomDoorDirection = nil
	self.isSecretRoomCreated = false
	UnloadSpawnGroupByHandle(self.spawnGroup)
end
function K.prototype.SetRewardType(self, P)
	self.rewardType = P
end
function K.prototype.SetSpecialKind(self, W)
	self.specialKind = W
end
function K.prototype.Prepare(self)
	if self.isPrepare then
		return
	end
	print(
		(
			(
				(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] Prepare: type=")
								.. RoomType[self.roomType]
							) .. " reward="
						) .. RoomRewardType[self.rewardType]
					) .. " special="
				) .. (self.specialKind or "-")
			) .. " map="
		) .. self.mapName
	)
	if self:IsCombatRoom() then
		self:InitializePreviewRoomRewards()
	end
	self:AnalyzeGrid()
	self:CreateEntrance()
	self:CreateExit()
	self:ResolveTravelingMerchantSpawnData()
	self:CreateTravelingMerchantPlaceholder()
	self.dungeonTrap:Prepare()
	self:CreateBreakable()
	if self.roomType == RoomType.SHOP then
		self:CreateShopItem(false)
	end
	if self.roomType == RoomType.TAVERN then
		self:CreateTavernItems()
	end
	if self.roomType == RoomType.STAIR then
		self:CreateStairItem()
	end
	if self.roomType == RoomType.SPECIAL then
		self:CreateSpecialRoom()
	end
	if self.specialKind == H and self.roomType == RoomType.STAIR then
		if self.zoneID < 3 then
			self:CreateInteractiveTravelingMerchant()
		end
	end
	if self:IsCombatRoom() and not self:IsBossRoom() then
		if self.spawnInfo.isDeploy then
			self:CreateWaveEnemy()
		end
	end
	self.isPrepare = true
	self.eventListenerID = GameEvent("entity_killed", function(self, ...)
		return self:OnEntityKilled(...)
	end, self)
end
function K.prototype.InitializePreviewRoomRewards(self)
	self.previewRewardSlots = {}
	self.enemyPreviewRewards = {}
	self.previewRewardAssignedEnemyCount = 0
	local ab = self:IsBossRoom() and 1 or math.max(1, self.spawnInfo.totalCount)
	do
		local aa = 0
		while aa < ab do
			local ac = self.previewRewardSlots
			ac[#ac + 1] = {}
			aa = aa + 1
		end
	end
	local ad = 0
	Game:EachPlayer(function(a0, ae)
		local af = CommonService:GetPlayerServiceNetTable(ae, "player_room_rewards_preview")
		local ag = af and af[self.roomID]
		if ag == nil then
			return
		end
		if toFiniteNumber(ag.receive_times, 0) > 0 then
			return
		end
		local ah = ag.rewards
		if ah == nil or #ah <= 0 then
			return
		end
		do
			local aa = 0
			while aa < #ah do
				do
					local ai = ah[aa + 1]
					local aj = toFiniteNumber(ai.item_id, 0)
					local ak = toFiniteNumber(ai.amounts, 0)
					if aj <= 0 or ak <= 0 then
						goto al
					end
					local Y = self:ResolvePreviewRewardItemName(aj)
					if Y == nil then
						print(
							((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励 item_id=") .. tostring(aj))
								.. " 未找到对应 itemName，已跳过"
						)
						goto al
					end
					local am = RandomInt(0, ab - 1)
					local an = self.previewRewardSlots[am + 1]
					an[#an + 1] = { playerID = ae, itemID = aj, amounts = ak, itemName = Y }
					ad = ad + 1
				end
				::al::
				aa = aa + 1
			end
		end
	end)
	if ad > 0 then
		print(
			(
				((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励已预分配到 ") .. tostring(ab))
				.. " 个怪物槽位，奖励条目数="
			) .. tostring(ad)
		)
	end
end
function K.prototype.ResolvePreviewRewardItemName(self, aj)
	if aj <= 0 then
		return nil
	end
	local ao = self.itemNameByItemID[aj]
	if ao ~= nil then
		return ao
	end
	for Y, ap in pairs(KeyValues.items) do
		local aq = toFiniteNumber
		local ar = ap.ItemID
		if ar == nil then
			ar = ap.item_id
		end
		local as = ar
		if as == nil then
			as = ap.id
		end
		local at = as
		if at == nil then
			at = ap.ID
		end
		local au = at
		if au == nil then
			au = ap.ServiceItemID
		end
		local av = aq(au, -1)
		if av == aj then
			self.itemNameByItemID[aj] = Y
			return Y
		end
	end
	if KeyValues.items.item_health_potion_1 ~= nil then
		self.itemNameByItemID[aj] = "item_health_potion_1"
		print(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励 item_id=") .. tostring(aj))
				.. " 未找到精确映射，使用调试占位物 item_health_potion_1"
		)
		return "item_health_potion_1"
	end
	return nil
end
function K.prototype.AssignPreviewRewardsToEnemy(self, aw)
	local ax = self.previewRewardSlots[self.previewRewardAssignedEnemyCount + 1] or {}
	if #ax > 0 then
		local ay = aw:GetEntityIndex()
		self.enemyPreviewRewards[ay] = {}
		do
			local aa = 0
			while aa < #ax do
				local az = self.enemyPreviewRewards[ay]
				az[#az + 1] = ax[aa + 1]
				aa = aa + 1
			end
		end
		print(
			(
				(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 怪物 ") .. aw:GetUnitName()) .. " 分配到 ")
				.. tostring(#ax)
			) .. " 条预览奖励"
		)
	end
	self.previewRewardAssignedEnemyCount = self.previewRewardAssignedEnemyCount + 1
end
function K.prototype.DropPreviewRewardsFromEnemy(self, a1)
	local ay = a1:GetEntityIndex()
	local ah = self.enemyPreviewRewards[ay]
	if ah == nil or #ah <= 0 then
		return
	end
	f(self.enemyPreviewRewards, ay)
	local aA = GetGroundPosition(a1:GetAbsOrigin(), a1)
	Interaction:BeginSyncBatch()
	do
		local aa = 0
		while aa < #ah do
			do
				local ai = ah[aa + 1]
				if KeyValues.items[ai.itemName] == nil then
					goto aB
				end
				self:AddDroppedPreviewReward(ai.playerID, ai.itemID, ai.amounts)
				local aC = d(w, ai.playerID, ai.itemID, aA)
				local aD = self.clientItems
				aD[#aD + 1] = aC
				local aE = { clientItem = aC, reward = ai }
				local aF = self.previewRewardDrops
				aF[#aF + 1] = aE
				local aG = Interaction:RegisterInteract(aC.entity, InteractType.Consumables, 200, function(a0, aH, ae)
					return self:PickupPreviewRewardDrop(aH, aE, ae)
				end, 1, ai.playerID)
				if aG ~= -1 then
					aE.interactIndex = aG
					local aI = self.registeredInteracts
					aI[#aI + 1] = aG
				end
				Match:AddPlayerRoundRewards(
					ai.playerID,
					{ { item_id = ai.itemID, amounts = ai.amounts, item_rarity = GetPropRarity(ai.itemID) } }
				)
			end
			::aB::
			aa = aa + 1
		end
	end
	Interaction:EndSyncBatch()
end
function K.prototype.PickupPreviewRewardDrop(self, aH, aE, ae)
	if not IsValid(aH) or not aH:IsRealHero() or not aH:IsAlive() then
		return false
	end
	local aC = aE.clientItem
	if aC.isDispose or not aC:IsLanded() or not IsValid(aC.entity) then
		return false
	end
	local aJ = ae or aH:GetPlayerOwnerID()
	if aJ ~= aE.reward.playerID then
		return false
	end
	local aK = aC:GetLandedPosition()
	print(
		(
			(
				(
					(
						(
							(
								(
									(
										(("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励拾取 player=")
										.. tostring(aJ)
									) .. " owner="
								) .. tostring(aE.reward.playerID)
							) .. " item_id="
						) .. tostring(aE.reward.itemID)
					) .. " item_name="
				) .. aE.reward.itemName
			) .. " amounts="
		) .. tostring(aE.reward.amounts)
	)
	CommonService:SendReceiveRewards(aJ, { { item_id = aE.reward.itemID, amounts = aE.reward.amounts } })
	Event:Fire("client_item_pickup", { playerID = aJ, item_id = aE.reward.itemID })
	self:CreateClientItemPickupParticle(aK, aH)
	if aE.interactIndex ~= nil then
		Interaction:UnregisterInteractable(aE.interactIndex)
		ArrayRemove(self.registeredInteracts, aE.interactIndex)
		aE.interactIndex = nil
	end
	ArrayRemove(self.previewRewardDrops, aE)
	ArrayRemove(self.clientItems, aC)
	aC:dispose()
	return true
end
function K.prototype.TryAutoPickupPreviewReward(self, aH)
	if not IsValid(aH) or not aH:IsRealHero() or not aH:IsAlive() then
		return false
	end
	local aJ = aH:GetPlayerOwnerID()
	local aL = aH:GetAbsOrigin()
	local aM
	local aN = 200
	do
		local aa = 0
		while aa < #self.previewRewardDrops do
			do
				local aE = self.previewRewardDrops[aa + 1]
				if aE == nil then
					goto aO
				end
				local aC = aE.clientItem
				if aE.reward.playerID ~= aJ or aC.isDispose or not aC:IsLanded() or not IsValid(aC.entity) then
					goto aO
				end
				local aP = aC.entity:GetAbsOrigin()
				local aQ = (aL - aP):Length2D()
				if aQ <= aN then
					aN = aQ
					aM = aE
				end
			end
			::aO::
			aa = aa + 1
		end
	end
	if aM == nil then
		return false
	end
	return self:PickupPreviewRewardDrop(aH, aM, aJ)
end
function K.prototype.CanAutoPickupDropItem(self, aR, aS)
	local aT = aS
	if not aT then
		local aU = KeyValues.items[aR.itemName]
		if aU ~= nil then
			aU = aU.AutoPickUp
		end
		aT = aU == 1
	end
	return aT
end
function K.prototype.RegisterDropItemForAutoPickup(self, aR, aV)
	local aW = self.dropItems
	aW[#aW + 1] = aR
	if aV ~= -1 then
		local aX = self.registeredInteracts
		aX[#aX + 1] = aV
	end
end
function K.prototype.UnregisterDropItemForAutoPickup(self, aR, aV)
	ArrayRemove(self.dropItems, aR)
	if aV ~= -1 then
		ArrayRemove(self.registeredInteracts, aV)
	end
end
function K.prototype.TryAutoPickupDropItem(self, aH, aS)
	if aS == nil then
		aS = false
	end
	if not IsValid(aH) or not aH:IsRealHero() or not aH:IsAlive() then
		return false
	end
	local aJ = aH:GetPlayerOwnerID()
	local aL = aH:GetAbsOrigin()
	local aY
	local aZ
	local aN = 200
	do
		local aa = 0
		while aa < #self.dropItems do
			do
				local aR = self.dropItems[aa + 1]
				if
					aR == nil
					or aR.isDispose
					or not aR:IsLanded()
					or not IsValid(aR.entity)
					or not self:CanAutoPickupDropItem(aR, aS)
				then
					goto a_
				end
				if aR.playerID ~= nil and aR.playerID ~= aJ then
					goto a_
				end
				local ay = aR:GetEntityIndex()
				if ay == -1 then
					goto a_
				end
				local aP = aR.entity:GetAbsOrigin()
				local aQ = (aL - aP):Length2D()
				if aQ <= aN then
					aN = aQ
					aY = aR
					aZ = ay
				end
			end
			::a_::
			aa = aa + 1
		end
	end
	if aY == nil or aZ == nil then
		return false
	end
	local aK = aY.entity:GetAbsOrigin()
	local b0 = Interaction:ExecutePrimaryCallback(aZ, aH, aJ)
	if not b0 then
		return false
	end
	self:CreateClientItemPickupParticle(aK, aH)
	Interaction:UnregisterInteractable(aZ)
	ArrayRemove(self.registeredInteracts, aZ)
	ArrayRemove(self.dropItems, aY)
	return true
end
function K.prototype.AddDroppedPreviewReward(self, ae, aj, ak)
	if ak <= 0 then
		return
	end
	local b1 = tostring(ae)
	local b2 = tostring(aj)
	local b3, b4 = self.droppedPreviewRewards, b1
	if b3[b4] == nil then
		b3[b4] = {}
	end
	self.droppedPreviewRewards[b1][b2] = (self.droppedPreviewRewards[b1][b2] or 0) + ak
end
function K.prototype.GetDroppedPreviewRewards(self, ae)
	local b5 = self.droppedPreviewRewards[tostring(ae)]
	if b5 == nil then
		return {}
	end
	local b6 = {}
	for aj, ak in pairs(b5) do
		b6[tostring(aj)] = toFiniteNumber(ak, 0)
	end
	return b6
end
function K.prototype.Activate(self)
	if self.isDispose then
		return
	end
	if self.isActived then
		return
	end
	if not self.isPrepare then
		self:Prepare()
	end
	self.isActived = true
	print(
		(
			(
				(
					((("[DungeonRoom " .. tostring(self.roomID)) .. "] Activate: type=") .. RoomType[self.roomType])
					.. " reward="
				) .. RoomRewardType[self.rewardType]
			) .. " special="
		) .. (self.specialKind or "-")
	)
	if self.roomType == RoomType.STAIR and not DungeonManager:IsTutorial() then
		local b7 = DungeonManager:GetRoomIndex() + 1
		Game:EachPlayer(function(a0, ae)
			Service:ReportClick(ae, "dungeon", "reward_room|enter|room_" .. tostring(b7))
		end)
	end
	self.currentWave = 0
	Event:Fire("dungeon_room_start", { room = self })
	self.dungeonTrap:Activate()
	if self:IsCombatRoom() then
		self:LockGate()
		self:StartUnitManagerGuardTimer()
		if self:IsBossRoom() then
			self:CreateBoss()
		else
			if self.spawnInfo.isDeploy then
				for aa, a1 in ipairs(self.enemies) do
					a1:RemoveModifierByName("modifier_sleep")
				end
			end
			self.timerID = Timer:GameTimer(self.spawnInfo.isDeploy and self.spawnInfo.spawnInterval or 0, function()
				self:CreateWaveEnemy()
				if self.spawnInfo.totalCount > 0 then
					return self.spawnInfo.spawnInterval
				end
			end)
		end
	else
		if DungeonManager:IsTutorial() then
			self:LockGate()
			return
		end
		if self.roomType == RoomType.STAIR then
			self:StartStairChestStateWatcher()
			self:RefreshStairChestPlayerStates()
		else
			self:OpenGates()
		end
	end
end
function K.prototype.Complete(self, b8)
	if self.isComplete then
		return
	end
	self.isComplete = true
	self:StopStairChestStateWatcher()
	self.dungeonTrap:Complete()
	self:StopUnitManagerGuardTimer()
	if self.timerID ~= nil then
		Timer:StopTimer(self.timerID)
		self.timerID = nil
	end
	if self.eventListenerID ~= nil then
		StopGameEvent(self.eventListenerID)
		self.eventListenerID = nil
	end
	e(self.items, function(a0, a7)
		if IsValid(a7) then
			local a8 = a7:GetContainedItem()
			if IsValid(a8) then
				UTIL_Remove(a8)
			end
			UTIL_Remove(a7)
		end
	end)
	e(self.dropItems, function(a0, a7)
		a7:dispose()
	end)
	e(self.clientItems, function(a0, a7)
		a7:dispose()
	end)
	e(self.shopItems, function(a0, a7)
		print(a7.itemName, "dispose")
		a7:dispose()
	end)
	self.items = {}
	self.dropItems = {}
	self.clientItems = {}
	self.shopItems = {}
	do
		local aa = 0
		while aa < #self.registeredInteracts do
			Interaction:UnregisterInteractable(self.registeredInteracts[aa + 1])
			aa = aa + 1
		end
	end
	self.registeredInteracts = {}
	for a0, a9 in ipairs(self.exitInfos) do
		if a9.rewardParticleID ~= nil then
			ParticleManager:DestroyParticle(a9.rewardParticleID, true)
			ParticleManager:ReleaseParticleIndex(a9.rewardParticleID)
		end
		if a9.eliteParticleID ~= nil then
			ParticleManager:DestroyParticle(a9.eliteParticleID, true)
			ParticleManager:ReleaseParticleIndex(a9.eliteParticleID)
		end
	end
	local b9 = self.exitInfos[b8 + 1]
	if b9 ~= nil then
		print(
			(
				(
					(
						((("[DungeonRoom " .. tostring(self.roomID)) .. "] 玩家选择出口 ") .. tostring(b8))
						.. "，进入下个房间，房间奖励: "
					) .. tostring(b9.rewardType)
				) .. " special="
			) .. (b9.specialKind or "")
		)
		DungeonManager:SetSelectedNextRoomRoute(b9.rewardType, b9.specialKind)
	end
	Event:Fire("dungeon_room_complete", { room = self })
end
function K.prototype.LockGate(self)
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	for a0, bb in ipairs(ba) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if bd == self.entrancePrefix then
			bb:FireOutput("OnUser1", nil, nil, nil, 0)
		end
	end
end
function K.prototype.OpenGates(self)
	if self.gatesOpened then
		return
	end
	self.gatesOpened = true
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	print(
		(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] OpenGates - 找到 ") .. tostring(#ba))
			.. " 个门，出口数量: "
		) .. tostring(#self.exitInfos)
	)
	local be = {}
	for a0, bb in ipairs(ba) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if not be[bd] then
			be[bd] = {}
		end
		local bf = be[bd]
		bf[#bf + 1] = bb
	end
	do
		local aa = 0
		while aa < #self.exitInfos do
			do
				local a9 = self.exitInfos[aa + 1]
				if a9 == nil then
					goto bg
				end
				local b8 = aa
				local bh = self:GetExitTooltip(a9)
				local bi = be[a9.prefix]
				if bi == nil or #bi == 0 then
					print(
						((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 未找到前缀为 ") .. a9.prefix)
							.. " 的门"
					)
					goto bg
				end
				local bj = G[a9.specialKind or ""] or F[a9.roomType] or J[a9.rewardType]
				print(
					(
						(
							(
								(
									(((("[DungeonRoom " .. tostring(self.roomID)) .. "] ") .. tostring(b8)) .. " ")
									.. RoomType[a9.roomType]
								) .. " "
							) .. RoomRewardType[a9.rewardType]
						) .. " 创建粒子效果: "
					) .. tostring(bj)
				)
				if bj ~= nil and a9.rewardParticleID == nil then
					local bk = bi[1]:GetAbsOrigin()
					local bl = ParticleManager:CreateParticleForce(bj, PATTACH_CUSTOMORIGIN, nil)
					ParticleManager:SetParticleControl(bl, 0, bk)
					a9.rewardParticleID = bl
				end
				if a9.roomType == RoomType.ELITE and a9.eliteParticleID == nil then
					local bk = bi[1]:GetAbsOrigin()
					local bm = ParticleManager:CreateParticleForce(
						"particles/generic_gameplay/rune/rune_elite.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(bm, 0, bk)
					a9.eliteParticleID = bm
				end
				for a0, bb in ipairs(bi) do
					local bc = bb:GetName()
					bb:FireOutput("OnUser1", nil, nil, nil, 0)
					if self:IsFirstRoomRewardGuideEnabled() then
						self:ShowFirstRoomRewardGuide(bb:GetEntityIndex())
					end
					local aG = Interaction:RegisterInteract(bb, InteractType.Portal, 200, function(a0, aH)
						self:ClearFirstRoomRewardGuide()
						aH:AddNewModifier(
							aH,
							nil,
							"modifier_enter_gate",
							{ position = VectorToString(bb:GetAbsOrigin() + a9.direction * 600), duration = 1 }
						)
						DungeonManager:ShowLoadingScreen()
						if self:IsFirstRoomRewardGuideEnabled() then
							self:ShowFirstRoomRewardGuide(bb:GetEntityIndex())
						end
						aH:GameTimer(1, function()
							self:Complete(b8)
						end)
					end)
					Interaction:UpdateInteract(aG, { tooltip = bh })
					if aG ~= -1 then
						local bn = self.registeredInteracts
						bn[#bn + 1] = aG
					end
				end
			end
			::bg::
			aa = aa + 1
		end
	end
	Event:Fire("dungeon_room_open_gates", { room = self })
end
function K.prototype.CreateTreasure(self, Q)
	if self:IsBossRoom() then
		self:SpawnBossCoinStacks(Q)
		self:OpenGates()
		return
	end
	print("创建奖励:", self.roomID, RoomRewardType[self.rewardType])
	local Y
	repeat
		local bo = self.rewardType
		local bp = bo == RoomRewardType.POM
		if bp then
			Y = "item_tome_of_prop"
			break
		end
		bp = bp or bo == RoomRewardType.BOON
		if bp then
			Y = "item_boon_bless"
			break
		end
		bp = bp or bo == RoomRewardType.DOUBLE_BOON
		if bp then
			Y = "item_boon_bless_double"
			break
		end
		bp = bp or bo == RoomRewardType.HERO_UPGRADE
		if bp then
			Y = "item_hammer_weapon"
			break
		end
		bp = bp or bo == RoomRewardType.TREASURE
		if bp then
			Y = "item_treasure"
			break
		end
		bp = bp or bo == RoomRewardType.GOLD
		do
			Y = "item_gold_pouch"
			break
		end
	until true
	if Y == nil then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 警告：无法获取奖励物品")
		self:OpenGates()
		return
	end
	local aR = d(A, Y, Q)
	local bq = aR.particleIDs
	bq[#bq + 1] = ParticleManager:CreateParticleForce(
		"particles/generic_gameplay/rune/rube_drop_items_fx.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aR.entity
	)
	local br = self.dropItems
	br[#br + 1] = aR
	if self:IsFirstRoomRewardGuideEnabled() then
		self:ShowFirstRoomRewardGuide(aR.entity:GetEntityIndex())
	end
	local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 150, function(a0, aH, ae)
		if not aR:IsLanded() then
			return false
		end
		aH:AddItemByName(Y)
		if not DungeonManager:IsTutorial() then
			local b7 = DungeonManager:GetRoomIndex() + 1
			Service:ReportClick(ae, "dungeon", "room_reward|pickup|room_" .. tostring(b7))
		end
		if self.rewardType == RoomRewardType.BOON or self.rewardType == RoomRewardType.DOUBLE_BOON then
			local bs = self.rewardType == RoomRewardType.DOUBLE_BOON
			Game:EachPlayer(function(a0, bt)
				Event:Fire("bless_room_reward_claimed", { playerID = bt, isDouble = bs })
			end)
		end
		aR:dispose()
		self:ClearFirstRoomRewardGuide()
		self:OpenGates()
	end, nil, nil, Y)
	if aG ~= -1 then
		local bu = self.registeredInteracts
		bu[#bu + 1] = aG
	end
end
function K.prototype.IsFirstRoomRewardGuideEnabled(self)
	return GameRules:GetCustomGameDifficulty() <= 2 and self.roomID == 0
end
function K.prototype.ShowFirstRoomRewardGuide(self, bv)
	Game:EachPlayer(function(a0, ae)
		local aH = PlayerResource:GetSelectedHeroEntity(ae)
		if IsValid(aH) and aH:IsRealHero() then
			aH:AddNewModifier(aH, nil, "modifier_first_dungeon_guide", { targetEntIndex = bv })
		end
	end)
end
function K.prototype.ClearFirstRoomRewardGuide(self)
	if not self:IsFirstRoomRewardGuideEnabled() then
		return
	end
	Game:EachPlayer(function(a0, ae)
		local aH = PlayerResource:GetSelectedHeroEntity(ae)
		if IsValid(aH) then
			aH:RemoveAllModifiersOfName("modifier_first_dungeon_guide")
		end
	end)
end
function K.prototype.SpawnBossCoinStacks(self, bw)
	local bx = RandomInt(8, 15)
	local by = 480
	local bz = 10
	Interaction:BeginSyncBatch()
	do
		local aa = 0
		while aa < bx do
			local bA
			do
				local bB = 0
				while bB < bz do
					local bC = RandomFloat(0, 360)
					local aQ = RandomFloat(0, by)
					local bD = Vector(math.cos(bC * math.pi / 180) * aQ, math.sin(bC * math.pi / 180) * aQ, 0)
					local bE = bw:__add(bD)
					if GridNav:IsValidPosition(bE) then
						bA = bE
						break
					end
					bB = bB + 1
				end
			end
			if bA == nil then
				bA = self:GetNearestValidGridPosition(bw) or bw
			end
			local aR = d(A, "item_coin_stack", bA)
			local bF = self.dropItems
			bF[#bF + 1] = aR
			local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
				aH:AddItemByName("item_coin_stack")
				aR:dispose()
			end, nil, nil, "item_coin_stack")
			if aG ~= -1 then
				local bG = self.registeredInteracts
				bG[#bG + 1] = aG
			end
			aa = aa + 1
		end
	end
	Interaction:EndSyncBatch()
	print(((("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss房掉落 ") .. tostring(bx)) .. " 个金币堆")
end
function K.prototype.NormalizeGridPhaseFromCenter(self, bD)
	local bH = GRID_SIZE * 0.5
	local bI = math.abs(bD % GRID_SIZE)
	local bJ = math.min(bI, math.abs(GRID_SIZE - bI))
	local bK = math.abs(bI - bH)
	return bK < bJ and bH or 0
end
function K.prototype.ResolveGridAnalysisOrigin(self)
	local bi = self:FindEntities("prop_dynamic", "prop_gate")
	if #bi <= 0 then
		return self.position
	end
	local bL = 0
	local bM = 0
	local bN = 0
	local bH = GRID_SIZE * 0.5
	do
		local aa = 0
		while aa < #bi do
			local bb = bi[aa + 1]
			local bO = bb:GetAbsOrigin()
			local bP = bO.x - self.position.x
			local bQ = bO.y - self.position.y
			local bR = bO.x
			local bS = bO.y
			if math.abs(bP) > math.abs(bQ) then
				bR = bO.x - (bP > 0 and bH or -bH)
			else
				bS = bO.y - (bQ > 0 and bH or -bH)
			end
			if self:NormalizeGridPhaseFromCenter(bR - self.position.x) >= bH then
				bM = bM + 1
			end
			if self:NormalizeGridPhaseFromCenter(bS - self.position.y) >= bH then
				bN = bN + 1
			end
			bL = bL + 1
			aa = aa + 1
		end
	end
	local bT = bM * 2 > bL and bH or 0
	local bU = bN * 2 > bL and bH or 0
	return Vector(self.position.x + bT, self.position.y + bU, self.position.z)
end
function K.prototype.AnalyzeGrid(self)
	local bw = self:ResolveGridAnalysisOrigin()
	local bV = 5
	local bW = 20
	self.validGridPositions = {}
	local bX = bw.y - GRID_SIZE * 2
	do
		local bY = 0
		while bY <= bW do
			local bZ = false
			do
				local b_ = -bY
				while b_ <= bY do
					do
						local c0 = -bY
						while c0 <= bY do
							if math.abs(b_) == bY or math.abs(c0) == bY then
								local c1 = Vector(bw.x + b_ * GRID_SIZE, bw.y + c0 * GRID_SIZE, bw.z)
								if c1.y > bX and GridNav:IsValidPosition(c1) then
									bZ = true
									local c2 = self.validGridPositions
									c2[#c2 + 1] = c1
								else
								end
							end
							c0 = c0 + 1
						end
					end
					b_ = b_ + 1
				end
			end
			if not bZ and bY >= bV then
				break
			end
			bY = bY + 1
		end
	end
end
function K.prototype.CreateBreakable(self)
	if #self.validGridPositions == 0 then
		return
	end
	local c3 = RandomInt(0, 3)
	local c4 = math.floor(#self.validGridPositions / 20)
	local c5 = c3 + c4
	if c5 == 0 then
		return
	end
	local bw = self.position
	local c6 = h({ unpack(self.validGridPositions) }, function(a0, c7, c8)
		local c9 = c7:__sub(bw):Length2D()
		local ca = c8:__sub(bw):Length2D()
		return ca - c9
	end)
	local cb = i(c6, 0, math.ceil(#c6 * 0.7))
	local cc = {}
	do
		local aa = 0
		while aa < #cb do
			local cd = cb[aa + 1]
			if not self:IsTravelingMerchantNear(cd, GRID_SIZE * 1.5) then
				cc[#cc + 1] = cd
			end
			aa = aa + 1
		end
	end
	local ce = #cc > 0 and cc or cb
	do
		local aa = #ce - 1
		while aa > 0 do
			local cf = RandomInt(0, aa)
			local cg = { ce[cf + 1], ce[aa + 1] }
			ce[aa + 1] = cg[1]
			ce[cf + 1] = cg[2]
			aa = aa - 1
		end
	end
	local ch = math.max(1, math.floor(#ce / (c5 + 1)))
	do
		local aa = 0
		while aa < c5 do
			local ci = RandomInt(2, 4)
			local cj = aa * ch
			if cj >= #ce then
				break
			end
			local ck = ce[cj + 1]
			do
				local cf = 0
				while cf < ci do
					local bC = RandomFloat(0, 360)
					local aQ = RandomFloat(50, 150)
					local bD = Vector(math.cos(bC * math.pi / 180) * aQ, math.sin(bC * math.pi / 180) * aQ, 0)
					local cl = ck:__add(bD)
					CreateUnitByNameAsync(
						DrawPool:Draw(self.terrainThemeKey ~= "ice" and "breakable" or "breakable_ice")
							or "npc_dungeon_crate_1",
						cl,
						true,
						nil,
						nil,
						DOTA_TEAM_BADGUYS,
						function(cm)
							if self.isDispose then
								cm:SafeRemoveUnit()
							else
								cm:SetForwardVector(RandomVector(1))
								cm:SetModelScale(RandomFloat(0.8, 1))
								local cn = self.breakables
								cn[#cn + 1] = cm
								self.occupiedPositions[cj] = true
							end
						end
					)
					cf = cf + 1
				end
			end
			aa = aa + 1
		end
	end
end
function K.prototype.CreateSpawnInfo(self, co, S)
	if co == "" or co == nil then
		return {
			totalCount = 0,
			countPerRound = { 0, 0 },
			isDeploy = false,
			eliteChance = 0,
			spawnInterval = 0,
			captainName = "",
			bossName = "",
			healthFactor = 1,
			damageFactor = 1,
			enemyPool = d(E),
		}
	end
	local cp = KeyValues.spawn_info
	local cq = KeyValues["spawn_info_" .. S]
	local cr
	if cq ~= nil then
		cr = cq[co]
	else
		cr = nil
	end
	local cs = cr
	local ct
	if cp ~= nil then
		ct = cp[co]
	else
		ct = nil
	end
	local cu = ct
	if cs == nil and cu == nil then
		print(((("[DungeonRoom] 警告：刷怪配置 '" .. co) .. "' 在默认和主题'") .. S) .. "'中均未找到")
		return {
			totalCount = 0,
			countPerRound = { 0, 0 },
			isDeploy = false,
			eliteChance = 0,
			spawnInterval = 0,
			captainName = "",
			bossName = "",
			healthFactor = 1,
			damageFactor = 1,
			enemyPool = d(E),
		}
	end
	local function cv(a0, cw)
		if cs ~= nil and cs[cw] ~= nil then
			return cs[cw]
		end
		if cu ~= nil and cu[cw] ~= nil then
			return cu[cw]
		end
		return nil
	end
	local cx = k(g(j(tostring(cv(nil, "EnemyCount"))), "|"), function(a0, a7)
		return toFiniteNumber(a7, 0)
	end)
	local cy = k(g(j(tostring(cv(nil, "CountPerRound"))), "|"), function(a0, a7)
		return toFiniteNumber(a7, 0)
	end)
	if cy[2] == nil then
		cy[2] = cy[1]
	end
	local cz = RollPercentage(toFiniteNumber(cv(nil, "CaptainRoomChance")))
	local cA = RollPercentage(toFiniteNumber(cv(nil, "EliteRoomChance")))
	local cB = cA and toFiniteNumber(cv(nil, "OverrideEliteChance")) or toFiniteNumber(cv(nil, "EliteChance"))
	local cC = cv(nil, "EnemyList")
	local cD = d(E)
	if cC ~= nil then
		for cE, a7 in pairs(cC) do
			cD:Set(cE, toFiniteNumber(a7, 0))
		end
	end
	local cF = RandomInt(cx[1], cx[2])
	local cG = RollPercentage(toFiniteNumber(cv(nil, "DeployChance")))
	local cH = toFiniteNumber(cv(nil, "SpawnInterval"))
	local cI
	if cz then
		cI = cv(nil, "CaptainName")
	else
		cI = ""
	end
	return {
		totalCount = cF,
		countPerRound = cy,
		isDeploy = cG,
		eliteChance = cB,
		spawnInterval = cH,
		captainName = cI,
		bossName = cv(nil, "BossName"),
		healthFactor = toFiniteNumber(cv(nil, "HealthFactor"), 1),
		damageFactor = toFiniteNumber(cv(nil, "DamageFactor"), 1),
		enemyPool = cD,
	}
end
function K.prototype.CreateEnemyForTutorial(self, cJ, cK, cL, cM)
	local cN = {}
	local cO = self:GetGridsAroundPosition(cL, 300)
	if #cO < cK then
		cO = self:GetGridsAroundPosition(cL, 600)
	end
	if #cO < cK then
		cO = self:GetGridsAroundPosition(cL, 1200)
	end
	if #cO == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 没有可用生成位置")
		return {}
	end
	do
		local aa = #cO - 1
		while aa > 0 do
			local cf = RandomInt(0, aa)
			local cP = { cO[cf + 1], cO[aa + 1] }
			cO[aa + 1] = cP[1]
			cO[cf + 1] = cP[2]
			aa = aa - 1
		end
	end
	do
		local aa = 0
		while aa < cK and aa < #cO do
			local cl = cO[aa + 1]
			if cJ ~= nil and KeyValues.units[cJ] ~= nil then
				if SimulateUnitManager:IsSimulateUnit(cJ) then
					local aw = SimulateUnitManager:CreateCustomUnit(cJ, cl, DOTA_TEAM_BADGUYS)
					aw:SetForwardVector(RandomVector(1))
					local cQ = self.simulateEnemies
					cQ[#cQ + 1] = aw
					self:AssignPreviewRewardsToEnemy(aw)
				else
					local aw = CreateUnitByName(cJ, cl, true, nil, nil, DOTA_TEAM_BADGUYS)
					self:ApplyDifficultyModifiers(aw)
					cN[#cN + 1] = aw
					if cM then
						aw:AddNewModifier(aw, nil, "modifier_elite", {})
					end
				end
			else
				print(
					((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️警告：单位 '") .. cJ)
						.. "' 无法创建（可能未在KV中定义）"
				)
			end
			aa = aa + 1
		end
	end
	return cN
end
function K.prototype.CreateWaveEnemy(self)
	local cR =
		math.min(self.spawnInfo.totalCount, RandomInt(self.spawnInfo.countPerRound[1], self.spawnInfo.countPerRound[2]))
	if cR <= 0 then
		print(
			(
				(
					(("[DungeonRoom " .. tostring(self.roomID)) .. "] 本波刷怪数量为0，剩余待刷=")
					.. tostring(self.spawnInfo.totalCount)
				) .. "，存活="
			) .. tostring(self.aliveEnemyCount)
		)
		if self.spawnInfo.totalCount > 0 then
			print(
				("[DungeonRoom " .. tostring(self.roomID))
					.. "] ⚠️ CountPerRound配置异常，清空剩余待刷数量以避免卡关"
			)
			self.spawnInfo.totalCount = 0
		end
		self:TryFinishCombatWhenNoEnemies(self.position)
		return
	end
	self.occupiedPositions = {}
	local bw = self.position
	local cO
	if self.currentWave == 0 then
		cO = self:GetAvailablePositionIndices(bw.y - 400, bw.y)
		if #cO < cR then
			cO = self:GetAvailablePositionIndices()
		end
	else
		cO = self:GetAvailablePositionIndices(bw.y, bw.y + 600)
		if #cO < cR then
			cO = self:GetAvailablePositionIndices()
		end
	end
	if #cO == 0 then
		print(
			(
				(
					(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 没有可用生成位置，跳过本波 ")
					.. tostring(cR)
				) .. " 只怪，剩余待刷="
			) .. tostring(self.spawnInfo.totalCount)
		)
		local cS, cT = self.spawnInfo, "totalCount"
		cS[cT] = cS[cT] - cR
		self.spawnInfo.totalCount = math.max(0, self.spawnInfo.totalCount)
		self:TryFinishCombatWhenNoEnemies(self.position)
		return
	end
	local cU = math.min(cR, #cO)
	local cV, cW = self.spawnInfo, "totalCount"
	cV[cW] = cV[cW] - cU
	if cU < cR then
		print(
			(
				(
					(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 可用生成位置不足，计划=")
					.. tostring(cR)
				) .. "，实际尝试="
			) .. tostring(cU)
		)
	end
	self.currentWave = self.currentWave + 1
	do
		local aa = #cO - 1
		while aa > 0 do
			local cf = RandomInt(0, aa)
			local cX = { cO[cf + 1], cO[aa + 1] }
			cO[aa + 1] = cX[1]
			cO[cf + 1] = cX[2]
			aa = aa - 1
		end
	end
	local cY = 0
	do
		local aa = 0
		while aa < cU and aa < #cO do
			local cZ = cO[aa + 1]
			local cl = self.validGridPositions[cZ + 1]
			local cJ = self.spawnInfo.enemyPool:Random()
			if cJ ~= nil and KeyValues.units[cJ] ~= nil then
				local cB = self.spawnInfo.eliteChance
				local cM = RollPercentage(cB)
				self.aliveEnemyCount = self.aliveEnemyCount + 1
				cY = cY + 1
				if SimulateUnitManager:IsSimulateUnit(cJ) then
					local aw = SimulateUnitManager:CreateCustomUnit(cJ, cl, DOTA_TEAM_BADGUYS)
					aw:SetForwardVector(RandomVector(1))
					local c_ = self.simulateEnemies
					c_[#c_ + 1] = aw
					self:AssignPreviewRewardsToEnemy(aw)
				else
					CreateUnitByNameAsync(cJ, cl, true, nil, nil, DOTA_TEAM_BADGUYS, function(aw)
						if not IsValid(aw) then
							print(
								((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 单位创建失败: ") .. cJ)
									.. "，回退计数器"
							)
							self.aliveEnemyCount = self.aliveEnemyCount - 1
							self.aliveEnemyCount = math.max(0, self.aliveEnemyCount)
							return
						end
						if self.isDispose then
							aw:SafeRemoveUnit()
						else
							FindClearSpaceForUnit(aw, cl, true)
							aw:SetForwardVector(RandomVector(1))
							local d0 = self.enemies
							d0[#d0 + 1] = aw
							self:AssignPreviewRewardsToEnemy(aw)
							if not self.isActived then
								aw:AddNewModifier(aw, nil, "modifier_sleep", {})
							end
							self:ApplyDifficultyModifiers(aw)
							if cM then
								aw:AddNewModifier(aw, nil, "modifier_elite", {})
							end
						end
					end)
				end
				self.occupiedPositions[cZ] = true
			else
				print(
					((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️警告：单位 '") .. tostring(cJ))
						.. "' 无法创建（可能未在KV中定义）"
				)
			end
			aa = aa + 1
		end
	end
	if cY <= 0 then
		print(
			(
				(
					(
						("[DungeonRoom " .. tostring(self.roomID))
						.. "] ⚠️ 本波没有成功创建任何怪物，剩余待刷="
					) .. tostring(self.spawnInfo.totalCount)
				) .. "，存活="
			) .. tostring(self.aliveEnemyCount)
		)
		self:TryFinishCombatWhenNoEnemies(self.position)
	end
end
function K.prototype.TryFinishCombatWhenNoEnemies(self, Q)
	if self.isCombatEnd or self.isDispose then
		return
	end
	if self:IsBossRoom() then
		return
	end
	if DungeonManager:IsTutorial() then
		return
	end
	if self.aliveEnemyCount > 0 or self.spawnInfo.totalCount > 0 then
		return
	end
	local d1 = GetGroundPosition(Q, nil)
	if not GridNav:IsValidPosition(d1) then
		d1 = self:GetNearestValidGridPosition(d1) or self.position
	end
	print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 无剩余有效怪物，执行战斗房兜底清场")
	self:FinishCombat(d1)
end
function K.prototype.FinishCombat(self, Q)
	if self.isCombatEnd or self.isDispose then
		return
	end
	self.dungeonTrap:StopCombat()
	self:CreateTreasure(Q)
	self:CreateInteractiveTravelingMerchant()
	self.isCombatEnd = true
	self:StopUnitManagerGuardTimer()
	Event:Fire("dungeon_room_clear", { room = self, position = Q, trapOnlyClear = self.playerKilledEnemyCount == 0 })
end
function K.prototype.CreateBoss(self)
	if self.bossName == nil or self.bossName == "" then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss房缺少Boss名称配置")
		return
	end
	local T = self.bossName
	if KeyValues.units[T] == nil then
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 警告：Boss单位 '") .. T) .. "' 未在KV中定义")
		return
	end
	local d2 = self:FindInfoTarget("info_boss_spawn")
	local d3 = d2 and d2:GetAbsOrigin() or self.position
	print(
		(
			(
				((((("[DungeonRoom " .. tostring(self.roomID)) .. "] 生成Boss: ") .. T) .. " at (") .. tostring(d3.x))
				.. ", "
			) .. tostring(d3.y)
		) .. ")"
	)
	self.aliveEnemyCount = self.aliveEnemyCount + 1
	CreateUnitByNameAsync(T, d3, true, nil, nil, DOTA_TEAM_BADGUYS, function(d4)
		if not IsValid(d4) then
			print(
				((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ Boss创建失败: ") .. T)
					.. "，回退计数器"
			)
			self.aliveEnemyCount = self.aliveEnemyCount - 1
			self.aliveEnemyCount = math.max(0, self.aliveEnemyCount)
			return
		end
		if self.isDispose then
			d4:SafeRemoveUnit()
		else
			d4:SetForwardVector(vec3_bottom)
			local d5 = KeyValues.units[T]
			local d6 = math.max(0.1, toFiniteNumber(d5.IntroDuration, 4))
			local d7 = toFiniteNumber(d5.IntroFocusDistance, 520)
			local d8 = toFiniteNumber(d5.IntroHeightOffset, 160)
			local d9 = GameRules:GetGameTime()
			local da = d4:GetForwardVector()
			local db = {
				targetEntIndex = d4:GetEntityIndex(),
				targetX = d3.x,
				targetY = d3.y,
				targetZ = d3.z,
				forwardX = da.x,
				forwardY = da.y,
				forwardZ = da.z,
				duration = d6,
				focusDistance = d7,
				heightOffset = d8,
				restoreDuration = 1,
				startTime = d9,
				endTime = d9 + d6,
				sequence = d9,
			}
			CustomNetTables:SetNetData("common", "boss_intro", { state = true })
			CustomNetTables:SetNetData("common", "boss_intro_camera", l({ state = true }, db))
			CustomGameEventManager:Send_ServerToAllClients("boss_camera_intro", db)
			Timer:GameTimer(d6, function()
				CustomNetTables:SetNetData("common", "boss_intro", { state = false })
				CustomNetTables:SetNetData("common", "boss_intro_camera", { state = false })
				self.dungeonTrap:AddBossShrink()
			end)
			Game:EachPlayer(function(a0, ae)
				local aH = PlayerResource:GetSelectedHeroEntity(ae)
				if IsValid(aH) then
					aH:AddNewModifier(aH, nil, "modifier_stunned", { duration = d6 })
				end
			end)
			DungeonManager:MarkBossSpawned(T)
			local dc = self.enemies
			dc[#dc + 1] = d4
			self:AssignPreviewRewardsToEnemy(d4)
			d4:AddNewModifier(d4, nil, "modifier_boss_custom", {})
			self:ApplyDifficultyModifiers(d4)
			if self.difficultyCooldownReduction ~= 0 then
				d4:AddProperty(PropertyFunction.COOLDOWN_REDUCTION, self.difficultyCooldownReduction)
			end
			if self.difficultyBossGapAmplify ~= 0 then
				d4:AddProperty(PropertyFunction.BOSS_GAP_AMPLIFY, self.difficultyBossGapAmplify)
			end
			print(
				(
					(
						(
							(
								(
									(
										(("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss已生成: ")
										.. d4:GetUnitName()
									) .. "， health:"
								) .. tostring(d4:GetMaxHealth())
							) .. " attack:"
						) .. tostring(d4:GetAttackDamage())
					) .. "当前计数="
				) .. tostring(self.aliveEnemyCount)
			)
		end
	end)
end
function K.prototype.CreateShopItem(self, dd)
	local de = {}
	local df = self:GetSinglePlayerShopFilterHero()
	if df ~= nil then
		self:AppendShopExcludedForHero(de, df)
	end
	local dg = self:FindInfoTarget("info_shop_heal")
	if IsValid(dg) then
		self:SpawnShopItemAtPosition("item_heal_shop", 1, dg:GetAbsOrigin(), "heal")
		de[#de + 1] = "item_heal_shop"
	end
	local dh = self:FindInfoTarget("info_shop_upgrade")
	if IsValid(dh) then
		self:SpawnShopItemAtPosition("item_bless_upgrade", 1, dh:GetAbsOrigin(), "upgrade")
		de[#de + 1] = "item_bless_upgrade"
	end
	local di = self:FindInfoTarget("info_shop_refresh")
	if IsValid(di) then
		self:ClearShopRefreshInteract()
		local a1 = CreateUnitByName("interact_shop_refresh", di:GetAbsOrigin(), false, nil, nil, DOTA_TEAM_GOODGUYS)
		a1:SetForwardVector(vec3_bottom)
		local aG = Interaction:RegisterInteract(a1, InteractType.Refresh, 200, function(a0, aH, ae)
			local dj = SHOP_REFRESH_BASE_COST + self.shopRefreshCount * SHOP_REFRESH_COST_INCREMENT
			if Player:GetGold(ae) < dj then
				return false
			end
			Player:ModifyGold(ae, -dj)
			self.shopRefreshCount = self.shopRefreshCount + 1
			self:RefreshShopItems()
			EmitSoundOnLocationForPlayer("General.Buy", aH:GetAbsOrigin(), ae)
			Event:Fire("shop_refresh_purchased", { playerID = ae, cost = dj })
			return true
		end, 999999)
		if aG ~= -1 then
			Interaction:UpdateInteract(
				aG,
				{
					costInfo = {
						costType = "gold",
						cost = SHOP_REFRESH_BASE_COST + self.shopRefreshCount * SHOP_REFRESH_COST_INCREMENT,
					},
				}
			)
			local dk = self.registeredInteracts
			dk[#dk + 1] = aG
			self.shopRefreshInteractIndex = aG
		end
		self.shopRefreshUnit = a1
		local dl = self.npcs
		dl[#dl + 1] = a1
	end
	local dm = self:FindInfoTarget("info_shop_item")
	if not IsValid(dm) then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] ⚠️ 未找到 info_shop_item，跳过常规商店商品生成"
		)
		return
	end
	local dn = self:GetSymmetricShopPositions(dm:GetAbsOrigin(), SHOP_ITEM_COUNT)
	do
		local dp = 0
		while dp < #dn do
			do
				local a6 = 1
				local Y
				do
					local dq = 0
					while dq < 10 do
						a6 = self:RollShopRarity()
						Y = DrawPool:PickShopItemNameByRarity(a6, de)
						if Y ~= nil then
							break
						end
						dq = dq + 1
					end
				end
				if Y == nil then
					Y = DrawPool:Draw("items", de)
					a6 = 1
				end
				if Y == nil then
					goto dr
				end
				self:AppendShopGeneratedExcluded(de, Y)
				self:SpawnShopItemAtPosition(Y, a6, dn[dp + 1], "item_" .. tostring(dp + 1))
			end
			::dr::
			dp = dp + 1
		end
	end
	if not dd then
		local ds = Vector(dm:GetAbsOrigin().x, dm:GetAbsOrigin().y - 300, dm:GetAbsOrigin().z)
		Game:EachPlayer(function(a0, ae)
			if Privilege:HasPrivilege("privilege_bless_003", ae) then
				self:CreateFreeShopItem(ae, ds, de)
			end
		end)
	end
end
function K.prototype.CreateFreeShopItem(self, ae, Q, de)
	local dt = { unpack(de) }
	local aH = self:GetShopFilterHero(ae)
	if aH ~= nil then
		self:AppendShopExcludedForHero(dt, aH)
	end
	local Y
	local a6 = 1
	local du = ShuffledList({ 3, 4, 5 })
	do
		local aa = 0
		while aa < #du do
			local dv = du[aa + 1]
			Y = DrawPool:PickShopItemNameByRarity(dv, dt)
			if Y ~= nil then
				a6 = dv
				break
			end
			aa = aa + 1
		end
	end
	if Y == nil then
		Y = DrawPool:Draw("items", dt)
		a6 = 1
	end
	if Y ~= nil then
		self:AppendShopGeneratedExcluded(de, Y)
		self:SpawnShopItemAtPosition(Y, a6, Q, "free_item_" .. tostring(ae), true, ae)
		print(
			(
				(
					(
						(
							((("[DungeonRoom " .. tostring(self.roomID)) .. "] 玩家") .. tostring(ae))
							.. "专属免费商品: "
						) .. Y
					) .. " (稀有度"
				) .. tostring(a6)
			) .. ")"
		)
	end
	return Y
end
function K.prototype.GetShopFilterHero(self, ae)
	if ae ~= nil then
		local aH = PlayerResource:GetSelectedHeroEntity(ae)
		return IsValid(aH) and aH or nil
	end
	local b6
	Game:EachPlayer(function(a0, dw)
		if b6 ~= nil then
			return
		end
		local aH = PlayerResource:GetSelectedHeroEntity(dw)
		if IsValid(aH) then
			b6 = aH
		end
	end)
	return b6
end
function K.prototype.GetSinglePlayerShopFilterHero(self)
	if Game:GetPlayerCount() ~= 1 then
		return nil
	end
	return self:GetShopFilterHero()
end
function K.prototype.AppendShopExcludedForHero(self, de, aH)
	local dx = {}
	local dy = aH:GetAllItems()
	do
		local aa = 0
		while aa < #dy do
			do
				local a8 = dy[aa + 1]
				if not IsValid(a8) then
					goto dz
				end
				local Y = a8:GetAbilityName()
				local dA = KeyValues.items[Y]
				if dA == nil then
					goto dz
				end
				local dB = toFiniteNumber(dA.Quantitylimit, 0)
				if dB > 0 and aH:GetItemCount(Y) >= dB then
					self:AppendShopExcludedItem(de, Y)
				end
				local dC = self:GetArtifactUpgradeGroup(Y)
				local dD = self:GetArtifactUpgradeRank(Y)
				if dC ~= "" and dD > (dx[dC] or 0) then
					dx[dC] = dD
				end
			end
			::dz::
			aa = aa + 1
		end
	end
	for Y, ap in pairs(KeyValues.items) do
		do
			local dE = tostring
			local dF = ap.UpgradeGroup
			if dF == nil then
				dF = ""
			end
			local dC = dE(dF)
			if dC == "" then
				goto dG
			end
			local dH = dx[dC]
			if dH == nil then
				goto dG
			end
			local dD = toFiniteNumber(ap.UpgradeRank, 0)
			if dD > 0 and dD <= dH then
				self:AppendShopExcludedItem(de, Y)
			end
		end
		::dG::
	end
end
function K.prototype.AppendShopGeneratedExcluded(self, de, Y)
	self:AppendShopExcludedItem(de, Y)
	local dC = self:GetArtifactUpgradeGroup(Y)
	local dD = self:GetArtifactUpgradeRank(Y)
	if dC == "" or dD <= 0 then
		return
	end
	for dI, ap in pairs(KeyValues.items) do
		do
			local dJ = tostring
			local dK = ap.UpgradeGroup
			if dK == nil then
				dK = ""
			end
			if dJ(dK) ~= dC then
				goto dL
			end
			local dM = toFiniteNumber(ap.UpgradeRank, 0)
			if dM > 0 and dM <= dD then
				self:AppendShopExcludedItem(de, dI)
			end
		end
		::dL::
	end
end
function K.prototype.AppendShopExcludedItem(self, de, Y)
	if not m(de, Y) then
		de[#de + 1] = Y
	end
end
function K.prototype.GetArtifactUpgradeGroup(self, Y)
	local dN = tostring
	local dO = KeyValues.items[Y]
	if dO ~= nil then
		dO = dO.UpgradeGroup
	end
	local dP = dO
	if dP == nil then
		dP = ""
	end
	return dN(dP)
end
function K.prototype.GetArtifactUpgradeRank(self, Y)
	local dQ = toFiniteNumber
	local dR = KeyValues.items[Y]
	if dR ~= nil then
		dR = dR.UpgradeRank
	end
	return dQ(dR, 0)
end
function K.prototype.SpawnShopItemAtPosition(self, Y, a6, Q, dS, dT, dU, dV)
	if dT == nil then
		dT = false
	end
	if dV == nil then
		dV = "Default"
	end
	print(
		(
			(
				(
					((((("[DungeonRoom " .. tostring(self.roomID)) .. "] Shop item slot=") .. dS) .. " item=") .. Y)
					.. " rarity="
				) .. tostring(a6)
			) .. " free="
		) .. tostring(dT)
	)
	local aR = d(C, Y, a6, Q, dT, dU, dV)
	Interaction:RegisterShopItemInteract(aR)
	local dW = self.registeredInteracts
	dW[#dW + 1] = aR:GetEntityIndex()
	local dX = self.shopItems
	dX[#dX + 1] = aR
end
function K.prototype.GetSymmetricShopPositions(self, bw, cK)
	local dn = {}
	local dY = 256 - (cK - 2) * 32
	local dZ = -((cK - 1) * dY) * 0.5
	do
		local dp = 0
		while dp < cK do
			local bT = dZ + dp * dY
			dn[#dn + 1] = Vector(bw.x + bT, bw.y, bw.z)
			dp = dp + 1
		end
	end
	return dn
end
function K.prototype.ClearShopRefreshInteract(self)
	if self.shopRefreshInteractIndex ~= nil then
		Interaction:UnregisterInteractable(self.shopRefreshInteractIndex)
		local d_ = {}
		do
			local aa = 0
			while aa < #self.registeredInteracts do
				local ay = self.registeredInteracts[aa + 1]
				if ay ~= self.shopRefreshInteractIndex then
					d_[#d_ + 1] = ay
				end
				aa = aa + 1
			end
		end
		self.registeredInteracts = d_
		self.shopRefreshInteractIndex = nil
	end
	if self.shopRefreshUnit ~= nil then
		ArrayRemove(self.npcs, self.shopRefreshUnit)
		self:RemoveUnit(self.shopRefreshUnit)
		self.shopRefreshUnit = nil
	end
end
function K.prototype.RefreshShopItems(self)
	if self.roomType ~= RoomType.SHOP then
		return
	end
	print(("[DungeonRoom " .. tostring(self.roomID)) .. "] RefreshShopItems")
	Interaction:BeginSyncBatch()
	local e0 = {}
	do
		local aa = 0
		while aa < #self.shopItems do
			do
				local e1 = self.shopItems[aa + 1]
				if e1 == nil then
					goto e2
				end
				local ay = e1:GetEntityIndex()
				if ay == -1 then
					goto e2
				end
				Interaction:UnregisterInteractable(ay)
				e0[ay] = true
				e1:dispose()
			end
			::e2::
			aa = aa + 1
		end
	end
	self.shopItems = {}
	local d_ = {}
	do
		local aa = 0
		while aa < #self.registeredInteracts do
			local ay = self.registeredInteracts[aa + 1]
			if e0[ay] ~= true then
				d_[#d_ + 1] = ay
			end
			aa = aa + 1
		end
	end
	self.registeredInteracts = d_
	self:ClearShopRefreshInteract()
	self:CreateShopItem(true)
	Interaction:EndSyncBatch()
end
function K.prototype.CreateStairItem(self)
	local e3 = GetGroundPosition(self.position, nil)
	self.stairChestPlayers = {}
	self.stairChestCompletedPlayers = {}
	self.stairChestAutoClaimingPlayers = {}
	self.stairChestOpeningPlayers = {}
	self.stairChestIgnoredPlayers = {}
	self.stairChestItemPos = e3
	local e4 = DungeonManager:IsTutorial()
	Game:EachPlayer(function(a0, ae)
		self.stairChestPlayers[ae] = true
		local aC = d(w, ae, "9900000", e3, { 0, 0 })
		local e5 = self.clientItems
		e5[#e5 + 1] = aC
		local aG
		aG = Interaction:RegisterInteract(aC.entity, InteractType.BossChest, 200, function(a0, aH)
			if not self:CanOpenStairChest(ae) then
				return false
			end
			if self:IsEquipmentCapacityFull(ae) then
				self:ShowEquipmentCapacityDialog(ae, true)
				return false
			end
			self.stairChestOpeningPlayers[ae] = true
			self:RequestStairChestRewards(ae, 1, false, e3, function(a0, e6)
				self.stairChestOpeningPlayers[ae] = false
				if not e6 or self.isDispose or self.stairChestIgnoredPlayers[ae] == true then
					if DungeonManager:IsTutorial() then
						self:CompleteManualStairChestOpen(ae, aG, aC, e3, false, false)
						self:OpenGates()
						return
					end
					self:TryOpenStairGatesByChestState()
					return
				end
				self:CompleteManualStairChestOpen(ae, aG, aC, e3, false, false)
			end, true)
			return false
		end, nil, ae)
		if not e4 then
			Interaction:SetSecondaryInteraction(aG, function(a0, aH)
				if not self:CanOpenStairChest(ae) then
					return false
				end
				if self:IsEquipmentCapacityFull(ae) then
					self:ShowEquipmentCapacityDialog(ae, true)
					return false
				end
				local e7 = Privilege:HasPrivilege("privilege_bless_001", ae)
				local e8 = e7 and Privilege:GetPrivilegeSpecialValue("privilege_bless_001", 1, "free_count", aH) or 0
				local e9 = CommonService:GetPlayerServiceNetTable(ae, "player_counters") or {}
				local ea = e9.daily_free_boss_rewards
				local eb = ea and ea.count or 0
				local ec = eb < e8
				print(
					(
						(
							(
								(
									(
										((("[DungeonRoom " .. tostring(self.roomID)) .. "] Player ") .. tostring(ae))
										.. " Open Boss Chest Rewards isUseFreeCount="
									) .. tostring(ec)
								) .. " usedFreeCount="
							) .. tostring(eb)
						) .. " freeCount="
					) .. tostring(e8)
				)
				if not ec then
					local ed = CommonService:GetPlayerServiceNetTable(ae, "player_tokens") or {}
					local ee = ed["110006"]
					if (ee and ee.amounts or 0) < 1 then
						ErrorMessage("error_token_no_enough", ae)
						return false
					end
				end
				self.stairChestOpeningPlayers[ae] = true
				self:RequestStairChestRewards(ae, 2, ec, e3, function(a0, e6)
					self.stairChestOpeningPlayers[ae] = false
					if not e6 or self.isDispose or self.stairChestIgnoredPlayers[ae] == true then
						self:TryOpenStairGatesByChestState()
						return
					end
					self:CompleteManualStairChestOpen(ae, aG, aC, e3, true, ec)
				end, true)
				return false
			end)
			local aH = PlayerResource:GetSelectedHeroEntity(ae)
			local e7 = Privilege:HasPrivilege("privilege_bless_001", ae)
			local e8 = e7 and Privilege:GetPrivilegeSpecialValue("privilege_bless_001", 1, "free_count", aH) or 0
			local e9 = CommonService:GetPlayerServiceNetTable(ae, "player_counters") or {}
			local ef = e9.daily_free_boss_rewards
			local eb = ef and ef.count or 0
			Interaction:UpdateSecondaryInteract(
				aG,
				{ tooltip = "DoubleBossChest", costInfo = {
					cost = 1,
					costType = "110006",
					costSource = "tokens",
					freeCount = e8 - eb,
				} }
			)
		end
		if aG ~= -1 then
			local eg = self.registeredInteracts
			eg[#eg + 1] = aG
		end
	end)
	local a1 = CreateUnitByName(
		"interact_regen_well",
		self.position + Vector(500, 700, 0),
		false,
		nil,
		nil,
		DOTA_TEAM_GOODGUYS
	)
	local aG = Interaction:RegisterInteract(a1, InteractType.RegenWell, 200, function(a0, aH, ae)
		local eh = a1:FindModifierByName("modifier_spawn_interact_regen_well")
		if eh ~= nil then
			eh:Activity()
		end
	end, 1)
	if aG ~= -1 then
		local ei = self.registeredInteracts
		ei[#ei + 1] = aG
	end
	local ej = self.npcs
	ej[#ej + 1] = a1
	if DungeonManager:IsFinalZone(self.zoneID) then
		DungeonAdventure:OpenAdventure(self.zoneID, self.roomType, self.position)
	end
end
function K.prototype.CompleteManualStairChestOpen(self, ae, aG, aC, e3, bs, ec)
	Interaction:UnregisterInteractable(aG)
	ArrayRemove(self.registeredInteracts, aG)
	self:MarkStairChestCompleted(ae)
	if not DungeonManager:IsTutorial() then
		local b7 = DungeonManager:GetRoomIndex() + 1
		Service:ReportClick(ae, "dungeon", "reward_room|open_chest|room_" .. tostring(b7))
	end
	EmitSoundOnLocationForPlayer(bs and "Chess.LongOpen" or "Chess.Open", e3, ae)
	if ec then
		Notification:CombatToPlayer(ae, { message = "Notify_FreeOpenBossRewards" })
	end
	e(aC.particleIDs, function(a0, ek)
		ParticleManager:DestroyParticle(ek, false)
	end)
	aC.particleIDs = {}
	local el = PlayerResource:GetPlayer(ae)
	if el == nil then
		return
	end
	local em = ParticleManager:CreateParticleForPlayer(
		"particles/generic_gameplay/boss_chest_opening.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aC.entity,
		el
	)
	ParticleManager:SetParticleControlEnt(em, 1, aC.entity, PATTACH_INVALID, nil, aC.entity:GetAbsOrigin(), true)
	local en = aC.particleIDs
	en[#en + 1] = em
	Timer:GameTimer(0.8, function()
		if self.isDispose or aC.isDispose then
			return
		end
		e(aC.particleIDs, function(a0, ek)
			ParticleManager:DestroyParticle(ek, false)
		end)
		aC.particleIDs = {}
		local eo = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/treasure_box/treasure_box_open_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			el
		)
		ParticleManager:SetParticleControl(eo, 0, aC.entity:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(eo)
		local ep = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/boss_chest_open.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			el
		)
		ParticleManager:SetParticleControl(ep, 0, aC.entity:GetAbsOrigin())
		local eq = aC.particleIDs
		eq[#eq + 1] = ep
	end)
end
function K.prototype.CanOpenStairChest(self, ae)
	if self.roomType ~= RoomType.STAIR then
		return true
	end
	return self.stairChestCompletedPlayers[ae] ~= true
		and self.stairChestAutoClaimingPlayers[ae] ~= true
		and self.stairChestOpeningPlayers[ae] ~= true
		and self.stairChestIgnoredPlayers[ae] ~= true
end
function K.prototype.MarkStairChestCompleted(self, ae)
	if self.roomType ~= RoomType.STAIR then
		return
	end
	if self.stairChestCompletedPlayers[ae] == true then
		return
	end
	self.stairChestCompletedPlayers[ae] = true
	self.stairChestAutoClaimingPlayers[ae] = false
	self.stairChestOpeningPlayers[ae] = false
	print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 楼梯房宝箱完成 player=") .. tostring(ae))
	self:TryOpenStairGatesByChestState()
end
function K.prototype.StartStairChestStateWatcher(self)
	if
		self.roomType ~= RoomType.STAIR
		or self.stairChestStateTimerID ~= nil
		or self.isDispose
		or self.isComplete
		or self.gatesOpened
	then
		return
	end
	self.stairChestStateTimerID = Timer:GameTimer(1, function()
		self.stairChestStateTimerID = nil
		if self.isDispose or self.isComplete or self.gatesOpened or self.roomType ~= RoomType.STAIR then
			return
		end
		self:RefreshStairChestPlayerStates()
		if not self.gatesOpened then
			self:StartStairChestStateWatcher()
		end
	end)
end
function K.prototype.StopStairChestStateWatcher(self)
	if self.stairChestStateTimerID == nil then
		return
	end
	Timer:StopTimer(self.stairChestStateTimerID)
	self.stairChestStateTimerID = nil
end
function K.prototype.StartUnitManagerGuardTimer(self)
	if
		not self:IsCombatRoom()
		or self.unitManagerGuardTimerID ~= nil
		or self.isDispose
		or self.isComplete
		or self.isCombatEnd
	then
		return
	end
	self.unitManagerGuardTimerID = Timer:GameTimer(5, function()
		if self.isDispose or self.isComplete or self.isCombatEnd or not self:IsCombatRoom() then
			self.unitManagerGuardTimerID = nil
			return
		end
		self:CheckUnitManagerGuard()
		return 5
	end)
end
function K.prototype.StopUnitManagerGuardTimer(self)
	if self.unitManagerGuardTimerID == nil then
		return
	end
	Timer:StopTimer(self.unitManagerGuardTimerID)
	self.unitManagerGuardTimerID = nil
end
function K.prototype.CheckUnitManagerGuard(self)
	if UnitManager == nil or not UnitManager:IsReady() then
		return
	end
	local er = self:GetAliveManagedEnemies()
	if #er >= 5 then
		return
	end
	local es = {}
	for a0, aw in ipairs(er) do
		if not UnitManager:IsUnitIndexValid(aw) then
			UnitManager:RepairUnitIndex(aw)
			es[#es + 1] = aw
		end
	end
	if #es <= 0 or self.hasReportedUnitManagerGuard then
		return
	end
	self.hasReportedUnitManagerGuard = true
	self:ReportUnitManagerGuard(es, #er)
end
function K.prototype.GetAliveManagedEnemies(self)
	local er = {}
	do
		local aa = 0
		while aa < #self.enemies do
			local aw = self.enemies[aa + 1]
			if IsValid(aw) and aw:IsAlive() then
				er[#er + 1] = aw
			end
			aa = aa + 1
		end
	end
	return er
end
function K.prototype.ReportUnitManagerGuard(self, es, et)
	if CommonService == nil then
		return
	end
	CommonService:CallAction(
		"/v1/log/report",
		0,
		{
			level = "Server",
			message = "[DungeonRoom] UnitManager guard repaired enemy indexes " .. json.encode({
				roomID = self.roomID,
				roomKey = self:GetRoomKey(),
				roomType = RoomType[self.roomType],
				mapName = self.mapName,
				aliveEnemyCount = et,
				trackedEnemyCount = #self.enemies,
				pendingAliveEnemyCount = self.aliveEnemyCount,
				remainingSpawnCount = self.spawnInfo.totalCount,
				repairedEnemies = k(es, function(a0, aw)
					return self:GetUnitManagerGuardUnitReport(aw)
				end),
			}),
		}
	)
end
function K.prototype.GetUnitManagerGuardUnitReport(self, a1)
	return UnitManager and UnitManager:GetUnitIndexReport(a1) or { valid = false }
end
function K.prototype.GetStairChestPlayerCount(self)
	local cK = 0
	for eu in pairs(self.stairChestPlayers) do
		cK = cK + 1
	end
	return cK
end
function K.prototype.RefreshStairChestPlayerStates(self)
	if self.roomType ~= RoomType.STAIR or self.isDispose or self.isComplete or self.gatesOpened then
		return
	end
	for ev in pairs(self.stairChestPlayers) do
		do
			local ae = tonumber(ev)
			if
				ae == nil
				or self.stairChestCompletedPlayers[ae] == true
				or self.stairChestIgnoredPlayers[ae] == true
			then
				goto ew
			end
			local ex = PlayerResource:GetConnectionState(ae)
			if ex == DOTA_CONNECTION_STATE_CONNECTED then
				goto ew
			end
			if ex == DOTA_CONNECTION_STATE_ABANDONED then
				self.stairChestIgnoredPlayers[ae] = true
				self.stairChestAutoClaimingPlayers[ae] = false
				self.stairChestOpeningPlayers[ae] = false
				print(
					(
						("[DungeonRoom " .. tostring(self.roomID))
						.. "] 楼梯房玩家已放弃，跳过宝箱并不再等待 player="
					) .. tostring(ae)
				)
				goto ew
			end
			self:AutoClaimStairChest(ae)
		end
		::ew::
	end
	self:TryOpenStairGatesByChestState()
end
function K.prototype.AutoClaimStairChest(self, ae)
	if
		self.stairChestCompletedPlayers[ae] == true
		or self.stairChestIgnoredPlayers[ae] == true
		or self.stairChestAutoClaimingPlayers[ae] == true
		or self.stairChestOpeningPlayers[ae] == true
	then
		return
	end
	if self.stairChestItemPos == nil then
		return
	end
	self.stairChestAutoClaimingPlayers[ae] = true
	print(
		(("[DungeonRoom " .. tostring(self.roomID)) .. "] 楼梯房玩家断线，自动普通开箱 player=")
			.. tostring(ae)
	)
	self:RequestStairChestRewards(ae, 1, false, self.stairChestItemPos, function(a0, e6)
		self.stairChestAutoClaimingPlayers[ae] = false
		if not e6 then
			self:TryOpenStairGatesByChestState()
			return
		end
		if self.isDispose or self.isComplete or self.stairChestIgnoredPlayers[ae] == true then
			self:TryOpenStairGatesByChestState()
			return
		end
		self:MarkStairChestCompleted(ae)
	end)
end
function K.prototype.TryOpenStairGatesByChestState(self)
	if self.roomType ~= RoomType.STAIR or self.isDispose or self.isComplete or self.gatesOpened then
		return
	end
	local ey = 0
	local ez = 0
	local eA = 0
	local eB = 0
	for ev in pairs(self.stairChestPlayers) do
		do
			local ae = tonumber(ev)
			if ae == nil then
				goto eC
			end
			ey = ey + 1
			if self.stairChestIgnoredPlayers[ae] == true then
				eA = eA + 1
				goto eC
			end
			if self.stairChestCompletedPlayers[ae] == true then
				ez = ez + 1
				goto eC
			end
			eB = eB + 1
		end
		::eC::
	end
	local eD = DungeonAdventure:IsAdventureRequired("gem")
	local eE = not eD or DungeonAdventure:IsAdventureCompleted("gem")
	local eF = ey <= 0 or eB <= 0
	print(
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
															("[DungeonRoom " .. tostring(self.roomID))
															.. "] 楼梯房离开进度 chestCompleted="
														) .. tostring(eF)
													) .. " completed="
												) .. tostring(ez)
											) .. " ignored="
										) .. tostring(eA)
									) .. " waiting="
								) .. tostring(eB)
							) .. " total="
						) .. tostring(ey)
					) .. " adventureRequired="
				) .. tostring(eD)
			) .. " adventureCompleted="
		) .. tostring(eE)
	)
	if eF and eE then
		self:StopStairChestStateWatcher()
		self:OpenGates()
	end
end
function K.prototype.RequestBossChestRewards(self, ae, eG, eH, e3, eI, eJ)
	if eJ == nil then
		eJ = false
	end
	if eJ and self:IsEquipmentCapacityFull(ae) then
		self:ShowEquipmentCapacityDialog(ae, true)
		if eI ~= nil then
			eI(nil, false)
		end
		return
	end
	CommonService:RepeatCallAction(
		"/v1/settle/receive_boss_rewards",
		ae,
		{
			match_id = Match:GetMatchID(),
			round = DungeonManager:GetZoneIndex(),
			room_step = DungeonManager:GetRoomIndex(),
			open_times = eG,
			use_daily_free_open_times = eH,
		},
		function(a0, eK, eL)
			CommonService:CommonCallback(ae, eL)
			self:HandleBossChestRewardsResponse(eK, eL, e3, eI)
		end
	)
end
function K.prototype.RequestStairChestRewards(self, ae, eG, eH, e3, eI, eJ)
	if eJ == nil then
		eJ = false
	end
	if DungeonManager:IsTutorial() then
		if eJ and self:IsEquipmentCapacityFull(ae) then
			self:ShowEquipmentCapacityDialog(ae, true)
			if eI ~= nil then
				eI(nil, false)
			end
			return
		end
		CommonService:RepeatCallAction("/v1/player/receive_teach_rewards", ae, {}, function(a0, eK, eL)
			if eL.code == 0 or eL.code == 200 then
				CommonService:CommonCallback(ae, eL, false)
			else
				ErrorMessage("Tutorial's reward has been received", ae)
				if eI ~= nil then
					eI(nil, false)
				end
				return
			end
			self:HandleBossChestRewardsResponse(eK, eL, e3, eI)
		end, false)
		return
	end
	self:RequestBossChestRewards(ae, eG, eH, e3, eI, eJ)
end
function K.prototype.HandleBossChestRewardsResponse(self, ae, eL, e3, eI)
	if eL.code ~= 0 and eL.code ~= 200 then
		if eI ~= nil then
			eI(nil, false)
		end
		return
	end
	local eM
	if eL ~= nil then
		eM = eL.data
	end
	local eN
	if eM ~= nil then
		eN = eM.add_items
	end
	local eO = eN
	local eP
	if eO ~= nil then
		eP = eO.other
	end
	local eQ = eP
	local eR
	if eL ~= nil then
		eR = eL.data
	end
	local eS
	if eR ~= nil then
		eS = eR.player_equipments
	end
	local eT = eS
	local eU
	if eL ~= nil then
		eU = eL.data
	end
	local eV
	if eU ~= nil then
		eV = eU.player_drawings
	end
	local eW = eV
	local eX
	if eL ~= nil then
		eX = eL.data
	end
	local eY
	if eX ~= nil then
		eY = eX.player_keys
	end
	local eZ = eY
	local e_
	if eL ~= nil then
		e_ = eL.data
	end
	local f0
	if e_ ~= nil then
		f0 = e_.player_notices
	end
	local f1 = f0
	if f1 == nil then
		f1 = {}
	end
	local f2 = f1
	local f3 = f2[1]
	local f4 = (f3 and f3.key) == "BossRewards3TimesDrop"
	if f4 then
		Notification:CombatToPlayer(ae, { message = "Notify_BossRewards3TimesDrop" })
	end
	if not eQ and not eT and not eW and not eZ then
		if eI ~= nil then
			eI(nil, true)
		end
		self:ScheduleEquipmentCapacityDialog(ae)
		return
	end
	if eI ~= nil then
		eI(nil, true)
	end
	self:ScheduleEquipmentCapacityDialog(ae)
	Timer:GameTimer(0.8, function()
		if self.isDispose then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", e3, ae)
		local f5 = {}
		if eQ then
			for a0, ai in ipairs(eQ) do
				do
					local f6 = tonumber(GetItemPropType(ai.item_id))
					if f6 == 9 or f6 == 19 or f6 == 20 then
						goto f7
					end
					f5[#f5 + 1] =
						{ item_id = ai.item_id, amounts = ai.amounts, item_rarity = GetPropRarity(ai.item_id) }
				end
				::f7::
			end
		end
		if eT then
			for a0, f8 in ipairs(eT) do
				f5[#f5 + 1] = { item_id = f8.equipment_item_id, amounts = 1, item_rarity = f8.rarity, uid = f8.id }
			end
		end
		if eW then
			for a0, f9 in ipairs(eW) do
				f5[#f5 + 1] = { item_id = f9.drawing_item_id, amounts = 1, item_rarity = f9.rarity, uid = f9.id }
			end
		end
		if eZ then
			for a0, fa in ipairs(eZ) do
				f5[#f5 + 1] = { item_id = fa.key_item_id, amounts = 1, item_rarity = fa.rarity, uid = fa.id }
			end
		end
		local fb = {}
		for aa, ai in ipairs(f5) do
			fb[#fb + 1] = ai
			Timer:GameTimer(0.1 * aa, function()
				if self.isDispose then
					return
				end
				local fc = d(w, ae, ai.item_id, e3, { 200, 300 })
				local fd = self.clientItems
				fd[#fd + 1] = fc
				local aG = Interaction:RegisterInteract(fc.entity, InteractType.Consumables, 200, function(a0, aH, bt)
					CommonService:SendReceiveRewards(
						bt,
						{ { item_id = ai.item_id, amounts = ai.amounts, uid = ai.uid } }
					)
					fc:dispose()
					Event:Fire("client_item_pickup", { playerID = ae, item_id = ai.item_id })
				end, 1, ae)
				Interaction:UpdateInteract(aG, { position = fc:GetLandedPosition() })
				Interaction:SetSecondaryInteraction(aG, function(a0, aH, ae)
					local aJ = aH:GetPlayerOwnerID()
					local fe = {}
					do
						local aa = 0
						while aa < #self.clientItems do
							do
								local aC = self.clientItems[aa + 1]
								if aC == nil or aC.isDispose or not aC:IsLanded() or not IsValid(aC.entity) then
									goto ff
								end
								if aC.playerID ~= aJ then
									goto ff
								end
								local ay = aC:GetEntityIndex()
								if ay == -1 then
									goto ff
								end
								fe[#fe + 1] = { entityIndex = ay, position = aC:GetLandedPosition() }
							end
							::ff::
							aa = aa + 1
						end
					end
					do
						local aa = 0
						while aa < #fe do
							local fg = fe[aa + 1]
							self:CreateClientItemPickupParticle(fg.position, aH)
							Interaction:ExecutePrimaryCallback(fg.entityIndex, aH, ae)
							Interaction:UnregisterInteractable(fg.entityIndex)
							ArrayRemove(self.registeredInteracts, fg.entityIndex)
							aa = aa + 1
						end
					end
					self.clientItems = n(self.clientItems, function(a0, a7)
						return not a7.isDispose
					end)
				end)
				Interaction:UpdateSecondaryInteract(aG, { tooltip = "DoubleConsumables" })
				if aG ~= -1 then
					local fh = self.registeredInteracts
					fh[#fh + 1] = aG
				end
			end)
		end
		if #fb > 0 then
			Match:AddPlayerRoundRewards(ae, fb)
		end
	end)
end
function K.prototype.GetEquipmentCount(self, ae)
	return Equipment:GetCapacityCount(ae, "equipment")
end
function K.prototype.IsEquipmentCapacityFull(self, ae)
	return Equipment:IsCapacityFull(ae, "equipment")
end
function K.prototype.ScheduleEquipmentCapacityDialog(self, ae)
	Timer:GameTimer(0.8, function()
		local cK = self:GetEquipmentCount(ae)
		if cK >= I then
			self:ShowEquipmentCapacityDialog(ae, cK >= Equipment:GetCapacityLimit("equipment"))
		end
	end)
end
function K.prototype.ShowEquipmentCapacityDialog(self, ae, fi)
	Equipment:ShowCapacityDialog(ae, "equipment", fi)
end
function K.prototype.CreateSpecialRoom(self)
	if self.roomType == RoomType.SPECIAL then
		local b6 = self.specialKind
		if b6 == nil or b6 == "" then
			local fj = "special_room_zone" .. tostring(self.zoneID)
			b6 = DrawPool:Draw(fj)
			print(
				(((("[DungeonRoom " .. tostring(self.roomID)) .. "] SpecialRoom fallback draw from ") .. fj) .. ": ")
					.. (b6 or "-")
			)
		end
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] SpecialRoom resolved: ") .. (b6 or "-"))
		if b6 ~= nil and type(self["Create" .. b6]) == "function" then
			self["Create" .. b6](self)
		end
	end
end
function K.prototype.CreateWishingPool(self)
	local a1 = CreateUnitByName("interact_wishing_pool", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aG
	aG = Interaction:RegisterInteract(a1, InteractType.Pool, 380, function(a0, aH, ae)
		local fk = self.wishingPoolCount * WISHING_POOL_COST
		local e8 = Privilege:GetPlayerDynamicValue("privilege_bless_012", ae, "free_count") or 0
		local dj = e8 > 0 and 0 or fk
		if e8 > 0 then
			Privilege:SetPlayerDynamicValue("privilege_bless_012", ae, "free_count", e8 - 1)
		end
		if dj > 0 then
			if Player:GetGold(ae) < dj then
				EmitAnnouncerSoundForPlayer("General.Cancel", ae)
				return false
			end
			Player:ModifyGold(ae, -dj, true, true)
		end
		self.wishingPoolCount = self.wishingPoolCount + 1
		Interaction:UpdateInteract(
			aG,
			{ costInfo = { cost = self.wishingPoolCount * WISHING_POOL_COST, costType = "gold" } }
		)
		local ai = DrawPool:Draw("wish_pool_zone" .. tostring(self.zoneID))
		if ai ~= nil then
			local fl = CalcDirection2D(aH, self.position)
			local fm = self.position + fl * RandomInt(400, 500)
			fm.z = aH:GetAbsOrigin().z
			local aR = d(A, ai, fm)
			local fn = self.dropItems
			fn[#fn + 1] = aR
			local fo = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH, ae)
				if not aR:IsLanded() then
					return false
				end
				if aH ~= nil then
					aH:AddItemByName(ai, nil, false)
				end
				aR:dispose()
			end, nil, nil, ai)
			if fo ~= -1 then
				local fp = self.registeredInteracts
				fp[#fp + 1] = fo
			end
		end
		Event:Fire("wishing_pool_reward", { playerID = ae, cost = dj })
	end, 99999999)
	if aG ~= -1 then
		Interaction:UpdateInteract(
			aG,
			{ costInfo = { cost = self.wishingPoolCount * WISHING_POOL_COST, costType = "gold" } }
		)
		local fq = self.registeredInteracts
		fq[#fq + 1] = aG
	end
	local fr = self.npcs
	fr[#fr + 1] = a1
end
function K.prototype.CreateRegenWell(self)
	local a1 = CreateUnitByName("interact_regen_well", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aG = Interaction:RegisterInteract(a1, InteractType.RegenWell, 200, function(a0, aH, ae)
		local fs = a1:FindModifierByName("modifier_spawn_interact_regen_well")
		if fs ~= nil then
			fs:Activity()
		end
	end, 1)
	if aG ~= -1 then
		local ft = self.registeredInteracts
		ft[#ft + 1] = aG
	end
	local fu = self.npcs
	fu[#fu + 1] = a1
end
function K.prototype.CreateBook(self)
	local a1 = CreateUnitByName("interact_book", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aG = Interaction:RegisterInteract(a1, InteractType.Book, 200, function(a0, aH, ae)
		Game:EachPlayer(function(a0, ae)
			BlessUpgrade:RequestEnqueueBlessUpgrade(ae, 3)
		end)
		a1:EmitSoundParams("ui.badge_levelup", 0, 0.5, 0)
	end, 1)
	if aG ~= -1 then
		local fv = self.registeredInteracts
		fv[#fv + 1] = aG
	end
	local fw = self.npcs
	fw[#fw + 1] = a1
end
function K.prototype.CreateSmithy(self)
	local a1 = CreateUnitByName("interact_smithy", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	a1:SetForwardVector(vec3_bottom)
	local aG = Interaction:RegisterInteract(a1, InteractType.Smithy, 200, function(a0, fx, eu)
		Game:EachPlayer(function(a0, ae)
			local b6 = ArtifactUpgrade:RequestEnqueueArtifactUpgrade(ae, 3)
			if not b6 then
				ErrorMessage("#error_no_artifact_upgrade", ae)
				Artifact:RequestEnqueueArtifactSelection(ae, 3, { [2] = 7, [3] = 3 })
			end
		end)
		a1:EmitSoundParams("ui.badge_levelup", 0, 0.5, 0)
	end, 1)
	if aG ~= -1 then
		local fy = self.registeredInteracts
		fy[#fy + 1] = aG
	end
	local fz = self.npcs
	fz[#fz + 1] = a1
end
function K.prototype.HasTravelingMerchant(self)
	return self.specialKind == H
end
function K.prototype.IsTravelingMerchantNear(self, Q, fA)
	if self.travelingMerchantPosition == nil then
		return false
	end
	return CalcDistance(Q, self.travelingMerchantPosition) <= fA
end
function K.prototype.GetTravelingMerchantTrapPositions(self)
	local fB = {}
	local fC = Entities:FindAllByClassname("prop_dynamic")
	do
		local aa = 0
		while aa < #fC do
			local fD = fC[aa + 1]
			if fD:GetSpawnGroupHandle() == self.spawnGroup and o(fD:GetName(), "trap_fire_model") then
				fB[#fB + 1] = fD:GetAbsOrigin()
			end
			aa = aa + 1
		end
	end
	return fB
end
function K.prototype.GetTravelingMerchantExitInfos(self)
	local fE = {}
	do
		local aa = 0
		while aa < #self.exitInfos do
			do
				local a9 = self.exitInfos[aa + 1]
				if a9 == nil then
					goto fF
				end
				fE[#fE + 1] = { position = a9.position, direction = a9.direction }
			end
			::fF::
			aa = aa + 1
		end
	end
	return fE
end
function K.prototype.IsTravelingMerchantBlockedByExit(self, Q)
	local fE = self:GetTravelingMerchantExitInfos()
	local fG = GRID_SIZE * 2
	local fH = GRID_SIZE * 0.75
	do
		local aa = 0
		while aa < #fE do
			local a9 = fE[aa + 1]
			local fI = Q:__sub(a9.position)
			local fJ = fI.x * a9.direction.x + fI.y * a9.direction.y
			local fK = -fJ
			local fL = math.abs(fI.x * -a9.direction.y + fI.y * a9.direction.x)
			if fK >= 0 and fK <= fG and fL <= fH then
				return true
			end
			aa = aa + 1
		end
	end
	return false
end
function K.prototype.ResolveTravelingMerchantForward(self, Q)
	local bP = Q.x - self.position.x
	local bQ = Q.y - self.position.y
	if math.abs(bP) > math.abs(bQ) then
		return bP > 0 and vec3_left or vec3_right
	end
	return vec3_bottom
end
function K.prototype.IsTravelingMerchantGridPositionValid(self, Q)
	do
		local aa = 0
		while aa < #self.validGridPositions do
			local fM = self.validGridPositions[aa + 1]
			if fM ~= nil and CalcDistance(fM, Q) <= GRID_SIZE * 0.25 then
				return true
			end
			aa = aa + 1
		end
	end
	return false
end
function K.prototype.CanPlaceTravelingMerchantAt(self, Q, fN)
	if not self:IsTravelingMerchantGridPositionValid(Q) then
		return false
	end
	local fO = Q:__add(fN:__mul(GRID_SIZE))
	local fP = Vector(-fN.y, fN.x, 0)
	local fQ = Q:__add(fP:__mul(GRID_SIZE))
	local fR = Q:__sub(fP:__mul(GRID_SIZE))
	return self:IsTravelingMerchantGridPositionValid(fO)
		and self:IsTravelingMerchantGridPositionValid(fQ)
		and self:IsTravelingMerchantGridPositionValid(fR)
end
function K.prototype.GetTravelingMerchantDirectionCandidates(self, Q)
	local fS = self:ResolveTravelingMerchantForward(Q)
	local fT = { fS }
	local fU = { vec3_bottom, vec3_left, vec3_right }
	do
		local aa = 0
		while aa < #fU do
			local fl = fU[aa + 1]
			if fl ~= fS then
				fT[#fT + 1] = fl
			end
			aa = aa + 1
		end
	end
	return fT
end
function K.prototype.ResolveTravelingMerchantAngles(self, fl)
	if fl == vec3_left then
		return "0 180 0"
	end
	if fl == vec3_right then
		return "0 0 0"
	end
	return "0 -90 0"
end
function K.prototype.ResolveTravelingMerchantAdjustedPosition(self, Q, fN)
	local fV = Q
	local fW = fN:__mul(-1)
	local fX = GRID_SIZE * 0.1
	local fY = GRID_SIZE * 0.5
	local fZ = 10
	do
		local f_ = 0
		while f_ <= fZ do
			local g0 = fY + fX * f_
			local cd = Q:__add(fW:__mul(g0))
			if not self:IsPositionInside(cd) or not GridNav:IsValidPosition(cd) then
				break
			end
			fV = cd
			f_ = f_ + 1
		end
	end
	return fV
end
function K.prototype.ResolveTravelingMerchantSpawnData(self)
	self.travelingMerchantPosition = nil
	self.travelingMerchantForward = vec3_bottom
	self.travelingMerchantAngles = "0 -90 0"
	if not self:HasTravelingMerchant() then
		return
	end
	if #self.validGridPositions <= 0 then
		return
	end
	local g1 = math.huge
	local g2 = -math.huge
	local g3 = -math.huge
	do
		local aa = 0
		while aa < #self.validGridPositions do
			do
				local fM = self.validGridPositions[aa + 1]
				if fM == nil then
					goto g4
				end
				g1 = math.min(g1, fM.x)
				g2 = math.max(g2, fM.x)
				g3 = math.max(g3, fM.y)
			end
			::g4::
			aa = aa + 1
		end
	end
	local fB = self:GetTravelingMerchantTrapPositions()
	local g5 = GRID_SIZE * 1.25
	local g6 = nil
	local g7 = nil
	local g8 = math.huge
	local g9 = -math.huge
	do
		local aa = 0
		while aa < #self.validGridPositions do
			do
				local fM = self.validGridPositions[aa + 1]
				if fM == nil then
					goto ga
				end
				if self:IsTravelingMerchantBlockedByExit(fM) then
					goto ga
				end
				local gb = false
				do
					local gc = 0
					while gc < #fB do
						if CalcDistance(fM, fB[gc + 1]) <= g5 then
							gb = true
							break
						end
						gc = gc + 1
					end
				end
				if gb then
					goto ga
				end
				local fT = self:GetTravelingMerchantDirectionCandidates(fM)
				local gd = nil
				do
					local ge = 0
					while ge < #fT do
						local fl = fT[ge + 1]
						if self:CanPlaceTravelingMerchantAt(fM, fl) then
							gd = fl
							break
						end
						ge = ge + 1
					end
				end
				if gd == nil then
					goto ga
				end
				local gf = math.min(math.abs(fM.x - g1), math.abs(g2 - fM.x), math.abs(g3 - fM.y))
				local gg = CalcDistance(fM, self.position)
				if gf < g8 or gf == g8 and gg > g9 then
					g6 = fM
					g7 = gd
					g8 = gf
					g9 = gg
				end
			end
			::ga::
			aa = aa + 1
		end
	end
	if g6 == nil or g7 == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] TravelingMerchant 未找到满足前方和两侧相邻网格条件的站位，跳过创建"
		)
		return
	end
	local fV = self:ResolveTravelingMerchantAdjustedPosition(g6, g7)
	self.travelingMerchantPosition = GetGroundPosition(fV, nil)
	self.travelingMerchantForward = g7
	self.travelingMerchantAngles = self:ResolveTravelingMerchantAngles(self.travelingMerchantForward)
	print(
		(
			(
				(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] TravelingMerchant spawn=(")
								.. tostring(self.travelingMerchantPosition.x)
							) .. ", "
						) .. tostring(self.travelingMerchantPosition.y)
					) .. ", "
				) .. tostring(self.travelingMerchantPosition.z)
			) .. ") angles="
		) .. self.travelingMerchantAngles
	)
end
function K.prototype.CreateTravelingMerchantPlaceholder(self)
	if
		not self:HasTravelingMerchant()
		or self.travelingMerchantPosition == nil
		or IsValid(self.travelingMerchantPlaceholder)
	then
		return
	end
	self.travelingMerchantPlaceholder = SpawnEntityFromTableSynchronous(
		"dota_prop_customtexture",
		{
			angles = self.travelingMerchantAngles,
			model = "models/props_structures/secretshop_dire001.vmdl",
			origin = self.travelingMerchantPosition,
			skin = "default",
			targetname = "traveling_merchant_placeholder",
			StartingAnim = "ACT_DOTA_IDLE",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		}
	)
end
function K.prototype.GetTravelingMerchantArtifactPool(self)
	local gh = {}
	for Y, ap in pairs(KeyValues.artifact) do
		local gi = tostring
		local gj = ap.Access
		if gj == nil then
			gj = ""
		end
		if gi(gj) == "Meepo" then
			gh[#gh + 1] = tostring(Y)
		end
	end
	return gh
end
function K.prototype.GetTravelingMerchantItemRarity(self, Y)
	return self:RollTavernItemRarity(Y)
end
function K.prototype.CreateTravelingMerchantShopItems(self)
	if self.travelingMerchantPosition == nil then
		return
	end
	local X = self:GetTravelingMerchantArtifactPool()
	if #X <= 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] TravelingMerchant 未找到 Access=Meepo 的 artifact 商品"
		)
		return
	end
	local de = {}
	local df = self:GetSinglePlayerShopFilterHero()
	if df ~= nil then
		self:AppendShopExcludedForHero(de, df)
	end
	local gk = self.travelingMerchantForward:__mul(128)
	local gl = self.travelingMerchantPosition:__add(gk)
	local fP = Vector(-self.travelingMerchantForward.y, self.travelingMerchantForward.x, 0)
	local gm = { -128, 0, 128 }
	local gn = {}
	local go = ShuffledList(X)
	do
		local aa = 0
		while aa < #go and #gn < 3 do
			do
				local Y = go[aa + 1]
				if Y == nil or Y == "" or m(de, Y) then
					goto gp
				end
				gn[#gn + 1] = Y
				self:AppendShopGeneratedExcluded(de, Y)
			end
			::gp::
			aa = aa + 1
		end
	end
	do
		local aa = 0
		while aa < #gn do
			do
				local Y = gn[aa + 1]
				if Y == nil or Y == "" then
					goto gq
				end
				local aK = gl:__add(fP:__mul(gm[aa + 1] or 0))
				local a6 = self:GetTravelingMerchantItemRarity(Y)
				self:SpawnShopItemAtPosition(
					Y,
					a6,
					aK,
					"traveling_merchant_" .. tostring(aa + 1),
					false,
					nil,
					"TravelingMerchant"
				)
			end
			::gq::
			aa = aa + 1
		end
	end
	local ds = gl:__add(gk)
	Game:EachPlayer(function(a0, ae)
		if Privilege:HasPrivilege("privilege_041", ae) then
			self:CreateFreeTravelingMerchantItem(ae, ds, X, de)
		end
	end)
end
function K.prototype.CreateFreeTravelingMerchantItem(self, ae, Q, X, de)
	local dt = { unpack(de) }
	local gr = {}
	local aH = self:GetShopFilterHero(ae)
	if aH ~= nil then
		self:AppendShopExcludedForHero(dt, aH)
		self:AppendShopExcludedForHero(gr, aH)
	end
	local Y
	local go = ShuffledList(X)
	do
		local aa = 0
		while aa < #go do
			local bE = go[aa + 1]
			if bE ~= nil and bE ~= "" and not m(dt, bE) then
				Y = bE
				break
			end
			aa = aa + 1
		end
	end
	if Y == nil then
		do
			local aa = 0
			while aa < #go do
				local bE = go[aa + 1]
				if bE ~= nil and bE ~= "" and not m(gr, bE) then
					Y = bE
					break
				end
				aa = aa + 1
			end
		end
	end
	if Y == nil then
		return
	end
	self:AppendShopGeneratedExcluded(de, Y)
	local a6 = self:GetTravelingMerchantItemRarity(Y)
	self:SpawnShopItemAtPosition(Y, a6, Q, "traveling_merchant_free_" .. tostring(ae), true, ae, "TravelingMerchant")
end
function K.prototype.CreateInteractiveTravelingMerchant(self)
	if
		not self:HasTravelingMerchant()
		or self.travelingMerchantPosition == nil
		or IsValid(self.travelingMerchantUnit)
	then
		return
	end
	local a1 = CreateUnitByName("interact_meepo", self.travelingMerchantPosition, false, nil, nil, DOTA_TEAM_GOODGUYS)
	a1:SetForwardVector(Rotation2D(self.travelingMerchantForward, 135, true))
	self.travelingMerchantUnit = a1
	local gs = self.npcs
	gs[#gs + 1] = a1
	self:CreateTravelingMerchantShopItems()
end
function K.prototype.RollTavernItemRarity(self, Y)
	local ap = KeyValues.items[Y]
	local gt = ap and ap.RarityRange
	if gt == nil or j(tostring(gt)) == "" then
		local gu = ap and ap.Rarity
		if gu ~= nil and j(tostring(gu)) ~= "" then
			return toFiniteNumber(gu, 1)
		end
		return 1
	end
	local gv = n(
		k(g(tostring(gt), "|"), function(a0, a7)
			return toFiniteNumber(a7, 0)
		end),
		function(a0, a7)
			return a7 > 0
		end
	)
	if #gv == 0 then
		return 1
	end
	local gw = { [1] = 50, [2] = 30, [3] = 15, [4] = 4, [5] = 1 }
	local gx = d(E)
	do
		local aa = 0
		while aa < #gv do
			local a6 = gv[aa + 1]
			gx:Set(a6, gw[a6] or 1)
			aa = aa + 1
		end
	end
	return gx:Random() or gv[1]
end
function K.prototype.CreateTavernItems(self)
	local gy = PickList(TAVERN_ITEMS, 4)
	local gz = { 1, 1, 1, 1 }
	local dm = self:FindInfoTarget("info_shop_item")
	if not IsValid(dm) then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 未找到 info_shop_item，跳过酒馆商品生成"
		)
		return
	end
	local gA = dm:GetAbsOrigin()
	local dn = self:GetSymmetricShopPositions(gA, #gy)
	print((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateTavernItems: slots=") .. tostring(#dn))
	do
		local dp = 0
		while dp < #dn do
			do
				local Y = gy[dp + 1]
				local a6 = gz[dp + 1] or 1
				if Y == nil or Y == "" then
					goto gB
				end
				print(
					(
						(
							(
								((("[DungeonRoom " .. tostring(self.roomID)) .. "] Tavern item slot=") .. tostring(dp))
								.. " item="
							) .. Y
						) .. " rarity="
					) .. tostring(a6)
				)
				self:SpawnShopItemAtPosition(Y, a6, dn[dp + 1], "tavern_" .. tostring(dp + 1))
			end
			::gB::
			dp = dp + 1
		end
	end
	local gC = n(TAVERN_ITEMS, function(a0, Y)
		return not m(gy, Y)
	end)
	local ds = Vector(gA.x, gA.y - 300, gA.z)
	Game:EachPlayer(function(a0, ae)
		if not Privilege:HasPrivilege("privilege_042", ae) then
			return
		end
		local gD = PickList(#gC > 0 and gC or TAVERN_ITEMS, 1)
		local Y = gD[1]
		if Y == nil or Y == "" then
			return
		end
		local a6 = gz[1] or 1
		self:SpawnShopItemAtPosition(Y, a6, ds, "tavern_free_" .. tostring(ae), true, ae)
	end)
end
function K.prototype.CreateFaith(self)
	local gE = DrawPool:Draw("faith")
	if gE then
		local a1 = CreateUnitByName(gE, self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
		local aG = Interaction:RegisterInteract(a1, InteractType.ShopItem, 200, function(a0, aH, ae)
			local a8 = DrawPool:Draw(gE)
			if a8 ~= nil then
				aH:AddItemByName(a8)
			end
		end)
		if aG ~= -1 then
			local gF = self.registeredInteracts
			gF[#gF + 1] = aG
		end
		local gG = self.npcs
		gG[#gG + 1] = a1
	end
end
function K.prototype.CreateOutpost(self)
	local a1 = CreateUnitByName("bonus_outpost", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local gH = self.npcs
	gH[#gH + 1] = a1
end
function K.prototype.ShouldCreateSecretRoom(self)
	if not DungeonManager:HasSecretRoomPrefabs() then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] 当前地形未配置隐藏房间预制体，跳过创建"
		)
		return false
	end
	local gI = DungeonManager:GetSecretRoomChance()
	local gJ = RollPercentage(gI)
	print(
		(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间判定 chance=") .. tostring(gI))
			.. "% result="
		) .. tostring(gJ)
	)
	return gJ
end
function K.prototype.TryCreateSecretGate(self, gK, gL, gM)
	if self.secretRoomPrefix ~= nil then
		return
	end
	if not self:ShouldCreateSecretRoom() then
		return
	end
	local gN = d(p, gL)
	gN:add(self.entrancePrefix)
	local gO = {}
	do
		local aa = 0
		while aa < #gK do
			local bd = gK[aa + 1]
			if bd ~= nil and not gN:has(bd) then
				gO[#gO + 1] = bd
			end
			aa = aa + 1
		end
	end
	if #gO == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 没有未使用的出口可用于隐藏房间")
		return
	end
	local gP = GetRandomElement(gO)
	if gP == nil then
		return
	end
	local gQ = r(gM, function(a0, gR)
		return q(gR:GetName(), gP .. "_")
	end)
	if not IsValid(gQ) then
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间出口实体无效: ") .. gP)
		return
	end
	local gS = gQ:GetAbsOrigin()
	local bw = self.position
	local bP = gS.x - bw.x
	local bQ = gS.y - bw.y
	local fl
	if math.abs(bQ) > math.abs(bP) then
		fl = vec3_top
	else
		fl = bP > 0 and vec3_right or vec3_left
	end
	local bO = gS:__add(fl:__mul(-128))
	self.secretRoomPrefix = gP
	self.secretRoomDoorPosition = gS
	self.secretRoomDoorDirection = fl
	CreateUnitByNameAsync("npc_dungeon_secret_gate", bO, true, nil, nil, DOTA_TEAM_BADGUYS, function(bb)
		if not IsValid(bb) then
			print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门创建失败")
			self.secretRoomPrefix = nil
			self.secretRoomDoorPosition = nil
			self.secretRoomDoorDirection = nil
			return
		end
		if self.isDispose then
			bb:SafeRemoveUnit()
			return
		end
		bb:SetAbsOrigin(bO)
		bb:SetForwardVector(Rotation2D(fl, 180, true))
		self.secretRoomGate = bb
		local gT = self.enemies
		gT[#gT + 1] = bb
		print(
			(
				(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门已创建: prefix=")
								.. gP
							) .. " pos=("
						) .. tostring(bO.x)
					) .. ", "
				) .. tostring(bO.y)
			) .. ")"
		)
	end)
end
function K.prototype.CreateSecretRoom(self, gU, fl)
	local gV = DungeonManager:GetSecretRoomPrefab(fl)
	if gV == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间未配置当前方向的预制体，跳过创建"
		)
		return
	end
	local function gW(a0, gX, gY)
		if gX % 64 == 0 then
			return gX
		end
		if gY > 0 then
			return math.ceil(gX / 64) * 64
		end
		if gY < 0 then
			return math.floor(gX / 64) * 64
		end
		return math.floor(gX / 64 + 0.5) * 64
	end
	local fm = Vector(gW(nil, gU.x, fl.x), gW(nil, gU.y, fl.y), gU.z)
	print(
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
																("[DungeonRoom " .. tostring(self.roomID))
																.. "] 创建隐藏房间: prefix="
															) .. tostring(self.secretRoomPrefix)
														) .. " prefab="
													) .. gV
												) .. " door=("
											) .. tostring(gU.x)
										) .. ", "
									) .. tostring(gU.y)
								) .. ") spawn=("
							) .. tostring(fm.x)
						) .. ", "
					) .. tostring(fm.y)
				) .. ", "
			) .. tostring(fm.z)
		) .. ")"
	)
	self.isSecretRoomCreated = true
	self.secretRoomSpawnGroup = DOTA_SpawnMapAtPosition(gV, fm, true, function(_)
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间 onReadyToSpawn")
		ManuallyTriggerSpawnGroupCompletion(_)
	end, function()
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间 onSpawnComplete")
		self:RevealSecretRoomGates()
		self:OnSecretRoomContentReady(fm, fl)
	end, nil)
end
function K.prototype.OnSecretRoomContentReady(self, fm, fl)
	local gZ = Entities:FindAllByClassname("info_target")
	local g_ = {}
	for a0, h0 in ipairs(gZ) do
		if h0:GetSpawnGroupHandle() == self.secretRoomSpawnGroup and o(h0:GetName(), "info_waard") then
			g_[#g_ + 1] = h0:GetAbsOrigin()
		end
	end
	if #g_ == 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间内未找到 info_waard 实体，使用推算中心位置"
		)
		g_[#g_ + 1] = fm:__add(fl:__mul(960))
	end
	Interaction:BeginSyncBatch()
	do
		local h1 = 0
		while h1 < #g_ do
			local h2 = g_[h1 + 1]
			if RollPercentage(50) then
				local bx = RandomInt(8, 15)
				local by = 480
				do
					local aa = 0
					while aa < bx do
						local bC = RandomFloat(0, 360)
						local aQ = RandomFloat(0, by)
						local bD = Vector(math.cos(bC * math.pi / 180) * aQ, math.sin(bC * math.pi / 180) * aQ, 0)
						local bA = h2:__add(bD)
						local aR = d(A, "item_coin_stack", bA)
						local h3 = self.dropItems
						h3[#h3 + 1] = aR
						local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
							aH:AddItemByName("item_coin_stack")
							aR:dispose()
						end, nil, nil, "item_coin_stack")
						if aG ~= -1 then
							local h4 = self.registeredInteracts
							h4[#h4 + 1] = aG
						end
						aa = aa + 1
					end
				end
				print(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间内容就绪，在 ward[")
								.. tostring(h1)
							) .. "] 周围生成 "
						) .. tostring(bx)
					) .. " 个金币堆"
				)
			else
				local aR = d(A, "item_treasure_secret", h2)
				local h5 = self.dropItems
				h5[#h5 + 1] = aR
				local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
					aH:AddItemByName("item_treasure_secret")
					aR:dispose()
				end, nil, nil, "item_treasure_secret")
				if aG ~= -1 then
					local h6 = self.registeredInteracts
					h6[#h6 + 1] = aG
				end
			end
			h1 = h1 + 1
		end
	end
	Interaction:EndSyncBatch()
end
function K.prototype.RevealSecretRoomGates(self)
	if self.secretRoomPrefix == nil then
		return
	end
	local h7 = self:FindEntities("prop_dynamic", "prop_wall")
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	local h8 = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	for a0, h9 in ipairs(h7) do
		local bd = g(h9:GetName(), "_")[1]
		if bd == self.secretRoomPrefix then
			h9:AddEffects(EF_NODRAW)
		end
	end
	for a0, bb in ipairs(ba) do
		local bd = g(bb:GetName(), "_")[1]
		if bd == self.secretRoomPrefix then
			bb:AddEffects(EF_NODRAW)
		end
	end
	for a0, bb in ipairs(h8) do
		local bd = g(bb:GetName(), "_")[1]
		if bd == self.secretRoomPrefix then
			bb:AddEffects(EF_NODRAW)
		end
	end
	print(
		(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门已揭示: prefix=") .. self.secretRoomPrefix
	)
end
function K.prototype.CreateEntrance(self)
	local gM = self:FindInfoTargets("info_room_start")
	if #gM == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	local ha = d(p)
	for a0, h0 in ipairs(gM) do
		local bc = h0:GetName()
		local bd = g(bc, "_")[1]
		if bd ~= nil and bd ~= "" then
			ha:add(bd)
		end
	end
	local hb = s(ha)
	if #hb == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	self.entrancePrefix = GetRandomElement(hb) or ""
	local hc = r(gM, function(a0, gR)
		return q(gR:GetName(), self.entrancePrefix .. "_")
	end)
	self.entrancePos = IsValid(hc) and hc:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
end
function K.prototype.CreateExit(self)
	local gM = self:FindInfoTargets("info_room_exit")
	print(
		((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 找到 ") .. tostring(#gM))
			.. " 个 info_room_exit"
	)
	if #gM == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无出口实体，使用默认配置")
		return
	end
	local ha = d(p)
	for a0, h0 in ipairs(gM) do
		local bc = h0:GetName()
		local bd = g(bc, "_")[1]
		if bd ~= nil and bd ~= "" then
			ha:add(bd)
		end
	end
	local hb = s(ha)
	if #hb == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无有效前缀")
		return
	end
	local hd = DungeonManager:GetExitCountOverrideByIndex(self.roomID) or 1
	local he = self.roomID + 1
	local hf = DungeonManager:GetRoomTypeByIndex(he)
	local hg = DungeonManager:GetRewardTypeByIndex(he)
	local hh = DungeonManager:GetRewardOptionsByIndex(he)
	local hi = DungeonManager:GetSpecialOptionsByIndex(he)
	if #hi > 0 then
		hd = #hi
	elseif #hh > 1 then
		hd = #hh
	end
	hd = math.min(#hb, hd)
	local gL = PickList(hb, hd)
	local hj = {}
	local hk = {}
	if #hi > 0 then
		local hl = { unpack(hi) }
		do
			local aa = #hl - 1
			while aa > 0 do
				local cf = RandomInt(0, aa)
				local hm = { hl[cf + 1], hl[aa + 1] }
				hl[aa + 1] = hm[1]
				hl[cf + 1] = hm[2]
				aa = aa - 1
			end
		end
		do
			local aa = 0
			while aa < hd do
				hj[#hj + 1] = hg
				hk[#hk + 1] = hl[aa + 1] or hl[1] or ""
				aa = aa + 1
			end
		end
	elseif #hh > 0 then
		if hd <= 1 then
			hj = { hg }
		else
			do
				local aa = 0
				while aa < hd do
					hj[#hj + 1] = hh[aa + 1] or hg
					aa = aa + 1
				end
			end
		end
	else
		hj = { hg }
	end
	self.exitInfos = {}
	local bw = self.position
	do
		local aa = 0
		while aa < #gL do
			do
				local bd = gL[aa + 1]
				if bd == nil then
					goto hn
				end
				local gQ = r(gM, function(a0, gR)
					return q(gR:GetName(), bd .. "_")
				end)
				local gS = IsValid(gQ) and gQ:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
				local bP = gS.x - bw.x
				local bQ = gS.y - bw.y
				local fl
				if math.abs(bQ) > math.abs(bP) then
					fl = vec3_top
				else
					fl = bP > 0 and vec3_right or vec3_left
				end
				local ho = self.exitInfos
				ho[#ho + 1] = {
					prefix = bd,
					position = gS,
					direction = fl,
					roomType = hf,
					rewardType = hj[aa + 1] or hg,
					specialKind = hk[aa + 1],
				}
				print(
					(
						(
							(
								(
									(
										(
											(
												(
													(("[DungeonRoom " .. tostring(self.roomID)) .. "] Exit ")
													.. tostring(aa)
												) .. ": prefix="
											) .. bd
										) .. " nextType="
									) .. RoomType[hf]
								) .. " reward="
							) .. RoomRewardType[hj[aa + 1] or hg]
						) .. " special="
					) .. (hk[aa + 1] or "-")
				)
			end
			::hn::
			aa = aa + 1
		end
	end
	self:TryCreateSecretGate(hb, gL, gM)
	self:UpdateGateVisibility()
	print(
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
																(("[DungeonRoom " .. tostring(self.roomID)) .. "-")
																.. RoomType[self.roomType]
															) .. "-"
														) .. RoomRewardType[self.rewardType]
													) .. "] 出口数量："
												) .. tostring(hd)
											) .. "，next:"
										) .. RoomType[hf]
									) .. "-"
								) .. RoomRewardType[hg]
							) .. " 前缀: "
						) .. table.concat(gL, ", ")
					) .. "，奖励："
				) .. table.concat(hj, ", ")
			) .. " special="
		) .. table.concat(hk, ", ")
	)
end
function K.prototype.GetExitTooltip(self, a9)
	if a9.roomType == RoomType.SPECIAL then
		if a9.specialKind == "WishingPool" then
			return "WishingPool"
		end
		if a9.specialKind == "RegenWell" then
			return "RegenWell"
		end
		if a9.specialKind == "Book" then
			return "Book"
		end
		if a9.specialKind == "Smithy" then
			return "Smithy"
		end
	end
	if
		a9.roomType == RoomType.SHOP
		or a9.roomType == RoomType.BOSS
		or a9.roomType == RoomType.STARTING
		or a9.roomType == RoomType.TAVERN
	then
		return RoomType[a9.roomType]
	end
	if a9.rewardType ~= RoomRewardType.NONE then
		return RoomRewardType[a9.rewardType]
	end
	return RoomType[a9.roomType]
end
function K.prototype.UpdateGateVisibility(self)
	local h7 = self:FindEntities("prop_dynamic", "prop_wall")
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	local h8 = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	local hp = d(p)
	hp:add(self.entrancePrefix)
	do
		local aa = 0
		while aa < #self.exitInfos do
			local a9 = self.exitInfos[aa + 1]
			if a9 ~= nil then
				hp:add(a9.prefix)
			end
			aa = aa + 1
		end
	end
	for a0, h9 in ipairs(h7) do
		local bc = h9:GetName()
		local bd = g(bc, "_")[1]
		if hp:has(bd) then
			h9:AddEffects(EF_NODRAW)
		else
			h9:RemoveEffects(EF_NODRAW)
		end
	end
	for a0, bb in ipairs(ba) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if hp:has(bd) then
			bb:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bb)
		end
	end
	for a0, bb in ipairs(h8) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if hp:has(bd) then
			bb:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bb)
		end
	end
end
function K.prototype.GetAvailablePositionIndices(self, hq, g3)
	local b6 = {}
	do
		local aa = 0
		while aa < #self.validGridPositions do
			if self.occupiedPositions[aa] ~= true then
				local hr = self.validGridPositions[aa + 1]
				if (hq == nil or hr.y >= hq) and (g3 == nil or hr.y <= g3) then
					b6[#b6 + 1] = aa
				end
			end
			aa = aa + 1
		end
	end
	return b6
end
function K.prototype.GetGridsAroundPosition(self, bw, fA, hs)
	if hs == nil then
		hs = 0
	end
	local dn = {}
	for a0, ht in ipairs(self:GetAvailablePositionIndices()) do
		do
			local Q = self.validGridPositions[ht + 1]
			if Q == nil then
				goto hu
			end
			local aQ = CalcDistance(Q, bw)
			if hs > 0 then
				if aQ < fA + hs and aQ > fA - hs then
					dn[#dn + 1] = Q
				end
			else
				if aQ < fA then
					dn[#dn + 1] = Q
				end
			end
		end
		::hu::
	end
	return dn
end
function K.prototype.GetNearestValidGridPosition(self, hv)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local hw = nil
	local aN = math.huge
	do
		local aa = 0
		while aa < #self.validGridPositions do
			do
				local Q = self.validGridPositions[aa + 1]
				if Q == nil then
					goto hx
				end
				local aQ = CalcDistance(Q, hv)
				if aQ < aN then
					aN = aQ
					hw = Q
				end
			end
			::hx::
			aa = aa + 1
		end
	end
	return hw
end
function K.prototype.IsPositionInside(self, Q)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local g1 = math.huge
	local g2 = -math.huge
	local hq = math.huge
	local g3 = -math.huge
	for a0, c1 in ipairs(self.validGridPositions) do
		if c1 ~= nil then
			g1 = math.min(g1, c1.x)
			g2 = math.max(g2, c1.x)
			hq = math.min(hq, c1.y)
			g3 = math.max(g3, c1.y)
		end
	end
	if g1 == math.huge then
		return false
	end
	local hy = GRID_SIZE * 0.5
	return Q.x >= g1 - hy and Q.x <= g2 + hy and Q.y >= hq - hy and Q.y <= g3 + hy
end
function K.prototype.GetRandomValidGridPosition(self)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	if #self.validGridPositions == 0 then
		return nil
	end
	return self.validGridPositions[RandomInt(0, #self.validGridPositions - 1) + 1]
end
function K.prototype.FindEntities(self, hz, hA)
	local hB = Entities:FindAllByClassname(hz)
	local b6 = {}
	for a0, h0 in ipairs(hB) do
		if h0:GetSpawnGroupHandle() == self.spawnGroup and o(h0:GetName(), hA) then
			b6[#b6 + 1] = h0
		end
	end
	return b6
end
function K.prototype.FindInfoTargets(self, hA)
	local hB = Entities:FindAllByClassname("info_target")
	local b6 = {}
	for a0, h0 in ipairs(hB) do
		if h0:GetSpawnGroupHandle() == self.spawnGroup and o(h0:GetName(), hA) then
			b6[#b6 + 1] = h0
		end
	end
	return b6
end
function K.prototype.FindInfoTarget(self, hA)
	local hB = Entities:FindAllByClassname("info_target")
	for a0, h0 in ipairs(hB) do
		if h0:GetSpawnGroupHandle() == self.spawnGroup and o(h0:GetName(), hA) then
			return h0
		end
	end
end
function K.prototype.RemoveUnit(self, a1)
	if IsValid(a1) then
		if BehaviorTree ~= nil then
			BehaviorTree:UnregisterUnit(a1)
		end
		if PropertySystem ~= nil then
			PropertySystem:CleanupUnitProperties(a1)
		end
		if StateSystem ~= nil then
			StateSystem:CleanupUnitStates(a1)
		end
		a1:RemoveAllModifiers(0, false, true, false)
		a1:ForceKill(false)
		a1:MakeIllusion()
		a1:AddNoDraw()
		a1:CallAbilityDestroy()
		UTIL_Remove(a1)
	end
end
function K.prototype.CreateClientItemPickupParticle(self, aK, aH)
	local hC =
		ParticleManager:CreateParticleForce("particles/generic_gameplay/drop_item_pick.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(hC, 0, aK)
	ParticleManager:SetParticleControlEnt(hC, 1, aH, PATTACH_POINT_FOLLOW, "attach_hitloc", aH:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(hC)
end
function K.prototype.DropItemFromEnemy(self, a1, hD)
	local Y
	if self.guaranteedDrops ~= nil then
		for hE, hF in pairs(self.guaranteedDrops) do
			if hF > 0 then
				Y = hE
				self.guaranteedDrops[hE] = hF - 1
				if self.guaranteedDrops[hE] <= 0 then
					f(self.guaranteedDrops, hE)
				end
				break
			end
		end
	end
	local ae = hD:GetPlayerOwnerID()
	if Y == nil then
		if self.dropPool == nil then
			return
		end
		local hG = Privilege:GetPlayerDynamicValue("privilege_bless_009", ae, "FirstDropCount") or 0
		if hG < 1 and not RollPercentage(self.dropPool.dropChance + GetBreakDropChance(hD)) then
			return
		end
		Privilege:SetPlayerDynamicValue("privilege_bless_009", ae, "FirstDropCount", hG - 1)
		Y = self.dropPool.itemPool:Random(nil)
	end
	if Y == nil then
		return
	end
	local aA = a1:GetAbsOrigin()
	local aR = d(A, Y, aA)
	local hH = self.dropItems
	hH[#hH + 1] = aR
	local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
		aH:AddItemByName(Y)
		aR:dispose()
	end, nil, nil, Y)
	if aG ~= -1 then
		local hI = self.registeredInteracts
		hI[#hI + 1] = aG
	end
	Event:Fire("break_drop", { itemName = Y, drop_item = aR })
end
function K.prototype.CalculateDifficultyModifiers(self)
	local hJ = GameRules:GetCustomGameDifficulty()
	local hK = KeyValues.difficulty[tostring(hJ)]
	if hK == nil then
		print(("[DungeonRoom] 警告：难度配置 " .. tostring(hJ)) .. " 未找到")
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		return
	end
	local hL = toFiniteNumber(hK.HealthFactor, 1)
	local hM = toFiniteNumber(hK.DamageFactor, 1)
	local hN = DungeonManager:GetZoneIndex()
	if hN == 1 then
		hL = hL * toFiniteNumber(hK.Chapter1HealthFactor, 1)
		hM = hM * toFiniteNumber(hK.Chapter1DamageFactor, 1)
	elseif hN == 2 then
		hL = hL * toFiniteNumber(hK.Chapter2HealthFactor, 1)
		hM = hM * toFiniteNumber(hK.Chapter2DamageFactor, 1)
	elseif hN == 3 then
		hL = hL * toFiniteNumber(hK.Chapter3HealthFactor, 1)
		hM = hM * toFiniteNumber(hK.Chapter3DamageFactor, 1)
	end
	local hO = Game:GetPlayerCount()
	if hO == 2 then
		hL = hL * toFiniteNumber(hK.Player2HealthFactor, 1)
		hM = hM * toFiniteNumber(hK.Player2DamageFactor, 1)
	elseif hO == 3 then
		hL = hL * toFiniteNumber(hK.Player3HealthFactor, 1)
		hM = hM * toFiniteNumber(hK.Player3DamageFactor, 1)
	elseif hO >= 4 then
		hL = hL * toFiniteNumber(hK.Player4HealthFactor, 1)
		hM = hM * toFiniteNumber(hK.Player4DamageFactor, 1)
	end
	self.difficultyHealthAmplify = (hL - 1) * 100
	self.difficultyDamageAmplify = (hM - 1) * 100
	self.difficultyCooldownReduction = DIFFICULTY_COOLDOWN_REDUCTION[hJ] or 0
	self.difficultyBossGapAmplify = DIFFICULTY_BOSS_GAP_AMPLIFY[hJ] or 0
	print(
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
																	(
																		("[DungeonRoom " .. tostring(self.roomID))
																		.. "] 难度系数已计算 - 难度:"
																	) .. tostring(hJ)
																) .. " 玩家:"
															) .. tostring(hO)
														) .. " 血量:"
													) .. t(hL, 2)
												) .. "x("
											) .. t(self.difficultyHealthAmplify, 1)
										) .. "%) 伤害:"
									) .. t(hM, 2)
								) .. "x("
							) .. t(self.difficultyDamageAmplify, 1)
						) .. "%) 冷却缩减:"
					) .. tostring(self.difficultyCooldownReduction)
				) .. "% Boss间隔增幅:"
			) .. tostring(self.difficultyBossGapAmplify)
		) .. "%"
	)
end
function K.prototype.ApplyDifficultyModifiers(self, aw)
	local hL = self.spawnInfo.healthFactor or 1
	local hM = self.spawnInfo.damageFactor or 1
	local hP = DungeonManager:GetDifficultyKeyHealthFactor()
	local hQ = DungeonManager:GetDifficultyKeyDamageFactor()
	local hR = (1 + self.difficultyHealthAmplify / 100) * hL * hP
	local hS = (1 + self.difficultyDamageAmplify / 100) * hM * hQ
	local hT = (hR - 1) * 100
	local hU = (hS - 1) * 100
	print("ApplyDifficultyModifiers", hL, hM)
	if hT ~= 0 then
		aw:AddProperty(PropertyFunction.HEALTH_AMPLIFY, hT)
	end
	if hU ~= 0 then
		aw:AddProperty(PropertyFunction.ATTACK_AMPLIFY, hU)
	end
	DungeonManager:ApplyDifficultyKeyDebuffs(aw)
end
function K.prototype.DropPomReward(self, Q)
	local Y = DrawPool:Draw("pom_reward")
	if Y ~= nil then
		local aR = d(A, Y, Q)
		local hV = self.dropItems
		hV[#hV + 1] = aR
		local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
			aH:AddItemByName(Y)
			aR:dispose()
		end)
		if aG ~= -1 then
			local hW = self.registeredInteracts
			hW[#hW + 1] = aG
		end
	end
end
function K.prototype.GetRoomKey(self)
	return (tostring(self.zoneID) .. "-") .. tostring(self.roomID)
end
function K.prototype.GetRoomType(self)
	return self.roomType
end
function K.prototype.GetRewardType(self)
	return self.rewardType
end
function K.prototype.GetPosition(self)
	return Vector(self.position.x, self.position.y, self.position.z)
end
function K.prototype.GetEntrancePosition(self)
	return self.entrancePos + CalcDirection2D(self.position, self.entrancePos):__mul(100)
end
function K.prototype.IsCombatRoom(self)
	return self.roomType == RoomType.ENEMY
		or self.roomType == RoomType.ELITE
		or self.roomType == RoomType.MINI_BOSS
		or self.roomType == RoomType.BOSS
end
function K.prototype.IsBossRoom(self)
	return self.roomType == RoomType.BOSS
end
function K.prototype.GetBossName(self)
	return self.bossName
end
function K.prototype.IsSpawnComplete(self)
	return self.isSpawnComplete
end
function K.prototype.AddGuaranteedDropCount(self, Y, hX)
	local hY = self.guaranteedDrops[Y] or 0
	local hZ = hY + hX
	if hZ <= 0 then
		f(self.guaranteedDrops, Y)
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 移除必掉物品: ") .. Y)
	else
		self.guaranteedDrops[Y] = hZ
		print(
			(
				(
					(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 增加 ") .. Y) .. " 掉落次数: ")
					.. tostring(hY)
				) .. " -> "
			) .. tostring(hZ)
		)
	end
end
function K.prototype.IsCompleted(self)
	return self.isComplete
end
function K.prototype.IsCombatEnd(self)
	return self:IsCombatRoom() and self.isCombatEnd
end
function K.prototype.ClearGuaranteedDropItems(self)
	self.guaranteedDrops = {}
end
function K.prototype.GetExitInfo(self)
	return self.exitInfos
end
function K.prototype.GetTrapList(self)
	return self.dungeonTrap:GetTrapList()
end
function K.prototype.GetNpcs(self)
	return self.npcs
end
function K.prototype.GetShopItems(self)
	return self.shopItems
end
function K.prototype.GetSpawnGroup(self)
	return self.spawnGroup
end
function K.prototype.OnEntityKilled(self, h_)
	local i0 = EntIndexToHScript(h_.entindex_killed)
	if not IsValid(i0) then
		return
	end
	if self.secretRoomGate ~= nil and i0 == self.secretRoomGate then
		self.secretRoomGate = nil
		ArrayRemove(self.enemies, i0)
		if self.secretRoomDoorPosition ~= nil and self.secretRoomDoorDirection ~= nil then
			self:CreateSecretRoom(self.secretRoomDoorPosition, self.secretRoomDoorDirection)
		end
		return
	end
	if m(self.enemies, i0) then
		local hD = EntIndexToHScript(h_.entindex_attacker)
		if IsValid(hD) and hD:IsRealHero() then
			self.playerKilledEnemyCount = self.playerKilledEnemyCount + 1
		end
		self:DropPreviewRewardsFromEnemy(i0)
		ArrayRemove(self.enemies, i0)
		self.aliveEnemyCount = self.aliveEnemyCount - 1
		self.aliveEnemyCount = math.max(0, self.aliveEnemyCount)
		print(
			(
				(
					(
						(
							(("[DungeonRoom " .. tostring(self.roomID)) .. "] 敌人死亡，剩余=")
							.. tostring(self.aliveEnemyCount)
						) .. "，数组长度="
					) .. tostring(#self.enemies)
				) .. "，totalCount="
			) .. tostring(self.spawnInfo.totalCount)
		)
		if self.aliveEnemyCount <= 0 then
			if self.spawnInfo.totalCount > 0 then
				print(
					((("[DungeonRoom " .. tostring(self.roomID)) .. "] 还有") .. tostring(self.spawnInfo.totalCount))
						.. "只怪待刷新，创建新的一波"
				)
				self:CreateWaveEnemy()
				if self.timerID ~= nil then
					Timer:RestartTimer(self.timerID)
				end
			else
				print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 所有敌人已清除，生成宝箱")
				local Q = GetGroundPosition(i0:GetAbsOrigin(), i0)
				if not GridNav:IsValidPosition(Q) then
					Q = self:GetNearestValidGridPosition(Q) or Q
				end
				self:FinishCombat(Q)
			end
		end
	end
	if m(self.breakables, i0) then
		local hD = EntIndexToHScript(h_.entindex_attacker)
		self:DropItemFromEnemy(i0, hD)
		return
	end
end
return u