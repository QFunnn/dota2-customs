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
local ____base_ability = require("abilities._base.base_ability")
local BaseAbility_CS = ____base_ability.BaseAbility_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____Sync = require("modules.Sync")
local SyncNetTable = ____Sync.SyncNetTable
____exports.item_proxy_cast = __TS__Class()
local item_proxy_cast = ____exports.item_proxy_cast
item_proxy_cast.name = "item_proxy_cast"
__TS__ClassExtends(item_proxy_cast, BaseAbility_CS)
function item_proxy_cast.prototype.IsHiddenAbilityCastable(self)
	return true
end
function item_proxy_cast.prototype.InvokeItemSuccess(self, item, itemConfig)
	local ____temp_2 = not item or not IsValid(nil, item)
	if not ____temp_2 then
		local ____this_1
		____this_1 = item
		local ____opt_0 = ____this_1.IsSafeRemoving
		____temp_2 = ____opt_0 and ____opt_0(____this_1)
	end
	if ____temp_2 then
		return
	end
	SafelyCall(nil, function()
		if itemConfig and itemConfig.onSuccess then
			itemConfig:onSuccess()
			return
		end
		local ____this_6
		____this_6 = item
		local ____opt_5 = ____this_6.OnSpellStart
		if ____opt_5 ~= nil then
			____opt_5(____this_6)
		end
	end)
end
function item_proxy_cast.prototype.ApplyProxyResources(self, item)
	local ____temp_9 = not item or item:IsNull()
	if not ____temp_9 then
		local ____this_8
		____this_8 = item
		local ____opt_7 = ____this_8.IsSafeRemoving
		____temp_9 = ____opt_7 and ____opt_7(____this_8)
	end
	if ____temp_9 then
		return
	end
	local level = math.max(item:GetLevel() - 1, 0)
	local shouldSpendMana = item:GetManaCost(level) > 0
	local shouldStartCooldown = item:GetCooldown(level) > 0 and item:GetCooldownTimeRemaining() <= 0
	if not shouldSpendMana and not shouldStartCooldown then
		return
	end
	print(
		(
			(
				(("[item_proxy_cast] ApplyProxyResources item=" .. item:GetName()) .. " mana=")
				.. tostring(shouldSpendMana)
			) .. " health=false cooldown="
		) .. tostring(shouldStartCooldown)
	)
	item:UseResources(shouldSpendMana, false, false, shouldStartCooldown)
end
function item_proxy_cast.prototype.FireProxyItemAbilityEvent(self, eventName, item)
	local caster = self:GetCaster()
	local ____temp_12 = not caster or caster:IsNull() or not item or item:IsNull()
	if not ____temp_12 then
		local ____this_11
		____this_11 = item
		local ____opt_10 = ____this_11.IsSafeRemoving
		____temp_12 = ____opt_10 and ____opt_10(____this_11)
	end
	if ____temp_12 then
		return
	end
	local ____MyGameEvent_24 = MyGameEvent
	local ____MyGameEvent_FireEvent_25 = MyGameEvent.FireEvent
	local ____eventName_23 = eventName
	local ____temp_19 = item:GetEntityIndex()
	local ____temp_20 = item:GetAbilityName()
	local ____temp_21 = caster:GetEntityIndex()
	local ____opt_15 = self.GetCursorTarget
	local ____opt_13 = ____opt_15 and ____opt_15(self)
	local ____temp_22 = ____opt_13 and ____opt_13:GetEntityIndex()
	local ____opt_17 = self.GetCursorPosition
	____MyGameEvent_FireEvent_25(____MyGameEvent_24, ____eventName_23, {
		ability_index = ____temp_19,
		ability_name = ____temp_20,
		caster = ____temp_21,
		target = ____temp_22,
		pos = ____opt_17 and ____opt_17(self),
	}, { scope = "entity", entity = caster })
end
function item_proxy_cast.prototype.SetItemProxyContext(self, item)
	local ____item_32 = item
	local ____temp_30 = self:GetCaster()
	local ____opt_26 = self.GetCursorTarget
	local ____temp_31 = ____opt_26 and ____opt_26(self)
	local ____opt_28 = self.GetCursorPosition
	____item_32.__proxy_cast_context = {
		caster = ____temp_30,
		target = ____temp_31,
		point = ____opt_28 and ____opt_28(self),
	}
	item.__caster__ = self:GetCaster()
end
function item_proxy_cast.prototype.ClearItemProxyContext(self, item) end
function item_proxy_cast.prototype.ClearProxyState(self)
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end
	local playerId = caster:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return
	end
	SyncNetTable:SetTableValue(
		"custom_value",
		"proxy_cast_" .. tostring(playerId),
		{ index = -1, item_entindex = -1, source = "knapsack" }
	)
