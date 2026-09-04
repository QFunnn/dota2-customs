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
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local ____exports = {}
local ____ability_tag_context = require("shared.ability_tag_context")
local BuildTagContextFromAbilityKv = ____ability_tag_context.BuildTagContextFromAbilityKv
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseItem = ____dota_ts_adapter.BaseItem
local SAFE_REMOVE_DELAY_SECONDS = 0.5
--- 自定义物品基类（CS 层）
____exports.BaseItem_CS = __TS__Class()
local BaseItem_CS = ____exports.BaseItem_CS
BaseItem_CS.name = "BaseItem_CS"
__TS__ClassExtends(BaseItem_CS, BaseItem)
function BaseItem_CS.prototype.ResolveNumericConfigValue(self, value, level)
	if value == nil or value == nil then
		return nil
	end
	local ____temp_0
	if type(value) == "function" then
		____temp_0 = value(nil, level)
	else
		____temp_0 = value
	end
	return ____temp_0
end
function BaseItem_CS.prototype.ResolveClientNumericConfigFallback(self, value)
	local ____temp_1
	if type(value) == "number" then
		____temp_1 = value
	else
		____temp_1 = nil
	end
	return ____temp_1
end
function BaseItem_CS.prototype.BuildTagResolveContext(self, extra)
	local ____opt_2 = self.GetAbilityName
	local abilityName = ____opt_2 and ____opt_2(self) or self:GetName()
	local abilityKv = MyGameRulesetManager and MyGameRulesetManager:GetItemConfig(abilityName)
	local mergedLayer1 = BuildTagContextFromAbilityKv(nil, abilityKv, extra and extra.tagContext)
	local context = { abilityName = abilityName, abilityKv = abilityKv, tagContext = mergedLayer1 }
	if extra and extra.rules then
		context.rules = extra.rules
	end
	return context
end
function BaseItem_CS.prototype.ResolveTagNumber(self, baseValue, statKey, extraContext)
	if not MyGameTagManager then
		return baseValue
	end
	local context = self:BuildTagResolveContext(extraContext)
	local ____opt_10 = self.GetCaster
	local caster = ____opt_10 and ____opt_10(self)
	if caster and IsValid(nil, caster) then
		return MyGameTagManager:ResolveNumberForUnit(caster, baseValue, statKey, context)
	end
	return MyGameTagManager:ResolveNumber(baseValue, statKey, context)
end
function BaseItem_CS.prototype.GetItemConfig(self)
	return nil
end
function BaseItem_CS.prototype.Spawn(self)
	self._caster = BaseItem.prototype.GetCaster(self)
	self._ability = self
	self._parent = BaseItem.prototype.GetCaster(self)
end
function BaseItem_CS.prototype.GetCaster(self)
	local proxyContext = self.__proxy_cast_context
	local ____temp_14 = proxyContext and proxyContext.caster or self.__caster__
	if ____temp_14 == nil then
		____temp_14 = BaseItem.prototype.GetCaster(self)
	end
	return ____temp_14
end
function BaseItem_CS.prototype.GetCursorTarget(self)
	local proxyContext = self.__proxy_cast_context
	return proxyContext and proxyContext.target or BaseItem.prototype.GetCursorTarget(self)
end
function BaseItem_CS.prototype.GetCursorPosition(self)
	local proxyContext = self.__proxy_cast_context
	return proxyContext and proxyContext.point or BaseItem.prototype.GetCursorPosition(self)
end
function BaseItem_CS.prototype.GetBehavior(self)
	local ____opt_19 = self:GetItemConfig()
	return ____opt_19 and ____opt_19.behavior or BaseItem.prototype.GetBehavior(self)
end
function BaseItem_CS.prototype.GetManaCost(self, level)
	local ____self_ResolveNumericConfigValue_23 = self.ResolveNumericConfigValue
	local ____opt_21 = self:GetItemConfig()
	local configManaCost = ____self_ResolveNumericConfigValue_23(self, ____opt_21 and ____opt_21.manaCost, level)
	if configManaCost ~= nil then
		return configManaCost
	end
	return BaseItem.prototype.GetManaCost(self, level)
