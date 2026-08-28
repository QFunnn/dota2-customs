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
--- 必中
____exports.sl_modifier_cannot_miss = __TS__Class()
local sl_modifier_cannot_miss = ____exports.sl_modifier_cannot_miss
sl_modifier_cannot_miss.name = "sl_modifier_cannot_miss"
__TS__ClassExtends(sl_modifier_cannot_miss, SLModifierBase)
function sl_modifier_cannot_miss.prototype.CheckState(self)
	return { [MODIFIER_STATE_CANNOT_MISS] = true }
end
--- 无法闪避
____exports.sl_modifier_evade_disable = __TS__Class()
local sl_modifier_evade_disable = ____exports.sl_modifier_evade_disable
sl_modifier_evade_disable.name = "sl_modifier_evade_disable"
__TS__ClassExtends(sl_modifier_evade_disable, SLModifierBase)
function sl_modifier_evade_disable.prototype.CheckState(self)
	return { [MODIFIER_STATE_EVADE_DISABLED] = true }
end
--- 限制攻击距离
____exports.sl_modifier_override_attack_range = __TS__Class()
local sl_modifier_override_attack_range = ____exports.sl_modifier_override_attack_range
sl_modifier_override_attack_range.name = "sl_modifier_override_attack_range"
__TS__ClassExtends(sl_modifier_override_attack_range, SLModifierBase)
function sl_modifier_override_attack_range.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MAX_ATTACK_RANGE, MODIFIER_PROPERTY_ATTACK_RANGE_BONUS }
end
function sl_modifier_override_attack_range.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._range = params.range
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_override_attack_range.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	if not params then
		return
	end
	local ____params_range_0 = params.range
	if ____params_range_0 == nil then
		____params_range_0 = self._range
	end
	self._range = ____params_range_0
	self:SendBuffRefreshToClients()
end
function sl_modifier_override_attack_range.prototype.HandleCustomTransmitterData(self, data)
	self._range = data.range
end
function sl_modifier_override_attack_range.prototype.AddCustomTransmitterData(self)
	return { range = self._range }
end
function sl_modifier_override_attack_range.prototype.GetModifierMaxAttackRange(self)
	return self._range
end
function sl_modifier_override_attack_range.prototype.GetModifierAttackRangeBonus(self)
	return self._range
