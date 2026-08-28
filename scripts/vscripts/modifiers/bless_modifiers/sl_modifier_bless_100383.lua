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
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_100383 = __TS__Class()
local sl_modifier_bless_100383 = ____exports.sl_modifier_bless_100383
sl_modifier_bless_100383.name = "sl_modifier_bless_100383"
__TS__ClassExtends(sl_modifier_bless_100383, sl_modifier_transmitter_data)
function sl_modifier_bless_100383.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_100383.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_100383.prototype.OnCreated(self, params)
	sl_modifier_transmitter_data.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function sl_modifier_bless_100383.prototype.GetModifierAttackSpeedBonus_Constant(self)
	local ____table__params_as_cur_0 = self._params
	if ____table__params_as_cur_0 ~= nil then
		____table__params_as_cur_0 = ____table__params_as_cur_0.as_cur
	end
	local ____table__params_as_cur_0_2 = ____table__params_as_cur_0
	if ____table__params_as_cur_0_2 == nil then
		____table__params_as_cur_0_2 = 0
	end
	return ____table__params_as_cur_0_2
end
function sl_modifier_bless_100383.prototype.GetModifierDamageOutgoing_Percentage(self)
	local ____table__params_atk_cur_3 = self._params
	if ____table__params_atk_cur_3 ~= nil then
		____table__params_atk_cur_3 = ____table__params_atk_cur_3.atk_cur
	end
	local ____table__params_atk_cur_3_5 = ____table__params_atk_cur_3
	if ____table__params_atk_cur_3_5 == nil then
		____table__params_atk_cur_3_5 = 0
	end
	return ____table__params_atk_cur_3_5
end
function sl_modifier_bless_100383.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local ____table__params_atk_cur_6 = self._params
	if ____table__params_atk_cur_6 ~= nil then
		____table__params_atk_cur_6 = ____table__params_atk_cur_6.atk_cur
	end
	local ____table__params_atk_max_8 = self._params
	if ____table__params_atk_max_8 ~= nil then
		____table__params_atk_max_8 = ____table__params_atk_max_8.atk_max
	end
	local ____table__params_atk_max_8_10 = ____table__params_atk_max_8
	if ____table__params_atk_max_8_10 == nil then
		____table__params_atk_max_8_10 = 0
	end
	if ____table__params_atk_cur_6 < ____table__params_atk_max_8_10 then
		local ____self__params_14, ____atk_cur_15 = self._params, "atk_cur"
		local ____table__params_atk_sec_11 = self._params
		if ____table__params_atk_sec_11 ~= nil then
			____table__params_atk_sec_11 = ____table__params_atk_sec_11.atk_sec
		end
		local ____table__params_atk_sec_11_13 = ____table__params_atk_sec_11
		if ____table__params_atk_sec_11_13 == nil then
			____table__params_atk_sec_11_13 = 0
		end
		____self__params_14[____atk_cur_15] = ____self__params_14[____atk_cur_15] + ____table__params_atk_sec_11_13
		local ____self__params_atk_cur_19 = self._params.atk_cur
		local ____table__params_atk_max_16 = self._params
		if ____table__params_atk_max_16 ~= nil then
			____table__params_atk_max_16 = ____table__params_atk_max_16.atk_max
		end
		local ____table__params_atk_max_16_18 = ____table__params_atk_max_16
		if ____table__params_atk_max_16_18 == nil then
			____table__params_atk_max_16_18 = 0
		end
		if ____self__params_atk_cur_19 > ____table__params_atk_max_16_18 then
			local ____self__params_23 = self._params
			local ____table__params_atk_max_20 = self._params
			if ____table__params_atk_max_20 ~= nil then
				____table__params_atk_max_20 = ____table__params_atk_max_20.atk_max
			end
			local ____table__params_atk_max_20_22 = ____table__params_atk_max_20
			if ____table__params_atk_max_20_22 == nil then
				____table__params_atk_max_20_22 = 0
			end
			____self__params_23.atk_cur = ____table__params_atk_max_20_22
		end
	end
	local ____table__params_as_cur_24 = self._params
	if ____table__params_as_cur_24 ~= nil then
		____table__params_as_cur_24 = ____table__params_as_cur_24.as_cur
	end
	local ____table__params_as_max_26 = self._params
	if ____table__params_as_max_26 ~= nil then
		____table__params_as_max_26 = ____table__params_as_max_26.as_max
	end
	local ____table__params_as_max_26_28 = ____table__params_as_max_26
	if ____table__params_as_max_26_28 == nil then
		____table__params_as_max_26_28 = 0
	end
	if ____table__params_as_cur_24 < ____table__params_as_max_26_28 then
		local ____self__params_32, ____as_cur_33 = self._params, "as_cur"
		local ____table__params_as_sec_29 = self._params
		if ____table__params_as_sec_29 ~= nil then
			____table__params_as_sec_29 = ____table__params_as_sec_29.as_sec
		end
		local ____table__params_as_sec_29_31 = ____table__params_as_sec_29
		if ____table__params_as_sec_29_31 == nil then
			____table__params_as_sec_29_31 = 0
		end
		____self__params_32[____as_cur_33] = ____self__params_32[____as_cur_33] + ____table__params_as_sec_29_31
		local ____self__params_as_cur_37 = self._params.as_cur
		local ____table__params_as_max_34 = self._params
		if ____table__params_as_max_34 ~= nil then
			____table__params_as_max_34 = ____table__params_as_max_34.as_max
		end
		local ____table__params_as_max_34_36 = ____table__params_as_max_34
		if ____table__params_as_max_34_36 == nil then
			____table__params_as_max_34_36 = 0
		end
		if ____self__params_as_cur_37 > ____table__params_as_max_34_36 then
			local ____self__params_41 = self._params
			local ____table__params_as_max_38 = self._params
			if ____table__params_as_max_38 ~= nil then
				____table__params_as_max_38 = ____table__params_as_max_38.as_max
			end
			local ____table__params_as_max_38_40 = ____table__params_as_max_38
			if ____table__params_as_max_38_40 == nil then
				____table__params_as_max_38_40 = 0
			end
			____self__params_41.as_cur = ____table__params_as_max_38_40
		end
	end
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_100383.prototype.GetASCur(self)
	local ____table__params_as_cur_42 = self._params
	if ____table__params_as_cur_42 ~= nil then
		____table__params_as_cur_42 = ____table__params_as_cur_42.as_cur
	end
	local ____table__params_as_cur_42_44 = ____table__params_as_cur_42
	if ____table__params_as_cur_42_44 == nil then
		____table__params_as_cur_42_44 = 0
	end
	return ____table__params_as_cur_42_44
end
function sl_modifier_bless_100383.prototype.GetATKur(self)
	local ____table__params_atk_cur_45 = self._params
	if ____table__params_atk_cur_45 ~= nil then
		____table__params_atk_cur_45 = ____table__params_atk_cur_45.atk_cur
	end
	local ____table__params_atk_cur_45_47 = ____table__params_atk_cur_45
	if ____table__params_atk_cur_45_47 == nil then
		____table__params_atk_cur_45_47 = 0
	end
	return ____table__params_atk_cur_45_47
end
sl_modifier_bless_100383 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100383") },
	sl_modifier_bless_100383
)
____exports.sl_modifier_bless_100383 = sl_modifier_bless_100383
return ____exports