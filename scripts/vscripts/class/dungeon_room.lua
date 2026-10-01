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
	self.difficultyBossDamageAmplify = 0
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
			if self.difficultyBossDamageAmplify ~= 0 then
				d4:AddProperty(PropertyFunction.FINAL_DAMAGE, self.difficultyBossDamageAmplify)
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
			local dk = math.max(0, math.min(100, GetShopRefreshRefund(aH)))
			if dk > 0 then
				local dl = dj * dk * 0.01
				Player:ModifyGold(ae, dl, true, true, false)
			end
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
			local dm = self.registeredInteracts
			dm[#dm + 1] = aG
			self.shopRefreshInteractIndex = aG
		end
		self.shopRefreshUnit = a1
		local dn = self.npcs
		dn[#dn + 1] = a1
	end
	local dp = self:FindInfoTarget("info_shop_item")
	if not IsValid(dp) then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] ⚠️ 未找到 info_shop_item，跳过常规商店商品生成"
		)
		return
	end
	local dq = self:GetSymmetricShopPositions(dp:GetAbsOrigin(), SHOP_ITEM_COUNT)
	do
		local dr = 0
		while dr < #dq do
			do
				local a6 = 1
				local Y
				do
					local ds = 0
					while ds < 10 do
						a6 = self:RollShopRarity()
						Y = DrawPool:PickShopItemNameByRarity(a6, de)
						if Y ~= nil then
							break
						end
						ds = ds + 1
					end
				end
				if Y == nil then
					Y = DrawPool:Draw("items", de)
					a6 = 1
				end
				if Y == nil then
					goto dt
				end
				self:AppendShopGeneratedExcluded(de, Y)
				self:SpawnShopItemAtPosition(Y, a6, dq[dr + 1], "item_" .. tostring(dr + 1))
			end
			::dt::
			dr = dr + 1
		end
	end
	if not dd then
		local du = Vector(dp:GetAbsOrigin().x, dp:GetAbsOrigin().y - 300, dp:GetAbsOrigin().z)
		Game:EachPlayer(function(a0, ae)
			if Privilege:HasPrivilege("privilege_bless_003", ae) then
				self:CreateFreeShopItem(ae, du, de)
			end
		end)
	end
