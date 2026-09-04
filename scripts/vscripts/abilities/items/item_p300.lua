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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____ItemFlowBusinessEvents = require("my_game_axe.ItemFlowBusinessEvents")
local FireItemChestGoldGranted = ____ItemFlowBusinessEvents.FireItemChestGoldGranted
local FireItemChestRewardGranted = ____ItemFlowBusinessEvents.FireItemChestRewardGranted
local ITEM_P300_BONUS_DROP_CHANCE_PCT = 28
local MERCHANT_REWARD_CHEST_IDS = {
	item_P300 = true,
	item_P301 = true,
	item_P302 = true,
	item_P303 = true,
	item_P304 = true,
	item_P305 = true,
}
____exports.item_P300 = __TS__Class()
local item_P300 = ____exports.item_P300
item_P300.name = "item_P300"
__TS__ClassExtends(item_P300, BaseItem_CS)
function item_P300.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "channel",
		duration = 0.8,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			self:OpenChest()
		end,
		onInterrupted = function() end,
	}
end
function item_P300.prototype.OpenChest(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local playerId = caster:GetPlayerOwnerID()
	local player = MyGamePlayers:getPlayer(playerId)
	if not player then
		return
	end
	local rewardText = ""
	if self:IsGetGold() then
		local gold = self:GetGold()
		MyGameDropManager:AddGoldByItemName(playerId, gold)
		if self:ShouldNotifyChestRewards() then
			FireItemChestGoldGranted(nil, playerId, gold, self:GetName())
		end
		rewardText = tostring(gold) .. " 金币"
	else
		MyGameDropManager:AddGoldByItemName(playerId, 1)
		rewardText = ""
	end
	if RandomInt(1, 100) <= self:GetItemChance() then
		local decaySourceKey = MyGameDropManager:GetItemProductionSourceKey(self:GetName())
		local dropResult = MyGameDropManager:DrawItemResultFromPool(self:GetDropPoolId(), playerId, decaySourceKey)
		if dropResult then
			Timers:CreateTimer(0.1, function()
				local itemName = dropResult.itemName
				local destination = self:GrantRewardItem(playerId, itemName)
				if destination then
					MyGameDropManager:CommitDropResultDecay(dropResult)
					if not self:IsGetGold() then
						player:RequestDelayedItemSave()
					end
					if self:ShouldNotifyChestRewards() then
						FireItemChestRewardGranted(
							nil,
							playerId,
							{ itemId = itemName, count = 1, destination = destination, source = "chest" },
							self:GetName()
						)
					end
					rewardText = rewardText .. "，并获得额外物品"
				end
			end)
		end
	end
	EmitSoundOnClient("ui.treasure_reveal", self:GetCaster():GetPlayerOwner())
	SuccessMsg(nil, playerId, "开启宝箱成功!")
	self:CostItemCharge(1)
end
function item_P300.prototype.GetItemChance(self)
	return ITEM_P300_BONUS_DROP_CHANCE_PCT
end
function item_P300.prototype.IsGetGold(self)
	return true
end
function item_P300.prototype.GetGold(self)
	local value = self:GetItemKeyValues("ItemCost")
	if not value then
		return 100
	end
	return math.floor(RandomInt(value * 0.5, value * 0.8))
end
function item_P300.prototype.GetDropPoolId(self)
	return "P600"
end
function item_P300.prototype.ShouldNotifyChestRewards(self)
	return MERCHANT_REWARD_CHEST_IDS[self:GetName()] == true
end
function item_P300.prototype.GrantRewardItem(self, playerId, itemName)
	local player = MyGamePlayers:getPlayer(playerId)
	if not player then
		return nil
	end
	local grantResult = player:AddItemWithResult(itemName, 1)
	if grantResult.ok and grantResult.destination ~= "none" then
		return grantResult.destination
	end
	local hero = player:GetHero()
	local item = MyGameItemManager:CreateItem(itemName)
	if not hero or not item then
		if item and IsValid(nil, item) then
			item:RemoveSelf()
		end
		return nil
	end
	MyGameCreateItemOnPosition(nil, hero:GetAbsOrigin():__add(hero:GetForwardVector():__mul(120)), item)
	item._player_id = playerId
	item:SetOwner(hero)
	return "ground"
end
item_P300 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P300)
____exports.item_P300 = item_P300
____exports.item_P301 = __TS__Class()
local item_P301 = ____exports.item_P301
item_P301.name = "item_P301"
__TS__ClassExtends(item_P301, ____exports.item_P300)
function item_P301.prototype.GetDropPoolId(self)
	return "P601"
end
item_P301 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P301)
____exports.item_P301 = item_P301
____exports.item_P302 = __TS__Class()
local item_P302 = ____exports.item_P302
item_P302.name = "item_P302"
__TS__ClassExtends(item_P302, ____exports.item_P300)
function item_P302.prototype.GetDropPoolId(self)
	return "P602"
end
item_P302 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P302)
____exports.item_P302 = item_P302
____exports.item_P303 = __TS__Class()
local item_P303 = ____exports.item_P303
item_P303.name = "item_P303"
__TS__ClassExtends(item_P303, ____exports.item_P300)
function item_P303.prototype.GetDropPoolId(self)
	return "P603"
end
item_P303 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P303)
____exports.item_P303 = item_P303
____exports.item_P304 = __TS__Class()
local item_P304 = ____exports.item_P304
item_P304.name = "item_P304"
__TS__ClassExtends(item_P304, ____exports.item_P300)
function item_P304.prototype.GetDropPoolId(self)
	return "P604"
