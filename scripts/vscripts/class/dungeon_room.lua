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
		if IsValid(ae) then
			Npc:RemoveNpc(ae:entindex())
		end
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
		self:CreateHuntSaveNPC()
	end
end
function P.prototype.CreateHuntSaveNPC(self)
	local eM = tonumber
	local eN = KeyValues.hunt_intelligence["1"]
	if eN ~= nil then
		eN = eN.dungeon_diff
	end
	local eO = eM(eN)
	if eO == nil or GameRules:GetCustomGameDifficulty() < eO then
		return
	end
	local eP =
		CreateUnitByName("npc_hunt_save", self.position + Vector(500, -500, 0), false, nil, nil, DOTA_TEAM_GOODGUYS)
	eP:SetForwardVector(vec3_bottom)
	eP:AddNewModifier(nil, nil, "modifier_no_health_bar", {})
	local eQ = Interaction:RegisterInteract(eP, InteractType.NPC, 200, function(a6, eR, al)
		local eS = PlayerResource:GetPlayer(al)
		local eT = PlayerResource:GetSelectedHeroEntity(al)
		if eS == nil or not IsValid(eT) then
			return false
		end
		HuntSaveArchive:CreateSnapshot(al, eT)
		CustomGameEventManager:Send_ServerToPlayer(
			eS,
			"client_side_event",
			{
				event_name = "show_popup",
				event_data = json.encode({ popupName = "HuntSaveArchive", PopupID = "hunt_save_archive_"
					.. tostring(al) }),
			}
		)
		return false
	end, 9999)
	if eQ ~= -1 then
		Interaction:UpdateInteract(eQ, { tooltip = "hunt_save" })
		local eU = self.registeredInteracts
		eU[#eU + 1] = eQ
	end
	local eV = self.npcs
	eV[#eV + 1] = eP
end
function P.prototype.CompleteManualStairChestOpen(self, al, aN, aJ, eu, bz, eE, ey)
	if ey == nil then
		ey = false
	end
	Interaction:UnregisterInteractable(aN)
	ArrayRemove(self.registeredInteracts, aN)
	self:MarkStairChestCompleted(al)
	if ey then
		e(aJ.particleIDs, function(a6, eW)
			ParticleManager:DestroyParticle(eW, false)
		end)
		aJ.particleIDs = {}
		local eS = PlayerResource:GetPlayer(al)
		if eS ~= nil then
			local eX = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/boss_chest_open.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				eS
			)
			ParticleManager:SetParticleControl(eX, 0, aJ.entity:GetAbsOrigin())
			local eY = aJ.particleIDs
			eY[#eY + 1] = eX
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
	e(aJ.particleIDs, function(a6, eW)
		ParticleManager:DestroyParticle(eW, false)
	end)
	aJ.particleIDs = {}
	local eS = PlayerResource:GetPlayer(al)
	if eS == nil then
		return
	end
	local eZ = ParticleManager:CreateParticleForPlayer(
		"particles/generic_gameplay/boss_chest_opening.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aJ.entity,
		eS
	)
	ParticleManager:SetParticleControlEnt(eZ, 1, aJ.entity, PATTACH_INVALID, nil, aJ.entity:GetAbsOrigin(), true)
	local e_ = aJ.particleIDs
	e_[#e_ + 1] = eZ
	Timer:GameTimer(0.8, function()
		if self.isDispose or aJ.isDispose then
			return
		end
		e(aJ.particleIDs, function(a6, eW)
			ParticleManager:DestroyParticle(eW, false)
		end)
		aJ.particleIDs = {}
		local f0 = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/treasure_box/treasure_box_open_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			eS
		)
		ParticleManager:SetParticleControl(f0, 0, aJ.entity:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(f0)
		local eX = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/boss_chest_open.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			eS
		)
		ParticleManager:SetParticleControl(eX, 0, aJ.entity:GetAbsOrigin())
		local f1 = aJ.particleIDs
		f1[#f1 + 1] = eX
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
	local f2 = self:GetAliveManagedEnemies()
	if #f2 >= 5 then
		return
	end
	local f3 = {}
	for a6, aD in ipairs(f2) do
		if not UnitManager:IsUnitIndexValid(aD) then
			UnitManager:RepairUnitIndex(aD)
			f3[#f3 + 1] = aD
		end
	end
	if #f3 <= 0 or self.hasReportedUnitManagerGuard then
		return
	end
	self.hasReportedUnitManagerGuard = true
	self:ReportUnitManagerGuard(f3, #f2)
end
function P.prototype.GetAliveManagedEnemies(self)
	local f2 = {}
	do
		local ah = 0
		while ah < #self.enemies do
			local aD = self.enemies[ah + 1]
			if IsValid(aD) and aD:IsAlive() then
				f2[#f2 + 1] = aD
			end
			ah = ah + 1
		end
	end
	return f2
end
function P.prototype.ReportUnitManagerGuard(self, f3, f4)
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
				aliveEnemyCount = f4,
				trackedEnemyCount = #self.enemies,
				pendingAliveEnemyCount = self.aliveEnemyCount,
				remainingSpawnCount = self.spawnInfo.totalCount,
				repairedEnemies = j(f3, function(a6, aD)
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
	for f5 in pairs(self.stairChestPlayers) do
		d3 = d3 + 1
	end
	return d3
end
function P.prototype.RefreshStairChestPlayerStates(self)
	if self.roomType ~= RoomType.STAIR or self.isDispose or self.isComplete or self.gatesOpened then
		return
	end
	for f6 in pairs(self.stairChestPlayers) do
		do
			local al = tonumber(f6)
			if
				al == nil
				or self.stairChestCompletedPlayers[al] == true
				or self.stairChestIgnoredPlayers[al] == true
			then
				goto f7
			end
			local f8 = PlayerResource:GetConnectionState(al)
			if f8 == DOTA_CONNECTION_STATE_CONNECTED then
				goto f7
			end
			if f8 == DOTA_CONNECTION_STATE_ABANDONED then
				self.stairChestIgnoredPlayers[al] = true
				self.stairChestAutoClaimingPlayers[al] = false
				self.stairChestOpeningPlayers[al] = false
				print(
					(
						("[DungeonRoom " .. tostring(self.roomID))
						.. "] 楼梯房玩家已放弃，跳过宝箱并不再等待 player="
					) .. tostring(al)
				)
				goto f7
			end
			self:AutoClaimStairChest(al)
		end
		::f7::
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
	local f9 = 0
	local fa = 0
	local fb = 0
	local fc = 0
	for f6 in pairs(self.stairChestPlayers) do
		do
			local al = tonumber(f6)
			if al == nil then
				goto fd
			end
			f9 = f9 + 1
			if self.stairChestIgnoredPlayers[al] == true then
				fb = fb + 1
				goto fd
			end
			if self.stairChestCompletedPlayers[al] == true then
				fa = fa + 1
				goto fd
			end
			fc = fc + 1
		end
		::fd::
	end
	local fe = DungeonAdventure:AreOpenedAdventuresCompleted()
	local ff = f9 <= 0 or fc <= 0
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
												) .. tostring(ff)
											) .. " completed="
										) .. tostring(fa)
									) .. " ignored="
								) .. tostring(fb)
							) .. " waiting="
						) .. tostring(fc)
					) .. " total="
				) .. tostring(f9)
			) .. " adventuresCompleted="
		) .. tostring(fe)
	)
	if ff and fe then
		self:StopStairChestStateWatcher()
		self:OpenGates()
	end
