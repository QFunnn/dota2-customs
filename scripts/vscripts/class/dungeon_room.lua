--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
local i = b.__TS__ArrayUnshift
local j = b.__TS__ArrayMap
local k = b.__TS__ArrayFilter
local l = b.__TS__ArraySlice
local m = b.__TS__StringTrim
local n = b.__TS__ObjectAssign
local o = b.__TS__ArrayIncludes
local p = b.__TS__StringEndsWith
local q = b.Set
local r = b.__TS__StringStartsWith
local s = b.__TS__ArrayFind
local t = b.__TS__ArrayFrom
local u = b.__TS__NumberToFixed
local v = {}
local w = require("class.client_item")
local x = w.ClientItem
local y = require("framework.native_gridnav_obstruction")
local z = y.NativeGridNavObstruction
local A = require("data.dungeon_gridnav.reader")
local B = A.gridNavReader
local C = require("class.dungeon_trap")
local D = C.DungeonTrap
local E = require("class.drop_item")
local F = E.DropItem
local G = require("class.shop_item")
local H = G.ShopItem
local I = require("class.weight_pool")
local J = I.CWeightPool
local K = {
	[RoomType.BOSS] = "particles/generic_gameplay/rune/rune_boss.vpcf",
	[RoomType.SHOP] = "particles/generic_gameplay/rune/rune_store.vpcf",
	[RoomType.TAVERN] = "particles/generic_gameplay/rune/rune_tavern.vpcf",
	[RoomType.STAIR] = "particles/generic_gameplay/rune/rune_stair_exit.vpcf",
	[RoomType.INVALID] = "particles/generic_gameplay/rune/rune_stair_exit.vpcf",
}
local L = {
	WishingPool = "particles/generic_gameplay/rune/wishing_pool_exit.vpcf",
	RegenWell = "particles/generic_gameplay/rune/regen_well_exit.vpcf",
	Book = "particles/generic_gameplay/rune/book_exit.vpcf",
	Smithy = "particles/generic_gameplay/rune/smithy_exit.vpcf",
}
local M = "TravelingMerchant"
local N = 320
local O = {
	[RoomRewardType.BOON] = "particles/generic_gameplay/rune/rune_blessings.vpcf",
	[RoomRewardType.DOUBLE_BOON] = "particles/generic_gameplay/rune/rune_blessings.vpcf",
	[RoomRewardType.HERO_UPGRADE] = "particles/generic_gameplay/rune/rune_experience.vpcf",
	[RoomRewardType.POM] = "particles/generic_gameplay/rune/rune_property.vpcf",
	[RoomRewardType.GOLD] = "particles/generic_gameplay/rune/rune_bounty_first.vpcf",
	[RoomRewardType.TREASURE] = "particles/generic_gameplay/rune/rune_treasure.vpcf",
}
v.DungeonRoom = c()
local P = v.DungeonRoom
P.name = "DungeonRoom"
function P.prototype.____constructor(self, Q, R, S, T, U, V, W, X, Y, Z, _, a0)
	self.validGridPositions = {}
	self.enemySpawnGatePositions = {}
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
	self.difficultyBossDamageAmplify = 0
	self.wishingPoolCount = 1
	self.shopRefreshCount = 0
	self.isSecretRoomCreated = false
	self.zoneID = Q
	self.terrainThemeKey = X
	self.roomID = R
	self.mapName = S
	self.rewardType = U
	self.roomType = T
	self.position = V
	self.bossName = Y
	self.shopRarityPoolName = _ or ""
	self.specialKind = a0
	self.spawnInfo = self:CreateSpawnInfo(W, X)
	self.guaranteedDrops = {}
	self:CalculateDifficultyModifiers()
	if Z ~= nil then
		local a1 = d(J)
		if Z.ItemList ~= nil then
			for a2, a3 in pairs(Z.ItemList) do
				a1:Add(tostring(a2), toFiniteNumber(a3))
			end
		end
		self.dropPool = { dropChance = toFiniteNumber(Z.DropChance), itemPool = a1 }
	end
	self.spawnGroup = DOTA_SpawnMapAtPosition(S, V, true, function(a4)
		if self.isDispose then
			UnloadSpawnGroupByHandle(a4)
			return
		end
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "-") .. W) .. "] onReadyToSpawn")
		ManuallyTriggerSpawnGroupCompletion(a4)
	end, function()
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "-") .. W) .. "] onSpawnComplete")
		if self.isDispose then
			return
		end
		local a5 = d(z, self.mapName, self.position, self:GetNativeNavigationProtectedAreas(self.spawnGroup))
		self.nativeNavigation = a5
		a5:Start(function()
			if not self.isDispose and self.nativeNavigation == a5 then
				self.isSpawnComplete = true
			end
		end)
	end, nil)
	self.dungeonTrap = d(D, {
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
		removeUnit = function(a6, a7)
			return self:RemoveUnit(a7)
		end,
	})
end
function P.prototype.RollShopRarity(self)
	if self.shopRarityPoolName == nil or self.shopRarityPoolName == "" then
		return 1
	end
	local a8 = DrawPool:Draw(self.shopRarityPoolName)
	if a8 == nil then
		return 1
	end
	local a9 = 0
	Game:EachPlayer(function(a6, aa)
		a9 = a9 + GetShopItemRarity(aa) + GetArtifactItemRarity(aa)
	end)
	local ab = math.floor(a9 / 100)
	if math.random(1, 100) <= a9 % 100 then
		ab = ab + 1
	end
	local ac = toFiniteNumber(a8, 1) + ab
	if ac < 1 then
		return 1
	end
	if ac > 5 then
		return 5
	end
	return ac
end
function P.prototype.dispose(self)
	if self.isDispose then
		return
	end
	self.isDispose = true
	local ad = self.nativeNavigation
	if ad ~= nil then
		ad:Dispose()
	end
	self.nativeNavigation = nil
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
	e(self.breakables, function(a6, ae)
		self:RemoveUnit(ae)
	end)
	e(self.npcs, function(a6, ae)
		self:RemoveUnit(ae)
	end)
	e(self.enemies, function(a6, ae)
		self:RemoveUnit(ae)
	end)
	e(self.simulateEnemies, function(a6, ae)
		ae:dispose()
	end)
	e(self.items, function(a6, ae)
		if IsValid(ae) then
			local af = ae:GetContainedItem()
			if IsValid(af) then
				UTIL_Remove(af)
			end
			UTIL_Remove(ae)
		end
	end)
	e(self.dropItems, function(a6, ae)
		ae:dispose()
	end)
	e(self.clientItems, function(a6, ae)
		ae:dispose()
	end)
	e(self.shopItems, function(a6, ae)
		ae:dispose()
	end)
	for a6, ag in ipairs(self.exitInfos) do
		if ag.rewardParticleID ~= nil then
			ParticleManager:DestroyParticle(ag.rewardParticleID, true)
			ParticleManager:ReleaseParticleIndex(ag.rewardParticleID)
		end
		if ag.eliteParticleID ~= nil then
			ParticleManager:DestroyParticle(ag.eliteParticleID, true)
			ParticleManager:ReleaseParticleIndex(ag.eliteParticleID)
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
		local ah = 0
		while ah < #self.registeredInteracts do
			Interaction:UnregisterInteractable(self.registeredInteracts[ah + 1])
			ah = ah + 1
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
	self:RemovePrefabNavigationUnits()
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
function P.prototype.SetRewardType(self, U)
	self.rewardType = U
end
function P.prototype.SetSpecialKind(self, a0)
	self.specialKind = a0