end
--- 承伤百分比 正值增伤，负值减伤
____exports.sl_modifier_damage_income = __TS__Class()
local sl_modifier_damage_income = ____exports.sl_modifier_damage_income
sl_modifier_damage_income.name = "sl_modifier_damage_income"
__TS__ClassExtends(sl_modifier_damage_income, SLModifierBase)
function sl_modifier_damage_income.prototype.OnCreated(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_damage_income.prototype.OnRefresh(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_damage_income.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	local value = params.value
	if not value then
		return
	end
	self._pct = value
end
function sl_modifier_damage_income.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_damage_income.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self._pct
end
--- 输出百分比 正值增伤 负值减伤
____exports.sl_modifier_damage_output = __TS__Class()
local sl_modifier_damage_output = ____exports.sl_modifier_damage_output
sl_modifier_damage_output.name = "sl_modifier_damage_output"
__TS__ClassExtends(sl_modifier_damage_output, SLModifierBase)
function sl_modifier_damage_output.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_damage_output.prototype.OnRefresh(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_damage_output.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	local value = params.value
	if not value then
		return
	end
	self._pct = value
	self:SendBuffRefreshToClients()
end
function sl_modifier_damage_output.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_damage_output.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	return self._pct
end
function sl_modifier_damage_output.prototype.HandleCustomTransmitterData(self, data)
	self._pct = data.value
end
function sl_modifier_damage_output.prototype.AddCustomTransmitterData(self)
	return { value = self._pct }
end
--- 输出百分比debuff  正值增伤 负值减伤
-- 默认隐藏，死亡移除，可驱散
____exports.sl_modifier_damage_output_debuff = __TS__Class()
local sl_modifier_damage_output_debuff = ____exports.sl_modifier_damage_output_debuff
sl_modifier_damage_output_debuff.name = "sl_modifier_damage_output_debuff"
__TS__ClassExtends(sl_modifier_damage_output_debuff, ____exports.sl_modifier_damage_output)
function sl_modifier_damage_output_debuff.prototype.IsDebuff(self)
	return true
end
function sl_modifier_damage_output_debuff.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_damage_output_debuff.prototype.IsPurgable(self)
	return true
end
function sl_modifier_damage_output_debuff.prototype.IsPermanent(self)
	return false
end
--- 绿字攻击力
____exports.sl_modifier_pre_attack_damage = __TS__Class()
local sl_modifier_pre_attack_damage = ____exports.sl_modifier_pre_attack_damage
sl_modifier_pre_attack_damage.name = "sl_modifier_pre_attack_damage"
__TS__ClassExtends(sl_modifier_pre_attack_damage, SLModifierBase)
function sl_modifier_pre_attack_damage.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_pre_attack_damage.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_pre_attack_damage.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_pre_attack_damage.prototype._ApplyParam(self, params)
	if self._params == nil then
		self._params = params
	end
	local ____self__params_2 = self._params
	local ____params_constant_1 = params.constant
	if ____params_constant_1 == nil then
		____params_constant_1 = self._params.constant
	end
	____self__params_2.constant = ____params_constant_1
	local ____self__params_4 = self._params
	local ____params_base_attack_pct_3 = params.base_attack_pct
	if ____params_base_attack_pct_3 == nil then
		____params_base_attack_pct_3 = self._params.base_attack_pct
	end
	____self__params_4.base_attack_pct = ____params_base_attack_pct_3
	self:SendBuffRefreshToClients()
end
function sl_modifier_pre_attack_damage.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_pre_attack_damage.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_pre_attack_damage.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____table__params_constant_5 = self._params
	if ____table__params_constant_5 ~= nil then
		____table__params_constant_5 = ____table__params_constant_5.constant
	end
	return ____table__params_constant_5
end
function sl_modifier_pre_attack_damage.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____table__params_base_attack_pct_7 = self._params
	if ____table__params_base_attack_pct_7 ~= nil then
		____table__params_base_attack_pct_7 = ____table__params_base_attack_pct_7.base_attack_pct
	end
	return ____table__params_base_attack_pct_7
end
--- 护盾
local sl_modifier_shield_base = __TS__Class()
sl_modifier_shield_base.name = "sl_modifier_shield_base"
__TS__ClassExtends(sl_modifier_shield_base, SLModifierBase)
function sl_modifier_shield_base.prototype.IsHidden(self)
	return true
end
function sl_modifier_shield_base.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_shield_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_shield_base.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_shield_base.prototype.GetCurrentShieldAmount(self)
	local ____table__params_shield_amount_9 = self._params
	if ____table__params_shield_amount_9 ~= nil then
		____table__params_shield_amount_9 = ____table__params_shield_amount_9.shield_amount
	end
	local ____table__params_shield_amount_9_11 = ____table__params_shield_amount_9
	if ____table__params_shield_amount_9_11 == nil then
		____table__params_shield_amount_9_11 = 0
	end
	return ____table__params_shield_amount_9_11
end
function sl_modifier_shield_base.prototype.GetMaxShieldAmount(self)
	local ____table__params_shield_amount_max_12 = self._params
	if ____table__params_shield_amount_max_12 ~= nil then
		____table__params_shield_amount_max_12 = ____table__params_shield_amount_max_12.shield_amount_max
	end
	local ____table__params_shield_amount_max_12_14 = ____table__params_shield_amount_max_12
	if ____table__params_shield_amount_max_12_14 == nil then
		____table__params_shield_amount_max_12_14 = 0
	end
	return ____table__params_shield_amount_max_12_14
end
function sl_modifier_shield_base.prototype._ApplyParam(self, params)
	if not params then
		return
	end
	if self._params == nil then
		self._params = params
	end
	local ____self__params_16 = self._params
	local ____params_shield_amount_max_15 = params.shield_amount_max
	if ____params_shield_amount_max_15 == nil then
		____params_shield_amount_max_15 = self._params.shield_amount_max
	end
	____self__params_16.shield_amount_max = ____params_shield_amount_max_15
	local ____self__params_19 = self._params
	local ____math_min_18 = math.min
	local ____params_shield_amount_17 = params.shield_amount
	if ____params_shield_amount_17 == nil then
		____params_shield_amount_17 = self._params.shield_amount_max
	end
	____self__params_19.shield_amount = ____math_min_18(____params_shield_amount_17, self._params.shield_amount_max)
	self:SendBuffRefreshToClients()
	if self.GetModifierIncomingDamageConstant then
		self:GetModifierIncomingDamageConstant(nil)
	end
	if self.GetModifierIncomingPhysicalDamageConstant then
		self:GetModifierIncomingPhysicalDamageConstant(nil)
	end
	if self.GetModifierIncomingSpellDamageConstant then
		self:GetModifierIncomingSpellDamageConstant(nil)
	end
end
function sl_modifier_shield_base.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_shield_base.prototype.HandleCustomTransmitterData(self, params)
	self._params = params
end
function sl_modifier_shield_base.prototype.GetModifierIncomingDamageConstant(self, event)
	return self:_OnShieldBlockDamage(event)
end
function sl_modifier_shield_base.prototype.GetModifierIncomingPhysicalDamageConstant(self, event)
	return self:_OnShieldBlockDamage(event)
end
function sl_modifier_shield_base.prototype.GetModifierIncomingSpellDamageConstant(self, event)
	return self:_OnShieldBlockDamage(event)
end
function sl_modifier_shield_base.prototype._OnShieldBlockDamage(self, event)
	if IsClient() then
		local ____event_report_max_20 = event
		if ____event_report_max_20 ~= nil then
			____event_report_max_20 = ____event_report_max_20.report_max
		end
		if ____event_report_max_20 then
			local ____table__params_shield_amount_max_22 = self._params
			if ____table__params_shield_amount_max_22 ~= nil then
				____table__params_shield_amount_max_22 = ____table__params_shield_amount_max_22.shield_amount_max
			end
			return ____table__params_shield_amount_max_22
		else
			local ____table__params_shield_amount_24 = self._params
			if ____table__params_shield_amount_24 ~= nil then
				____table__params_shield_amount_24 = ____table__params_shield_amount_24.shield_amount
			end
			return ____table__params_shield_amount_24
		end
	else
		if not event then
			return
		end
		local ____event_26 = event
		local damage = ____event_26.damage
		local target = ____event_26.target
		local parent = self:GetParent()
		if parent ~= target then
			return
		end
		local ____table__params_shield_amount_27 = self._params
		if ____table__params_shield_amount_27 ~= nil then
			____table__params_shield_amount_27 = ____table__params_shield_amount_27.shield_amount
		end
		local ____temp_31 = not ____table__params_shield_amount_27
		if not ____temp_31 then
			local ____table__params_shield_amount_29 = self._params
			if ____table__params_shield_amount_29 ~= nil then
				____table__params_shield_amount_29 = ____table__params_shield_amount_29.shield_amount
			end
			____temp_31 = ____table__params_shield_amount_29 <= 0
		end
		if ____temp_31 then
			return
		end
		local blocked_damage = damage
		local ____self__params_32, ____shield_amount_33 = self._params, "shield_amount"
		____self__params_32[____shield_amount_33] = ____self__params_32[____shield_amount_33] - damage
		if self._params.shield_amount <= 0 then
			blocked_damage = damage - math.abs(self._params.shield_amount)
			self:Destroy()
		end
		self:SendBuffRefreshToClients()
		return -blocked_damage
	end
end
--- 全护盾
____exports.sl_modifier_shield_all = __TS__Class()
local sl_modifier_shield_all = ____exports.sl_modifier_shield_all
sl_modifier_shield_all.name = "sl_modifier_shield_all"
__TS__ClassExtends(sl_modifier_shield_all, sl_modifier_shield_base)
function sl_modifier_shield_all.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT }
end
--- 物理护盾
____exports.sl_modifier_shield_physical = __TS__Class()
local sl_modifier_shield_physical = ____exports.sl_modifier_shield_physical
sl_modifier_shield_physical.name = "sl_modifier_shield_physical"
__TS__ClassExtends(sl_modifier_shield_physical, sl_modifier_shield_base)
function sl_modifier_shield_physical.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT }
end
--- 魔法护盾
____exports.sl_modifier_shield_spell = __TS__Class()
local sl_modifier_shield_spell = ____exports.sl_modifier_shield_spell
sl_modifier_shield_spell.name = "sl_modifier_shield_spell"
__TS__ClassExtends(sl_modifier_shield_spell, sl_modifier_shield_base)
function sl_modifier_shield_spell.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT }
end
--- 免疫伤害
____exports.sl_modifier_immune_damage = __TS__Class()
local sl_modifier_immune_damage = ____exports.sl_modifier_immune_damage
sl_modifier_immune_damage.name = "sl_modifier_immune_damage"
__TS__ClassExtends(sl_modifier_immune_damage, SLModifierBase)
function sl_modifier_immune_damage.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.damage_immune
end
function sl_modifier_immune_damage.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function sl_modifier_immune_damage.prototype.GetModifierAvoidDamage(self, event)
	if not IsServer() then
		return
	end
	local unit = event.target
	if unit == self:GetParent() then
		return 1
	end