end
function item_proxy_cast.prototype.GetProxyState(self)
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return nil
	end
	local playerId = caster:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return nil
	end
	return CustomNetTables:GetTableValue("custom_value", "proxy_cast_" .. tostring(playerId))
end
function item_proxy_cast.prototype.ResolveBoundItem(self)
	local state = self:GetProxyState()
	if not state or state.item_entindex == nil or state.item_entindex == -1 then
		return nil
	end
	local ent = EntIndexToHScript(state.item_entindex)
	if not ent or not IsValid(nil, ent) or ent:IsNull() then
		return nil
	end
	local item = ent
	local ____opt_33 = item.IsSafeRemoving
	if ____opt_33 and ____opt_33(item) then
		return nil
	end
	return item
end
function item_proxy_cast.prototype.GetBehavior(self)
	local state = self:GetProxyState()
	local item = self:ResolveBoundItem()
	if not item then
		return BaseAbility_CS.prototype.GetBehavior(self)
	end
	local behavior = item:GetBehaviorInt()
	return bit.bor(behavior, DOTA_ABILITY_BEHAVIOR_HIDDEN)
end
function item_proxy_cast.prototype.GetCastRange(self, location, target)
	local item = self:ResolveBoundItem()
	if not item then
		return BaseAbility_CS.prototype.GetCastRange(self, location, target)
	end
	return item:GetCastRange(location, target)
end
function item_proxy_cast.prototype.GetAOERadius(self)
	local item = self:ResolveBoundItem()
	if not item or type(item.GetAOERadius) ~= "function" then
		return BaseAbility_CS.prototype.GetAOERadius(self)
	end
	return item:GetAOERadius()
end
function item_proxy_cast.prototype.CastFilterResult(self)
	local item = self:ResolveBoundItem()
	if not item then
		return BaseAbility_CS.prototype.CastFilterResult(self)
	end
	return item:CastFilterResult()
end
function item_proxy_cast.prototype.CastFilterResultTarget(self, target)
	local item = self:ResolveBoundItem()
	if not item then
		return BaseAbility_CS.prototype.CastFilterResultTarget(self, target)
	end
	return item:CastFilterResultTarget(target)
end
function item_proxy_cast.prototype.CastFilterResultLocation(self, location)
	local item = self:ResolveBoundItem()
	if not item then
		return BaseAbility_CS.prototype.CastFilterResultLocation(self, location)
	end
	return item:CastFilterResultLocation(location)
end
function item_proxy_cast.prototype.GetCustomCastError(self)
	local item = self:ResolveBoundItem()
	if not item then
		return BaseAbility_CS.prototype.GetCustomCastError(self)
	end
	return item:GetCustomCastError()
end
function item_proxy_cast.prototype.GetCustomCastErrorTarget(self, target)
	local item = self:ResolveBoundItem()
	if not item then
		return BaseAbility_CS.prototype.GetCustomCastErrorTarget(self, target)
	end
	return item:GetCustomCastErrorTarget(target)
end
function item_proxy_cast.prototype.GetCustomCastErrorLocation(self, location)
	local item = self:ResolveBoundItem()
	if not item then
		return BaseAbility_CS.prototype.GetCustomCastErrorLocation(self, location)
	end
	return item:GetCustomCastErrorLocation(location)
end
function item_proxy_cast.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local state = self:GetProxyState()
	local item = self:ResolveBoundItem()
	if not item then
		print("[item_proxy_cast] OnSpellStart no bound item state=" .. JSON:encode(state or {}))
		self:ClearProxyState()
		return
	end
	print(
		(
			(
				(
					(
						(("[item_proxy_cast] OnSpellStart item=" .. item:GetName()) .. " entindex=")
						.. tostring(item:entindex())
					) .. " index="
				) .. tostring(state and state.index or -1)
			) .. " behavior="
		) .. tostring(item:GetBehaviorInt())
	)
	local ____opt_37 = item.GetItemConfig
	local itemConfig = ____opt_37 and ____opt_37(item)
	self:SetItemProxyContext(item)
	self:FireProxyItemAbilityEvent(BusinessEvents.ON_ABILITY_START, item)
	print(
		(("[item_proxy_cast] invoke item success item=" .. item:GetName()) .. " entindex=") .. tostring(item:entindex())
	)
	self:InvokeItemSuccess(item, itemConfig)
	local ____IsValid_result_41 = IsValid(nil, item)
	if ____IsValid_result_41 then
		local ____opt_39 = item.IsSafeRemoving
		____IsValid_result_41 = not (____opt_39 and ____opt_39(item))
	end
	if ____IsValid_result_41 then
		self:FireProxyItemAbilityEvent(BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST, item)
		self:ApplyProxyResources(item)
	end
end
item_proxy_cast = __TS__DecorateLegacy({ registerAbility(nil) }, item_proxy_cast)
____exports.item_proxy_cast = item_proxy_cast
return ____exports