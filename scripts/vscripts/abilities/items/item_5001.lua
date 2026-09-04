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
local BaseActiveGreedCaveCompassItem = __TS__Class()
BaseActiveGreedCaveCompassItem.name = "BaseActiveGreedCaveCompassItem"
__TS__ClassExtends(BaseActiveGreedCaveCompassItem, BaseItem_CS)
function BaseActiveGreedCaveCompassItem.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1.6,
		castAnimation = -1,
		cooldown = 1,
		canCast = function()
			if not IsServer() then
				return UF_SUCCESS
			end
			local playerId = self:GetCasterPlayerId()
			if playerId == nil or playerId < 0 then
				return UF_FAIL_CUSTOM
			end
			local ____MyGameGreedCaveManager_CanUseCompass_result_ok_2
			if MyGameGreedCaveManager and MyGameGreedCaveManager:CanUseCompass(playerId, self:GetCompassTier()).ok then
				____MyGameGreedCaveManager_CanUseCompass_result_ok_2 = UF_SUCCESS
			else
				____MyGameGreedCaveManager_CanUseCompass_result_ok_2 = UF_FAIL_CUSTOM
			end
			return ____MyGameGreedCaveManager_CanUseCompass_result_ok_2
		end,
		castError = function()
			local playerId = self:GetCasterPlayerId()
			if playerId == nil or playerId < 0 then
				return "无法使用秘境邀请函"
			end
			return MyGameGreedCaveManager
					and MyGameGreedCaveManager:CanUseCompass(playerId, self:GetCompassTier()).reason
				or "无法使用秘境邀请函"
		end,
		onSuccess = function()
			return self:UseCompass()
		end,
		onInterrupted = function() end,
	}
end
function BaseActiveGreedCaveCompassItem.prototype.OnSpellStart(self)
	self:UseCompass()
end
function BaseActiveGreedCaveCompassItem.prototype.UseCompass(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster or not IsValidAlive(nil, caster) then
		return
	end
	local playerId = self:GetCasterPlayerId()
	if playerId == nil or playerId < 0 then
		return
	end
	if MyGameGreedCaveManager ~= nil then
		MyGameGreedCaveManager:TryUseCompass(playerId, self:GetCompassTier(), self:entindex())
	end
end
function BaseActiveGreedCaveCompassItem.prototype.GetCasterPlayerId(self)
	local caster = self:GetCaster()
	local ____opt_7 = caster and caster.GetPlayerOwnerID
	return ____opt_7 and ____opt_7(caster)
end
function BaseActiveGreedCaveCompassItem.prototype.PlayEffects1(self, caster)
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/teleport_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("DOTA_Item.TomeOfKnowledge")
end
____exports.item_5001 = __TS__Class()
local item_5001 = ____exports.item_5001
item_5001.name = "item_5001"
__TS__ClassExtends(item_5001, BaseItem_CS)
item_5001 = __TS__DecorateLegacy({ registerAbility(nil) }, item_5001)
____exports.item_5001 = item_5001
____exports.item_5002 = __TS__Class()
local item_5002 = ____exports.item_5002
item_5002.name = "item_5002"
__TS__ClassExtends(item_5002, BaseItem_CS)
item_5002 = __TS__DecorateLegacy({ registerAbility(nil) }, item_5002)
____exports.item_5002 = item_5002
____exports.item_5003 = __TS__Class()
local item_5003 = ____exports.item_5003
item_5003.name = "item_5003"
__TS__ClassExtends(item_5003, BaseItem_CS)
item_5003 = __TS__DecorateLegacy({ registerAbility(nil) }, item_5003)
____exports.item_5003 = item_5003
____exports.item_5101 = __TS__Class()
local item_5101 = ____exports.item_5101
item_5101.name = "item_5101"
__TS__ClassExtends(item_5101, BaseActiveGreedCaveCompassItem)
function item_5101.prototype.GetCompassTier(self)
	return 4
end
item_5101 = __TS__DecorateLegacy({ registerAbility(nil) }, item_5101)
____exports.item_5101 = item_5101
return ____exports