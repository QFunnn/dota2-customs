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
local GREED_CAVE_RUNE_BAG_IDS = { item_P326 = true, item_P327 = true, item_P328 = true }
local BaseGreedCaveChestItem = __TS__Class()
BaseGreedCaveChestItem.name = "BaseGreedCaveChestItem"
__TS__ClassExtends(BaseGreedCaveChestItem, BaseItem_CS)
function BaseGreedCaveChestItem.prototype.GetItemConfig(self)
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
function BaseGreedCaveChestItem.prototype.GetRewardCount(self)
	return 1
end
function BaseGreedCaveChestItem.prototype.OpenChest(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local playerId = caster:GetPlayerOwnerID()
	local player = MyGamePlayers:getPlayer(playerId)
	if not player then
		return
	end
	local rewardCount = self:GetRewardCount()
	local dropPoolId = self:GetDropPoolId()
	local decaySourceKey = MyGameDropManager:GetItemProductionSourceKey(self:GetName())
	Timers:CreateTimer(0.1, function()
		local successCount = 0
		do
			local i = 0
			while i < rewardCount do
				do
					local dropResult = MyGameDropManager:DrawItemResultFromPool(dropPoolId, playerId, decaySourceKey)
					if not dropResult then
						WarningPrint(
							("[GreedCaveChest] 掉落池 " .. dropPoolId)
								.. " 未抽到物品，请检查 ak_drop_pools.csv"
						)
						goto __continue10
					end
					local itemName = dropResult.itemName
					if not player:AddItem(itemName, 1) then
						WarningPrint(
							((("[GreedCaveChest] 玩家 " .. tostring(playerId)) .. " 获得 ") .. itemName)
								.. " 失败，请检查背包和仓库空间"
						)
						ErrorMsg(nil, playerId, "背包和仓库空间不足")
						goto __continue10
					end
					MyGameDropManager:CommitDropResultDecay(dropResult)
					successCount = successCount + 1
					ShowItemBullet(nil, playerId, itemName, 1)
					if MyGameCombatNoticeManager ~= nil then
						MyGameCombatNoticeManager:FireMessage(
							CombatNoticeMessage.ItemPickup,
							playerId,
							{ broadcastAll = true, itemId = itemName }
						)
					end
				end
				::__continue10::
				i = i + 1
			end
		end
		if successCount > 0 then
			SuccessMsg(nil, playerId, "开启宝箱成功")
			if GREED_CAVE_RUNE_BAG_IDS[self:GetName()] then
				player:RequestDelayedItemSave()
			else
				player:SavePlayerSave()
			end
		end
	end)
	EmitSoundOnClient("ui.treasure_reveal", caster:GetPlayerOwner())
	self:CostItemCharge(1)
end
local BaseGreedCaveMaterialChestItem = __TS__Class()
BaseGreedCaveMaterialChestItem.name = "BaseGreedCaveMaterialChestItem"
__TS__ClassExtends(BaseGreedCaveMaterialChestItem, BaseGreedCaveChestItem)
function BaseGreedCaveMaterialChestItem.prototype.GetRewardCount(self)
	return 2
end
____exports.item_P314 = __TS__Class()
local item_P314 = ____exports.item_P314
item_P314.name = "item_P314"
__TS__ClassExtends(item_P314, BaseGreedCaveChestItem)
function item_P314.prototype.GetDropPoolId(self)
	return "P704"
end
item_P314 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P314)
____exports.item_P314 = item_P314
____exports.item_P315 = __TS__Class()
local item_P315 = ____exports.item_P315
item_P315.name = "item_P315"
__TS__ClassExtends(item_P315, BaseGreedCaveChestItem)
function item_P315.prototype.GetDropPoolId(self)
	return "P705"
end
item_P315 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P315)
____exports.item_P315 = item_P315
____exports.item_P316 = __TS__Class()
local item_P316 = ____exports.item_P316
item_P316.name = "item_P316"
__TS__ClassExtends(item_P316, BaseGreedCaveChestItem)
function item_P316.prototype.GetDropPoolId(self)
	return "P706"
