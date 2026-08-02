--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
local I = 400
local J = 320
local K = {
	[RoomRewardType.BOON] = "particles/generic_gameplay/rune/rune_blessings.vpcf",
	[RoomRewardType.DOUBLE_BOON] = "particles/generic_gameplay/rune/rune_blessings.vpcf",
	[RoomRewardType.HERO_UPGRADE] = "particles/generic_gameplay/rune/rune_experience.vpcf",
	[RoomRewardType.POM] = "particles/generic_gameplay/rune/rune_property.vpcf",
	[RoomRewardType.GOLD] = "particles/generic_gameplay/rune/rune_bounty_first.vpcf",
	[RoomRewardType.TREASURE] = "particles/generic_gameplay/rune/rune_treasure.vpcf",
}
u.DungeonRoom = c()
local L = u.DungeonRoom
L.name = "DungeonRoom"
function L.prototype.____constructor(self, M, N, O, P, Q, R, S, T, U, V, W, X)
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
	self.zoneID = M
	self.terrainThemeKey = T
	self.roomID = N
	self.mapName = O
	self.rewardType = Q
	self.roomType = P
	self.position = R
	self.bossName = U
	self.shopRarityPoolName = W or ""
	self.specialKind = X
	self.spawnInfo = self:CreateSpawnInfo(S, T)
	self.guaranteedDrops = {}
	self:CalculateDifficultyModifiers()
	if V ~= nil then
		local Y = d(E)
		if V.ItemList ~= nil then
			for Z, _ in pairs(V.ItemList) do
				Y:Add(tostring(Z), toFiniteNumber(_))
			end
		end
		self.dropPool = { dropChance = toFiniteNumber(V.DropChance), itemPool = Y }
	end
	self.spawnGroup = DOTA_SpawnMapAtPosition(O, R, true, function(a0)
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "-") .. S) .. "] onReadyToSpawn")
		ManuallyTriggerSpawnGroupCompletion(a0)
	end, function()
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "-") .. S) .. "] onSpawnComplete")
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
		removeUnit = function(a1, a2)
			return self:RemoveUnit(a2)
		end,
	})
end
function L.prototype.RollShopRarity(self)
	if self.shopRarityPoolName == nil or self.shopRarityPoolName == "" then
		return 1
	end
	local a3 = DrawPool:Draw(self.shopRarityPoolName)
	if a3 == nil then
		return 1
	end
	local a4 = 0
	Game:EachPlayer(function(a1, a5)
		a4 = a4 + GetShopItemRarity(a5) + GetArtifactItemRarity(a5)
	end)
	local a6 = math.floor(a4 / 100)
	if math.random(1, 100) <= a4 % 100 then
		a6 = a6 + 1
	end
	local a7 = toFiniteNumber(a3, 1) + a6
	if a7 < 1 then
		return 1
	end
	if a7 > 5 then
		return 5
	end
	return a7
end
function L.prototype.dispose(self)
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
	e(self.breakables, function(a1, a8)
		self:RemoveUnit(a8)
	end)
	e(self.npcs, function(a1, a8)
		self:RemoveUnit(a8)
	end)
	e(self.enemies, function(a1, a8)
		self:RemoveUnit(a8)
	end)
	e(self.simulateEnemies, function(a1, a8)
		a8:dispose()
	end)
	e(self.items, function(a1, a8)
		if IsValid(a8) then
			local a9 = a8:GetContainedItem()
			if IsValid(a9) then
				UTIL_Remove(a9)
			end
			UTIL_Remove(a8)
		end
	end)
	e(self.dropItems, function(a1, a8)
		a8:dispose()
	end)
	e(self.clientItems, function(a1, a8)
		a8:dispose()
	end)
	e(self.shopItems, function(a1, a8)
		a8:dispose()
	end)
	for a1, aa in ipairs(self.exitInfos) do
		if aa.rewardParticleID ~= nil then
			ParticleManager:DestroyParticle(aa.rewardParticleID, true)
			ParticleManager:ReleaseParticleIndex(aa.rewardParticleID)
		end
		if aa.eliteParticleID ~= nil then
			ParticleManager:DestroyParticle(aa.eliteParticleID, true)
			ParticleManager:ReleaseParticleIndex(aa.eliteParticleID)
		end
	end
	self.exitInfos = {}
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
		local ab = 0
		while ab < #self.registeredInteracts do
			Interaction:UnregisterInteractable(self.registeredInteracts[ab + 1])
			ab = ab + 1
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
function L.prototype.SetRewardType(self, Q)
	self.rewardType = Q
end
function L.prototype.SetSpecialKind(self, X)
	self.specialKind = X
