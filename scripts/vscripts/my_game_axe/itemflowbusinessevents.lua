--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.FireShopItemBought(self, playerId, itemId, count, destination, price)
	MyGameEvent:FireEventToPlayer(playerId, "shop_item_bought", {
		playerId = playerId,
		itemId = itemId,
		count = count,
		destination = destination,
		price = price,
	}, true)
end
function ____exports.FireAncientShopItemBought(self, playerId, itemId, count, destination, price)
	MyGameEvent:FireEventToPlayer(playerId, "ancient_shop_item_bought", {
		playerId = playerId,
		itemId = itemId,
		count = count,
		destination = destination,
		price = price,
	}, true)
end
function ____exports.FireShopItemSold(self, playerId, itemId, count, gold)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"shop_item_sold",
		{ playerId = playerId, itemId = itemId, count = count, gold = gold },
		true
	)
end
function ____exports.FireAncientShopItemSold(self, playerId, itemId, count, gold)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"ancient_shop_item_sold",
		{ playerId = playerId, itemId = itemId, count = count, gold = gold },
		true
	)
end
function ____exports.FireKnapsackQuickSellCompleted(self, playerId, soldItems, totalGold)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"knapsack_quick_sell_completed",
		{ playerId = playerId, soldItems = soldItems, totalGold = totalGold },
		true
	)
end
function ____exports.FireShopMallGoodsBought(self, playerId, goodsId, count, cost)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"shop_mall_goods_bought",
		{ playerId = playerId, goodsId = goodsId, count = count, cost = cost },
		true
	)
end
function ____exports.FireShopMallRewardGranted(self, playerId, items, goodsId)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"shop_mall_reward_granted",
		{ playerId = playerId, goodsId = goodsId, items = items },
		true
	)
end
function ____exports.FireTreasureRewardGranted(self, playerId, item, treasureType)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"treasure_reward_granted",
		{ playerId = playerId, treasureType = treasureType, item = item },
		true
	)
end
function ____exports.FireTreasureFragmentShopItemBought(self, playerId, shopItemId, item, fragmentCost, fragmentCount)
	MyGameEvent:FireEventToPlayer(playerId, "treasure_fragment_shop_item_bought", {
		playerId = playerId,
		shopItemId = shopItemId,
		item = item,
		fragmentCost = fragmentCost,
		fragmentCount = fragmentCount,
	}, true)
end
function ____exports.FireCraftItemClaimed(self, playerId, itemId, count, destination)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"craft_item_claimed",
		{ playerId = playerId, itemId = itemId, count = count, destination = destination },
		true
	)
end
function ____exports.FireMerchantTaskSubmitted(self, playerId, taskId, submittedItem, rewardItems, assetRewards)
	MyGameEvent:FireEventToPlayer(playerId, "merchant_task_submitted", {
		playerId = playerId,
		taskId = taskId,
		submittedItem = submittedItem,
		rewardItems = rewardItems,
		assetRewards = assetRewards,
	}, true)
end
function ____exports.FireMerchantExchangeItemBought(self, playerId, offerId, item, cost)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"merchant_exchange_item_bought",
		{ playerId = playerId, offerId = offerId, item = item, cost = cost },
		true
	)
end
function ____exports.FireMerchantDailyRewardClaimed(self, playerId, rewardItems, assetRewards)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"merchant_daily_reward_claimed",
		{ playerId = playerId, rewardItems = rewardItems, assetRewards = assetRewards },
		true
	)
end
function ____exports.FireItemChestRewardGranted(self, playerId, item, chestItemId)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"item_chest_reward_granted",
		{ playerId = playerId, chestItemId = chestItemId, item = item },
		true
	)
end
function ____exports.FireItemChestGoldGranted(self, playerId, gold, chestItemId)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"item_chest_gold_granted",
		{ playerId = playerId, chestItemId = chestItemId, gold = gold },
		true
	)
end
function ____exports.FireGreedCaveShopItemBought(self, playerId, itemId, count, destination, price)
	MyGameEvent:FireEventToPlayer(playerId, "greed_cave_shop_item_bought", {
		playerId = playerId,
		itemId = itemId,
		count = count,
		destination = destination,
		price = price,
	}, true)
end
function ____exports.FireEquipmentItemEquipped(self, playerId, itemId, count, slot)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"equipment_item_equipped",
		{ playerId = playerId, itemId = itemId, count = count, slot = slot },
		true
	)
end
function ____exports.FireEquipmentItemUnequipped(self, playerId, itemId, count, slot, destination)
	MyGameEvent:FireEventToPlayer(playerId, "equipment_item_unequipped", {
		playerId = playerId,
		itemId = itemId,
		count = count,
		slot = slot,
		destination = destination,
	}, true)
end
--- 在装备预设事务完整提交后广播实际物品流转摘要。
-- 该事件只传展示所需的物品名与实例数量，战斗通知由监听方决定如何汇总和渲染。
function ____exports.FireEquipmentPresetItemFlowCommitted(self, playerId, equippedItems, unequippedToWarehouseItems)
	MyGameEvent:FireEventToPlayer(
		playerId,
		"equipment_preset_item_flow_committed",
		{ playerId = playerId, equippedItems = equippedItems, unequippedToWarehouseItems = unequippedToWarehouseItems },
		true
	)
end
return ____exports