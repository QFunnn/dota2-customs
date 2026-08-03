--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 自定义属性模块
____exports.sl_modifier_custom_attr = __TS__Class()
local sl_modifier_custom_attr = ____exports.sl_modifier_custom_attr
sl_modifier_custom_attr.name = "sl_modifier_custom_attr"
__TS__ClassExtends(sl_modifier_custom_attr, SLModifierBase)
function sl_modifier_custom_attr.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._attr_record = {
		sm = { need_calculate = true },
		smI = { need_calculate = true },
		mf = { need_calculate = true },
		mfI = { need_calculate = true },
		gjb = { send_to_client = true },
		gjl = { send_to_client = true },
		gjbI = { send_to_client = true },
		gjI = { send_to_client = true },
		jnzq = { send_to_client = true },
		hj = { send_to_client = true },
		mk = { send_to_client = true },
		xx = { send_to_client = true },
		jnxx = { send_to_client = true },
		qnxx = { send_to_client = true },
		yxxx = { send_to_client = true },
		yxjnxx = { send_to_client = true },
		yxqnxx = { send_to_client = true },
		shI = {},
		gsI = { send_to_client = true },
		gs = { send_to_client = true },
		lq = { send_to_client = true },
		ys = { send_to_client = true },
		ysI = { send_to_client = true },
		gjjl = { send_to_client = true },
		sb = { send_to_client = true },
		sfjl = { send_to_client = true },
		ll = { send_to_client = true, need_calculate = true },
		mj = { send_to_client = true, need_calculate = true },
		zl = { send_to_client = true, need_calculate = true },
		zsx = { send_to_client = true, need_calculate = true },
		qss = { send_to_client = true, need_calculate = true },
		fm = {},
		ztkx = { send_to_client = true },
		gjjg = { send_to_client = true },
		smhf = { send_to_client = true },
		smhfI = { send_to_client = true },
		smhfzqI = { send_to_client = true },
		mfhf = { send_to_client = true },
		mfhfzqI = { send_to_client = true },
		csshI = {},
		mxI = {},
		smhftzI = { send_to_client = true },
		cffyshI = nil,
		cfdjshI = nil,
		jnfw = nil,
		jnfwI = nil,
		fhsj = nil,
		fhsjI = nil,
		hxgjbl = nil,
		hxgjgl = nil,
		phcs = nil,
		phzs = nil,
		gangpct = nil,
	}
	self._primary_attribute = DOTA_ATTRIBUTE_INVALID
	self._cached_need_send_attrs = {}
	self._cached_custom_sync_funcs = __TS__New(Set)
	self._cached_need_calculate = false
	self._transmitter_counts = 0
	self._min_interval = StaticFrameTime
end
function sl_modifier_custom_attr.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
		MODIFIER_PROPERTY_MAGICAL_LIFESTEAL,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end
function sl_modifier_custom_attr.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent:IsHero() then
		return
	end
	self._primary_attribute = parent:GetPrimaryAttribute()
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_custom_attr.prototype.SetAttrValue(self, attr, value)
	self:SetAttrValueByTable({ [attr] = value })
end
function sl_modifier_custom_attr.prototype.SetAttrValueByTable(self, attr_table)
	if not IsServer() then
		SLError(nil, "sl_modifier_custom_attr: SetAttrValueByTable can only be called on server")
		return
	end
	local parent = self:GetParent()
	if not parent:IsHero() then
		SLError(nil, "sl_modifier_custom_attr: parent is not a hero")
		return
	end
	for key in pairs(attr_table) do
		do
			local attr_key = key
			local config = self._attr_record[attr_key]
			if not config then
				goto __continue10
			end
			local attr_value = attr_table[attr_key]
			config.value = attr_value
			if config.send_to_client then
				self:_PushRefresh(attr_key)
			end
			if config.need_calculate then
				self:_PushRefresh(true)
			end
			if config.custom_sync_func then
				self:_PushRefresh(config.custom_sync_func)
			end
		end
		::__continue10::
	end
