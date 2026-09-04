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
--- 回城卷轴
-- 消耗品：使用后撤离
____exports.item_P100 = __TS__Class()
local item_P100 = ____exports.item_P100
item_P100.name = "item_P100"
__TS__ClassExtends(item_P100, BaseItem_CS)
function item_P100.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 5,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		canCast = function()
			DebugPrint(nil, "canCast")
			local playerId = self:GetCaster():GetPlayerId()
			local player = MyGamePlayers:getPlayer(playerId)
			return not player:IsInBase() and UF_SUCCESS
		end,
		onSuccess = function()
			local caster = self:GetCaster()
			print("撤离成功")
			local playerId = caster:GetPlayerId()
			MyGameRoomManager:EvacuatePlayer(playerId)
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_P100.prototype.GetTextureName(self)
	return "item_tpscroll"
end
item_P100 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P100)
____exports.item_P100 = item_P100
return ____exports