end
function P.prototype.RequestBossChestRewards(self, al, fg, fh, eu, fi, fj)
	if fj == nil then
		fj = false
	end
	if fj and self:IsEquipmentCapacityFull(al) then
		self:ShowEquipmentCapacityDialog(al, true)
		if fi ~= nil then
			fi(nil, false)
		end
		return
	end
	local fk = false
	CommonService:RepeatCallAction(
		"/v1/settle/receive_boss_rewards",
		al,
		{
			match_id = Match:GetMatchID(),
			round = DungeonManager:GetZoneIndex(),
			room_step = DungeonManager:GetRoomIndex(),
			open_times = fg,
			use_daily_free_open_times = fh,
		},
		function(a6, fl, fm)
			if fk then
				return
			end
			fk = true
			if fm.code == 2 and fm.message == "rewards received" then
				ErrorMessage("error_boss_rewards_already_received")
				if fi ~= nil then
					fi(nil, true, true)
				end
				return
			end
			CommonService:CommonCallback(al, fm)
			self:HandleBossChestRewardsResponse(fl, fm, eu, fi)
		end,
		false
	)
end
function P.prototype.RequestStairChestRewards(self, al, fg, fh, eu, fi, fj)
	if fj == nil then
		fj = false
	end
	if DungeonManager:IsTutorial() then
		if fj and self:IsEquipmentCapacityFull(al) then
			self:ShowEquipmentCapacityDialog(al, true)
			if fi ~= nil then
				fi(nil, false)
			end
			return
		end
		CommonService:RepeatCallAction("/v1/player/receive_teach_rewards", al, {}, function(a6, fl, fm)
			if fm.code == 0 or fm.code == 200 then
				CommonService:CommonCallback(al, fm, false)
			else
				ErrorMessage("Tutorial's reward has been received", al)
				if fi ~= nil then
					fi(nil, false)
				end
				return
			end
			self:HandleBossChestRewardsResponse(fl, fm, eu, fi)
		end, false)
		return
	end
	self:RequestBossChestRewards(al, fg, fh, eu, fi, fj)
