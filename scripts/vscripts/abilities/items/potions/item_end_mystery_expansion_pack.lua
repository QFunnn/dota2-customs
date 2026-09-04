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
local ____Sync = require("modules.Sync")
local SyncGameEvent = ____Sync.SyncGameEvent
local END_MYSTERY_BASIC_TOKEN_ITEM_ID = "item_P253"
local END_MYSTERY_REWARD_SPACE_ERROR = "背包或仓库空间不足，无法领取扩展包物品"
local BaseEndMysteryExpansionItem = __TS__Class()
BaseEndMysteryExpansionItem.name = "BaseEndMysteryExpansionItem"
__TS__ClassExtends(BaseEndMysteryExpansionItem, BaseItem_CS)
function BaseEndMysteryExpansionItem.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1.2,
		castAnimation = -1,
		canCast = function()
			local ____table_CanUseItem_result_ok_0
			if self:CanUseItem().ok then
				____table_CanUseItem_result_ok_0 = UF_SUCCESS
			else
				____table_CanUseItem_result_ok_0 = UF_FAIL_CUSTOM
			end
			return ____table_CanUseItem_result_ok_0
		end,
		castError = function()
			return self:CanUseItem().reason or "当前无法使用"
		end,
		onSuccess = function()
			self:OnUseItem()
		end,
		onInterrupted = function() end,
	}
end
function BaseEndMysteryExpansionItem.prototype.CanUseItem(self)
	local player = self:GetCustomPlayer()
	if not (player and player:IsSaveLoadedComplete()) then
		return { ok = false, reason = "存档尚未加载完成" }
	end
	if not player:GetHero() then
		return { ok = false, reason = "英雄未就绪" }
	end
	return { ok = true }
end
function BaseEndMysteryExpansionItem.prototype.GetCustomPlayer(self)
	local ____opt_3 = self:GetCaster()
	local playerId = ____opt_3 and ____opt_3:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	return MyGamePlayers:getPlayer(playerId)
end
function BaseEndMysteryExpansionItem.prototype.GetShopMall(self)
	local ____opt_5 = self:GetCustomPlayer()
	return ____opt_5 and ____opt_5.shopMall
end
function BaseEndMysteryExpansionItem.prototype.ConsumeCurrentItem(self)
	local caster = self:GetCaster()
	local playerId = caster and caster:GetPlayerId()
	if playerId ~= nil and playerId >= 0 then
		local player = MyGamePlayers:getPlayer(playerId)
		if player and player:CostItemToIndex(self:entindex(), 1) then
			return
		end
	end
	self:CostItemCharge(1)
end
function BaseEndMysteryExpansionItem.prototype.PlayEffects1(self, caster)
	local particle =
		ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
end
____exports.item_P253 = __TS__Class()
local item_P253 = ____exports.item_P253
item_P253.name = "item_P253"
__TS__ClassExtends(item_P253, BaseEndMysteryExpansionItem)
function item_P253.prototype.CanUseItem(self)
	local result = BaseEndMysteryExpansionItem.prototype.CanUseItem(self)
	if not result.ok then
		return result
	end
	local shopMall = self:GetShopMall()
	if not shopMall then
		return { ok = false, reason = "商城数据未就绪" }
	end
	if shopMall:HasEndMysteryBasicEntitlement() then
		return { ok = false, reason = "末影秘境扩展包权益已解锁，无法重复使用" }
	end
	return { ok = true }