end
function BaseItem_CS.prototype.GetHealthCost(self, level)
	local ____self_ResolveNumericConfigValue_26 = self.ResolveNumericConfigValue
	local ____opt_24 = self:GetItemConfig()
	local configHealthCost = ____self_ResolveNumericConfigValue_26(self, ____opt_24 and ____opt_24.healthCost, level)
	if configHealthCost ~= nil then
		return configHealthCost
	end
	return BaseItem.prototype.GetHealthCost(self, level)
end
function BaseItem_CS.prototype.GetCooldown(self, level)
	if IsClient() then
		local syncedCooldown = self:ReadResolvedItemCooldown()
		if syncedCooldown ~= nil then
			return syncedCooldown
		end
		local ____opt_27 = self:GetItemConfig()
		local clientConfigCooldown = ____opt_27 and ____opt_27.cooldown
		return self:ResolveClientNumericConfigFallback(clientConfigCooldown)
			or BaseItem.prototype.GetCooldown(self, level)
	end
	local ____opt_29 = self:GetItemConfig()
	local itemConfigCooldown = ____opt_29 and ____opt_29.cooldown
	local configCooldown = self:ResolveNumericConfigValue(itemConfigCooldown, level)
	local ____temp_31
	if configCooldown ~= nil then
		____temp_31 = configCooldown
	else
		____temp_31 = BaseItem.prototype.GetCooldown(self, level)
	end
	local baseCooldown = ____temp_31
	local resolvedCooldown = self:ResolveTagNumber(baseCooldown, 7)
	if MyGameItemResolvedStatManager ~= nil then
		MyGameItemResolvedStatManager:RecordCooldown(self, baseCooldown, resolvedCooldown)
	end
	return resolvedCooldown
end
function BaseItem_CS.prototype.ForceSyncResolvedItemStats(self, stats)
	if not IsServer() then
		return
	end
	if stats and #stats > 0 and __TS__ArrayIndexOf(stats, "cooldown") < 0 then
		return
	end
	local level = math.max(0, self:GetLevel() - 1)
	self:GetCooldown(level)
end
function BaseItem_CS.prototype.ReadResolvedItemCooldown(self)
	local playerId = GetLocalPlayerID()
	if playerId == nil or playerId == nil or playerId < 0 then
		return nil
	end
	local ____table = CustomNetTables:GetTableValue("custom_value", "item_resolved_stats_" .. tostring(playerId))
	local entry = ____table and ____table[tostring(self:entindex())]
	local cooldown = tonumber(entry and entry.cooldown)
	local ____temp_38
	if cooldown ~= nil and cooldown ~= nil and __TS__NumberIsFinite(__TS__Number(cooldown)) then
		____temp_38 = cooldown
	else
		____temp_38 = nil
	end
	return ____temp_38
end
function BaseItem_CS.prototype.CastFilterResult(self)
	local config = self:GetItemConfig()
	if not IsServer() then
		return UF_SUCCESS
	end
	if self:IsSafeRemoving() then
		return UF_FAIL_CUSTOM
	end
	if not (config and config.canCast) then
		return BaseItem.prototype.CastFilterResult(self)
	end
	return config:canCast({})
end
function BaseItem_CS.prototype.CastFilterResultTarget(self, target)
	if not IsServer() then
		return UF_SUCCESS
	end
	if self:IsSafeRemoving() then
		return UF_FAIL_CUSTOM
	end
	local config = self:GetItemConfig()
	if not (config and config.canCast) then
		return BaseItem.prototype.CastFilterResultTarget(self, target)
	end
	return config:canCast({ target = target })
end
function BaseItem_CS.prototype.CastFilterResultLocation(self, location)
	if not IsServer() then
		return UF_SUCCESS
	end
	if self:IsSafeRemoving() then
		return UF_FAIL_CUSTOM
	end
	local config = self:GetItemConfig()
	if not (config and config.canCast) then
		return BaseItem.prototype.CastFilterResultLocation(self, location)
	end
	return config:canCast({ point = location })
end
function BaseItem_CS.prototype.GetCustomCastError(self)
	if not IsServer() then
		return BaseItem.prototype.GetCustomCastError(self)
	end
	local config = self:GetItemConfig()
	if not (config and config.castError) then
		return BaseItem.prototype.GetCustomCastError(self)
	end
	return config:castError({})