end
function P.prototype.HandleBossChestRewardsResponse(self, al, fm, eu, fi)
	if fm.code ~= 0 and fm.code ~= 200 then
		if fi ~= nil then
			fi(nil, false)
		end
		return
	end
	local fn
	if fm ~= nil then
		fn = fm.data
	end
	local fo
	if fn ~= nil then
		fo = fn.add_items
	end
	local fp = fo
	local fq
	if fp ~= nil then
		fq = fp.other
	end
	local fr = fq
	local fs
	if fm ~= nil then
		fs = fm.data
	end
	local ft
	if fs ~= nil then
		ft = fs.player_equipments
	end
	local fu = ft
	local fv
	if fm ~= nil then
		fv = fm.data
	end
	local fw
	if fv ~= nil then
		fw = fv.player_drawings
	end
	local fx = fw
	local fy
	if fm ~= nil then
		fy = fm.data
	end
	local fz
	if fy ~= nil then
		fz = fy.player_keys
	end
	local fA = fz
	local fB
	if fm ~= nil then
		fB = fm.data
	end
	local fC
	if fB ~= nil then
		fC = fB.player_notices
	end
	local fD = fC
	if fD == nil then
		fD = {}
	end
	local fE = fD
	local fF = fE[1]
	local fG = (fF and fF.key) == "BossRewards3TimesDrop"
	if fG then
		Notification:CombatToPlayer(al, { message = "Notify_BossRewards3TimesDrop" })
	end
	if not fr and not fu and not fx and not fA then
		if fi ~= nil then
			fi(nil, true)
		end
		self:ScheduleEquipmentCapacityDialog(al)
		return
	end
	if fi ~= nil then
		fi(nil, true)
	end
	self:ScheduleEquipmentCapacityDialog(al)
	Timer:GameTimer(0.8, function()
		if self.isDispose then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", eu, al)
		local fH = {}
		if fr then
			for a6, ap in ipairs(fr) do
				do
					local fI = tonumber(GetItemPropType(ap.item_id))
					if fI == 9 or fI == 19 or fI == 20 then
						goto fJ
					end
					fH[#fH + 1] =
						{ item_id = ap.item_id, amounts = ap.amounts, item_rarity = GetPropRarity(ap.item_id) }
				end
				::fJ::
			end
		end
		if fu then
			for a6, fK in ipairs(fu) do
				fH[#fH + 1] = { item_id = fK.equipment_item_id, amounts = 1, item_rarity = fK.rarity, uid = fK.id }
			end
		end
		if fx then
			for a6, fL in ipairs(fx) do
				fH[#fH + 1] = { item_id = fL.drawing_item_id, amounts = 1, item_rarity = fL.rarity, uid = fL.id }
			end
		end
		if fA then
			for a6, fM in ipairs(fA) do
				fH[#fH + 1] = { item_id = fM.key_item_id, amounts = 1, item_rarity = fM.rarity, uid = fM.id }
			end
		end
		local fN = {}
		for ah, ap in ipairs(fH) do
			fN[#fN + 1] = ap
			Timer:GameTimer(0.1 * ah, function()
				if self.isDispose then
					return
				end
				local fO = d(x, al, ap.item_id, eu, { 200, 300 })
				local fP = self.clientItems
				fP[#fP + 1] = fO
				local aN = Interaction:RegisterInteract(fO.entity, InteractType.Consumables, 200, function(a6, aO, bA)
					CommonService:SendReceiveRewards(
						bA,
						{ { item_id = ap.item_id, amounts = ap.amounts, uid = ap.uid } }
					)
					fO:dispose()
					Event:Fire("client_item_pickup", { playerID = al, item_id = ap.item_id })
				end, 1, al)
				Interaction:UpdateInteract(aN, { position = fO:GetLandedPosition() })
				Interaction:SetSecondaryInteraction(aN, function(a6, aO, al)
					local aQ = aO:GetPlayerOwnerID()
					local fQ = {}
					do
						local ah = 0
						while ah < #self.clientItems do
							do
								local aJ = self.clientItems[ah + 1]
								if aJ == nil or aJ.isDispose or not aJ:IsLanded() or not IsValid(aJ.entity) then
									goto fR
								end
								if aJ.playerID ~= aQ then
									goto fR
								end
								local aF = aJ:GetEntityIndex()
								if aF == -1 then
									goto fR
								end
								fQ[#fQ + 1] = { entityIndex = aF, position = aJ:GetLandedPosition() }
							end
							::fR::
							ah = ah + 1
						end
					end
					do
						local ah = 0
						while ah < #fQ do
							local fS = fQ[ah + 1]
							self:CreateClientItemPickupParticle(fS.position, aO)
							Interaction:ExecutePrimaryCallback(fS.entityIndex, aO, al)
							Interaction:UnregisterInteractable(fS.entityIndex)
							ArrayRemove(self.registeredInteracts, fS.entityIndex)
							ah = ah + 1
						end
					end
					self.clientItems = k(self.clientItems, function(a6, ae)
						return not ae.isDispose
					end)
				end)
				Interaction:UpdateSecondaryInteract(aN, { tooltip = "DoubleConsumables" })
				if aN ~= -1 then
					local fT = self.registeredInteracts
					fT[#fT + 1] = aN
				end
			end)
		end
		if #fN > 0 then
			Match:AddPlayerRoundRewards(al, fN)
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
function P.prototype.ShowEquipmentCapacityDialog(self, al, fU)
	Equipment:ShowCapacityDialog(al, "equipment", fU)
end
function P.prototype.CreateSpecialRoom(self)
	if self.roomType == RoomType.SPECIAL then
		local bd = self.specialKind
		if bd == nil or bd == "" then
			local fV = "special_room_zone" .. tostring(self.zoneID)
			bd = DrawPool:Draw(fV)
			print(
				(((("[DungeonRoom " .. tostring(self.roomID)) .. "] SpecialRoom fallback draw from ") .. fV) .. ": ")
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
		local fW = self.wishingPoolCount * WISHING_POOL_COST
		local eA = Privilege:GetPlayerDynamicValue("privilege_bless_012", al, "free_count") or 0
		local dJ = eA > 0 and 0 or fW
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
			local fX = CalcDirection2D(aO, self.position)
			local fY = self.position + fX * RandomInt(400, 500)
			fY.z = aO:GetAbsOrigin().z
			local aY = d(F, ap, fY)
			local fZ = self.dropItems
			fZ[#fZ + 1] = aY
			local f_ = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO, al)
				if not aY:IsLanded() then
					return false
				end
				if aO ~= nil then
					aO:AddItemByName(ap, nil, false)
				end
				aY:dispose()
			end, nil, nil, ap)
			if f_ ~= -1 then
				local g0 = self.registeredInteracts
				g0[#g0 + 1] = f_
			end
		end
		Event:Fire("wishing_pool_reward", { playerID = al, cost = dJ })
	end, 99999999)
	if aN ~= -1 then
		Interaction:UpdateInteract(
			aN,
			{ costInfo = { cost = self.wishingPoolCount * WISHING_POOL_COST, costType = "gold" } }
		)
		local g1 = self.registeredInteracts
		g1[#g1 + 1] = aN
	end
	local g2 = self.npcs
	g2[#g2 + 1] = a7
end
function P.prototype.CreateRegenWell(self)
	local a7 = CreateUnitByName("interact_regen_well", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aN = Interaction:RegisterInteract(a7, InteractType.RegenWell, 200, function(a6, aO, al)
		local g3 = a7:FindModifierByName("modifier_spawn_interact_regen_well")
		if g3 ~= nil then
			g3:Activity()
		end
	end, 1)
	if aN ~= -1 then
		local g4 = self.registeredInteracts
		g4[#g4 + 1] = aN
	end
	local g5 = self.npcs
	g5[#g5 + 1] = a7
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
		local g6 = self.registeredInteracts
		g6[#g6 + 1] = aN
	end
	local g7 = self.npcs
	g7[#g7 + 1] = a7
end
function P.prototype.CreateSmithy(self)
	local a7 = CreateUnitByName("interact_smithy", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	a7:SetForwardVector(vec3_bottom)
	local aN = Interaction:RegisterInteract(a7, InteractType.Smithy, 200, function(a6, eR, f5)
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
		local g8 = self.registeredInteracts
		g8[#g8 + 1] = aN
	end
	local g9 = self.npcs
	g9[#g9 + 1] = a7
end
function P.prototype.HasTravelingMerchant(self)
	return self.specialKind == M
end
function P.prototype.IsTravelingMerchantNear(self, V, ga)
	if self.travelingMerchantPosition == nil then
		return false
	end
	return CalcDistance(V, self.travelingMerchantPosition) <= ga
end
function P.prototype.GetTravelingMerchantTrapPositions(self)
	local gb = {}
	local gc = Entities:FindAllByClassname("prop_dynamic")
	do
		local ah = 0
		while ah < #gc do
			local gd = gc[ah + 1]
			if gd:GetSpawnGroupHandle() == self.spawnGroup and p(gd:GetName(), "trap_fire_model") then
				gb[#gb + 1] = gd:GetAbsOrigin()
			end
			ah = ah + 1
		end
	end
	return gb
end
function P.prototype.GetTravelingMerchantExitInfos(self)
	local ge = {}
	do
		local ah = 0
		while ah < #self.exitInfos do
			do
				local ag = self.exitInfos[ah + 1]
				if ag == nil then
					goto gf
				end
				ge[#ge + 1] = { position = ag.position, direction = ag.direction }
			end
			::gf::
			ah = ah + 1
		end
	end
	return ge
end
function P.prototype.IsTravelingMerchantBlockedByExit(self, V)
	local ge = self:GetTravelingMerchantExitInfos()
	local gg = GRID_SIZE * 2
	local gh = GRID_SIZE * 0.75
	do
		local ah = 0
		while ah < #ge do
			local ag = ge[ah + 1]
			local gi = V:__sub(ag.position)
			local gj = gi.x * ag.direction.x + gi.y * ag.direction.y
			local gk = -gj
			local gl = math.abs(gi.x * -ag.direction.y + gi.y * ag.direction.x)
			if gk >= 0 and gk <= gg and gl <= gh then
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
			local gm = self.validGridPositions[ah + 1]
			if gm ~= nil and CalcDistance(gm, V) <= GRID_SIZE * 0.25 then
				return true
			end
			ah = ah + 1
		end
	end
	return false
end
function P.prototype.CanPlaceTravelingMerchantAt(self, V, gn)
	if not self:IsTravelingMerchantGridPositionValid(V) then
		return false
	end
	local go = V:__add(gn:__mul(GRID_SIZE))
	local gp = Vector(-gn.y, gn.x, 0)
	local gq = V:__add(gp:__mul(GRID_SIZE))
	local gr = V:__sub(gp:__mul(GRID_SIZE))
	return self:IsTravelingMerchantGridPositionValid(go)
		and self:IsTravelingMerchantGridPositionValid(gq)
		and self:IsTravelingMerchantGridPositionValid(gr)
end
function P.prototype.GetTravelingMerchantDirectionCandidates(self, V)
	local gs = self:ResolveTravelingMerchantForward(V)
	local gt = { gs }
	local gu = { vec3_bottom, vec3_left, vec3_right }
	do
		local ah = 0
		while ah < #gu do
			local fX = gu[ah + 1]
			if fX ~= gs then
				gt[#gt + 1] = fX
			end
			ah = ah + 1
		end
	end
	return gt
end
function P.prototype.ResolveTravelingMerchantAngles(self, fX)
	if fX == vec3_left then
		return "0 180 0"
	end
	if fX == vec3_right then
		return "0 0 0"
	end
	return "0 -90 0"
end
function P.prototype.ResolveTravelingMerchantAdjustedPosition(self, V, gn)
	local gv = V
	local gw = gn:__mul(-1)
	local gx = GRID_SIZE * 0.1
	local gy = GRID_SIZE * 0.5
	local gz = 10
	do
		local gA = 0
		while gA <= gz do
			local gB = gy + gx * gA
			local cx = V:__add(gw:__mul(gB))
			if not self:IsPositionInside(cx) or not GridNav:IsValidPosition(cx) then
				break
			end
			gv = cx
			gA = gA + 1
		end
	end
	return gv
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
	local gC = math.huge
	local gD = -math.huge
	local gE = -math.huge
	do
		local ah = 0
		while ah < #self.validGridPositions do
			do
				local gm = self.validGridPositions[ah + 1]
				if gm == nil then
					goto gF
				end
				gC = math.min(gC, gm.x)
				gD = math.max(gD, gm.x)
				gE = math.max(gE, gm.y)
			end
			::gF::
			ah = ah + 1
		end
	end
	local gb = self:GetTravelingMerchantTrapPositions()
	local gG = GRID_SIZE * 1.25
	local gH = nil
	local gI = nil
	local gJ = math.huge
	local gK = -math.huge
	do
		local ah = 0
		while ah < #self.validGridPositions do
			do
				local gm = self.validGridPositions[ah + 1]
				if gm == nil then
					goto gL
				end
				if self:IsTravelingMerchantBlockedByExit(gm) then
					goto gL
				end
				local gM = false
				do
					local gN = 0
					while gN < #gb do
						if CalcDistance(gm, gb[gN + 1]) <= gG then
							gM = true
							break
						end
						gN = gN + 1
					end
				end
				if gM then
					goto gL
				end
				local gt = self:GetTravelingMerchantDirectionCandidates(gm)
				local gO = nil
				do
					local gP = 0
					while gP < #gt do
						local fX = gt[gP + 1]
						if self:CanPlaceTravelingMerchantAt(gm, fX) then
							gO = fX
							break
						end
						gP = gP + 1
					end
				end
				if gO == nil then
					goto gL
				end
				local gQ = math.min(math.abs(gm.x - gC), math.abs(gD - gm.x), math.abs(gE - gm.y))
				local gR = CalcDistance(gm, self.position)
				if gQ < gJ or gQ == gJ and gR > gK then
					gH = gm
					gI = gO
					gJ = gQ
					gK = gR
				end
			end
			::gL::
			ah = ah + 1
		end
	end
	if gH == nil or gI == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] TravelingMerchant 未找到满足前方和两侧相邻网格条件的站位，跳过创建"
		)
		return
	end
	local gv = self:ResolveTravelingMerchantAdjustedPosition(gH, gI)
	self.travelingMerchantPosition = GetGroundPosition(gv, nil)
	self.travelingMerchantForward = gI
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
	local gS = {}
	for a2, aw in pairs(KeyValues.artifact) do
		local gT = tostring
		local gU = aw.Access
		if gU == nil then
			gU = ""
		end
		if gT(gU) == "Meepo" then
			gS[#gS + 1] = tostring(a2)
		end
	end
	return gS
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
	local gV = self.travelingMerchantForward:__mul(128)
	local gW = self.travelingMerchantPosition:__add(gV)
	local gp = Vector(-self.travelingMerchantForward.y, self.travelingMerchantForward.x, 0)
	local gX = { -128, 0, 128 }
	local gY = {}
	local gZ = ShuffledList(a1)
	do
		local ah = 0
		while ah < #gZ and #gY < 3 do
			do
				local a2 = gZ[ah + 1]
				if a2 == nil or a2 == "" or o(dE, a2) then
					goto g_
				end
				gY[#gY + 1] = a2
				self:AppendShopGeneratedExcluded(dE, a2)
			end
			::g_::
			ah = ah + 1
		end
	end
	do
		local ah = 0
		while ah < #gY do
			do
				local a2 = gY[ah + 1]
				if a2 == nil or a2 == "" then
					goto h0
				end
				local aR = gW:__add(gp:__mul(gX[ah + 1] or 0))
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
			::h0::
			ah = ah + 1
		end
	end
	local dT = gW:__add(gV)
	Game:EachPlayer(function(a6, al)
		if Privilege:HasPrivilege("privilege_041", al) then
			self:CreateFreeTravelingMerchantItem(al, dT, a1, dE)
		end
	end)
end
function P.prototype.CreateFreeTravelingMerchantItem(self, al, V, a1, dE)
	local dU = { unpack(dE) }
	local h1 = {}
	local aO = self:GetShopFilterHero(al)
	if aO ~= nil then
		self:AppendShopExcludedForHero(dU, aO)
		self:AppendShopExcludedForHero(h1, aO)
	end
	local a2
	local gZ = ShuffledList(a1)
	do
		local ah = 0
		while ah < #gZ do
			local bL = gZ[ah + 1]
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
			while ah < #gZ do
				local bL = gZ[ah + 1]
				if bL ~= nil and bL ~= "" and not o(h1, bL) then
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
	local h2 = self.npcs
	h2[#h2 + 1] = a7
	self:CreateTravelingMerchantShopItems()
end
function P.prototype.RollTavernItemRarity(self, a2)
	local aw = KeyValues.items[a2]
	local h3 = aw and aw.RarityRange
	if h3 == nil or m(tostring(h3)) == "" then
		local h4 = aw and aw.Rarity
		if h4 ~= nil and m(tostring(h4)) ~= "" then
			return toFiniteNumber(h4, 1)
		end
		return 1
	end
	local h5 = k(
		j(g(tostring(h3), "|"), function(a6, ae)
			return toFiniteNumber(ae, 0)
		end),
		function(a6, ae)
			return ae > 0
		end
	)
	if #h5 == 0 then
		return 1
	end
	local h6 = { [1] = 50, [2] = 30, [3] = 15, [4] = 4, [5] = 1 }
	local h7 = d(J)
	do
		local ah = 0
		while ah < #h5 do
			local ac = h5[ah + 1]
			h7:Set(ac, h6[ac] or 1)
			ah = ah + 1
		end
	end
	return h7:Random() or h5[1]
end
function P.prototype.CreateTavernItems(self)
	local h8 = PickList(TAVERN_ITEMS, 4)
	local h9 = { 1, 1, 1, 1 }
	local dO = self:FindInfoTarget("info_shop_item")
	if not IsValid(dO) then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 未找到 info_shop_item，跳过酒馆商品生成"
		)
		return
	end
	local ha = dO:GetAbsOrigin()
	local dP = self:GetSymmetricShopPositions(ha, #h8)
	print((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateTavernItems: slots=") .. tostring(#dP))
	do
		local dQ = 0
		while dQ < #dP do
			do
				local a2 = h8[dQ + 1]
				local ac = h9[dQ + 1] or 1
				if a2 == nil or a2 == "" then
					goto hb
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
			::hb::
			dQ = dQ + 1
		end
	end
	local hc = k(TAVERN_ITEMS, function(a6, a2)
		return not o(h8, a2)
	end)
	local dT = Vector(ha.x, ha.y - 300, ha.z)
	Game:EachPlayer(function(a6, al)
		if not Privilege:HasPrivilege("privilege_042", al) then
			return
		end
		local hd = PickList(#hc > 0 and hc or TAVERN_ITEMS, 1)
		local a2 = hd[1]
		if a2 == nil or a2 == "" then
			return
		end
		local ac = h9[1] or 1
		self:SpawnShopItemAtPosition(a2, ac, dT, "tavern_free_" .. tostring(al), true, al)
	end)
end
function P.prototype.CreateFaith(self)
	local he = DrawPool:Draw("faith")
	if he then
		local a7 = CreateUnitByName(he, self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
		local aN = Interaction:RegisterInteract(a7, InteractType.ShopItem, 200, function(a6, aO, al)
			local af = DrawPool:Draw(he)
			if af ~= nil then
				aO:AddItemByName(af)
			end
		end)
		if aN ~= -1 then
			local hf = self.registeredInteracts
			hf[#hf + 1] = aN
		end
		local hg = self.npcs
		hg[#hg + 1] = a7
	end
end
function P.prototype.CreateOutpost(self)
	local a7 = CreateUnitByName("bonus_outpost", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local hh = self.npcs
	hh[#hh + 1] = a7
end
function P.prototype.ShouldCreateSecretRoom(self)
	if not DungeonManager:HasSecretRoomPrefabs() then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] 当前地形未配置隐藏房间预制体，跳过创建"
		)
		return false
	end
	local hi = DungeonManager:GetSecretRoomChance()
	local hj = RollPercentage(hi)
	print(
		(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间判定 chance=") .. tostring(hi))
			.. "% result="
		) .. tostring(hj)
	)
	return hj
end
function P.prototype.TryCreateSecretGate(self, hk, hl, hm)
	if self.secretRoomPrefix ~= nil then
		return
	end
	if not self:ShouldCreateSecretRoom() then
		return
	end
	local hn = d(q, hl)
	hn:add(self.entrancePrefix)
	local ho = {}
	do
		local ah = 0
		while ah < #hk do
			local bk = hk[ah + 1]
			if bk ~= nil and not hn:has(bk) then
				ho[#ho + 1] = bk
			end
			ah = ah + 1
		end
	end
	if #ho == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 没有未使用的出口可用于隐藏房间")
		return
	end
	local hp = GetRandomElement(ho)
	if hp == nil then
		return
	end
	local hq = s(hm, function(a6, hr)
		return r(hr:GetName(), hp .. "_")
	end)
	if not IsValid(hq) then
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间出口实体无效: ") .. hp)
		return
	end
	local hs = hq:GetAbsOrigin()
	local bD = self.position
	local bW = hs.x - bD.x
	local bX = hs.y - bD.y
	local fX
	if math.abs(bX) > math.abs(bW) then
		fX = vec3_top
	else
		fX = bW > 0 and vec3_right or vec3_left
	end
	local bV = hs:__add(fX:__mul(-128))
	self.secretRoomPrefix = hp
	self.secretRoomDoorPosition = hs
	self.secretRoomDoorDirection = fX
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
		bi:SetForwardVector(Rotation2D(fX, 180, true))
		self.secretRoomGate = bi
		local ht = self.enemies
		ht[#ht + 1] = bi
		print(
			(
				(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门已创建: prefix=")
								.. hp
							) .. " pos=("
						) .. tostring(bV.x)
					) .. ", "
				) .. tostring(bV.y)
			) .. ")"
		)
	end)
end
function P.prototype.CreateSecretRoom(self, hu, fX)
	local hv = DungeonManager:GetSecretRoomPrefab(fX)
	if hv == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间未配置当前方向的预制体，跳过创建"
		)
		return
	end
	local function hw(a6, hx, hy)
		if hx % 64 == 0 then
			return hx
		end
		if hy > 0 then
			return math.ceil(hx / 64) * 64
		end
		if hy < 0 then
			return math.floor(hx / 64) * 64
		end
		return math.floor(hx / 64 + 0.5) * 64
	end
	local fY = Vector(hw(nil, hu.x, fX.x), hw(nil, hu.y, fX.y), hu.z)
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
													) .. hv
												) .. " door=("
											) .. tostring(hu.x)
										) .. ", "
									) .. tostring(hu.y)
								) .. ") spawn=("
							) .. tostring(fY.x)
						) .. ", "
					) .. tostring(fY.y)
				) .. ", "
			) .. tostring(fY.z)
		) .. ")"
	)
	self.isSecretRoomCreated = true
	self.secretRoomSpawnGroup = DOTA_SpawnMapAtPosition(hv, fY, true, function(a4)
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
		local function hz()
			if self.isDispose then
				return
			end
			self:RevealSecretRoomGates()
			self:OnSecretRoomContentReady(fY, fX)
		end
		if self.nativeNavigation ~= nil then
			self.nativeNavigation:AddTerrain(
				hv,
				fY,
				self:GetNativeNavigationProtectedAreas(self.secretRoomSpawnGroup),
				hz
			)
		else
			hz(nil)
		end
	end, nil)
end
function P.prototype.OnSecretRoomContentReady(self, fY, fX)
	local hA = Entities:FindAllByClassname("info_target")
	local hB = {}
	for a6, hC in ipairs(hA) do
		if hC:GetSpawnGroupHandle() == self.secretRoomSpawnGroup and p(hC:GetName(), "info_waard") then
			hB[#hB + 1] = hC:GetAbsOrigin()
		end
	end
	if #hB == 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间内未找到 info_waard 实体，使用推算中心位置"
		)
		hB[#hB + 1] = fY:__add(fX:__mul(960))
	end
	Interaction:BeginSyncBatch()
	do
		local hD = 0
		while hD < #hB do
			local hE = hB[hD + 1]
			if RollPercentage(50) then
				local bE = RandomInt(8, 15)
				local bF = 480
				do
					local ah = 0
					while ah < bE do
						local bJ = RandomFloat(0, 360)
						local aX = RandomFloat(0, bF)
						local bK = Vector(math.cos(bJ * math.pi / 180) * aX, math.sin(bJ * math.pi / 180) * aX, 0)
						local bH = hE:__add(bK)
						local aY = d(F, "item_coin_stack", bH)
						local hF = self.dropItems
						hF[#hF + 1] = aY
						local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
							aO:AddItemByName("item_coin_stack")
							aY:dispose()
						end, nil, nil, "item_coin_stack")
						if aN ~= -1 then
							local hG = self.registeredInteracts
							hG[#hG + 1] = aN
						end
						ah = ah + 1
					end
				end
				print(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间内容就绪，在 ward[")
								.. tostring(hD)
							) .. "] 周围生成 "
						) .. tostring(bE)
					) .. " 个金币堆"
				)
			else
				local aY = d(F, "item_treasure_secret", hE)
				local hH = self.dropItems
				hH[#hH + 1] = aY
				local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
					aO:AddItemByName("item_treasure_secret")
					aY:dispose()
				end, nil, nil, "item_treasure_secret")
				if aN ~= -1 then
					local hI = self.registeredInteracts
					hI[#hI + 1] = aN
				end
			end
			hD = hD + 1
		end
	end
	Interaction:EndSyncBatch()
end
function P.prototype.RevealSecretRoomGates(self)
	if self.secretRoomPrefix == nil then
		return
	end
	local hJ = self:FindEntities("prop_dynamic", "prop_wall")
	local bh = self:FindEntities("prop_dynamic", "prop_gate")
	local hK = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	for a6, hL in ipairs(hJ) do
		local bk = g(hL:GetName(), "_")[1]
		if bk == self.secretRoomPrefix then
			hL:AddEffects(EF_NODRAW)
		end
	end
	for a6, bi in ipairs(bh) do
		local bk = g(bi:GetName(), "_")[1]
		if bk == self.secretRoomPrefix then
			bi:AddEffects(EF_NODRAW)
		end
	end
	for a6, bi in ipairs(hK) do
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
	local hm = self:FindInfoTargets("info_room_start")
	if #hm == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	local hM = d(q)
	for a6, hC in ipairs(hm) do
		local bj = hC:GetName()
		local bk = g(bj, "_")[1]
		if bk ~= nil and bk ~= "" then
			hM:add(bk)
		end
	end
	local hN = t(hM)
	if #hN == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	self.entrancePrefix = GetRandomElement(hN) or ""
	local hO = s(hm, function(a6, hr)
		return r(hr:GetName(), self.entrancePrefix .. "_")
	end)
	self.entrancePos = IsValid(hO) and hO:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
end
function P.prototype.CreateExit(self)
	local hm = self:FindInfoTargets("info_room_exit")
	print(
		((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 找到 ") .. tostring(#hm))
			.. " 个 info_room_exit"
	)
	if #hm == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无出口实体，使用默认配置")
		return
	end
	local hM = d(q)
	for a6, hC in ipairs(hm) do
		local bj = hC:GetName()
		local bk = g(bj, "_")[1]
		if bk ~= nil and bk ~= "" then
			hM:add(bk)
		end
	end
	local hN = t(hM)
	if #hN == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无有效前缀")
		return
	end
	local hP = DungeonManager:GetExitCountOverrideByIndex(self.roomID) or 1
	local hQ = self.roomID + 1
	local hR = DungeonManager:GetRoomTypeByIndex(hQ)
	local hS = DungeonManager:GetRewardTypeByIndex(hQ)
	local hT = DungeonManager:GetRewardOptionsByIndex(hQ)
	local hU = DungeonManager:GetSpecialOptionsByIndex(hQ)
	if #hU > 0 then
		hP = #hU
	elseif #hT > 1 then
		hP = #hT
	end
	hP = math.min(#hN, hP)
	local hl = PickList(hN, hP)
	local hV = {}
	local hW = {}
	if #hU > 0 then
		local hX = { unpack(hU) }
		do
			local ah = #hX - 1
			while ah > 0 do
				local cz = RandomInt(0, ah)
				local hY = { hX[cz + 1], hX[ah + 1] }
				hX[ah + 1] = hY[1]
				hX[cz + 1] = hY[2]
				ah = ah - 1
			end
		end
		do
			local ah = 0
			while ah < hP do
				hV[#hV + 1] = hS
				hW[#hW + 1] = hX[ah + 1] or hX[1] or ""
				ah = ah + 1
			end
		end
	elseif #hT > 0 then
		if hP <= 1 then
			hV = { hS }
		else
			do
				local ah = 0
				while ah < hP do
					hV[#hV + 1] = hT[ah + 1] or hS
					ah = ah + 1
				end
			end
		end
	else
		hV = { hS }
	end
	self.exitInfos = {}
	local bD = self.position
	do
		local ah = 0
		while ah < #hl do
			do
				local bk = hl[ah + 1]
				if bk == nil then
					goto hZ
				end
				local hq = s(hm, function(a6, hr)
					return r(hr:GetName(), bk .. "_")
				end)
				local hs = IsValid(hq) and hq:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
				local bW = hs.x - bD.x
				local bX = hs.y - bD.y
				local fX
				if math.abs(bX) > math.abs(bW) then
					fX = vec3_top
				else
					fX = bW > 0 and vec3_right or vec3_left
				end
				local h_ = self.exitInfos
				h_[#h_ + 1] = {
					prefix = bk,
					position = hs,
					direction = fX,
					roomType = hR,
					rewardType = hV[ah + 1] or hS,
					specialKind = hW[ah + 1],
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
									) .. RoomType[hR]
								) .. " reward="
							) .. RoomRewardType[hV[ah + 1] or hS]
						) .. " special="
					) .. (hW[ah + 1] or "-")
				)
			end
			::hZ::
			ah = ah + 1
		end
	end
	self:TryCreateSecretGate(hN, hl, hm)
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
												) .. tostring(hP)
											) .. "，next:"
										) .. RoomType[hR]
									) .. "-"
								) .. RoomRewardType[hS]
							) .. " 前缀: "
						) .. table.concat(hl, ", ")
					) .. "，奖励："
				) .. table.concat(hV, ", ")
			) .. " special="
		) .. table.concat(hW, ", ")
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
	local hJ = self:FindEntities("prop_dynamic", "prop_wall")
	local bh = self:FindEntities("prop_dynamic", "prop_gate")
	local hK = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	local i0 = d(q)
	i0:add(self.entrancePrefix)
	do
		local ah = 0
		while ah < #self.exitInfos do
			local ag = self.exitInfos[ah + 1]
			if ag ~= nil then
				i0:add(ag.prefix)
			end
			ah = ah + 1
		end
	end
	for a6, hL in ipairs(hJ) do
		local bj = hL:GetName()
		local bk = g(bj, "_")[1]
		if i0:has(bk) then
			hL:AddEffects(EF_NODRAW)
		else
			hL:RemoveEffects(EF_NODRAW)
		end
	end
	for a6, bi in ipairs(bh) do
		local bj = bi:GetName()
		local bk = g(bj, "_")[1]
		if i0:has(bk) then
			bi:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bi)
		end
	end
	for a6, bi in ipairs(hK) do
		local bj = bi:GetName()
		local bk = g(bj, "_")[1]
		if i0:has(bk) then
			bi:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bi)
		end
	end
end
function P.prototype.DebugCheckEnemySpawnPositions(self, i1)
	if i1 == nil then
		i1 = 20
	end
	if not IsInToolsMode() or self.isDispose then
		return nil
	end
	i1 = math.max(1, math.min(60, toFiniteNumber(i1, 20)))
	local c3 = self:GetEnemySpawnReference()
	local i2 = {
		mapName = self.mapName,
		gridCount = #self.validGridPositions,
		invalidGridCount = 0,
		enemyCount = 0,
		invalidEnemyCount = 0,
		duration = i1,
	}
	local function i3(a6, V, i4, i5)
		local c2, ch = B:GetCode(self.mapName, V, self.position)
		local i6 = self:IsInsideEnemySpawnGates(V)
		local i7 = GridNav:IsTraversable(V)
		local i8 = GridNav:IsBlocked(V)
		local i9 = c3 ~= nil and GridNav:CanFindPath(c3, V)
		local cd = c2 == 1 and i6 and i7 and not i8 and i9
		local ia = cd and (i5 and Vector(0, 255, 255) or Vector(0, 255, 0)) or Vector(255, 0, 0)
		local ib = GetGroundPosition(V, nil)
		local ga = i5 and 64 or 32
		local ic = {
			Vector(ib.x - ga, ib.y - ga, ib.z + 64),
			Vector(ib.x + ga, ib.y - ga, ib.z + 64),
			Vector(ib.x + ga, ib.y + ga, ib.z + 64),
			Vector(ib.x - ga, ib.y + ga, ib.z + 64),
		}
		do
			local ah = 0
			while ah < #ic do
				DebugDrawLineColor(ic[ah + 1], ic[(ah + 1) % #ic + 1], ia, false, i1)
				ah = ah + 1
			end
		end
		if i5 or not cd then
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
																								.. i4
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
														) .. tostring(i6)
													) .. " traversable="
												) .. tostring(i7)
											) .. " blocked="
										) .. tostring(i8)
									) .. " reachable="
								) .. tostring(i9)
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
			if not i3(nil, self.validGridPositions[ah + 1], "grid:" .. tostring(ah), false) then
				i2.invalidGridCount = i2.invalidGridCount + 1
			end
			ah = ah + 1
		end
	end
	for a6, aD in ipairs(self.enemies) do
		do
			if not IsValid(aD) or not aD:IsAlive() or aD == self.secretRoomGate then
				goto id
			end
			i2.enemyCount = i2.enemyCount + 1
			if not i3(nil, aD:GetAbsOrigin(), aD:GetUnitName(), true) then
				i2.invalidEnemyCount = i2.invalidEnemyCount + 1
			end
		end
		::id::
	end
	do
		local ah = 0
		while ah < #self.simulateEnemies do
			do
				local aD = self.simulateEnemies[ah + 1]
				if aD.isDispose or not IsValid(aD.entity) then
					goto ie
				end
				i2.enemyCount = i2.enemyCount + 1
				if not i3(nil, aD:GetAbsOrigin(), "simulate:" .. tostring(ah), true) then
					i2.invalidEnemyCount = i2.invalidEnemyCount + 1
				end
			end
			::ie::
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
								) .. tostring(i2.gridCount)
							) .. " invalidGrids="
						) .. tostring(i2.invalidGridCount)
					) .. " enemies="
				) .. tostring(i2.enemyCount)
			) .. " invalidEnemies="
		) .. tostring(i2.invalidEnemyCount)
	)
	return i2
