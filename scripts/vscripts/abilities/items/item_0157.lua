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
--- 远行鞋
-- 使用后进行撤离，不消耗装备本体。
____exports.item_0157 = __TS__Class()
local item_0157 = ____exports.item_0157
item_0157.name = "item_0157"
__TS__ClassExtends(item_0157, BaseItem_CS)
function item_0157.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "channel",
		duration = 8,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		ambientEffect = "particles/items2_fx/teleport_start.vpcf",
		canCast = function()
			local playerId = self:GetCaster():GetPlayerId()
			local player = MyGamePlayers:getPlayer(playerId)
			if not player or player:IsInBase() then
				return UF_FAIL_CUSTOM
			end
			return UF_SUCCESS
		end,
		onSuccess = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			local playerId = caster:GetPlayerId()
			MyGameRoomManager:EvacuatePlayer(playerId)
			local ability_level = math.max(self:GetLevel() - 1, 0)
			self:StartCooldown(self:GetCooldown(ability_level))
		end,
		onInterrupted = function() end,
	}
end
function item_0157.prototype.GetTextureName(self)
	return "item_travel_boots"
end
item_0157 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0157)
____exports.item_0157 = item_0157
return ____exports