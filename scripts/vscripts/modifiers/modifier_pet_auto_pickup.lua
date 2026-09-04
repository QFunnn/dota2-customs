--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Delete = ____lualib.__TS__Delete
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ak_items_formula = require("json.ak_items_formula")
local ____pet_config = require("my_game_axe.pet.pet_config")
local GetDefaultPetAutoPickupSettings = ____pet_config.GetDefaultPetAutoPickupSettings
local MatchPetPickupBasicFilter = ____pet_config.MatchPetPickupBasicFilter
local PET_PICKUP_THINK_INTERVAL = 0.06
local PET_PICKUP_SCAN_INTERVAL = 0.4
local PET_PICKUP_ACTIVE_SCAN_INTERVAL = 1.4
local PET_PICKUP_INITIAL_SCAN_STAGGER_STEP = 0.025
local PET_PICKUP_INITIAL_SCAN_STAGGER_BUCKETS = 8
local PET_PICKUP_SEARCH_RADIUS = 1400
local PET_PICKUP_OWNER_LEASH = 1400
local PET_PICKUP_RANGE = 260
local PET_PICKUP_TELEPORT_RANGE = 1800
--- 跟随主人时超过此时间仍无法明显接近，则认为被地形或门卡住。
local PET_FOLLOW_STUCK_TELEPORT_SECONDS = 10
--- 跟随距离至少缩短这么多，才视为一次有效接近。
local PET_FOLLOW_STUCK_PROGRESS_DISTANCE = 80
local PET_FOLLOW_DISTANCE = 180
local PET_MOVE_ORDER_INTERVAL = 0.3
local PET_PICKUP_MAX_CANDIDATES = 32
local PET_PICKUP_VALUE_BAND_RATIO = 0.75
local PET_PICKUP_CLUSTER_RADIUS = 400
local PET_PICKUP_ROUTE_LIMIT = 5
local PET_PICKUP_ROUTE_VALUE_BAND_RATIO = 0.8
--- 路线优化时，高价值目标相对原价值优先路线允许延后的最大行进距离。
local PET_PICKUP_ROUTE_PRIORITY_MAX_DELAY = 80
local PET_PICKUP_OWNER_REPLAN_DISTANCE = 300
local PET_PICKUP_INTERRUPT_VALUE_MULTIPLIER = 2
local PET_PICKUP_INTERRUPT_PROTECTION_RANGE = PET_PICKUP_RANGE * 1.5
local PET_PICKUP_PROGRESS_TIMEOUT = 1.5
local PET_PICKUP_MIN_PROGRESS_DISTANCE = 48
local PET_PICKUP_TEMP_IGNORE_SECONDS = 2
local PET_PICKUP_SETTINGS_REFRESH_INTERVAL = 0.1
--- 成功拾取后的短暂动作间隔，避免同一区域多个物品同帧入包。
local PET_PICKUP_ACTION_DELAY = 0.06
--- 单帧最多连续处理一条完整短路线，避免堆叠掉落导致无界循环。
local PET_PICKUP_MAX_CHAIN_ACTIONS_PER_THINK = PET_PICKUP_ROUTE_LIMIT
--- 白名单物品使用虚拟价值加权，保证路线规划与打断判断都优先处理它们。
local PET_PICKUP_WHITELIST_VALUE_BONUS = 100000000
--- 玩家丢弃落地后，此时间内宠物自动拾取不处理该物品（与背包 `__drop_time` 配合）
local PET_IGNORE_DROPPED_ITEM_SECONDS = 2.5
--- 玩家刚手动丢弃物品后，短时间暂停所有宠物自动拾取，避免刚腾出的格子立刻被填满
local PET_IGNORE_AFTER_MANUAL_DROP_SECONDS = 2.5
--- 单人/附近无其他玩家时，新生成地面物的自动拾取保护时间。
local PET_FRESH_WORLD_DROP_PICKUP_DELAY = 0.4
--- 附近有其他玩家时，新生成地面物的自动拾取保护时间。
local PET_NEARBY_PLAYER_FRESH_WORLD_DROP_PICKUP_DELAY = 2.5
--- 判定“附近有其他玩家”并启用拾取延迟的距离。
local PET_NEARBY_PLAYER_PICKUP_DELAY_RANGE = 1500
local PET_PICKUP_SUCCESS_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_stonepulse.vpcf"
____exports.modifier_pet_auto_pickup = __TS__Class()
local modifier_pet_auto_pickup = ____exports.modifier_pet_auto_pickup
modifier_pet_auto_pickup.name = "modifier_pet_auto_pickup"
__TS__ClassExtends(modifier_pet_auto_pickup, BaseModifier_CS)
function modifier_pet_auto_pickup.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.currentTargetValue = 0
	self.currentTargetBestDistance = 0
	self.currentTargetProgressAt = 0
	self.pickupRoute = {}
	self.pickupRouteIndex = 0
	self.nextCandidateScanAt = 0
	self.immediateScanRequested = true
	self.ignoredItemUntil = {}
	self.nextMoveOrderAt = 0
	self.moveOrderKind = "none"
	self.moveOrderTargetEntIndex = -1
	self.nextPickupAllowedAt = 0
	self.followStuckStartedAt = 0
	self.followBestDistance = 0
	self.nextSettingsRefreshAt = 0
	self.observedDropGeneration = 0