end
function L.prototype.Prepare(self)
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
function L.prototype.InitializePreviewRoomRewards(self)
	self.previewRewardSlots = {}
	self.enemyPreviewRewards = {}
	self.previewRewardAssignedEnemyCount = 0
	local ac = self:IsBossRoom() and 1 or math.max(1, self.spawnInfo.totalCount)
	do
		local ab = 0
		while ab < ac do
			local ad = self.previewRewardSlots
			ad[#ad + 1] = {}
			ab = ab + 1
		end
	end
	local ae = 0
	Game:EachPlayer(function(a1, af)
		local ag = CommonService:GetPlayerServiceNetTable(af, "player_room_rewards_preview")
		local ah = ag and ag[self.roomID]
		if ah == nil then
			return
		end
		if toFiniteNumber(ah.receive_times, 0) > 0 then
			return
		end
		local ai = ah.rewards
		if ai == nil or #ai <= 0 then
			return
		end
		do
			local ab = 0
			while ab < #ai do
				do
					local aj = ai[ab + 1]
					local ak = toFiniteNumber(aj.item_id, 0)
					local al = toFiniteNumber(aj.amounts, 0)
					if ak <= 0 or al <= 0 then
						goto am
					end
					local Z = self:ResolvePreviewRewardItemName(ak)
					if Z == nil then
						print(
							((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励 item_id=") .. tostring(ak))
								.. " 未找到对应 itemName，已跳过"
						)
						goto am
					end
					local an = RandomInt(0, ac - 1)
					local ao = self.previewRewardSlots[an + 1]
					ao[#ao + 1] = { playerID = af, itemID = ak, amounts = al, itemName = Z }
					ae = ae + 1
				end
				::am::
				ab = ab + 1
			end
		end
	end)
	if ae > 0 then
		print(
			(
				((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励已预分配到 ") .. tostring(ac))
				.. " 个怪物槽位，奖励条目数="
			) .. tostring(ae)
		)
	end
end
function L.prototype.ResolvePreviewRewardItemName(self, ak)
	if ak <= 0 then
		return nil
	end
	local ap = self.itemNameByItemID[ak]
	if ap ~= nil then
		return ap
	end
	for Z, aq in pairs(KeyValues.items) do
		local ar = toFiniteNumber
		local as = aq.ItemID
		if as == nil then
			as = aq.item_id
		end
		local at = as
		if at == nil then
			at = aq.id
		end
		local au = at
		if au == nil then
			au = aq.ID
		end
		local av = au
		if av == nil then
			av = aq.ServiceItemID
		end
		local aw = ar(av, -1)
		if aw == ak then
			self.itemNameByItemID[ak] = Z
			return Z
		end
	end
	if KeyValues.items.item_health_potion_1 ~= nil then
		self.itemNameByItemID[ak] = "item_health_potion_1"
		print(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] 预览奖励 item_id=") .. tostring(ak))
				.. " 未找到精确映射，使用调试占位物 item_health_potion_1"
		)
		return "item_health_potion_1"
	end
	return nil
end
function L.prototype.AssignPreviewRewardsToEnemy(self, ax)
	local ay = self.previewRewardSlots[self.previewRewardAssignedEnemyCount + 1] or {}
	if #ay > 0 then
		local az = ax:GetEntityIndex()
		self.enemyPreviewRewards[az] = {}
		do
			local ab = 0
			while ab < #ay do
				local aA = self.enemyPreviewRewards[az]
				aA[#aA + 1] = ay[ab + 1]
				ab = ab + 1
			end
		end
		print(
			(
				(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 怪物 ") .. ax:GetUnitName()) .. " 分配到 ")
				.. tostring(#ay)
			) .. " 条预览奖励"
		)
	end
	self.previewRewardAssignedEnemyCount = self.previewRewardAssignedEnemyCount + 1
end
function L.prototype.DropPreviewRewardsFromEnemy(self, a2)
	local az = a2:GetEntityIndex()
	local ai = self.enemyPreviewRewards[az]
	if ai == nil or #ai <= 0 then
		return
	end
	f(self.enemyPreviewRewards, az)
	local aB = GetGroundPosition(a2:GetAbsOrigin(), a2)
	Interaction:BeginSyncBatch()
	do
		local ab = 0
		while ab < #ai do
			do
				local aj = ai[ab + 1]
				if KeyValues.items[aj.itemName] == nil then
					goto aC
				end
				self:AddDroppedPreviewReward(aj.playerID, aj.itemID, aj.amounts)
				local aD = d(w, aj.playerID, aj.itemID, aB)
				local aE = self.clientItems
				aE[#aE + 1] = aD
				local aF = { clientItem = aD, reward = aj }
				local aG = self.previewRewardDrops
				aG[#aG + 1] = aF
				local aH = Interaction:RegisterInteract(aD.entity, InteractType.Consumables, 200, function(a1, aI, af)
					return self:PickupPreviewRewardDrop(aI, aF, af)
				end, 1, aj.playerID)
				if aH ~= -1 then
					aF.interactIndex = aH
					local aJ = self.registeredInteracts
					aJ[#aJ + 1] = aH
				end
				Match:AddPlayerRoundRewards(
					aj.playerID,
					{ { item_id = aj.itemID, amounts = aj.amounts, item_rarity = GetPropRarity(aj.itemID) } }
				)
			end
			::aC::
			ab = ab + 1
		end
	end
	Interaction:EndSyncBatch()
end
function L.prototype.PickupPreviewRewardDrop(self, aI, aF, af)
	if not IsValid(aI) or not aI:IsRealHero() or not aI:IsAlive() then
		return false
	end
	local aD = aF.clientItem
	if aD.isDispose or not aD:IsLanded() or not IsValid(aD.entity) then
		return false
	end
	local aK = af or aI:GetPlayerOwnerID()
	if aK ~= aF.reward.playerID then
		return false
	end
	local aL = aD:GetLandedPosition()
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
										.. tostring(aK)
									) .. " owner="
								) .. tostring(aF.reward.playerID)
							) .. " item_id="
						) .. tostring(aF.reward.itemID)
					) .. " item_name="
				) .. aF.reward.itemName
			) .. " amounts="
		) .. tostring(aF.reward.amounts)
	)
	CommonService:SendReceiveRewards(aK, { { item_id = aF.reward.itemID, amounts = aF.reward.amounts } })
	Event:Fire("client_item_pickup", { playerID = aK, item_id = aF.reward.itemID })
	self:CreateClientItemPickupParticle(aL, aI)
	if aF.interactIndex ~= nil then
		Interaction:UnregisterInteractable(aF.interactIndex)
		ArrayRemove(self.registeredInteracts, aF.interactIndex)
		aF.interactIndex = nil
	end
	ArrayRemove(self.previewRewardDrops, aF)
	ArrayRemove(self.clientItems, aD)
	aD:dispose()
	return true
end
function L.prototype.TryAutoPickupPreviewReward(self, aI)
	if not IsValid(aI) or not aI:IsRealHero() or not aI:IsAlive() then
		return false
	end
	local aK = aI:GetPlayerOwnerID()
	local aM = aI:GetAbsOrigin()
	local aN
	local aO = 200
	do
		local ab = 0
		while ab < #self.previewRewardDrops do
			do
				local aF = self.previewRewardDrops[ab + 1]
				if aF == nil then
					goto aP
				end
				local aD = aF.clientItem
				if aF.reward.playerID ~= aK or aD.isDispose or not aD:IsLanded() or not IsValid(aD.entity) then
					goto aP
				end
				local aQ = aD.entity:GetAbsOrigin()
				local aR = (aM - aQ):Length2D()
				if aR <= aO then
					aO = aR
					aN = aF
				end
			end
			::aP::
			ab = ab + 1
		end
	end
	if aN == nil then
		return false
	end
	return self:PickupPreviewRewardDrop(aI, aN, aK)
end
function L.prototype.CanAutoPickupDropItem(self, aS, aT)
	local aU = aT
	if not aU then
		local aV = KeyValues.items[aS.itemName]
		if aV ~= nil then
			aV = aV.AutoPickUp
		end
		aU = aV == 1
	end
	return aU
end
function L.prototype.RegisterDropItemForAutoPickup(self, aS, aW)
	local aX = self.dropItems
	aX[#aX + 1] = aS
	if aW ~= -1 then
		local aY = self.registeredInteracts
		aY[#aY + 1] = aW
	end
end
function L.prototype.UnregisterDropItemForAutoPickup(self, aS, aW)
	ArrayRemove(self.dropItems, aS)
	if aW ~= -1 then
		ArrayRemove(self.registeredInteracts, aW)
	end
end
function L.prototype.TryAutoPickupDropItem(self, aI, aT)
	if aT == nil then
		aT = false
	end
	if not IsValid(aI) or not aI:IsRealHero() or not aI:IsAlive() then
		return false
	end
	local aK = aI:GetPlayerOwnerID()
	local aM = aI:GetAbsOrigin()
	local aZ
	local a_
	local aO = 200
	do
		local ab = 0
		while ab < #self.dropItems do
			do
				local aS = self.dropItems[ab + 1]
				if
					aS == nil
					or aS.isDispose
					or not aS:IsLanded()
					or not IsValid(aS.entity)
					or not self:CanAutoPickupDropItem(aS, aT)
				then
					goto b0
				end
				if aS.playerID ~= nil and aS.playerID ~= aK then
					goto b0
				end
				local az = aS:GetEntityIndex()
				if az == -1 then
					goto b0
				end
				local aQ = aS.entity:GetAbsOrigin()
				local aR = (aM - aQ):Length2D()
				if aR <= aO then
					aO = aR
					aZ = aS
					a_ = az
				end
			end
			::b0::
			ab = ab + 1
		end
	end
	if aZ == nil or a_ == nil then
		return false
	end
	local aL = aZ.entity:GetAbsOrigin()
	local b1 = Interaction:ExecutePrimaryCallback(a_, aI, aK)
	if not b1 then
		return false
	end
	self:CreateClientItemPickupParticle(aL, aI)
	Interaction:UnregisterInteractable(a_)
	ArrayRemove(self.registeredInteracts, a_)
	ArrayRemove(self.dropItems, aZ)
	return true
end
function L.prototype.AddDroppedPreviewReward(self, af, ak, al)
	if al <= 0 then
		return
	end
	local b2 = tostring(af)
	local b3 = tostring(ak)
	local b4, b5 = self.droppedPreviewRewards, b2
	if b4[b5] == nil then
		b4[b5] = {}
	end
	self.droppedPreviewRewards[b2][b3] = (self.droppedPreviewRewards[b2][b3] or 0) + al
end
function L.prototype.GetDroppedPreviewRewards(self, af)
	local b6 = self.droppedPreviewRewards[tostring(af)]
	if b6 == nil then
		return {}
	end
	local b7 = {}
	for ak, al in pairs(b6) do
		b7[tostring(ak)] = toFiniteNumber(al, 0)
	end
	return b7
end
function L.prototype.Activate(self)
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
				for ab, a2 in ipairs(self.enemies) do
					a2:RemoveModifierByName("modifier_sleep")
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
			if self:GetStairChestPlayerCount() <= 0 then
				self:OpenGates()
			end
		else
			self:OpenGates()
		end
	end
end
function L.prototype.Complete(self, b8)
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
	e(self.items, function(a1, a8)
		if IsValid(a8) then
			local a9 = a8:GetContainedItem()
			if IsValid(a9) then
				UTIL_Remove(a9)
			end
			UTIL_Remove(a8)
		end
	end)
	e(self.dropItems, function(a1, a8)
		a8:dispose()
	end)
	e(self.clientItems, function(a1, a8)
		a8:dispose()
	end)
	e(self.shopItems, function(a1, a8)
		print(a8.itemName, "dispose")
		a8:dispose()
	end)
	self.items = {}
	self.dropItems = {}
	self.clientItems = {}
	self.shopItems = {}
	do
		local ab = 0
		while ab < #self.registeredInteracts do
			Interaction:UnregisterInteractable(self.registeredInteracts[ab + 1])
			ab = ab + 1
		end
	end
	self.registeredInteracts = {}
	for a1, aa in ipairs(self.exitInfos) do
		if aa.rewardParticleID ~= nil then
			ParticleManager:DestroyParticle(aa.rewardParticleID, true)
			ParticleManager:ReleaseParticleIndex(aa.rewardParticleID)
		end
		if aa.eliteParticleID ~= nil then
			ParticleManager:DestroyParticle(aa.eliteParticleID, true)
			ParticleManager:ReleaseParticleIndex(aa.eliteParticleID)
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
function L.prototype.LockGate(self)
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	for a1, bb in ipairs(ba) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if bd == self.entrancePrefix then
			bb:FireOutput("OnUser1", nil, nil, nil, 0)
		end
	end
end
function L.prototype.OpenGates(self)
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
	for a1, bb in ipairs(ba) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if not be[bd] then
			be[bd] = {}
		end
		local bf = be[bd]
		bf[#bf + 1] = bb
	end
	do
		local ab = 0
		while ab < #self.exitInfos do
			do
				local aa = self.exitInfos[ab + 1]
				if aa == nil then
					goto bg
				end
				local b8 = ab
				local bh = self:GetExitTooltip(aa)
				local bi = be[aa.prefix]
				if bi == nil or #bi == 0 then
					print(
						((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 未找到前缀为 ") .. aa.prefix)
							.. " 的门"
					)
					goto bg
				end
				local bj = G[aa.specialKind or ""] or F[aa.roomType] or K[aa.rewardType]
				print(
					(
						(
							(
								(
									(((("[DungeonRoom " .. tostring(self.roomID)) .. "] ") .. tostring(b8)) .. " ")
									.. RoomType[aa.roomType]
								) .. " "
							) .. RoomRewardType[aa.rewardType]
						) .. " 创建粒子效果: "
					) .. tostring(bj)
				)
				if bj ~= nil and aa.rewardParticleID == nil then
					local bk = bi[1]:GetAbsOrigin()
					local bl = ParticleManager:CreateParticleForce(bj, PATTACH_CUSTOMORIGIN, nil)
					ParticleManager:SetParticleControl(bl, 0, bk)
					aa.rewardParticleID = bl
				end
				if aa.roomType == RoomType.ELITE and aa.eliteParticleID == nil then
					local bk = bi[1]:GetAbsOrigin()
					local bm = ParticleManager:CreateParticleForce(
						"particles/generic_gameplay/rune/rune_elite.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(bm, 0, bk)
					aa.eliteParticleID = bm
				end
				for a1, bb in ipairs(bi) do
					local bc = bb:GetName()
					bb:FireOutput("OnUser1", nil, nil, nil, 0)
					local aH = Interaction:RegisterInteract(bb, InteractType.Portal, 200, function(a1, aI)
						aI:AddNewModifier(
							aI,
							nil,
							"modifier_enter_gate",
							{ position = VectorToString(bb:GetAbsOrigin() + aa.direction * 600), duration = 1 }
						)
						DungeonManager:ShowLoadingScreen()
						aI:GameTimer(1, function()
							self:Complete(b8)
						end)
					end)
					Interaction:UpdateInteract(aH, { tooltip = bh })
					if aH ~= -1 then
						local bn = self.registeredInteracts
						bn[#bn + 1] = aH
					end
				end
			end
			::bg::
			ab = ab + 1
		end
	end
	Event:Fire("dungeon_room_open_gates", { room = self })
end
function L.prototype.CreateTreasure(self, R)
	if self:IsBossRoom() then
		self:SpawnBossCoinStacks(R)
		self:OpenGates()
		return
	end
	print("创建奖励:", self.roomID, RoomRewardType[self.rewardType])
	local Z
	repeat
		local bo = self.rewardType
		local bp = bo == RoomRewardType.POM
		if bp then
			Z = "item_tome_of_prop"
			break
		end
		bp = bp or bo == RoomRewardType.BOON
		if bp then
			Z = "item_boon_bless"
			break
		end
		bp = bp or bo == RoomRewardType.DOUBLE_BOON
		if bp then
			Z = "item_boon_bless_double"
			break
		end
		bp = bp or bo == RoomRewardType.HERO_UPGRADE
		if bp then
			Z = "item_hammer_weapon"
			break
		end
		bp = bp or bo == RoomRewardType.TREASURE
		if bp then
			Z = "item_treasure"
			break
		end
		bp = bp or bo == RoomRewardType.GOLD
		do
			Z = "item_gold_pouch"
			break
		end
	until true
	if Z == nil then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 警告：无法获取奖励物品")
		self:OpenGates()
		return
	end
	local aS = d(A, Z, R)
	local bq = aS.particleIDs
	bq[#bq + 1] = ParticleManager:CreateParticleForce(
		"particles/generic_gameplay/rune/rube_drop_items_fx.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aS.entity
	)
	local br = self.dropItems
	br[#br + 1] = aS
	local aH = Interaction:RegisterInteract(aS.entity, InteractType.Chest, 150, function(a1, aI, af)
		if not aS:IsLanded() then
			return false
		end
		aI:AddItemByName(Z)
		if self.rewardType == RoomRewardType.BOON or self.rewardType == RoomRewardType.DOUBLE_BOON then
			local bs = self.rewardType == RoomRewardType.DOUBLE_BOON
			Game:EachPlayer(function(a1, bt)
				Event:Fire("bless_room_reward_claimed", { playerID = bt, isDouble = bs })
			end)
		end
		aS:dispose()
		self:OpenGates()
	end, nil, nil, Z)
	if aH ~= -1 then
		local bu = self.registeredInteracts
		bu[#bu + 1] = aH
	end
end
function L.prototype.SpawnBossCoinStacks(self, bv)
	local bw = RandomInt(8, 15)
	local bx = 480
	local by = 10
	Interaction:BeginSyncBatch()
	do
		local ab = 0
		while ab < bw do
			local bz
			do
				local bA = 0
				while bA < by do
					local bB = RandomFloat(0, 360)
					local aR = RandomFloat(0, bx)
					local bC = Vector(math.cos(bB * math.pi / 180) * aR, math.sin(bB * math.pi / 180) * aR, 0)
					local bD = bv:__add(bC)
					if GridNav:IsValidPosition(bD) then
						bz = bD
						break
					end
					bA = bA + 1
				end
			end
			if bz == nil then
				bz = self:GetNearestValidGridPosition(bv) or bv
			end
			local aS = d(A, "item_coin_stack", bz)
			local bE = self.dropItems
			bE[#bE + 1] = aS
			local aH = Interaction:RegisterInteract(aS.entity, InteractType.Chest, 200, function(a1, aI)
				aI:AddItemByName("item_coin_stack")
				aS:dispose()
			end, nil, nil, "item_coin_stack")
			if aH ~= -1 then
				local bF = self.registeredInteracts
				bF[#bF + 1] = aH
			end
			ab = ab + 1
		end
	end
	Interaction:EndSyncBatch()
	print(((("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss房掉落 ") .. tostring(bw)) .. " 个金币堆")
end
function L.prototype.NormalizeGridPhaseFromCenter(self, bC)
	local bG = GRID_SIZE * 0.5
	local bH = math.abs(bC % GRID_SIZE)
	local bI = math.min(bH, math.abs(GRID_SIZE - bH))
	local bJ = math.abs(bH - bG)
	return bJ < bI and bG or 0
end
function L.prototype.ResolveGridAnalysisOrigin(self)
	local bi = self:FindEntities("prop_dynamic", "prop_gate")
	if #bi <= 0 then
		return self.position
	end
	local bK = 0
	local bL = 0
	local bM = 0
	local bG = GRID_SIZE * 0.5
	do
		local ab = 0
		while ab < #bi do
			local bb = bi[ab + 1]
			local bN = bb:GetAbsOrigin()
			local bO = bN.x - self.position.x
			local bP = bN.y - self.position.y
			local bQ = bN.x
			local bR = bN.y
			if math.abs(bO) > math.abs(bP) then
				bQ = bN.x - (bO > 0 and bG or -bG)
			else
				bR = bN.y - (bP > 0 and bG or -bG)
			end
			if self:NormalizeGridPhaseFromCenter(bQ - self.position.x) >= bG then
				bL = bL + 1
			end
			if self:NormalizeGridPhaseFromCenter(bR - self.position.y) >= bG then
				bM = bM + 1
			end
			bK = bK + 1
			ab = ab + 1
		end
	end
	local bS = bL * 2 > bK and bG or 0
	local bT = bM * 2 > bK and bG or 0
	return Vector(self.position.x + bS, self.position.y + bT, self.position.z)
end
function L.prototype.AnalyzeGrid(self)
	local bv = self:ResolveGridAnalysisOrigin()
	local bU = 5
	local bV = 20
	self.validGridPositions = {}
	local bW = bv.y - GRID_SIZE * 2
	do
		local bX = 0
		while bX <= bV do
			local bY = false
			do
				local bZ = -bX
				while bZ <= bX do
					do
						local b_ = -bX
						while b_ <= bX do
							if math.abs(bZ) == bX or math.abs(b_) == bX then
								local c0 = Vector(bv.x + bZ * GRID_SIZE, bv.y + b_ * GRID_SIZE, bv.z)
								if c0.y > bW and GridNav:IsValidPosition(c0) then
									bY = true
									local c1 = self.validGridPositions
									c1[#c1 + 1] = c0
								else
								end
							end
							b_ = b_ + 1
						end
					end
					bZ = bZ + 1
				end
			end
			if not bY and bX >= bU then
				break
			end
			bX = bX + 1
		end
	end
end
function L.prototype.CreateBreakable(self)
	if #self.validGridPositions == 0 then
		return
	end
	local c2 = RandomInt(0, 3)
	local c3 = math.floor(#self.validGridPositions / 20)
	local c4 = c2 + c3
	if c4 == 0 then
		return
	end
	local bv = self.position
	local c5 = h({ unpack(self.validGridPositions) }, function(a1, c6, c7)
		local c8 = c6:__sub(bv):Length2D()
		local c9 = c7:__sub(bv):Length2D()
		return c9 - c8
	end)
	local ca = i(c5, 0, math.ceil(#c5 * 0.7))
	local cb = {}
	do
		local ab = 0
		while ab < #ca do
			local cc = ca[ab + 1]
			if not self:IsTravelingMerchantNear(cc, GRID_SIZE * 1.5) then
				cb[#cb + 1] = cc
			end
			ab = ab + 1
		end
	end
	local cd = #cb > 0 and cb or ca
	do
		local ab = #cd - 1
		while ab > 0 do
			local ce = RandomInt(0, ab)
			local cf = { cd[ce + 1], cd[ab + 1] }
			cd[ab + 1] = cf[1]
			cd[ce + 1] = cf[2]
			ab = ab - 1
		end
	end
	local cg = math.max(1, math.floor(#cd / (c4 + 1)))
	do
		local ab = 0
		while ab < c4 do
			local ch = RandomInt(2, 4)
			local ci = ab * cg
			if ci >= #cd then
				break
			end
			local cj = cd[ci + 1]
			do
				local ce = 0
				while ce < ch do
					local bB = RandomFloat(0, 360)
					local aR = RandomFloat(50, 150)
					local bC = Vector(math.cos(bB * math.pi / 180) * aR, math.sin(bB * math.pi / 180) * aR, 0)
					local ck = cj:__add(bC)
					CreateUnitByNameAsync(
						DrawPool:Draw(self.terrainThemeKey ~= "ice" and "breakable" or "breakable_ice")
							or "npc_dungeon_crate_1",
						ck,
						true,
						nil,
						nil,
						DOTA_TEAM_BADGUYS,
						function(cl)
							if self.isDispose then
								cl:SafeRemoveUnit()
							else
								cl:SetForwardVector(RandomVector(1))
								cl:SetModelScale(RandomFloat(0.8, 1))
								local cm = self.breakables
								cm[#cm + 1] = cl
								self.occupiedPositions[ci] = true
							end
						end
					)
					ce = ce + 1
				end
			end
			ab = ab + 1
		end
	end
end
function L.prototype.CreateSpawnInfo(self, cn, T)
	if cn == "" or cn == nil then
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
	local co = KeyValues.spawn_info
	local cp = KeyValues["spawn_info_" .. T]
	local cq
	if cp ~= nil then
		cq = cp[cn]
	else
		cq = nil
	end
	local cr = cq
	local cs
	if co ~= nil then
		cs = co[cn]
	else
		cs = nil
	end
	local ct = cs
	if cr == nil and ct == nil then
		print(((("[DungeonRoom] 警告：刷怪配置 '" .. cn) .. "' 在默认和主题'") .. T) .. "'中均未找到")
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
	local function cu(a1, cv)
		if cr ~= nil and cr[cv] ~= nil then
			return cr[cv]
		end
		if ct ~= nil and ct[cv] ~= nil then
			return ct[cv]
		end
		return nil
	end
	local cw = k(g(j(tostring(cu(nil, "EnemyCount"))), "|"), function(a1, a8)
		return toFiniteNumber(a8, 0)
	end)
	local cx = k(g(j(tostring(cu(nil, "CountPerRound"))), "|"), function(a1, a8)
		return toFiniteNumber(a8, 0)
	end)
	if cx[2] == nil then
		cx[2] = cx[1]
	end
	local cy = RollPercentage(toFiniteNumber(cu(nil, "CaptainRoomChance")))
	local cz = RollPercentage(toFiniteNumber(cu(nil, "EliteRoomChance")))
	local cA = cz and toFiniteNumber(cu(nil, "OverrideEliteChance")) or toFiniteNumber(cu(nil, "EliteChance"))
	local cB = cu(nil, "EnemyList")
	local cC = d(E)
	if cB ~= nil then
		for cD, a8 in pairs(cB) do
			cC:Set(cD, toFiniteNumber(a8, 0))
		end
	end
	local cE = RandomInt(cw[1], cw[2])
	local cF = RollPercentage(toFiniteNumber(cu(nil, "DeployChance")))
	local cG = toFiniteNumber(cu(nil, "SpawnInterval"))
	local cH
	if cy then
		cH = cu(nil, "CaptainName")
	else
		cH = ""
	end
	return {
		totalCount = cE,
		countPerRound = cx,
		isDeploy = cF,
		eliteChance = cA,
		spawnInterval = cG,
		captainName = cH,
		bossName = cu(nil, "BossName"),
		healthFactor = toFiniteNumber(cu(nil, "HealthFactor"), 1),
		damageFactor = toFiniteNumber(cu(nil, "DamageFactor"), 1),
		enemyPool = cC,
	}
end
function L.prototype.CreateEnemyForTutorial(self, cI, cJ, cK, cL)
	local cM = {}
	local cN = self:GetGridsAroundPosition(cK, 300)
	if #cN < cJ then
		cN = self:GetGridsAroundPosition(cK, 600)
	end
	if #cN < cJ then
		cN = self:GetGridsAroundPosition(cK, 1200)
	end
	if #cN == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 没有可用生成位置")
		return {}
	end
	do
		local ab = #cN - 1
		while ab > 0 do
			local ce = RandomInt(0, ab)
			local cO = { cN[ce + 1], cN[ab + 1] }
			cN[ab + 1] = cO[1]
			cN[ce + 1] = cO[2]
			ab = ab - 1
		end
	end
	do
		local ab = 0
		while ab < cJ and ab < #cN do
			local ck = cN[ab + 1]
			if cI ~= nil and KeyValues.units[cI] ~= nil then
				if SimulateUnitManager:IsSimulateUnit(cI) then
					local ax = SimulateUnitManager:CreateCustomUnit(cI, ck, DOTA_TEAM_BADGUYS)
					ax:SetForwardVector(RandomVector(1))
					local cP = self.simulateEnemies
					cP[#cP + 1] = ax
					self:AssignPreviewRewardsToEnemy(ax)
				else
					local ax = CreateUnitByName(cI, ck, true, nil, nil, DOTA_TEAM_BADGUYS)
					self:ApplyDifficultyModifiers(ax)
					cM[#cM + 1] = ax
					if cL then
						ax:AddNewModifier(ax, nil, "modifier_elite", {})
					end
				end
			else
				print(
					((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️警告：单位 '") .. cI)
						.. "' 无法创建（可能未在KV中定义）"
				)
			end
			ab = ab + 1
		end
	end
	return cM
end
function L.prototype.CreateWaveEnemy(self)
	local cQ =
		math.min(self.spawnInfo.totalCount, RandomInt(self.spawnInfo.countPerRound[1], self.spawnInfo.countPerRound[2]))
	if cQ <= 0 then
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
	local bv = self.position
	local cN
	if self.currentWave == 0 then
		cN = self:GetAvailablePositionIndices(bv.y - 400, bv.y)
		if #cN < cQ then
			cN = self:GetAvailablePositionIndices()
		end
	else
		cN = self:GetAvailablePositionIndices(bv.y, bv.y + 600)
		if #cN < cQ then
			cN = self:GetAvailablePositionIndices()
		end
	end
	if #cN == 0 then
		print(
			(
				(
					(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 没有可用生成位置，跳过本波 ")
					.. tostring(cQ)
				) .. " 只怪，剩余待刷="
			) .. tostring(self.spawnInfo.totalCount)
		)
		local cR, cS = self.spawnInfo, "totalCount"
		cR[cS] = cR[cS] - cQ
		self.spawnInfo.totalCount = math.max(0, self.spawnInfo.totalCount)
		self:TryFinishCombatWhenNoEnemies(self.position)
		return
	end
	local cT = math.min(cQ, #cN)
	local cU, cV = self.spawnInfo, "totalCount"
	cU[cV] = cU[cV] - cT
	if cT < cQ then
		print(
			(
				(
					(("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 可用生成位置不足，计划=")
					.. tostring(cQ)
				) .. "，实际尝试="
			) .. tostring(cT)
		)
	end
	self.currentWave = self.currentWave + 1
	do
		local ab = #cN - 1
		while ab > 0 do
			local ce = RandomInt(0, ab)
			local cW = { cN[ce + 1], cN[ab + 1] }
			cN[ab + 1] = cW[1]
			cN[ce + 1] = cW[2]
			ab = ab - 1
		end
	end
	local cX = 0
	do
		local ab = 0
		while ab < cT and ab < #cN do
			local cY = cN[ab + 1]
			local ck = self.validGridPositions[cY + 1]
			local cI = self.spawnInfo.enemyPool:Random()
			if cI ~= nil and KeyValues.units[cI] ~= nil then
				local cA = self.spawnInfo.eliteChance
				local cL = RollPercentage(cA)
				self.aliveEnemyCount = self.aliveEnemyCount + 1
				cX = cX + 1
				if SimulateUnitManager:IsSimulateUnit(cI) then
					local ax = SimulateUnitManager:CreateCustomUnit(cI, ck, DOTA_TEAM_BADGUYS)
					ax:SetForwardVector(RandomVector(1))
					local cZ = self.simulateEnemies
					cZ[#cZ + 1] = ax
					self:AssignPreviewRewardsToEnemy(ax)
				else
					CreateUnitByNameAsync(cI, ck, true, nil, nil, DOTA_TEAM_BADGUYS, function(ax)
						if not IsValid(ax) then
							print(
								((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 单位创建失败: ") .. cI)
									.. "，回退计数器"
							)
							self.aliveEnemyCount = self.aliveEnemyCount - 1
							self.aliveEnemyCount = math.max(0, self.aliveEnemyCount)
							return
						end
						if self.isDispose then
							ax:SafeRemoveUnit()
						else
							FindClearSpaceForUnit(ax, ck, true)
							ax:SetForwardVector(RandomVector(1))
							local c_ = self.enemies
							c_[#c_ + 1] = ax
							self:AssignPreviewRewardsToEnemy(ax)
							if not self.isActived then
								ax:AddNewModifier(ax, nil, "modifier_sleep", {})
							end
							self:ApplyDifficultyModifiers(ax)
							if cL then
								ax:AddNewModifier(ax, nil, "modifier_elite", {})
							end
						end
					end)
				end
				self.occupiedPositions[cY] = true
			else
				print(
					((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️警告：单位 '") .. tostring(cI))
						.. "' 无法创建（可能未在KV中定义）"
				)
			end
			ab = ab + 1
		end
	end
	if cX <= 0 then
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
function L.prototype.TryFinishCombatWhenNoEnemies(self, R)
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
	local d0 = GetGroundPosition(R, nil)
	if not GridNav:IsValidPosition(d0) then
		d0 = self:GetNearestValidGridPosition(d0) or self.position
	end
	print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 无剩余有效怪物，执行战斗房兜底清场")
	self:FinishCombat(d0)
end
function L.prototype.FinishCombat(self, R)
	if self.isCombatEnd or self.isDispose then
		return
	end
	self.dungeonTrap:StopCombat()
	self:CreateTreasure(R)
	self:CreateInteractiveTravelingMerchant()
	self.isCombatEnd = true
	self:StopUnitManagerGuardTimer()
	Event:Fire("dungeon_room_clear", { room = self, position = R, trapOnlyClear = self.playerKilledEnemyCount == 0 })
end
function L.prototype.CreateBoss(self)
	if self.bossName == nil or self.bossName == "" then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss房缺少Boss名称配置")
		return
	end
	local U = self.bossName
	if KeyValues.units[U] == nil then
		print(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 警告：Boss单位 '") .. U) .. "' 未在KV中定义")
		return
	end
	local d1 = self:FindInfoTarget("info_boss_spawn")
	local d2 = d1 and d1:GetAbsOrigin() or self.position
	print(
		(
			(
				((((("[DungeonRoom " .. tostring(self.roomID)) .. "] 生成Boss: ") .. U) .. " at (") .. tostring(d2.x))
				.. ", "
			) .. tostring(d2.y)
		) .. ")"
	)
	self.aliveEnemyCount = self.aliveEnemyCount + 1
	CreateUnitByNameAsync(U, d2, true, nil, nil, DOTA_TEAM_BADGUYS, function(d3)
		if not IsValid(d3) then
			print(
				((("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ Boss创建失败: ") .. U)
					.. "，回退计数器"
			)
			self.aliveEnemyCount = self.aliveEnemyCount - 1
			self.aliveEnemyCount = math.max(0, self.aliveEnemyCount)
			return
		end
		if self.isDispose then
			d3:SafeRemoveUnit()
		else
			d3:SetForwardVector(vec3_bottom)
			local d4 = KeyValues.units[U]
			local d5 = math.max(0.1, toFiniteNumber(d4.IntroDuration, 4))
			local d6 = toFiniteNumber(d4.IntroFocusDistance, 520)
			local d7 = toFiniteNumber(d4.IntroHeightOffset, 160)
			local d8 = GameRules:GetGameTime()
			local d9 = d3:GetForwardVector()
			local da = {
				targetEntIndex = d3:GetEntityIndex(),
				targetX = d2.x,
				targetY = d2.y,
				targetZ = d2.z,
				forwardX = d9.x,
				forwardY = d9.y,
				forwardZ = d9.z,
				duration = d5,
				focusDistance = d6,
				heightOffset = d7,
				restoreDuration = 1,
				startTime = d8,
				endTime = d8 + d5,
				sequence = d8,
			}
			CustomNetTables:SetNetData("common", "boss_intro", { state = true })
			CustomNetTables:SetNetData("common", "boss_intro_camera", l({ state = true }, da))
			CustomGameEventManager:Send_ServerToAllClients("boss_camera_intro", da)
			Timer:GameTimer(d5, function()
				CustomNetTables:SetNetData("common", "boss_intro", { state = false })
				CustomNetTables:SetNetData("common", "boss_intro_camera", { state = false })
				self.dungeonTrap:AddBossShrink()
			end)
			Game:EachPlayer(function(a1, af)
				local aI = PlayerResource:GetSelectedHeroEntity(af)
				if IsValid(aI) then
					aI:AddNewModifier(aI, nil, "modifier_stunned", { duration = d5 })
				end
			end)
			DungeonManager:MarkBossSpawned(U)
			local db = self.enemies
			db[#db + 1] = d3
			self:AssignPreviewRewardsToEnemy(d3)
			d3:AddNewModifier(d3, nil, "modifier_boss_custom", {})
			self:ApplyDifficultyModifiers(d3)
			if self.difficultyCooldownReduction ~= 0 then
				d3:AddProperty(PropertyFunction.COOLDOWN_REDUCTION, self.difficultyCooldownReduction)
			end
			if self.difficultyBossGapAmplify ~= 0 then
				d3:AddProperty(PropertyFunction.BOSS_GAP_AMPLIFY, self.difficultyBossGapAmplify)
			end
			print(
				(
					(
						(
							(
								(
									(
										(("[DungeonRoom " .. tostring(self.roomID)) .. "] Boss已生成: ")
										.. d3:GetUnitName()
									) .. "， health:"
								) .. tostring(d3:GetMaxHealth())
							) .. " attack:"
						) .. tostring(d3:GetAttackDamage())
					) .. "当前计数="
				) .. tostring(self.aliveEnemyCount)
			)
		end
	end)
end
function L.prototype.CreateShopItem(self, dc)
	local dd = {}
	local de = self:GetSinglePlayerShopFilterHero()
	if de ~= nil then
		self:AppendShopExcludedForHero(dd, de)
	end
	local df = self:FindInfoTarget("info_shop_heal")
	if IsValid(df) then
		self:SpawnShopItemAtPosition("item_heal_shop", 1, df:GetAbsOrigin(), "heal")
		dd[#dd + 1] = "item_heal_shop"
	end
	local dg = self:FindInfoTarget("info_shop_upgrade")
	if IsValid(dg) then
		self:SpawnShopItemAtPosition("item_bless_upgrade", 1, dg:GetAbsOrigin(), "upgrade")
		dd[#dd + 1] = "item_bless_upgrade"
	end
	local dh = self:FindInfoTarget("info_shop_refresh")
	if IsValid(dh) then
		self:ClearShopRefreshInteract()
		local a2 = CreateUnitByName("interact_shop_refresh", dh:GetAbsOrigin(), false, nil, nil, DOTA_TEAM_GOODGUYS)
		a2:SetForwardVector(vec3_bottom)
		local aH = Interaction:RegisterInteract(a2, InteractType.Refresh, 200, function(a1, aI, af)
			local di = SHOP_REFRESH_BASE_COST + self.shopRefreshCount * SHOP_REFRESH_COST_INCREMENT
			if Player:GetGold(af) < di then
				return false
			end
			Player:ModifyGold(af, -di)
			self.shopRefreshCount = self.shopRefreshCount + 1
			self:RefreshShopItems()
			EmitSoundOnLocationForPlayer("General.Buy", aI:GetAbsOrigin(), af)
			Event:Fire("shop_refresh_purchased", { playerID = af, cost = di })
			return true
		end, 999999)
		if aH ~= -1 then
			Interaction:UpdateInteract(
				aH,
				{
					costInfo = {
						costType = "gold",
						cost = SHOP_REFRESH_BASE_COST + self.shopRefreshCount * SHOP_REFRESH_COST_INCREMENT,
					},
				}
			)
			local dj = self.registeredInteracts
			dj[#dj + 1] = aH
			self.shopRefreshInteractIndex = aH
		end
		self.shopRefreshUnit = a2
		local dk = self.npcs
		dk[#dk + 1] = a2
	end
	local dl = self:FindInfoTarget("info_shop_item")
	if not IsValid(dl) then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] ⚠️ 未找到 info_shop_item，跳过常规商店商品生成"
		)
		return
	end
	local dm = self:GetSymmetricShopPositions(dl:GetAbsOrigin(), SHOP_ITEM_COUNT)
	do
		local dn = 0
		while dn < #dm do
			do
				local a7 = 1
				local Z
				do
					local dp = 0
					while dp < 10 do
						a7 = self:RollShopRarity()
						Z = DrawPool:PickShopItemNameByRarity(a7, dd)
						if Z ~= nil then
							break
						end
						dp = dp + 1
					end
				end
				if Z == nil then
					Z = DrawPool:Draw("items", dd)
					a7 = 1
				end
				if Z == nil then
					goto dq
				end
				self:AppendShopGeneratedExcluded(dd, Z)
				self:SpawnShopItemAtPosition(Z, a7, dm[dn + 1], "item_" .. tostring(dn + 1))
			end
			::dq::
			dn = dn + 1
		end
	end
	if not dc then
		local dr = Vector(dl:GetAbsOrigin().x, dl:GetAbsOrigin().y - 300, dl:GetAbsOrigin().z)
		Game:EachPlayer(function(a1, af)
			if Privilege:HasPrivilege("privilege_bless_003", af) then
				self:CreateFreeShopItem(af, dr, dd)
			end
		end)
	end
end
function L.prototype.CreateFreeShopItem(self, af, R, dd)
	local ds = { unpack(dd) }
	local aI = self:GetShopFilterHero(af)
	if aI ~= nil then
		self:AppendShopExcludedForHero(ds, aI)
	end
	local Z
	local a7 = 1
	local dt = ShuffledList({ 3, 4, 5 })
	do
		local ab = 0
		while ab < #dt do
			local du = dt[ab + 1]
			Z = DrawPool:PickShopItemNameByRarity(du, ds)
			if Z ~= nil then
				a7 = du
				break
			end
			ab = ab + 1
		end
	end
	if Z == nil then
		Z = DrawPool:Draw("items", ds)
		a7 = 1
	end
	if Z ~= nil then
		self:AppendShopGeneratedExcluded(dd, Z)
		self:SpawnShopItemAtPosition(Z, a7, R, "free_item_" .. tostring(af), true, af)
		print(
			(
				(
					(
						(
							((("[DungeonRoom " .. tostring(self.roomID)) .. "] 玩家") .. tostring(af))
							.. "专属免费商品: "
						) .. Z
					) .. " (稀有度"
				) .. tostring(a7)
			) .. ")"
		)
	end
	return Z
end
function L.prototype.GetShopFilterHero(self, af)
	if af ~= nil then
		local aI = PlayerResource:GetSelectedHeroEntity(af)
		return IsValid(aI) and aI or nil
	end
	local b7
	Game:EachPlayer(function(a1, dv)
		if b7 ~= nil then
			return
		end
		local aI = PlayerResource:GetSelectedHeroEntity(dv)
		if IsValid(aI) then
			b7 = aI
		end
	end)
	return b7
end
function L.prototype.GetSinglePlayerShopFilterHero(self)
	if Game:GetPlayerCount() ~= 1 then
		return nil
	end
	return self:GetShopFilterHero()
end
function L.prototype.AppendShopExcludedForHero(self, dd, aI)
	local dw = {}
	local dx = aI:GetAllItems()
	do
		local ab = 0
		while ab < #dx do
			do
				local a9 = dx[ab + 1]
				if not IsValid(a9) then
					goto dy
				end
				local Z = a9:GetAbilityName()
				local dz = KeyValues.items[Z]
				if dz == nil then
					goto dy
				end
				local dA = toFiniteNumber(dz.Quantitylimit, 0)
				if dA > 0 and aI:GetItemCount(Z) >= dA then
					self:AppendShopExcludedItem(dd, Z)
				end
				local dB = self:GetArtifactUpgradeGroup(Z)
				local dC = self:GetArtifactUpgradeRank(Z)
				if dB ~= "" and dC > (dw[dB] or 0) then
					dw[dB] = dC
				end
			end
			::dy::
			ab = ab + 1
		end
	end
	for Z, aq in pairs(KeyValues.items) do
		do
			local dD = tostring
			local dE = aq.UpgradeGroup
			if dE == nil then
				dE = ""
			end
			local dB = dD(dE)
			if dB == "" then
				goto dF
			end
			local dG = dw[dB]
			if dG == nil then
				goto dF
			end
			local dC = toFiniteNumber(aq.UpgradeRank, 0)
			if dC > 0 and dC <= dG then
				self:AppendShopExcludedItem(dd, Z)
			end
		end
		::dF::
	end
end
function L.prototype.AppendShopGeneratedExcluded(self, dd, Z)
	self:AppendShopExcludedItem(dd, Z)
	local dB = self:GetArtifactUpgradeGroup(Z)
	local dC = self:GetArtifactUpgradeRank(Z)
	if dB == "" or dC <= 0 then
		return
	end
	for dH, aq in pairs(KeyValues.items) do
		do
			local dI = tostring
			local dJ = aq.UpgradeGroup
			if dJ == nil then
				dJ = ""
			end
			if dI(dJ) ~= dB then
				goto dK
			end
			local dL = toFiniteNumber(aq.UpgradeRank, 0)
			if dL > 0 and dL <= dC then
				self:AppendShopExcludedItem(dd, dH)
			end
		end
		::dK::
	end
end
function L.prototype.AppendShopExcludedItem(self, dd, Z)
	if not m(dd, Z) then
		dd[#dd + 1] = Z
	end
end
function L.prototype.GetArtifactUpgradeGroup(self, Z)
	local dM = tostring
	local dN = KeyValues.items[Z]
	if dN ~= nil then
		dN = dN.UpgradeGroup
	end
	local dO = dN
	if dO == nil then
		dO = ""
	end
	return dM(dO)
end
function L.prototype.GetArtifactUpgradeRank(self, Z)
	local dP = toFiniteNumber
	local dQ = KeyValues.items[Z]
	if dQ ~= nil then
		dQ = dQ.UpgradeRank
	end
	return dP(dQ, 0)
end
function L.prototype.SpawnShopItemAtPosition(self, Z, a7, R, dR, dS, dT, dU)
	if dS == nil then
		dS = false
	end
	if dU == nil then
		dU = "Default"
	end
	print(
		(
			(
				(
					((((("[DungeonRoom " .. tostring(self.roomID)) .. "] Shop item slot=") .. dR) .. " item=") .. Z)
					.. " rarity="
				) .. tostring(a7)
			) .. " free="
		) .. tostring(dS)
	)
	local aS = d(C, Z, a7, R, dS, dT, dU)
	Interaction:RegisterShopItemInteract(aS)
	local dV = self.registeredInteracts
	dV[#dV + 1] = aS:GetEntityIndex()
	local dW = self.shopItems
	dW[#dW + 1] = aS
end
function L.prototype.GetSymmetricShopPositions(self, bv, cJ)
	local dm = {}
	local dX = 256 - (cJ - 2) * 32
	local dY = -((cJ - 1) * dX) * 0.5
	do
		local dn = 0
		while dn < cJ do
			local bS = dY + dn * dX
			dm[#dm + 1] = Vector(bv.x + bS, bv.y, bv.z)
			dn = dn + 1
		end
	end
	return dm
end
function L.prototype.ClearShopRefreshInteract(self)
	if self.shopRefreshInteractIndex ~= nil then
		Interaction:UnregisterInteractable(self.shopRefreshInteractIndex)
		local dZ = {}
		do
			local ab = 0
			while ab < #self.registeredInteracts do
				local az = self.registeredInteracts[ab + 1]
				if az ~= self.shopRefreshInteractIndex then
					dZ[#dZ + 1] = az
				end
				ab = ab + 1
			end
		end
		self.registeredInteracts = dZ
		self.shopRefreshInteractIndex = nil
	end
	if self.shopRefreshUnit ~= nil then
		ArrayRemove(self.npcs, self.shopRefreshUnit)
		self:RemoveUnit(self.shopRefreshUnit)
		self.shopRefreshUnit = nil
	end
end
function L.prototype.RefreshShopItems(self)
	if self.roomType ~= RoomType.SHOP then
		return
	end
	print(("[DungeonRoom " .. tostring(self.roomID)) .. "] RefreshShopItems")
	Interaction:BeginSyncBatch()
	local d_ = {}
	do
		local ab = 0
		while ab < #self.shopItems do
			do
				local e0 = self.shopItems[ab + 1]
				if e0 == nil then
					goto e1
				end
				local az = e0:GetEntityIndex()
				if az == -1 then
					goto e1
				end
				Interaction:UnregisterInteractable(az)
				d_[az] = true
				e0:dispose()
			end
			::e1::
			ab = ab + 1
		end
	end
	self.shopItems = {}
	local dZ = {}
	do
		local ab = 0
		while ab < #self.registeredInteracts do
			local az = self.registeredInteracts[ab + 1]
			if d_[az] ~= true then
				dZ[#dZ + 1] = az
			end
			ab = ab + 1
		end
	end
	self.registeredInteracts = dZ
	self:ClearShopRefreshInteract()
	self:CreateShopItem(true)
	Interaction:EndSyncBatch()
end
function L.prototype.CreateStairItem(self)
	local e2 = GetGroundPosition(self.position, nil)
	self.stairChestPlayers = {}
	self.stairChestCompletedPlayers = {}
	self.stairChestAutoClaimingPlayers = {}
	self.stairChestOpeningPlayers = {}
	self.stairChestIgnoredPlayers = {}
	self.stairChestItemPos = e2
	local e3 = DungeonManager:IsTutorial()
	Game:EachPlayer(function(a1, af)
		self.stairChestPlayers[af] = true
		local aD = d(w, af, "9900000", e2, { 0, 0 })
		local e4 = self.clientItems
		e4[#e4 + 1] = aD
		local aH
		aH = Interaction:RegisterInteract(aD.entity, InteractType.BossChest, 200, function(a1, aI)
			if not self:CanOpenStairChest(af) then
				return false
			end
			if self:IsEquipmentCapacityFull(af) then
				self:ShowEquipmentCapacityDialog(af, true)
				return false
			end
			self.stairChestOpeningPlayers[af] = true
			self:RequestStairChestRewards(af, 1, false, e2, function(a1, e5)
				self.stairChestOpeningPlayers[af] = false
				if not e5 or self.isDispose or self.stairChestIgnoredPlayers[af] == true then
					self:TryOpenStairGatesByChestState()
					return
				end
				self:CompleteManualStairChestOpen(af, aH, aD, e2, false, false)
			end, true)
			return false
		end, nil, af)
		if not e3 then
			Interaction:SetSecondaryInteraction(aH, function(a1, aI)
				if not self:CanOpenStairChest(af) then
					return false
				end
				if self:IsEquipmentCapacityFull(af) then
					self:ShowEquipmentCapacityDialog(af, true)
					return false
				end
				local e6 = Privilege:HasPrivilege("privilege_bless_001", af)
				local e7 = e6 and Privilege:GetPrivilegeSpecialValue("privilege_bless_001", 1, "free_count", aI) or 0
				local e8 = CommonService:GetPlayerServiceNetTable(af, "player_counters") or {}
				local e9 = e8.daily_free_boss_rewards
				local ea = e9 and e9.count or 0
				local eb = ea < e7
				print(
					(
						(
							(
								(
									(
										((("[DungeonRoom " .. tostring(self.roomID)) .. "] Player ") .. tostring(af))
										.. " Open Boss Chest Rewards isUseFreeCount="
									) .. tostring(eb)
								) .. " usedFreeCount="
							) .. tostring(ea)
						) .. " freeCount="
					) .. tostring(e7)
				)
				if not eb then
					local ec = CommonService:GetPlayerServiceNetTable(af, "player_tokens") or {}
					local ed = ec["110006"]
					if (ed and ed.amounts or 0) < 1 then
						ErrorMessage("error_token_no_enough", af)
						return false
					end
				end
				self.stairChestOpeningPlayers[af] = true
				self:RequestStairChestRewards(af, 2, eb, e2, function(a1, e5)
					self.stairChestOpeningPlayers[af] = false
					if not e5 or self.isDispose or self.stairChestIgnoredPlayers[af] == true then
						self:TryOpenStairGatesByChestState()
						return
					end
					self:CompleteManualStairChestOpen(af, aH, aD, e2, true, eb)
				end, true)
				return false
			end)
			local aI = PlayerResource:GetSelectedHeroEntity(af)
			local e6 = Privilege:HasPrivilege("privilege_bless_001", af)
			local e7 = e6 and Privilege:GetPrivilegeSpecialValue("privilege_bless_001", 1, "free_count", aI) or 0
			local e8 = CommonService:GetPlayerServiceNetTable(af, "player_counters") or {}
			local ee = e8.daily_free_boss_rewards
			local ea = ee and ee.count or 0
			Interaction:UpdateSecondaryInteract(
				aH,
				{ tooltip = "DoubleBossChest", costInfo = {
					cost = 1,
					costType = "110006",
					costSource = "tokens",
					freeCount = e7 - ea,
				} }
			)
		end
		if aH ~= -1 then
			local ef = self.registeredInteracts
			ef[#ef + 1] = aH
		end
	end)
	local a2 = CreateUnitByName(
		"interact_regen_well",
		self.position + Vector(500, 700, 0),
		false,
		nil,
		nil,
		DOTA_TEAM_GOODGUYS
	)
	local aH = Interaction:RegisterInteract(a2, InteractType.RegenWell, 200, function(a1, aI, af)
		local eg = a2:FindModifierByName("modifier_spawn_interact_regen_well")
		if eg ~= nil then
			eg:Activity()
		end
	end, 1)
	if aH ~= -1 then
		local eh = self.registeredInteracts
		eh[#eh + 1] = aH
	end
	local ei = self.npcs
	ei[#ei + 1] = a2
	if DungeonManager:IsFinalZone(self.zoneID) then
		DungeonAdventure:OpenAdventure(self.zoneID, self.roomType, self.position)
	end
end
function L.prototype.CompleteManualStairChestOpen(self, af, aH, aD, e2, bs, eb)
	Interaction:UnregisterInteractable(aH)
	ArrayRemove(self.registeredInteracts, aH)
	self:MarkStairChestCompleted(af)
	EmitSoundOnLocationForPlayer(bs and "Chess.LongOpen" or "Chess.Open", e2, af)
	if eb then
		Notification:CombatToPlayer(af, { message = "Notify_FreeOpenBossRewards" })
	end
	e(aD.particleIDs, function(a1, ej)
		ParticleManager:DestroyParticle(ej, false)
	end)
	aD.particleIDs = {}
	local ek = PlayerResource:GetPlayer(af)
	if ek == nil then
		return
	end
	local el = ParticleManager:CreateParticleForPlayer(
		"particles/generic_gameplay/boss_chest_opening.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aD.entity,
		ek
	)
	ParticleManager:SetParticleControlEnt(el, 1, aD.entity, PATTACH_INVALID, nil, aD.entity:GetAbsOrigin(), true)
	local em = aD.particleIDs
	em[#em + 1] = el
	Timer:GameTimer(0.8, function()
		if self.isDispose or aD.isDispose then
			return
		end
		e(aD.particleIDs, function(a1, ej)
			ParticleManager:DestroyParticle(ej, false)
		end)
		aD.particleIDs = {}
		local en = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/treasure_box/treasure_box_open_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			ek
		)
		ParticleManager:SetParticleControl(en, 0, aD.entity:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(en)
		local eo = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/boss_chest_open.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			ek
		)
		ParticleManager:SetParticleControl(eo, 0, aD.entity:GetAbsOrigin())
		local ep = aD.particleIDs
		ep[#ep + 1] = eo
	end)
end
function L.prototype.CanOpenStairChest(self, af)
	if self.roomType ~= RoomType.STAIR then
		return true
	end
	return self.stairChestCompletedPlayers[af] ~= true
		and self.stairChestAutoClaimingPlayers[af] ~= true
		and self.stairChestOpeningPlayers[af] ~= true
		and self.stairChestIgnoredPlayers[af] ~= true
end
function L.prototype.MarkStairChestCompleted(self, af)
	if self.roomType ~= RoomType.STAIR then
		return
	end
	if self.stairChestCompletedPlayers[af] == true then
		return
	end
	self.stairChestCompletedPlayers[af] = true
	self.stairChestAutoClaimingPlayers[af] = false
	self.stairChestOpeningPlayers[af] = false
	print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 楼梯房宝箱完成 player=") .. tostring(af))
	self:TryOpenStairGatesByChestState()
end
function L.prototype.StartStairChestStateWatcher(self)
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
function L.prototype.StopStairChestStateWatcher(self)
	if self.stairChestStateTimerID == nil then
		return
	end
	Timer:StopTimer(self.stairChestStateTimerID)
	self.stairChestStateTimerID = nil
end
function L.prototype.StartUnitManagerGuardTimer(self)
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
function L.prototype.StopUnitManagerGuardTimer(self)
	if self.unitManagerGuardTimerID == nil then
		return
	end
	Timer:StopTimer(self.unitManagerGuardTimerID)
	self.unitManagerGuardTimerID = nil
end
function L.prototype.CheckUnitManagerGuard(self)
	if UnitManager == nil or not UnitManager:IsReady() then
		return
	end
	local eq = self:GetAliveManagedEnemies()
	if #eq >= 5 then
		return
	end
	local er = {}
	for a1, ax in ipairs(eq) do
		if not UnitManager:IsUnitIndexValid(ax) then
			UnitManager:RepairUnitIndex(ax)
			er[#er + 1] = ax
		end
	end
	if #er <= 0 or self.hasReportedUnitManagerGuard then
		return
	end
	self.hasReportedUnitManagerGuard = true
	self:ReportUnitManagerGuard(er, #eq)
end
function L.prototype.GetAliveManagedEnemies(self)
	local eq = {}
	do
		local ab = 0
		while ab < #self.enemies do
			local ax = self.enemies[ab + 1]
			if IsValid(ax) and ax:IsAlive() then
				eq[#eq + 1] = ax
			end
			ab = ab + 1
		end
	end
	return eq
end
function L.prototype.ReportUnitManagerGuard(self, er, es)
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
				aliveEnemyCount = es,
				trackedEnemyCount = #self.enemies,
				pendingAliveEnemyCount = self.aliveEnemyCount,
				remainingSpawnCount = self.spawnInfo.totalCount,
				repairedEnemies = k(er, function(a1, ax)
					return self:GetUnitManagerGuardUnitReport(ax)
				end),
			}),
		}
	)
end
function L.prototype.GetUnitManagerGuardUnitReport(self, a2)
	return UnitManager and UnitManager:GetUnitIndexReport(a2) or { valid = false }
end
function L.prototype.GetStairChestPlayerCount(self)
	local cJ = 0
	for et in pairs(self.stairChestPlayers) do
		cJ = cJ + 1
	end
	return cJ
end
function L.prototype.RefreshStairChestPlayerStates(self)
	if self.roomType ~= RoomType.STAIR or self.isDispose or self.isComplete or self.gatesOpened then
		return
	end
	for eu in pairs(self.stairChestPlayers) do
		do
			local af = tonumber(eu)
			if
				af == nil
				or self.stairChestCompletedPlayers[af] == true
				or self.stairChestIgnoredPlayers[af] == true
			then
				goto ev
			end
			local ew = PlayerResource:GetConnectionState(af)
			if ew == DOTA_CONNECTION_STATE_CONNECTED then
				goto ev
			end
			if ew == DOTA_CONNECTION_STATE_ABANDONED then
				self.stairChestIgnoredPlayers[af] = true
				self.stairChestAutoClaimingPlayers[af] = false
				self.stairChestOpeningPlayers[af] = false
				print(
					(
						("[DungeonRoom " .. tostring(self.roomID))
						.. "] 楼梯房玩家已放弃，跳过宝箱并不再等待 player="
					) .. tostring(af)
				)
				goto ev
			end
			self:AutoClaimStairChest(af)
		end
		::ev::
	end
	self:TryOpenStairGatesByChestState()
end
function L.prototype.AutoClaimStairChest(self, af)
	if
		self.stairChestCompletedPlayers[af] == true
		or self.stairChestIgnoredPlayers[af] == true
		or self.stairChestAutoClaimingPlayers[af] == true
		or self.stairChestOpeningPlayers[af] == true
	then
		return
	end
	if self.stairChestItemPos == nil then
		return
	end
	self.stairChestAutoClaimingPlayers[af] = true
	print(
		(("[DungeonRoom " .. tostring(self.roomID)) .. "] 楼梯房玩家断线，自动普通开箱 player=")
			.. tostring(af)
	)
	self:RequestStairChestRewards(af, 1, false, self.stairChestItemPos, function(a1, e5)
		self.stairChestAutoClaimingPlayers[af] = false
		if not e5 then
			self:TryOpenStairGatesByChestState()
			return
		end
		if self.isDispose or self.isComplete or self.stairChestIgnoredPlayers[af] == true then
			self:TryOpenStairGatesByChestState()
			return
		end
		self:MarkStairChestCompleted(af)
	end)
end
function L.prototype.TryOpenStairGatesByChestState(self)
	if self.roomType ~= RoomType.STAIR or self.isDispose or self.isComplete or self.gatesOpened then
		return
	end
	local ex = 0
	local ey = 0
	local ez = 0
	local eA = 0
	for eu in pairs(self.stairChestPlayers) do
		do
			local af = tonumber(eu)
			if af == nil then
				goto eB
			end
			ex = ex + 1
			if self.stairChestIgnoredPlayers[af] == true then
				ez = ez + 1
				goto eB
			end
			if self.stairChestCompletedPlayers[af] == true then
				ey = ey + 1
				goto eB
			end
			eA = eA + 1
		end
		::eB::
	end
	print(
		(
			(
				(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 楼梯房宝箱进度 completed=")
								.. tostring(ey)
							) .. " ignored="
						) .. tostring(ez)
					) .. " waiting="
				) .. tostring(eA)
			) .. " total="
		) .. tostring(ex)
	)
	if ex > 0 and eA <= 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 楼梯房所有未放弃玩家已完成宝箱交互，开启出口"
		)
		self:StopStairChestStateWatcher()
		self:OpenGates()
	end
end
function L.prototype.RequestBossChestRewards(self, af, eC, eD, e2, eE, eF)
	if eF == nil then
		eF = false
	end
	if eF and self:IsEquipmentCapacityFull(af) then
		self:ShowEquipmentCapacityDialog(af, true)
		if eE ~= nil then
			eE(nil, false)
		end
		return
	end
	CommonService:RepeatCallAction(
		"/v1/settle/receive_boss_rewards",
		af,
		{
			match_id = Match:GetMatchID(),
			round = DungeonManager:GetZoneIndex(),
			room_step = DungeonManager:GetRoomIndex(),
			open_times = eC,
			use_daily_free_open_times = eD,
		},
		function(a1, eG, eH)
			CommonService:CommonCallback(af, eH)
			self:HandleBossChestRewardsResponse(eG, eH, e2, eE)
		end
	)
end
function L.prototype.RequestStairChestRewards(self, af, eC, eD, e2, eE, eF)
	if eF == nil then
		eF = false
	end
	if DungeonManager:IsTutorial() then
		if eF and self:IsEquipmentCapacityFull(af) then
			self:ShowEquipmentCapacityDialog(af, true)
			if eE ~= nil then
				eE(nil, false)
			end
			return
		end
		CommonService:RepeatCallAction("/v1/player/receive_teach_rewards", af, {}, function(a1, eG, eH)
			CommonService:CommonCallback(af, eH, false)
			self:HandleBossChestRewardsResponse(eG, eH, e2, eE)
		end)
		return
	end
	self:RequestBossChestRewards(af, eC, eD, e2, eE, eF)
end
function L.prototype.HandleBossChestRewardsResponse(self, af, eH, e2, eE)
	if eH.code ~= 0 and eH.code ~= 200 then
		if eE ~= nil then
			eE(nil, false)
		end
		return
	end
	local eI
	if eH ~= nil then
		eI = eH.data
	end
	local eJ
	if eI ~= nil then
		eJ = eI.add_items
	end
	local eK = eJ
	local eL
	if eK ~= nil then
		eL = eK.other
	end
	local eM = eL
	local eN
	if eH ~= nil then
		eN = eH.data
	end
	local eO
	if eN ~= nil then
		eO = eN.player_equipments
	end
	local eP = eO
	local eQ
	if eH ~= nil then
		eQ = eH.data
	end
	local eR
	if eQ ~= nil then
		eR = eQ.player_drawings
	end
	local eS = eR
	local eT
	if eH ~= nil then
		eT = eH.data
	end
	local eU
	if eT ~= nil then
		eU = eT.player_keys
	end
	local eV = eU
	local eW
	if eH ~= nil then
		eW = eH.data
	end
	local eX
	if eW ~= nil then
		eX = eW.player_notices
	end
	local eY = eX
	if eY == nil then
		eY = {}
	end
	local eZ = eY
	local e_ = print
	local f0 = self.roomID
	local f1 = af
	local f2 = eM and #eM or 0
	local f3 = eP and #eP or 0
	local f4 = eS and #eS or 0
	local f5 = eV and #eV or 0
	local f6 = #eZ
	local f7 = eZ[1]
	e_(
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
															("[DungeonRoom " .. tostring(f0))
															.. "] BossRewardsResponse player="
														) .. tostring(f1)
													) .. " otherRewards="
												) .. tostring(f2)
											) .. " playerEquipments="
										) .. tostring(f3)
									) .. " playerDrawings="
								) .. tostring(f4)
							) .. " playerKeys="
						) .. tostring(f5)
					) .. " notices="
				) .. tostring(f6)
			) .. " is3Times="
		) .. (f7 and f7.key or " - ")
	)
	local f8 = eZ[1]
	local f9 = (f8 and f8.key) == "BossRewards3TimesDrop"
	if f9 then
		Notification:CombatToPlayer(af, { message = "Notify_BossRewards3TimesDrop" })
	end
	if not eM and not eP and not eS and not eV then
		if eE ~= nil then
			eE(nil, true)
		end
		self:ScheduleEquipmentCapacityDialog(af)
		return
	end
	if eE ~= nil then
		eE(nil, true)
	end
	self:ScheduleEquipmentCapacityDialog(af)
	Timer:GameTimer(0.8, function()
		if self.isDispose then
			return
		end
		EmitSoundOnLocationForPlayer("Chess.Finish", e2, af)
		local fa = {}
		if eM then
			for a1, aj in ipairs(eM) do
				do
					local fb = tonumber(GetItemPropType(aj.item_id))
					if fb == 9 or fb == 19 or fb == 20 then
						goto fc
					end
					fa[#fa + 1] =
						{ item_id = aj.item_id, amounts = aj.amounts, item_rarity = GetPropRarity(aj.item_id) }
				end
				::fc::
			end
		end
		if eP then
			for a1, fd in ipairs(eP) do
				fa[#fa + 1] = { item_id = fd.equipment_item_id, amounts = 1, item_rarity = fd.rarity, uid = fd.id }
			end
		end
		if eS then
			for a1, fe in ipairs(eS) do
				fa[#fa + 1] = { item_id = fe.drawing_item_id, amounts = 1, item_rarity = fe.rarity, uid = fe.id }
			end
		end
		if eV then
			for a1, ff in ipairs(eV) do
				fa[#fa + 1] = { item_id = ff.key_item_id, amounts = 1, item_rarity = ff.rarity, uid = ff.id }
			end
		end
		local fg = {}
		for ab, aj in ipairs(fa) do
			fg[#fg + 1] = aj
			Timer:GameTimer(0.1 * ab, function()
				if self.isDispose then
					return
				end
				local fh = d(w, af, aj.item_id, e2, { 200, 300 })
				local fi = self.clientItems
				fi[#fi + 1] = fh
				local aH = Interaction:RegisterInteract(fh.entity, InteractType.Consumables, 200, function(a1, aI, bt)
					CommonService:SendReceiveRewards(
						bt,
						{ { item_id = aj.item_id, amounts = aj.amounts, uid = aj.uid } }
					)
					fh:dispose()
					Event:Fire("client_item_pickup", { playerID = af, item_id = aj.item_id })
				end, 1, af)
				Interaction:UpdateInteract(aH, { position = fh:GetLandedPosition() })
				Interaction:SetSecondaryInteraction(aH, function(a1, aI, af)
					local aK = aI:GetPlayerOwnerID()
					local fj = {}
					do
						local ab = 0
						while ab < #self.clientItems do
							do
								local aD = self.clientItems[ab + 1]
								if aD == nil or aD.isDispose or not aD:IsLanded() or not IsValid(aD.entity) then
									goto fk
								end
								if aD.playerID ~= aK then
									goto fk
								end
								local az = aD:GetEntityIndex()
								if az == -1 then
									goto fk
								end
								fj[#fj + 1] = { entityIndex = az, position = aD:GetLandedPosition() }
							end
							::fk::
							ab = ab + 1
						end
					end
					do
						local ab = 0
						while ab < #fj do
							local fl = fj[ab + 1]
							self:CreateClientItemPickupParticle(fl.position, aI)
							Interaction:ExecutePrimaryCallback(fl.entityIndex, aI, af)
							Interaction:UnregisterInteractable(fl.entityIndex)
							ArrayRemove(self.registeredInteracts, fl.entityIndex)
							ab = ab + 1
						end
					end
					self.clientItems = n(self.clientItems, function(a1, a8)
						return not a8.isDispose
					end)
				end)
				Interaction:UpdateSecondaryInteract(aH, { tooltip = "DoubleConsumables" })
				if aH ~= -1 then
					local fm = self.registeredInteracts
					fm[#fm + 1] = aH
				end
			end)
		end
		if #fg > 0 then
			Match:AddPlayerRoundRewards(af, fg)
		end
	end)
end
function L.prototype.GetEquipmentCount(self, af)
	local e8 = CommonService:GetPlayerServiceNetTable(af, "player_counters") or {}
	local fn = e8.equipment_count
	return fn and fn.count or 0
end
function L.prototype.IsEquipmentCapacityFull(self, af)
	return self:GetEquipmentCount(af) >= I
end
function L.prototype.ScheduleEquipmentCapacityDialog(self, af)
	Timer:GameTimer(0.8, function()
		local cJ = self:GetEquipmentCount(af)
		if cJ >= J then
			self:ShowEquipmentCapacityDialog(af, cJ >= I)
		end
	end)
end
function L.prototype.ShowEquipmentCapacityDialog(self, af, fo)
	local ek = PlayerResource:GetPlayer(af)
	if ek == nil then
		return
	end
	CustomGameEventManager:Send_ServerToPlayer(
		ek,
		"client_side_event",
		{
			event_name = "show_popup",
			event_data = json.encode({
				popupName = "EquipmentCapacityDialog",
				PopupID = "equipment_capacity_" .. tostring(af),
				full = fo,
				count = self:GetEquipmentCount(af),
				limit = I,
			}),
		}
	)
end
function L.prototype.CreateSpecialRoom(self)
	if self.roomType == RoomType.SPECIAL then
		local b7 = self.specialKind
		if b7 == nil or b7 == "" then
			local fp = "special_room_zone" .. tostring(self.zoneID)
			b7 = DrawPool:Draw(fp)
			print(
				(((("[DungeonRoom " .. tostring(self.roomID)) .. "] SpecialRoom fallback draw from ") .. fp) .. ": ")
					.. (b7 or "-")
			)
		end
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] SpecialRoom resolved: ") .. (b7 or "-"))
		if b7 ~= nil and type(self["Create" .. b7]) == "function" then
			self["Create" .. b7](self)
		end
	end
end
function L.prototype.CreateWishingPool(self)
	local a2 = CreateUnitByName("interact_wishing_pool", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aH
	aH = Interaction:RegisterInteract(a2, InteractType.Pool, 380, function(a1, aI, af)
		local fq = self.wishingPoolCount * WISHING_POOL_COST
		local e7 = Privilege:GetPlayerDynamicValue("privilege_bless_012", af, "free_count") or 0
		local di = e7 > 0 and 0 or fq
		if e7 > 0 then
			Privilege:SetPlayerDynamicValue("privilege_bless_012", af, "free_count", e7 - 1)
		end
		if di > 0 then
			if Player:GetGold(af) < di then
				EmitAnnouncerSoundForPlayer("General.Cancel", af)
				return false
			end
			Player:ModifyGold(af, -di, true, true)
		end
		self.wishingPoolCount = self.wishingPoolCount + 1
		Interaction:UpdateInteract(
			aH,
			{ costInfo = { cost = self.wishingPoolCount * WISHING_POOL_COST, costType = "gold" } }
		)
		local aj = DrawPool:Draw("wish_pool_zone" .. tostring(self.zoneID))
		if aj ~= nil then
			local fr = CalcDirection2D(aI, self.position)
			local fs = self.position + fr * RandomInt(400, 500)
			fs.z = aI:GetAbsOrigin().z
			local aS = d(A, aj, fs)
			local ft = self.dropItems
			ft[#ft + 1] = aS
			local fu = Interaction:RegisterInteract(aS.entity, InteractType.Chest, 200, function(a1, aI, af)
				if not aS:IsLanded() then
					return false
				end
				if aI ~= nil then
					aI:AddItemByName(aj, nil, false)
				end
				aS:dispose()
			end, nil, nil, aj)
			if fu ~= -1 then
				local fv = self.registeredInteracts
				fv[#fv + 1] = fu
			end
		end
		Event:Fire("wishing_pool_reward", { playerID = af, cost = di })
	end, 99999999)
	if aH ~= -1 then
		Interaction:UpdateInteract(
			aH,
			{ costInfo = { cost = self.wishingPoolCount * WISHING_POOL_COST, costType = "gold" } }
		)
		local fw = self.registeredInteracts
		fw[#fw + 1] = aH
	end
	local fx = self.npcs
	fx[#fx + 1] = a2
end
function L.prototype.CreateRegenWell(self)
	local a2 = CreateUnitByName("interact_regen_well", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aH = Interaction:RegisterInteract(a2, InteractType.RegenWell, 200, function(a1, aI, af)
		local fy = a2:FindModifierByName("modifier_spawn_interact_regen_well")
		if fy ~= nil then
			fy:Activity()
		end
	end, 1)
	if aH ~= -1 then
		local fz = self.registeredInteracts
		fz[#fz + 1] = aH
	end
	local fA = self.npcs
	fA[#fA + 1] = a2
end
function L.prototype.CreateBook(self)
	local a2 = CreateUnitByName("interact_book", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local aH = Interaction:RegisterInteract(a2, InteractType.Book, 200, function(a1, aI, af)
		Game:EachPlayer(function(a1, af)
			BlessUpgrade:RequestEnqueueBlessUpgrade(af, 3)
		end)
		a2:EmitSoundParams("ui.badge_levelup", 0, 0.5, 0)
	end, 1)
	if aH ~= -1 then
		local fB = self.registeredInteracts
		fB[#fB + 1] = aH
	end
	local fC = self.npcs
	fC[#fC + 1] = a2
end
function L.prototype.CreateSmithy(self)
	local a2 = CreateUnitByName("interact_smithy", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	a2:SetForwardVector(vec3_bottom)
	local aH = Interaction:RegisterInteract(a2, InteractType.Smithy, 200, function(a1, fD, et)
		Game:EachPlayer(function(a1, af)
			local b7 = ArtifactUpgrade:RequestEnqueueArtifactUpgrade(af, 3)
			if not b7 then
				ErrorMessage("#error_no_artifact_upgrade", af)
				Artifact:RequestEnqueueArtifactSelection(af, 3, { [2] = 7, [3] = 3 })
			end
		end)
		a2:EmitSoundParams("ui.badge_levelup", 0, 0.5, 0)
	end, 1)
	if aH ~= -1 then
		local fE = self.registeredInteracts
		fE[#fE + 1] = aH
	end
	local fF = self.npcs
	fF[#fF + 1] = a2
end
function L.prototype.HasTravelingMerchant(self)
	return self.specialKind == H
end
function L.prototype.IsTravelingMerchantNear(self, R, fG)
	if self.travelingMerchantPosition == nil then
		return false
	end
	return CalcDistance(R, self.travelingMerchantPosition) <= fG
end
function L.prototype.GetTravelingMerchantTrapPositions(self)
	local fH = {}
	local fI = Entities:FindAllByClassname("prop_dynamic")
	do
		local ab = 0
		while ab < #fI do
			local fJ = fI[ab + 1]
			if fJ:GetSpawnGroupHandle() == self.spawnGroup and o(fJ:GetName(), "trap_fire_model") then
				fH[#fH + 1] = fJ:GetAbsOrigin()
			end
			ab = ab + 1
		end
	end
	return fH
end
function L.prototype.GetTravelingMerchantExitInfos(self)
	local fK = {}
	do
		local ab = 0
		while ab < #self.exitInfos do
			do
				local aa = self.exitInfos[ab + 1]
				if aa == nil then
					goto fL
				end
				fK[#fK + 1] = { position = aa.position, direction = aa.direction }
			end
			::fL::
			ab = ab + 1
		end
	end
	return fK
end
function L.prototype.IsTravelingMerchantBlockedByExit(self, R)
	local fK = self:GetTravelingMerchantExitInfos()
	local fM = GRID_SIZE * 2
	local fN = GRID_SIZE * 0.75
	do
		local ab = 0
		while ab < #fK do
			local aa = fK[ab + 1]
			local fO = R:__sub(aa.position)
			local fP = fO.x * aa.direction.x + fO.y * aa.direction.y
			local fQ = -fP
			local fR = math.abs(fO.x * -aa.direction.y + fO.y * aa.direction.x)
			if fQ >= 0 and fQ <= fM and fR <= fN then
				return true
			end
			ab = ab + 1
		end
	end
	return false
end
function L.prototype.ResolveTravelingMerchantForward(self, R)
	local bO = R.x - self.position.x
	local bP = R.y - self.position.y
	if math.abs(bO) > math.abs(bP) then
		return bO > 0 and vec3_left or vec3_right
	end
	return vec3_bottom
end
function L.prototype.IsTravelingMerchantGridPositionValid(self, R)
	do
		local ab = 0
		while ab < #self.validGridPositions do
			local fS = self.validGridPositions[ab + 1]
			if fS ~= nil and CalcDistance(fS, R) <= GRID_SIZE * 0.25 then
				return true
			end
			ab = ab + 1
		end
	end
	return false
end
function L.prototype.CanPlaceTravelingMerchantAt(self, R, fT)
	if not self:IsTravelingMerchantGridPositionValid(R) then
		return false
	end
	local fU = R:__add(fT:__mul(GRID_SIZE))
	local fV = Vector(-fT.y, fT.x, 0)
	local fW = R:__add(fV:__mul(GRID_SIZE))
	local fX = R:__sub(fV:__mul(GRID_SIZE))
	return self:IsTravelingMerchantGridPositionValid(fU)
		and self:IsTravelingMerchantGridPositionValid(fW)
		and self:IsTravelingMerchantGridPositionValid(fX)
end
function L.prototype.GetTravelingMerchantDirectionCandidates(self, R)
	local fY = self:ResolveTravelingMerchantForward(R)
	local fZ = { fY }
	local f_ = { vec3_bottom, vec3_left, vec3_right }
	do
		local ab = 0
		while ab < #f_ do
			local fr = f_[ab + 1]
			if fr ~= fY then
				fZ[#fZ + 1] = fr
			end
			ab = ab + 1
		end
	end
	return fZ
end
function L.prototype.ResolveTravelingMerchantAngles(self, fr)
	if fr == vec3_left then
		return "0 180 0"
	end
	if fr == vec3_right then
		return "0 0 0"
	end
	return "0 -90 0"
end
function L.prototype.ResolveTravelingMerchantAdjustedPosition(self, R, fT)
	local g0 = R
	local g1 = fT:__mul(-1)
	local g2 = GRID_SIZE * 0.1
	local g3 = GRID_SIZE * 0.5
	local g4 = 10
	do
		local g5 = 0
		while g5 <= g4 do
			local g6 = g3 + g2 * g5
			local cc = R:__add(g1:__mul(g6))
			if not self:IsPositionInside(cc) or not GridNav:IsValidPosition(cc) then
				break
			end
			g0 = cc
			g5 = g5 + 1
		end
	end
	return g0
end
function L.prototype.ResolveTravelingMerchantSpawnData(self)
	self.travelingMerchantPosition = nil
	self.travelingMerchantForward = vec3_bottom
	self.travelingMerchantAngles = "0 -90 0"
	if not self:HasTravelingMerchant() then
		return
	end
	if #self.validGridPositions <= 0 then
		return
	end
	local g7 = math.huge
	local g8 = -math.huge
	local g9 = -math.huge
	do
		local ab = 0
		while ab < #self.validGridPositions do
			do
				local fS = self.validGridPositions[ab + 1]
				if fS == nil then
					goto ga
				end
				g7 = math.min(g7, fS.x)
				g8 = math.max(g8, fS.x)
				g9 = math.max(g9, fS.y)
			end
			::ga::
			ab = ab + 1
		end
	end
	local fH = self:GetTravelingMerchantTrapPositions()
	local gb = GRID_SIZE * 1.25
	local gc = nil
	local gd = nil
	local ge = math.huge
	local gf = -math.huge
	do
		local ab = 0
		while ab < #self.validGridPositions do
			do
				local fS = self.validGridPositions[ab + 1]
				if fS == nil then
					goto gg
				end
				if self:IsTravelingMerchantBlockedByExit(fS) then
					goto gg
				end
				local gh = false
				do
					local gi = 0
					while gi < #fH do
						if CalcDistance(fS, fH[gi + 1]) <= gb then
							gh = true
							break
						end
						gi = gi + 1
					end
				end
				if gh then
					goto gg
				end
				local fZ = self:GetTravelingMerchantDirectionCandidates(fS)
				local gj = nil
				do
					local gk = 0
					while gk < #fZ do
						local fr = fZ[gk + 1]
						if self:CanPlaceTravelingMerchantAt(fS, fr) then
							gj = fr
							break
						end
						gk = gk + 1
					end
				end
				if gj == nil then
					goto gg
				end
				local gl = math.min(math.abs(fS.x - g7), math.abs(g8 - fS.x), math.abs(g9 - fS.y))
				local gm = CalcDistance(fS, self.position)
				if gl < ge or gl == ge and gm > gf then
					gc = fS
					gd = gj
					ge = gl
					gf = gm
				end
			end
			::gg::
			ab = ab + 1
		end
	end
	if gc == nil or gd == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] TravelingMerchant 未找到满足前方和两侧相邻网格条件的站位，跳过创建"
		)
		return
	end
	local g0 = self:ResolveTravelingMerchantAdjustedPosition(gc, gd)
	self.travelingMerchantPosition = GetGroundPosition(g0, nil)
	self.travelingMerchantForward = gd
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
function L.prototype.CreateTravelingMerchantPlaceholder(self)
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
function L.prototype.GetTravelingMerchantArtifactPool(self)
	local gn = {}
	for Z, aq in pairs(KeyValues.artifact) do
		local go = tostring
		local gp = aq.Access
		if gp == nil then
			gp = ""
		end
		if go(gp) == "Meepo" then
			gn[#gn + 1] = tostring(Z)
		end
	end
	return gn
end
function L.prototype.GetTravelingMerchantItemRarity(self, Z)
	return self:RollTavernItemRarity(Z)
end
function L.prototype.CreateTravelingMerchantShopItems(self)
	if self.travelingMerchantPosition == nil then
		return
	end
	local Y = self:GetTravelingMerchantArtifactPool()
	if #Y <= 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] TravelingMerchant 未找到 Access=Meepo 的 artifact 商品"
		)
		return
	end
	local dd = {}
	local de = self:GetSinglePlayerShopFilterHero()
	if de ~= nil then
		self:AppendShopExcludedForHero(dd, de)
	end
	local gq = self.travelingMerchantForward:__mul(128)
	local gr = self.travelingMerchantPosition:__add(gq)
	local fV = Vector(-self.travelingMerchantForward.y, self.travelingMerchantForward.x, 0)
	local gs = { -128, 0, 128 }
	local gt = {}
	local gu = ShuffledList(Y)
	do
		local ab = 0
		while ab < #gu and #gt < 3 do
			do
				local Z = gu[ab + 1]
				if Z == nil or Z == "" or m(dd, Z) then
					goto gv
				end
				gt[#gt + 1] = Z
				self:AppendShopGeneratedExcluded(dd, Z)
			end
			::gv::
			ab = ab + 1
		end
	end
	do
		local ab = 0
		while ab < #gt do
			do
				local Z = gt[ab + 1]
				if Z == nil or Z == "" then
					goto gw
				end
				local aL = gr:__add(fV:__mul(gs[ab + 1] or 0))
				local a7 = self:GetTravelingMerchantItemRarity(Z)
				self:SpawnShopItemAtPosition(
					Z,
					a7,
					aL,
					"traveling_merchant_" .. tostring(ab + 1),
					false,
					nil,
					"TravelingMerchant"
				)
			end
			::gw::
			ab = ab + 1
		end
	end
	local dr = gr:__add(gq)
	Game:EachPlayer(function(a1, af)
		if Privilege:HasPrivilege("privilege_041", af) then
			self:CreateFreeTravelingMerchantItem(af, dr, Y, dd)
		end
	end)
end
function L.prototype.CreateFreeTravelingMerchantItem(self, af, R, Y, dd)
	local ds = { unpack(dd) }
	local gx = {}
	local aI = self:GetShopFilterHero(af)
	if aI ~= nil then
		self:AppendShopExcludedForHero(ds, aI)
		self:AppendShopExcludedForHero(gx, aI)
	end
	local Z
	local gu = ShuffledList(Y)
	do
		local ab = 0
		while ab < #gu do
			local bD = gu[ab + 1]
			if bD ~= nil and bD ~= "" and not m(ds, bD) then
				Z = bD
				break
			end
			ab = ab + 1
		end
	end
	if Z == nil then
		do
			local ab = 0
			while ab < #gu do
				local bD = gu[ab + 1]
				if bD ~= nil and bD ~= "" and not m(gx, bD) then
					Z = bD
					break
				end
				ab = ab + 1
			end
		end
	end
	if Z == nil then
		return
	end
	self:AppendShopGeneratedExcluded(dd, Z)
	local a7 = self:GetTravelingMerchantItemRarity(Z)
	self:SpawnShopItemAtPosition(Z, a7, R, "traveling_merchant_free_" .. tostring(af), true, af, "TravelingMerchant")
end
function L.prototype.CreateInteractiveTravelingMerchant(self)
	if
		not self:HasTravelingMerchant()
		or self.travelingMerchantPosition == nil
		or IsValid(self.travelingMerchantUnit)
	then
		return
	end
	local a2 = CreateUnitByName("interact_meepo", self.travelingMerchantPosition, false, nil, nil, DOTA_TEAM_GOODGUYS)
	a2:SetForwardVector(Rotation2D(self.travelingMerchantForward, 135, true))
	self.travelingMerchantUnit = a2
	local gy = self.npcs
	gy[#gy + 1] = a2
	self:CreateTravelingMerchantShopItems()
end
function L.prototype.RollTavernItemRarity(self, Z)
	local aq = KeyValues.items[Z]
	local gz = aq and aq.RarityRange
	if gz == nil or j(tostring(gz)) == "" then
		local gA = aq and aq.Rarity
		if gA ~= nil and j(tostring(gA)) ~= "" then
			return toFiniteNumber(gA, 1)
		end
		return 1
	end
	local gB = n(
		k(g(tostring(gz), "|"), function(a1, a8)
			return toFiniteNumber(a8, 0)
		end),
		function(a1, a8)
			return a8 > 0
		end
	)
	if #gB == 0 then
		return 1
	end
	local gC = { [1] = 50, [2] = 30, [3] = 15, [4] = 4, [5] = 1 }
	local gD = d(E)
	do
		local ab = 0
		while ab < #gB do
			local a7 = gB[ab + 1]
			gD:Set(a7, gC[a7] or 1)
			ab = ab + 1
		end
	end
	return gD:Random() or gB[1]
end
function L.prototype.CreateTavernItems(self)
	local gE = PickList(TAVERN_ITEMS, 4)
	local gF = { 1, 1, 1, 1 }
	local dl = self:FindInfoTarget("info_shop_item")
	if not IsValid(dl) then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] ⚠️ 未找到 info_shop_item，跳过酒馆商品生成"
		)
		return
	end
	local gG = dl:GetAbsOrigin()
	local dm = self:GetSymmetricShopPositions(gG, #gE)
	print((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateTavernItems: slots=") .. tostring(#dm))
	do
		local dn = 0
		while dn < #dm do
			do
				local Z = gE[dn + 1]
				local a7 = gF[dn + 1] or 1
				if Z == nil or Z == "" then
					goto gH
				end
				print(
					(
						(
							(
								((("[DungeonRoom " .. tostring(self.roomID)) .. "] Tavern item slot=") .. tostring(dn))
								.. " item="
							) .. Z
						) .. " rarity="
					) .. tostring(a7)
				)
				self:SpawnShopItemAtPosition(Z, a7, dm[dn + 1], "tavern_" .. tostring(dn + 1))
			end
			::gH::
			dn = dn + 1
		end
	end
	local gI = n(TAVERN_ITEMS, function(a1, Z)
		return not m(gE, Z)
	end)
	local dr = Vector(gG.x, gG.y - 300, gG.z)
	Game:EachPlayer(function(a1, af)
		if not Privilege:HasPrivilege("privilege_042", af) then
			return
		end
		local gJ = PickList(#gI > 0 and gI or TAVERN_ITEMS, 1)
		local Z = gJ[1]
		if Z == nil or Z == "" then
			return
		end
		local a7 = gF[1] or 1
		self:SpawnShopItemAtPosition(Z, a7, dr, "tavern_free_" .. tostring(af), true, af)
	end)
end
function L.prototype.CreateFaith(self)
	local gK = DrawPool:Draw("faith")
	if gK then
		local a2 = CreateUnitByName(gK, self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
		local aH = Interaction:RegisterInteract(a2, InteractType.ShopItem, 200, function(a1, aI, af)
			local a9 = DrawPool:Draw(gK)
			if a9 ~= nil then
				aI:AddItemByName(a9)
			end
		end)
		if aH ~= -1 then
			local gL = self.registeredInteracts
			gL[#gL + 1] = aH
		end
		local gM = self.npcs
		gM[#gM + 1] = a2
	end
end
function L.prototype.CreateOutpost(self)
	local a2 = CreateUnitByName("bonus_outpost", self.position, false, nil, nil, DOTA_TEAM_GOODGUYS)
	local gN = self.npcs
	gN[#gN + 1] = a2
end
function L.prototype.ShouldCreateSecretRoom(self)
	if not DungeonManager:HasSecretRoomPrefabs() then
		print(
			("[DungeonRoom " .. tostring(self.roomID)) .. "] 当前地形未配置隐藏房间预制体，跳过创建"
		)
		return false
	end
	local gO = DungeonManager:GetSecretRoomChance()
	local gP = RollPercentage(gO)
	print(
		(
			((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间判定 chance=") .. tostring(gO))
			.. "% result="
		) .. tostring(gP)
	)
	return gP
end
function L.prototype.TryCreateSecretGate(self, gQ, gR, gS)
	if self.secretRoomPrefix ~= nil then
		return
	end
	if not self:ShouldCreateSecretRoom() then
		return
	end
	local gT = d(p, gR)
	gT:add(self.entrancePrefix)
	local gU = {}
	do
		local ab = 0
		while ab < #gQ do
			local bd = gQ[ab + 1]
			if bd ~= nil and not gT:has(bd) then
				gU[#gU + 1] = bd
			end
			ab = ab + 1
		end
	end
	if #gU == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 没有未使用的出口可用于隐藏房间")
		return
	end
	local gV = GetRandomElement(gU)
	if gV == nil then
		return
	end
	local gW = r(gS, function(a1, gX)
		return q(gX:GetName(), gV .. "_")
	end)
	if not IsValid(gW) then
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间出口实体无效: ") .. gV)
		return
	end
	local gY = gW:GetAbsOrigin()
	local bv = self.position
	local bO = gY.x - bv.x
	local bP = gY.y - bv.y
	local fr
	if math.abs(bP) > math.abs(bO) then
		fr = vec3_top
	else
		fr = bO > 0 and vec3_right or vec3_left
	end
	local bN = gY:__add(fr:__mul(-128))
	self.secretRoomPrefix = gV
	self.secretRoomDoorPosition = gY
	self.secretRoomDoorDirection = fr
	CreateUnitByNameAsync("npc_dungeon_secret_gate", bN, true, nil, nil, DOTA_TEAM_BADGUYS, function(bb)
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
		bb:SetAbsOrigin(bN)
		bb:SetForwardVector(Rotation2D(fr, 180, true))
		self.secretRoomGate = bb
		local gZ = self.enemies
		gZ[#gZ + 1] = bb
		print(
			(
				(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门已创建: prefix=")
								.. gV
							) .. " pos=("
						) .. tostring(bN.x)
					) .. ", "
				) .. tostring(bN.y)
			) .. ")"
		)
	end)
end
function L.prototype.CreateSecretRoom(self, g_, fr)
	local h0 = DungeonManager:GetSecretRoomPrefab(fr)
	if h0 == nil then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间未配置当前方向的预制体，跳过创建"
		)
		return
	end
	local function h1(a1, h2, h3)
		if h2 % 64 == 0 then
			return h2
		end
		if h3 > 0 then
			return math.ceil(h2 / 64) * 64
		end
		if h3 < 0 then
			return math.floor(h2 / 64) * 64
		end
		return math.floor(h2 / 64 + 0.5) * 64
	end
	local fs = Vector(h1(nil, g_.x, fr.x), h1(nil, g_.y, fr.y), g_.z)
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
													) .. h0
												) .. " door=("
											) .. tostring(g_.x)
										) .. ", "
									) .. tostring(g_.y)
								) .. ") spawn=("
							) .. tostring(fs.x)
						) .. ", "
					) .. tostring(fs.y)
				) .. ", "
			) .. tostring(fs.z)
		) .. ")"
	)
	self.isSecretRoomCreated = true
	self.secretRoomSpawnGroup = DOTA_SpawnMapAtPosition(h0, fs, true, function(a0)
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间 onReadyToSpawn")
		ManuallyTriggerSpawnGroupCompletion(a0)
	end, function()
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间 onSpawnComplete")
		self:RevealSecretRoomGates()
		self:OnSecretRoomContentReady(fs, fr)
	end, nil)
end
function L.prototype.OnSecretRoomContentReady(self, fs, fr)
	local h4 = Entities:FindAllByClassname("info_target")
	local h5 = {}
	for a1, h6 in ipairs(h4) do
		if h6:GetSpawnGroupHandle() == self.secretRoomSpawnGroup and o(h6:GetName(), "info_waard") then
			h5[#h5 + 1] = h6:GetAbsOrigin()
		end
	end
	if #h5 == 0 then
		print(
			("[DungeonRoom " .. tostring(self.roomID))
				.. "] 隐藏房间内未找到 info_waard 实体，使用推算中心位置"
		)
		h5[#h5 + 1] = fs:__add(fr:__mul(960))
	end
	Interaction:BeginSyncBatch()
	do
		local h7 = 0
		while h7 < #h5 do
			local h8 = h5[h7 + 1]
			if RollPercentage(50) then
				local bw = RandomInt(8, 15)
				local bx = 480
				do
					local ab = 0
					while ab < bw do
						local bB = RandomFloat(0, 360)
						local aR = RandomFloat(0, bx)
						local bC = Vector(math.cos(bB * math.pi / 180) * aR, math.sin(bB * math.pi / 180) * aR, 0)
						local bz = h8:__add(bC)
						local aS = d(A, "item_coin_stack", bz)
						local h9 = self.dropItems
						h9[#h9 + 1] = aS
						local aH = Interaction:RegisterInteract(aS.entity, InteractType.Chest, 200, function(a1, aI)
							aI:AddItemByName("item_coin_stack")
							aS:dispose()
						end, nil, nil, "item_coin_stack")
						if aH ~= -1 then
							local ha = self.registeredInteracts
							ha[#ha + 1] = aH
						end
						ab = ab + 1
					end
				end
				print(
					(
						(
							(
								(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间内容就绪，在 ward[")
								.. tostring(h7)
							) .. "] 周围生成 "
						) .. tostring(bw)
					) .. " 个金币堆"
				)
			else
				local aS = d(A, "item_treasure_secret", h8)
				local hb = self.dropItems
				hb[#hb + 1] = aS
				local aH = Interaction:RegisterInteract(aS.entity, InteractType.Chest, 200, function(a1, aI)
					aI:AddItemByName("item_treasure_secret")
					aS:dispose()
				end, nil, nil, "item_treasure_secret")
				if aH ~= -1 then
					local hc = self.registeredInteracts
					hc[#hc + 1] = aH
				end
			end
			h7 = h7 + 1
		end
	end
	Interaction:EndSyncBatch()
end
function L.prototype.RevealSecretRoomGates(self)
	if self.secretRoomPrefix == nil then
		return
	end
	local hd = self:FindEntities("prop_dynamic", "prop_wall")
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	local he = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	for a1, hf in ipairs(hd) do
		local bd = g(hf:GetName(), "_")[1]
		if bd == self.secretRoomPrefix then
			hf:AddEffects(EF_NODRAW)
		end
	end
	for a1, bb in ipairs(ba) do
		local bd = g(bb:GetName(), "_")[1]
		if bd == self.secretRoomPrefix then
			bb:AddEffects(EF_NODRAW)
		end
	end
	for a1, bb in ipairs(he) do
		local bd = g(bb:GetName(), "_")[1]
		if bd == self.secretRoomPrefix then
			bb:AddEffects(EF_NODRAW)
		end
	end
	print(
		(("[DungeonRoom " .. tostring(self.roomID)) .. "] 隐藏房间门已揭示: prefix=") .. self.secretRoomPrefix
	)
end
function L.prototype.CreateEntrance(self)
	local gS = self:FindInfoTargets("info_room_start")
	if #gS == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	local hg = d(p)
	for a1, h6 in ipairs(gS) do
		local bc = h6:GetName()
		local bd = g(bc, "_")[1]
		if bd ~= nil and bd ~= "" then
			hg:add(bd)
		end
	end
	local hh = s(hg)
	if #hh == 0 then
		self.entrancePos = GetRandomElement(self.validGridPositions) or vec3_zero
		return
	end
	self.entrancePrefix = GetRandomElement(hh) or ""
	local hi = r(gS, function(a1, gX)
		return q(gX:GetName(), self.entrancePrefix .. "_")
	end)
	self.entrancePos = IsValid(hi) and hi:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
end
function L.prototype.CreateExit(self)
	local gS = self:FindInfoTargets("info_room_exit")
	print(
		((("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 找到 ") .. tostring(#gS))
			.. " 个 info_room_exit"
	)
	if #gS == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无出口实体，使用默认配置")
		return
	end
	local hg = d(p)
	for a1, h6 in ipairs(gS) do
		local bc = h6:GetName()
		local bd = g(bc, "_")[1]
		if bd ~= nil and bd ~= "" then
			hg:add(bd)
		end
	end
	local hh = s(hg)
	if #hh == 0 then
		print(("[DungeonRoom " .. tostring(self.roomID)) .. "] CreateExit - 无有效前缀")
		return
	end
	local hj = DungeonManager:GetExitCountOverrideByIndex(self.roomID) or 1
	local hk = self.roomID + 1
	local hl = DungeonManager:GetRoomTypeByIndex(hk)
	local hm = DungeonManager:GetRewardTypeByIndex(hk)
	local hn = DungeonManager:GetRewardOptionsByIndex(hk)
	local ho = DungeonManager:GetSpecialOptionsByIndex(hk)
	if #ho > 0 then
		hj = #ho
	elseif #hn > 1 then
		hj = #hn
	end
	hj = math.min(#hh, hj)
	local gR = PickList(hh, hj)
	local hp = {}
	local hq = {}
	if #ho > 0 then
		local hr = { unpack(ho) }
		do
			local ab = #hr - 1
			while ab > 0 do
				local ce = RandomInt(0, ab)
				local hs = { hr[ce + 1], hr[ab + 1] }
				hr[ab + 1] = hs[1]
				hr[ce + 1] = hs[2]
				ab = ab - 1
			end
		end
		do
			local ab = 0
			while ab < hj do
				hp[#hp + 1] = hm
				hq[#hq + 1] = hr[ab + 1] or hr[1] or ""
				ab = ab + 1
			end
		end
	elseif #hn > 0 then
		if hj <= 1 then
			hp = { hm }
		else
			do
				local ab = 0
				while ab < hj do
					hp[#hp + 1] = hn[ab + 1] or hm
					ab = ab + 1
				end
			end
		end
	else
		hp = { hm }
	end
	self.exitInfos = {}
	local bv = self.position
	do
		local ab = 0
		while ab < #gR do
			do
				local bd = gR[ab + 1]
				if bd == nil then
					goto ht
				end
				local gW = r(gS, function(a1, gX)
					return q(gX:GetName(), bd .. "_")
				end)
				local gY = IsValid(gW) and gW:GetAbsOrigin() or (GetRandomElement(self.validGridPositions) or vec3_zero)
				local bO = gY.x - bv.x
				local bP = gY.y - bv.y
				local fr
				if math.abs(bP) > math.abs(bO) then
					fr = vec3_top
				else
					fr = bO > 0 and vec3_right or vec3_left
				end
				local hu = self.exitInfos
				hu[#hu + 1] = {
					prefix = bd,
					position = gY,
					direction = fr,
					roomType = hl,
					rewardType = hp[ab + 1] or hm,
					specialKind = hq[ab + 1],
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
													.. tostring(ab)
												) .. ": prefix="
											) .. bd
										) .. " nextType="
									) .. RoomType[hl]
								) .. " reward="
							) .. RoomRewardType[hp[ab + 1] or hm]
						) .. " special="
					) .. (hq[ab + 1] or "-")
				)
			end
			::ht::
			ab = ab + 1
		end
	end
	self:TryCreateSecretGate(hh, gR, gS)
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
												) .. tostring(hj)
											) .. "，next:"
										) .. RoomType[hl]
									) .. "-"
								) .. RoomRewardType[hm]
							) .. " 前缀: "
						) .. table.concat(gR, ", ")
					) .. "，奖励："
				) .. table.concat(hp, ", ")
			) .. " special="
		) .. table.concat(hq, ", ")
	)
end
function L.prototype.GetExitTooltip(self, aa)
	if aa.roomType == RoomType.SPECIAL then
		if aa.specialKind == "WishingPool" then
			return "WishingPool"
		end
		if aa.specialKind == "RegenWell" then
			return "RegenWell"
		end
		if aa.specialKind == "Book" then
			return "Book"
		end
		if aa.specialKind == "Smithy" then
			return "Smithy"
		end
	end
	if
		aa.roomType == RoomType.SHOP
		or aa.roomType == RoomType.BOSS
		or aa.roomType == RoomType.STARTING
		or aa.roomType == RoomType.TAVERN
	then
		return RoomType[aa.roomType]
	end
	if aa.rewardType ~= RoomRewardType.NONE then
		return RoomRewardType[aa.rewardType]
	end
	return RoomType[aa.roomType]
end
function L.prototype.UpdateGateVisibility(self)
	local hd = self:FindEntities("prop_dynamic", "prop_wall")
	local ba = self:FindEntities("prop_dynamic", "prop_gate")
	local he = self:FindEntities("prop_dynamic", "prop_gate_decorate")
	local hv = d(p)
	hv:add(self.entrancePrefix)
	do
		local ab = 0
		while ab < #self.exitInfos do
			local aa = self.exitInfos[ab + 1]
			if aa ~= nil then
				hv:add(aa.prefix)
			end
			ab = ab + 1
		end
	end
	for a1, hf in ipairs(hd) do
		local bc = hf:GetName()
		local bd = g(bc, "_")[1]
		if hv:has(bd) then
			hf:AddEffects(EF_NODRAW)
		else
			hf:RemoveEffects(EF_NODRAW)
		end
	end
	for a1, bb in ipairs(ba) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if hv:has(bd) then
			bb:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bb)
		end
	end
	for a1, bb in ipairs(he) do
		local bc = bb:GetName()
		local bd = g(bc, "_")[1]
		if hv:has(bd) then
			bb:RemoveEffects(EF_NODRAW)
		else
			UTIL_Remove(bb)
		end
	end
end
function L.prototype.GetAvailablePositionIndices(self, hw, g9)
	local b7 = {}
	do
		local ab = 0
		while ab < #self.validGridPositions do
			if self.occupiedPositions[ab] ~= true then
				local hx = self.validGridPositions[ab + 1]
				if (hw == nil or hx.y >= hw) and (g9 == nil or hx.y <= g9) then
					b7[#b7 + 1] = ab
				end
			end
			ab = ab + 1
		end
	end
	return b7
end
function L.prototype.GetGridsAroundPosition(self, bv, fG, hy)
	if hy == nil then
		hy = 0
	end
	local dm = {}
	for a1, hz in ipairs(self:GetAvailablePositionIndices()) do
		do
			local R = self.validGridPositions[hz + 1]
			if R == nil then
				goto hA
			end
			local aR = CalcDistance(R, bv)
			if hy > 0 then
				if aR < fG + hy and aR > fG - hy then
					dm[#dm + 1] = R
				end
			else
				if aR < fG then
					dm[#dm + 1] = R
				end
			end
		end
		::hA::
	end
	return dm
end
function L.prototype.GetNearestValidGridPosition(self, hB)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local hC = nil
	local aO = math.huge
	do
		local ab = 0
		while ab < #self.validGridPositions do
			do
				local R = self.validGridPositions[ab + 1]
				if R == nil then
					goto hD
				end
				local aR = CalcDistance(R, hB)
				if aR < aO then
					aO = aR
					hC = R
				end
			end
			::hD::
			ab = ab + 1
		end
	end
	return hC
end
function L.prototype.IsPositionInside(self, R)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	local g7 = math.huge
	local g8 = -math.huge
	local hw = math.huge
	local g9 = -math.huge
	for a1, c0 in ipairs(self.validGridPositions) do
		if c0 ~= nil then
			g7 = math.min(g7, c0.x)
			g8 = math.max(g8, c0.x)
			hw = math.min(hw, c0.y)
			g9 = math.max(g9, c0.y)
		end
	end
	if g7 == math.huge then
		return false
	end
	local hE = GRID_SIZE * 0.5
	return R.x >= g7 - hE and R.x <= g8 + hE and R.y >= hw - hE and R.y <= g9 + hE
end
function L.prototype.GetRandomValidGridPosition(self)
	if #self.validGridPositions == 0 then
		self:AnalyzeGrid()
	end
	if #self.validGridPositions == 0 then
		return nil
	end
	return self.validGridPositions[RandomInt(0, #self.validGridPositions - 1) + 1]
end
function L.prototype.FindEntities(self, hF, hG)
	local hH = Entities:FindAllByClassname(hF)
	local b7 = {}
	for a1, h6 in ipairs(hH) do
		if h6:GetSpawnGroupHandle() == self.spawnGroup and o(h6:GetName(), hG) then
			b7[#b7 + 1] = h6
		end
	end
	return b7
end
function L.prototype.FindInfoTargets(self, hG)
	local hH = Entities:FindAllByClassname("info_target")
	local b7 = {}
	for a1, h6 in ipairs(hH) do
		if h6:GetSpawnGroupHandle() == self.spawnGroup and o(h6:GetName(), hG) then
			b7[#b7 + 1] = h6
		end
	end
	return b7
end
function L.prototype.FindInfoTarget(self, hG)
	local hH = Entities:FindAllByClassname("info_target")
	for a1, h6 in ipairs(hH) do
		if h6:GetSpawnGroupHandle() == self.spawnGroup and o(h6:GetName(), hG) then
			return h6
		end
	end
end
function L.prototype.RemoveUnit(self, a2)
	if IsValid(a2) then
		if BehaviorTree ~= nil then
			BehaviorTree:UnregisterUnit(a2)
		end
		if PropertySystem ~= nil then
			PropertySystem:CleanupUnitProperties(a2)
		end
		if StateSystem ~= nil then
			StateSystem:CleanupUnitStates(a2)
		end
		a2:RemoveAllModifiers(0, false, true, false)
		a2:ForceKill(false)
		a2:MakeIllusion()
		a2:AddNoDraw()
		a2:CallAbilityDestroy()
		UTIL_Remove(a2)
	end
end
function L.prototype.CreateClientItemPickupParticle(self, aL, aI)
	local hI =
		ParticleManager:CreateParticleForce("particles/generic_gameplay/drop_item_pick.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(hI, 0, aL)
	ParticleManager:SetParticleControlEnt(hI, 1, aI, PATTACH_POINT_FOLLOW, "attach_hitloc", aI:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(hI)
end
function L.prototype.DropItemFromEnemy(self, a2, hJ)
	local Z
	if self.guaranteedDrops ~= nil then
		for hK, hL in pairs(self.guaranteedDrops) do
			if hL > 0 then
				Z = hK
				self.guaranteedDrops[hK] = hL - 1
				if self.guaranteedDrops[hK] <= 0 then
					f(self.guaranteedDrops, hK)
				end
				break
			end
		end
	end
	local af = hJ:GetPlayerOwnerID()
	if Z == nil then
		if self.dropPool == nil then
			return
		end
		local hM = Privilege:GetPlayerDynamicValue("privilege_bless_009", af, "FirstDropCount") or 0
		if hM < 1 and not RollPercentage(self.dropPool.dropChance + GetBreakDropChance(hJ)) then
			return
		end
		Privilege:SetPlayerDynamicValue("privilege_bless_009", af, "FirstDropCount", hM - 1)
		Z = self.dropPool.itemPool:Random(nil)
	end
	if Z == nil then
		return
	end
	local aB = a2:GetAbsOrigin()
	local aS = d(A, Z, aB)
	local hN = self.dropItems
	hN[#hN + 1] = aS
	local aH = Interaction:RegisterInteract(aS.entity, InteractType.Chest, 200, function(a1, aI)
		aI:AddItemByName(Z)
		aS:dispose()
	end, nil, nil, Z)
	if aH ~= -1 then
		local hO = self.registeredInteracts
		hO[#hO + 1] = aH
	end
	Event:Fire("break_drop", { itemName = Z, drop_item = aS })
end
function L.prototype.CalculateDifficultyModifiers(self)
	local hP = GameRules:GetCustomGameDifficulty()
	local hQ = KeyValues.difficulty[tostring(hP)]
	if hQ == nil then
		print(("[DungeonRoom] 警告：难度配置 " .. tostring(hP)) .. " 未找到")
		self.difficultyHealthAmplify = 0
		self.difficultyDamageAmplify = 0
		return
	end
	local hR = toFiniteNumber(hQ.HealthFactor, 1)
	local hS = toFiniteNumber(hQ.DamageFactor, 1)
	local hT = DungeonManager:GetZoneIndex()
	if hT == 1 then
		hR = hR * toFiniteNumber(hQ.Chapter1HealthFactor, 1)
		hS = hS * toFiniteNumber(hQ.Chapter1DamageFactor, 1)
	elseif hT == 2 then
		hR = hR * toFiniteNumber(hQ.Chapter2HealthFactor, 1)
		hS = hS * toFiniteNumber(hQ.Chapter2DamageFactor, 1)
	elseif hT == 3 then
		hR = hR * toFiniteNumber(hQ.Chapter3HealthFactor, 1)
		hS = hS * toFiniteNumber(hQ.Chapter3DamageFactor, 1)
	end
	local hU = Game:GetPlayerCount()
	if hU == 2 then
		hR = hR * toFiniteNumber(hQ.Player2HealthFactor, 1)
		hS = hS * toFiniteNumber(hQ.Player2DamageFactor, 1)
	elseif hU == 3 then
		hR = hR * toFiniteNumber(hQ.Player3HealthFactor, 1)
		hS = hS * toFiniteNumber(hQ.Player3DamageFactor, 1)
	elseif hU >= 4 then
		hR = hR * toFiniteNumber(hQ.Player4HealthFactor, 1)
		hS = hS * toFiniteNumber(hQ.Player4DamageFactor, 1)
	end
	self.difficultyHealthAmplify = (hR - 1) * 100
	self.difficultyDamageAmplify = (hS - 1) * 100
	self.difficultyCooldownReduction = DIFFICULTY_COOLDOWN_REDUCTION[hP] or 0
	self.difficultyBossGapAmplify = DIFFICULTY_BOSS_GAP_AMPLIFY[hP] or 0
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
																	) .. tostring(hP)
																) .. " 玩家:"
															) .. tostring(hU)
														) .. " 血量:"
													) .. t(hR, 2)
												) .. "x("
											) .. t(self.difficultyHealthAmplify, 1)
										) .. "%) 伤害:"
									) .. t(hS, 2)
								) .. "x("
							) .. t(self.difficultyDamageAmplify, 1)
						) .. "%) 冷却缩减:"
					) .. tostring(self.difficultyCooldownReduction)
				) .. "% Boss间隔增幅:"
			) .. tostring(self.difficultyBossGapAmplify)
		) .. "%"
	)
end
function L.prototype.ApplyDifficultyModifiers(self, ax)
	local hR = self.spawnInfo.healthFactor or 1
	local hS = self.spawnInfo.damageFactor or 1
	local hV = DungeonManager:GetDifficultyKeyIntensity()
	local hW = 1 + hV * DIFFICULTY_KEY_HEALTH_FACTOR_PER_INTENSITY
	local hX = 1 + hV * DIFFICULTY_KEY_DAMAGE_FACTOR_PER_INTENSITY
	local hY = (1 + self.difficultyHealthAmplify / 100) * hR * hW
	local hZ = (1 + self.difficultyDamageAmplify / 100) * hS * hX
	local h_ = (hY - 1) * 100
	local i0 = (hZ - 1) * 100
	print("ApplyDifficultyModifiers", hR, hS)
	if h_ ~= 0 then
		ax:AddProperty(PropertyFunction.HEALTH_AMPLIFY, h_)
	end
	if i0 ~= 0 then
		ax:AddProperty(PropertyFunction.ATTACK_AMPLIFY, i0)
	end
	self:ApplyDifficultyKeyDebuffs(ax)
end
function L.prototype.ApplyDifficultyKeyDebuffs(self, ax)
	local i1 = DungeonManager:GetDifficultyKeyDebuffs()
	if #i1 <= 0 then
		return
	end
	do
		local ab = 0
		while ab < #i1 do
			local i2 = i1[ab + 1]
			ax:AddNewModifier(ax, nil, "modifier_" .. i2.debuff, { level = i2.level })
			ab = ab + 1
		end
	end
end
function L.prototype.DropPomReward(self, R)
	local Z = DrawPool:Draw("pom_reward")
	if Z ~= nil then
		local aS = d(A, Z, R)
		local i3 = self.dropItems
		i3[#i3 + 1] = aS
		local aH = Interaction:RegisterInteract(aS.entity, InteractType.Chest, 200, function(a1, aI)
			aI:AddItemByName(Z)
			aS:dispose()
		end)
		if aH ~= -1 then
			local i4 = self.registeredInteracts
			i4[#i4 + 1] = aH
		end
	end
end
function L.prototype.GetRoomKey(self)
	return (tostring(self.zoneID) .. "-") .. tostring(self.roomID)
end
function L.prototype.GetRoomType(self)
	return self.roomType
end
function L.prototype.GetRewardType(self)
	return self.rewardType
end
function L.prototype.GetPosition(self)
	return Vector(self.position.x, self.position.y, self.position.z)
end
function L.prototype.GetEntrancePosition(self)
	return self.entrancePos + CalcDirection2D(self.position, self.entrancePos):__mul(100)
end
function L.prototype.IsCombatRoom(self)
	return self.roomType == RoomType.ENEMY
		or self.roomType == RoomType.ELITE
		or self.roomType == RoomType.MINI_BOSS
		or self.roomType == RoomType.BOSS
end
function L.prototype.IsBossRoom(self)
	return self.roomType == RoomType.BOSS
end
function L.prototype.GetBossName(self)
	return self.bossName
end
function L.prototype.IsSpawnComplete(self)
	return self.isSpawnComplete
end
function L.prototype.AddGuaranteedDropCount(self, Z, i5)
	local i6 = self.guaranteedDrops[Z] or 0
	local i7 = i6 + i5
	if i7 <= 0 then
		f(self.guaranteedDrops, Z)
		print((("[DungeonRoom " .. tostring(self.roomID)) .. "] 移除必掉物品: ") .. Z)
	else
		self.guaranteedDrops[Z] = i7
		print(
			(
				(
					(((("[DungeonRoom " .. tostring(self.roomID)) .. "] 增加 ") .. Z) .. " 掉落次数: ")
					.. tostring(i6)
				) .. " -> "
			) .. tostring(i7)
		)
	end
end
function L.prototype.IsCompleted(self)
	return self.isComplete
end
function L.prototype.IsCombatEnd(self)
	return self:IsCombatRoom() and self.isCombatEnd
end
function L.prototype.ClearGuaranteedDropItems(self)
	self.guaranteedDrops = {}
end
function L.prototype.GetExitInfo(self)
	return self.exitInfos
end
function L.prototype.GetTrapList(self)
	return self.dungeonTrap:GetTrapList()
end
function L.prototype.GetNpcs(self)
	return self.npcs
end
function L.prototype.GetShopItems(self)
	return self.shopItems
end
function L.prototype.GetSpawnGroup(self)
	return self.spawnGroup
end
function L.prototype.OnEntityKilled(self, i8)
	local i9 = EntIndexToHScript(i8.entindex_killed)
	if not IsValid(i9) then
		return
	end
	if self.secretRoomGate ~= nil and i9 == self.secretRoomGate then
		self.secretRoomGate = nil
		ArrayRemove(self.enemies, i9)
		if self.secretRoomDoorPosition ~= nil and self.secretRoomDoorDirection ~= nil then
			self:CreateSecretRoom(self.secretRoomDoorPosition, self.secretRoomDoorDirection)
		end
		return
	end
	if m(self.enemies, i9) then
		local hJ = EntIndexToHScript(i8.entindex_attacker)
		if IsValid(hJ) and hJ:IsRealHero() then
			self.playerKilledEnemyCount = self.playerKilledEnemyCount + 1
		end
		self:DropPreviewRewardsFromEnemy(i9)
		ArrayRemove(self.enemies, i9)
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
				local R = GetGroundPosition(i9:GetAbsOrigin(), i9)
				if not GridNav:IsValidPosition(R) then
					R = self:GetNearestValidGridPosition(R) or R
				end
				self:FinishCombat(R)
			end
		end
	end
	if m(self.breakables, i9) then
		local hJ = EntIndexToHScript(i8.entindex_attacker)
		self:DropItemFromEnemy(i9, hJ)
		return
	end
end
return u