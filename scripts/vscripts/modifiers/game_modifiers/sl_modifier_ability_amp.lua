--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ABILITY_DAMAGE_SPECIAL_KEY = "AbilityDamage"
--- 技能增强buff
____exports.sl_modifier_ability_amp = __TS__Class()
local sl_modifier_ability_amp = ____exports.sl_modifier_ability_amp
sl_modifier_ability_amp.name = "sl_modifier_ability_amp"
__TS__ClassExtends(sl_modifier_ability_amp, SLModifierBase)
function sl_modifier_ability_amp.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._need_send_amp_record = false
	self._special_record = {}
	self._native_ability_damage_override_warning_record = {}
	self._special_record_refuse_list = {
		item_tpscroll = true,
		ability_capture = true,
		abyssal_underlord_portal_warp = true,
		twin_gate_portal_warp = true,
		ability_lamp_use = true,
	}
	self._special_attr_cached_table = {}
	self._attr_cached_send_keys = {}
	self._special_attr_calc_cb = {
		jnfw = function(____, original_value, attr)
			if original_value == 0 then
				return 0
			end
			return attr
		end,
		jnfwI = function(____, original_value, attr)
			if original_value == 0 then
				return 0
			end
			return original_value * (attr / 100)
		end,
		cfdjshI = function(____, original_value, attr)
			return original_value * (attr / 100)
		end,
	}
	self._min_interval = StaticFrameTime
	self._transmitter_counts = 0
end
function sl_modifier_ability_amp.prototype._FixedNumber(self, num, decimalPlaces)
	local multiplier = 10 ^ decimalPlaces
	return (math.floor(num * multiplier + 0.5) or 0) / multiplier
end
function sl_modifier_ability_amp.prototype._InitAbilityAmpRecord(self)
	self._amp_record = {}
