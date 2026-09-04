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
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____ability_tag_context = require("shared.ability_tag_context")
local BuildTagContextFromAbilityKv = ____ability_tag_context.BuildTagContextFromAbilityKv
local ____ability_value_stat_key = require("shared.ability_value_stat_key")
local ResolveStatByAbilityValueKey = ____ability_value_stat_key.ResolveStatByAbilityValueKey
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerAbility = ____dota_ts_adapter.registerAbility
local CUSTOM_ABILITY_CHARGES_KEY = "Custom_AbilityCharges"
local CUSTOM_ABILITY_CHARGE_RESTORE_TIME_KEY = "Custom_AbilityChargeRestoreTime"
local ABILITY_COOLDOWN_KEY = "AbilityCooldown"
local ABILITY_MANA_COST_KEY = "AbilityManaCost"
local ABILITY_CAST_RANGE_KEY = "AbilityCastRange"
local ABILITY_CAST_POINT_KEY = "AbilityCastPoint"
local ABILITY_CAST_ANIMATION_KEY = "AbilityCastAnimation"
local ABILITY_CAST_ANIMATION_MAP = {
	DOTA_ATTACK = ACT_DOTA_ATTACK,
	DOTA_CAST_ABILITY_1 = ACT_DOTA_CAST_ABILITY_1,
	DOTA_CAST_ABILITY_2 = ACT_DOTA_CAST_ABILITY_2,
	DOTA_CAST_ABILITY_3 = ACT_DOTA_CAST_ABILITY_3,
	DOTA_CAST_ABILITY_4 = ACT_DOTA_CAST_ABILITY_4,
	DOTA_CAST_ABILITY_5 = ACT_DOTA_CAST_ABILITY_5,
	DOTA_CAST_ABILITY_6 = ACT_DOTA_CAST_ABILITY_6,
	DOTA_GENERIC_CHANNEL_1 = ACT_DOTA_GENERIC_CHANNEL_1,
	DOTA_OVERRIDE_ABILITY_1 = ACT_DOTA_OVERRIDE_ABILITY_1,
	DOTA_OVERRIDE_ABILITY_2 = ACT_DOTA_OVERRIDE_ABILITY_2,
	DOTA_OVERRIDE_ABILITY_3 = ACT_DOTA_OVERRIDE_ABILITY_3,
	DOTA_OVERRIDE_ABILITY_4 = ACT_DOTA_OVERRIDE_ABILITY_4,
	DOTA_SPAWN = ACT_DOTA_SPAWN,
	DOTA_TELEPORT = ACT_DOTA_TELEPORT,
}
local MIN_CUSTOM_CHARGE_RESTORE_TIME = 0.03
local MAX_CUSTOM_CHARGE_RESTORE_REDUCTION_PCT = 99
____exports.BaseAbility_CS = __TS__Class()
local BaseAbility_CS = ____exports.BaseAbility_CS
BaseAbility_CS.name = "BaseAbility_CS"
__TS__ClassExtends(BaseAbility_CS, BaseAbility)
function BaseAbility_CS.prototype.ResolveNumericConfigValue(self, value, level)
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
function BaseAbility_CS.prototype.BuildTagResolveContext(self, extra)
	local abilityName = self:GetAbilityName()
	local ____table_ShouldUseSeasonRuleset_result_3
	if self:ShouldUseSeasonRuleset() then
		____table_ShouldUseSeasonRuleset_result_3 = MyGameRulesetManager
			and MyGameRulesetManager:GetAbilityConfig(abilityName)
	else
		____table_ShouldUseSeasonRuleset_result_3 = nil
	end
	local abilityKv = ____table_ShouldUseSeasonRuleset_result_3
	local mergedLayer1 = BuildTagContextFromAbilityKv(nil, abilityKv, extra and extra.tagContext)
	local context = { abilityName = abilityName, abilityKv = abilityKv, tagContext = mergedLayer1 }
	if extra and extra.rules then
		context.rules = extra.rules
	end
	return context
end
function BaseAbility_CS.prototype.ResolveTagNumber(self, baseValue, statKey, extraContext)
	if not self:ShouldUseSeasonRuleset() then
		return baseValue
	end
	if not MyGameTagManager then
		return baseValue
	end
	local context = self:BuildTagResolveContext(extraContext)
	local ____opt_8 = self.GetCaster
	local caster = ____opt_8 and ____opt_8(self)
	if caster and IsValid(nil, caster) then
		return MyGameTagManager:ResolveNumberForUnit(caster, baseValue, statKey, context)
	end
	return MyGameTagManager:ResolveNumber(baseValue, statKey, context)