end
function item_P253.prototype.OnUseItem(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local shopMall = self:GetShopMall()
	if not shopMall then
		ErrorMsg(nil, caster:GetPlayerId(), "商城数据未就绪")
		return
	end
	local result = shopMall:ActivateEndMysteryBasicEntitlement()
	if not (result and result.ok) then
		ErrorMsg(nil, caster:GetPlayerId(), result and result.reason or "末影秘境扩展包权益激活失败")
		return
	end
	local player = self:GetCustomPlayer()
	if not player then
		return
	end
	player:AddCustomValue("tree9", 1)
	local unlockedMaps = player.playerSave:GetServerData("unlocked_maps") or {}
	if not unlockedMaps.M014 then
		unlockedMaps.M014 = true
		player.playerSave:SetServerData("unlocked_maps", unlockedMaps)
	end
	SyncGameEvent:Send_ServerToPlayer(
		PlayerResource:GetPlayer(player.playerId),
		"s2c_portal_unlock",
		{ roomId = "M014" }
	)
	self:PlayEffects1(caster)
	SuccessMsg(nil, caster:GetPlayerId(), "末影秘境扩展包权益已解锁")
	self:ConsumeCurrentItem()
end
item_P253 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P253)
____exports.item_P253 = item_P253
____exports.item_P254 = __TS__Class()
local item_P254 = ____exports.item_P254
item_P254.name = "item_P254"
__TS__ClassExtends(item_P254, BaseEndMysteryExpansionItem)
function item_P254.prototype.CanUseItem(self)
	local result = BaseEndMysteryExpansionItem.prototype.CanUseItem(self)
	if not result.ok then
		return result
	end
	local player = self:GetCustomPlayer()
	if not player then
		return { ok = false, reason = "玩家数据未就绪" }
	end
	return self:CanGrantRewards(player, { { itemId = END_MYSTERY_BASIC_TOKEN_ITEM_ID, count = 1 } })
end
function item_P254.prototype.OnUseItem(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local player = self:GetCustomPlayer()
	if not player then
		return
	end
	local rewards = { { itemId = END_MYSTERY_BASIC_TOKEN_ITEM_ID, count = 1 } }
	if not self:GrantRewards(player, rewards) then
		ErrorMsg(nil, caster:GetPlayerId(), END_MYSTERY_REWARD_SPACE_ERROR)
		return
	end
	self:PlayEffects1(caster)
	SuccessMsg(nil, caster:GetPlayerId(), "已获得末影秘契")
	self:ConsumeCurrentItem()
end
function item_P254.prototype.CanGrantRewards(self, player, rewards)
	for ____, reward in ipairs(rewards) do
		if not player:CanAddItem(reward.itemId, reward.count) then
			return { ok = false, reason = END_MYSTERY_REWARD_SPACE_ERROR }
		end
	end
	return { ok = true }
end
function item_P254.prototype.GrantRewards(self, player, rewards)
	local grantedRewards = {}
	for ____, reward in ipairs(rewards) do
		if not player:AddItem(reward.itemId, reward.count) then
			for ____, grantedReward in ipairs(grantedRewards) do
				player:CostItem(grantedReward.itemId, grantedReward.count)
			end
			return false
		end
		grantedRewards[#grantedRewards + 1] = reward
	end
	local playerId = player.playerId
	for ____, reward in ipairs(rewards) do
		ShowItemBullet(nil, playerId, reward.itemId, reward.count)
	end
	return true
end
item_P254 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P254)
____exports.item_P254 = item_P254
____exports.item_P255 = __TS__Class()
local item_P255 = ____exports.item_P255
item_P255.name = "item_P255"
__TS__ClassExtends(item_P255, BaseEndMysteryExpansionItem)
function item_P255.prototype.OnUseItem(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local player = self:GetCustomPlayer()
	if not player then
		return
	end
	local ability_gold = self:GetSpecialValueFor("ability_gold")
	if not player:AddAssets("gold", ability_gold) then
		ErrorMsg(nil, caster:GetPlayerId(), "金币发放失败，请稍后重试")
		return
	end
	SendOverheadEventMessage(player:GetPlayer(), OVERHEAD_ALERT_GOLD, caster, ability_gold, nil)
	self:PlayEffects1(caster)
	SuccessMsg(nil, caster:GetPlayerId(), ("末影珍藏匣已开启，获得" .. tostring(ability_gold)) .. "金币")
	self:ConsumeCurrentItem()
end
item_P255 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P255)
____exports.item_P255 = item_P255
return ____exports