end
function P.prototype.Prepare(self)
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
	if self.specialKind == M and self.roomType == RoomType.STAIR then
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
function P.prototype.InitializePreviewRoomRewards(self)
	self.previewRewardSlots = {}
	self.enemyPreviewRewards = {}
	self.previewRewardAssignedEnemyCount = 0
	local ai = self:IsBossRoom() and 1 or math.max(1, self.spawnInfo.totalCount)
	do
		local ah = 0
		while ah < ai do
			local aj = self.previewRewardSlots
			aj[#aj + 1] = {}
			ah = ah + 1
		end
	end
	local ak = 0
	Game:EachPlayer(function(a6, al)
		local am = CommonService:GetPlayerServiceNetTable(al, "player_room_rewards_preview")
		local an = am and am[self.roomID]
		if an == nil then
			return
		end
		if toFiniteNumber(an.receive_times, 0) > 0 then
			return
		end
		local ao = an.rewards
		if ao == nil or #ao <= 0 then
			return
		end
		do
			local ah = 0
			while ah < #ao do
				do
					local ap = ao[ah + 1]
					local aq = toFiniteNumber(ap.item_id, 0)
					local ar = toFiniteNumber(ap.amounts, 0)
					if aq <= 0 or ar <= 0 then
						goto as
					end
					local a2 = self:ResolvePreviewRewardItemName(aq)
					if a2 == nil then
						print(
							((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励 item_id=") .. tostring(aq))
								.. " 未找到对应 itemName，已跳过"
						)
						goto as
					end
					local at = RandomInt(0, ai - 1)
					local au = self.previewRewardSlots[at + 1]
					au[#au + 1] = { playerID = al, itemID = aq, amounts = ar, itemName = a2 }
					ak = ak + 1
				end
				::as::
				ah = ah + 1
			end
		end
	end)
	if ak > 0 then
		print(
			(
				((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励已预分配到 ") .. tostring(ai))
				.. " 个怪物槽位，奖励条目数="
			) .. tostring(ak)
		)
	end
end
function P.prototype.ResolvePreviewRewardItemName(self, aq)
	if aq <= 0 then
		return nil
	end
	local av = self.itemNameByItemID[aq]
	if av ~= nil then
		return av
	end
	for a2, aw in pairs(KeyValues.items) do
		local ax = toFiniteNumber
		local ay = aw.ItemID
		if ay == nil then
			ay = aw.item_id
		end
		local az = ay
		if az == nil then
			az = aw.id
		end
		local aA = az
		if aA == nil then
			aA = aw.ID
		end
		local aB = aA
		if aB == nil then
			aB = aw.ServiceItemID
		end
		local aC = ax(aB, -1)
		if aC == aq then
			self.itemNameByItemID[aq] = a2
			return a2
		end
	end
	if KeyValues.items.item_health_potion_1 ~= nil then
		self.itemNameByItemID[aq] = "item_health_potion_1"
		print(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励 item_id=") .. tostring(aq))
				.. " 未找到精确映射，使用调试占位物 item_health_potion_1"
		)
		return "item_health_potion_1"
	end
	return nil
end
function P.prototype.AssignPreviewRewardsToEnemy(self, aD)
	local aE = self.previewRewardSlots[self.previewRewardAssignedEnemyCount + 1] or {}
	if #aE > 0 then
		local aF = aD:GetEntityIndex()
		self.enemyPreviewRewards[aF] = {}
		do
			local ah = 0
			while ah < #aE do
				local aG = self.enemyPreviewRewards[aF]
				aG[#aG + 1] = aE[ah + 1]
				ah = ah + 1
			end
		end
		print(
			(
				(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 怪物 ") .. aD:GetUnitName()) .. " 分配到 ")
				.. tostring(#aE)
			) .. " 条预览奖励"
		)
	end
	self.previewRewardAssignedEnemyCount = self.previewRewardAssignedEnemyCount + 1
end
function P.prototype.DropPreviewRewardsFromEnemy(self, a7)
	local aF = a7:GetEntityIndex()
	local ao = self.enemyPreviewRewards[aF]
	if ao == nil or #ao <= 0 then
		return
	end
	f(self.enemyPreviewRewards, aF)
	local aH = GetGroundPosition(a7:GetAbsOrigin(), a7)
	Interaction:BeginSyncBatch()
	do
		local ah = 0
		while ah < #ao do
			do
				local ap = ao[ah + 1]
				if KeyValues.items[ap.itemName] == nil then
					goto aI
				end
				self:AddDroppedPreviewReward(ap.playerID, ap.itemID, ap.amounts)
				local aJ = d(x, ap.playerID, ap.itemID, aH)
				local aK = self.clientItems
				aK[#aK + 1] = aJ
				local aL = { clientItem = aJ, reward = ap }
				local aM = self.previewRewardDrops
				aM[#aM + 1] = aL
				local aN = Interaction:RegisterInteract(aJ.entity, InteractType.Consumables, 200, function(a6, aO, al)
					return self:PickupPreviewRewardDrop(aO, aL, al)
				end, 1, ap.playerID)
				if aN ~= -1 then
					aL.interactIndex = aN
					local aP = self.registeredInteracts
					aP[#aP + 1] = aN
				end
				Match:AddPlayerRoundRewards(
					ap.playerID,
					{ { item_id = ap.itemID, amounts = ap.amounts, item_rarity = GetPropRarity(ap.itemID) } }
				)
			end
			::aI::
			ah = ah + 1
		end
	end
	Interaction:EndSyncBatch()
end
function P.prototype.PickupPreviewRewardDrop(self, aO, aL, al)
	if not IsValid(aO) or not aO:IsRealHero() or not aO:IsAlive() then
		return false
	end
	local aJ = aL.clientItem
	if aJ.isDispose or not aJ:IsLanded() or not IsValid(aJ.entity) then
		return false
	end
	local aQ = al or aO:GetPlayerOwnerID()
	if aQ ~= aL.reward.playerID then
		return false
	end
	local aR = aJ:GetLandedPosition()
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
										.. tostring(aQ)
									) .. " owner="
								) .. tostring(aL.reward.playerID)
							) .. " item_id="
						) .. tostring(aL.reward.itemID)
					) .. " item_name="
				) .. aL.reward.itemName
			) .. " amounts="
		) .. tostring(aL.reward.amounts)
	)
	CommonService:SendReceiveRewards(aQ, { { item_id = aL.reward.itemID, amounts = aL.reward.amounts } })
	Event:Fire("client_item_pickup", { playerID = aQ, item_id = aL.reward.itemID })
	self:CreateClientItemPickupParticle(aR, aO)
	if aL.interactIndex ~= nil then
		Interaction:UnregisterInteractable(aL.interactIndex)
		ArrayRemove(self.registeredInteracts, aL.interactIndex)
		aL.interactIndex = nil
	end
	ArrayRemove(self.previewRewardDrops, aL)
	ArrayRemove(self.clientItems, aJ)
	aJ:dispose()
	return true
end
function P.prototype.TryAutoPickupPreviewReward(self, aO)
	if not IsValid(aO) or not aO:IsRealHero() or not aO:IsAlive() then
		return false
	end
	local aQ = aO:GetPlayerOwnerID()
	local aS = aO:GetAbsOrigin()
	local aT
	local aU = 200
	do
		local ah = 0
		while ah < #self.previewRewardDrops do
			do
				local aL = self.previewRewardDrops[ah + 1]
				if aL == nil then
					goto aV
				end
				local aJ = aL.clientItem
				if aL.reward.playerID ~= aQ or aJ.isDispose or not aJ:IsLanded() or not IsValid(aJ.entity) then
					goto aV
				end
				local aW = aJ.entity:GetAbsOrigin()
				local aX = (aS - aW):Length2D()
				if aX <= aU then
					aU = aX
					aT = aL
				end
			end
			::aV::
			ah = ah + 1
		end
	end
	if aT == nil then
		return false
	end
	return self:PickupPreviewRewardDrop(aO, aT, aQ)
end
function P.prototype.CanAutoPickupDropItem(self, aY, aZ)
	local a_ = aZ
	if not a_ then
		local b0 = KeyValues.items[aY.itemName]
		if b0 ~= nil then
			b0 = b0.AutoPickUp
		end
		a_ = b0 == 1
	end
	return a_
end
function P.prototype.RegisterDropItemForAutoPickup(self, aY, b1)
	local b2 = self.dropItems
	b2[#b2 + 1] = aY
	if b1 ~= -1 then
		local b3 = self.registeredInteracts
		b3[#b3 + 1] = b1
	end
end
function P.prototype.UnregisterDropItemForAutoPickup(self, aY, b1)
	ArrayRemove(self.dropItems, aY)
	if b1 ~= -1 then
		ArrayRemove(self.registeredInteracts, b1)
	end
end
function P.prototype.TryAutoPickupDropItem(self, aO, aZ)
	if aZ == nil then
		aZ = false
	end
	if not IsValid(aO) or not aO:IsRealHero() or not aO:IsAlive() then
		return false
	end
	local aQ = aO:GetPlayerOwnerID()
	local aS = aO:GetAbsOrigin()
	local b4
	local b5
	local aU = 200
	do
		local ah = 0
		while ah < #self.dropItems do
			do
				local aY = self.dropItems[ah + 1]
				if
					aY == nil
					or aY.isDispose
					or not aY:IsLanded()
					or not IsValid(aY.entity)
					or not self:CanAutoPickupDropItem(aY, aZ)
				then
					goto b6
				end
				if aY.playerID ~= nil and aY.playerID ~= aQ then
					goto b6
				end
				local aF = aY:GetEntityIndex()
				if aF == -1 then
					goto b6
				end
				local aW = aY.entity:GetAbsOrigin()
				local aX = (aS - aW):Length2D()
				if aX <= aU then
					aU = aX
					b4 = aY
					b5 = aF
				end
			end
			::b6::
			ah = ah + 1
		end
	end
	if b4 == nil or b5 == nil then
		return false
	end
	local aR = b4.entity:GetAbsOrigin()
	local b7 = Interaction:ExecutePrimaryCallback(b5, aO, aQ)
	if not b7 then
		return false
	end
	self:CreateClientItemPickupParticle(aR, aO)
	Interaction:UnregisterInteractable(b5)
	ArrayRemove(self.registeredInteracts, b5)
	ArrayRemove(self.dropItems, b4)
	return true
end
function P.prototype.AddDroppedPreviewReward(self, al, aq, ar)
	if ar <= 0 then
		return
	end
	local b8 = tostring(al)
	local b9 = tostring(aq)
	local ba, bb = self.droppedPreviewRewards, b8
	if ba[bb] == nil then
		ba[bb] = {}
	end
	self.droppedPreviewRewards[b8][b9] = (self.droppedPreviewRewards[b8][b9] or 0) + ar
end
function P.prototype.GetDroppedPreviewRewards(self, al)
	local bc = self.droppedPreviewRewards[tostring(al)]
	if bc == nil then
		return {}
	end
	local bd = {}
	for aq, ar in pairs(bc) do
		bd[tostring(aq)] = toFiniteNumber(ar, 0)
	end
	return bd
end
function P.prototype.Activate(self)
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
		local be = DungeonManager:GetRoomIndex() + 1
		Game:EachPlayer(function(a6, al)
			Service:ReportClick(al, "dungeon", "reward_room|enter|room_" .. tostring(be))
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
				for ah, a7 in ipairs(self.enemies) do
					a7:RemoveModifierByName("modifier_sleep")
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
function P.prototype.Complete(self, bf)
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
	e(self.items, function(a6, ae)
		if IsValid(ae) then
			local af = ae:GetContainedItem()
			if IsValid(af) then
				UTIL_Remove(af)
			end
			UTIL_Remove(ae)
		end
	end)
	e(self.dropItems, function(a6, ae)
		ae:dispose()
	end)
	e(self.clientItems, function(a6, ae)
		ae:dispose()
	end)
	e(self.shopItems, function(a6, ae)
		print(ae.itemName, "dispose")
		ae:dispose()
	end)
	self.items = {}
	self.dropItems = {}
	self.clientItems = {}
	self.shopItems = {}
	do
		local ah = 0
		while ah < #self.registeredInteracts do
			Interaction:UnregisterInteractable(self.registeredInteracts[ah + 1])
			ah = ah + 1
		end
	end
	self.registeredInteracts = {}
	for a6, ag in ipairs(self.exitInfos) do
		if ag.rewardParticleID ~= nil then
			ParticleManager:DestroyParticle(ag.rewardParticleID, true)
			ParticleManager:ReleaseParticleIndex(ag.rewardParticleID)
		end
		if ag.eliteParticleID ~= nil then
			ParticleManager:DestroyParticle(ag.eliteParticleID, true)
			ParticleManager:ReleaseParticleIndex(ag.eliteParticleID)
		end
	end
	local bg = self.exitInfos[bf + 1]
	if bg ~= nil then
		print(
			(
				(
					(
						((("[DungeonRoom " .. tostring(self.roomID)) .. "] 玩家选择出口 ") .. tostring(bf))
						.. "，进入下个房间，房间奖励: "
					) .. tostring(bg.rewardType)
				) .. " special="
			) .. (bg.specialKind or "")
		)
		DungeonManager:SetSelectedNextRoomRoute(bg.rewardType, bg.specialKind)
	end
	Event:Fire("dungeon_room_complete", { room = self })
end
function P.prototype.LockGate(self)
	local bh = self:FindEntities("prop_dynamic", "prop_gate")
	for a6, bi in ipairs(bh) do
		local bj = bi:GetName()
		local bk = g(bj, "_")[1]
		if bk == self.entrancePrefix then
			bi:FireOutput("OnUser1", nil, nil, nil, 0)
		end
	end
end
function P.prototype.OpenGates(self)
	if self.gatesOpened then
		return
	end
	self.gatesOpened = true
	local bh = self:FindEntities("prop_dynamic", "prop_gate")
	print(
		(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] OpenGates - 找到 ") .. tostring(#bh))
			.. " 个门，出口数量: "
		) .. tostring(#self.exitInfos)
	)
	local bl = {}
	for a6, bi in ipairs(bh) do
		local bj = bi:GetName()
		local bk = g(bj, "_")[1]
		if not bl[bk] then
			bl[bk] = {}
		end
		local bm = bl[bk]
		bm[#bm + 1] = bi
	end
	do
		local ah = 0
		while ah < #self.exitInfos do
			do
				local ag = self.exitInfos[ah + 1]
				if ag == nil then
					goto bn
				end
				local bf = ah
				local bo = self:GetExitTooltip(ag)
				local bp = bl[ag.prefix]
				if bp == nil or #bp == 0 then
					print(
						((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 未找到前缀为 ") .. ag.prefix)
							.. " 的门"
					)
					goto bn
				end
				local bq = L[ag.specialKind or ""] or K[ag.roomType] or O[ag.rewardType]
				print(
					(
						(
							(
								(
									(((("[DungeonRoom " .. tostring(self.roomID)) .. "] ") .. tostring(bf)) .. " ")
									.. RoomType[ag.roomType]
								) .. " "
							) .. RoomRewardType[ag.rewardType]
						) .. " 创建粒子效果: "
					) .. tostring(bq)
				)
				if bq ~= nil and ag.rewardParticleID == nil then
					local br = bp[1]:GetAbsOrigin()
					local bs = ParticleManager:CreateParticleForce(bq, PATTACH_CUSTOMORIGIN, nil)
					ParticleManager:SetParticleControl(bs, 0, br)
					ag.rewardParticleID = bs
				end
				if ag.roomType == RoomType.ELITE and ag.eliteParticleID == nil then
					local br = bp[1]:GetAbsOrigin()
					local bt = ParticleManager:CreateParticleForce(
						"particles/generic_gameplay/rune/rune_elite.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(bt, 0, br)
					ag.eliteParticleID = bt
				end
				for a6, bi in ipairs(bp) do
					local bj = bi:GetName()
					bi:FireOutput("OnUser1", nil, nil, nil, 0)
					if self:IsFirstRoomRewardGuideEnabled() then
						self:ShowFirstRoomRewardGuide(bi:GetEntityIndex())
					end
					local aN = Interaction:RegisterInteract(bi, InteractType.Portal, 200, function(a6, aO)
						self:ClearFirstRoomRewardGuide()
						aO:AddNewModifier(
							aO,
							nil,
							"modifier_enter_gate",
							{ position = VectorToString(bi:GetAbsOrigin() + ag.direction * 600), duration = 1 }
						)
						DungeonManager:ShowLoadingScreen()
						if self:IsFirstRoomRewardGuideEnabled() then
							self:ShowFirstRoomRewardGuide(bi:GetEntityIndex())
						end
						aO:GameTimer(1, function()
							self:Complete(bf)
						end)
					end)
					Interaction:UpdateInteract(aN, { tooltip = bo })
					if aN ~= -1 then
						local bu = self.registeredInteracts
						bu[#bu + 1] = aN
					end
				end
			end
			::bn::
			ah = ah + 1
		end
	end
	Event:Fire("dungeon_room_open_gates", { room = self })
end
function P.prototype.CreateTreasure(self, V)
	if self:IsBossRoom() then
		self:SpawnBossCoinStacks(V)
		self:OpenGates()
		return
	end
	print("创建奖励:", self.roomID, RoomRewardType[self.rewardType])
	local a2
	repeat
		local bv = self.rewardType
		local bw = bv == RoomRewardType.POM
		if bw then
			a2 = "item_tome_of_prop"
			break
		end
		bw = bw or bv == RoomRewardType.BOON
		if bw then
			a2 = "item_boon_bless"
			break
		end
		bw = bw or bv == RoomRewardType.DOUBLE_BOON
		if bw then
			a2 = "item_boon_bless_double"
			break
		end
		bw = bw or bv == RoomRewardType.HERO_UPGRADE
		if bw then
			a2 = "item_hammer_weapon"
			break
		end
		bw = bw or bv == RoomRewardType.TREASURE
		if bw then
			a2 = "item_treasure"
			break
		end
		bw = bw or bv == RoomRewardType.GOLD
		do
			a2 = "item_gold_pouch"
			break
		end
	until true
	if a2 == nil then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 警告：无法获取奖励物品")
		self:OpenGates()
		return
	end
	local aY = d(F, a2, V)
	local bx = aY.particleIDs
	bx[#bx + 1] = ParticleManager:CreateParticleForce(
		"particles/generic_gameplay/rune/rube_drop_items_fx.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aY.entity
	)
	local by = self.dropItems
	by[#by + 1] = aY
	if self:IsFirstRoomRewardGuideEnabled() then
		self:ShowFirstRoomRewardGuide(aY.entity:GetEntityIndex())
	end
	local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 150, function(a6, aO, al)
		if not aY:IsLanded() then
			return false
		end
		aO:AddItemByName(a2)
		if not DungeonManager:IsTutorial() then
			local be = DungeonManager:GetRoomIndex() + 1
			Service:ReportClick(al, "dungeon", "room_reward|pickup|room_" .. tostring(be))
		end
		if self.rewardType == RoomRewardType.BOON or self.rewardType == RoomRewardType.DOUBLE_BOON then
			local bz = self.rewardType == RoomRewardType.DOUBLE_BOON
			Game:EachPlayer(function(a6, bA)
				Event:Fire("bless_room_reward_claimed", { playerID = bA, isDouble = bz })
			end)
		end
		aY:dispose()
		self:ClearFirstRoomRewardGuide()
		self:OpenGates()
	end, nil, nil, a2)
	if aN ~= -1 then
		local bB = self.registeredInteracts
		bB[#bB + 1] = aN
	end
end
function P.prototype.IsFirstRoomRewardGuideEnabled(self)
	return GameRules:GetCustomGameDifficulty() <= 2 and self.roomID == 0
end
function P.prototype.ShowFirstRoomRewardGuide(self, bC)
	Game:EachPlayer(function(a6, al)
		local aO = PlayerResource:GetSelectedHeroEntity(al)
		if IsValid(aO) and aO:IsRealHero() then
			aO:AddNewModifier(aO, nil, "modifier_first_dungeon_guide", { targetEntIndex = bC })
		end
	end)
end
function P.prototype.ClearFirstRoomRewardGuide(self)
	if not self:IsFirstRoomRewardGuideEnabled() then
		return
	end
	Game:EachPlayer(function(a6, al)
		local aO = PlayerResource:GetSelectedHeroEntity(al)
		if IsValid(aO) then
			aO:RemoveAllModifiersOfName("modifier_first_dungeon_guide")
		end
	end)
end
function P.prototype.SpawnBossCoinStacks(self, bD)
	local bE = RandomInt(8, 15)
	local bF = 480
	local bG = 10
	Interaction:BeginSyncBatch()
	do
		local ah = 0
		while ah < bE do
			local bH
			do
				local bI = 0
				while bI < bG do
					local bJ = RandomFloat(0, 360)
					local aX = RandomFloat(0, bF)
					local bK = Vector(math.cos(bJ * math.pi / 180) * aX, math.sin(bJ * math.pi / 180) * aX, 0)
					local bL = bD:__add(bK)
					if GridNav:IsValidPosition(bL) then
						bH = bL
						break
					end
					bI = bI + 1
				end
			end
			if bH == nil then
				bH = self:GetNearestValidGridPosition(bD) or bD
			end
			local aY = d(F, "item_coin_stack", bH)
			local bM = self.dropItems
			bM[#bM + 1] = aY
			local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
				aO:AddItemByName("item_coin_stack")
				aY:dispose()
			end, nil, nil, "item_coin_stack")
			if aN ~= -1 then
				local bN = self.registeredInteracts
				bN[#bN + 1] = aN
			end
			ah = ah + 1
		end
	end
	Interaction:EndSyncBatch()
	print(((("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss房掉落 ") .. tostring(bE)) .. " 个金币堆")
end
function P.prototype.NormalizeGridPhaseFromCenter(self, bK)
	local bO = GRID_SIZE * 0.5
	local bP = math.abs(bK % GRID_SIZE)
	local bQ = math.min(bP, math.abs(GRID_SIZE - bP))
	local bR = math.abs(bP - bO)
	return bR < bQ and bO or 0
end
function P.prototype.ResolveGridAnalysisOrigin(self)
	local bp = self:FindEntities("prop_dynamic", "prop_gate")
	if #bp <= 0 then
		return self.position
	end
	local bS = 0
	local bT = 0
	local bU = 0
	local bO = GRID_SIZE * 0.5
	do
		local ah = 0
		while ah < #bp do
			local bi = bp[ah + 1]
			local bV = bi:GetAbsOrigin()
			local bW = bV.x - self.position.x
			local bX = bV.y - self.position.y
			local bY = bV.x
			local bZ = bV.y
			if math.abs(bW) > math.abs(bX) then
				bY = bV.x - (bW > 0 and bO or -bO)
			else
				bZ = bV.y - (bX > 0 and bO or -bO)
			end
			if self:NormalizeGridPhaseFromCenter(bY - self.position.x) >= bO then
				bT = bT + 1
			end
			if self:NormalizeGridPhaseFromCenter(bZ - self.position.y) >= bO then
				bU = bU + 1
			end
			bS = bS + 1
			ah = ah + 1
		end
	end
	local b_ = bT * 2 > bS and bO or 0
	local c0 = bU * 2 > bS and bO or 0
	return Vector(self.position.x + b_, self.position.y + c0, self.position.z)
end
function P.prototype.IsInsideEnemySpawnGates(self, V)
	local c1 = 32
	for a6, bi in ipairs(self.enemySpawnGatePositions) do
		local bW = bi.x - self.position.x
		local bX = bi.y - self.position.y
		if math.abs(bW) > math.abs(bX) then
			if bW > 0 and V.x >= bi.x - c1 then
				return false
			end
			if bW < 0 and V.x <= bi.x + c1 then
				return false
			end
		else
			if bX > 0 and V.y >= bi.y - c1 then
				return false
			end
			if bX < 0 and V.y <= bi.y + c1 then
				return false
			end
		end
	end
	return true
end
function P.prototype.IsCurrentRoomSpawnCell(self, V)
	if self.isDispose or not self:IsInsideEnemySpawnGates(V) then
		return false
	end
	local c2 = B:GetCode(self.mapName, V, self.position)
	return c2 == 1 and GridNav:IsValidPosition(V)
end
function P.prototype.GetEnemySpawnReference(self)
	local c3
	if self.isActived then
		Game:EachPlayer(function(a6, al)
			local aO = PlayerResource:GetSelectedHeroEntity(al)
			if c3 == nil and IsValid(aO) and aO:IsAlive() and self:IsCurrentRoomSpawnCell(aO:GetAbsOrigin()) then
				c3 = aO:GetAbsOrigin()
			end
		end)
	end
	if c3 ~= nil then
		return c3
	end
	if self:IsCurrentRoomSpawnCell(self.position) then
		return self.position
	end
	local aU = math.huge
	for a6, bL in ipairs(self.validGridPositions) do
		do
			if not self:IsCurrentRoomSpawnCell(bL) then
				goto c4
			end
			local aX = CalcDistance(bL, self.position)
			if aX < aU then
				aU = aX
				c3 = bL
			end
		end
		::c4::
	end
	return c3
end
function P.prototype.IsEnemySpawnPositionValid(self, V, c3)
	return c3 ~= nil and self:IsCurrentRoomSpawnCell(V) and GridNav:CanFindPath(c3, V)
end
function P.prototype.PlaceEnemyAtValidPosition(self, aD, c5)
	local c3 = self:GetEnemySpawnReference()
	local c6 = h({ unpack(self.validGridPositions) }, function(a6, c7, c8)
		return CalcDistance(c7, c5) - CalcDistance(c8, c5)
	end)
	i(c6, c5)
	local c9
	local ca = 0
	for a6, bL in ipairs(c6) do
		do
			if not self:IsEnemySpawnPositionValid(bL, c3) then
				goto cb
			end
			if c9 == nil then
				c9 = bL
			end
			FindClearSpaceForUnit(aD, bL, true)
			if self:IsEnemySpawnPositionValid(aD:GetAbsOrigin(), c3) then
				return true
			end
			ca = ca + 1
			if ca >= 8 then
				break
			end
		end
		::cb::
	end
	if c9 == nil or not self:IsEnemySpawnPositionValid(c9, c3) then
		return false
	end
	local cc = aD:GetAbsOrigin()
	aD:SetAbsOrigin(GetGroundPosition(c9, aD))
	local cd = self:IsEnemySpawnPositionValid(aD:GetAbsOrigin(), c3)
	print(
		(
			(
				(
					(
						(
							(
								(
									(
										(("[DungeonRoom " .. tostring(self.roomID)) .. "] 修正刷怪落点 map=")
										.. self.mapName
									) .. " unit="
								) .. aD:GetUnitName()
							) .. " from="
						) .. VectorToString(cc)
					) .. " to="
				) .. VectorToString(aD:GetAbsOrigin())
			) .. " valid="
		) .. tostring(cd)
	)
	return cd
end
function P.prototype.AnalyzeGrid(self)
	local bD = self:ResolveGridAnalysisOrigin()
	local ce = 5
	local cf = 20
	self.validGridPositions = {}
	self.enemySpawnGatePositions = j(self:FindEntities("prop_dynamic", "prop_gate"), function(a6, bi)
		return bi:GetAbsOrigin()
	end)
	local cg, ch = B:GetMap(self.mapName)
	if cg == nil then
		print(
			(
				((("[DungeonRoom " .. tostring(self.roomID)) .. "] 无有效刷怪模板 map=") .. self.mapName)
				.. " reason="
			) .. tostring(ch)
		)
		return
	end
	local ci = bD.y - GRID_SIZE * 2
	do
		local cj = 0
		while cj <= cf do
			local ck = false
			do
				local cl = -cj
				while cl <= cj do
					do
						local cm = -cj
						while cm <= cj do
							if math.abs(cl) == cj or math.abs(cm) == cj then
								local cn = Vector(bD.x + cl * GRID_SIZE, bD.y + cm * GRID_SIZE, bD.z)
								if cn.y > ci and self:IsCurrentRoomSpawnCell(cn) then
									ck = true
									local co = self.validGridPositions
									co[#co + 1] = cn
								else
								end
							end
							cm = cm + 1
						end
					end
					cl = cl + 1
				end
			end
			if not ck and cj >= ce then
				break
			end
			cj = cj + 1
		end
	end
	local c3 = self:GetEnemySpawnReference()
	self.validGridPositions = k(self.validGridPositions, function(a6, V)
		return self:IsEnemySpawnPositionValid(V, c3)
	end)
end
function P.prototype.CreateBreakable(self)
	if #self.validGridPositions == 0 then
		return
	end
	local cp = RandomInt(0, 3)
	local cq = math.floor(#self.validGridPositions / 20)
	local cr = cp + cq
	if cr == 0 then
		return
	end
	local bD = self.position
	local cs = h({ unpack(self.validGridPositions) }, function(a6, c7, c8)
		local ct = c7:__sub(bD):Length2D()
		local cu = c8:__sub(bD):Length2D()
		return cu - ct
	end)
	local cv = l(cs, 0, math.ceil(#cs * 0.7))
	local cw = {}
	do
		local ah = 0
		while ah < #cv do
			local cx = cv[ah + 1]
			if not self:IsTravelingMerchantNear(cx, GRID_SIZE * 1.5) then
				cw[#cw + 1] = cx
			end
			ah = ah + 1
		end
	end
	local cy = #cw > 0 and cw or cv
	do
		local ah = #cy - 1
		while ah > 0 do
			local cz = RandomInt(0, ah)
			local cA = { cy[cz + 1], cy[ah + 1] }
			cy[ah + 1] = cA[1]
			cy[cz + 1] = cA[2]
			ah = ah - 1
		end
	end
	local cB = math.max(1, math.floor(#cy / (cr + 1)))
	do
		local ah = 0
		while ah < cr do
			local cC = RandomInt(2, 4)
			local cD = ah * cB
			if cD >= #cy then
				break
			end
			local cE = cy[cD + 1]
			do
				local cz = 0
				while cz < cC do
					local bJ = RandomFloat(0, 360)
					local aX = RandomFloat(50, 150)
					local bK = Vector(math.cos(bJ * math.pi / 180) * aX, math.sin(bJ * math.pi / 180) * aX, 0)
					local cF = cE:__add(bK)
					CreateUnitByNameAsync(
						DrawPool:Draw(self.terrainThemeKey ~= "ice" and "breakable" or "breakable_ice")
							or "npc_dungeon_crate_1",
						cF,
						true,
						nil,
						nil,
						DOTA_TEAM_BADGUYS,
						function(cG)
							if self.isDispose then
								cG:SafeRemoveUnit()
							else
								cG:SetForwardVector(RandomVector(1))
								cG:SetModelScale(RandomFloat(0.8, 1))
								local cH = self.breakables
								cH[#cH + 1] = cG
								self.occupiedPositions[cD] = true
							end
						end
					)
					cz = cz + 1
				end
			end
			ah = ah + 1
		end
	end
end
function P.prototype.CreateSpawnInfo(self, cI, X)
	if cI == "" or cI == nil then
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
			enemyPool = d(J),
		}
	end
	local cJ = KeyValues.spawn_info
	local cK = KeyValues["spawn_info_" .. X]
	local cL
	if cK ~= nil then
		cL = cK[cI]
	else
		cL = nil
	end
	local cM = cL
	local cN
	if cJ ~= nil then
		cN = cJ[cI]
	else
		cN = nil
	end
	local cO = cN
	if cM == nil and cO == nil then
		print(((("[DungeonRoom] 警告：刷怪配置 '" .. cI) .. "' 在默认和主题'") .. X) .. "'中均未找到")
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
			enemyPool = d(J),
		}
	end
	local function cP(a6, cQ)
		if cM ~= nil and cM[cQ] ~= nil then
			return cM[cQ]
		end
		if cO ~= nil and cO[cQ] ~= nil then
			return cO[cQ]
		end
		return nil
	end
	local cR = j(g(m(tostring(cP(nil, "EnemyCount"))), "|"), function(a6, ae)
		return toFiniteNumber(ae, 0)
	end)
	local cS = j(g(m(tostring(cP(nil, "CountPerRound"))), "|"), function(a6, ae)
		return toFiniteNumber(ae, 0)
	end)
	if cS[2] == nil then
		cS[2] = cS[1]
	end
	local cT = RollPercentage(toFiniteNumber(cP(nil, "CaptainRoomChance")))
	local cU = RollPercentage(toFiniteNumber(cP(nil, "EliteRoomChance")))
	local cV = cU and toFiniteNumber(cP(nil, "OverrideEliteChance")) or toFiniteNumber(cP(nil, "EliteChance"))
	local cW = cP(nil, "EnemyList")
	local cX = d(J)
	if cW ~= nil then
		for cY, ae in pairs(cW) do
			cX:Set(cY, toFiniteNumber(ae, 0))
		end
	end
	local cZ = RandomInt(cR[1], cR[2])
	local c_ = RollPercentage(toFiniteNumber(cP(nil, "DeployChance")))
	local d0 = toFiniteNumber(cP(nil, "SpawnInterval"))
	local d1
	if cT then
		d1 = cP(nil, "CaptainName")
	else
		d1 = ""
	end
	return {
		totalCount = cZ,
		countPerRound = cS,
		isDeploy = c_,
		eliteChance = cV,
		spawnInterval = d0,
		captainName = d1,
		bossName = cP(nil, "BossName"),
		healthFactor = toFiniteNumber(cP(nil, "HealthFactor"), 1),
		damageFactor = toFiniteNumber(cP(nil, "DamageFactor"), 1),
		enemyPool = cX,
	}
end
function P.prototype.CreateEnemyForTutorial(self, d2, d3, d4, d5)
	local d6 = {}
	local d7 = self:GetGridsAroundPosition(d4, 300)
	if #d7 < d3 then
		d7 = self:GetGridsAroundPosition(d4, 600)
	end
	if #d7 < d3 then
		d7 = self:GetGridsAroundPosition(d4, 1200)
	end
	if #d7 == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 没有可用生成位置")
		return {}
	end
	do
		local ah = #d7 - 1
		while ah > 0 do
			local cz = RandomInt(0, ah)
			local d8 = { d7[cz + 1], d7[ah + 1] }
			d7[ah + 1] = d8[1]
			d7[cz + 1] = d8[2]
			ah = ah - 1
		end
	end
	do
		local ah = 0
		while ah < d3 and ah < #d7 do
			do
				local cF = d7[ah + 1]
				if not self:IsEnemySpawnPositionValid(cF, self:GetEnemySpawnReference()) then
					goto d9
				end
				if d2 ~= nil and KeyValues.units[d2] ~= nil then
					if SimulateUnitManager:IsSimulateUnit(d2) then
						local aD = SimulateUnitManager:CreateCustomUnit(d2, cF, DOTA_TEAM_BADGUYS)
						aD:SetForwardVector(RandomVector(1))
						local da = self.simulateEnemies
						da[#da + 1] = aD
						self:AssignPreviewRewardsToEnemy(aD)
					else
						local aD = CreateUnitByName(d2, cF, true, nil, nil, DOTA_TEAM_BADGUYS)
						if not IsValid(aD) then
							goto d9
						end
						if not self:PlaceEnemyAtValidPosition(aD, cF) then
							aD:SafeRemoveUnit()
							goto d9
						end
						self:ApplyDifficultyModifiers(aD)
						d6[#d6 + 1] = aD
						if d5 then
							aD:AddNewModifier(aD, nil, "modifier_elite", {})
						end
					end
				else
					print(
						((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️警告：单位 '") .. d2)
							.. "' 无法创建（可能未在KV中定义）"
					)
				end
			end
			::d9::
			ah = ah + 1
		end
	end
	return d6
end
function P.prototype.CreateWaveEnemy(self)
	local db =
		math.min(self.spawnInfo.totalCount, RandomInt(self.spawnInfo.countPerRound[1], self.spawnInfo.countPerRound[2]))
	if db <= 0 then
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
	local bD = self.position
	local d7
	if self.currentWave == 0 then
		d7 = self:GetAvailablePositionIndices(bD.y - 400, bD.y)
		if #d7 < db then
			d7 = self:GetAvailablePositionIndices()
		end
	else
		d7 = self:GetAvailablePositionIndices(bD.y, bD.y + 600)
		if #d7 < db then
			d7 = self:GetAvailablePositionIndices()
		end
	end
	if #d7 == 0 then
		print(
			(
				(
					(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 没有可用生成位置，跳过本波 ")
					.. tostring(db)
				) .. " 只怪，剩余待刷="
			) .. tostring(self.spawnInfo.totalCount)
		)
		local dc, dd = self.spawnInfo, "totalCount"
		dc[dd] = dc[dd] - db
		self.spawnInfo.totalCount = math.max(0, self.spawnInfo.totalCount)
		self:TryFinishCombatWhenNoEnemies(self.position)
		return
	end
	local de = math.min(db, #d7)
	local df, dg = self.spawnInfo, "totalCount"
	df[dg] = df[dg] - de
	if de < db then
		print(
			(
				(
					(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 可用生成位置不足，计划=")
					.. tostring(db)
				) .. "，实际尝试="
			) .. tostring(de)
		)
	end
	self.currentWave = self.currentWave + 1
	do
		local ah = #d7 - 1
		while ah > 0 do
			local cz = RandomInt(0, ah)
			local dh = { d7[cz + 1], d7[ah + 1] }
			d7[ah + 1] = dh[1]
			d7[cz + 1] = dh[2]
			ah = ah - 1
		end
	end
	local di = 0
	do
		local ah = 0
		while ah < de and ah < #d7 do
			do
				local dj = d7[ah + 1]
				local cF = self.validGridPositions[dj + 1]
				if not self:IsEnemySpawnPositionValid(cF, self:GetEnemySpawnReference()) then
					local dk, dl = self.spawnInfo, "totalCount"
					dk[dl] = dk[dl] + 1
					goto dm
				end
				local d2 = self.spawnInfo.enemyPool:Random()
				if d2 ~= nil and KeyValues.units[d2] ~= nil then
					local cV = self.spawnInfo.eliteChance
					local d5 = RollPercentage(cV)
					self.aliveEnemyCount = self.aliveEnemyCount + 1
					di = di + 1
					if SimulateUnitManager:IsSimulateUnit(d2) then
						local aD = SimulateUnitManager:CreateCustomUnit(d2, cF, DOTA_TEAM_BADGUYS)
						aD:SetForwardVector(RandomVector(1))
						local dn = self.simulateEnemies
						dn[#dn + 1] = aD
						self:AssignPreviewRewardsToEnemy(aD)
					else
						CreateUnitByNameAsync(d2, cF, true, nil, nil, DOTA_TEAM_BADGUYS, function(aD)
							if not IsValid(aD) then
								print(
									(
										(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 单位创建失败: ")
										.. d2
									) .. "，回退计数器"
								)
								self.aliveEnemyCount = self.aliveEnemyCount - 1
								self.aliveEnemyCount = math.max(0, self.aliveEnemyCount)
								return
							end
							if self.isDispose then
								aD:SafeRemoveUnit()
							else
								if not self:PlaceEnemyAtValidPosition(aD, cF) then
									print(
										(
											(
												(
													("[DungeonRoom " .. tostring(self.roomID))
													.. "] 无安全刷怪落点 map="
												) .. self.mapName
											) .. " unit="
										) .. d2
									)
									aD:SafeRemoveUnit()
									self.aliveEnemyCount = math.max(0, self.aliveEnemyCount - 1)
									self:TryFinishCombatWhenNoEnemies(self.position)
									return
								end
								aD:SetForwardVector(RandomVector(1))
								local dp = self.enemies
								dp[#dp + 1] = aD
								self:AssignPreviewRewardsToEnemy(aD)
								if not self.isActived then
									aD:AddNewModifier(aD, nil, "modifier_sleep", {})
								end
								self:ApplyDifficultyModifiers(aD)
								if d5 then
									aD:AddNewModifier(aD, nil, "modifier_elite", {})
								end
							end
						end)
					end
					self.occupiedPositions[dj] = true
				else
					print(
						((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️警告：单位 '") .. tostring(d2))
							.. "' 无法创建（可能未在KV中定义）"
					)
				end
			end
			::dm::
			ah = ah + 1
		end
	end
	if di <= 0 then
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
function P.prototype.TryFinishCombatWhenNoEnemies(self, V)
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
	local dq = GetGroundPosition(V, nil)
	if not GridNav:IsValidPosition(dq) then
		dq = self:GetNearestValidGridPosition(dq) or self.position
	end
	print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 无剩余有效怪物，执行战斗房兜底清场")
	self:FinishCombat(dq)
end
function P.prototype.FinishCombat(self, V)
	if self.isCombatEnd or self.isDispose then
		return
	end
	self.dungeonTrap:StopCombat()
	self:CreateTreasure(V)
	self:CreateInteractiveTravelingMerchant()
	self.isCombatEnd = true
	self:StopUnitManagerGuardTimer()
	Event:Fire("dungeon_room_clear", { room = self, position = V, trapOnlyClear = self.playerKilledEnemyCount == 0 })
end
function P.prototype.CreateBoss(self)
	if self.bossName == nil or self.bossName == "" then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss房缺少Boss名称配置")
		return
	end
	local Y = self.bossName
	if KeyValues.units[Y] == nil then
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 警告：Boss单位 '") .. Y) .. "' 未在KV中定义")
		return
	end
	local dr = self:FindInfoTarget("info_boss_spawn")
	local ds = dr and dr:GetAbsOrigin() or self.position
	local dt = self:IsEnemySpawnPositionValid(ds, self:GetEnemySpawnReference()) and ds
		or self:GetNearestValidGridPosition(ds)
	if dt == nil then
		print(
			(
				((("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss无安全刷怪点 map=") .. self.mapName)
				.. " unit="
			) .. Y
		)
		return
	end
	print(
		(
			(
				((((("[DungeonRoom " .. tostring(self.roomID)) .. "] 生成Boss: ") .. Y) .. " at (") .. tostring(dt.x))
				.. ", "
			) .. tostring(dt.y)
		) .. ")"
	)
	self.aliveEnemyCount = self.aliveEnemyCount + 1
	CreateUnitByNameAsync(Y, dt, true, nil, nil, DOTA_TEAM_BADGUYS, function(du)
		if not IsValid(du) then
			print(
				((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ Boss创建失败: ") .. Y)
					.. "，回退计数器"
			)
			self.aliveEnemyCount = self.aliveEnemyCount - 1
			self.aliveEnemyCount = math.max(0, self.aliveEnemyCount)
			return
		end
		if self.isDispose then
			du:SafeRemoveUnit()
		else
			if not self:PlaceEnemyAtValidPosition(du, dt) then
				du:SafeRemoveUnit()
				self.aliveEnemyCount = math.max(0, self.aliveEnemyCount - 1)
				print(
					(
						((("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss无安全落点 map=") .. self.mapName)
						.. " unit="
					) .. Y
				)
				return
			end
			du:SetForwardVector(vec3_bottom)
			local dv = KeyValues.units[Y]
			local dw = math.max(0.1, toFiniteNumber(dv.IntroDuration, 4))
			local dx = toFiniteNumber(dv.IntroFocusDistance, 520)
			local dy = toFiniteNumber(dv.IntroHeightOffset, 160)
			local dz = GameRules:GetGameTime()
			local dA = du:GetForwardVector()
			local dB = {
				targetEntIndex = du:GetEntityIndex(),
				targetX = dt.x,
				targetY = dt.y,
				targetZ = dt.z,
				forwardX = dA.x,
				forwardY = dA.y,
				forwardZ = dA.z,
				duration = dw,
				focusDistance = dx,
				heightOffset = dy,
				restoreDuration = 1,
				startTime = dz,
				endTime = dz + dw,
				sequence = dz,
			}
			CustomNetTables:SetNetData("common", "boss_intro", { state = true })
			CustomNetTables:SetNetData("common", "boss_intro_camera", n({ state = true }, dB))
			CustomGameEventManager:Send_ServerToAllClients("boss_camera_intro", dB)
			Timer:GameTimer(dw, function()
				CustomNetTables:SetNetData("common", "boss_intro", { state = false })
				CustomNetTables:SetNetData("common", "boss_intro_camera", { state = false })
				self.dungeonTrap:AddBossShrink()
			end)
			Game:EachPlayer(function(a6, al)
				local aO = PlayerResource:GetSelectedHeroEntity(al)
				if IsValid(aO) then
					aO:AddNewModifier(aO, nil, "modifier_stunned", { duration = dw })
				end
			end)
			DungeonManager:MarkBossSpawned(Y)
			local dC = self.enemies
			dC[#dC + 1] = du
			self:AssignPreviewRewardsToEnemy(du)
			du:AddNewModifier(du, nil, "modifier_boss_custom", {})
			self:ApplyDifficultyModifiers(du)
			if self.difficultyCooldownReduction ~= 0 then
				du:AddProperty(PropertyFunction.COOLDOWN_REDUCTION, self.difficultyCooldownReduction)
			end
			if self.difficultyBossGapAmplify ~= 0 then
				du:AddProperty(PropertyFunction.BOSS_GAP_AMPLIFY, self.difficultyBossGapAmplify)
			end
			if self.difficultyBossDamageAmplify ~= 0 then
				du:AddProperty(PropertyFunction.FINAL_DAMAGE, self.difficultyBossDamageAmplify)
			end
			print(
				(
					(
						(
							(
								(
									(
										(("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss已生成: ")
										.. du:GetUnitName()
									) .. "， health:"
								) .. tostring(du:GetMaxHealth())
							) .. " attack:"
						) .. tostring(du:GetAttackDamage())
					) .. "当前计数="
				) .. tostring(self.aliveEnemyCount)
			)
		end
	end)
end
function P.prototype.CreateShopItem(self, dD)
	local dE = {}
	local dF = self:GetSinglePlayerShopFilterHero()
	if dF ~= nil then
		self:AppendShopExcludedForHero(dE, dF)
	end
	local dG = self:FindInfoTarget("info_shop_heal")
	if IsValid(dG) then
		self:SpawnShopItemAtPosition("item_heal_shop", 1, dG:GetAbsOrigin(), "heal")
		dE[#dE + 1] = "item_heal_shop"
	end
	local dH = self:FindInfoTarget("info_shop_upgrade")
	if IsValid(dH) then
		self:SpawnShopItemAtPosition("item_bless_upgrade", 1, dH:GetAbsOrigin(), "upgrade")
		dE[#dE + 1] = "item_bless_upgrade"
	end
	local dI = self:FindInfoTarget("info_shop_refresh")
	if IsValid(dI) then
		self:ClearShopRefreshInteract()
		local a7 = CreateUnitByName("interact_shop_refresh", dI:GetAbsOrigin(), false, nil, nil, DOTA_TEAM_GOODGUYS)
		a7:SetForwardVector(vec3_bottom)
		local aN = Interaction:RegisterInteract(a7, InteractType.Refresh, 200, function(a6, aO, al)
			local dJ = SHOP_REFRESH_BASE_COST + self.shopRefreshCount * SHOP_REFRESH_COST_INCREMENT
			if Player:GetGold(al) < dJ then
				return false
			end
			Player:ModifyGold(al, -dJ)
			local dK = math.max(0, math.min(100, GetShopRefreshRefund(aO)))
			if dK > 0 then
				local dL = dJ * dK * 0.01
				Player:ModifyGold(al, dL, true, true, false)
			end
			self.shopRefreshCount = self.shopRefreshCount + 1
			self:RefreshShopItems()
			EmitSoundOnLocationForPlayer("General.Buy", aO:GetAbsOrigin(), al)
			Event:Fire("shop_refresh_purchased", { playerID = al, cost = dJ })
			return true
		end, 999999)
		if aN ~= -1 then
			Interaction:UpdateInteract(
				aN,
				{
					costInfo = {
						costType = "gold",
						cost = SHOP_REFRESH_BASE_COST + self.shopRefreshCount * SHOP_REFRESH_COST_INCREMENT,
					},
				}
			)
			local dM = self.registeredInteracts
			dM[#dM + 1] = aN
			self.shopRefreshInteractIndex = aN
		end
		self.shopRefreshUnit = a7
		local dN = self.npcs
		dN[#dN + 1] = a7
	end
	local dO = self:FindInfoTarget("info_shop_item")
	if not IsValid(dO) then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] ⚠️ 未找到 info_shop_item，跳过常规商店商品生成"
		)
		return
	end
	local dP = self:GetSymmetricShopPositions(dO:GetAbsOrigin(), SHOP_ITEM_COUNT)
	do
		local dQ = 0
		while dQ < #dP do
			do
				local ac = 1
				local a2
				do
					local dR = 0
					while dR < 10 do
						ac = self:RollShopRarity()
						a2 = DrawPool:PickShopItemNameByRarity(ac, dE)
						if a2 ~= nil then
							break
						end
						dR = dR + 1
					end
				end
				if a2 == nil then
					a2 = DrawPool:Draw("items", dE)
					ac = 1
				end
				if a2 == nil then
					goto dS
				end
				self:AppendShopGeneratedExcluded(dE, a2)
				self:SpawnShopItemAtPosition(a2, ac, dP[dQ + 1], "item_" .. tostring(dQ + 1))
			end
			::dS::
			dQ = dQ + 1
		end
	end
	if not dD then
		local dT = Vector(dO:GetAbsOrigin().x, dO:GetAbsOrigin().y - 300, dO:GetAbsOrigin().z)
		Game:EachPlayer(function(a6, al)
			if Privilege:HasPrivilege("privilege_bless_003", al) then
				self:CreateFreeShopItem(al, dT, dE)
			end
		end)
	end
end
function P.prototype.CreateFreeShopItem(self, al, V, dE)
	local dU = { unpack(dE) }
	local aO = self:GetShopFilterHero(al)
	if aO ~= nil then
		self:AppendShopExcludedForHero(dU, aO)
	end
	local a2
	local ac = 1
	local dV = ShuffledList({ 3, 4, 5 })
	do
		local ah = 0
		while ah < #dV do
			local dW = dV[ah + 1]
			a2 = DrawPool:PickShopItemNameByRarity(dW, dU)
			if a2 ~= nil then
				ac = dW
				break
			end
			ah = ah + 1
		end
	end
	if a2 == nil then
		a2 = DrawPool:Draw("items", dU)
		ac = 1
	end
	if a2 ~= nil then
		self:AppendShopGeneratedExcluded(dE, a2)
		self:SpawnShopItemAtPosition(a2, ac, V, "free_item_" .. tostring(al), true, al)
		print(
			(
				(
					(
						(
							((("[DungeonRoom " .. tostring(self.roomID)) .. "] 玩家") .. tostring(al))
							.. "专属免费商品: "
						) .. a2
					) .. " (稀有度"
				) .. tostring(ac)
			) .. ")"
		)
	end
	return a2
end
function P.prototype.GetShopFilterHero(self, al)
	if al ~= nil then
		local aO = PlayerResource:GetSelectedHeroEntity(al)
		return IsValid(aO) and aO or nil
	end
	local bd
	Game:EachPlayer(function(a6, dX)
		if bd ~= nil then
			return
		end
		local aO = PlayerResource:GetSelectedHeroEntity(dX)
		if IsValid(aO) then
			bd = aO
		end
	end)
	return bd
end
function P.prototype.GetSinglePlayerShopFilterHero(self)
	if Game:GetPlayerCount() ~= 1 then
		return nil
	end
	return self:GetShopFilterHero()
end
function P.prototype.AppendShopExcludedForHero(self, dE, aO)
	local dY = {}
	local dZ = aO:GetAllItems()
	do
		local ah = 0
		while ah < #dZ do
			do
				local af = dZ[ah + 1]
				if not IsValid(af) then
					goto d_
				end
				local a2 = af:GetAbilityName()
				local e0 = KeyValues.items[a2]
				if e0 == nil then
					goto d_
				end
				local e1 = toFiniteNumber(e0.Quantitylimit, 0)
				if e1 > 0 and aO:GetItemCount(a2) >= e1 then
					self:AppendShopExcludedItem(dE, a2)
				end
				local e2 = self:GetArtifactUpgradeGroup(a2)
				local e3 = self:GetArtifactUpgradeRank(a2)
				if e2 ~= "" and e3 > (dY[e2] or 0) then
					dY[e2] = e3
				end
			end
			::d_::
			ah = ah + 1
		end
	end
	for a2, aw in pairs(KeyValues.items) do
		do
			local e4 = tostring
			local e5 = aw.UpgradeGroup
			if e5 == nil then
				e5 = ""
			end
			local e2 = e4(e5)
			if e2 == "" then
				goto e6
			end
			local e7 = dY[e2]
			if e7 == nil then
				goto e6
			end
			local e3 = toFiniteNumber(aw.UpgradeRank, 0)
			if e3 > 0 and e3 <= e7 then
				self:AppendShopExcludedItem(dE, a2)
			end
		end
		::e6::
	end
end
function P.prototype.AppendShopGeneratedExcluded(self, dE, a2)
	self:AppendShopExcludedItem(dE, a2)
	local e2 = self:GetArtifactUpgradeGroup(a2)
	local e3 = self:GetArtifactUpgradeRank(a2)
	if e2 == "" or e3 <= 0 then
		return
	end
	for e8, aw in pairs(KeyValues.items) do
		do
			local e9 = tostring
			local ea = aw.UpgradeGroup
			if ea == nil then
				ea = ""
			end
			if e9(ea) ~= e2 then
				goto eb
			end
			local ec = toFiniteNumber(aw.UpgradeRank, 0)
			if ec > 0 and ec <= e3 then
				self:AppendShopExcludedItem(dE, e8)
			end
		end
		::eb::
	end
end
function P.prototype.AppendShopExcludedItem(self, dE, a2)
	if not o(dE, a2) then
		dE[#dE + 1] = a2
	end
end
function P.prototype.GetArtifactUpgradeGroup(self, a2)
	local ed = tostring
	local ee = KeyValues.items[a2]
	if ee ~= nil then
		ee = ee.UpgradeGroup
	end
	local ef = ee
	if ef == nil then
		ef = ""
	end
	return ed(ef)
end
function P.prototype.GetArtifactUpgradeRank(self, a2)
	local eg = toFiniteNumber
	local eh = KeyValues.items[a2]
	if eh ~= nil then
		eh = eh.UpgradeRank
	end
	return eg(eh, 0)
end
function P.prototype.SpawnShopItemAtPosition(self, a2, ac, V, ei, ej, ek, el)
	if ej == nil then
		ej = false
	end
	if el == nil then
		el = "Default"
	end
	print(
		(
			(
				(
					((((("[DungeonRoom " .. tostring(self.roomID)) .. "] Shop item slot=") .. ei) .. " item=") .. a2)
					.. " rarity="
				) .. tostring(ac)
			) .. " free="
		) .. tostring(ej)
	)
	local aY = d(H, a2, ac, V, ej, ek, el)
	Interaction:RegisterShopItemInteract(aY)
	local em = self.registeredInteracts
	em[#em + 1] = aY:GetEntityIndex()
	local en = self.shopItems
	en[#en + 1] = aY
end
function P.prototype.GetSymmetricShopPositions(self, bD, d3)
	local dP = {}
	local eo = 256 - (d3 - 2) * 32
	local ep = -((d3 - 1) * eo) * 0.5
	do
		local dQ = 0
		while dQ < d3 do
			local b_ = ep + dQ * eo
			dP[#dP + 1] = Vector(bD.x + b_, bD.y, bD.z)
			dQ = dQ + 1
		end
	end
	return dP
end
function P.prototype.ClearShopRefreshInteract(self)
	if self.shopRefreshInteractIndex ~= nil then
		Interaction:UnregisterInteractable(self.shopRefreshInteractIndex)
		local eq = {}
		do
			local ah = 0
			while ah < #self.registeredInteracts do
				local aF = self.registeredInteracts[ah + 1]
				if aF ~= self.shopRefreshInteractIndex then
					eq[#eq + 1] = aF
				end
				ah = ah + 1
			end
		end
		self.registeredInteracts = eq
		self.shopRefreshInteractIndex = nil
	end
	if self.shopRefreshUnit ~= nil then
		ArrayRemove(self.npcs, self.shopRefreshUnit)
		self:RemoveUnit(self.shopRefreshUnit)
		self.shopRefreshUnit = nil
	end
end
function P.prototype.RefreshShopItems(self)
	if self.roomType ~= RoomType.SHOP then
		return
	end
	print(("[DungeonRoom " .. tostring(self.roomID)) .. "] RefreshShopItems")
	Interaction:BeginSyncBatch()
	local er = {}
	do
		local ah = 0
		while ah < #self.shopItems do
			do
				local es = self.shopItems[ah + 1]
				if es == nil then
					goto et
				end
				local aF = es:GetEntityIndex()
				if aF == -1 then
					goto et
				end
				Interaction:UnregisterInteractable(aF)
				er[aF] = true
				es:dispose()
			end
			::et::
			ah = ah + 1
		end
	end
	self.shopItems = {}
	local eq = {}
	do
		local ah = 0
		while ah < #self.registeredInteracts do
			local aF = self.registeredInteracts[ah + 1]
			if er[aF] ~= true then
				eq[#eq + 1] = aF
			end
			ah = ah + 1
		end
	end
	self.registeredInteracts = eq
	self:ClearShopRefreshInteract()
	self:CreateShopItem(true)
	Interaction:EndSyncBatch()
end
function P.prototype.CreateStairItem(self)
	local eu = GetGroundPosition(self.position, nil)
	self.stairChestPlayers = {}
	self.stairChestCompletedPlayers = {}
	self.stairChestAutoClaimingPlayers = {}
	self.stairChestOpeningPlayers = {}
	self.stairChestIgnoredPlayers = {}
	self.stairChestItemPos = eu
	local ev = DungeonManager:IsTutorial()
	Game:EachPlayer(function(a6, al)
		self.stairChestPlayers[al] = true
		local aJ = d(x, al, "9900000", eu, { 0, 0 })
		local ew = self.clientItems
		ew[#ew + 1] = aJ
		local aN
		aN = Interaction:RegisterInteract(aJ.entity, InteractType.BossChest, 200, function(a6, aO)
			if not self:CanOpenStairChest(al) then
				return false
			end
			if self:IsEquipmentCapacityFull(al) then
				self:ShowEquipmentCapacityDialog(al, true)
				return false
			end
			self.stairChestOpeningPlayers[al] = true
			self:RequestStairChestRewards(al, 1, false, eu, function(a6, ex, ey)
				self.stairChestOpeningPlayers[al] = false
				if not ex or self.isDispose or self.stairChestIgnoredPlayers[al] == true then
					if DungeonManager:IsTutorial() then
						self:CompleteManualStairChestOpen(al, aN, aJ, eu, false, false)
						self:OpenGates()
						return
					end
					self:TryOpenStairGatesByChestState()
					return
				end
				self:CompleteManualStairChestOpen(al, aN, aJ, eu, false, false, ey)
			end, true)
			return false
		end, nil, al)
		if not ev then
			Interaction:SetSecondaryInteraction(aN, function(a6, aO)
				if not self:CanOpenStairChest(al) then
					return false
				end
				if self:IsEquipmentCapacityFull(al) then
					self:ShowEquipmentCapacityDialog(al, true)
					return false
				end
				local ez = Privilege:HasPrivilege("privilege_bless_001", al)
				local eA = ez and Privilege:GetPrivilegeSpecialValue("privilege_bless_001", 1, "free_count", aO) or 0
				local eB = CommonService:GetPlayerServiceNetTable(al, "player_counters") or {}
				local eC = eB.daily_free_boss_rewards
				local eD = eC and eC.count or 0
				local eE = eD < eA
				print(
					(
						(
							(
								(
									(
										((("[DungeonRoom " .. tostring(self.roomID)) .. "] Player ") .. tostring(al))
										.. " Open Boss Chest Rewards isUseFreeCount="
									) .. tostring(eE)
								) .. " usedFreeCount="
							) .. tostring(eD)
						) .. " freeCount="
					) .. tostring(eA)
				)
				if not eE then
					local eF = CommonService:GetPlayerServiceNetTable(al, "player_tokens") or {}
					local eG = eF["110006"]
					if (eG and eG.amounts or 0) < 1 then
						ErrorMessage("error_token_no_enough", al)
						return false
					end
				end
				self.stairChestOpeningPlayers[al] = true
				self:RequestStairChestRewards(al, 2, eE, eu, function(a6, ex, ey)
					self.stairChestOpeningPlayers[al] = false
					if not ex or self.isDispose or self.stairChestIgnoredPlayers[al] == true then
						self:TryOpenStairGatesByChestState()
						return
					end
					self:CompleteManualStairChestOpen(al, aN, aJ, eu, true, eE, ey)
				end, true)
				return false
			end)
			local aO = PlayerResource:GetSelectedHeroEntity(al)
			local ez = Privilege:HasPrivilege("privilege_bless_001", al)
			local eA = ez and Privilege:GetPrivilegeSpecialValue("privilege_bless_001", 1, "free_count", aO) or 0
			local eB = CommonService:GetPlayerServiceNetTable(al, "player_counters") or {}
			local eH = eB.daily_free_boss_rewards
			local eD = eH and eH.count or 0
			Interaction:UpdateSecondaryInteract(
				aN,
				{ tooltip = "DoubleBossChest", costInfo = {
					cost = 1,
					costType = "110006",
					costSource = "tokens",
					freeCount = eA - eD,
				} }
			)
		end
		if aN ~= -1 then
			local eI = self.registeredInteracts
			eI[#eI + 1] = aN
		end
	end)
	local a7 = CreateUnitByName(
		"interact_regen_well",
		self.position + Vector(500, 700, 0),
		false,
		nil,
		nil,
		DOTA_TEAM_GOODGUYS
	)
	local aN = Interaction:RegisterInteract(a7, InteractType.RegenWell, 200, function(a6, aO, al)
		local eJ = a7:FindModifierByName("modifier_spawn_interact_regen_well")
		if eJ ~= nil then
			eJ:Activity()
		end
	end, 1)
	if aN ~= -1 then
		local eK = self.registeredInteracts
		eK[#eK + 1] = aN
	end
	local eL = self.npcs
	eL[#eL + 1] = a7
	if DungeonManager:IsFinalZone(self.zoneID) then
		DungeonAdventure:OpenAdventure(self.zoneID, self.roomType, self.position)
	end
end
function P.prototype.CompleteManualStairChestOpen(self, al, aN, aJ, eu, bz, eE, ey)
	if ey == nil then
		ey = false
	end
	Interaction:UnregisterInteractable(aN)
	ArrayRemove(self.registeredInteracts, aN)
	self:MarkStairChestCompleted(al)
	if ey then
		e(aJ.particleIDs, function(a6, eM)
			ParticleManager:DestroyParticle(eM, false)
		end)
		aJ.particleIDs = {}
		local eN = PlayerResource:GetPlayer(al)
		if eN ~= nil then
			local eO = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/boss_chest_open.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				eN
			)
			ParticleManager:SetParticleControl(eO, 0, aJ.entity:GetAbsOrigin())
			local eP = aJ.particleIDs
			eP[#eP + 1] = eO
		end
		return
	end
	if not DungeonManager:IsTutorial() then
		local be = DungeonManager:GetRoomIndex() + 1
		Service:ReportClick(al, "dungeon", "reward_room|open_chest|room_" .. tostring(be))
	end
	EmitSoundOnLocationForPlayer(bz and "Chess.LongOpen" or "Chess.Open", eu, al)
	if eE then
		Notification:CombatToPlayer(al, { message = "Notify_FreeOpenBossRewards" })
	end
	e(aJ.particleIDs, function(a6, eM)
		ParticleManager:DestroyParticle(eM, false)
	end)
	aJ.particleIDs = {}
	local eN = PlayerResource:GetPlayer(al)
	if eN == nil then
		return
	end
	local eQ = ParticleManager:CreateParticleForPlayer(
		"particles/generic_gameplay/boss_chest_opening.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aJ.entity,
		eN
	)
	ParticleManager:SetParticleControlEnt(eQ, 1, aJ.entity, PATTACH_INVALID, nil, aJ.entity:GetAbsOrigin(), true)
	local eR = aJ.particleIDs
	eR[#eR + 1] = eQ
	Timer:GameTimer(0.8, function()
		if self.isDispose or aJ.isDispose then
			return
		end
		e(aJ.particleIDs, function(a6, eM)
			ParticleManager:DestroyParticle(eM, false)
		end)
		aJ.particleIDs = {}
		local eS = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/treasure_box/treasure_box_open_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			eN
		)
		ParticleManager:SetParticleControl(eS, 0, aJ.entity:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(eS)
		local eO = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/boss_chest_open.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			eN
		)
		ParticleManager:SetParticleControl(eO, 0, aJ.entity:GetAbsOrigin())
		local eT = aJ.particleIDs
		eT[#eT + 1] = eO
	end)
end
function P.prototype.CanOpenStairChest(self, al)
	if self.roomType ~= RoomType.STAIR then
		return true
	end
	return self.stairChestCompletedPlayers[al] ~= true
		and self.stairChestAutoClaimingPlayers[al] ~= true
		and self.stairChestOpeningPlayers[al] ~= true
		and self.stairChestIgnoredPlayers[al] ~= true
end
function P.prototype.MarkStairChestCompleted(self, al)
	if self.roomType ~= RoomType.STAIR then
		return
	end
	if self.stairChestCompletedPlayers[al] == true then
		return
	end
	self.stairChestCompletedPlayers[al] = true
	self.stairChestAutoClaimingPlayers[al] = false
	self.stairChestOpeningPlayers[al] = false
	print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 楼梯房宝箱完成 player=") .. tostring(al))
	self:TryOpenStairGatesByChestState()
end
function P.prototype.StartStairChestStateWatcher(self)
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
function P.prototype.StopStairChestStateWatcher(self)
	if self.stairChestStateTimerID == nil then
		return
	end
	Timer:StopTimer(self.stairChestStateTimerID)
	self.stairChestStateTimerID = nil
end
function P.prototype.StartUnitManagerGuardTimer(self)
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
function P.prototype.StopUnitManagerGuardTimer(self)
	if self.unitManagerGuardTimerID == nil then
		return
	end
	Timer:StopTimer(self.unitManagerGuardTimerID)
	self.unitManagerGuardTimerID = nil
end
function P.prototype.CheckUnitManagerGuard(self)
	if UnitManager == nil or not UnitManager:IsReady() then
		return
	end
	local eU = self:GetAliveManagedEnemies()
	if #eU >= 5 then
		return
	end
	local eV = {}
	for a6, aD in ipairs(eU) do
		if not UnitManager:IsUnitIndexValid(aD) then
			UnitManager:RepairUnitIndex(aD)
			eV[#eV + 1] = aD
		end
	end
	if #eV <= 0 or self.hasReportedUnitManagerGuard then
		return
	end
	self.hasReportedUnitManagerGuard = true
	self:ReportUnitManagerGuard(eV, #eU)
end
function P.prototype.GetAliveManagedEnemies(self)
	local eU = {}
	do
		local ah = 0
		while ah < #self.enemies do
			local aD = self.enemies[ah + 1]
			if IsValid(aD) and aD:IsAlive() then
				eU[#eU + 1] = aD
			end
			ah = ah + 1
		end
	end
	return eU
end
function P.prototype.ReportUnitManagerGuard(self, eV, eW)
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
				aliveEnemyCount = eW,
				trackedEnemyCount = #self.enemies,
				pendingAliveEnemyCount = self.aliveEnemyCount,
				remainingSpawnCount = self.spawnInfo.totalCount,
				repairedEnemies = j(eV, function(a6, aD)
					return self:GetUnitManagerGuardUnitReport(aD)
				end),
			}),
		}
	)
end
function P.prototype.GetUnitManagerGuardUnitReport(self, a7)
	return UnitManager and UnitManager:GetUnitIndexReport(a7) or { valid = false }
end
function P.prototype.GetStairChestPlayerCount(self)
	local d3 = 0
	for eX in pairs(self.stairChestPlayers) do
		d3 = d3 + 1
	end
	return d3
end
function P.prototype.RefreshStairChestPlayerStates(self)
	if self.roomType ~= RoomType.STAIR or self.isDispose or self.isComplete or self.gatesOpened then
		return
	end
	for eY in pairs(self.stairChestPlayers) do
		do
			local al = tonumber(eY)
			if
				al == nil
				or self.stairChestCompletedPlayers[al] == true
				or self.stairChestIgnoredPlayers[al] == true
			then
				goto eZ
			end
			local e_ = PlayerResource:GetConnectionState(al)
			if e_ == DOTA_CONNECTION_STATE_CONNECTED then
				goto eZ
			end
			if e_ == DOTA_CONNECTION_STATE_ABANDONED then
				self.stairChestIgnoredPlayers[al] = true
				self.stairChestAutoClaimingPlayers[al] = false
				self.stairChestOpeningPlayers[al] = false
				print(
					(
						("[DungeonRoom " .. tostring(self.roomID))
						.. "] 楼梯房玩家已放弃，跳过宝箱并不再等待 player="
					) .. tostring(al)
				)
				goto eZ
			end
			self:AutoClaimStairChest(al)
		end
		::eZ::
	end
	self:TryOpenStairGatesByChestState()
end
function P.prototype.AutoClaimStairChest(self, al)
	if
		self.stairChestCompletedPlayers[al] == true
		or self.stairChestIgnoredPlayers[al] == true
		or self.stairChestAutoClaimingPlayers[al] == true
		or self.stairChestOpeningPlayers[al] == true
	then
		return
	end
	if self.stairChestItemPos == nil then
		return
	end
	self.stairChestAutoClaimingPlayers[al] = true
	print(
		(("[DungeonRoom " .. tostring(self.roomID)) .. "] 楼梯房玩家断线，自动普通开箱 player=")
			.. tostring(al)
	)
	self:RequestStairChestRewards(al, 1, false, self.stairChestItemPos, function(a6, ex)
		self.stairChestAutoClaimingPlayers[al] = false
		if not ex then
			self:TryOpenStairGatesByChestState()
			return
		end
		if self.isDispose or self.isComplete or self.stairChestIgnoredPlayers[al] == true then
			self:TryOpenStairGatesByChestState()
			return
		end
		self:MarkStairChestCompleted(al)
	end)
end
function P.prototype.TryOpenStairGatesByChestState(self)
	if self.roomType ~= RoomType.STAIR or self.isDispose or self.isComplete or self.gatesOpened then
		return
	end
	local f0 = 0
	local f1 = 0
	local f2 = 0
	local f3 = 0
	for eY in pairs(self.stairChestPlayers) do
		do
			local al = tonumber(eY)
			if al == nil then
				goto f4
			end
			f0 = f0 + 1
			if self.stairChestIgnoredPlayers[al] == true then
				f2 = f2 + 1
				goto f4
			end
			if self.stairChestCompletedPlayers[al] == true then
				f1 = f1 + 1
				goto f4
			end
			f3 = f3 + 1
		end
		::f4::
	end
	local f5 = DungeonAdventure:AreOpenedAdventuresCompleted()
	local f6 = f0 <= 0 or f3 <= 0
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
													("[DungeonRoom " .. tostring(self.roomID))
													.. "] 楼梯房离开进度 chestCompleted="
												) .. tostring(f6)
											) .. " completed="
										) .. tostring(f1)
									) .. " ignored="
								) .. tostring(f2)
							) .. " waiting="
						) .. tostring(f3)
					) .. " total="
				) .. tostring(f0)
			) .. " adventuresCompleted="
		) .. tostring(f5)
	)
	if f6 and f5 then
		self:StopStairChestStateWatcher()
		self:OpenGates()
	end
end
function P.prototype.RequestBossChestRewards(self, al, f7, f8, eu, f9, fa)
	if fa == nil then
		fa = false
	end
	if fa and self:IsEquipmentCapacityFull(al) then
		self:ShowEquipmentCapacityDialog(al, true)
		if f9 ~= nil then
			f9(nil, false)
		end
		return
	end
	local fb = false
	CommonService:RepeatCallAction(
		"/v1/settle/receive_boss_rewards",
		al,
		{
			match_id = Match:GetMatchID(),
			round = DungeonManager:GetZoneIndex(),
			room_step = DungeonManager:GetRoomIndex(),
			open_times = f7,
			use_daily_free_open_times = f8,
		},
		function(a6, fc, fd)
			if fb then
				return
			end
			fb = true
			if fd.code == 2 and fd.message == "rewards received" then
				ErrorMessage("error_boss_rewards_already_received")
				if f9 ~= nil then
					f9(nil, true, true)
				end
				return
			end
			CommonService:CommonCallback(al, fd)
			self:HandleBossChestRewardsResponse(fc, fd, eu, f9)
		end,
		false
	)
end
function P.prototype.RequestStairChestRewards(self, al, f7, f8, eu, f9, fa)
	if fa == nil then
		fa = false
	end
	if DungeonManager:IsTutorial() then
		if fa and self:IsEquipmentCapacityFull(al) then
			self:ShowEquipmentCapacityDialog(al, true)
			if f9 ~= nil then
				f9(nil, false)
			end
			return
		end
		CommonService:RepeatCallAction("/v1/player/receive_teach_rewards", al, {}, function(a6, fc, fd)
			if fd.code == 0 or fd.code == 200 then
				CommonService:CommonCallback(al, fd, false)
			else
				ErrorMessage("Tutorial's reward has been received", al)
				if f9 ~= nil then
					f9(nil, false)
				end
				return
			end
			self:HandleBossChestRewardsResponse(fc, fd, eu, f9)
		end, false)
		return
	end
	self:RequestBossChestRewards(al, f7, f8, eu, f9, fa)
end
function P.prototype.HandleBossChestRewardsResponse(self, al, fd, eu, f9)
	if fd.code ~= 0 and fd.code ~= 200 then
		if f9 ~= nil then
			f9(nil, false)
		end
		return
	end
	local fe
	if fd ~= nil then
		fe = fd.data
	end
	local ff
	if fe ~= nil then
		ff = fe.add_items
	end
	local fg = ff
	local fh
	if fg ~= nil then
		fh = fg.other
	end
	local fi = fh
	local fj
	if fd ~= nil then
		fj = fd.data
	end
	local fk
	if fj ~= nil then
		fk = fj.player_equipments
	end
	local fl = fk
	local fm
	if fd ~= nil then
		fm = fd.data
	end
	local fn
	if fm ~= nil then
		fn = fm.player_drawings
	end
	local fo = fn
	local fp
	if fd ~= nil then
		fp = fd.data
	end
	local fq
	if fp ~= nil then
		fq = fp.player_keys
	end
	local fr = fq
	local fs
	if fd ~= nil then
		fs = fd.data
	end
	local ft
	if fs ~= nil then
		ft = fs.player_notices
	end
	local fu = ft
	if fu == nil then
		fu = {}
	end
	local fv = fu
	local fw = fv[1]
	local fx = (fw and fw.key) == "BossRewards3TimesDrop"
	if fx then
		Notification:CombatToPlayer(al, { message = "Notify_BossRewards3TimesDrop" })
	end
	if not fi and not fl and not fo and not fr then
		if f9 ~= nil then
			f9(nil, true)
		end
		self:ScheduleEquipmentCapacityDialog(al)
		return
	end
	if f9 ~= nil then
		f9(nil, true)
	end
	self:ScheduleEquipmentCapacityDialog(al)
	Timer:GameTimer(0.8, function()
		if self.isDispose then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", eu, al)
		local fy = {}
		if fi then
			for a6, ap in ipairs(fi) do
				do
					local fz = tonumber(GetItemPropType(ap.item_id))
					if fz == 9 or fz == 19 or fz == 20 then
						goto fA
					end
					fy[#fy + 1] =
						{ item_id = ap.item_id, amounts = ap.amounts, item_rarity = GetPropRarity(ap.item_id) }
				end
				::fA::
			end
		end
		if fl then
			for a6, fB in ipairs(fl) do
				fy[#fy + 1] = { item_id = fB.equipment_item_id, amounts = 1, item_rarity = fB.rarity, uid = fB.id }
			end
		end
		if fo then
			for a6, fC in ipairs(fo) do
				fy[#fy + 1] = { item_id = fC.drawing_item_id, amounts = 1, item_rarity = fC.rarity, uid = fC.id }
			end
		end
		if fr then
			for a6, fD in ipairs(fr) do
				fy[#fy + 1] = { item_id = fD.key_item_id, amounts = 1, item_rarity = fD.rarity, uid = fD.id }
			end
		end
		local fE = {}
		for ah, ap in ipairs(fy) do
			fE[#fE + 1] = ap
			Timer:GameTimer(0.1 * ah, function()
				if self.isDispose then
					return
				end
				local fF = d(x, al, ap.item_id, eu, { 200, 300 })
				local fG = self.clientItems
				fG[#fG + 1] = fF
				local aN = Interaction:RegisterInteract(fF.entity, InteractType.Consumables, 200, function(a6, aO, bA)
					CommonService:SendReceiveRewards(
						bA,
						{ { item_id = ap.item_id, amounts = ap.amounts, uid = ap.uid } }
					)
					fF:dispose()
					Event:Fire("client_item_pickup", { playerID = al, item_id = ap.item_id })
				end, 1, al)
				Interaction:UpdateInteract(aN, { position = fF:GetLandedPosition() })
				Interaction:SetSecondaryInteraction(aN, function(a6, aO, al)
					local aQ = aO:GetPlayerOwnerID()
					local fH = {}
					do
						local ah = 0
						while ah < #self.clientItems do
							do
								local aJ = self.clientItems[ah + 1]
								if aJ == nil or aJ.isDispose or not aJ:IsLanded() or not IsValid(aJ.entity) then
									goto fI
								end
								if aJ.playerID ~= aQ then
									goto fI
								end
								local aF = aJ:GetEntityIndex()
								if aF == -1 then
									goto fI
								end
								fH[#fH + 1] = { entityIndex = aF, position = aJ:GetLandedPosition() }
							end
							::fI::
							ah = ah + 1
						end
					end
					do
						local ah = 0
						while ah < #fH do
							local fJ = fH[ah + 1]
							self:CreateClientItemPickupParticle(fJ.position, aO)
							Interaction:ExecutePrimaryCallback(fJ.entityIndex, aO, al)
							Interaction:UnregisterInteractable(fJ.entityIndex)
							ArrayRemove(self.registeredInteracts, fJ.entityIndex)
							ah = ah + 1
						end
					end
					self.clientItems = k(self.clientItems, function(a6, ae)
						return not ae.isDispose
					end)
				end)
				Interaction:UpdateSecondaryInteract(aN, { tooltip = "DoubleConsumables" })
				if aN ~= -1 then
					local fK = self.registeredInteracts
					fK[#fK + 1] = aN
				end
			end)
		end
		if #fE > 0 then
			Match:AddPlayerRoundRewards(al, fE)
		end
	end)
end
function P.prototype.GetEquipmentCount(self, al)
	return Equipment:GetCapacityCount(al, "equipment")
end
function P.prototype.IsEquipmentCapacityFull(self, al)
	return Equipment:IsCapacityFull(al, "equipment")
end
function P.prototype.ScheduleEquipmentCapacityDialog(self, al)
	Timer:GameTimer(0.8, function()
		local d3 = self:GetEquipmentCount(al)
		if d3 >= N then
			self:ShowEquipmentCapacityDialog(al, d3 >= Equipment:GetCapacityLimit("equipment"))
		end
	end)
end
function P.prototype.ShowEquipmentCapacityDialog(self, al, fL)
	Equipment:ShowCapacityDialog(al, "equipment", fL)
end
function P.prototype.CreateSpecialRoom(self)
	if self.roomType == RoomType.SPECIAL then
		local bd = self.specialKind
		if bd == nil or bd == "" then
			local fM = "special_room_zone" .. tostring(self.zoneID)
			bd = DrawPool:Draw(fM)
			print(
				(((("[DungeonRoom " .. tostring(self.roomID)) .. "] SpecialRoom fallback draw from ") .. fM) .. ": ")
					.. (bd or "-")
			)
		end
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] SpecialRoom resolved: ") .. (bd or "-"))
		if bd ~= nil and type(self["Create" .. bd]) == "function" then
			self["Create" .. bd](self)
		end
	end
end
function P.prototype.CreateWishingPool(self)
	local a7 = CreateUnitByName("interact_wishing_pool", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aN
	aN = Interaction:RegisterInteract(a7, InteractType.Pool, 380, function(a6, aO, al)
		local fN = self.wishingPoolCount * WISHING_POOL_COST
		local eA = Privilege:GetPlayerDynamicValue("privilege_bless_012", al, "free_count") or 0
		local dJ = eA > 0 and 0 or fN
		if eA > 0 then
			Privilege:SetPlayerDynamicValue("privilege_bless_012", al, "free_count", eA - 1)
		end
		if dJ > 0 then
			if Player:GetGold(al) < dJ then
				EmitAnnouncerSoundForPlayer("General.Cancel", al)
				return false
			end
			Player:ModifyGold(al, -dJ, true, true)
		end
		self.wishingPoolCount = self.wishingPoolCount + 1
		Interaction:UpdateInteract(
			aN,
			{ costInfo = { cost = self.wishingPoolCount * WISHING_POOL_COST, costType = "gold" } }
		)
		local ap = DrawPool:Draw("wish_pool_zone" .. tostring(self.zoneID))
		if ap ~= nil then
			local fO = CalcDirection2D(aO, self.position)
			local fP = self.position + fO * RandomInt(400, 500)
			fP.z = aO:GetAbsOrigin().z
			local aY = d(F, ap, fP)
			local fQ = self.dropItems
			fQ[#fQ + 1] = aY
			local fR = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO, al)
				if not aY:IsLanded() then
					return false
				end
				if aO ~= nil then
					aO:AddItemByName(ap, nil, false)
				end
				aY:dispose()
			end, nil, nil, ap)
			if fR ~= -1 then
				local fS = self.registeredInteracts
				fS[#fS + 1] = fR
			end
		end
		Event:Fire("wishing_pool_reward", { playerID = al, cost = dJ })
	end, 99999999)
	if aN ~= -1 then
		Interaction:UpdateInteract(
			aN,
			{ costInfo = { cost = self.wishingPoolCount * WISHING_POOL_COST, costType = "gold" } }
		)
		local fT = self.registeredInteracts
		fT[#fT + 1] = aN
	end
	local fU = self.npcs
	fU[#fU + 1] = a7
end
function P.prototype.CreateRegenWell(self)
	local a7 = CreateUnitByName("interact_regen_well", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aN = Interaction:RegisterInteract(a7, InteractType.RegenWell, 200, function(a6, aO, al)
		local fV = a7:FindModifierByName("modifier_spawn_interact_regen_well")
		if fV ~= nil then
			fV:Activity()
		end
	end, 1)
	if aN ~= -1 then
		local fW = self.registeredInteracts
		fW[#fW + 1] = aN
	end
	local fX = self.npcs
	fX[#fX + 1] = a7
end
function P.prototype.CreateBook(self)
	local a7 = CreateUnitByName("interact_book", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aN = Interaction:RegisterInteract(a7, InteractType.Book, 200, function(a6, aO, al)
		Game:EachPlayer(function(a6, al)
			BlessUpgrade:RequestEnqueueBlessUpgrade(al, 3)
		end)
		a7:EmitSoundParams("ui.badge_levelup", 0, 0.5, 0)
	end, 1)
	if aN ~= -1 then
		local fY = self.registeredInteracts
		fY[#fY + 1] = aN
	end
	local fZ = self.npcs
	fZ[#fZ + 1] = a7
end
function P.prototype.CreateSmithy(self)
	local a7 = CreateUnitByName("interact_smithy", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	a7:SetForwardVector(vec3_bottom)
	local aN = Interaction:RegisterInteract(a7, InteractType.Smithy, 200, function(a6, f_, eX)
		Game:EachPlayer(function(a6, al)
			local bd = ArtifactUpgrade:RequestEnqueueArtifactUpgrade(al, 3)
			if not bd then
				ErrorMessage("#error_no_artifact_upgrade", al)
				Artifact:RequestEnqueueArtifactSelection(al, 3, { [2] = 7, [3] = 3 })
			end
		end)
		a7:EmitSoundParams("ui.badge_levelup", 0, 0.5, 0)
	end, 1)
	if aN ~= -1 then
		local g0 = self.registeredInteracts
		g0[#g0 + 1] = aN
	end
	local g1 = self.npcs
	g1[#g1 + 1] = a7
end
function P.prototype.HasTravelingMerchant(self)
	return self.specialKind == M
end
function P.prototype.IsTravelingMerchantNear(self, V, g2)
	if self.travelingMerchantPosition == nil then
		return false
	end
	return CalcDistance(V, self.travelingMerchantPosition) <= g2
end
function P.prototype.GetTravelingMerchantTrapPositions(self)
	local g3 = {}
	local g4 = Entities:FindAllByClassname("prop_dynamic")
	do
		local ah = 0
		while ah < #g4 do
			local g5 = g4[ah + 1]
			if g5:GetSpawnGroupHandle() == self.spawnGroup and p(g5:GetName(), "trap_fire_model") then
				g3[#g3 + 1] = g5:GetAbsOrigin()
			end
			ah = ah + 1
		end
	end
	return g3
end
function P.prototype.GetTravelingMerchantExitInfos(self)
	local g6 = {}
	do
		local ah = 0
		while ah < #self.exitInfos do
			do
				local ag = self.exitInfos[ah + 1]
				if ag == nil then
					goto g7
				end
				g6[#g6 + 1] = { position = ag.position, direction = ag.direction }
			end
			::g7::
			ah = ah + 1
		end
	end
	return g6
end
function P.prototype.IsTravelingMerchantBlockedByExit(self, V)
	local g6 = self:GetTravelingMerchantExitInfos()
	local g8 = GRID_SIZE * 2
	local g9 = GRID_SIZE * 0.75
	do
		local ah = 0
		while ah < #g6 do
			local ag = g6[ah + 1]
			local ga = V:__sub(ag.position)
			local gb = ga.x * ag.direction.x + ga.y * ag.direction.y
			local gc = -gb
			local gd = math.abs(ga.x * -ag.direction.y + ga.y * ag.direction.x)
			if gc >= 0 and gc <= g8 and gd <= g9 then
				return true
			end
			ah = ah + 1
		end
	end
	return false
end
function P.prototype.ResolveTravelingMerchantForward(self, V)
	local bW = V.x - self.position.x
	local bX = V.y - self.position.y
	if math.abs(bW) > math.abs(bX) then
		return bW > 0 and vec3_left or vec3_right
	end
	return vec3_bottom
end
function P.prototype.IsTravelingMerchantGridPositionValid(self, V)
	do
		local ah = 0
		while ah < #self.validGridPositions do
			local ge = self.validGridPositions[ah + 1]
			if ge ~= nil and CalcDistance(ge, V) <= GRID_SIZE * 0.25 then
				return true
			end
			ah = ah + 1
		end
	end
	return false
end
function P.prototype.CanPlaceTravelingMerchantAt(self, V, gf)
	if not self:IsTravelingMerchantGridPositionValid(V) then
		return false
	end
	local gg = V:__add(gf:__mul(GRID_SIZE))
	local gh = Vector(-gf.y, gf.x, 0)
	local gi = V:__add(gh:__mul(GRID_SIZE))
	local gj = V:__sub(gh:__mul(GRID_SIZE))
	return self:IsTravelingMerchantGridPositionValid(gg)
		and self:IsTravelingMerchantGridPositionValid(gi)
		and self:IsTravelingMerchantGridPositionValid(gj)
end
function P.prototype.GetTravelingMerchantDirectionCandidates(self, V)
	local gk = self:ResolveTravelingMerchantForward(V)
	local gl = { gk }
	local gm = { vec3_bottom, vec3_left, vec3_right }
	do
		local ah = 0
		while ah < #gm do
			local fO = gm[ah + 1]
			if fO ~= gk then
				gl[#gl + 1] = fO
			end
			ah = ah + 1
		end
	end
	return gl
end
function P.prototype.ResolveTravelingMerchantAngles(self, fO)
	if fO == vec3_left then
		return "0 180 0"
	end
	if fO == vec3_right then
		return "0 0 0"
	end
	return "0 -90 0"
end
function P.prototype.ResolveTravelingMerchantAdjustedPosition(self, V, gf)
	local gn = V
	local go = gf:__mul(-1)
	local gp = GRID_SIZE * 0.1
	local gq = GRID_SIZE * 0.5
	local gr = 10
	do
		local gs = 0
		while gs <= gr do
			local gt = gq + gp * gs
			local cx = V:__add(go:__mul(gt))
			if not self:IsPositionInside(cx) or not GridNav:IsValidPosition(cx) then
				break
			end
			gn = cx
			gs = gs + 1
		end
	end
	return gn
end
function P.prototype.ResolveTravelingMerchantSpawnData(self)
	self.travelingMerchantPosition = nil
	self.travelingMerchantForward = vec3_bottom
	self.travelingMerchantAngles = "0 -90 0"
	if not self:HasTravelingMerchant() then
		return
	end
	if #self.validGridPositions <= 0 then
		return
	end
	local gu = math.huge
	local gv = -math.huge
	local gw = -math.huge
	do
		local ah = 0
		while ah < #self.validGridPositions do
			do
				local ge = self.validGridPositions[ah + 1]
				if ge == nil then
					goto gx
				end
				gu = math.min(gu, ge.x)
				gv = math.max(gv, ge.x)
				gw = math.max(gw, ge.y)
			end
			::gx::
			ah = ah + 1
		end
	end
	local g3 = self:GetTravelingMerchantTrapPositions()
	local gy = GRID_SIZE * 1.25
	local gz = nil
	local gA = nil
	local gB = math.huge
	local gC = -math.huge
	do
		local ah = 0
		while ah < #self.validGridPositions do
			do
				local ge = self.validGridPositions[ah + 1]
				if ge == nil then
					goto gD
				end
				if self:IsTravelingMerchantBlockedByExit(ge) then
					goto gD
				end
				local gE = false
				do
					local gF = 0
					while gF < #g3 do
						if CalcDistance(ge, g3[gF + 1]) <= gy then
							gE = true
							break
						end
						gF = gF + 1
					end
				end
				if gE then
					goto gD
				end
				local gl = self:GetTravelingMerchantDirectionCandidates(ge)
				local gG = nil
				do
					local gH = 0
					while gH < #gl do
						local fO = gl[gH + 1]
						if self:CanPlaceTravelingMerchantAt(ge, fO) then
							gG = fO
							break
						end
						gH = gH + 1
					end
				end
				if gG == nil then
					goto gD
				end
				local gI = math.min(math.abs(ge.x - gu), math.abs(gv - ge.x), math.abs(gw - ge.y))
				local gJ = CalcDistance(ge, self.position)
				if gI < gB or gI == gB and gJ > gC then
					gz = ge
					gA = gG
					gB = gI
					gC = gJ
				end
			end
			::gD::
			ah = ah + 1
		end
	end
	if gz == nil or gA == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] TravelingMerchant 未找到满足前方和两侧相邻网格条件的站位，跳过创建"
		)
		return
	end
	local gn = self:ResolveTravelingMerchantAdjustedPosition(gz, gA)
	self.travelingMerchantPosition = GetGroundPosition(gn, nil)
	self.travelingMerchantForward = gA
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
function P.prototype.CreateTravelingMerchantPlaceholder(self)
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
function P.prototype.GetTravelingMerchantArtifactPool(self)
	local gK = {}
	for a2, aw in pairs(KeyValues.artifact) do
		local gL = tostring
		local gM = aw.Access
		if gM == nil then
			gM = ""
		end
		if gL(gM) == "Meepo" then
			gK[#gK + 1] = tostring(a2)
		end
	end
	return gK
end
function P.prototype.GetTravelingMerchantItemRarity(self, a2)
	return self:RollTavernItemRarity(a2)
end
function P.prototype.CreateTravelingMerchantShopItems(self)
	if self.travelingMerchantPosition == nil then
		return
	end
	local a1 = self:GetTravelingMerchantArtifactPool()
	if #a1 <= 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] TravelingMerchant 未找到 Access=Meepo 的 artifact 商品"
		)
		return
	end
	local dE = {}
	local dF = self:GetSinglePlayerShopFilterHero()
	if dF ~= nil then
		self:AppendShopExcludedForHero(dE, dF)
	end
	local gN = self.travelingMerchantForward:__mul(128)
	local gO = self.travelingMerchantPosition:__add(gN)
	local gh = Vector(-self.travelingMerchantForward.y, self.travelingMerchantForward.x, 0)
	local gP = { -128, 0, 128 }
	local gQ = {}
	local gR = ShuffledList(a1)
	do
		local ah = 0
		while ah < #gR and #gQ < 3 do
			do
				local a2 = gR[ah + 1]
				if a2 == nil or a2 == "" or o(dE, a2) then
					goto gS
				end
				gQ[#gQ + 1] = a2
				self:AppendShopGeneratedExcluded(dE, a2)
			end
			::gS::
			ah = ah + 1
		end
	end
	do
		local ah = 0
		while ah < #gQ do
			do
				local a2 = gQ[ah + 1]
				if a2 == nil or a2 == "" then
					goto gT
				end
				local aR = gO:__add(gh:__mul(gP[ah + 1] or 0))
				local ac = self:GetTravelingMerchantItemRarity(a2)
				self:SpawnShopItemAtPosition(
					a2,
					ac,
					aR,
					"traveling_merchant_" .. tostring(ah + 1),
					false,
					nil,
					"TravelingMerchant"
				)
			end
			::gT::
			ah = ah + 1
		end
	end
	local dT = gO:__add(gN)
	Game:EachPlayer(function(a6, al)
		if Privilege:HasPrivilege("privilege_041", al) then
			self:CreateFreeTravelingMerchantItem(al, dT, a1, dE)
		end
	end)
end
function P.prototype.CreateFreeTravelingMerchantItem(self, al, V, a1, dE)
	local dU = { unpack(dE) }
	local gU = {}
	local aO = self:GetShopFilterHero(al)
	if aO ~= nil then
		self:AppendShopExcludedForHero(dU, aO)
		self:AppendShopExcludedForHero(gU, aO)
	end
	local a2
	local gR = ShuffledList(a1)
	do
		local ah = 0
		while ah < #gR do
			local bL = gR[ah + 1]
			if bL ~= nil and bL ~= "" and not o(dU, bL) then
				a2 = bL
				break
			end
			ah = ah + 1
		end
	end
	if a2 == nil then
		do
			local ah = 0
			while ah < #gR do
				local bL = gR[ah + 1]
				if bL ~= nil and bL ~= "" and not o(gU, bL) then
					a2 = bL
					break
				end
				ah = ah + 1
			end
		end
	end
	if a2 == nil then
		return
	end
	self:AppendShopGeneratedExcluded(dE, a2)
	local ac = self:GetTravelingMerchantItemRarity(a2)
	self:SpawnShopItemAtPosition(a2, ac, V, "traveling_merchant_free_" .. tostring(al), true, al, "TravelingMerchant")
end
function P.prototype.CreateInteractiveTravelingMerchant(self)
	if
		not self:HasTravelingMerchant()
		or self.travelingMerchantPosition == nil
		or IsValid(self.travelingMerchantUnit)
	then
		return
	end
	local a7 = CreateUnitByName("interact_meepo", self.travelingMerchantPosition, false, nil, nil, DOTA_TEAM_GOODGUYS)
	a7:SetForwardVector(Rotation2D(self.travelingMerchantForward, 135, true))
	self.travelingMerchantUnit = a7
	local gV = self.npcs
	gV[#gV + 1] = a7
	self:CreateTravelingMerchantShopItems()
end
function P.prototype.RollTavernItemRarity(self, a2)
	local aw = KeyValues.items[a2]
	local gW = aw and aw.RarityRange
	if gW == nil or m(tostring(gW)) == "" then
		local gX = aw and aw.Rarity
		if gX ~= nil and m(tostring(gX)) ~= "" then
			return toFiniteNumber(gX, 1)
		end
		return 1
	end
	local gY = k(
		j(g(tostring(gW), "|"), function(a6, ae)
			return toFiniteNumber(ae, 0)
		end),
		function(a6, ae)
			return ae > 0
		end
	)
	if #gY == 0 then
		return 1
	end
	local gZ = { [1] = 50, [2] = 30, [3] = 15, [4] = 4, [5] = 1 }
	local g_ = d(J)
	do
		local ah = 0
		while ah < #gY do
			local ac = gY[ah + 1]
			g_:Set(ac, gZ[ac] or 1)
			ah = ah + 1
		end
	end
	return g_:Random() or gY[1]
end
function P.prototype.CreateTavernItems(self)
	local h0 = PickList(TAVERN_ITEMS, 4)
	local h1 = { 1, 1, 1, 1 }
	local dO = self:FindInfoTarget("info_shop_item")
	if not IsValid(dO) then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 未找到 info_shop_item，跳过酒馆商品生成"
		)
		return
	end
	local h2 = dO:GetAbsOrigin()
	local dP = self:GetSymmetricShopPositions(h2, #h0)
	print((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateTavernItems: slots=") .. tostring(#dP))
	do
		local dQ = 0
		while dQ < #dP do
			do
				local a2 = h0[dQ + 1]
				local ac = h1[dQ + 1] or 1
				if a2 == nil or a2 == "" then
					goto h3
				end
				print(
					(
						(
							(
								((("[DungeonRoom " .. tostring(self.roomID)) .. "] Tavern item slot=") .. tostring(dQ))
								.. " item="
							) .. a2
						) .. " rarity="
					) .. tostring(ac)
				)
				self:SpawnShopItemAtPosition(a2, ac, dP[dQ + 1], "tavern_" .. tostring(dQ + 1))
			end
			::h3::
			dQ = dQ + 1
		end
	end
	local h4 = k(TAVERN_ITEMS, function(a6, a2)
		return not o(h0, a2)
	end)
	local dT = Vector(h2.x, h2.y - 300, h2.z)
	Game:EachPlayer(function(a6, al)
		if not Privilege:HasPrivilege("privilege_042", al) then
			return
		end
		local h5 = PickList(#h4 > 0 and h4 or TAVERN_ITEMS, 1)
		local a2 = h5[1]
		if a2 == nil or a2 == "" then
			return
		end
		local ac = h1[1] or 1
		self:SpawnShopItemAtPosition(a2, ac, dT, "tavern_free_" .. tostring(al), true, al)
	end)
end
function P.prototype.CreateFaith(self)
	local h6 = DrawPool:Draw("faith")
	if h6 then
		local a7 = CreateUnitByName(h6, self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
		local aN = Interaction:RegisterInteract(a7, InteractType.ShopItem, 200, function(a6, aO, al)
			local af = DrawPool:Draw(h6)
			if af ~= nil then
				aO:AddItemByName(af)
			end
		end)
		if aN ~= -1 then
			local h7 = self.registeredInteracts
			h7[#h7 + 1] = aN
		end
		local h8 = self.npcs
		h8[#h8 + 1] = a7
	end
end
function P.prototype.CreateOutpost(self)
	local a7 = CreateUnitByName("bonus_outpost", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local h9 = self.npcs
	h9[#h9 + 1] = a7
end
function P.prototype.ShouldCreateSecretRoom(self)
	if not DungeonManager:HasSecretRoomPrefabs() then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] 当前地形未配置隐藏房间预制体，跳过创建"
		)
		return false
	end
	local ha = DungeonManager:GetSecretRoomChance()
	local hb = RollPercentage(ha)
	print(
		(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间判定 chance=") .. tostring(ha))
			.. "% result="
		) .. tostring(hb)
	)
	return hb
end
function P.prototype.TryCreateSecretGate(self, hc, hd, he)
	if self.secretRoomPrefix ~= nil then
		return
	end
	if not self:ShouldCreateSecretRoom() then
		return
	end
	local hf = d(q, hd)
	hf:add(self.entrancePrefix)
	local hg = {}
	do
		local ah = 0
		while ah < #hc do
			local bk = hc[ah + 1]
			if bk ~= nil and not hf:has(bk) then
				hg[#hg + 1] = bk
			end
			ah = ah + 1
		end
	end
	if #hg == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 没有未使用的出口可用于隐藏房间")
		return
	end
	local hh = GetRandomElement(hg)
	if hh == nil then
		return
	end
	local hi = s(he, function(a6, hj)
		return r(hj:GetName(), hh .. "_")
	end)
	if not IsValid(hi) then
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间出口实体无效: ") .. hh)
		return
	end
	local hk = hi:GetAbsOrigin()
	local bD = self.position
	local bW = hk.x - bD.x
	local bX = hk.y - bD.y
	local fO
	if math.abs(bX) > math.abs(bW) then
		fO = vec3_top
	else
		fO = bW > 0 and vec3_right or vec3_left
	end
	local bV = hk:__add(fO:__mul(-128))
	self.secretRoomPrefix = hh
	self.secretRoomDoorPosition = hk
	self.secretRoomDoorDirection = fO
	CreateUnitByNameAsync("npc_dungeon_secret_gate", bV, true, nil, nil, DOTA_TEAM_BADGUYS, function(bi)
		if not IsValid(bi) then
			print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门创建失败")
			self.secretRoomPrefix = nil
			self.secretRoomDoorPosition = nil
			self.secretRoomDoorDirection = nil
			return
		end
		if self.isDispose then
			bi:SafeRemoveUnit()
			return
		end
		bi:SetAbsOrigin(bV)
		bi:SetForwardVector(Rotation2D(fO, 180, true))
		self.secretRoomGate = bi
		local hl = self.enemies
		hl[#hl + 1] = bi
		print(
			(
				(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门已创建: prefix=")
								.. hh
							) .. " pos=("
						) .. tostring(bV.x)
					) .. ", "
				) .. tostring(bV.y)
			) .. ")"
		)
	end)
end
function P.prototype.CreateSecretRoom(self, hm, fO)
	local hn = DungeonManager:GetSecretRoomPrefab(fO)
	if hn == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间未配置当前方向的预制体，跳过创建"
		)
		return
	end
	local function ho(a6, hp, hq)
		if hp % 64 == 0 then
			return hp
		end
		if hq > 0 then
			return math.ceil(hp / 64) * 64
		end
		if hq < 0 then
			return math.floor(hp / 64) * 64
		end
		return math.floor(hp / 64 + 0.5) * 64
	end
	local fP = Vector(ho(nil, hm.x, fO.x), ho(nil, hm.y, fO.y), hm.z)
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
													) .. hn
												) .. " door=("
											) .. tostring(hm.x)
										) .. ", "
									) .. tostring(hm.y)
								) .. ") spawn=("
							) .. tostring(fP.x)
						) .. ", "
					) .. tostring(fP.y)
				) .. ", "
			) .. tostring(fP.z)
		) .. ")"
	)
	self.isSecretRoomCreated = true
	self.secretRoomSpawnGroup = DOTA_SpawnMapAtPosition(hn, fP, true, function(a4)
		if self.isDispose then
			UnloadSpawnGroupByHandle(a4)
			return
		end
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间 onReadyToSpawn")
		ManuallyTriggerSpawnGroupCompletion(a4)
	end, function()
		if self.isDispose or self.secretRoomSpawnGroup == nil then
			return
		end
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间 onSpawnComplete")
		local function hr()
			if self.isDispose then
				return
			end
			self:RevealSecretRoomGates()
			self:OnSecretRoomContentReady(fP, fO)
		end
		if self.nativeNavigation ~= nil then
			self.nativeNavigation:AddTerrain(
				hn,
				fP,
				self:GetNativeNavigationProtectedAreas(self.secretRoomSpawnGroup),
				hr
			)
		else
			hr(nil)
		end
	end, nil)
end
function P.prototype.OnSecretRoomContentReady(self, fP, fO)
	local hs = Entities:FindAllByClassname("info_target")
	local ht = {}
	for a6, hu in ipairs(hs) do
		if hu:GetSpawnGroupHandle() == self.secretRoomSpawnGroup and p(hu:GetName(), "info_waard") then
			ht[#ht + 1] = hu:GetAbsOrigin()
		end
	end
	if #ht == 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间内未找到 info_waard 实体，使用推算中心位置"
		)
		ht[#ht + 1] = fP:__add(fO:__mul(960))
	end
	Interaction:BeginSyncBatch()
	do
		local hv = 0
		while hv < #ht do
			local hw = ht[hv + 1]
			if RollPercentage(50) then
				local bE = RandomInt(8, 15)
				local bF = 480
				do
					local ah = 0
					while ah < bE do
						local bJ = RandomFloat(0, 360)
						local aX = RandomFloat(0, bF)
						local bK = Vector(math.cos(bJ * math.pi / 180) * aX, math.sin(bJ * math.pi / 180) * aX, 0)
						local bH = hw:__add(bK)
						local aY = d(F, "item_coin_stack", bH)
						local hx = self.dropItems
						hx[#hx + 1] = aY
						local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
							aO:AddItemByName("item_coin_stack")
							aY:dispose()
						end, nil, nil, "item_coin_stack")
						if aN ~= -1 then
							local hy = self.registeredInteracts
							hy[#hy + 1] = aN
						end
						ah = ah + 1
					end
				end
				print(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间内容就绪，在 ward[")
								.. tostring(hv)
							) .. "] 周围生成 "
						) .. tostring(bE)
					) .. " 个金币堆"
				)
			else
				local aY = d(F, "item_treasure_secret", hw)
				local hz = self.dropItems
				hz[#hz + 1] = aY
				local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
					aO:AddItemByName("item_treasure_secret")
					aY:dispose()
				end, nil, nil, "item_treasure_secret")
				if aN ~= -1 then
					local hA = self.registeredInteracts
					hA[#hA + 1] = aN
				end
			end
			hv = hv + 1
		end
	end
	Interaction:EndSyncBatch()
end
function P.prototype.RevealSecretRoomGates(self)
	if self.secretRoomPrefix == nil then
		return
	end
	local hB = self:FindEntities("prop_dynamic", "prop_wall")
	local bh = self:FindEntities("prop_dynamic", "prop_gate")
	local hC = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	for a6, hD in ipairs(hB) do
		local bk = g(hD:GetName(), "_")[1]
		if bk == self.secretRoomPrefix then
			hD:AddEffects(EF_NODRAW)
		end
	end
	for a6, bi in ipairs(bh) do
		local bk = g(bi:GetName(), "_")[1]
		if bk == self.secretRoomPrefix then
			bi:AddEffects(EF_NODRAW)
		end
	end
	for a6, bi in ipairs(hC) do
		local bk = g(bi:GetName(), "_")[1]
		if bk == self.secretRoomPrefix then
			bi:AddEffects(EF_NODRAW)
		end
	end
	print(
		(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门已揭示: prefix=") .. self.secretRoomPrefix
	)
end
function P.prototype.CreateEntrance(self)
	local he = self:FindInfoTargets("info_room_start")
	if #he == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	local hE = d(q)
	for a6, hu in ipairs(he) do
		local bj = hu:GetName()
		local bk = g(bj, "_")[1]
		if bk ~= nil and bk ~= "" then
			hE:add(bk)
		end
	end
	local hF = t(hE)
	if #hF == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	self.entrancePrefix = GetRandomElement(hF) or ""
	local hG = s(he, function(a6, hj)
		return r(hj:GetName(), self.entrancePrefix .. "_")
	end)
	self.entrancePos = IsValid(hG) and hG:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
end
function P.prototype.CreateExit(self)
	local he = self:FindInfoTargets("info_room_exit")
	print(
		((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 找到 ") .. tostring(#he))
			.. " 个 info_room_exit"
	)
	if #he == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无出口实体，使用默认配置")
		return
	end
	local hE = d(q)
	for a6, hu in ipairs(he) do
		local bj = hu:GetName()
		local bk = g(bj, "_")[1]
		if bk ~= nil and bk ~= "" then
			hE:add(bk)
		end
	end
	local hF = t(hE)
	if #hF == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无有效前缀")
		return
	end
	local hH = DungeonManager:GetExitCountOverrideByIndex(self.roomID) or 1
	local hI = self.roomID + 1
	local hJ = DungeonManager:GetRoomTypeByIndex(hI)
	local hK = DungeonManager:GetRewardTypeByIndex(hI)
	local hL = DungeonManager:GetRewardOptionsByIndex(hI)
	local hM = DungeonManager:GetSpecialOptionsByIndex(hI)
	if #hM > 0 then
		hH = #hM
	elseif #hL > 1 then
		hH = #hL
	end
	hH = math.min(#hF, hH)
	local hd = PickList(hF, hH)
	local hN = {}
	local hO = {}
	if #hM > 0 then
		local hP = { unpack(hM) }
		do
			local ah = #hP - 1
			while ah > 0 do
				local cz = RandomInt(0, ah)
				local hQ = { hP[cz + 1], hP[ah + 1] }
				hP[ah + 1] = hQ[1]
				hP[cz + 1] = hQ[2]
				ah = ah - 1
			end
		end
		do
			local ah = 0
			while ah < hH do
				hN[#hN + 1] = hK
				hO[#hO + 1] = hP[ah + 1] or hP[1] or ""
				ah = ah + 1
			end
		end
	elseif #hL > 0 then
		if hH <= 1 then
			hN = { hK }
		else
			do
				local ah = 0
				while ah < hH do
					hN[#hN + 1] = hL[ah + 1] or hK
					ah = ah + 1
				end
			end
		end
	else
		hN = { hK }
	end
	self.exitInfos = {}
	local bD = self.position
	do
		local ah = 0
		while ah < #hd do
			do
				local bk = hd[ah + 1]
				if bk == nil then
					goto hR
				end
				local hi = s(he, function(a6, hj)
					return r(hj:GetName(), bk .. "_")
				end)
				local hk = IsValid(hi) and hi:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
				local bW = hk.x - bD.x
				local bX = hk.y - bD.y
				local fO
				if math.abs(bX) > math.abs(bW) then
					fO = vec3_top
				else
					fO = bW > 0 and vec3_right or vec3_left
				end
				local hS = self.exitInfos
				hS[#hS + 1] = {
					prefix = bk,
					position = hk,
					direction = fO,
					roomType = hJ,
					rewardType = hN[ah + 1] or hK,
					specialKind = hO[ah + 1],
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
													.. tostring(ah)
												) .. ": prefix="
											) .. bk
										) .. " nextType="
									) .. RoomType[hJ]
								) .. " reward="
							) .. RoomRewardType[hN[ah + 1] or hK]
						) .. " special="
					) .. (hO[ah + 1] or "-")
				)
			end
			::hR::
			ah = ah + 1
		end
	end
	self:TryCreateSecretGate(hF, hd, he)
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
												) .. tostring(hH)
											) .. "，next:"
										) .. RoomType[hJ]
									) .. "-"
								) .. RoomRewardType[hK]
							) .. " 前缀: "
						) .. table.concat(hd, ", ")
					) .. "，奖励："
				) .. table.concat(hN, ", ")
			) .. " special="
		) .. table.concat(hO, ", ")
	)
end
function P.prototype.GetExitTooltip(self, ag)
	if ag.roomType == RoomType.SPECIAL then
		if ag.specialKind == "WishingPool" then
			return "WishingPool"
		end
		if ag.specialKind == "RegenWell" then
			return "RegenWell"
		end
		if ag.specialKind == "Book" then
			return "Book"
		end
		if ag.specialKind == "Smithy" then
			return "Smithy"
		end
	end
	if
		ag.roomType == RoomType.SHOP
		or ag.roomType == RoomType.BOSS
		or ag.roomType == RoomType.STARTING
		or ag.roomType == RoomType.TAVERN
	then
		return RoomType[ag.roomType]
	end
	if ag.rewardType ~= RoomRewardType.NONE then
		return RoomRewardType[ag.rewardType]
	end
	return RoomType[ag.roomType]
end
function P.prototype.UpdateGateVisibility(self)
	local hB = self:FindEntities("prop_dynamic", "prop_wall")
	local bh = self:FindEntities("prop_dynamic", "prop_gate")
	local hC = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	local hT = d(q)
	hT:add(self.entrancePrefix)
	do
		local ah = 0
		while ah < #self.exitInfos do
			local ag = self.exitInfos[ah + 1]
			if ag ~= nil then
				hT:add(ag.prefix)
			end
			ah = ah + 1
		end
	end
	for a6, hD in ipairs(hB) do
		local bj = hD:GetName()
		local bk = g(bj, "_")[1]
		if hT:has(bk) then
			hD:AddEffects(EF_NODRAW)
		else
			hD:RemoveEffects(EF_NODRAW)
		end
	end
	for a6, bi in ipairs(bh) do
		local bj = bi:GetName()
		local bk = g(bj, "_")[1]
		if hT:has(bk) then
			bi:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bi)
		end
	end
	for a6, bi in ipairs(hC) do
		local bj = bi:GetName()
		local bk = g(bj, "_")[1]
		if hT:has(bk) then
			bi:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bi)
		end
	end
end
function P.prototype.DebugCheckEnemySpawnPositions(self, hU)
	if hU == nil then
		hU = 20
	end
	if not IsInToolsMode() or self.isDispose then
		return nil
	end
	hU = math.max(1, math.min(60, toFiniteNumber(hU, 20)))
	local c3 = self:GetEnemySpawnReference()
	local hV = {
		mapName = self.mapName,
		gridCount = #self.validGridPositions,
		invalidGridCount = 0,
		enemyCount = 0,
		invalidEnemyCount = 0,
		duration = hU,
	}
	local function hW(a6, V, hX, hY)
		local c2, ch = B:GetCode(self.mapName, V, self.position)
		local hZ = self:IsInsideEnemySpawnGates(V)
		local h_ = GridNav:IsTraversable(V)
		local i0 = GridNav:IsBlocked(V)
		local i1 = c3 ~= nil and GridNav:CanFindPath(c3, V)
		local cd = c2 == 1 and hZ and h_ and not i0 and i1
		local i2 = cd and (hY and Vector(0, 255, 255) or Vector(0, 255, 0)) or Vector(255, 0, 0)
		local i3 = GetGroundPosition(V, nil)
		local g2 = hY and 64 or 32
		local i4 = {
			Vector(i3.x - g2, i3.y - g2, i3.z + 64),
			Vector(i3.x + g2, i3.y - g2, i3.z + 64),
			Vector(i3.x + g2, i3.y + g2, i3.z + 64),
			Vector(i3.x - g2, i3.y + g2, i3.z + 64),
		}
		do
			local ah = 0
			while ah < #i4 do
				DebugDrawLineColor(i4[ah + 1], i4[(ah + 1) % #i4 + 1], i2, false, hU)
				ah = ah + 1
			end
		end
		if hY or not cd then
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
																				(
																					(
																						(
																							(
																								(
																									(
																										"[SpawnCheck] map="
																										.. self.mapName
																									)
																									.. " source="
																								)
																								.. hX
																							)
																							.. " world="
																						)
																						.. VectorToString(V)
																					) .. " local="
																				)
																				.. tostring(V.x - self.position.x)
																			) .. ","
																		)
																		.. tostring(V.y - self.position.y)
																	) .. " code="
																) .. tostring(c2 or "unknown")
															) .. " insideGates="
														) .. tostring(hZ)
													) .. " traversable="
												) .. tostring(h_)
											) .. " blocked="
										) .. tostring(i0)
									) .. " reachable="
								) .. tostring(i1)
							) .. " valid="
						) .. tostring(cd)
					) .. " reason="
				) .. (ch or "-")
			)
		end
		return cd
	end
	do
		local ah = 0
		while ah < #self.validGridPositions do
			if not hW(nil, self.validGridPositions[ah + 1], "grid:" .. tostring(ah), false) then
				hV.invalidGridCount = hV.invalidGridCount + 1
			end
			ah = ah + 1
		end
	end
	for a6, aD in ipairs(self.enemies) do
		do
			if not IsValid(aD) or not aD:IsAlive() or aD == self.secretRoomGate then
				goto i5
			end
			hV.enemyCount = hV.enemyCount + 1
			if not hW(nil, aD:GetAbsOrigin(), aD:GetUnitName(), true) then
				hV.invalidEnemyCount = hV.invalidEnemyCount + 1
			end
		end
		::i5::
	end
	do
		local ah = 0
		while ah < #self.simulateEnemies do
			do
				local aD = self.simulateEnemies[ah + 1]
				if aD.isDispose or not IsValid(aD.entity) then
					goto i6
				end
				hV.enemyCount = hV.enemyCount + 1
				if not hW(nil, aD:GetAbsOrigin(), "simulate:" .. tostring(ah), true) then
					hV.invalidEnemyCount = hV.invalidEnemyCount + 1
				end
			end
			::i6::
			ah = ah + 1
		end
	end
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
												(("[SpawnCheck] room=" .. tostring(self.roomID)) .. " map=")
												.. self.mapName
											) .. " reference="
										) .. (c3 == nil and "none" or VectorToString(c3))
									) .. " grids="
								) .. tostring(hV.gridCount)
							) .. " invalidGrids="
						) .. tostring(hV.invalidGridCount)
					) .. " enemies="
				) .. tostring(hV.enemyCount)
			) .. " invalidEnemies="
		) .. tostring(hV.invalidEnemyCount)
	)
	return hV
end
function P.prototype.GetAvailablePositionIndices(self, i7, gw)
	local bd = {}
	local c3 = self:GetEnemySpawnReference()
	do
		local ah = 0
		while ah < #self.validGridPositions do
			do
				if self.occupiedPositions[ah] ~= true then
					local i8 = self.validGridPositions[ah + 1]
					if not self:IsEnemySpawnPositionValid(i8, c3) then
						goto i9
					end
					if (i7 == nil or i8.y >= i7) and (gw == nil or i8.y <= gw) then
						bd[#bd + 1] = ah
					end
				end
			end
			::i9::
			ah = ah + 1
		end
	end
	return bd
end
function P.prototype.GetGridsAroundPosition(self, bD, g2, ia)
	if ia == nil then
		ia = 0
	end
	local dP = {}
	for a6, ib in ipairs(self:GetAvailablePositionIndices()) do
		do
			local V = self.validGridPositions[ib + 1]
			if V == nil then
				goto ic
			end
			local aX = CalcDistance(V, bD)
			if ia > 0 then
				if aX < g2 + ia and aX > g2 - ia then
					dP[#dP + 1] = V
				end
			else
				if aX < g2 then
					dP[#dP + 1] = V
				end
			end
		end
		::ic::
	end
	return dP
end
function P.prototype.GetNearestValidGridPosition(self, id)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local ie = nil
	local aU = math.huge
	local c3 = self:GetEnemySpawnReference()
	do
		local ah = 0
		while ah < #self.validGridPositions do
			do
				local V = self.validGridPositions[ah + 1]
				if V == nil or not self:IsEnemySpawnPositionValid(V, c3) then
					goto ig
				end
				local aX = CalcDistance(V, id)
				if aX < aU then
					aU = aX
					ie = V
				end
			end
			::ig::
			ah = ah + 1
		end
	end
	return ie
end
function P.prototype.IsPositionInside(self, V)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local gu = math.huge
	local gv = -math.huge
	local i7 = math.huge
	local gw = -math.huge
	for a6, cn in ipairs(self.validGridPositions) do
		if cn ~= nil then
			gu = math.min(gu, cn.x)
			gv = math.max(gv, cn.x)
			i7 = math.min(i7, cn.y)
			gw = math.max(gw, cn.y)
		end
	end
	if gu == math.huge then
		return false
	end
	local ih = GRID_SIZE * 0.5
	return V.x >= gu - ih and V.x <= gv + ih and V.y >= i7 - ih and V.y <= gw + ih
end
function P.prototype.GetRandomValidGridPosition(self)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	if #self.validGridPositions == 0 then
		return nil
	end
	local c3 = self:GetEnemySpawnReference()
	local dP = k(self.validGridPositions, function(a6, V)
		return self:IsEnemySpawnPositionValid(V, c3)
	end)
	return #dP > 0 and dP[RandomInt(0, #dP - 1) + 1] or nil
end
function P.prototype.FindEntities(self, ii, ij)
	local ik = Entities:FindAllByClassname(ii)
	local bd = {}
	for a6, hu in ipairs(ik) do
		if hu:GetSpawnGroupHandle() == self.spawnGroup and p(hu:GetName(), ij) then
			bd[#bd + 1] = hu
		end
	end
	return bd
end
function P.prototype.FindInfoTargets(self, ij)
	local ik = Entities:FindAllByClassname("info_target")
	local bd = {}
	for a6, hu in ipairs(ik) do
		if hu:GetSpawnGroupHandle() == self.spawnGroup and p(hu:GetName(), ij) then
			bd[#bd + 1] = hu
		end
	end
	return bd
end
function P.prototype.FindInfoTarget(self, ij)
	local ik = Entities:FindAllByClassname("info_target")
	for a6, hu in ipairs(ik) do
		if hu:GetSpawnGroupHandle() == self.spawnGroup and p(hu:GetName(), ij) then
			return hu
		end
	end
end
function P.prototype.RemoveUnit(self, a7)
	if IsValid(a7) then
		if BehaviorTree ~= nil then
			BehaviorTree:UnregisterUnit(a7)
		end
		if PropertySystem ~= nil then
			PropertySystem:CleanupUnitProperties(a7)
		end
		if StateSystem ~= nil then
			StateSystem:CleanupUnitStates(a7)
		end
		a7:RemoveAllModifiers(0, false, true, false)
		a7:ForceKill(false)
		a7:MakeIllusion()
		a7:AddNoDraw()
		a7:CallAbilityDestroy()
		UTIL_Remove(a7)
	end
end
function P.prototype.CreateClientItemPickupParticle(self, aR, aO)
	local il =
		ParticleManager:CreateParticleForce("particles/generic_gameplay/drop_item_pick.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(il, 0, aR)
	ParticleManager:SetParticleControlEnt(il, 1, aO, PATTACH_POINT_FOLLOW, "attach_hitloc", aO:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(il)
end
function P.prototype.DropItemFromEnemy(self, a7, im)
	local a2
	if self.guaranteedDrops ~= nil then
		for io, ip in pairs(self.guaranteedDrops) do
			if ip > 0 then
				a2 = io
				self.guaranteedDrops[io] = ip - 1
				if self.guaranteedDrops[io] <= 0 then
					f(self.guaranteedDrops, io)
				end
				break
			end
		end
	end
	local al = im:GetPlayerOwnerID()
	if a2 == nil then
		if self.dropPool == nil then
			return
		end
		local iq = Privilege:GetPlayerDynamicValue("privilege_bless_009", al, "FirstDropCount") or 0
		if iq < 1 and not RollPercentage(self.dropPool.dropChance + GetBreakDropChance(im)) then
			return
		end
		Privilege:SetPlayerDynamicValue("privilege_bless_009", al, "FirstDropCount", iq - 1)
		a2 = self.dropPool.itemPool:Random(nil)
	end
	if a2 == nil then
		return
	end
	local aH = a7:GetAbsOrigin()
	local aY = d(F, a2, aH)
	local ir = self.dropItems
	ir[#ir + 1] = aY
	local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
		aO:AddItemByName(a2)
		aY:dispose()
	end, nil, nil, a2)
	if aN ~= -1 then
		local is = self.registeredInteracts
		is[#is + 1] = aN
	end
	Event:Fire("break_drop", { itemName = a2, drop_item = aY })
end
function P.prototype.CalculateDifficultyModifiers(self)
	local it = GameRules:GetCustomGameDifficulty()
	local iu = KeyValues.difficulty[tostring(it)]
	if iu == nil then
		print(("[DungeonRoom] 警告：难度配置 " .. tostring(it)) .. " 未找到")
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		return
	end
	local iv = toFiniteNumber(iu.HealthFactor, 1)
	local iw = toFiniteNumber(iu.DamageFactor, 1)
	local ix = DungeonManager:GetZoneIndex()
	if ix == 1 then
		iv = iv * toFiniteNumber(iu.Chapter1HealthFactor, 1)
		iw = iw * toFiniteNumber(iu.Chapter1DamageFactor, 1)
	elseif ix == 2 then
		iv = iv * toFiniteNumber(iu.Chapter2HealthFactor, 1)
		iw = iw * toFiniteNumber(iu.Chapter2DamageFactor, 1)
	elseif ix == 3 then
		iv = iv * toFiniteNumber(iu.Chapter3HealthFactor, 1)
		iw = iw * toFiniteNumber(iu.Chapter3DamageFactor, 1)
	end
	local iy = Game:GetPlayerCount()
	if iy == 2 then
		iv = iv * toFiniteNumber(iu.Player2HealthFactor, 1)
		iw = iw * toFiniteNumber(iu.Player2DamageFactor, 1)
	elseif iy == 3 then
		iv = iv * toFiniteNumber(iu.Player3HealthFactor, 1)
		iw = iw * toFiniteNumber(iu.Player3DamageFactor, 1)
	elseif iy >= 4 then
		iv = iv * toFiniteNumber(iu.Player4HealthFactor, 1)
		iw = iw * toFiniteNumber(iu.Player4DamageFactor, 1)
	end
	self.difficultyHealthAmplify = (iv - 1) * 100
	self.difficultyDamageAmplify = (iw - 1) * 100
	self.difficultyCooldownReduction = DIFFICULTY_COOLDOWN_REDUCTION[it] or 0
	self.difficultyBossGapAmplify = DIFFICULTY_BOSS_GAP_AMPLIFY[it] or 0
	self.difficultyBossDamageAmplify = DIFFICULTY_BOSS_DAMAGE_AMPLIFY[it] or 0
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
																		(
																			(
																				(
																					"[DungeonRoom "
																					.. tostring(self.roomID)
																				)
																				.. "] 难度系数已计算 - 难度:"
																			) .. tostring(it)
																		) .. " 玩家:"
																	) .. tostring(iy)
																) .. " 血量:"
															) .. u(iv, 2)
														) .. "x("
													) .. u(self.difficultyHealthAmplify, 1)
												) .. "%) 伤害:"
											) .. u(iw, 2)
										) .. "x("
									) .. u(self.difficultyDamageAmplify, 1)
								) .. "%) 冷却缩减:"
							) .. tostring(self.difficultyCooldownReduction)
						) .. "% Boss间隔增幅:"
					) .. tostring(self.difficultyBossGapAmplify)
				) .. "% Boss最终伤害:"
			) .. tostring(self.difficultyBossDamageAmplify)
		) .. "%"
	)
end
function P.prototype.ApplyDifficultyModifiers(self, aD)
	local iv = self.spawnInfo.healthFactor or 1
	local iw = self.spawnInfo.damageFactor or 1
	local iz = DungeonManager:GetDifficultyKeyHealthFactor()
	local iA = DungeonManager:GetDifficultyKeyDamageFactor()
	local iB = (1 + self.difficultyHealthAmplify / 100) * iv * iz
	local iC = (1 + self.difficultyDamageAmplify / 100) * iw * iA
	local iD = (iB - 1) * 100
	local iE = (iC - 1) * 100
	print("ApplyDifficultyModifiers", iv, iw)
	if iD ~= 0 then
		aD:AddProperty(PropertyFunction.HEALTH_AMPLIFY, iD)
	end
	if iE ~= 0 then
		aD:AddProperty(PropertyFunction.ATTACK_AMPLIFY, iE)
	end
	DungeonManager:ApplyDifficultyKeyDebuffs(aD)
end
function P.prototype.DropPomReward(self, V)
	local a2 = DrawPool:Draw("pom_reward")
	if a2 ~= nil then
		local aY = d(F, a2, V)
		local iF = self.dropItems
		iF[#iF + 1] = aY
		local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
			aO:AddItemByName(a2)
			aY:dispose()
		end)
		if aN ~= -1 then
			local iG = self.registeredInteracts
			iG[#iG + 1] = aN
		end
	end
end
function P.prototype.GetRoomKey(self)
	return (tostring(self.zoneID) .. "-") .. tostring(self.roomID)
end
function P.prototype.GetRoomType(self)
	return self.roomType
end
function P.prototype.GetRewardType(self)
	return self.rewardType
end
function P.prototype.GetPosition(self)
	return Vector(self.position.x, self.position.y, self.position.z)
end
function P.prototype.GetEntrancePosition(self)
	return self.entrancePos + CalcDirection2D(self.position, self.entrancePos):__mul(100)
end
function P.prototype.IsCombatRoom(self)
	return self.roomType == RoomType.ENEMY
		or self.roomType == RoomType.ELITE
		or self.roomType == RoomType.MINI_BOSS
		or self.roomType == RoomType.BOSS
end
function P.prototype.IsBossRoom(self)
	return self.roomType == RoomType.BOSS
end
function P.prototype.GetBossName(self)
	return self.bossName
end
function P.prototype.GetNativeNavigationProtectedAreas(self, a4)
	local bd = {}
	local hu = Entities:First()
	while hu ~= nil do
		if hu:GetSpawnGroupHandle() == a4 then
			local bj = hu:GetName()
			if p(bj, "prop_gate") or p(bj, "prop_wall") or hu:IsNPC() and not hu:HasMovementCapability() then
				bd[#bd + 1] = hu:GetAbsOrigin()
			end
		end
		hu = Entities:Next(hu)
	end
	return bd
end
function P.prototype.RemovePrefabNavigationUnits(self)
	local iH = self.secretRoomSpawnGroup == nil and { self.spawnGroup } or {
			self.spawnGroup,
			self.secretRoomSpawnGroup,
		}
	local iI = {}
	local hu = Entities:First()
	while hu ~= nil do
		if hu:IsNPC() and o(iH, hu:GetSpawnGroupHandle()) then
			iI[#iI + 1] = hu
		end
		hu = Entities:Next(hu)
	end
	for a6, a7 in ipairs(iI) do
		self:RemoveUnit(a7)
	end
end
function P.prototype.IsSpawnComplete(self)
	return self.isSpawnComplete
end
function P.prototype.AddGuaranteedDropCount(self, a2, iJ)
	local iK = self.guaranteedDrops[a2] or 0
	local iL = iK + iJ
	if iL <= 0 then
		f(self.guaranteedDrops, a2)
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 移除必掉物品: ") .. a2)
	else
		self.guaranteedDrops[a2] = iL
		print(
			(
				(
					(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 增加 ") .. a2) .. " 掉落次数: ")
					.. tostring(iK)
				) .. " -> "
			) .. tostring(iL)
		)
	end
end
function P.prototype.IsCompleted(self)
	return self.isComplete
end
function P.prototype.IsCombatEnd(self)
	return self:IsCombatRoom() and self.isCombatEnd
end
function P.prototype.ClearGuaranteedDropItems(self)
	self.guaranteedDrops = {}
end
function P.prototype.GetExitInfo(self)
	return self.exitInfos
end
function P.prototype.GetTrapList(self)
	return self.dungeonTrap:GetTrapList()
end
function P.prototype.GetNpcs(self)
	return self.npcs
end
function P.prototype.GetShopItems(self)
	return self.shopItems
end
function P.prototype.GetSpawnGroup(self)
	return self.spawnGroup
end
function P.prototype.OnEntityKilled(self, iM)
	if self.isDispose then
		return
	end
	local iN = EntIndexToHScript(iM.entindex_killed)
	if not IsValid(iN) then
		return
	end
	if self.secretRoomGate ~= nil and iN == self.secretRoomGate then
		self.secretRoomGate = nil
		ArrayRemove(self.enemies, iN)
		if self.secretRoomDoorPosition ~= nil and self.secretRoomDoorDirection ~= nil then
			self:CreateSecretRoom(self.secretRoomDoorPosition, self.secretRoomDoorDirection)
		end
		return
	end
	if o(self.enemies, iN) then
		local im = EntIndexToHScript(iM.entindex_attacker)
		if IsValid(im) and im:IsRealHero() then
			self.playerKilledEnemyCount = self.playerKilledEnemyCount + 1
		end
		self:DropPreviewRewardsFromEnemy(iN)
		ArrayRemove(self.enemies, iN)
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
				local V = GetGroundPosition(iN:GetAbsOrigin(), iN)
				if not GridNav:IsValidPosition(V) then
					V = self:GetNearestValidGridPosition(V) or V
				end
				self:FinishCombat(V)
			end
		end
	end
	if o(self.breakables, iN) then
		local im = EntIndexToHScript(iM.entindex_attacker)
		self:DropItemFromEnemy(iN, im)
		return
	end
end
return v