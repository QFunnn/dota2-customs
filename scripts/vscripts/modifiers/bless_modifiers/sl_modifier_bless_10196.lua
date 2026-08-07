--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10196_belly = __TS__Class()
local sl_modifier_bless_10196_belly = ____exports.sl_modifier_bless_10196_belly
sl_modifier_bless_10196_belly.name = "sl_modifier_bless_10196_belly"
__TS__ClassExtends(sl_modifier_bless_10196_belly, sl_modifier_transmitter_data)
function sl_modifier_bless_10196_belly.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._total_killed = 0
	self._last_sync_time = 0
end
function sl_modifier_bless_10196_belly.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10196_belly.prototype.GetTexture(self)
	return "buff/bless/10196"
end
function sl_modifier_bless_10196_belly.prototype.SetSourceBless(self, bless)
	self._source_bless = bless
end
function sl_modifier_bless_10196_belly.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_UNIT_MOVED,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_EVENT_ON_HERO_KILLED,
	}
end
function sl_modifier_bless_10196_belly.prototype.GetModifierIncomingDamage_Percentage(self, event)
	local ____table__params_csshI_0 = self._params
	if ____table__params_csshI_0 ~= nil then
		____table__params_csshI_0 = ____table__params_csshI_0.csshI
	end
	local ____table__params_csshI_0_2 = ____table__params_csshI_0
	if ____table__params_csshI_0_2 == nil then
		____table__params_csshI_0_2 = 0
	end
	return ____table__params_csshI_0_2 * self:GetStackCount()
end
function sl_modifier_bless_10196_belly.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_ms_3 = self._params
	if ____table__params_ms_3 ~= nil then
		____table__params_ms_3 = ____table__params_ms_3.ms
	end
	local ____table__params_ms_3_5 = ____table__params_ms_3
	if ____table__params_ms_3_5 == nil then
		____table__params_ms_3_5 = 0
	end
	return ____table__params_ms_3_5 * self:GetStackCount()
end
function sl_modifier_bless_10196_belly.prototype.GetModifierModelScale(self)
	return 5 * self:GetStackCount()
end
function sl_modifier_bless_10196_belly.prototype.OnTooltip(self)
	local ____table__params_total_moved_6 = self._params
	if ____table__params_total_moved_6 ~= nil then
		____table__params_total_moved_6 = ____table__params_total_moved_6.total_moved
	end
	local ____table__params_total_moved_6_8 = ____table__params_total_moved_6
	if ____table__params_total_moved_6_8 == nil then
		____table__params_total_moved_6_8 = 0
	end
	return ____table__params_total_moved_6_8
end
function sl_modifier_bless_10196_belly.prototype.OnTooltip2(self)
	local ____table__params_move_9 = self._params
	if ____table__params_move_9 ~= nil then
		____table__params_move_9 = ____table__params_move_9.move
	end
	return ____table__params_move_9
end
function sl_modifier_bless_10196_belly.prototype.OnUnitMoved(self, event)
	if not IsServer() then
		return
	end
	local ____event_11 = event
	local unit = ____event_11.unit
	local parent = self:GetParent()
	if unit ~= parent then
		return
	end
	local move_speed = unit:GetMoveSpeedModifier(unit:GetBaseMoveSpeed(), false)
	local moved_distance = move_speed * FrameTime()
	local ____self__params_12, ____total_moved_13 = self._params, "total_moved"
	____self__params_12[____total_moved_13] = ____self__params_12[____total_moved_13] + moved_distance
	local ____table__params_move_14 = self._params
	if ____table__params_move_14 ~= nil then
		____table__params_move_14 = ____table__params_move_14.move
	end
	if ____table__params_move_14 ~= nil and self:GetStackCount() > 0 then
		if self._params.move <= 0 then
			if IsServer() then
				SLError(nil, "bless_10196_belly move <= 0")
			end
			return
		end
		while self._params.total_moved >= self._params.move do
			local ____self__params_16, ____total_moved_17 = self._params, "total_moved"
			____self__params_16[____total_moved_17] = ____self__params_16[____total_moved_17] - self._params.move
			self:_LostOneStackBelly()
		end
	end
	local now = GameRules:GetGameTime()
	if now - self._last_sync_time >= 0.5 then
		self._last_sync_time = now
		self:_SendBuffRefreshToClientsAndRecord()
	end
