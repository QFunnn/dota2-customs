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
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____base_ability = require("abilities._base.base_ability")
local BaseAbility_CS = ____base_ability.BaseAbility_CS
--- 文件内共用：按队伍+范围查找可见的敌方英雄/小兵，编译后为同一份 local 函数，不污染全局
local function findMonsterEnemies(self, teamNumber, searchPoint, radius)
	return FindUnitsInRadius(
		teamNumber,
		searchPoint,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_CAN_BE_SEEN + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
end
____exports.BaseHeroAbility = __TS__Class()
local BaseHeroAbility = ____exports.BaseHeroAbility
BaseHeroAbility.name = "BaseHeroAbility"
__TS__ClassExtends(BaseHeroAbility, BaseAbility_CS)
function BaseHeroAbility.prototype.FindMonsterEnemies(self, searchPoint, radius)
	return findMonsterEnemies(nil, self._caster:GetTeamNumber(), searchPoint, radius)
end
function BaseHeroAbility.prototype.ForceSyncResolvedStats(self, stats)
	if not IsServer() then
		return
	end
	local ____opt_0 = self.GetCaster
	local caster = ____opt_0 and ____opt_0(self)
	if not caster or not IsValid(nil, caster) or not caster:IsHero() then
		return
	end
	self.resolvedStatSyncBatch = {}
	do
		pcall(function()
			local normalizedLevel = self:NormalizeSyncLevel(self:GetLevel() - 1)
			if self:ShouldForceSyncResolvedStat(7, stats) then
				self:GetCooldown(normalizedLevel)
			end
			if self:ShouldForceSyncResolvedStat(6, stats) then
				self:GetManaCost(normalizedLevel)
			end
			if self:ShouldForceSyncResolvedStat(9, stats) then
				self:GetCastPoint()
			end
			if self:ShouldForceSyncResolvedStat(8, stats) then
				self:GetCastRange(caster:GetAbsOrigin(), nil)
			end
			if self:ShouldForceSyncResolvedStat(17, stats) or self:ShouldForceSyncResolvedStat(16, stats) then
				if MyGameAbilityChargeManager ~= nil then
					MyGameAbilityChargeManager:RefreshAbility(self)
				end
			end
		end)
		do
			local batch = self.resolvedStatSyncBatch
			self.resolvedStatSyncBatch = nil
			if batch and #__TS__ObjectKeys(batch) > 0 then
				if MyGameNetTableContentManager ~= nil then
					MyGameNetTableContentManager:SetResolvedStats(caster, self, batch)
				end
			end
		end
	end
end
function BaseHeroAbility.prototype.GetCooldown(self, level)
	if IsServer() and (MyGameAbilityChargeManager and MyGameAbilityChargeManager:IsCustomChargeAbility(self)) then
		return MyGameAbilityChargeManager:GetReleaseInterval()
	end
	local baseCooldown = self:GetBaseCooldownValue(level)
	local syncKey = self:GetResolvedStatSyncKey("cooldown", level)
	if IsClient() then
		return self:ReadResolvedStatSyncValue(syncKey, baseCooldown)
	end
	local resolved = self:ResolveTagNumber(baseCooldown, 7)
	self:WriteResolvedStatSyncValue(syncKey, resolved)
	return resolved
end
function BaseHeroAbility.prototype.GetManaCost(self, level)
	local baseManaCost = self:GetBaseManaCostValue(level)
	local syncKey = self:GetResolvedStatSyncKey("mana_cost", level)
	if IsClient() then
		return self:ReadResolvedStatSyncValue(syncKey, baseManaCost)
	end
	local resolved = self:ResolveTagNumber(baseManaCost, 6)
	self:WriteResolvedStatSyncValue(syncKey, resolved)
	return resolved
end
function BaseHeroAbility.prototype.GetCastPoint(self)
	local baseCastPoint = self:GetBaseCastPointValue()
	local syncKey = self:GetResolvedStatSyncKey("cast_point")
	if IsClient() then
		return self:ReadResolvedStatSyncValue(syncKey, baseCastPoint)
	end
	local resolved = self:ResolveTagNumber(baseCastPoint, 9)
	self:WriteResolvedStatSyncValue(syncKey, resolved)
	return resolved
end
function BaseHeroAbility.prototype.GetCastRange(self, location, target)
	local baseCastRange = self:GetBaseCastRangeValue(location, target)
	local syncKey = self:GetResolvedStatSyncKey("cast_range")
	if IsClient() then
		return self:ReadResolvedStatSyncValue(syncKey, baseCastRange)
	end
	local resolved = self:ResolveTagNumber(baseCastRange, 8)
	self:WriteResolvedStatSyncValue(syncKey, resolved)
	return resolved
end
function BaseHeroAbility.prototype.Spawn(self)
	BaseAbility_CS.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(nil, self) then
			return
		end
		self:ForceSyncResolvedStats()
	end)