end
function modifier_pet_auto_pickup.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local ____opt_0 = self:GetCaster()
	local ownerPlayerId = ____opt_0 and ____opt_0:GetPlayerId() or -1
	local ____temp_2
	if ownerPlayerId >= 0 then
		____temp_2 = ownerPlayerId
	else
		____temp_2 = self:GetParent():entindex()
	end
	local staggerSeed = ____temp_2
	local staggerBucket = staggerSeed % PET_PICKUP_INITIAL_SCAN_STAGGER_BUCKETS
	self.immediateScanRequested = false
	self.nextCandidateScanAt = GameRules:GetGameTime() + staggerBucket * PET_PICKUP_INITIAL_SCAN_STAGGER_STEP
	self.observedDropGeneration = self:GetOwnerDropGeneration(self:GetCaster())
	self:StartIntervalThink(PET_PICKUP_THINK_INTERVAL)
end
function modifier_pet_auto_pickup.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local pet = self:GetParent()
	local owner = self:GetCaster()
	if not IsValidAlive(nil, pet) or not owner or not IsValid(nil, owner) or owner:IsNull() then
		self:Destroy()
		return
	end
	if not IsValidAlive(nil, owner) then
		self:ClearPickupRoute(false)
		self:StopPetMovement(pet)
		return
	end
	local ownerPos = owner:GetAbsOrigin()
	local petPos = pet:GetAbsOrigin()
	if GetDistance(nil, ownerPos, petPos) > PET_PICKUP_TELEPORT_RANGE then
		FindClearSpaceForUnit(pet, ownerPos:__add(RandomVector(120)), true)
		self:StopPetMovement(pet)
		self:ClearPickupRoute(true)
		return
	end
	local settings = self:GetAutoPickupSettings(owner)
	if not settings.enabled then
		self:ClearPickupRoute(true)
		self:FollowOwner(pet, owner)
		return
	end
	if self:IsOwnerInManualDropCooldown(owner) then
		self:ClearPickupRoute(true)
		self:FollowOwner(pet, owner)
		return
	end
	local ____opt_3 = MyGamePlayers:getPlayer(owner:GetPlayerId())
	local knapsack = ____opt_3 and ____opt_3.knapsack
	if not knapsack then
		self:ClearPickupRoute(true)
		self:FollowOwner(pet, owner)
		return
	end
	self:RefreshDropGeneration(owner)
	do
		local actionIndex = 0
		while actionIndex < PET_PICKUP_MAX_CHAIN_ACTIONS_PER_THINK do
			do
				local targetItem = self:ResolveTargetItem(pet, owner, settings, knapsack)
				if not targetItem then
					if self.immediateScanRequested then
						goto __continue12
					end
					self:FollowOwner(pet, owner)
					return
				end
				if not self:MoveToPickupItem(pet, targetItem, knapsack) then
					return
				end
			end
			::__continue12::
			actionIndex = actionIndex + 1
		end
	end
end
function modifier_pet_auto_pickup.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNSELECTABLE] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_pet_auto_pickup.prototype.IsHidden(self)
	return true
end
function modifier_pet_auto_pickup.prototype.IsPurgable(self)
	return false
end
function modifier_pet_auto_pickup.prototype.RemoveOnDeath(self)
	return true
end
function modifier_pet_auto_pickup.prototype.ResolveTargetItem(self, pet, owner, settings, knapsack)
	local now = GameRules:GetGameTime()
	local ownerPos = owner:GetAbsOrigin()
	if
		self.routeOwnerOrigin
		and GetDistance(nil, ownerPos, self.routeOwnerOrigin) > PET_PICKUP_OWNER_REPLAN_DISTANCE
	then
		self:ClearPickupRoute(true)
	end
	if self.currentTargetItem and not self:IsCurrentTargetLightValid(self.currentTargetItem, owner, settings) then
		self:CompleteCurrentTarget()
	end
	local scannedCandidates
	if self.immediateScanRequested or now >= self.nextCandidateScanAt then
		scannedCandidates = self:ScanPickupCandidates(pet, owner, settings, knapsack, now)
		self.immediateScanRequested = false
		if self.currentTargetItem then
			if self:ShouldInterruptCurrentTarget(scannedCandidates, pet) then
				self:SetPickupRoute(self:BuildPickupRoute(scannedCandidates, pet:GetAbsOrigin(), ownerPos), ownerPos)
			end
		elseif self.pickupRouteIndex >= #self.pickupRoute then
			self:SetPickupRoute(self:BuildPickupRoute(scannedCandidates, pet:GetAbsOrigin(), ownerPos), ownerPos)
		end
		local hasPickupWork = not not self.currentTargetItem or self.pickupRouteIndex < #self.pickupRoute
		self.nextCandidateScanAt = now + (hasPickupWork and PET_PICKUP_ACTIVE_SCAN_INTERVAL or PET_PICKUP_SCAN_INTERVAL)
	end
	if self.currentTargetItem then
		return self.currentTargetItem
	end
	if self.pickupRouteIndex >= #self.pickupRoute then
		return nil
	end
	return self:ActivateRouteTarget(pet, owner, settings, knapsack, now)