end
--- 固定攻击间隔
____exports.sl_modifier_override_attack_rate = __TS__Class()
local sl_modifier_override_attack_rate = ____exports.sl_modifier_override_attack_rate
sl_modifier_override_attack_rate.name = "sl_modifier_override_attack_rate"
__TS__ClassExtends(sl_modifier_override_attack_rate, SLModifierBase)
function sl_modifier_override_attack_rate.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_override_attack_rate.prototype.OnRefresh(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_override_attack_rate.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	if not params.rate then
		return
	end
	self._rate = params.rate
	self:SendBuffRefreshToClients()
end
function sl_modifier_override_attack_rate.prototype.HandleCustomTransmitterData(self, data)
	self._rate = data.rate
end
function sl_modifier_override_attack_rate.prototype.AddCustomTransmitterData(self)
	return { rate = self._rate }
end
function sl_modifier_override_attack_rate.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_FIXED_ATTACK_RATE }
end
function sl_modifier_override_attack_rate.prototype.GetModifierFixedAttackRate(self)
	return self._rate
end
____exports.sl_modifier_invisible = __TS__Class()
local sl_modifier_invisible = ____exports.sl_modifier_invisible
sl_modifier_invisible.name = "sl_modifier_invisible"
__TS__ClassExtends(sl_modifier_invisible, SLModifierBase)
function sl_modifier_invisible.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("invisible_active")
end
function sl_modifier_invisible.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.invisible_start
end
function sl_modifier_invisible.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function sl_modifier_invisible.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVISIBLE] = true }
end
function sl_modifier_invisible.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
end
function sl_modifier_invisible.prototype.GetModifierInvisibilityLevel(self)
	return 1