end
function P.prototype.GetAvailablePositionIndices(self, ig, gE)
	local bd = {}
	local c3 = self:GetEnemySpawnReference()
	do
		local ah = 0
		while ah < #self.validGridPositions do
			do
				if self.occupiedPositions[ah] ~= true then
					local ih = self.validGridPositions[ah + 1]
					if not self:IsEnemySpawnPositionValid(ih, c3) then
						goto ii
					end
					if (ig == nil or ih.y >= ig) and (gE == nil or ih.y <= gE) then
						bd[#bd + 1] = ah
					end
				end
			end
			::ii::
			ah = ah + 1
		end
	end
	return bd
end
function P.prototype.GetGridsAroundPosition(self, bD, ga, ij)
	if ij == nil then
		ij = 0
	end
	local dP = {}
	for a6, ik in ipairs(self:GetAvailablePositionIndices()) do
		do
			local V = self.validGridPositions[ik + 1]
			if V == nil then
				goto il
			end
			local aX = CalcDistance(V, bD)
			if ij > 0 then
				if aX < ga + ij and aX > ga - ij then
					dP[#dP + 1] = V
				end
			else
				if aX < ga then
					dP[#dP + 1] = V
				end
			end
		end
		::il::
	end
	return dP
end
function P.prototype.GetNearestValidGridPosition(self, im)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local io = nil
	local aU = math.huge
	local c3 = self:GetEnemySpawnReference()
	do
		local ah = 0
		while ah < #self.validGridPositions do
			do
				local V = self.validGridPositions[ah + 1]
				if V == nil or not self:IsEnemySpawnPositionValid(V, c3) then
					goto ip
				end
				local aX = CalcDistance(V, im)
				if aX < aU then
					aU = aX
					io = V
				end
			end
			::ip::
			ah = ah + 1
		end
	end
	return io
end
function P.prototype.IsPositionInside(self, V)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local gC = math.huge
	local gD = -math.huge
	local ig = math.huge
	local gE = -math.huge
	for a6, cn in ipairs(self.validGridPositions) do
		if cn ~= nil then
			gC = math.min(gC, cn.x)
			gD = math.max(gD, cn.x)
			ig = math.min(ig, cn.y)
			gE = math.max(gE, cn.y)
		end
	end
	if gC == math.huge then
		return false
	end
	local iq = GRID_SIZE * 0.5
	return V.x >= gC - iq and V.x <= gD + iq and V.y >= ig - iq and V.y <= gE + iq
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
function P.prototype.FindEntities(self, ir, is)
	local it = Entities:FindAllByClassname(ir)
	local bd = {}
	for a6, hC in ipairs(it) do
		if hC:GetSpawnGroupHandle() == self.spawnGroup and p(hC:GetName(), is) then
			bd[#bd + 1] = hC
		end
	end
	return bd
end
function P.prototype.FindInfoTargets(self, is)
	local it = Entities:FindAllByClassname("info_target")
	local bd = {}
	for a6, hC in ipairs(it) do
		if hC:GetSpawnGroupHandle() == self.spawnGroup and p(hC:GetName(), is) then
			bd[#bd + 1] = hC
		end
	end
	return bd
end
function P.prototype.FindInfoTarget(self, is)
	local it = Entities:FindAllByClassname("info_target")
	for a6, hC in ipairs(it) do
		if hC:GetSpawnGroupHandle() == self.spawnGroup and p(hC:GetName(), is) then
			return hC
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
	local iu =
		ParticleManager:CreateParticleForce("particles/generic_gameplay/drop_item_pick.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(iu, 0, aR)
	ParticleManager:SetParticleControlEnt(iu, 1, aO, PATTACH_POINT_FOLLOW, "attach_hitloc", aO:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(iu)
end
function P.prototype.DropItemFromEnemy(self, a7, iv)
	local a2
	if self.guaranteedDrops ~= nil then
		for iw, ix in pairs(self.guaranteedDrops) do
			if ix > 0 then
				a2 = iw
				self.guaranteedDrops[iw] = ix - 1
				if self.guaranteedDrops[iw] <= 0 then
					f(self.guaranteedDrops, iw)
				end
				break
			end
		end
	end
	local al = iv:GetPlayerOwnerID()
	if a2 == nil then
		if self.dropPool == nil then
			return
		end
		local iy = Privilege:GetPlayerDynamicValue("privilege_bless_009", al, "FirstDropCount") or 0
		if iy < 1 and not RollPercentage(self.dropPool.dropChance + GetBreakDropChance(iv)) then
			return
		end
		Privilege:SetPlayerDynamicValue("privilege_bless_009", al, "FirstDropCount", iy - 1)
		a2 = self.dropPool.itemPool:Random(nil)
	end
	if a2 == nil then
		return
	end
	local aH = a7:GetAbsOrigin()
	local aY = d(F, a2, aH)
	local iz = self.dropItems
	iz[#iz + 1] = aY
	local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
		aO:AddItemByName(a2)
		aY:dispose()
	end, nil, nil, a2)
	if aN ~= -1 then
		local iA = self.registeredInteracts
		iA[#iA + 1] = aN
	end
	Event:Fire("break_drop", { itemName = a2, drop_item = aY })
end
function P.prototype.CalculateDifficultyModifiers(self)
	local iB = GameRules:GetCustomGameDifficulty()
	local iC = KeyValues.difficulty[tostring(iB)]
	if iC == nil then
		print(("[DungeonRoom] 警告：难度配置 " .. tostring(iB)) .. " 未找到")
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		return
	end
	local iD = toFiniteNumber(iC.HealthFactor, 1)
	local iE = toFiniteNumber(iC.DamageFactor, 1)
	local iF = DungeonManager:GetZoneIndex()
	if iF == 1 then
		iD = iD * toFiniteNumber(iC.Chapter1HealthFactor, 1)
		iE = iE * toFiniteNumber(iC.Chapter1DamageFactor, 1)
	elseif iF == 2 then
		iD = iD * toFiniteNumber(iC.Chapter2HealthFactor, 1)
		iE = iE * toFiniteNumber(iC.Chapter2DamageFactor, 1)
	elseif iF == 3 then
		iD = iD * toFiniteNumber(iC.Chapter3HealthFactor, 1)
		iE = iE * toFiniteNumber(iC.Chapter3DamageFactor, 1)
	end
	local iG = Game:GetPlayerCount()
	if iG == 2 then
		iD = iD * toFiniteNumber(iC.Player2HealthFactor, 1)
		iE = iE * toFiniteNumber(iC.Player2DamageFactor, 1)
	elseif iG == 3 then
		iD = iD * toFiniteNumber(iC.Player3HealthFactor, 1)
		iE = iE * toFiniteNumber(iC.Player3DamageFactor, 1)
	elseif iG >= 4 then
		iD = iD * toFiniteNumber(iC.Player4HealthFactor, 1)
		iE = iE * toFiniteNumber(iC.Player4DamageFactor, 1)
	end
	self.difficultyHealthAmplify = (iD - 1) * 100
	self.difficultyDamageAmplify = (iE - 1) * 100
	self.difficultyCooldownReduction = DIFFICULTY_COOLDOWN_REDUCTION[iB] or 0
	self.difficultyBossGapAmplify = DIFFICULTY_BOSS_GAP_AMPLIFY[iB] or 0
	self.difficultyBossDamageAmplify = DIFFICULTY_BOSS_DAMAGE_AMPLIFY[iB] or 0
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
																			) .. tostring(iB)
																		) .. " 玩家:"
																	) .. tostring(iG)
																) .. " 血量:"
															) .. u(iD, 2)
														) .. "x("
													) .. u(self.difficultyHealthAmplify, 1)
												) .. "%) 伤害:"
											) .. u(iE, 2)
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
	local iD = self.spawnInfo.healthFactor or 1
	local iE = self.spawnInfo.damageFactor or 1
	local iH = DungeonManager:GetDifficultyKeyHealthFactor()
	local iI = DungeonManager:GetDifficultyKeyDamageFactor()
	local iJ = (1 + self.difficultyHealthAmplify / 100) * iD * iH
	local iK = (1 + self.difficultyDamageAmplify / 100) * iE * iI
	local iL = (iJ - 1) * 100
	local iM = (iK - 1) * 100
	print("ApplyDifficultyModifiers", iD, iE)
	if iL ~= 0 then
		aD:AddProperty(PropertyFunction.HEALTH_AMPLIFY, iL)
	end
	if iM ~= 0 then
		aD:AddProperty(PropertyFunction.ATTACK_AMPLIFY, iM)
	end
	DungeonManager:ApplyDifficultyKeyDebuffs(aD)