end
function modifier_pet_auto_pickup.prototype.ScanPickupCandidates(self, pet, owner, settings, knapsack, now)
	self:PruneIgnoredItems(now)
	local candidates = {}
	local petPos = pet:GetAbsOrigin()
	local ownerPos = owner:GetAbsOrigin()
	local dropEntities = Entities:FindAllByClassnameWithin("dota_item_drop", petPos, PET_PICKUP_SEARCH_RADIUS)
	for ____, dropEntity in ipairs(dropEntities) do
		do
			if not dropEntity or not IsValid(nil, dropEntity) or dropEntity:IsNull() then
				goto __continue30
			end
			local item = dropEntity:GetContainedItem()
			if not item or self:IsTemporarilyIgnored(item, now) then
				goto __continue30
			end
			if not self:IsItemValidForOwner(item, owner, settings, knapsack) then
				goto __continue30
			end
			local dropPos = dropEntity:GetAbsOrigin()
			if GetDistance(nil, ownerPos, dropPos) > PET_PICKUP_OWNER_LEASH then
				goto __continue30
			end
			self:AddCandidateWithinLimit(candidates, {
				item = item,
				position = Vector(dropPos.x, dropPos.y, dropPos.z),
				value = self:GetPickupCandidateValue(item, settings, knapsack),
			})
		end
		::__continue30::
	end
	return candidates