end
function sl_modifier_invisible.prototype.GetDisableAutoAttack(self)
	return 1
end
function sl_modifier_invisible.prototype.OnAttack(self, event)
	if not IsServer() then
		return
	end
	if event.attacker == self:GetParent() then
		self:Destroy()
	end
end
function sl_modifier_invisible.prototype.OnAbilityFullyCast(self, event)
	if not IsServer() then
		return
	end
	if event.ability:GetCaster() == self:GetParent() then
		self:Destroy()
	end
end
--- 通用隐身（不破隐）
-- - 保留 sl_modifier_invisible 的隐身音效和特效
-- - 不禁用自动攻击
-- - 攻击和施法都不会解除隐身
____exports.sl_modifier_invisible_non_break = __TS__Class()
local sl_modifier_invisible_non_break = ____exports.sl_modifier_invisible_non_break
sl_modifier_invisible_non_break.name = "sl_modifier_invisible_non_break"
__TS__ClassExtends(sl_modifier_invisible_non_break, ____exports.sl_modifier_invisible)
function sl_modifier_invisible_non_break.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
____exports.sl_modifier_disable_healing = __TS__Class()
local sl_modifier_disable_healing = ____exports.sl_modifier_disable_healing
sl_modifier_disable_healing.name = "sl_modifier_disable_healing"
__TS__ClassExtends(sl_modifier_disable_healing, SLModifierBase)
function sl_modifier_disable_healing.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_HEALING }
end
function sl_modifier_disable_healing.prototype.GetDisableHealing(self)
	return 1
end
function sl_modifier_disable_healing.prototype.IsDebuff(self)
	return true
end
function sl_modifier_disable_healing.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.unheal_defbuff
end
function sl_modifier_disable_healing.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
____exports.sl_modifier_transmitter_data = __TS__Class()
local sl_modifier_transmitter_data = ____exports.sl_modifier_transmitter_data
sl_modifier_transmitter_data.name = "sl_modifier_transmitter_data"
__TS__ClassExtends(sl_modifier_transmitter_data, SLModifierBase)
function sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._min_interval = StaticFrameTime
	self._transmitter_counts = 0
	self._transmitter_counts_key = DoUniqueString("__transmitter_counts__")
end
function sl_modifier_transmitter_data.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_transmitter_data.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_transmitter_data.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	if not params then
		return
	end
	if params.update_data == nil then
		return
	end
	self._params = params
	if params.update_data == 1 then
		self:_QueueSendBuffRefreshToClients()
	end
end
function sl_modifier_transmitter_data.prototype._CanSendBuff(self)
	local now = GameRules:GetGameTime()
	if not self._last_send_data_time then
		return true
	end
	if now - self._last_send_data_time >= self._min_interval then
		return true
	end
	return false
end
function sl_modifier_transmitter_data.prototype._QueueSendBuffRefreshToClients(self)
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
function sl_modifier_transmitter_data.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_transmitter_data.prototype._SendBuffRefreshToClientsAndRecord(self)
	self._last_send_data_time = GameRules:GetGameTime()
	self._transmitter_counts = self._transmitter_counts + 1
	self:SendBuffRefreshToClients()