end
item_P316 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P316)
____exports.item_P316 = item_P316
____exports.item_P317 = __TS__Class()
local item_P317 = ____exports.item_P317
item_P317.name = "item_P317"
__TS__ClassExtends(item_P317, BaseGreedCaveMaterialChestItem)
function item_P317.prototype.GetDropPoolId(self)
	return "P707"
end
item_P317 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P317)
____exports.item_P317 = item_P317
____exports.item_P318 = __TS__Class()
local item_P318 = ____exports.item_P318
item_P318.name = "item_P318"
__TS__ClassExtends(item_P318, BaseGreedCaveChestItem)
function item_P318.prototype.GetDropPoolId(self)
	return "P708"
end
item_P318 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P318)
____exports.item_P318 = item_P318
____exports.item_P319 = __TS__Class()
local item_P319 = ____exports.item_P319
item_P319.name = "item_P319"
__TS__ClassExtends(item_P319, BaseGreedCaveChestItem)
function item_P319.prototype.GetDropPoolId(self)
	return "P709"
end
item_P319 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P319)
____exports.item_P319 = item_P319
____exports.item_P320 = __TS__Class()
local item_P320 = ____exports.item_P320
item_P320.name = "item_P320"
__TS__ClassExtends(item_P320, BaseGreedCaveChestItem)
function item_P320.prototype.GetDropPoolId(self)
	return "P710"
end
item_P320 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P320)
____exports.item_P320 = item_P320
____exports.item_P321 = __TS__Class()
local item_P321 = ____exports.item_P321
item_P321.name = "item_P321"
__TS__ClassExtends(item_P321, BaseGreedCaveChestItem)
function item_P321.prototype.GetDropPoolId(self)
	return "P711"
end
item_P321 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P321)
____exports.item_P321 = item_P321
____exports.item_P322 = __TS__Class()
local item_P322 = ____exports.item_P322
item_P322.name = "item_P322"
__TS__ClassExtends(item_P322, BaseGreedCaveChestItem)
function item_P322.prototype.GetDropPoolId(self)
	return "P712"
end
item_P322 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P322)
____exports.item_P322 = item_P322
____exports.item_P323 = __TS__Class()
local item_P323 = ____exports.item_P323
item_P323.name = "item_P323"
__TS__ClassExtends(item_P323, BaseGreedCaveChestItem)
function item_P323.prototype.GetDropPoolId(self)
	return "P713"
end
item_P323 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P323)
____exports.item_P323 = item_P323
____exports.item_P324 = __TS__Class()
local item_P324 = ____exports.item_P324
item_P324.name = "item_P324"
__TS__ClassExtends(item_P324, BaseGreedCaveMaterialChestItem)
function item_P324.prototype.GetDropPoolId(self)
	return "P714"
end
item_P324 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P324)
____exports.item_P324 = item_P324
____exports.item_P325 = __TS__Class()
local item_P325 = ____exports.item_P325
item_P325.name = "item_P325"
__TS__ClassExtends(item_P325, BaseGreedCaveMaterialChestItem)
function item_P325.prototype.GetDropPoolId(self)
	return "P715"
end
item_P325 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P325)
____exports.item_P325 = item_P325
____exports.item_P326 = __TS__Class()
local item_P326 = ____exports.item_P326
item_P326.name = "item_P326"
__TS__ClassExtends(item_P326, BaseGreedCaveChestItem)
function item_P326.prototype.GetDropPoolId(self)
	return "P716"
end
item_P326 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P326)
____exports.item_P326 = item_P326
____exports.item_P327 = __TS__Class()
local item_P327 = ____exports.item_P327
item_P327.name = "item_P327"
__TS__ClassExtends(item_P327, BaseGreedCaveChestItem)
function item_P327.prototype.GetDropPoolId(self)
	return "P717"
end
item_P327 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P327)
____exports.item_P327 = item_P327
____exports.item_P328 = __TS__Class()
local item_P328 = ____exports.item_P328
item_P328.name = "item_P328"
__TS__ClassExtends(item_P328, BaseGreedCaveChestItem)
function item_P328.prototype.GetDropPoolId(self)
	return "P718"
end
item_P328 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P328)
____exports.item_P328 = item_P328
return ____exports