end
function K.prototype.CreateFreeShopItem(self, ae, Q, de)
	local dv = { unpack(de) }
	local aH = self:GetShopFilterHero(ae)
	if aH ~= nil then
		self:AppendShopExcludedForHero(dv, aH)
	end
	local Y
	local a6 = 1
	local dw = ShuffledList({ 3, 4, 5 })
	do
		local aa = 0
		while aa < #dw do
			local dx = dw[aa + 1]
			Y = DrawPool:PickShopItemNameByRarity(dx, dv)
			if Y ~= nil then
				a6 = dx
				break
			end
			aa = aa + 1
		end
	end
	if Y == nil then
		Y = DrawPool:Draw("items", dv)
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
	Game:EachPlayer(function(a0, dy)
		if b6 ~= nil then
			return
		end
		local aH = PlayerResource:GetSelectedHeroEntity(dy)
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
	local dz = {}
	local dA = aH:GetAllItems()
	do
		local aa = 0
		while aa < #dA do
			do
				local a8 = dA[aa + 1]
				if not IsValid(a8) then
					goto dB
				end
				local Y = a8:GetAbilityName()
				local dC = KeyValues.items[Y]
				if dC == nil then
					goto dB
				end
				local dD = toFiniteNumber(dC.Quantitylimit, 0)
				if dD > 0 and aH:GetItemCount(Y) >= dD then
					self:AppendShopExcludedItem(de, Y)
				end
				local dE = self:GetArtifactUpgradeGroup(Y)
				local dF = self:GetArtifactUpgradeRank(Y)
				if dE ~= "" and dF > (dz[dE] or 0) then
					dz[dE] = dF
				end
			end
			::dB::
			aa = aa + 1
		end
	end
	for Y, ap in pairs(KeyValues.items) do
		do
			local dG = tostring
			local dH = ap.UpgradeGroup
			if dH == nil then
				dH = ""
			end
			local dE = dG(dH)
			if dE == "" then
				goto dI
			end
			local dJ = dz[dE]
			if dJ == nil then
				goto dI
			end
			local dF = toFiniteNumber(ap.UpgradeRank, 0)
			if dF > 0 and dF <= dJ then
				self:AppendShopExcludedItem(de, Y)
			end
		end
		::dI::
	end
end
function K.prototype.AppendShopGeneratedExcluded(self, de, Y)
	self:AppendShopExcludedItem(de, Y)
	local dE = self:GetArtifactUpgradeGroup(Y)
	local dF = self:GetArtifactUpgradeRank(Y)
	if dE == "" or dF <= 0 then
		return
	end
	for dK, ap in pairs(KeyValues.items) do
		do
			local dL = tostring
			local dM = ap.UpgradeGroup
			if dM == nil then
				dM = ""
			end
			if dL(dM) ~= dE then
				goto dN
			end
			local dO = toFiniteNumber(ap.UpgradeRank, 0)
			if dO > 0 and dO <= dF then
				self:AppendShopExcludedItem(de, dK)
			end
		end
		::dN::
	end
end
function K.prototype.AppendShopExcludedItem(self, de, Y)
	if not m(de, Y) then
		de[#de + 1] = Y
	end
end
function K.prototype.GetArtifactUpgradeGroup(self, Y)
	local dP = tostring
	local dQ = KeyValues.items[Y]
	if dQ ~= nil then
		dQ = dQ.UpgradeGroup
	end
	local dR = dQ
	if dR == nil then
		dR = ""
	end
	return dP(dR)
end
function K.prototype.GetArtifactUpgradeRank(self, Y)
	local dS = toFiniteNumber
	local dT = KeyValues.items[Y]
	if dT ~= nil then
		dT = dT.UpgradeRank
	end
	return dS(dT, 0)
end
function K.prototype.SpawnShopItemAtPosition(self, Y, a6, Q, dU, dV, dW, dX)
	if dV == nil then
		dV = false
	end
	if dX == nil then
		dX = "Default"
	end
	print(
		(
			(
				(
					((((("[DungeonRoom " .. tostring(self.roomID)) .. "] Shop item slot=") .. dU) .. " item=") .. Y)
					.. " rarity="
				) .. tostring(a6)
			) .. " free="
		) .. tostring(dV)
	)
	local aR = d(C, Y, a6, Q, dV, dW, dX)
	Interaction:RegisterShopItemInteract(aR)
	local dY = self.registeredInteracts
	dY[#dY + 1] = aR:GetEntityIndex()
	local dZ = self.shopItems
	dZ[#dZ + 1] = aR
end
function K.prototype.GetSymmetricShopPositions(self, bw, cK)
	local dq = {}
	local d_ = 256 - (cK - 2) * 32
	local e0 = -((cK - 1) * d_) * 0.5
	do
		local dr = 0
		while dr < cK do
			local bT = e0 + dr * d_
			dq[#dq + 1] = Vector(bw.x + bT, bw.y, bw.z)
			dr = dr + 1
		end
	end
	return dq
end
function K.prototype.ClearShopRefreshInteract(self)
	if self.shopRefreshInteractIndex ~= nil then
		Interaction:UnregisterInteractable(self.shopRefreshInteractIndex)
		local e1 = {}
		do
			local aa = 0
			while aa < #self.registeredInteracts do
				local ay = self.registeredInteracts[aa + 1]
				if ay ~= self.shopRefreshInteractIndex then
					e1[#e1 + 1] = ay
				end
				aa = aa + 1
			end
		end
		self.registeredInteracts = e1
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
	local e2 = {}
	do
		local aa = 0
		while aa < #self.shopItems do
			do
				local e3 = self.shopItems[aa + 1]
				if e3 == nil then
					goto e4
				end
				local ay = e3:GetEntityIndex()
				if ay == -1 then
					goto e4
				end
				Interaction:UnregisterInteractable(ay)
				e2[ay] = true
				e3:dispose()
			end
			::e4::
			aa = aa + 1
		end
	end
	self.shopItems = {}
	local e1 = {}
	do
		local aa = 0
		while aa < #self.registeredInteracts do
			local ay = self.registeredInteracts[aa + 1]
			if e2[ay] ~= true then
				e1[#e1 + 1] = ay
			end
			aa = aa + 1
		end
	end
	self.registeredInteracts = e1
	self:ClearShopRefreshInteract()
	self:CreateShopItem(true)
	Interaction:EndSyncBatch()
end
function K.prototype.CreateStairItem(self)
	local e5 = GetGroundPosition(self.position, nil)
	self.stairChestPlayers = {}
	self.stairChestCompletedPlayers = {}
	self.stairChestAutoClaimingPlayers = {}
	self.stairChestOpeningPlayers = {}
	self.stairChestIgnoredPlayers = {}
	self.stairChestItemPos = e5
	local e6 = DungeonManager:IsTutorial()
	Game:EachPlayer(function(a0, ae)
		self.stairChestPlayers[ae] = true
		local aC = d(w, ae, "9900000", e5, { 0, 0 })
		local e7 = self.clientItems
		e7[#e7 + 1] = aC
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
			self:RequestStairChestRewards(ae, 1, false, e5, function(a0, e8, e9)
				self.stairChestOpeningPlayers[ae] = false
				if not e8 or self.isDispose or self.stairChestIgnoredPlayers[ae] == true then
					if DungeonManager:IsTutorial() then
						self:CompleteManualStairChestOpen(ae, aG, aC, e5, false, false)
						self:OpenGates()
						return
					end
					self:TryOpenStairGatesByChestState()
					return
				end
				self:CompleteManualStairChestOpen(ae, aG, aC, e5, false, false, e9)
			end, true)
			return false
		end, nil, ae)
		if not e6 then
			Interaction:SetSecondaryInteraction(aG, function(a0, aH)
				if not self:CanOpenStairChest(ae) then
					return false
				end
				if self:IsEquipmentCapacityFull(ae) then
					self:ShowEquipmentCapacityDialog(ae, true)
					return false
				end
				local ea = Privilege:HasPrivilege("privilege_bless_001", ae)
				local eb = ea and Privilege:GetPrivilegeSpecialValue("privilege_bless_001", 1, "free_count", aH) or 0
				local ec = CommonService:GetPlayerServiceNetTable(ae, "player_counters") or {}
				local ed = ec.daily_free_boss_rewards
				local ee = ed and ed.count or 0
				local ef = ee < eb
				print(
					(
						(
							(
								(
									(
										((("[DungeonRoom " .. tostring(self.roomID)) .. "] Player ") .. tostring(ae))
										.. " Open Boss Chest Rewards isUseFreeCount="
									) .. tostring(ef)
								) .. " usedFreeCount="
							) .. tostring(ee)
						) .. " freeCount="
					) .. tostring(eb)
				)
				if not ef then
					local eg = CommonService:GetPlayerServiceNetTable(ae, "player_tokens") or {}
					local eh = eg["110006"]
					if (eh and eh.amounts or 0) < 1 then
						ErrorMessage("error_token_no_enough", ae)
						return false
					end
				end
				self.stairChestOpeningPlayers[ae] = true
				self:RequestStairChestRewards(ae, 2, ef, e5, function(a0, e8, e9)
					self.stairChestOpeningPlayers[ae] = false
					if not e8 or self.isDispose or self.stairChestIgnoredPlayers[ae] == true then
						self:TryOpenStairGatesByChestState()
						return
					end
					self:CompleteManualStairChestOpen(ae, aG, aC, e5, true, ef, e9)
				end, true)
				return false
			end)
			local aH = PlayerResource:GetSelectedHeroEntity(ae)
			local ea = Privilege:HasPrivilege("privilege_bless_001", ae)
			local eb = ea and Privilege:GetPrivilegeSpecialValue("privilege_bless_001", 1, "free_count", aH) or 0
			local ec = CommonService:GetPlayerServiceNetTable(ae, "player_counters") or {}
			local ei = ec.daily_free_boss_rewards
			local ee = ei and ei.count or 0
			Interaction:UpdateSecondaryInteract(
				aG,
				{ tooltip = "DoubleBossChest", costInfo = {
					cost = 1,
					costType = "110006",
					costSource = "tokens",
					freeCount = eb - ee,
				} }
			)
		end
		if aG ~= -1 then
			local ej = self.registeredInteracts
			ej[#ej + 1] = aG
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
		local ek = a1:FindModifierByName("modifier_spawn_interact_regen_well")
		if ek ~= nil then
			ek:Activity()
		end
	end, 1)
	if aG ~= -1 then
		local el = self.registeredInteracts
		el[#el + 1] = aG
	end
	local em = self.npcs
	em[#em + 1] = a1
	if DungeonManager:IsFinalZone(self.zoneID) then
		DungeonAdventure:OpenAdventure(self.zoneID, self.roomType, self.position)
	end
end
function K.prototype.CompleteManualStairChestOpen(self, ae, aG, aC, e5, bs, ef, e9)
	if e9 == nil then
		e9 = false
	end
	Interaction:UnregisterInteractable(aG)
	ArrayRemove(self.registeredInteracts, aG)
	self:MarkStairChestCompleted(ae)
	if e9 then
		e(aC.particleIDs, function(a0, en)
			ParticleManager:DestroyParticle(en, false)
		end)
		aC.particleIDs = {}
		local eo = PlayerResource:GetPlayer(ae)
		if eo ~= nil then
			local ep = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/boss_chest_open.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				eo
			)
			ParticleManager:SetParticleControl(ep, 0, aC.entity:GetAbsOrigin())
			local eq = aC.particleIDs
			eq[#eq + 1] = ep
		end
		return
	end
	if not DungeonManager:IsTutorial() then
		local b7 = DungeonManager:GetRoomIndex() + 1
		Service:ReportClick(ae, "dungeon", "reward_room|open_chest|room_" .. tostring(b7))
	end
	EmitSoundOnLocationForPlayer(bs and "Chess.LongOpen" or "Chess.Open", e5, ae)
	if ef then
		Notification:CombatToPlayer(ae, { message = "Notify_FreeOpenBossRewards" })
	end
	e(aC.particleIDs, function(a0, en)
		ParticleManager:DestroyParticle(en, false)
	end)
	aC.particleIDs = {}
	local eo = PlayerResource:GetPlayer(ae)
	if eo == nil then
		return
	end
	local er = ParticleManager:CreateParticleForPlayer(
		"particles/generic_gameplay/boss_chest_opening.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aC.entity,
		eo
	)
	ParticleManager:SetParticleControlEnt(er, 1, aC.entity, PATTACH_INVALID, nil, aC.entity:GetAbsOrigin(), true)
	local es = aC.particleIDs
	es[#es + 1] = er
	Timer:GameTimer(0.8, function()
		if self.isDispose or aC.isDispose then
			return
		end
		e(aC.particleIDs, function(a0, en)
			ParticleManager:DestroyParticle(en, false)
		end)
		aC.particleIDs = {}
		local et = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/treasure_box/treasure_box_open_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			eo
		)
		ParticleManager:SetParticleControl(et, 0, aC.entity:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(et)
		local ep = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/boss_chest_open.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			eo
		)
		ParticleManager:SetParticleControl(ep, 0, aC.entity:GetAbsOrigin())
		local eu = aC.particleIDs
		eu[#eu + 1] = ep
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
	local ev = self:GetAliveManagedEnemies()
	if #ev >= 5 then
		return
	end
	local ew = {}
	for a0, aw in ipairs(ev) do
		if not UnitManager:IsUnitIndexValid(aw) then
			UnitManager:RepairUnitIndex(aw)
			ew[#ew + 1] = aw
		end
	end
	if #ew <= 0 or self.hasReportedUnitManagerGuard then
		return
	end
	self.hasReportedUnitManagerGuard = true
	self:ReportUnitManagerGuard(ew, #ev)
end
function K.prototype.GetAliveManagedEnemies(self)
	local ev = {}
	do
		local aa = 0
		while aa < #self.enemies do
			local aw = self.enemies[aa + 1]
			if IsValid(aw) and aw:IsAlive() then
				ev[#ev + 1] = aw
			end
			aa = aa + 1
		end
	end
	return ev
end
function K.prototype.ReportUnitManagerGuard(self, ew, ex)
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
				aliveEnemyCount = ex,
				trackedEnemyCount = #self.enemies,
				pendingAliveEnemyCount = self.aliveEnemyCount,
				remainingSpawnCount = self.spawnInfo.totalCount,
				repairedEnemies = k(ew, function(a0, aw)
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
	for ey in pairs(self.stairChestPlayers) do
		cK = cK + 1
	end
	return cK
end
function K.prototype.RefreshStairChestPlayerStates(self)
	if self.roomType ~= RoomType.STAIR or self.isDispose or self.isComplete or self.gatesOpened then
		return
	end
	for ez in pairs(self.stairChestPlayers) do
		do
			local ae = tonumber(ez)
			if
				ae == nil
				or self.stairChestCompletedPlayers[ae] == true
				or self.stairChestIgnoredPlayers[ae] == true
			then
				goto eA
			end
			local eB = PlayerResource:GetConnectionState(ae)
			if eB == DOTA_CONNECTION_STATE_CONNECTED then
				goto eA
			end
			if eB == DOTA_CONNECTION_STATE_ABANDONED then
				self.stairChestIgnoredPlayers[ae] = true
				self.stairChestAutoClaimingPlayers[ae] = false
				self.stairChestOpeningPlayers[ae] = false
				print(
					(
						("[DungeonRoom " .. tostring(self.roomID))
						.. "] 楼梯房玩家已放弃，跳过宝箱并不再等待 player="
					) .. tostring(ae)
				)
				goto eA
			end
			self:AutoClaimStairChest(ae)
		end
		::eA::
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
	self:RequestStairChestRewards(ae, 1, false, self.stairChestItemPos, function(a0, e8)
		self.stairChestAutoClaimingPlayers[ae] = false
		if not e8 then
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
	local eC = 0
	local eD = 0
	local eE = 0
	local eF = 0
	for ez in pairs(self.stairChestPlayers) do
		do
			local ae = tonumber(ez)
			if ae == nil then
				goto eG
			end
			eC = eC + 1
			if self.stairChestIgnoredPlayers[ae] == true then
				eE = eE + 1
				goto eG
			end
			if self.stairChestCompletedPlayers[ae] == true then
				eD = eD + 1
				goto eG
			end
			eF = eF + 1
		end
		::eG::
	end
	local eH = DungeonAdventure:AreOpenedAdventuresCompleted()
	local eI = eC <= 0 or eF <= 0
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
												) .. tostring(eI)
											) .. " completed="
										) .. tostring(eD)
									) .. " ignored="
								) .. tostring(eE)
							) .. " waiting="
						) .. tostring(eF)
					) .. " total="
				) .. tostring(eC)
			) .. " adventuresCompleted="
		) .. tostring(eH)
	)
	if eI and eH then
		self:StopStairChestStateWatcher()
		self:OpenGates()
	end
end
function K.prototype.RequestBossChestRewards(self, ae, eJ, eK, e5, eL, eM)
	if eM == nil then
		eM = false
	end
	if eM and self:IsEquipmentCapacityFull(ae) then
		self:ShowEquipmentCapacityDialog(ae, true)
		if eL ~= nil then
			eL(nil, false)
		end
		return
	end
	local eN = false
	CommonService:RepeatCallAction(
		"/v1/settle/receive_boss_rewards",
		ae,
		{
			match_id = Match:GetMatchID(),
			round = DungeonManager:GetZoneIndex(),
			room_step = DungeonManager:GetRoomIndex(),
			open_times = eJ,
			use_daily_free_open_times = eK,
		},
		function(a0, eO, eP)
			if eN then
				return
			end
			eN = true
			if eP.code == 2 and eP.message == "rewards received" then
				ErrorMessage("error_boss_rewards_already_received")
				if eL ~= nil then
					eL(nil, true, true)
				end
				return
			end
			CommonService:CommonCallback(ae, eP)
			self:HandleBossChestRewardsResponse(eO, eP, e5, eL)
		end,
		false
	)
end
function K.prototype.RequestStairChestRewards(self, ae, eJ, eK, e5, eL, eM)
	if eM == nil then
		eM = false
	end
	if DungeonManager:IsTutorial() then
		if eM and self:IsEquipmentCapacityFull(ae) then
			self:ShowEquipmentCapacityDialog(ae, true)
			if eL ~= nil then
				eL(nil, false)
			end
			return
		end
		CommonService:RepeatCallAction("/v1/player/receive_teach_rewards", ae, {}, function(a0, eO, eP)
			if eP.code == 0 or eP.code == 200 then
				CommonService:CommonCallback(ae, eP, false)
			else
				ErrorMessage("Tutorial's reward has been received", ae)
				if eL ~= nil then
					eL(nil, false)
				end
				return
			end
			self:HandleBossChestRewardsResponse(eO, eP, e5, eL)
		end, false)
		return
	end
	self:RequestBossChestRewards(ae, eJ, eK, e5, eL, eM)
end
function K.prototype.HandleBossChestRewardsResponse(self, ae, eP, e5, eL)
	if eP.code ~= 0 and eP.code ~= 200 then
		if eL ~= nil then
			eL(nil, false)
		end
		return
	end
	local eQ
	if eP ~= nil then
		eQ = eP.data
	end
	local eR
	if eQ ~= nil then
		eR = eQ.add_items
	end
	local eS = eR
	local eT
	if eS ~= nil then
		eT = eS.other
	end
	local eU = eT
	local eV
	if eP ~= nil then
		eV = eP.data
	end
	local eW
	if eV ~= nil then
		eW = eV.player_equipments
	end
	local eX = eW
	local eY
	if eP ~= nil then
		eY = eP.data
	end
	local eZ
	if eY ~= nil then
		eZ = eY.player_drawings
	end
	local e_ = eZ
	local f0
	if eP ~= nil then
		f0 = eP.data
	end
	local f1
	if f0 ~= nil then
		f1 = f0.player_keys
	end
	local f2 = f1
	local f3
	if eP ~= nil then
		f3 = eP.data
	end
	local f4
	if f3 ~= nil then
		f4 = f3.player_notices
	end
	local f5 = f4
	if f5 == nil then
		f5 = {}
	end
	local f6 = f5
	local f7 = f6[1]
	local f8 = (f7 and f7.key) == "BossRewards3TimesDrop"
	if f8 then
		Notification:CombatToPlayer(ae, { message = "Notify_BossRewards3TimesDrop" })
	end
	if not eU and not eX and not e_ and not f2 then
		if eL ~= nil then
			eL(nil, true)
		end
		self:ScheduleEquipmentCapacityDialog(ae)
		return
	end
	if eL ~= nil then
		eL(nil, true)
	end
	self:ScheduleEquipmentCapacityDialog(ae)
	Timer:GameTimer(0.8, function()
		if self.isDispose then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", e5, ae)
		local f9 = {}
		if eU then
			for a0, ai in ipairs(eU) do
				do
					local fa = tonumber(GetItemPropType(ai.item_id))
					if fa == 9 or fa == 19 or fa == 20 then
						goto fb
					end
					f9[#f9 + 1] =
						{ item_id = ai.item_id, amounts = ai.amounts, item_rarity = GetPropRarity(ai.item_id) }
				end
				::fb::
			end
		end
		if eX then
			for a0, fc in ipairs(eX) do
				f9[#f9 + 1] = { item_id = fc.equipment_item_id, amounts = 1, item_rarity = fc.rarity, uid = fc.id }
			end
		end
		if e_ then
			for a0, fd in ipairs(e_) do
				f9[#f9 + 1] = { item_id = fd.drawing_item_id, amounts = 1, item_rarity = fd.rarity, uid = fd.id }
			end
		end
		if f2 then
			for a0, fe in ipairs(f2) do
				f9[#f9 + 1] = { item_id = fe.key_item_id, amounts = 1, item_rarity = fe.rarity, uid = fe.id }
			end
		end
		local ff = {}
		for aa, ai in ipairs(f9) do
			ff[#ff + 1] = ai
			Timer:GameTimer(0.1 * aa, function()
				if self.isDispose then
					return
				end
				local fg = d(w, ae, ai.item_id, e5, { 200, 300 })
				local fh = self.clientItems
				fh[#fh + 1] = fg
				local aG = Interaction:RegisterInteract(fg.entity, InteractType.Consumables, 200, function(a0, aH, bt)
					CommonService:SendReceiveRewards(
						bt,
						{ { item_id = ai.item_id, amounts = ai.amounts, uid = ai.uid } }
					)
					fg:dispose()
					Event:Fire("client_item_pickup", { playerID = ae, item_id = ai.item_id })
				end, 1, ae)
				Interaction:UpdateInteract(aG, { position = fg:GetLandedPosition() })
				Interaction:SetSecondaryInteraction(aG, function(a0, aH, ae)
					local aJ = aH:GetPlayerOwnerID()
					local fi = {}
					do
						local aa = 0
						while aa < #self.clientItems do
							do
								local aC = self.clientItems[aa + 1]
								if aC == nil or aC.isDispose or not aC:IsLanded() or not IsValid(aC.entity) then
									goto fj
								end
								if aC.playerID ~= aJ then
									goto fj
								end
								local ay = aC:GetEntityIndex()
								if ay == -1 then
									goto fj
								end
								fi[#fi + 1] = { entityIndex = ay, position = aC:GetLandedPosition() }
							end
							::fj::
							aa = aa + 1
						end
					end
					do
						local aa = 0
						while aa < #fi do
							local fk = fi[aa + 1]
							self:CreateClientItemPickupParticle(fk.position, aH)
							Interaction:ExecutePrimaryCallback(fk.entityIndex, aH, ae)
							Interaction:UnregisterInteractable(fk.entityIndex)
							ArrayRemove(self.registeredInteracts, fk.entityIndex)
							aa = aa + 1
						end
					end
					self.clientItems = n(self.clientItems, function(a0, a7)
						return not a7.isDispose
					end)
				end)
				Interaction:UpdateSecondaryInteract(aG, { tooltip = "DoubleConsumables" })
				if aG ~= -1 then
					local fl = self.registeredInteracts
					fl[#fl + 1] = aG
				end
			end)
		end
		if #ff > 0 then
			Match:AddPlayerRoundRewards(ae, ff)
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
function K.prototype.ShowEquipmentCapacityDialog(self, ae, fm)
	Equipment:ShowCapacityDialog(ae, "equipment", fm)
end
function K.prototype.CreateSpecialRoom(self)
	if self.roomType == RoomType.SPECIAL then
		local b6 = self.specialKind
		if b6 == nil or b6 == "" then
			local fn = "special_room_zone" .. tostring(self.zoneID)
			b6 = DrawPool:Draw(fn)
			print(
				(((("[DungeonRoom " .. tostring(self.roomID)) .. "] SpecialRoom fallback draw from ") .. fn) .. ": ")
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
		local fo = self.wishingPoolCount * WISHING_POOL_COST
		local eb = Privilege:GetPlayerDynamicValue("privilege_bless_012", ae, "free_count") or 0
		local dj = eb > 0 and 0 or fo
		if eb > 0 then
			Privilege:SetPlayerDynamicValue("privilege_bless_012", ae, "free_count", eb - 1)
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
			local fp = CalcDirection2D(aH, self.position)
			local fq = self.position + fp * RandomInt(400, 500)
			fq.z = aH:GetAbsOrigin().z
			local aR = d(A, ai, fq)
			local fr = self.dropItems
			fr[#fr + 1] = aR
			local fs = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH, ae)
				if not aR:IsLanded() then
					return false
				end
				if aH ~= nil then
					aH:AddItemByName(ai, nil, false)
				end
				aR:dispose()
			end, nil, nil, ai)
			if fs ~= -1 then
				local ft = self.registeredInteracts
				ft[#ft + 1] = fs
			end
		end
		Event:Fire("wishing_pool_reward", { playerID = ae, cost = dj })
	end, 99999999)
	if aG ~= -1 then
		Interaction:UpdateInteract(
			aG,
			{ costInfo = { cost = self.wishingPoolCount * WISHING_POOL_COST, costType = "gold" } }
		)
		local fu = self.registeredInteracts
		fu[#fu + 1] = aG
	end
	local fv = self.npcs
	fv[#fv + 1] = a1
end
function K.prototype.CreateRegenWell(self)
	local a1 = CreateUnitByName("interact_regen_well", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aG = Interaction:RegisterInteract(a1, InteractType.RegenWell, 200, function(a0, aH, ae)
		local fw = a1:FindModifierByName("modifier_spawn_interact_regen_well")
		if fw ~= nil then
			fw:Activity()
		end
	end, 1)
	if aG ~= -1 then
		local fx = self.registeredInteracts
		fx[#fx + 1] = aG
	end
	local fy = self.npcs
	fy[#fy + 1] = a1
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
		local fz = self.registeredInteracts
		fz[#fz + 1] = aG
	end
	local fA = self.npcs
	fA[#fA + 1] = a1
end
function K.prototype.CreateSmithy(self)
	local a1 = CreateUnitByName("interact_smithy", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	a1:SetForwardVector(vec3_bottom)
	local aG = Interaction:RegisterInteract(a1, InteractType.Smithy, 200, function(a0, fB, ey)
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
		local fC = self.registeredInteracts
		fC[#fC + 1] = aG
	end
	local fD = self.npcs
	fD[#fD + 1] = a1
end
function K.prototype.HasTravelingMerchant(self)
	return self.specialKind == H
end
function K.prototype.IsTravelingMerchantNear(self, Q, fE)
	if self.travelingMerchantPosition == nil then
		return false
	end
	return CalcDistance(Q, self.travelingMerchantPosition) <= fE
end
function K.prototype.GetTravelingMerchantTrapPositions(self)
	local fF = {}
	local fG = Entities:FindAllByClassname("prop_dynamic")
	do
		local aa = 0
		while aa < #fG do
			local fH = fG[aa + 1]
			if fH:GetSpawnGroupHandle() == self.spawnGroup and o(fH:GetName(), "trap_fire_model") then
				fF[#fF + 1] = fH:GetAbsOrigin()
			end
			aa = aa + 1
		end
	end
	return fF
end
function K.prototype.GetTravelingMerchantExitInfos(self)
	local fI = {}
	do
		local aa = 0
		while aa < #self.exitInfos do
			do
				local a9 = self.exitInfos[aa + 1]
				if a9 == nil then
					goto fJ
				end
				fI[#fI + 1] = { position = a9.position, direction = a9.direction }
			end
			::fJ::
			aa = aa + 1
		end
	end
	return fI
end
function K.prototype.IsTravelingMerchantBlockedByExit(self, Q)
	local fI = self:GetTravelingMerchantExitInfos()
	local fK = GRID_SIZE * 2
	local fL = GRID_SIZE * 0.75
	do
		local aa = 0
		while aa < #fI do
			local a9 = fI[aa + 1]
			local fM = Q:__sub(a9.position)
			local fN = fM.x * a9.direction.x + fM.y * a9.direction.y
			local fO = -fN
			local fP = math.abs(fM.x * -a9.direction.y + fM.y * a9.direction.x)
			if fO >= 0 and fO <= fK and fP <= fL then
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
			local fQ = self.validGridPositions[aa + 1]
			if fQ ~= nil and CalcDistance(fQ, Q) <= GRID_SIZE * 0.25 then
				return true
			end
			aa = aa + 1
		end
	end
	return false
end
function K.prototype.CanPlaceTravelingMerchantAt(self, Q, fR)
	if not self:IsTravelingMerchantGridPositionValid(Q) then
		return false
	end
	local fS = Q:__add(fR:__mul(GRID_SIZE))
	local fT = Vector(-fR.y, fR.x, 0)
	local fU = Q:__add(fT:__mul(GRID_SIZE))
	local fV = Q:__sub(fT:__mul(GRID_SIZE))
	return self:IsTravelingMerchantGridPositionValid(fS)
		and self:IsTravelingMerchantGridPositionValid(fU)
		and self:IsTravelingMerchantGridPositionValid(fV)
end
function K.prototype.GetTravelingMerchantDirectionCandidates(self, Q)
	local fW = self:ResolveTravelingMerchantForward(Q)
	local fX = { fW }
	local fY = { vec3_bottom, vec3_left, vec3_right }
	do
		local aa = 0
		while aa < #fY do
			local fp = fY[aa + 1]
			if fp ~= fW then
				fX[#fX + 1] = fp
			end
			aa = aa + 1
		end
	end
	return fX
end
function K.prototype.ResolveTravelingMerchantAngles(self, fp)
	if fp == vec3_left then
		return "0 180 0"
	end
	if fp == vec3_right then
		return "0 0 0"
	end
	return "0 -90 0"
end
function K.prototype.ResolveTravelingMerchantAdjustedPosition(self, Q, fR)
	local fZ = Q
	local f_ = fR:__mul(-1)
	local g0 = GRID_SIZE * 0.1
	local g1 = GRID_SIZE * 0.5
	local g2 = 10
	do
		local g3 = 0
		while g3 <= g2 do
			local g4 = g1 + g0 * g3
			local cd = Q:__add(f_:__mul(g4))
			if not self:IsPositionInside(cd) or not GridNav:IsValidPosition(cd) then
				break
			end
			fZ = cd
			g3 = g3 + 1
		end
	end
	return fZ
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
	local g5 = math.huge
	local g6 = -math.huge
	local g7 = -math.huge
	do
		local aa = 0
		while aa < #self.validGridPositions do
			do
				local fQ = self.validGridPositions[aa + 1]
				if fQ == nil then
					goto g8
				end
				g5 = math.min(g5, fQ.x)
				g6 = math.max(g6, fQ.x)
				g7 = math.max(g7, fQ.y)
			end
			::g8::
			aa = aa + 1
		end
	end
	local fF = self:GetTravelingMerchantTrapPositions()
	local g9 = GRID_SIZE * 1.25
	local ga = nil
	local gb = nil
	local gc = math.huge
	local gd = -math.huge
	do
		local aa = 0
		while aa < #self.validGridPositions do
			do
				local fQ = self.validGridPositions[aa + 1]
				if fQ == nil then
					goto ge
				end
				if self:IsTravelingMerchantBlockedByExit(fQ) then
					goto ge
				end
				local gf = false
				do
					local gg = 0
					while gg < #fF do
						if CalcDistance(fQ, fF[gg + 1]) <= g9 then
							gf = true
							break
						end
						gg = gg + 1
					end
				end
				if gf then
					goto ge
				end
				local fX = self:GetTravelingMerchantDirectionCandidates(fQ)
				local gh = nil
				do
					local gi = 0
					while gi < #fX do
						local fp = fX[gi + 1]
						if self:CanPlaceTravelingMerchantAt(fQ, fp) then
							gh = fp
							break
						end
						gi = gi + 1
					end
				end
				if gh == nil then
					goto ge
				end
				local gj = math.min(math.abs(fQ.x - g5), math.abs(g6 - fQ.x), math.abs(g7 - fQ.y))
				local gk = CalcDistance(fQ, self.position)
				if gj < gc or gj == gc and gk > gd then
					ga = fQ
					gb = gh
					gc = gj
					gd = gk
				end
			end
			::ge::
			aa = aa + 1
		end
	end
	if ga == nil or gb == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] TravelingMerchant 未找到满足前方和两侧相邻网格条件的站位，跳过创建"
		)
		return
	end
	local fZ = self:ResolveTravelingMerchantAdjustedPosition(ga, gb)
	self.travelingMerchantPosition = GetGroundPosition(fZ, nil)
	self.travelingMerchantForward = gb
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
	local gl = {}
	for Y, ap in pairs(KeyValues.artifact) do
		local gm = tostring
		local gn = ap.Access
		if gn == nil then
			gn = ""
		end
		if gm(gn) == "Meepo" then
			gl[#gl + 1] = tostring(Y)
		end
	end
	return gl
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
	local go = self.travelingMerchantForward:__mul(128)
	local gp = self.travelingMerchantPosition:__add(go)
	local fT = Vector(-self.travelingMerchantForward.y, self.travelingMerchantForward.x, 0)
	local gq = { -128, 0, 128 }
	local gr = {}
	local gs = ShuffledList(X)
	do
		local aa = 0
		while aa < #gs and #gr < 3 do
			do
				local Y = gs[aa + 1]
				if Y == nil or Y == "" or m(de, Y) then
					goto gt
				end
				gr[#gr + 1] = Y
				self:AppendShopGeneratedExcluded(de, Y)
			end
			::gt::
			aa = aa + 1
		end
	end
	do
		local aa = 0
		while aa < #gr do
			do
				local Y = gr[aa + 1]
				if Y == nil or Y == "" then
					goto gu
				end
				local aK = gp:__add(fT:__mul(gq[aa + 1] or 0))
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
			::gu::
			aa = aa + 1
		end
	end
	local du = gp:__add(go)
	Game:EachPlayer(function(a0, ae)
		if Privilege:HasPrivilege("privilege_041", ae) then
			self:CreateFreeTravelingMerchantItem(ae, du, X, de)
		end
	end)
end
function K.prototype.CreateFreeTravelingMerchantItem(self, ae, Q, X, de)
	local dv = { unpack(de) }
	local gv = {}
	local aH = self:GetShopFilterHero(ae)
	if aH ~= nil then
		self:AppendShopExcludedForHero(dv, aH)
		self:AppendShopExcludedForHero(gv, aH)
	end
	local Y
	local gs = ShuffledList(X)
	do
		local aa = 0
		while aa < #gs do
			local bE = gs[aa + 1]
			if bE ~= nil and bE ~= "" and not m(dv, bE) then
				Y = bE
				break
			end
			aa = aa + 1
		end
	end
	if Y == nil then
		do
			local aa = 0
			while aa < #gs do
				local bE = gs[aa + 1]
				if bE ~= nil and bE ~= "" and not m(gv, bE) then
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
	local gw = self.npcs
	gw[#gw + 1] = a1
	self:CreateTravelingMerchantShopItems()
end
function K.prototype.RollTavernItemRarity(self, Y)
	local ap = KeyValues.items[Y]
	local gx = ap and ap.RarityRange
	if gx == nil or j(tostring(gx)) == "" then
		local gy = ap and ap.Rarity
		if gy ~= nil and j(tostring(gy)) ~= "" then
			return toFiniteNumber(gy, 1)
		end
		return 1
	end
	local gz = n(
		k(g(tostring(gx), "|"), function(a0, a7)
			return toFiniteNumber(a7, 0)
		end),
		function(a0, a7)
			return a7 > 0
		end
	)
	if #gz == 0 then
		return 1
	end
	local gA = { [1] = 50, [2] = 30, [3] = 15, [4] = 4, [5] = 1 }
	local gB = d(E)
	do
		local aa = 0
		while aa < #gz do
			local a6 = gz[aa + 1]
			gB:Set(a6, gA[a6] or 1)
			aa = aa + 1
		end
	end
	return gB:Random() or gz[1]
end
function K.prototype.CreateTavernItems(self)
	local gC = PickList(TAVERN_ITEMS, 4)
	local gD = { 1, 1, 1, 1 }
	local dp = self:FindInfoTarget("info_shop_item")
	if not IsValid(dp) then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 未找到 info_shop_item，跳过酒馆商品生成"
		)
		return
	end
	local gE = dp:GetAbsOrigin()
	local dq = self:GetSymmetricShopPositions(gE, #gC)
	print((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateTavernItems: slots=") .. tostring(#dq))
	do
		local dr = 0
		while dr < #dq do
			do
				local Y = gC[dr + 1]
				local a6 = gD[dr + 1] or 1
				if Y == nil or Y == "" then
					goto gF
				end
				print(
					(
						(
							(
								((("[DungeonRoom " .. tostring(self.roomID)) .. "] Tavern item slot=") .. tostring(dr))
								.. " item="
							) .. Y
						) .. " rarity="
					) .. tostring(a6)
				)
				self:SpawnShopItemAtPosition(Y, a6, dq[dr + 1], "tavern_" .. tostring(dr + 1))
			end
			::gF::
			dr = dr + 1
		end
	end
	local gG = n(TAVERN_ITEMS, function(a0, Y)
		return not m(gC, Y)
	end)
	local du = Vector(gE.x, gE.y - 300, gE.z)
	Game:EachPlayer(function(a0, ae)
		if not Privilege:HasPrivilege("privilege_042", ae) then
			return
		end
		local gH = PickList(#gG > 0 and gG or TAVERN_ITEMS, 1)
		local Y = gH[1]
		if Y == nil or Y == "" then
			return
		end
		local a6 = gD[1] or 1
		self:SpawnShopItemAtPosition(Y, a6, du, "tavern_free_" .. tostring(ae), true, ae)
	end)
end
function K.prototype.CreateFaith(self)
	local gI = DrawPool:Draw("faith")
	if gI then
		local a1 = CreateUnitByName(gI, self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
		local aG = Interaction:RegisterInteract(a1, InteractType.ShopItem, 200, function(a0, aH, ae)
			local a8 = DrawPool:Draw(gI)
			if a8 ~= nil then
				aH:AddItemByName(a8)
			end
		end)
		if aG ~= -1 then
			local gJ = self.registeredInteracts
			gJ[#gJ + 1] = aG
		end
		local gK = self.npcs
		gK[#gK + 1] = a1
	end
end
function K.prototype.CreateOutpost(self)
	local a1 = CreateUnitByName("bonus_outpost", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local gL = self.npcs
	gL[#gL + 1] = a1
end
function K.prototype.ShouldCreateSecretRoom(self)
	if not DungeonManager:HasSecretRoomPrefabs() then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] 当前地形未配置隐藏房间预制体，跳过创建"
		)
		return false
	end
	local gM = DungeonManager:GetSecretRoomChance()
	local gN = RollPercentage(gM)
	print(
		(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间判定 chance=") .. tostring(gM))
			.. "% result="
		) .. tostring(gN)
	)
	return gN
end
function K.prototype.TryCreateSecretGate(self, gO, gP, gQ)
	if self.secretRoomPrefix ~= nil then
		return
	end
	if not self:ShouldCreateSecretRoom() then
		return
	end
	local gR = d(p, gP)
	gR:add(self.entrancePrefix)
	local gS = {}
	do
		local aa = 0
		while aa < #gO do
			local bd = gO[aa + 1]
			if bd ~= nil and not gR:has(bd) then
				gS[#gS + 1] = bd
			end
			aa = aa + 1
		end
	end
	if #gS == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 没有未使用的出口可用于隐藏房间")
		return
	end
	local gT = GetRandomElement(gS)
	if gT == nil then
		return
	end
	local gU = r(gQ, function(a0, gV)
		return q(gV:GetName(), gT .. "_")
	end)
	if not IsValid(gU) then
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间出口实体无效: ") .. gT)
		return
	end
	local gW = gU:GetAbsOrigin()
	local bw = self.position
	local bP = gW.x - bw.x
	local bQ = gW.y - bw.y
	local fp
	if math.abs(bQ) > math.abs(bP) then
		fp = vec3_top
	else
		fp = bP > 0 and vec3_right or vec3_left
	end
	local bO = gW:__add(fp:__mul(-128))
	self.secretRoomPrefix = gT
	self.secretRoomDoorPosition = gW
	self.secretRoomDoorDirection = fp
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
		bb:SetForwardVector(Rotation2D(fp, 180, true))
		self.secretRoomGate = bb
		local gX = self.enemies
		gX[#gX + 1] = bb
		print(
			(
				(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门已创建: prefix=")
								.. gT
							) .. " pos=("
						) .. tostring(bO.x)
					) .. ", "
				) .. tostring(bO.y)
			) .. ")"
		)
	end)
end
function K.prototype.CreateSecretRoom(self, gY, fp)
	local gZ = DungeonManager:GetSecretRoomPrefab(fp)
	if gZ == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间未配置当前方向的预制体，跳过创建"
		)
		return
	end
	local function g_(a0, h0, h1)
		if h0 % 64 == 0 then
			return h0
		end
		if h1 > 0 then
			return math.ceil(h0 / 64) * 64
		end
		if h1 < 0 then
			return math.floor(h0 / 64) * 64
		end
		return math.floor(h0 / 64 + 0.5) * 64
	end
	local fq = Vector(g_(nil, gY.x, fp.x), g_(nil, gY.y, fp.y), gY.z)
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
													) .. gZ
												) .. " door=("
											) .. tostring(gY.x)
										) .. ", "
									) .. tostring(gY.y)
								) .. ") spawn=("
							) .. tostring(fq.x)
						) .. ", "
					) .. tostring(fq.y)
				) .. ", "
			) .. tostring(fq.z)
		) .. ")"
	)
	self.isSecretRoomCreated = true
	self.secretRoomSpawnGroup = DOTA_SpawnMapAtPosition(gZ, fq, true, function(_)
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间 onReadyToSpawn")
		ManuallyTriggerSpawnGroupCompletion(_)
	end, function()
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间 onSpawnComplete")
		self:RevealSecretRoomGates()
		self:OnSecretRoomContentReady(fq, fp)
	end, nil)
end
function K.prototype.OnSecretRoomContentReady(self, fq, fp)
	local h2 = Entities:FindAllByClassname("info_target")
	local h3 = {}
	for a0, h4 in ipairs(h2) do
		if h4:GetSpawnGroupHandle() == self.secretRoomSpawnGroup and o(h4:GetName(), "info_waard") then
			h3[#h3 + 1] = h4:GetAbsOrigin()
		end
	end
	if #h3 == 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间内未找到 info_waard 实体，使用推算中心位置"
		)
		h3[#h3 + 1] = fq:__add(fp:__mul(960))
	end
	Interaction:BeginSyncBatch()
	do
		local h5 = 0
		while h5 < #h3 do
			local h6 = h3[h5 + 1]
			if RollPercentage(50) then
				local bx = RandomInt(8, 15)
				local by = 480
				do
					local aa = 0
					while aa < bx do
						local bC = RandomFloat(0, 360)
						local aQ = RandomFloat(0, by)
						local bD = Vector(math.cos(bC * math.pi / 180) * aQ, math.sin(bC * math.pi / 180) * aQ, 0)
						local bA = h6:__add(bD)
						local aR = d(A, "item_coin_stack", bA)
						local h7 = self.dropItems
						h7[#h7 + 1] = aR
						local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
							aH:AddItemByName("item_coin_stack")
							aR:dispose()
						end, nil, nil, "item_coin_stack")
						if aG ~= -1 then
							local h8 = self.registeredInteracts
							h8[#h8 + 1] = aG
						end
						aa = aa + 1
					end
				end
				print(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间内容就绪，在 ward[")
								.. tostring(h5)
							) .. "] 周围生成 "
						) .. tostring(bx)
					) .. " 个金币堆"
				)
			else
				local aR = d(A, "item_treasure_secret", h6)
				local h9 = self.dropItems
				h9[#h9 + 1] = aR
				local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
					aH:AddItemByName("item_treasure_secret")
					aR:dispose()
				end, nil, nil, "item_treasure_secret")
				if aG ~= -1 then
					local ha = self.registeredInteracts
					ha[#ha + 1] = aG
				end
			end
			h5 = h5 + 1
		end
	end
	Interaction:EndSyncBatch()
end
function K.prototype.RevealSecretRoomGates(self)
	if self.secretRoomPrefix == nil then
		return
	end
	local hb = self:FindEntities("prop_dynamic", "prop_wall")
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	local hc = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	for a0, hd in ipairs(hb) do
		local bd = g(hd:GetName(), "_")[1]
		if bd == self.secretRoomPrefix then
			hd:AddEffects(EF_NODRAW)
		end
	end
	for a0, bb in ipairs(ba) do
		local bd = g(bb:GetName(), "_")[1]
		if bd == self.secretRoomPrefix then
			bb:AddEffects(EF_NODRAW)
		end
	end
	for a0, bb in ipairs(hc) do
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
	local gQ = self:FindInfoTargets("info_room_start")
	if #gQ == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	local he = d(p)
	for a0, h4 in ipairs(gQ) do
		local bc = h4:GetName()
		local bd = g(bc, "_")[1]
		if bd ~= nil and bd ~= "" then
			he:add(bd)
		end
	end
	local hf = s(he)
	if #hf == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	self.entrancePrefix = GetRandomElement(hf) or ""
	local hg = r(gQ, function(a0, gV)
		return q(gV:GetName(), self.entrancePrefix .. "_")
	end)
	self.entrancePos = IsValid(hg) and hg:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
end
function K.prototype.CreateExit(self)
	local gQ = self:FindInfoTargets("info_room_exit")
	print(
		((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 找到 ") .. tostring(#gQ))
			.. " 个 info_room_exit"
	)
	if #gQ == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无出口实体，使用默认配置")
		return
	end
	local he = d(p)
	for a0, h4 in ipairs(gQ) do
		local bc = h4:GetName()
		local bd = g(bc, "_")[1]
		if bd ~= nil and bd ~= "" then
			he:add(bd)
		end
	end
	local hf = s(he)
	if #hf == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无有效前缀")
		return
	end
	local hh = DungeonManager:GetExitCountOverrideByIndex(self.roomID) or 1
	local hi = self.roomID + 1
	local hj = DungeonManager:GetRoomTypeByIndex(hi)
	local hk = DungeonManager:GetRewardTypeByIndex(hi)
	local hl = DungeonManager:GetRewardOptionsByIndex(hi)
	local hm = DungeonManager:GetSpecialOptionsByIndex(hi)
	if #hm > 0 then
		hh = #hm
	elseif #hl > 1 then
		hh = #hl
	end
	hh = math.min(#hf, hh)
	local gP = PickList(hf, hh)
	local hn = {}
	local ho = {}
	if #hm > 0 then
		local hp = { unpack(hm) }
		do
			local aa = #hp - 1
			while aa > 0 do
				local cf = RandomInt(0, aa)
				local hq = { hp[cf + 1], hp[aa + 1] }
				hp[aa + 1] = hq[1]
				hp[cf + 1] = hq[2]
				aa = aa - 1
			end
		end
		do
			local aa = 0
			while aa < hh do
				hn[#hn + 1] = hk
				ho[#ho + 1] = hp[aa + 1] or hp[1] or ""
				aa = aa + 1
			end
		end
	elseif #hl > 0 then
		if hh <= 1 then
			hn = { hk }
		else
			do
				local aa = 0
				while aa < hh do
					hn[#hn + 1] = hl[aa + 1] or hk
					aa = aa + 1
				end
			end
		end
	else
		hn = { hk }
	end
	self.exitInfos = {}
	local bw = self.position
	do
		local aa = 0
		while aa < #gP do
			do
				local bd = gP[aa + 1]
				if bd == nil then
					goto hr
				end
				local gU = r(gQ, function(a0, gV)
					return q(gV:GetName(), bd .. "_")
				end)
				local gW = IsValid(gU) and gU:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
				local bP = gW.x - bw.x
				local bQ = gW.y - bw.y
				local fp
				if math.abs(bQ) > math.abs(bP) then
					fp = vec3_top
				else
					fp = bP > 0 and vec3_right or vec3_left
				end
				local hs = self.exitInfos
				hs[#hs + 1] = {
					prefix = bd,
					position = gW,
					direction = fp,
					roomType = hj,
					rewardType = hn[aa + 1] or hk,
					specialKind = ho[aa + 1],
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
									) .. RoomType[hj]
								) .. " reward="
							) .. RoomRewardType[hn[aa + 1] or hk]
						) .. " special="
					) .. (ho[aa + 1] or "-")
				)
			end
			::hr::
			aa = aa + 1
		end
	end
	self:TryCreateSecretGate(hf, gP, gQ)
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
												) .. tostring(hh)
											) .. "，next:"
										) .. RoomType[hj]
									) .. "-"
								) .. RoomRewardType[hk]
							) .. " 前缀: "
						) .. table.concat(gP, ", ")
					) .. "，奖励："
				) .. table.concat(hn, ", ")
			) .. " special="
		) .. table.concat(ho, ", ")
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
	local hb = self:FindEntities("prop_dynamic", "prop_wall")
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	local hc = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	local ht = d(p)
	ht:add(self.entrancePrefix)
	do
		local aa = 0
		while aa < #self.exitInfos do
			local a9 = self.exitInfos[aa + 1]
			if a9 ~= nil then
				ht:add(a9.prefix)
			end
			aa = aa + 1
		end
	end
	for a0, hd in ipairs(hb) do
		local bc = hd:GetName()
		local bd = g(bc, "_")[1]
		if ht:has(bd) then
			hd:AddEffects(EF_NODRAW)
		else
			hd:RemoveEffects(EF_NODRAW)
		end
	end
	for a0, bb in ipairs(ba) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if ht:has(bd) then
			bb:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bb)
		end
	end
	for a0, bb in ipairs(hc) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if ht:has(bd) then
			bb:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bb)
		end
	end
end
function K.prototype.GetAvailablePositionIndices(self, hu, g7)
	local b6 = {}
	do
		local aa = 0
		while aa < #self.validGridPositions do
			if self.occupiedPositions[aa] ~= true then
				local hv = self.validGridPositions[aa + 1]
				if (hu == nil or hv.y >= hu) and (g7 == nil or hv.y <= g7) then
					b6[#b6 + 1] = aa
				end
			end
			aa = aa + 1
		end
	end
	return b6
end
function K.prototype.GetGridsAroundPosition(self, bw, fE, hw)
	if hw == nil then
		hw = 0
	end
	local dq = {}
	for a0, hx in ipairs(self:GetAvailablePositionIndices()) do
		do
			local Q = self.validGridPositions[hx + 1]
			if Q == nil then
				goto hy
			end
			local aQ = CalcDistance(Q, bw)
			if hw > 0 then
				if aQ < fE + hw and aQ > fE - hw then
					dq[#dq + 1] = Q
				end
			else
				if aQ < fE then
					dq[#dq + 1] = Q
				end
			end
		end
		::hy::
	end
	return dq
end
function K.prototype.GetNearestValidGridPosition(self, hz)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local hA = nil
	local aN = math.huge
	do
		local aa = 0
		while aa < #self.validGridPositions do
			do
				local Q = self.validGridPositions[aa + 1]
				if Q == nil then
					goto hB
				end
				local aQ = CalcDistance(Q, hz)
				if aQ < aN then
					aN = aQ
					hA = Q
				end
			end
			::hB::
			aa = aa + 1
		end
	end
	return hA
end
function K.prototype.IsPositionInside(self, Q)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local g5 = math.huge
	local g6 = -math.huge
	local hu = math.huge
	local g7 = -math.huge
	for a0, c1 in ipairs(self.validGridPositions) do
		if c1 ~= nil then
			g5 = math.min(g5, c1.x)
			g6 = math.max(g6, c1.x)
			hu = math.min(hu, c1.y)
			g7 = math.max(g7, c1.y)
		end
	end
	if g5 == math.huge then
		return false
	end
	local hC = GRID_SIZE * 0.5
	return Q.x >= g5 - hC and Q.x <= g6 + hC and Q.y >= hu - hC and Q.y <= g7 + hC
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
function K.prototype.FindEntities(self, hD, hE)
	local hF = Entities:FindAllByClassname(hD)
	local b6 = {}
	for a0, h4 in ipairs(hF) do
		if h4:GetSpawnGroupHandle() == self.spawnGroup and o(h4:GetName(), hE) then
			b6[#b6 + 1] = h4
		end
	end
	return b6
end
function K.prototype.FindInfoTargets(self, hE)
	local hF = Entities:FindAllByClassname("info_target")
	local b6 = {}
	for a0, h4 in ipairs(hF) do
		if h4:GetSpawnGroupHandle() == self.spawnGroup and o(h4:GetName(), hE) then
			b6[#b6 + 1] = h4
		end
	end
	return b6
end
function K.prototype.FindInfoTarget(self, hE)
	local hF = Entities:FindAllByClassname("info_target")
	for a0, h4 in ipairs(hF) do
		if h4:GetSpawnGroupHandle() == self.spawnGroup and o(h4:GetName(), hE) then
			return h4
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
	local hG =
		ParticleManager:CreateParticleForce("particles/generic_gameplay/drop_item_pick.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(hG, 0, aK)
	ParticleManager:SetParticleControlEnt(hG, 1, aH, PATTACH_POINT_FOLLOW, "attach_hitloc", aH:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(hG)
end
function K.prototype.DropItemFromEnemy(self, a1, hH)
	local Y
	if self.guaranteedDrops ~= nil then
		for hI, hJ in pairs(self.guaranteedDrops) do
			if hJ > 0 then
				Y = hI
				self.guaranteedDrops[hI] = hJ - 1
				if self.guaranteedDrops[hI] <= 0 then
					f(self.guaranteedDrops, hI)
				end
				break
			end
		end
	end
	local ae = hH:GetPlayerOwnerID()
	if Y == nil then
		if self.dropPool == nil then
			return
		end
		local hK = Privilege:GetPlayerDynamicValue("privilege_bless_009", ae, "FirstDropCount") or 0
		if hK < 1 and not RollPercentage(self.dropPool.dropChance + GetBreakDropChance(hH)) then
			return
		end
		Privilege:SetPlayerDynamicValue("privilege_bless_009", ae, "FirstDropCount", hK - 1)
		Y = self.dropPool.itemPool:Random(nil)
	end
	if Y == nil then
		return
	end
	local aA = a1:GetAbsOrigin()
	local aR = d(A, Y, aA)
	local hL = self.dropItems
	hL[#hL + 1] = aR
	local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
		aH:AddItemByName(Y)
		aR:dispose()
	end, nil, nil, Y)
	if aG ~= -1 then
		local hM = self.registeredInteracts
		hM[#hM + 1] = aG
	end
	Event:Fire("break_drop", { itemName = Y, drop_item = aR })
end
function K.prototype.CalculateDifficultyModifiers(self)
	local hN = GameRules:GetCustomGameDifficulty()
	local hO = KeyValues.difficulty[tostring(hN)]
	if hO == nil then
		print(("[DungeonRoom] 警告：难度配置 " .. tostring(hN)) .. " 未找到")
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		return
	end
	local hP = toFiniteNumber(hO.HealthFactor, 1)
	local hQ = toFiniteNumber(hO.DamageFactor, 1)
	local hR = DungeonManager:GetZoneIndex()
	if hR == 1 then
		hP = hP * toFiniteNumber(hO.Chapter1HealthFactor, 1)
		hQ = hQ * toFiniteNumber(hO.Chapter1DamageFactor, 1)
	elseif hR == 2 then
		hP = hP * toFiniteNumber(hO.Chapter2HealthFactor, 1)
		hQ = hQ * toFiniteNumber(hO.Chapter2DamageFactor, 1)
	elseif hR == 3 then
		hP = hP * toFiniteNumber(hO.Chapter3HealthFactor, 1)
		hQ = hQ * toFiniteNumber(hO.Chapter3DamageFactor, 1)
	end
	local hS = Game:GetPlayerCount()
	if hS == 2 then
		hP = hP * toFiniteNumber(hO.Player2HealthFactor, 1)
		hQ = hQ * toFiniteNumber(hO.Player2DamageFactor, 1)
	elseif hS == 3 then
		hP = hP * toFiniteNumber(hO.Player3HealthFactor, 1)
		hQ = hQ * toFiniteNumber(hO.Player3DamageFactor, 1)
	elseif hS >= 4 then
		hP = hP * toFiniteNumber(hO.Player4HealthFactor, 1)
		hQ = hQ * toFiniteNumber(hO.Player4DamageFactor, 1)
	end
	self.difficultyHealthAmplify = (hP - 1) * 100
	self.difficultyDamageAmplify = (hQ - 1) * 100
	self.difficultyCooldownReduction = DIFFICULTY_COOLDOWN_REDUCTION[hN] or 0
	self.difficultyBossGapAmplify = DIFFICULTY_BOSS_GAP_AMPLIFY[hN] or 0
	self.difficultyBossDamageAmplify = DIFFICULTY_BOSS_DAMAGE_AMPLIFY[hN] or 0
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
																			) .. tostring(hN)
																		) .. " 玩家:"
																	) .. tostring(hS)
																) .. " 血量:"
															) .. t(hP, 2)
														) .. "x("
													) .. t(self.difficultyHealthAmplify, 1)
												) .. "%) 伤害:"
											) .. t(hQ, 2)
										) .. "x("
									) .. t(self.difficultyDamageAmplify, 1)
								) .. "%) 冷却缩减:"
							) .. tostring(self.difficultyCooldownReduction)
						) .. "% Boss间隔增幅:"
					) .. tostring(self.difficultyBossGapAmplify)
				) .. "% Boss最终伤害:"
			) .. tostring(self.difficultyBossDamageAmplify)
		) .. "%"
	)