end
function sl_modifier_custom_attr.prototype._PushRefresh(self, k1)
	if type(k1) == "boolean" then
		self._cached_need_calculate = k1
	elseif type(k1) == "string" then
		self._cached_need_send_attrs[k1] = true
	elseif type(k1) == "function" then
		self._cached_custom_sync_funcs:add(k1)
	else
		SLError(nil, "sl_modifier_custom_attr: invalid argument type")
	end
	if Timers:IsValid(self._send_buff_timer) then
		return
	end
	if self:_CanSendBuff() then
		self:_SendBuffRefreshToClientsAndRecord()
	else
		self._send_buff_timer = Timers:CreateTimer(function()
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
function sl_modifier_custom_attr.prototype._SendBuffRefreshToClientsAndRecord(self)
	self._transmitter_counts = self._transmitter_counts + 1
	self._last_send_data_time = GameRules:GetGameTime()
	self:SendBuffRefreshToClients()
end
function sl_modifier_custom_attr.prototype._CanSendBuff(self)
	local now = GameRules:GetGameTime()
	if not self._last_send_data_time then
		return true
	end
	if now - self._last_send_data_time >= self._min_interval then
		return true
	end
	return false
end
function sl_modifier_custom_attr.prototype.HandleCustomTransmitterData(self, data)
	local ____self__client_attr_record_0 = self._client_attr_record
	if ____self__client_attr_record_0 == nil then
		____self__client_attr_record_0 = { transmitter_counts = data.transmitter_counts }
	end
	self._client_attr_record = ____self__client_attr_record_0
	for key in pairs(data) do
		self._client_attr_record[key] = data[key]
	end
end
function sl_modifier_custom_attr.prototype.AddCustomTransmitterData(self)
	if self._cached_need_calculate then
		local parent = self:GetParent()
		if parent:IsHero() then
			parent:CalculateStatBonus(true)
		end
		self._cached_need_calculate = nil
	end
	for ____, func in __TS__Iterator(self._cached_custom_sync_funcs) do
		func(nil)
	end
	self._cached_custom_sync_funcs:clear()
	local data = { transmitter_counts = self._transmitter_counts }
	for key in pairs(self._cached_need_send_attrs) do
		local attr = key
		local value = self._attr_record[attr].value
		data[attr] = value
	end
	self._cached_need_send_attrs = {}
	return data
end
function sl_modifier_custom_attr.prototype._GetAttrValue(self, attr)
	if IsClient() then
		local ____table__client_attr_record_attr_1 = self._client_attr_record
		if ____table__client_attr_record_attr_1 ~= nil then
			____table__client_attr_record_attr_1 = ____table__client_attr_record_attr_1[attr]
		end
		return ____table__client_attr_record_attr_1
	else
		return self._attr_record[attr].value
	end
end
function sl_modifier_custom_attr.prototype.GetModifierHealthBonus(self)
	return self:_GetAttrValue("sm")
end
function sl_modifier_custom_attr.prototype.GetModifierExtraHealthPercentage(self)
	return self:_GetAttrValue("smI")
end
function sl_modifier_custom_attr.prototype.GetModifierManaBonus(self)
	return self:_GetAttrValue("mf")
end
function sl_modifier_custom_attr.prototype.GetModifierExtraManaPercentage(self)
	return self:_GetAttrValue("mfI")
end
function sl_modifier_custom_attr.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_GetAttrValue("gjb")
end
function sl_modifier_custom_attr.prototype.GetModifierPreAttack_BonusDamage(self)
	return self:_GetAttrValue("gjl")
end
function sl_modifier_custom_attr.prototype.GetModifierBaseDamageOutgoing_Percentage(self)
	return self:_GetAttrValue("gjbI")
end
function sl_modifier_custom_attr.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	return self:_GetAttrValue("gjI")
end
function sl_modifier_custom_attr.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ability = event.inflictor
	if IsServer() and IsValid(ability) then
		local ability_name = ability.GetAbilityName and ability:GetAbilityName()
		local ____ability_name_7 = ability_name
		if ____ability_name_7 then
			local ____HTTP_setting_GetServerSet_result_ability_name_5 =
				HTTP.setting:GetServerSet("abilitySpellAmplifyFix")
			if ____HTTP_setting_GetServerSet_result_ability_name_5 ~= nil then
				____HTTP_setting_GetServerSet_result_ability_name_5 =
					____HTTP_setting_GetServerSet_result_ability_name_5[ability_name]
			end
			local ____HTTP_setting_GetServerSet_result_ability_name_enable_3 =
				____HTTP_setting_GetServerSet_result_ability_name_5
			if ____HTTP_setting_GetServerSet_result_ability_name_enable_3 ~= nil then
				____HTTP_setting_GetServerSet_result_ability_name_enable_3 =
					____HTTP_setting_GetServerSet_result_ability_name_enable_3.enable
			end
			____ability_name_7 = ____HTTP_setting_GetServerSet_result_ability_name_enable_3 == 1
		end
		if ____ability_name_7 then
			local ____SLError_18 = SLError
			local ____ability_GetCaster_result_GetUnitName_result_8 = ability:GetCaster()
			if ____ability_GetCaster_result_GetUnitName_result_8 ~= nil then
				____ability_GetCaster_result_GetUnitName_result_8 =
					____ability_GetCaster_result_GetUnitName_result_8:GetUnitName()
			end
			local ____ability_GetCaster_result_GetUnitName_result_8_10 =
				____ability_GetCaster_result_GetUnitName_result_8
			if ____ability_GetCaster_result_GetUnitName_result_8_10 == nil then
				____ability_GetCaster_result_GetUnitName_result_8_10 = "unknown caster"
			end
			local ____event_attacker_GetUnitName_result_11 = event.attacker
			if ____event_attacker_GetUnitName_result_11 ~= nil then
				____event_attacker_GetUnitName_result_11 = ____event_attacker_GetUnitName_result_11:GetUnitName()
			end
			local ____event_attacker_GetUnitName_result_11_13 = ____event_attacker_GetUnitName_result_11
			if ____event_attacker_GetUnitName_result_11_13 == nil then
				____event_attacker_GetUnitName_result_11_13 = "unknown attacker"
			end
			local ____event_target_GetUnitName_17
			local ____event_target_GetUnitName_14 = event.target
			if ____event_target_GetUnitName_14 ~= nil then
				____event_target_GetUnitName_14 = ____event_target_GetUnitName_14.GetUnitName
			end
			if ____event_target_GetUnitName_14 then
				local ____temp_16 = event.target:GetUnitName()
				if ____temp_16 == nil then
					____temp_16 = "unknown target"
				end
				____event_target_GetUnitName_17 = ____temp_16
			else
				____event_target_GetUnitName_17 = "unknown target"
			end
			____SLError_18(
				nil,
				(
					(
						(
							(
								(ability_name .. " now can use spell amplify. ")
								.. ____ability_GetCaster_result_GetUnitName_result_8_10
							) .. " "
						) .. ____event_attacker_GetUnitName_result_11_13
					) .. " "
				) .. ____event_target_GetUnitName_17
			)
		end
	end
	return self:_GetAttrValue("jnzq")
end
function sl_modifier_custom_attr.prototype.GetModifierPhysicalArmorBonus(self, event)
	return self:_GetAttrValue("hj")
end
function sl_modifier_custom_attr.prototype.GetModifierMagicalResistanceBonus(self, event)
	return self:_GetAttrValue("mk")
end
function sl_modifier_custom_attr.prototype.OnTakeDamage(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local attacker = event.attacker
	local ability = event.inflictor
	local victim = event.unit
	if not IsValid(parent) or not IsValid(attacker) or not IsValid(victim) then
		return
	end
	if parent == attacker then
		local attackerTeam = attacker:GetTeamNumber()
		local victimTeam = victim:GetTeamNumber()
		local damage = event.damage
		local damageType = event.damage_type
		local damageCategory = event.damage_category
		local damageFlags = event.damage_flags
	end
end
function sl_modifier_custom_attr.prototype.GetModifierAttackSpeedPercentage(self)
	return self:_GetAttrValue("gsI")
end
function sl_modifier_custom_attr.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return self:_GetAttrValue("gs")
end
function sl_modifier_custom_attr.prototype.GetModifierPercentageCooldown(self)
	return self:_GetAttrValue("lq")
end
function sl_modifier_custom_attr.prototype.GetModifierMoveSpeedBonus_Constant(self)
	return self:_GetAttrValue("ys")
end
function sl_modifier_custom_attr.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	return self:_GetAttrValue("ysI")
end
function sl_modifier_custom_attr.prototype.GetModifierAttackRangeBonus(self)
	return self:_GetAttrValue("gjjl")
end
function sl_modifier_custom_attr.prototype.GetModifierEvasion_Constant(self, event)
	return self:_GetAttrValue("sb")
end
function sl_modifier_custom_attr.prototype.GetModifierCastRangeBonusStacking(self)
	return self:_GetAttrValue("sfjl")
end
function sl_modifier_custom_attr.prototype.GetModifierBonusStats_Strength(self)
	if not IsServer() then
		return 0
	end
	local value = 0
	if self._primary_attribute == DOTA_ATTRIBUTE_STRENGTH then
		local ____temp_19 = self:_GetAttrValue("zsx")
		if ____temp_19 == nil then
			____temp_19 = 0
		end
		value = value + ____temp_19
	elseif self._primary_attribute == DOTA_ATTRIBUTE_ALL then
		local ____temp_20 = self:_GetAttrValue("zsx")
		if ____temp_20 == nil then
			____temp_20 = 0
		end
		value = value + ____temp_20 * HTTP.setting:GetServerSet("gameBasic").UNIVERSAL_MAIN_STATS_PCT * 0.01
	end
	local ____temp_21 = self:_GetAttrValue("ll")
	if ____temp_21 == nil then
		____temp_21 = 0
	end
	local ____temp_22 = self:_GetAttrValue("qss")
	if ____temp_22 == nil then
		____temp_22 = 0
	end
	value = value + (____temp_21 + ____temp_22)
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierBonusStats_Agility(self)
	if not IsServer() then
		return 0
	end
	local value = 0
	if self._primary_attribute == DOTA_ATTRIBUTE_AGILITY then
		local ____temp_23 = self:_GetAttrValue("zsx")
		if ____temp_23 == nil then
			____temp_23 = 0
		end
		value = value + ____temp_23
	elseif self._primary_attribute == DOTA_ATTRIBUTE_ALL then
		local ____temp_24 = self:_GetAttrValue("zsx")
		if ____temp_24 == nil then
			____temp_24 = 0
		end
		value = value + ____temp_24 * HTTP.setting:GetServerSet("gameBasic").UNIVERSAL_MAIN_STATS_PCT * 0.01
	end
	local ____temp_25 = self:_GetAttrValue("mj")
	if ____temp_25 == nil then
		____temp_25 = 0
	end
	local ____temp_26 = self:_GetAttrValue("qss")
	if ____temp_26 == nil then
		____temp_26 = 0
	end
	value = value + (____temp_25 + ____temp_26)
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierBonusStats_Intellect(self)
	if not IsServer() then
		return 0
	end
	local value = 0
	if self._primary_attribute == DOTA_ATTRIBUTE_INTELLECT then
		local ____temp_27 = self:_GetAttrValue("zsx")
		if ____temp_27 == nil then
			____temp_27 = 0
		end
		value = value + ____temp_27
	elseif self._primary_attribute == DOTA_ATTRIBUTE_ALL then
		local ____temp_28 = self:_GetAttrValue("zsx")
		if ____temp_28 == nil then
			____temp_28 = 0
		end
		value = value + ____temp_28 * HTTP.setting:GetServerSet("gameBasic").UNIVERSAL_MAIN_STATS_PCT * 0.01
	end
	local ____temp_29 = self:_GetAttrValue("zl")
	if ____temp_29 == nil then
		____temp_29 = 0
	end
	local ____temp_30 = self:_GetAttrValue("qss")
	if ____temp_30 == nil then
		____temp_30 = 0
	end
	value = value + (____temp_29 + ____temp_30)
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierStatusResistanceStacking(self)
	return self:_GetAttrValue("ztkx")
end
function sl_modifier_custom_attr.prototype.GetModifierConstantHealthRegen(self)
	return self:_GetAttrValue("smhf")
end
function sl_modifier_custom_attr.prototype.GetModifierHealthRegenPercentage(self)
	return self:_GetAttrValue("smhfI")
end
function sl_modifier_custom_attr.prototype.GetModifierHPRegenAmplify_Percentage(self)
	return self:_GetAttrValue("smhfzqI")
end
function sl_modifier_custom_attr.prototype.GetModifierConstantManaRegen(self)
	return self:_GetAttrValue("mfhf")
end
function sl_modifier_custom_attr.prototype.GetModifierMPRegenAmplify_Percentage(self)
	return self:_GetAttrValue("mfhfzqI")
end
function sl_modifier_custom_attr.prototype.GetModifierIncomingDamage_Percentage(self)
	return self:_GetAttrValue("csshI")
end
function sl_modifier_custom_attr.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	return self:_GetAttrValue("shI")
end
function sl_modifier_custom_attr.prototype.GetModifierModelScale(self)
	return self:_GetAttrValue("mxI")
end
function sl_modifier_custom_attr.prototype.GetModifierProperty_PhysicalLifesteal(self, event)
	local ____temp_31 = self:_GetAttrValue("xx")
	if ____temp_31 == nil then
		____temp_31 = 0
	end
	local ____temp_32 = self:_GetAttrValue("qnxx")
	if ____temp_32 == nil then
		____temp_32 = 0
	end
	local value = ____temp_31 + ____temp_32
	if event.target:IsRealHero() then
		local ____temp_33 = self:_GetAttrValue("yxxx")
		if ____temp_33 == nil then
			____temp_33 = 0
		end
		local ____temp_34 = self:_GetAttrValue("yxqnxx")
		if ____temp_34 == nil then
			____temp_34 = 0
		end
		value = value + (____temp_33 + ____temp_34)
	end
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierProperty_MagicalLifesteal(self, event)
	local ____temp_35 = self:_GetAttrValue("jnxx")
	if ____temp_35 == nil then
		____temp_35 = 0
	end
	local ____temp_36 = self:_GetAttrValue("qnxx")
	if ____temp_36 == nil then
		____temp_36 = 0
	end
	local value = ____temp_35 + ____temp_36
	if event.target:IsRealHero() then
		local ____temp_37 = self:_GetAttrValue("yxjnxx")
		if ____temp_37 == nil then
			____temp_37 = 0
		end
		local ____temp_38 = self:_GetAttrValue("yxqnxx")
		if ____temp_38 == nil then
			____temp_38 = 0
		end
		value = value + (____temp_37 + ____temp_38)
	end
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierPropertyRestorationAmplification(self)
	return self:_GetAttrValue("smhftzI")
end
sl_modifier_custom_attr = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_custom_attr") },
	sl_modifier_custom_attr
)
____exports.sl_modifier_custom_attr = sl_modifier_custom_attr
return ____exports