end
item_P304 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P304)
____exports.item_P304 = item_P304
____exports.item_P305 = __TS__Class()
local item_P305 = ____exports.item_P305
item_P305.name = "item_P305"
__TS__ClassExtends(item_P305, ____exports.item_P300)
function item_P305.prototype.GetDropPoolId(self)
	return "P605"
end
item_P305 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P305)
____exports.item_P305 = item_P305
____exports.item_P310 = __TS__Class()
local item_P310 = ____exports.item_P310
item_P310.name = "item_P310"
__TS__ClassExtends(item_P310, ____exports.item_P300)
function item_P310.prototype.GetDropPoolId(self)
	return "P636"
end
function item_P310.prototype.IsGetGold(self)
	return false
end
function item_P310.prototype.GetItemChance(self)
	return 100
end
item_P310 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P310)
____exports.item_P310 = item_P310
____exports.item_P310_2 = __TS__Class()
local item_P310_2 = ____exports.item_P310_2
item_P310_2.name = "item_P310_2"
__TS__ClassExtends(item_P310_2, ____exports.item_P300)
function item_P310_2.prototype.GetDropPoolId(self)
	return "P636_2"
end
function item_P310_2.prototype.IsGetGold(self)
	return false
end
function item_P310_2.prototype.GetItemChance(self)
	return 100
end
item_P310_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P310_2)
____exports.item_P310_2 = item_P310_2
____exports.item_P310_3 = __TS__Class()
local item_P310_3 = ____exports.item_P310_3
item_P310_3.name = "item_P310_3"
__TS__ClassExtends(item_P310_3, ____exports.item_P300)
function item_P310_3.prototype.GetDropPoolId(self)
	return "P636_3"
end
function item_P310_3.prototype.IsGetGold(self)
	return false
end
function item_P310_3.prototype.GetItemChance(self)
	return 100
end
item_P310_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P310_3)
____exports.item_P310_3 = item_P310_3
____exports.item_P311 = __TS__Class()
local item_P311 = ____exports.item_P311
item_P311.name = "item_P311"
__TS__ClassExtends(item_P311, ____exports.item_P300)
function item_P311.prototype.GetDropPoolId(self)
	return "P638"
end
function item_P311.prototype.IsGetGold(self)
	return false
end
function item_P311.prototype.GetItemChance(self)
	return 100
end
item_P311 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P311)
____exports.item_P311 = item_P311
____exports.item_P311_2 = __TS__Class()
local item_P311_2 = ____exports.item_P311_2
item_P311_2.name = "item_P311_2"
__TS__ClassExtends(item_P311_2, ____exports.item_P300)
function item_P311_2.prototype.GetDropPoolId(self)
	return "P638_2"
end
function item_P311_2.prototype.IsGetGold(self)
	return false
end
function item_P311_2.prototype.GetItemChance(self)
	return 100
end
item_P311_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P311_2)
____exports.item_P311_2 = item_P311_2
____exports.item_P311_3 = __TS__Class()
local item_P311_3 = ____exports.item_P311_3
item_P311_3.name = "item_P311_3"
__TS__ClassExtends(item_P311_3, ____exports.item_P300)
function item_P311_3.prototype.GetDropPoolId(self)
	return "P638_3"
end
function item_P311_3.prototype.IsGetGold(self)
	return false
end
function item_P311_3.prototype.GetItemChance(self)
	return 100
end
item_P311_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P311_3)
____exports.item_P311_3 = item_P311_3
____exports.item_P312 = __TS__Class()
local item_P312 = ____exports.item_P312
item_P312.name = "item_P312"
__TS__ClassExtends(item_P312, ____exports.item_P300)
function item_P312.prototype.GetDropPoolId(self)
	return "P637"
end
function item_P312.prototype.IsGetGold(self)
	return false
end
function item_P312.prototype.GetItemChance(self)
	return 100
end
item_P312 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P312)
____exports.item_P312 = item_P312
____exports.item_P312_2 = __TS__Class()
local item_P312_2 = ____exports.item_P312_2
item_P312_2.name = "item_P312_2"
__TS__ClassExtends(item_P312_2, ____exports.item_P300)
function item_P312_2.prototype.GetDropPoolId(self)
	return "P637_2"
end
function item_P312_2.prototype.IsGetGold(self)
	return false
end
function item_P312_2.prototype.GetItemChance(self)
	return 100
end
item_P312_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P312_2)
____exports.item_P312_2 = item_P312_2
____exports.item_P312_3 = __TS__Class()
local item_P312_3 = ____exports.item_P312_3
item_P312_3.name = "item_P312_3"
__TS__ClassExtends(item_P312_3, ____exports.item_P300)
function item_P312_3.prototype.GetDropPoolId(self)
	return "P637_3"
end
function item_P312_3.prototype.IsGetGold(self)
	return false
end
function item_P312_3.prototype.GetItemChance(self)
	return 100
end
item_P312_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P312_3)
____exports.item_P312_3 = item_P312_3
____exports.item_P313 = __TS__Class()
local item_P313 = ____exports.item_P313
item_P313.name = "item_P313"
__TS__ClassExtends(item_P313, ____exports.item_P300)
function item_P313.prototype.GetDropPoolId(self)
	return "P639"
end
function item_P313.prototype.IsGetGold(self)
	return false
end
function item_P313.prototype.GetItemChance(self)
	return 100
end
item_P313 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P313)
____exports.item_P313 = item_P313
return ____exports