end
function sl_modifier_bless_10196_belly.prototype.OnHeroKilled(self, event)
	if not IsServer() then
		return
	end
	local ____event_18 = event
	local attacker = ____event_18.attacker
	local target = ____event_18.target
	local parent = self:GetParent()
	if attacker == parent and self:GetStackCount() > 0 then
		self._total_killed = self._total_killed + 1
		self:_LostOneStackBelly()
	end
end
function sl_modifier_bless_10196_belly.prototype._LostOneStackBelly(self)
	if not IsServer() then
		return
	end
	if self:GetStackCount() <= 0 then
		SLError(nil, "stack <= 0 befroe lost")
	end
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		if self._source_bless and self._source_bless:IsValid() then
			self._source_bless:OnLoseAllBellies(self:GetParent(), self._total_killed)
		end
		self:Destroy()
	end
end
sl_modifier_bless_10196_belly = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10196") },
	sl_modifier_bless_10196_belly
)
____exports.sl_modifier_bless_10196_belly = sl_modifier_bless_10196_belly
____exports.sl_modifier_bless_10196_muscle = __TS__Class()
local sl_modifier_bless_10196_muscle = ____exports.sl_modifier_bless_10196_muscle
sl_modifier_bless_10196_muscle.name = "sl_modifier_bless_10196_muscle"
__TS__ClassExtends(sl_modifier_bless_10196_muscle, sl_modifier_transmitter_data)
function sl_modifier_bless_10196_muscle.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10196_muscle.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10196_muscle.prototype.GetTexture(self)
	return "buff/bless/10196_muscle"
end
function sl_modifier_bless_10196_muscle.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end
function sl_modifier_bless_10196_muscle.prototype.GetModifierExtraHealthPercentage(self)
	local ____table__params_pct_19 = self._params
	if ____table__params_pct_19 ~= nil then
		____table__params_pct_19 = ____table__params_pct_19.pct
	end
	local ____table__params_pct_19_21 = ____table__params_pct_19
	if ____table__params_pct_19_21 == nil then
		____table__params_pct_19_21 = 0
	end
	return ____table__params_pct_19_21 * self:GetStackCount()
end
function sl_modifier_bless_10196_muscle.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_pct_22 = self._params
	if ____table__params_pct_22 ~= nil then
		____table__params_pct_22 = ____table__params_pct_22.pct
	end
	local ____table__params_pct_22_24 = ____table__params_pct_22
	if ____table__params_pct_22_24 == nil then
		____table__params_pct_22_24 = 0
	end
	return ____table__params_pct_22_24 * self:GetStackCount()
end
function sl_modifier_bless_10196_muscle.prototype.GetModifierAttackSpeedPercentage(self)
	local ____table__params_pct_25 = self._params
	if ____table__params_pct_25 ~= nil then
		____table__params_pct_25 = ____table__params_pct_25.pct
	end
	local ____table__params_pct_25_27 = ____table__params_pct_25
	if ____table__params_pct_25_27 == nil then
		____table__params_pct_25_27 = 0
	end
	return ____table__params_pct_25_27 * self:GetStackCount()
end
function sl_modifier_bless_10196_muscle.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_28 = self._params
	if ____table__params_pct_28 ~= nil then
		____table__params_pct_28 = ____table__params_pct_28.pct
	end
	local ____table__params_pct_28_30 = ____table__params_pct_28
	if ____table__params_pct_28_30 == nil then
		____table__params_pct_28_30 = 0
	end
	return ____table__params_pct_28_30 * self:GetStackCount()
end
sl_modifier_bless_10196_muscle = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10196") },
	sl_modifier_bless_10196_muscle
)
____exports.sl_modifier_bless_10196_muscle = sl_modifier_bless_10196_muscle
return ____exports