end
function sl_modifier_ability_amp.prototype.RefreshPlayerAbilityAmp(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local player_id = parent:GetPlayerOwnerID()
	local record = SLModules.AbilityAmp:GetAbilityValueTableByPlayerID(player_id)
	self._amp_record = record
	self:_RefreshAmpCache()
	self._need_send_amp_record = true
	self:_QueueSendBuffRefreshToClients()
end
function sl_modifier_ability_amp.prototype._RefreshAmpCache(self)
	self._amp_cache = {}
	for key in pairs(self._amp_record) do
		local ability_name = key
		self._amp_cache[ability_name] = {}
		for special_key in pairs(self._amp_record[ability_name]) do
			self._amp_cache[ability_name][special_key] = {}
		end
	end
	self._total_cached_table = {}
end
function sl_modifier_ability_amp.prototype._FilterSpecialRecord(self, ability)
	if not IsValid(ability) then
		return false
	end
	if ability.IsAttributeBonus and ability:IsAttributeBonus() then
		return false
	end
	if self._special_record_refuse_list[ability:GetAbilityName()] then
		return false
	end
	return true
end
function sl_modifier_ability_amp.prototype.GetSpecialRecord(self)
	return self._special_record
end
function sl_modifier_ability_amp.prototype._WarnIfNativeAbilityDamageOverrideDetected(self, ability, special_key)
	if not IsServer() or special_key ~= ABILITY_DAMAGE_SPECIAL_KEY then
		return
	end
	local ability_name = ability:GetAbilityName()
	local ____table__amp_record_ability_name_2 = self._amp_record
	if ____table__amp_record_ability_name_2 ~= nil then
		____table__amp_record_ability_name_2 = ____table__amp_record_ability_name_2[ability_name]
	end
	local ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0 = ____table__amp_record_ability_name_2
	if ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0 ~= nil then
		____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0 =
			____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0[ABILITY_DAMAGE_SPECIAL_KEY]
	end
	if not ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0 then
		return
	end
	if self._native_ability_damage_override_warning_record[ability_name] then
		return
	end
	self._native_ability_damage_override_warning_record[ability_name] = true
	SLError(
		nil,
		"[AbilityDamageAmp][VALVE_NATIVE_OVERRIDE_DETECTED] 引擎已通过 modifier special value override 请求 "
			.. ((ability_name .. ".") .. ABILITY_DAMAGE_SPECIAL_KEY)
			.. "。当前 DamageFilter 补偿可能重复增伤，请立即复测并评估移除补偿。"
	)
end
function sl_modifier_ability_amp.prototype._CalculateAmpValueByType(
	self,
	amp_config,
	____type,
	target_level,
	default_value
)
	if default_value == nil then
		default_value = 0
	end
	if not amp_config[____type] then
		return default_value
	end
	local ____amp_config_____type_4 = amp_config[____type]
	local all_level_values = ____amp_config_____type_4.all_level_values
	local level_values = ____amp_config_____type_4.level_values
	local result = ____type == "c" and 0 or default_value
	if level_values and #level_values > 0 then
		local max_level = math.min(#level_values, target_level) - 1
		local ____level_values_index_5 = level_values[max_level + 1]
		if ____level_values_index_5 == nil then
			____level_values_index_5 = result
		end
		result = ____level_values_index_5
	end
	if all_level_values then
		if ____type == "c" then
			result = math.max(result, all_level_values)
		else
			result = result + all_level_values
		end
	end
	return result
end
function sl_modifier_ability_amp.prototype._AddCustomTransmitterDataForAbilityAmp(self)
	if not self._need_send_amp_record then
		return
	end
	self._need_send_amp_record = false
	return self._amp_record
end
function sl_modifier_ability_amp.prototype._HandleCustomTransmitterDataForAbilityAmp(self, data)
	if not data then
		return
	end
	self._amp_record = data
	self:_RefreshAmpCache()
end
function sl_modifier_ability_amp.prototype._FilterSpecialValueForAbilityAmp(self, ability, special_key)
	local ability_name = ability:GetAbilityName()
	if IsInToolsMode() then
		if self:_FilterSpecialRecord(ability) then
			local ____self__special_record_ability_name_6 = self._special_record[ability_name]
			if ____self__special_record_ability_name_6 == nil then
				____self__special_record_ability_name_6 = {}
			end
			local record = ____self__special_record_ability_name_6
			record[special_key] = true
			self._special_record[ability_name] = record
		end
	end
	if self._amp_record[ability_name] then
		if self._amp_record[ability_name][special_key] then
			return true
		end
	end
	return false
end
function sl_modifier_ability_amp.prototype._GetTotalBonusValueForAbilityAmp(
	self,
	ability,
	special_level,
	special_key,
	original_value
)
	local ability_name = ability:GetAbilityName()
	local cfg = self._amp_record[ability_name] and self._amp_record[ability_name][special_key]
	if not cfg then
		return original_value, 0
	end
	local cached_table = self._amp_cache[ability_name][special_key][special_level]
	if cached_table ~= nil and cached_table.original == original_value then
		return cached_table.override_origin, cached_table.cached
	else
		--- 目标等级（1=1级）
		local target_level = special_level + 1
		local ability_current_level = ability:GetLevel()
		if ability_current_level > target_level then
			local original_value_for_current =
				ability:GetLevelSpecialValueNoOverride(special_key, ability_current_level)
			if original_value_for_current == original_value then
				target_level = ability_current_level
			end
		end
		local actual_base = self:_CalculateAmpValueByType(cfg, "c", target_level, original_value)
		local actual_constant_bonus = self:_CalculateAmpValueByType(cfg, "b", target_level, 0)
		local actual_percent_bonus = self:_CalculateAmpValueByType(cfg, "a", target_level, 0)
		local total_bonus = self:_FixedNumber(actual_constant_bonus + actual_base * (actual_percent_bonus / 100), 2)
		if cached_table ~= nil then
			cached_table.cached = total_bonus
			cached_table.original = original_value
			cached_table.override_origin = actual_base
		else
			self._amp_cache[ability_name][special_key][special_level] =
				{ cached = total_bonus, original = original_value, override_origin = actual_base }
		end
		return actual_base, total_bonus
	end
end
function sl_modifier_ability_amp.prototype.GetAbilityDamageAmpFactor(self, ability)
	local ability_name = ability:GetAbilityName()
	local ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7 = self._amp_record[ability_name]
	if ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7 ~= nil then
		____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7 =
			____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7[ABILITY_DAMAGE_SPECIAL_KEY]
	end
	if not ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7 then
		return nil
	end
	local ability_level = ability:GetLevel()
	if ability_level <= 0 then
		return nil
	end
	local original_damage = ability:GetAbilityDamage()
	if original_damage <= 0 then
		return nil
	end
	local override_origin, amp_bonus =
		self:_GetTotalBonusValueForAbilityAmp(ability, ability_level - 1, ABILITY_DAMAGE_SPECIAL_KEY, original_damage)
	local modified_damage = math.max(override_origin + amp_bonus, 0)
	return modified_damage / original_damage
end
function sl_modifier_ability_amp.prototype._InitSpecialAttrOnCreated(self)
	if self._attr_value == nil then
		self._attr_value = { jnfw = 0, jnfwI = 0, cfdjshI = 0 }
	end
	if IsServer() then
		self._special_attr_relation_map = KvData.special_attr_kv_relation_map
	else
		self._special_attr_relation_map = CustomNetTables:GetTableValue("kv_data", "special_attr_kv_relation_map")
	end
end
function sl_modifier_ability_amp.prototype._GetPlayerAttrManager(self)
	local parent = self:GetParent()
	local player_id = parent:GetPlayerOwnerID()
	return GlobalAttrManager:Get(player_id)
end
function sl_modifier_ability_amp.prototype.RefreshSpecialAttr(self)
	if not IsServer() then
		return
	end
	local attr_manager = self:_GetPlayerAttrManager()
	if not attr_manager then
		return
	end
	local need_send = false
	for key in pairs(self._attr_value) do
		local attr_name = key
		local attr_value = self._attr_value[attr_name]
		local current_value = attr_manager:GetAttr(attr_name)
		if attr_value ~= current_value then
			self._attr_value[attr_name] = current_value
			local ____self__attr_cached_send_keys_9 = self._attr_cached_send_keys
			____self__attr_cached_send_keys_9[#____self__attr_cached_send_keys_9 + 1] = attr_name
			need_send = true
		end
	end
	if need_send then
		self:_RefreshSpecialAttrCache()
		self:_QueueSendBuffRefreshToClients()
	end
end
function sl_modifier_ability_amp.prototype._RefreshSpecialAttrCache(self)
	self._special_attr_cached_table = {}
	self._total_cached_table = {}
end
function sl_modifier_ability_amp.prototype._AddCustomTransmitterDataForSpecialAttr(self)
	local data = {}
	for ____, key in ipairs(self._attr_cached_send_keys) do
		data[key] = self._attr_value[key]
	end
	self._attr_cached_send_keys = {}
	return data
end
function sl_modifier_ability_amp.prototype._HandleCustomTransmitterDataForSpecialAttr(self, data)
	if not data then
		return
	end
	if self._attr_value == nil then
		self._attr_value = { jnfw = 0, jnfwI = 0, cfdjshI = 0 }
	end
	for key in pairs(data) do
		local attr_name = key
		local attr_value = data[attr_name]
		self._attr_value[attr_name] = attr_value
	end
	self:_RefreshSpecialAttrCache()
end
function sl_modifier_ability_amp.prototype._FilterSpecialValueForSpecialAttr(self, ability, special_key)
	local ability_name = ability:GetAbilityName()
	local map = self._special_attr_relation_map[ability_name]
	if map then
		if map[special_key] ~= nil then
			return true
		end
	end
	return false
end
function sl_modifier_ability_amp.prototype._GetTotalBonusValueForSpecialAttr(self, ability, special_key, original_value)
	local map = self._special_attr_relation_map
	local ability_name = ability:GetAbilityName()
	if not map[ability_name] or not map[ability_name][special_key] then
		return 0
	end
	local ____table__special_attr_cached_table_ability_name_special_key_10 =
		self._special_attr_cached_table[ability_name]
	if ____table__special_attr_cached_table_ability_name_special_key_10 ~= nil then
		____table__special_attr_cached_table_ability_name_special_key_10 =
			____table__special_attr_cached_table_ability_name_special_key_10[special_key]
	end
	local cached_value = ____table__special_attr_cached_table_ability_name_special_key_10
	if cached_value then
		return cached_value
	else
		local total_bonus = 0
		local relation_attrs = map[ability_name][special_key]
		for key in pairs(relation_attrs) do
			do
				local attr = key
				if self._attr_value[attr] == 0 then
					goto __continue78
				end
				local ____self_12 = self._special_attr_calc_cb
				total_bonus = total_bonus + ____self_12[attr](____self_12, original_value, self._attr_value[attr])
			end
			::__continue78::
		end
		local ____self__special_attr_cached_table_13, ____ability_name_14 =
			self._special_attr_cached_table, ability_name
		if ____self__special_attr_cached_table_13[____ability_name_14] == nil then
			____self__special_attr_cached_table_13[____ability_name_14] = {}
		end
		self._special_attr_cached_table[ability_name][special_key] = total_bonus
		return total_bonus
	end
end
function sl_modifier_ability_amp.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL, MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE }
end
function sl_modifier_ability_amp.prototype.OnCreated(self, params)
	if IsServer() then
		local parent = self:GetParent()
		if not parent:IsRealHero() then
			SLError(nil, "sl_modifier_ability_amp: 只有真英雄才能添加技能增强修饰器")
		end
	end
	self:_InitAbilityAmpRecord()
	self:_InitSpecialAttrOnCreated()
	self:SetHasCustomTransmitterData(true)
	self:RefreshPlayerAbilityAmp()
	self:RefreshSpecialAttr()
end
function sl_modifier_ability_amp.prototype._QueueSendBuffRefreshToClients(self)
	if Timers:IsValid(self._send_timer) then
		return
	end
	if self:_CanSendBuff() then
		self:_SendBuffRefreshToClientsAndRecord()
	else
		self._send_timer = Timers:CreateTimer(self._min_interval, function()
			if not IsValid(self) then
				return
			end
			if self:_CanSendBuff() then
				self:_SendBuffRefreshToClientsAndRecord()
				return nil
			else
				return self._min_interval
			end
		end)
	end
end
function sl_modifier_ability_amp.prototype._SendBuffRefreshToClientsAndRecord(self)
	self._last_send_data_time = GameRules:GetGameTime()
	self._transmitter_counts = self._transmitter_counts + 1
	self:SendBuffRefreshToClients()
end
function sl_modifier_ability_amp.prototype._CanSendBuff(self)
	local now = GameRules:GetGameTime()
	if not self._last_send_data_time then
		return true
	end
	if now - self._last_send_data_time >= self._min_interval then
		return true
	end
	return false
end
function sl_modifier_ability_amp.prototype.HandleCustomTransmitterData(self, data)
	self:_HandleCustomTransmitterDataForAbilityAmp(data.amp_record)
	self:_HandleCustomTransmitterDataForSpecialAttr(data.attr_table)
end
function sl_modifier_ability_amp.prototype.AddCustomTransmitterData(self)
	local data = {
		transmitter_counts = self._transmitter_counts,
		amp_record = self:_AddCustomTransmitterDataForAbilityAmp(),
		attr_table = self:_AddCustomTransmitterDataForSpecialAttr(),
	}
	return data
end
function sl_modifier_ability_amp.prototype.GetModifierOverrideAbilitySpecial(self, event)
	local ____event_15 = event
	local ability = ____event_15.ability
	local ability_special_value = ____event_15.ability_special_value
	self:_WarnIfNativeAbilityDamageOverrideDetected(ability, ability_special_value)
	if self:_FilterSpecialValueForAbilityAmp(ability, ability_special_value) then
		return 1
	elseif self:_FilterSpecialValueForSpecialAttr(ability, ability_special_value) then
		return 1
	end
	return 0
end
function sl_modifier_ability_amp.prototype.GetModifierOverrideAbilitySpecialValue(self, event)
	local ____event_16 = event
	local ability = ____event_16.ability
	local ability_special_level = ____event_16.ability_special_level
	local ability_special_value = ____event_16.ability_special_value
	self:_WarnIfNativeAbilityDamageOverrideDetected(ability, ability_special_value)
	local ability_name = ability:GetAbilityName()
	local ____table__total_cached_table_ability_name_ability_special_value_19 = self._total_cached_table[ability_name]
	if ____table__total_cached_table_ability_name_ability_special_value_19 ~= nil then
		____table__total_cached_table_ability_name_ability_special_value_19 =
			____table__total_cached_table_ability_name_ability_special_value_19[ability_special_value]
	end
	local ____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17 =
		____table__total_cached_table_ability_name_ability_special_value_19
	if ____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17 ~= nil then
		____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17 =
			____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17[ability_special_level]
	end
	local cached_value = ____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17
	if cached_value then
		return cached_value
	else
		local original_value = ability:GetLevelSpecialValueNoOverride(ability_special_value, ability_special_level)
		local override_origin, amp_bonus =
			self:_GetTotalBonusValueForAbilityAmp(ability, ability_special_level, ability_special_value, original_value)
		local special_attr_bonus =
			self:_GetTotalBonusValueForSpecialAttr(ability, ability_special_value, override_origin)
		local result = override_origin + amp_bonus + special_attr_bonus
		local ____self__total_cached_table_21, ____ability_name_22 = self._total_cached_table, ability_name
		if ____self__total_cached_table_21[____ability_name_22] == nil then
			____self__total_cached_table_21[____ability_name_22] = {}
		end
		local ____self__total_cached_table_ability_name_23, ____ability_special_value_24 =
			self._total_cached_table[ability_name], ability_special_value
		if ____self__total_cached_table_ability_name_23[____ability_special_value_24] == nil then
			____self__total_cached_table_ability_name_23[____ability_special_value_24] = {}
		end
		self._total_cached_table[ability_name][ability_special_value][ability_special_level] = result
		return result
	end
end
sl_modifier_ability_amp = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_ability_amp") },
	sl_modifier_ability_amp
)
____exports.sl_modifier_ability_amp = sl_modifier_ability_amp
return ____exports