end
function P.prototype.DropPomReward(self, V)
	local a2 = DrawPool:Draw("pom_reward")
	if a2 ~= nil then
		local aY = d(F, a2, V)
		local iN = self.dropItems
		iN[#iN + 1] = aY
		local aN = Interaction:RegisterInteract(aY.entity, InteractType.Chest, 200, function(a6, aO)
			aO:AddItemByName(a2)
			aY:dispose()
		end)
		if aN ~= -1 then
			local iO = self.registeredInteracts
			iO[#iO + 1] = aN
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
	local hC = Entities:First()
	while hC ~= nil do
		if hC:GetSpawnGroupHandle() == a4 then
			local bj = hC:GetName()
			if p(bj, "prop_gate") or p(bj, "prop_wall") or hC:IsNPC() and not hC:HasMovementCapability() then
				bd[#bd + 1] = hC:GetAbsOrigin()
			end
		end
		hC = Entities:Next(hC)
	end
	return bd
end
function P.prototype.RemovePrefabNavigationUnits(self)
	local iP = self.secretRoomSpawnGroup == nil and { self.spawnGroup } or {
			self.spawnGroup,
			self.secretRoomSpawnGroup,
		}
	local iQ = {}
	local hC = Entities:First()
	while hC ~= nil do
		if hC:IsNPC() and o(iP, hC:GetSpawnGroupHandle()) then
			iQ[#iQ + 1] = hC
		end
		hC = Entities:Next(hC)
	end
	for a6, a7 in ipairs(iQ) do
		self:RemoveUnit(a7)
	end
end
function P.prototype.IsSpawnComplete(self)
	return self.isSpawnComplete
end
function P.prototype.AddGuaranteedDropCount(self, a2, iR)
	local iS = self.guaranteedDrops[a2] or 0
	local iT = iS + iR
	if iT <= 0 then
		f(self.guaranteedDrops, a2)
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 移除必掉物品: ") .. a2)
	else
		self.guaranteedDrops[a2] = iT
		print(
			(
				(
					(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 增加 ") .. a2) .. " 掉落次数: ")
					.. tostring(iS)
				) .. " -> "
			) .. tostring(iT)
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
function P.prototype.OnEntityKilled(self, iU)
	if self.isDispose then
		return
	end
	local iV = EntIndexToHScript(iU.entindex_killed)
	if not IsValid(iV) then
		return
	end
	if self.secretRoomGate ~= nil and iV == self.secretRoomGate then
		self.secretRoomGate = nil
		ArrayRemove(self.enemies, iV)
		if self.secretRoomDoorPosition ~= nil and self.secretRoomDoorDirection ~= nil then
			self:CreateSecretRoom(self.secretRoomDoorPosition, self.secretRoomDoorDirection)
		end
		return
	end
	if o(self.enemies, iV) then
		local iv = EntIndexToHScript(iU.entindex_attacker)
		if IsValid(iv) and iv:IsRealHero() then
			self.playerKilledEnemyCount = self.playerKilledEnemyCount + 1
		end
		self:DropPreviewRewardsFromEnemy(iV)
		ArrayRemove(self.enemies, iV)
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
				local V = GetGroundPosition(iV:GetAbsOrigin(), iV)
				if not GridNav:IsValidPosition(V) then
					V = self:GetNearestValidGridPosition(V) or V
				end
				self:FinishCombat(V)
			end
		end
	end
	if o(self.breakables, iV) then
		local iv = EntIndexToHScript(iU.entindex_attacker)
		self:DropItemFromEnemy(iV, iv)
		return
	end
end
return v