end
function K.prototype.ApplyDifficultyModifiers(self, aw)
	local hP = self.spawnInfo.healthFactor or 1
	local hQ = self.spawnInfo.damageFactor or 1
	local hT = DungeonManager:GetDifficultyKeyHealthFactor()
	local hU = DungeonManager:GetDifficultyKeyDamageFactor()
	local hV = (1 + self.difficultyHealthAmplify / 100) * hP * hT
	local hW = (1 + self.difficultyDamageAmplify / 100) * hQ * hU
	local hX = (hV - 1) * 100
	local hY = (hW - 1) * 100
	print("ApplyDifficultyModifiers", hP, hQ)
	if hX ~= 0 then
		aw:AddProperty(PropertyFunction.HEALTH_AMPLIFY, hX)
	end
	if hY ~= 0 then
		aw:AddProperty(PropertyFunction.ATTACK_AMPLIFY, hY)
	end
	DungeonManager:ApplyDifficultyKeyDebuffs(aw)
end
function K.prototype.DropPomReward(self, Q)
	local Y = DrawPool:Draw("pom_reward")
	if Y ~= nil then
		local aR = d(A, Y, Q)
		local hZ = self.dropItems
		hZ[#hZ + 1] = aR
		local aG = Interaction:RegisterInteract(aR.entity, InteractType.Chest, 200, function(a0, aH)
			aH:AddItemByName(Y)
			aR:dispose()
		end)
		if aG ~= -1 then
			local h_ = self.registeredInteracts
			h_[#h_ + 1] = aG
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
function K.prototype.AddGuaranteedDropCount(self, Y, i0)
	local i1 = self.guaranteedDrops[Y] or 0
	local i2 = i1 + i0
	if i2 <= 0 then
		f(self.guaranteedDrops, Y)
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 移除必掉物品: ") .. Y)
	else
		self.guaranteedDrops[Y] = i2
		print(
			(
				(
					(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 增加 ") .. Y) .. " 掉落次数: ")
					.. tostring(i1)
				) .. " -> "
			) .. tostring(i2)
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
function K.prototype.OnEntityKilled(self, i3)
	local i4 = EntIndexToHScript(i3.entindex_killed)
	if not IsValid(i4) then
		return
	end
	if self.secretRoomGate ~= nil and i4 == self.secretRoomGate then
		self.secretRoomGate = nil
		ArrayRemove(self.enemies, i4)
		if self.secretRoomDoorPosition ~= nil and self.secretRoomDoorDirection ~= nil then
			self:CreateSecretRoom(self.secretRoomDoorPosition, self.secretRoomDoorDirection)
		end
		return
	end
	if m(self.enemies, i4) then
		local hH = EntIndexToHScript(i3.entindex_attacker)
		if IsValid(hH) and hH:IsRealHero() then
			self.playerKilledEnemyCount = self.playerKilledEnemyCount + 1
		end
		self:DropPreviewRewardsFromEnemy(i4)
		ArrayRemove(self.enemies, i4)
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
				local Q = GetGroundPosition(i4:GetAbsOrigin(), i4)
				if not GridNav:IsValidPosition(Q) then
					Q = self:GetNearestValidGridPosition(Q) or Q
				end
				self:FinishCombat(Q)
			end
		end
	end
	if m(self.breakables, i4) then
		local hH = EntIndexToHScript(i3.entindex_attacker)
		self:DropItemFromEnemy(i4, hH)
		return
	end
end
return u