end
function BaseHeroAbility.prototype.GetResolvedStatSyncKey(self, stat, level)
	local normalizedLevel = self:NormalizeSyncLevel(level)
	local ____temp_8
	if normalizedLevel ~= nil then
		____temp_8 = "_lv_" .. tostring(normalizedLevel)
	else
		____temp_8 = ""
	end
	local levelSuffix = ____temp_8
	return ((((("resolved_stat_" .. self:GetAbilityName()) .. "_") .. tostring(self:entindex())) .. "_") .. stat)
		.. levelSuffix
end
function BaseHeroAbility.prototype.NormalizeSyncLevel(self, level)
	if level == nil or level == nil then
		return 0
	end
	return math.max(0, math.floor(level))
end
function BaseHeroAbility.prototype.ReadResolvedStatSyncValue(self, syncKey, fallback)
	local ____opt_9 = self.GetCaster
	local caster = ____opt_9 and ____opt_9(self)
	if not caster or caster:IsNull() then
		return fallback
	end
	local tableKey = tostring(caster:entindex())
	local syncedTable = CustomNetTables:GetTableValue("unit_custom_value_sync", tableKey)
	local ____opt_11 = caster.GetCustomValue
	local ____temp_15 = ____opt_11 and ____opt_11(caster, syncKey) or syncedTable and syncedTable[syncKey]
	if ____temp_15 == nil then
		____temp_15 = fallback
	end
	local sourceValue = ____temp_15
	local value = tonumber(sourceValue)
	local ____isFinite_result_16
	if __TS__NumberIsFinite(__TS__Number(value)) then
		____isFinite_result_16 = value
	else
		____isFinite_result_16 = fallback
	end
	return ____isFinite_result_16
end
function BaseHeroAbility.prototype.WriteResolvedStatSyncValue(self, syncKey, value)
	local ____opt_17 = self.GetCaster
	local caster = ____opt_17 and ____opt_17(self)
	if not caster or not IsValid(nil, caster) or not caster:IsHero() then
		return
	end
	if self.resolvedStatSyncBatch then
		self.resolvedStatSyncBatch[syncKey] = value
		return
	end
	if MyGameNetTableContentManager ~= nil then
		MyGameNetTableContentManager:SetResolvedStat(caster, self, syncKey, value)
	end
end
function BaseHeroAbility.prototype.ShouldForceSyncResolvedStat(self, stat, stats)
	return not stats or #stats == 0 or __TS__ArrayIndexOf(stats, stat) >= 0
end
BaseHeroAbility = __TS__DecorateLegacy({ registerAbility(nil) }, BaseHeroAbility)
____exports.BaseHeroAbility = BaseHeroAbility
____exports.BaseHeroModifier = __TS__Class()
local BaseHeroModifier = ____exports.BaseHeroModifier
BaseHeroModifier.name = "BaseHeroModifier"
__TS__ClassExtends(BaseHeroModifier, BaseModifier_CS)
function BaseHeroModifier.prototype.GetModifierConfig(self)
	return nil
end
function BaseHeroModifier.prototype.IsHidden(self)
	local config = self:GetModifierConfig()
	local ____config_21
	if config then
		____config_21 = config.isHidden
	else
		____config_21 = BaseModifier_CS.prototype.IsHidden(self)
	end
	return ____config_21
end
function BaseHeroModifier.prototype.IsDebuff(self)
	local config = self:GetModifierConfig()
	local ____config_22
	if config then
		____config_22 = config.isDebuff
	else
		____config_22 = BaseModifier_CS.prototype.IsDebuff(self)
	end
	return ____config_22
end
function BaseHeroModifier.prototype.IsPurgable(self)
	local config = self:GetModifierConfig()
	local ____config_23
	if config then
		____config_23 = config.isPurgable
	else
		____config_23 = BaseModifier_CS.prototype.IsPurgable(self)
	end
	return ____config_23
end
function BaseHeroModifier.prototype.IsPurgeException(self)
	local config = self:GetModifierConfig()
	local ____config_24
	if config then
		____config_24 = config.isPurgeException
	else
		____config_24 = BaseModifier_CS.prototype.IsPurgeException(self)
	end
	return ____config_24
end
function BaseHeroModifier.prototype.GetAttributes(self)
	local config = self:GetModifierConfig()
	local ____config_26
	if config then
		local ____config_isMultiple_25
		if config.isMultiple then
			____config_isMultiple_25 = MODIFIER_ATTRIBUTE_MULTIPLE
		else
			____config_isMultiple_25 = BaseModifier_CS.prototype.GetAttributes(self)
		end
		____config_26 = ____config_isMultiple_25
	else
		____config_26 = BaseModifier_CS.prototype.GetAttributes(self)
	end
	return ____config_26
end
function BaseHeroModifier.prototype.FindMonsterEnemies(self, searchPoint, radius)
	return findMonsterEnemies(nil, self._parent:GetTeamNumber(), searchPoint, radius)
end
BaseHeroModifier = __TS__DecorateLegacy({ registerModifier(nil) }, BaseHeroModifier)
____exports.BaseHeroModifier = BaseHeroModifier
return ____exports