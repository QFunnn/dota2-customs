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
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____Sync = require("modules.Sync")
local SyncGameEvent = ____Sync.SyncGameEvent
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local BaseLeaderboardIdentityTagItem_CS = __TS__Class()
BaseLeaderboardIdentityTagItem_CS.name = "BaseLeaderboardIdentityTagItem_CS"
__TS__ClassExtends(BaseLeaderboardIdentityTagItem_CS, BaseItem_CS)
function BaseLeaderboardIdentityTagItem_CS.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1.6,
		castAnimation = -1,
		canCast = function()
			local ____opt_0 = self:getLeaderboardIdentitySystem()
			local result = ____opt_0 and ____opt_0:canConsumeTagItem(self.tagItemId)
			local ____result_ok_4
			if result and result.ok then
				____result_ok_4 = UF_SUCCESS
			else
				____result_ok_4 = UF_FAIL_CUSTOM
			end
			return ____result_ok_4
		end,
		castError = function()
			local ____opt_5 = self:getLeaderboardIdentitySystem()
			return ____opt_5 and ____opt_5:canConsumeTagItem(self.tagItemId).reason or "当前无法使用"
		end,
		onSuccess = function()
			self:onTagItemConsumed()
		end,
		onInterrupted = function() end,
	}
end
function BaseLeaderboardIdentityTagItem_CS.prototype.onTagItemConsumed(self)
	return __TS__AsyncAwaiter(function(____awaiter_resolve)
		local caster = self:GetCaster()
		if not IsValidAlive(nil, caster) then
			return ____awaiter_resolve(nil)
		end
		local ____opt_7 = self:getLeaderboardIdentitySystem()
		local result = __TS__Await(____opt_7 and ____opt_7:consumeTagItem(self.tagItemId, self:entindex()))
		if not (result and result.ok) then
			ErrorMsg(nil, caster:GetPlayerId(), result and result.reason or "当前无法使用")
			return ____awaiter_resolve(nil)
		end
		self:PlayEffects1(caster)
		local player = PlayerResource:GetPlayer(caster:GetPlayerId())
		if player and result.tagId and result.previousLevel ~= nil and result.level ~= nil then
			SyncGameEvent:Send_ServerToPlayer(
				player,
				"s2c_leaderboard_identity_tag_prompt",
				{ tagId = result.tagId, previousLevel = result.previousLevel, level = result.level }
			)
		end
	end)
end
function BaseLeaderboardIdentityTagItem_CS.prototype.getLeaderboardIdentitySystem(self)
	local ____opt_13 = self:GetCaster()
	local playerId = ____opt_13 and ____opt_13:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_15 = MyGamePlayers:getPlayer(playerId)
	return ____opt_15 and ____opt_15.leaderboardIdentity
end
function BaseLeaderboardIdentityTagItem_CS.prototype.PlayEffects1(self, caster)
	local particle =
		ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
end
____exports.item_M531 = __TS__Class()
local item_M531 = ____exports.item_M531
item_M531.name = "item_M531"
__TS__ClassExtends(item_M531, BaseLeaderboardIdentityTagItem_CS)
function item_M531.prototype.____constructor(self, ...)
	BaseLeaderboardIdentityTagItem_CS.prototype.____constructor(self, ...)
	self.tagItemId = "item_M531"
end
item_M531 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M531)
____exports.item_M531 = item_M531
____exports.item_M532 = __TS__Class()
local item_M532 = ____exports.item_M532
item_M532.name = "item_M532"
__TS__ClassExtends(item_M532, BaseLeaderboardIdentityTagItem_CS)
function item_M532.prototype.____constructor(self, ...)
	BaseLeaderboardIdentityTagItem_CS.prototype.____constructor(self, ...)
	self.tagItemId = "item_M532"
end
item_M532 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M532)
____exports.item_M532 = item_M532
____exports.item_M533 = __TS__Class()
local item_M533 = ____exports.item_M533
item_M533.name = "item_M533"
__TS__ClassExtends(item_M533, BaseLeaderboardIdentityTagItem_CS)
function item_M533.prototype.____constructor(self, ...)
	BaseLeaderboardIdentityTagItem_CS.prototype.____constructor(self, ...)
	self.tagItemId = "item_M533"
end
item_M533 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M533)
____exports.item_M533 = item_M533
____exports.item_M534 = __TS__Class()
local item_M534 = ____exports.item_M534
item_M534.name = "item_M534"
__TS__ClassExtends(item_M534, BaseLeaderboardIdentityTagItem_CS)
function item_M534.prototype.____constructor(self, ...)
	BaseLeaderboardIdentityTagItem_CS.prototype.____constructor(self, ...)
	self.tagItemId = "item_M534"
end
item_M534 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M534)
____exports.item_M534 = item_M534
return ____exports