end
function BaseAbility_CS.prototype.GetCooldown(self, level)
	if IsServer() and (MyGameAbilityChargeManager and MyGameAbilityChargeManager:IsCustomChargeAbility(self)) then
		return MyGameAbilityChargeManager:GetReleaseInterval()
	end
	return self:ResolveTagNumber(self:GetBaseCooldownValue(level), 7)
end
function BaseAbility_CS.prototype.GetManaCost(self, level)
	return self:ResolveTagNumber(self:GetBaseManaCostValue(level), 6)
end
function BaseAbility_CS.prototype.GetHealthCost(self, level)
	local ____self_ResolveNumericConfigValue_14 = self.ResolveNumericConfigValue
	local ____opt_12 = self:GetAbilityConfig()
	local configHealthCost = ____self_ResolveNumericConfigValue_14(self, ____opt_12 and ____opt_12.healthCost, level)
	if configHealthCost ~= nil then
		return configHealthCost
	end
	return BaseAbility.prototype.GetHealthCost(self, level)
end
function BaseAbility_CS.prototype.GetAbilityConfig(self)
	return nil
end
function BaseAbility_CS.prototype.ShouldUseSeasonRuleset(self)
	return true
end
function BaseAbility_CS.prototype.GetCustomAbilityChargeCountBonus(self)
	return 0
end
function BaseAbility_CS.prototype.GetCustomAbilityChargeRestoreTimeReductionPct(self)
	return 0
end
function BaseAbility_CS.prototype.ResolveRulesetAbilityTopLevelNumber(self, key)
	if not self:ShouldUseSeasonRuleset() then
		return nil
	end
	local rulesetValue = MyGameRulesetManager
		and MyGameRulesetManager:ResolveAbilityTopLevelValue(self:GetAbilityName(), key)
	local value = tonumber(rulesetValue)
	local ____temp_17
	if value ~= nil and __TS__NumberIsFinite(__TS__Number(value)) then
		____temp_17 = value
	else
		____temp_17 = nil
	end
	return ____temp_17
end
function BaseAbility_CS.prototype.ResolveAbilityTopLevelNumber(self, key)
	local rulesetValue = self:ResolveRulesetAbilityTopLevelNumber(key)
	if rulesetValue ~= nil then
		return rulesetValue
	end
	local ____opt_18 = self.GetAbilityKeyValues
	local rawValue = ____opt_18 and ____opt_18(self, key)
	local value = tonumber(rawValue)
	local ____temp_20
	if value ~= nil and __TS__NumberIsFinite(__TS__Number(value)) then
		____temp_20 = value
	else
		____temp_20 = nil
	end
	return ____temp_20
end
function BaseAbility_CS.prototype.ResolveRulesetAbilityCastAnimation(self)
	if not self:ShouldUseSeasonRuleset() then
		return nil
	end
	local rawValue = MyGameRulesetManager
		and MyGameRulesetManager:ResolveAbilityTopLevelValue(self:GetAbilityName(), ABILITY_CAST_ANIMATION_KEY)
	if type(rawValue) == "number" then
		return rawValue
	end
	if type(rawValue) ~= "string" or #rawValue == 0 then
		return nil
	end
	local ____rawValue_startsWith_result_23
	if __TS__StringStartsWith(rawValue, "ACT_") then
		____rawValue_startsWith_result_23 = string.sub(rawValue, 5)
	else
		____rawValue_startsWith_result_23 = rawValue
	end
	local enumKey = ____rawValue_startsWith_result_23
	return ABILITY_CAST_ANIMATION_MAP[enumKey]