end
function modifier_pet_auto_pickup.prototype.AddCandidateWithinLimit(self, candidates, candidate)
	if #candidates < PET_PICKUP_MAX_CANDIDATES then
		candidates[#candidates + 1] = candidate
		return
	end
	local lowestIndex = 0
	do
		local i = 1
		while i < #candidates do
			if candidates[i + 1].value < candidates[lowestIndex + 1].value then
				lowestIndex = i
			end
			i = i + 1
		end
	end
	if candidate.value > candidates[lowestIndex + 1].value then
		candidates[lowestIndex + 1] = candidate
	end
end
function modifier_pet_auto_pickup.prototype.BuildPickupRoute(self, candidates, petPos, ownerPos)
	if #candidates <= 0 then
		return {}
	end
	local highestValue = 0
	for ____, candidate in ipairs(candidates) do
		if candidate.value > highestValue then
			highestValue = candidate.value
		end
	end
	local ____temp_5
	if highestValue > 0 then
		____temp_5 = highestValue * PET_PICKUP_VALUE_BAND_RATIO
	else
		____temp_5 = 0
	end
	local valueThreshold = ____temp_5
	local bandCandidates = {}
	for ____, candidate in ipairs(candidates) do
		if candidate.value >= valueThreshold then
			bandCandidates[#bandCandidates + 1] = candidate
		end
	end
	local assigned = {}
	do
		local i = 0
		while i < #bandCandidates do
			assigned[i + 1] = false
			i = i + 1
		end
	end
	local bestCluster = {}
	local bestClusterScore = -1
	do
		local i = 0
		while i < #bandCandidates do
			do
				if assigned[i + 1] then
					goto __continue50
				end
				assigned[i + 1] = true
				local clusterIndexes = { i }
				do
					local cursor = 0
					while cursor < #clusterIndexes do
						local currentIndex = clusterIndexes[cursor + 1]
						do
							local j = 0
							while j < #bandCandidates do
								do
									if assigned[j + 1] then
										goto __continue53
									end
									if
										GetDistance(
											nil,
											bandCandidates[currentIndex + 1].position,
											bandCandidates[j + 1].position
										) > PET_PICKUP_CLUSTER_RADIUS
									then
										goto __continue53
									end
									assigned[j + 1] = true
									clusterIndexes[#clusterIndexes + 1] = j
								end
								::__continue53::
								j = j + 1
							end
						end
						cursor = cursor + 1
					end
				end
				local cluster = {}
				for ____, index in ipairs(clusterIndexes) do
					cluster[#cluster + 1] = bandCandidates[index + 1]
				end
				local score = self:GetPickupClusterScore(cluster, petPos, ownerPos)
				if score > bestClusterScore then
					bestCluster = cluster
					bestClusterScore = score
				end
			end
			::__continue50::
			i = i + 1
		end
	end
	return self:BuildRouteWithinCluster(bestCluster, petPos)
end
function modifier_pet_auto_pickup.prototype.GetPickupClusterScore(self, cluster, petPos, ownerPos)
	local totalValue = 0
	local sumX = 0
	local sumY = 0
	local sumZ = 0
	local entryDistance = -1
	for ____, candidate in ipairs(cluster) do
		totalValue = totalValue + candidate.value
		sumX = sumX + candidate.position.x
		sumY = sumY + candidate.position.y
		sumZ = sumZ + candidate.position.z
		local distance = GetDistance(nil, petPos, candidate.position)
		if entryDistance < 0 or distance < entryDistance then
			entryDistance = distance
		end
	end
	local center = Vector(sumX / #cluster, sumY / #cluster, sumZ / #cluster)
	local dispersion = 0
	for ____, candidate in ipairs(cluster) do
		dispersion = dispersion + GetDistance(nil, center, candidate.position)
	end
	dispersion = dispersion / #cluster
	local returnDistance = GetDistance(nil, center, ownerPos)
	return totalValue / (300 + math.max(0, entryDistance) + dispersion + returnDistance * 0.5)
end
function modifier_pet_auto_pickup.prototype.BuildRouteWithinCluster(self, cluster, startPos)
	local priorityRoute = {}
	local remaining = __TS__ArraySlice(cluster)
	local currentPos = startPos
	while #remaining > 0 and #priorityRoute < PET_PICKUP_ROUTE_LIMIT do
		local highestRemainingValue = 0
		for ____, candidate in ipairs(remaining) do
			if candidate.value > highestRemainingValue then
				highestRemainingValue = candidate.value
			end
		end
		local ____temp_6
		if highestRemainingValue > 0 then
			____temp_6 = highestRemainingValue * PET_PICKUP_ROUTE_VALUE_BAND_RATIO
		else
			____temp_6 = 0
		end
		local valueThreshold = ____temp_6
		local selectedIndex = -1
		local selectedDistance = 0
		do
			local i = 0
			while i < #remaining do
				do
					local candidate = remaining[i + 1]
					if candidate.value < valueThreshold then
						goto __continue70
					end
					local distance = GetDistance(nil, currentPos, candidate.position)
					if selectedIndex < 0 or distance < selectedDistance then
						selectedIndex = i
						selectedDistance = distance
					end
				end
				::__continue70::
				i = i + 1
			end
		end
		if selectedIndex < 0 then
			break
		end
		local selected = remaining[selectedIndex + 1]
		priorityRoute[#priorityRoute + 1] = selected
		currentPos = selected.position
		__TS__ArraySplice(remaining, selectedIndex, 1)
	end
	return self:OptimizePickupRoute(priorityRoute, startPos)
end
function modifier_pet_auto_pickup.prototype.OptimizePickupRoute(self, priorityRoute, startPos)
	if #priorityRoute <= 1 then
		return __TS__ArrayMap(priorityRoute, function(____, candidate)
			return candidate.item
		end)
	end
	local highestValue = 0
	for ____, candidate in ipairs(priorityRoute) do
		if candidate.value > highestValue then
			highestValue = candidate.value
		end
	end
	local protectedValueThreshold = highestValue * PET_PICKUP_ROUTE_VALUE_BAND_RATIO
	local protectedArrivalLimits = {}
	local baselineArrivalDistance = 0
	local baselinePosition = startPos
	for ____, candidate in ipairs(priorityRoute) do
		baselineArrivalDistance = baselineArrivalDistance + GetDistance(nil, baselinePosition, candidate.position)
		baselinePosition = candidate.position
		if candidate.value >= protectedValueThreshold then
			protectedArrivalLimits[tostring(candidate.item:entindex())] = baselineArrivalDistance
				+ PET_PICKUP_ROUTE_PRIORITY_MAX_DELAY
		end
	end
	local searchState = {
		bestRoute = __TS__ArraySlice(priorityRoute),
		bestDistance = self:GetPickupRouteDistance(priorityRoute, startPos),
	}
	local used = {}
	do
		local i = 0
		while i < #priorityRoute do
			used[i + 1] = false
			i = i + 1
		end
	end
	self:SearchPickupRoute(priorityRoute, protectedArrivalLimits, used, {}, startPos, 0, searchState)
	return __TS__ArrayMap(searchState.bestRoute, function(____, candidate)
		return candidate.item
	end)
end
function modifier_pet_auto_pickup.prototype.SearchPickupRoute(
	self,
	candidates,
	protectedArrivalLimits,
	used,
	currentRoute,
	currentPos,
	currentDistance,
	searchState
)
	if #currentRoute >= #candidates then
		if currentDistance < searchState.bestDistance then
			searchState.bestDistance = currentDistance
			searchState.bestRoute = __TS__ArraySlice(currentRoute)
		end
		return
	end
	do
		local i = 0
		while i < #candidates do
			do
				if used[i + 1] then
					goto __continue88
				end
				local candidate = candidates[i + 1]
				local nextDistance = currentDistance + GetDistance(nil, currentPos, candidate.position)
				if nextDistance >= searchState.bestDistance then
					goto __continue88
				end
				local arrivalLimit = protectedArrivalLimits[tostring(candidate.item:entindex())]
				if arrivalLimit ~= nil and nextDistance > arrivalLimit then
					goto __continue88
				end
				used[i + 1] = true
				currentRoute[#currentRoute + 1] = candidate
				self:SearchPickupRoute(
					candidates,
					protectedArrivalLimits,
					used,
					currentRoute,
					candidate.position,
					nextDistance,
					searchState
				)
				table.remove(currentRoute)
				used[i + 1] = false
			end
			::__continue88::
			i = i + 1
		end
	end
end
function modifier_pet_auto_pickup.prototype.GetPickupRouteDistance(self, route, startPos)
	local distance = 0
	local currentPos = startPos
	for ____, candidate in ipairs(route) do
		distance = distance + GetDistance(nil, currentPos, candidate.position)
		currentPos = candidate.position
	end
	return distance
end
function modifier_pet_auto_pickup.prototype.ShouldInterruptCurrentTarget(self, candidates, pet)
	local currentItem = self.currentTargetItem
	local currentContainer = currentItem and currentItem:GetContainer()
	if not currentItem or not currentContainer or not IsValid(nil, currentContainer) or currentContainer:IsNull() then
		return false
	end
	if
		GetDistance(nil, pet:GetAbsOrigin(), currentContainer:GetAbsOrigin()) <= PET_PICKUP_INTERRUPT_PROTECTION_RANGE
	then
		return false
	end
	local highestOtherValue = -1
	for ____, candidate in ipairs(candidates) do
		do
			if candidate.item == currentItem then
				goto __continue98
			end
			if candidate.value > highestOtherValue then
				highestOtherValue = candidate.value
			end
		end
		::__continue98::
	end
	if highestOtherValue < 0 then
		return false
	end
	if self.currentTargetValue <= 0 then
		return highestOtherValue > 0
	end
	return highestOtherValue >= self.currentTargetValue * PET_PICKUP_INTERRUPT_VALUE_MULTIPLIER
end
function modifier_pet_auto_pickup.prototype.ActivateRouteTarget(self, pet, owner, settings, knapsack, now)
	while self.pickupRouteIndex < #self.pickupRoute do
		do
			local item = self.pickupRoute[self.pickupRouteIndex + 1]
			if not self:IsCurrentTargetValid(item, owner, settings, knapsack) then
				self:CompleteCurrentTarget()
				goto __continue105
			end
			local container = item:GetContainer()
			if not container or not IsValid(nil, container) or container:IsNull() then
				self:CompleteCurrentTarget()
				goto __continue105
			end
			local distance = GetDistance(nil, pet:GetAbsOrigin(), container:GetAbsOrigin())
			if
				distance > PET_PICKUP_RANGE
				and not GridNav:CanFindPath(pet:GetAbsOrigin(), container:GetAbsOrigin())
			then
				self:IgnoreItemTemporarily(item, now)
				self:CompleteCurrentTarget()
				goto __continue105
			end
			self.currentTargetItem = item
			self.currentTargetValue = self:GetPickupCandidateValue(item, settings, knapsack)
			self.currentTargetBestDistance = distance
			self.currentTargetProgressAt = now
			return item
		end
		::__continue105::
	end
	return nil
end
function modifier_pet_auto_pickup.prototype.IsCurrentTargetLightValid(self, item, owner, settings)
	if not self:IsItemLightValidForOwner(item, owner, settings) then
		return false
	end
	local container = item:GetContainer()
	return not not container
		and GetDistance(nil, owner:GetAbsOrigin(), container:GetAbsOrigin())
			<= PET_PICKUP_OWNER_LEASH
end
function modifier_pet_auto_pickup.prototype.IsCurrentTargetValid(self, item, owner, settings, knapsack)
	if not self:IsItemLightValidForOwner(item, owner, settings) then
		return false
	end
	if not knapsack:CanAutoPickupDroppedItem(item) then
		return false
	end
	local container = item:GetContainer()
	return not not container
		and GetDistance(nil, owner:GetAbsOrigin(), container:GetAbsOrigin())
			<= PET_PICKUP_OWNER_LEASH
end
function modifier_pet_auto_pickup.prototype.IsItemValidForOwner(self, item, owner, settings, knapsack)
	if not self:IsItemLightValidForOwner(item, owner, settings) then
		return false
	end
	return knapsack:CanAutoPickupDroppedItem(item)
end
function modifier_pet_auto_pickup.prototype.IsItemLightValidForOwner(self, item, owner, settings)
	if not item or not IsValid(nil, item) or item:IsNull() then
		return false
	end
	if item.CanOnlyPlayerHeroPickup and item:CanOnlyPlayerHeroPickup() then
		return false
	end
	if (tonumber(item:GetItemKeyValues("ItemCastOnPickup")) or 0) == 1 then
		return false
	end
	local container = item:GetContainer()
	if not container or not IsValid(nil, container) or container:IsNull() then
		return false
	end
	if not self:IsWorldDropReadyForPickup(item, container, GameRules:GetGameTime()) then
		return false
	end
	local bindPlayerId = item._player_id
	if bindPlayerId ~= nil and bindPlayerId ~= owner:GetPlayerId() then
		return false
	end
	local manualDropPlayerId = item.__manual_drop_by_player_id
	if manualDropPlayerId ~= nil then
		return false
	end
	local dropTime = item.__drop_time
	if dropTime ~= nil and GameRules:GetGameTime() < dropTime + PET_IGNORE_DROPPED_ITEM_SECONDS then
		return false
	end
	local itemName = item:GetName()
	if settings.pickupListUnlocked then
		if __TS__ArrayIncludes(settings.blacklist, itemName) then
			return false
		end
		if __TS__ArrayIncludes(settings.whitelist, itemName) then
			return true
		end
	end
	if settings.basicFilterUnlocked and not self:MatchPickupFilter(item, settings) then
		return false
	end
	if settings.advancedUnlocked and not self:MatchPickupTypeFilter(item, settings) then
		return false
	end
	return true
end
function modifier_pet_auto_pickup.prototype.GetPickupCandidateValue(self, item, settings, knapsack)
	local baseValue = math.max(0, knapsack:getItemValue(item))
	local ____temp_9
	if settings.pickupListUnlocked and __TS__ArrayIncludes(settings.whitelist, item:GetName()) then
		____temp_9 = baseValue + PET_PICKUP_WHITELIST_VALUE_BONUS
	else
		____temp_9 = baseValue
	end
	return ____temp_9
end
function modifier_pet_auto_pickup.prototype.IsOwnerInManualDropCooldown(self, owner)
	local dropTime = owner.__last_manual_item_drop_time
	return dropTime ~= nil and GameRules:GetGameTime() < dropTime + PET_IGNORE_AFTER_MANUAL_DROP_SECONDS
end
function modifier_pet_auto_pickup.prototype.MatchPickupFilter(self, item, settings)
	local itemName = item:GetName()
	local rulesetEquipment = MyGameRulesetManager and MyGameRulesetManager:GetEquipmentConfig(itemName)
	local kv = rulesetEquipment or GetAbilityKeyValuesByName(itemName) or {}
	local ____tonumber_14 = tonumber
	local ____kv_Level_12 = kv.Level
	if ____kv_Level_12 == nil then
		____kv_Level_12 = kv.ItemLevel
	end
	local ____kv_Level_12_13 = ____kv_Level_12
	if ____kv_Level_12_13 == nil then
		____kv_Level_12_13 = 0
	end
	local rawLevel = ____tonumber_14(____kv_Level_12_13)
	local ____temp_15
	if __TS__NumberIsFinite(__TS__Number(rawLevel)) and rawLevel > 0 then
		____temp_15 = math.floor(rawLevel)
	else
		____temp_15 = 1
	end
	local level = ____temp_15
	local ____tonumber_17 = tonumber
	local ____kv_ItemQuality_16 = kv.ItemQuality
	if ____kv_ItemQuality_16 == nil then
		____kv_ItemQuality_16 = 0
	end
	local rawQuality = ____tonumber_17(____kv_ItemQuality_16)
	local ____temp_18
	if __TS__NumberIsFinite(__TS__Number(rawQuality)) and rawQuality > 0 then
		____temp_18 = math.floor(rawQuality)
	else
		____temp_18 = 1
	end
	local quality = ____temp_18
	return MatchPetPickupBasicFilter(nil, level, quality, settings)
end
function modifier_pet_auto_pickup.prototype.MatchPickupTypeFilter(self, item, settings)
	local itemType = self:GetPickupType(item)
	return __TS__ArrayIncludes(settings.types, itemType)
end
function modifier_pet_auto_pickup.prototype.GetPickupType(self, item)
	local itemName = item:GetName()
	local formulaData = MyGameRulesetManager and MyGameRulesetManager:GetFormulaConfig(itemName)
		or ak_items_formula[itemName]
	if formulaData then
		return "blueprint"
	end
	local kv = GetAbilityKeyValuesByName(itemName) or {}
	local ____tostring_24 = tostring
	local ____kv_itemType_21 = kv.itemType
	if ____kv_itemType_21 == nil then
		____kv_itemType_21 = kv.ItemType
	end
	local ____kv_itemType_21_22 = ____kv_itemType_21
	if ____kv_itemType_21_22 == nil then
		____kv_itemType_21_22 = item:GetItemKeyValues("itemType")
	end
	local ____kv_itemType_21_22_23 = ____kv_itemType_21_22
	if ____kv_itemType_21_22_23 == nil then
		____kv_itemType_21_22_23 = ""
	end
	local rawItemType = ____tostring_24(____kv_itemType_21_22_23)
	if rawItemType == "material" then
		return "material"
	end
	if rawItemType == "equip" then
		return "equip"
	end
	if rawItemType == "gem" then
		return "gem"
	end
	if rawItemType == "blueprint" then
		return "blueprint"
	end
	if rawItemType == "potion" then
		return "potion"
	end
	return "other"
end
function modifier_pet_auto_pickup.prototype.GetAutoPickupSettings(self, owner)
	local now = GameRules:GetGameTime()
	if self.cachedAutoPickupSettings and now < self.nextSettingsRefreshAt then
		return self.cachedAutoPickupSettings
	end
	local playerId = owner:GetPlayerId()
	local ____temp_25
	if playerId ~= nil and playerId >= 0 then
		____temp_25 = MyGamePlayers:getPlayer(playerId)
	else
		____temp_25 = nil
	end
	local player = ____temp_25
	local petManager = player and player.petManager
	if petManager and petManager.GetAutoPickupSettings then
		self.cachedAutoPickupSettings = petManager:GetAutoPickupSettings()
		self.nextSettingsRefreshAt = now + PET_PICKUP_SETTINGS_REFRESH_INTERVAL
		return self.cachedAutoPickupSettings
	end
	self.cachedAutoPickupSettings = __TS__ObjectAssign(
		{},
		GetDefaultPetAutoPickupSettings(nil),
		{ basicFilterUnlocked = false, advancedUnlocked = false, pickupListUnlocked = false }
	)
	self.nextSettingsRefreshAt = now + PET_PICKUP_SETTINGS_REFRESH_INTERVAL
	return self.cachedAutoPickupSettings
end
function modifier_pet_auto_pickup.prototype.MoveToPickupItem(self, pet, item, knapsack)
	self:ResetFollowStuckTracking()
	local container = item:GetContainer()
	if not container or not IsValid(nil, container) or container:IsNull() then
		self:CompleteCurrentTarget()
		return true
	end
	local targetPos = container:GetAbsOrigin()
	local now = GameRules:GetGameTime()
	local distance = GetDistance(nil, pet:GetAbsOrigin(), targetPos)
	if distance <= PET_PICKUP_RANGE then
		if not self:IsWorldDropReadyForPickup(item, container, now) then
			self:StopPetMovement(pet)
			return false
		end
		if now < self.nextPickupAllowedAt then
			self:StopPetMovement(pet)
			return false
		end
		if not knapsack:CanAutoPickupDroppedItem(item) then
			self:IgnoreItemTemporarily(item, now)
			self:CompleteCurrentTarget()
			return true
		end
		local pickupResult = knapsack:TryPickupDroppedItem(item)
		if not pickupResult.success then
			self:IgnoreItemTemporarily(item, now)
			self:CompleteCurrentTarget()
			return true
		end
		self:PlayPickupSuccessEffect(targetPos)
		self.nextPickupAllowedAt = now + PET_PICKUP_ACTION_DELAY
		self:CompleteCurrentTarget()
		return false
	end
	if distance <= self.currentTargetBestDistance - PET_PICKUP_MIN_PROGRESS_DISTANCE then
		self.currentTargetBestDistance = distance
		self.currentTargetProgressAt = now
	elseif now >= self.currentTargetProgressAt + PET_PICKUP_PROGRESS_TIMEOUT then
		self:IgnoreItemTemporarily(item, now)
		self:CompleteCurrentTarget()
		return true
	end
	local targetEntIndex = item:entindex()
	local isNewMoveTarget = self.moveOrderKind ~= "pickup" or self.moveOrderTargetEntIndex ~= targetEntIndex
	if isNewMoveTarget or now >= self.nextMoveOrderAt then
		self.nextMoveOrderAt = now + PET_MOVE_ORDER_INTERVAL
		self.moveOrderKind = "pickup"
		self.moveOrderTargetEntIndex = targetEntIndex
		pet:MoveToPosition(targetPos)
	end
	return false
end
function modifier_pet_auto_pickup.prototype.PlayPickupSuccessEffect(self, position)
	local particle = ParticleManager:CreateParticle(PET_PICKUP_SUCCESS_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, position)
	ParticleManager:ReleaseParticleIndex(particle)
end
function modifier_pet_auto_pickup.prototype.IsWorldDropReadyForPickup(self, item, container, now)
	local pickupDelay = self:HasNearbyOtherPlayer() and PET_NEARBY_PLAYER_FRESH_WORLD_DROP_PICKUP_DELAY
		or PET_FRESH_WORLD_DROP_PICKUP_DELAY
	local autoPickupReadyAt = item.__pet_auto_pickup_ready_at__
	if autoPickupReadyAt ~= nil and now < autoPickupReadyAt then
		return false
	end
	local worldDropTime = container.LastTime
	if worldDropTime ~= nil and now < worldDropTime + pickupDelay then
		return false
	end
	local dropTime = item.__drop_time
	return dropTime == nil or now >= dropTime + pickupDelay
end
function modifier_pet_auto_pickup.prototype.HasNearbyOtherPlayer(self)
	local owner = self:GetCaster()
	if not owner or not IsValid(nil, owner) or owner:IsNull() then
		return false
	end
	local selfPlayerId = owner:GetPlayerId()
	local origin = owner:GetAbsOrigin()
	local playerCount = PlayerResource:GetPlayerCount()
	do
		local playerId = 0
		while playerId < playerCount do
			do
				if playerId == selfPlayerId then
					goto __continue160
				end
				local ____opt_30 = MyGamePlayers:getPlayer(playerId)
				local hero = ____opt_30 and ____opt_30:GetHero()
				if not hero or not IsValidAlive(nil, hero) then
					goto __continue160
				end
				if GetDistance(nil, origin, hero:GetAbsOrigin()) <= PET_NEARBY_PLAYER_PICKUP_DELAY_RANGE then
					return true
				end
			end
			::__continue160::
			playerId = playerId + 1
		end
	end
	return false
end
function modifier_pet_auto_pickup.prototype.RefreshDropGeneration(self, owner)
	local generation = self:GetOwnerDropGeneration(owner)
	if generation == self.observedDropGeneration then
		return
	end
	self.observedDropGeneration = generation
	self.immediateScanRequested = true
end
function modifier_pet_auto_pickup.prototype.GetOwnerDropGeneration(self, owner)
	if not owner then
		return 0
	end
	return owner.__pet_auto_pickup_drop_generation or 0
end
function modifier_pet_auto_pickup.prototype.CompleteCurrentTarget(self)
	self.currentTargetItem = nil
	self.currentTargetValue = 0
	self.currentTargetBestDistance = 0
	self.currentTargetProgressAt = 0
	self.pickupRouteIndex = self.pickupRouteIndex + 1
	if self.pickupRouteIndex >= #self.pickupRoute then
		self.pickupRoute = {}
		self.pickupRouteIndex = 0
		self.routeOwnerOrigin = nil
		self.immediateScanRequested = true
	end
end
function modifier_pet_auto_pickup.prototype.SetPickupRoute(self, route, ownerPos)
	self.pickupRoute = route
	self.pickupRouteIndex = 0
	self.currentTargetItem = nil
	self.currentTargetValue = 0
	self.currentTargetBestDistance = 0
	self.currentTargetProgressAt = 0
	local ____temp_32
	if #route > 0 then
		____temp_32 = Vector(ownerPos.x, ownerPos.y, ownerPos.z)
	else
		____temp_32 = nil
	end
	self.routeOwnerOrigin = ____temp_32
	self.immediateScanRequested = false
end
function modifier_pet_auto_pickup.prototype.ClearPickupRoute(self, requestImmediateScan)
	self.pickupRoute = {}
	self.pickupRouteIndex = 0
	self.currentTargetItem = nil
	self.currentTargetValue = 0
	self.currentTargetBestDistance = 0
	self.currentTargetProgressAt = 0
	self.routeOwnerOrigin = nil
	if requestImmediateScan then
		self.immediateScanRequested = true
	end
end
function modifier_pet_auto_pickup.prototype.IgnoreItemTemporarily(self, item, now)
	if not item or not IsValid(nil, item) then
		return
	end
	self.ignoredItemUntil[tostring(item:entindex())] = now + PET_PICKUP_TEMP_IGNORE_SECONDS
end
function modifier_pet_auto_pickup.prototype.IsTemporarilyIgnored(self, item, now)
	local key = tostring(item:entindex())
	local ignoredUntil = self.ignoredItemUntil[key]
	if ignoredUntil == nil then
		return false
	end
	if now < ignoredUntil then
		return true
	end
	__TS__Delete(self.ignoredItemUntil, key)
	return false
end
function modifier_pet_auto_pickup.prototype.PruneIgnoredItems(self, now)
	for ____, key in ipairs(__TS__ObjectKeys(self.ignoredItemUntil)) do
		if now >= self.ignoredItemUntil[key] then
			__TS__Delete(self.ignoredItemUntil, key)
		end
	end
end
function modifier_pet_auto_pickup.prototype.FollowOwner(self, pet, owner)
	local ownerPos = owner:GetAbsOrigin()
	local distance = GetDistance(nil, pet:GetAbsOrigin(), ownerPos)
	if distance <= PET_FOLLOW_DISTANCE then
		self:StopPetMovement(pet)
		return
	end
	local now = GameRules:GetGameTime()
	if self:ShouldTeleportStuckFollow(now, distance) then
		self:TeleportPetNearOwner(pet, ownerPos)
		return
	end
	local isNewMoveTarget = self.moveOrderKind ~= "follow"
	if not isNewMoveTarget and now < self.nextMoveOrderAt then
		return
	end
	self.nextMoveOrderAt = now + PET_MOVE_ORDER_INTERVAL
	self.moveOrderKind = "follow"
	self.moveOrderTargetEntIndex = -1
	pet:MoveToPosition(ownerPos:__add(RandomVector(90)))
end
function modifier_pet_auto_pickup.prototype.ShouldTeleportStuckFollow(self, now, distance)
	if self.moveOrderKind ~= "follow" or self.followStuckStartedAt <= 0 then
		self.followStuckStartedAt = now
		self.followBestDistance = distance
		return false
	end
	if distance <= self.followBestDistance - PET_FOLLOW_STUCK_PROGRESS_DISTANCE then
		self.followStuckStartedAt = now
		self.followBestDistance = distance
		return false
	end
	if distance < self.followBestDistance then
		self.followBestDistance = distance
	end
	return now >= self.followStuckStartedAt + PET_FOLLOW_STUCK_TELEPORT_SECONDS
end
function modifier_pet_auto_pickup.prototype.TeleportPetNearOwner(self, pet, ownerPos)
	FindClearSpaceForUnit(pet, ownerPos:__add(RandomVector(120)), true)
	self:StopPetMovement(pet)
end
function modifier_pet_auto_pickup.prototype.ResetFollowStuckTracking(self)
	self.followStuckStartedAt = 0
	self.followBestDistance = 0
end
function modifier_pet_auto_pickup.prototype.StopPetMovement(self, pet)
	self:ResetFollowStuckTracking()
	if self.moveOrderKind == "none" then
		return
	end
	pet:Stop()
	self.moveOrderKind = "none"
	self.moveOrderTargetEntIndex = -1
	self.nextMoveOrderAt = 0
end
modifier_pet_auto_pickup = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pet_auto_pickup)
____exports.modifier_pet_auto_pickup = modifier_pet_auto_pickup
return ____exports