end
function BaseItem_CS.prototype.GetCustomCastErrorTarget(self, target)
	if not IsServer() then
		return BaseItem.prototype.GetCustomCastErrorTarget(self, target)
	end
	local config = self:GetItemConfig()
	if not (config and config.castError) then
		return BaseItem.prototype.GetCustomCastErrorTarget(self, target)
	end
	return config:castError({ target = target })
end
function BaseItem_CS.prototype.GetCustomCastErrorLocation(self, location)
	if not IsServer() then
		return BaseItem.prototype.GetCustomCastErrorLocation(self, location)
	end
	local config = self:GetItemConfig()
	if not (config and config.castError) then
		return BaseItem.prototype.GetCustomCastErrorLocation(self, location)
	end
	return config:castError({ point = location })
end
function BaseItem_CS.prototype.FindUnitInRange(self, search_point, range, team)
	if team == nil then
		team = DOTA_UNIT_TARGET_TEAM_ENEMY
	end
	local units = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		search_point,
		nil,
		range,
		team,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	return units
end
function BaseItem_CS.prototype.ApplyDamage(self, target, damage, damage_type, flag)
	if flag == nil then
		flag = ApplyDamageFlag.NO_FLAG
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = damage_type,
		ability = self,
		damage_flag = flag,
	})
end
function BaseItem_CS.prototype.GetSpecialValue(self, _abilityName, key)
	return self:GetSpecialValueFor(key)
end
function BaseItem_CS.prototype.GetSpecialValueFor(self, key)
	if IsServer() then
		local randomAttributes = MyGameItemManager and MyGameItemManager:GetParseAttribute(self)
		local resolvedValue = randomAttributes and randomAttributes[key]
		if resolvedValue ~= nil then
			return tonumber(resolvedValue) or 0
		end
	end
	local rulesetValues = MyGameRulesetManager and MyGameRulesetManager:ResolveItemAbilityValues(self:GetName())
	if rulesetValues and rulesetValues.managed then
		return tonumber(rulesetValues.values[key]) or 0
	end
	return BaseItem.prototype.GetSpecialValueFor(self, key)
end
function BaseItem_CS.prototype.GetSpecialValueRaw(self, _abilityName, key)
	local rulesetValues = MyGameRulesetManager and MyGameRulesetManager:ResolveItemAbilityValues(self:GetName())
	if rulesetValues and rulesetValues.managed then
		return tonumber(rulesetValues.values[key]) or 0
	end
	return BaseItem.prototype.GetSpecialValueFor(self, key)
end
function BaseItem_CS.prototype.GetAllAttackDamage(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	return MyGameAttribute:GetAttribute(caster, "total_attack_damage")
end
function BaseItem_CS.prototype.IsSafeRemoving(self)
	return self.__ak_safe_removing__ == true
end
function BaseItem_CS.prototype.SafeRemove(self, delay)
	if delay == nil then
		delay = SAFE_REMOVE_DELAY_SECONDS
	end
	if not IsValid(nil, self) or self:IsNull() then
		return
	end
	if self.__ak_safe_removing__ then
		return
	end
	self.__ak_safe_removing__ = true
	Timers:CreateTimer(delay, function()
		if not IsValid(nil, self) or self:IsNull() then
			return
		end
		self:RemoveSelf()
	end)
end
function BaseItem_CS.prototype.CostItemCharge(self, count)
	if count == nil then
		count = 1
	end
	if not IsValid(nil, self) then
		return
	end
	if self:IsSafeRemoving() then
		return
	end
	MyGameEvent:FireEventToPlayer(self:GetCaster():GetPlayerId(), "item_charge_changed", {
		itemName = self:GetName(),
		count = count,
		item = self,
	})
	self:SpendCharge(count)
	if self:GetCurrentCharges() == 0 then
		self:SafeRemove()
	end
end
function BaseItem_CS.prototype.ApplyPotionModifier(self, modifierName, duration, params)
	return MyGamePotionManager
		and MyGamePotionManager:ApplyPotion({
			caster = self:GetCaster(),
			ability = self,
			modifierName = modifierName,
			duration = duration,
			params = params,
		})
end
return ____exports