end
function BaseAbility_CS.prototype.ResolveRulesetAbilityBehavior(self)
	if not self:ShouldUseSeasonRuleset() then
		return nil
	end
	local rawValue = MyGameRulesetManager
		and MyGameRulesetManager:ResolveAbilityTopLevelValue(self:GetAbilityName(), "AbilityBehavior")
	if type(rawValue) == "number" then
		return rawValue
	end
	if type(rawValue) ~= "string" or #rawValue == 0 then
		return nil
	end
	local abilityBehaviorMap = {
		HIDDEN = DOTA_ABILITY_BEHAVIOR_HIDDEN,
		PASSIVE = DOTA_ABILITY_BEHAVIOR_PASSIVE,
		NO_TARGET = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		UNIT_TARGET = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET,
		POINT = DOTA_ABILITY_BEHAVIOR_POINT,
		AOE = DOTA_ABILITY_BEHAVIOR_AOE,
		CHANNELLED = DOTA_ABILITY_BEHAVIOR_CHANNELLED,
		TOGGLE = DOTA_ABILITY_BEHAVIOR_TOGGLE,
		IMMEDIATE = DOTA_ABILITY_BEHAVIOR_IMMEDIATE,
		AUTOCAST = DOTA_ABILITY_BEHAVIOR_AUTOCAST,
		DIRECTIONAL = DOTA_ABILITY_BEHAVIOR_DIRECTIONAL,
		IGNORE_BACKSWING = DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		DONT_CANCEL_MOVEMENT = DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT,
	}
	local behavior = 0
	for ____, rawToken in ipairs(__TS__StringSplit(rawValue, "|")) do
		local token = __TS__StringTrim(rawToken)
		local ____token_startsWith_result_26
		if __TS__StringStartsWith(token, "DOTA_ABILITY_BEHAVIOR_") then
			____token_startsWith_result_26 = __TS__StringSlice(token, #"DOTA_ABILITY_BEHAVIOR_")
		else
			____token_startsWith_result_26 = token
		end
		local enumKey = ____token_startsWith_result_26
		local enumValue = abilityBehaviorMap[enumKey]
		if enumValue == nil then
			return nil
		end
		behavior = behavior + enumValue
	end
	return behavior
end
function BaseAbility_CS.prototype.GetCustomAbilityMaxCharges(self)
	local rawCharges = self:ResolveAbilityTopLevelNumber(CUSTOM_ABILITY_CHARGES_KEY) or 1
	local abilityBonus = self:GetCustomAbilityChargeCountBonus()
	local baseCharges = math.max(1, rawCharges + abilityBonus)
	local resolved = self:ResolveTagNumber(baseCharges, 17)
	return math.max(1, math.floor(resolved))
end
function BaseAbility_CS.prototype.HasConfiguredCustomAbilityCharges(self)
	local rawCharges = self:ResolveAbilityTopLevelNumber(CUSTOM_ABILITY_CHARGES_KEY)
	return rawCharges ~= nil and rawCharges > 1
end
function BaseAbility_CS.prototype.GetCustomAbilityChargeRestoreTime(self)
	local rawRestoreTime = self:ResolveAbilityTopLevelNumber(CUSTOM_ABILITY_CHARGE_RESTORE_TIME_KEY) or 0
	local ____self_ResolveNumericConfigValue_29 = self.ResolveNumericConfigValue
	local ____opt_27 = self:GetAbilityConfig()
	local configCooldown =
		____self_ResolveNumericConfigValue_29(self, ____opt_27 and ____opt_27.cooldown, self:GetLevel() - 1)
	local rulesetCooldown = self:ResolveRulesetAbilityTopLevelNumber(ABILITY_COOLDOWN_KEY)
	local kvCooldown = self:ResolveAbilityTopLevelNumber(ABILITY_COOLDOWN_KEY) or 0
	local fallbackRestoreTime = configCooldown or rulesetCooldown or kvCooldown
	local ____math_max_31 = math.max
	local ____temp_30
	if rawRestoreTime > 0 then
		____temp_30 = rawRestoreTime
	else
		____temp_30 = fallbackRestoreTime
	end
	local baseRestoreTime = ____math_max_31(MIN_CUSTOM_CHARGE_RESTORE_TIME, ____temp_30)
	local ____opt_32 = self.GetCaster
	local caster = ____opt_32 and ____opt_32(self)
	local ____temp_36
	if caster and IsValid(nil, caster) and (MyGameAttribute and MyGameAttribute:HasAttributes(caster)) then
		____temp_36 = math.max(
			0,
			math.min(
				MAX_CUSTOM_CHARGE_RESTORE_REDUCTION_PCT,
				MyGameAttribute:GetAttribute(caster, "charge_restore_time_pct") or 0
			)
		)
	else
		____temp_36 = 0
	end
	local unitReductionPct = ____temp_36
	local ____temp_39
	if caster and IsValid(nil, caster) and (MyGameAttribute and MyGameAttribute:HasAttributes(caster)) then
		____temp_39 = math.max(0, MyGameAttribute:GetAttribute(caster, "charge_restore_speed_pct") or 0)
	else
		____temp_39 = 0
	end
	local unitRestoreSpeedPct = ____temp_39
	local abilityReductionPct = math.max(
		0,
		math.min(MAX_CUSTOM_CHARGE_RESTORE_REDUCTION_PCT, self:GetCustomAbilityChargeRestoreTimeReductionPct())
	)
	local afterUnitReduction = baseRestoreTime * math.max(0, 1 - unitReductionPct / 100)
	local afterUnitRestoreSpeed = afterUnitReduction / (1 + unitRestoreSpeedPct / 100)
	local afterAbilityReduction = afterUnitRestoreSpeed * math.max(0, 1 - abilityReductionPct / 100)
	local resolved = self:ResolveTagNumber(afterAbilityReduction, 16, { tagContext = { tags = 32 } })
	return math.max(MIN_CUSTOM_CHARGE_RESTORE_TIME, resolved)
end
function BaseAbility_CS.prototype.OnCastEffect(self)
	return nil
end
function BaseAbility_CS.prototype.GetBehavior(self)
	local castEffect = self:OnCastEffect()
	if IsClient() and castEffect then
		if MyGameAbilityCastFxManager ~= nil then
			MyGameAbilityCastFxManager:TickByAbility(self)
		end
	end
	local config = self:GetAbilityConfig()
	if (config and config.behavior) ~= nil then
		return config.behavior
	end
	local rulesetBehavior = self:ResolveRulesetAbilityBehavior()
	local ____temp_44
	if rulesetBehavior ~= nil then
		____temp_44 = rulesetBehavior
	else
		____temp_44 = BaseAbility.prototype.GetBehavior(self)
	end
	return ____temp_44
end
function BaseAbility_CS.prototype.GetCastPoint(self)
	local baseCastPoint = self:GetBaseCastPointValue()
	return self:ResolveTagNumber(baseCastPoint, 9)
end
function BaseAbility_CS.prototype.GetCastAnimation(self)
	local config = self:GetAbilityConfig()
	if (config and config.castAnimation) ~= nil then
		return config.castAnimation
	end
	local rulesetCastAnimation = self:ResolveRulesetAbilityCastAnimation()
	local ____temp_47
	if rulesetCastAnimation ~= nil then
		____temp_47 = rulesetCastAnimation
	else
		____temp_47 = BaseAbility.prototype.GetCastAnimation(self)
	end
	return ____temp_47
end
function BaseAbility_CS.prototype.GetBaseCooldownValue(self, level)
	local ____self_ResolveNumericConfigValue_50 = self.ResolveNumericConfigValue
	local ____opt_48 = self:GetAbilityConfig()
	local configCooldown = ____self_ResolveNumericConfigValue_50(self, ____opt_48 and ____opt_48.cooldown, level)
	if configCooldown ~= nil then
		return configCooldown
	end
	local rulesetCooldown = self:ResolveRulesetAbilityTopLevelNumber(ABILITY_COOLDOWN_KEY)
	local ____temp_51
	if rulesetCooldown ~= nil then
		____temp_51 = rulesetCooldown
	else
		____temp_51 = BaseAbility.prototype.GetCooldown(self, level)
	end
	return ____temp_51
end
function BaseAbility_CS.prototype.GetBaseManaCostValue(self, level)
	local ____self_ResolveNumericConfigValue_54 = self.ResolveNumericConfigValue
	local ____opt_52 = self:GetAbilityConfig()
	local configManaCost = ____self_ResolveNumericConfigValue_54(self, ____opt_52 and ____opt_52.manaCost, level)
	if configManaCost ~= nil then
		return configManaCost
	end
	local rulesetManaCost = self:ResolveRulesetAbilityTopLevelNumber(ABILITY_MANA_COST_KEY)
	local ____temp_55
	if rulesetManaCost ~= nil then
		____temp_55 = rulesetManaCost
	else
		____temp_55 = BaseAbility.prototype.GetManaCost(self, level)
	end
	return ____temp_55
end
function BaseAbility_CS.prototype.GetBaseCastPointValue(self)
	local config = self:GetAbilityConfig()
	if (config and config.castPoint) ~= nil then
		return config.castPoint
	end
	local rulesetCastPoint = self:ResolveRulesetAbilityTopLevelNumber(ABILITY_CAST_POINT_KEY)
	local ____temp_58
	if rulesetCastPoint ~= nil then
		____temp_58 = rulesetCastPoint
	else
		____temp_58 = BaseAbility.prototype.GetCastPoint(self)
	end
	return ____temp_58
end
function BaseAbility_CS.prototype.GetPlaybackRateOverride(self)
	local config = self:GetAbilityConfig()
	local configPlayback = config and config.animationPlaybackRate
	local superPlayback = BaseAbility.prototype.GetPlaybackRateOverride(self)
	local ____temp_62
	if configPlayback ~= nil then
		____temp_62 = configPlayback
	else
		local ____temp_61
		if superPlayback and __TS__NumberIsFinite(__TS__Number(superPlayback)) and superPlayback > 0 then
			____temp_61 = superPlayback
		else
			____temp_61 = 1
		end
		____temp_62 = ____temp_61
	end
	local basePlaybackRate = ____temp_62
	local baseCastPoint = self:GetBaseCastPointValue()
	if not __TS__NumberIsFinite(__TS__Number(baseCastPoint)) or baseCastPoint <= 0 then
		return basePlaybackRate
	end
	local resolvedCastPoint = self:GetCastPoint()
	if not __TS__NumberIsFinite(__TS__Number(resolvedCastPoint)) or resolvedCastPoint <= 0 then
		return basePlaybackRate
	end
	return basePlaybackRate * (baseCastPoint / resolvedCastPoint)
end
function BaseAbility_CS.prototype.GetCastRange(self, location, target)
	return self:ResolveTagNumber(self:GetBaseCastRangeValue(location, target), 8)
end
function BaseAbility_CS.prototype.GetBaseCastRangeValue(self, location, target)
	local config = self:GetAbilityConfig()
	local castRange = config and config.castRange
	if castRange ~= nil and castRange ~= nil then
		local ____temp_65
		if type(castRange) == "function" then
			____temp_65 = castRange(nil, location, target)
		else
			____temp_65 = castRange
		end
		return ____temp_65
	end
	local rulesetCastRange = self:ResolveRulesetAbilityTopLevelNumber(ABILITY_CAST_RANGE_KEY)
	if rulesetCastRange ~= nil then
		return rulesetCastRange
	end
	return BaseAbility.prototype.GetCastRange(self, location, target) or 0
end
function BaseAbility_CS.prototype.CastFilterResult(self)
	local config = self:GetAbilityConfig()
	local castEffect = self:OnCastEffect()
	if IsClient() and self.GetCaster and castEffect then
		if MyGameAbilityCastFxManager ~= nil then
			MyGameAbilityCastFxManager:UpdatePreview(self:GetCaster(), self, self:GetCursorPosition())
		end
	end
	if not IsServer() then
		return UF_SUCCESS
	end
	if MyGameAbilityChargeManager and not MyGameAbilityChargeManager:CanCastAbility(self) then
		return UF_FAIL_CUSTOM
	end
	if not (config and config.canCast) then
		return BaseAbility.prototype.CastFilterResult(self)
	end
	return config:canCast({})
end
function BaseAbility_CS.prototype.CastFilterResultTarget(self, target)
	local castEffect = self:OnCastEffect()
	if IsClient() and self.GetCaster and castEffect then
		if MyGameAbilityCastFxManager ~= nil then
			MyGameAbilityCastFxManager:UpdatePreview(self:GetCaster(), self, target:GetAbsOrigin())
		end
	end
	if not IsServer() then
		return UF_SUCCESS
	end
	if MyGameAbilityChargeManager and not MyGameAbilityChargeManager:CanCastAbility(self) then
		return UF_FAIL_CUSTOM
	end
	local config = self:GetAbilityConfig()
	if not (config and config.canCast) then
		return BaseAbility.prototype.CastFilterResultTarget(self, target)
	end
	return config:canCast({ target = target })
end
function BaseAbility_CS.prototype.CastFilterResultLocation(self, location)
	local castEffect = self:OnCastEffect()
	if IsClient() and self.GetCaster and castEffect then
		if MyGameAbilityCastFxManager ~= nil then
			MyGameAbilityCastFxManager:UpdatePreview(self:GetCaster(), self, location)
		end
	end
	if not IsServer() then
		return UF_SUCCESS
	end
	if MyGameAbilityChargeManager and not MyGameAbilityChargeManager:CanCastAbility(self) then
		return UF_FAIL_CUSTOM
	end
	local config = self:GetAbilityConfig()
	if not (config and config.canCast) then
		return BaseAbility.prototype.CastFilterResultLocation(self, location)
	end
	return config:canCast({ point = location })
end
function BaseAbility_CS.prototype.GetCustomCastError(self)
	if IsServer() and MyGameAbilityChargeManager and not MyGameAbilityChargeManager:CanCastAbility(self) then
		return "#dota_hud_error_ability_in_cooldown"
	end
	local config = self:GetAbilityConfig()
	if not (config and config.castError) then
		return BaseAbility.prototype.GetCustomCastError(self)
	end
	return config:castError({})
end
function BaseAbility_CS.prototype.GetCustomCastErrorTarget(self, target)
	if IsServer() and MyGameAbilityChargeManager and not MyGameAbilityChargeManager:CanCastAbility(self) then
		return "#dota_hud_error_ability_in_cooldown"
	end
	local config = self:GetAbilityConfig()
	if not (config and config.castError) then
		return BaseAbility.prototype.GetCustomCastErrorTarget(self, target)
	end
	return config:castError({ target = target })
end
function BaseAbility_CS.prototype.GetCustomCastErrorLocation(self, location)
	if IsServer() and MyGameAbilityChargeManager and not MyGameAbilityChargeManager:CanCastAbility(self) then
		return "#dota_hud_error_ability_in_cooldown"
	end
	local config = self:GetAbilityConfig()
	if not (config and config.castError) then
		return BaseAbility.prototype.GetCustomCastErrorLocation(self, location)
	end
	return config:castError({ point = location })
end
function BaseAbility_CS.prototype.Spawn(self)
	self._ability = self
	self._caster = self:GetCaster()
	self._parnet = self:GetCaster()
	if IsServer() then
		Timers:CreateTimer(FrameTime(), function()
			if not IsValid(nil, self) then
				return
			end
			if MyGameAbilityChargeManager ~= nil then
				MyGameAbilityChargeManager:RegisterAbility(self)
			end
		end)
	end
end
function BaseAbility_CS.prototype.FindUnitInRange(self, search_point, range, team)
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
function BaseAbility_CS.prototype.ApplyDamage(self, target, damage, damage_type, flag)
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
function BaseAbility_CS.prototype.GetSpecialValueFor(self, key)
	if not self:ShouldUseSeasonRuleset() then
		return BaseAbility.prototype.GetSpecialValueFor(self, key)
	end
	local rulesetValues = MyGameRulesetManager and MyGameRulesetManager:ResolveAbilityValues(self:GetAbilityName())
	if rulesetValues and rulesetValues.managed then
		return tonumber(rulesetValues.values[key]) or 0
	end
	return BaseAbility.prototype.GetSpecialValueFor(self, key)
end
function BaseAbility_CS.prototype.GetSpecialValue(self, abilityName, key)
	if IsClient() then
		return self:GetSpecialValueFor(key)
	end
	local ____opt_90 = self.GetCaster
	local caster = ____opt_90 and ____opt_90(self)
	local ____temp_92
	if caster and IsValid(nil, caster) and caster.IsHero then
		____temp_92 = caster:IsHero()
	else
		____temp_92 = false
	end
	local isHeroCaster = ____temp_92
	local ____table_IsItem_93
	if self.IsItem then
		____table_IsItem_93 = self:IsItem()
	else
		____table_IsItem_93 = false
	end
	local isItemAbility = ____table_IsItem_93
	if isHeroCaster and not isItemAbility then
		local baseValue = self:GetSpecialValueFor(key)
		local statKey = ResolveStatByAbilityValueKey(nil, tostring(key))
		if not statKey then
			return baseValue
		end
		return self:ResolveTagNumber(baseValue, statKey)
	end
	return self:GetSpecialValueFor(key)
end
function BaseAbility_CS.prototype.GetSpecialValueRaw(self, _abilityName, key)
	return self:GetSpecialValueFor(key)
end
function BaseAbility_CS.prototype.GetAllAttackDamage(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	return MyGameAttribute:GetAttribute(caster, "total_attack_damage")
end
function BaseAbility_CS.prototype.GetIntelligence(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	return MyGameAttribute:GetAttribute(caster, "total_intelligence")
end
function BaseAbility_CS.prototype.GetAnimationIgnoresModelScale(self)
	return true
end
BaseAbility_CS = __TS__DecorateLegacy({ registerAbility(nil) }, BaseAbility_CS)
____exports.BaseAbility_CS = BaseAbility_CS
return ____exports