end
function sl_modifier_transmitter_data.prototype.AddCustomTransmitterData(self)
	if not self._params then
		return
	end
	self._params[self._transmitter_counts_key] = self._transmitter_counts
	return self._params
end
function sl_modifier_transmitter_data.prototype.GetCustomParam(self, key)
	return self._params[key]
end
--- 默认隐藏，死亡移除，可驱散
____exports.sl_modifier_transmitter_data_debuff = __TS__Class()
local sl_modifier_transmitter_data_debuff = ____exports.sl_modifier_transmitter_data_debuff
sl_modifier_transmitter_data_debuff.name = "sl_modifier_transmitter_data_debuff"
__TS__ClassExtends(sl_modifier_transmitter_data_debuff, ____exports.sl_modifier_transmitter_data)
function sl_modifier_transmitter_data_debuff.prototype.IsDebuff(self)
	return true
end
function sl_modifier_transmitter_data_debuff.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_transmitter_data_debuff.prototype.IsPurgable(self)
	return true
end
function sl_modifier_transmitter_data_debuff.prototype.IsPermanent(self)
	return false
end
____exports.sl_modifier_debuff_immune = __TS__Class()
local sl_modifier_debuff_immune = ____exports.sl_modifier_debuff_immune
sl_modifier_debuff_immune.name = "sl_modifier_debuff_immune"
__TS__ClassExtends(sl_modifier_debuff_immune, ____exports.sl_modifier_transmitter_data)
function sl_modifier_debuff_immune.prototype.CheckState(self)
	return { [MODIFIER_STATE_DEBUFF_IMMUNE] = true }
end
function sl_modifier_debuff_immune.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.debuff_immune
end
function sl_modifier_debuff_immune.prototype.GetStatusEffectName(self)
	return GENERIC_PARTICLES.debuff_immune_status_effect
end
function sl_modifier_debuff_immune.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
function sl_modifier_debuff_immune.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end
function sl_modifier_debuff_immune.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____table__params_magic_resist_34 = self._params
	if ____table__params_magic_resist_34 ~= nil then
		____table__params_magic_resist_34 = ____table__params_magic_resist_34.magic_resist
	end
	local ____table__params_magic_resist_34_36 = ____table__params_magic_resist_34
	if ____table__params_magic_resist_34_36 == nil then
		____table__params_magic_resist_34_36 = 0
	end
	return ____table__params_magic_resist_34_36
end
____exports.sl_modifier_debt_debuff = __TS__Class()
local sl_modifier_debt_debuff = ____exports.sl_modifier_debt_debuff
sl_modifier_debt_debuff.name = "sl_modifier_debt_debuff"
__TS__ClassExtends(sl_modifier_debt_debuff, SLModifierBase)
function sl_modifier_debt_debuff.prototype.IsDebuff(self)
	return true
end
function sl_modifier_debt_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_debt_debuff.prototype.GetTexture(self)
	return "buff/debt"
end
sl_modifier_debt_debuff =
	__TS__Decorate({ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_simple") }, sl_modifier_debt_debuff)
____exports.sl_modifier_debt_debuff = sl_modifier_debt_debuff
____exports.sl_modifier_ignore_attack_speed_limit = __TS__Class()
local sl_modifier_ignore_attack_speed_limit = ____exports.sl_modifier_ignore_attack_speed_limit
sl_modifier_ignore_attack_speed_limit.name = "sl_modifier_ignore_attack_speed_limit"
__TS__ClassExtends(sl_modifier_ignore_attack_speed_limit, SLModifierBase)
function sl_modifier_ignore_attack_speed_limit.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT }
end
function sl_modifier_ignore_attack_speed_limit.prototype.GetModifierAttackSpeed_Limit(self)
	if not IsServer() then
		return
	end
	return 1
end
sl_modifier_ignore_attack_speed_limit = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_simple") },
	sl_modifier_ignore_attack_speed_limit
)
____exports.sl_modifier_ignore_attack_speed_limit = sl_modifier_ignore_attack_speed_limit
____exports.sl_modifier_test = __TS__Class()
local sl_modifier_test = ____exports.sl_modifier_test
sl_modifier_test.name = "sl_modifier_test"
__TS__ClassExtends(sl_modifier_test, SLModifierBase)
function sl_modifier_test.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_FOW_TEAM }
end
function sl_modifier_test.prototype.CheckState(self)
	return { [MODIFIER_STATE_BLIND] = true }
end
function sl_modifier_test.prototype.GetModifierFoWTeam(self)
	print("1")
	return 1
end
sl_modifier_test =
	__TS__Decorate({ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_simple") }, sl_modifier_test)
____exports.sl_modifier_test = sl_modifier_test
return ____exports