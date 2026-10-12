--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_100383.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_100383.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:39",
		["18"] = "7:5",
		["19"] = "8:9",
		["20"] = "7:5",
		["21"] = "11:5",
		["22"] = "12:9",
		["23"] = "11:5",
		["24"] = "15:5",
		["25"] = "6:47",
		["26"] = "17:14",
		["29"] = "18:9",
		["30"] = "15:5",
		["31"] = "21:5",
		["32"] = "22:16",
		["33"] = "22:16",
		["34"] = "22:16",
		["36"] = "22:16",
		["38"] = "22:16",
		["40"] = "22:9",
		["41"] = "21:5",
		["42"] = "25:5",
		["43"] = "26:16",
		["44"] = "26:16",
		["45"] = "26:16",
		["47"] = "26:16",
		["49"] = "26:16",
		["51"] = "26:9",
		["52"] = "25:5",
		["53"] = "29:5",
		["54"] = "30:14",
		["57"] = "31:15",
		["58"] = "32:14",
		["61"] = "33:13",
		["62"] = "33:13",
		["63"] = "33:13",
		["65"] = "33:38",
		["66"] = "33:38",
		["67"] = "33:38",
		["69"] = "33:38",
		["71"] = "33:38",
		["73"] = "33:13",
		["74"] = "34:13",
		["75"] = "34:37",
		["76"] = "34:37",
		["77"] = "34:37",
		["79"] = "34:37",
		["81"] = "34:37",
		["83"] = "34:13",
		["84"] = "35:17",
		["85"] = "35:41",
		["86"] = "35:41",
		["87"] = "35:41",
		["89"] = "35:41",
		["91"] = "35:41",
		["93"] = "35:17",
		["94"] = "36:17",
		["95"] = "36:40",
		["96"] = "36:40",
		["97"] = "36:40",
		["99"] = "36:40",
		["101"] = "36:40",
		["103"] = "36:17",
		["106"] = "39:13",
		["107"] = "39:13",
		["108"] = "39:13",
		["110"] = "39:37",
		["111"] = "39:37",
		["112"] = "39:37",
		["114"] = "39:37",
		["116"] = "39:37",
		["118"] = "39:13",
		["119"] = "40:13",
		["120"] = "40:36",
		["121"] = "40:36",
		["122"] = "40:36",
		["124"] = "40:36",
		["126"] = "40:36",
		["128"] = "40:13",
		["129"] = "41:17",
		["130"] = "41:40",
		["131"] = "41:40",
		["132"] = "41:40",
		["134"] = "41:40",
		["136"] = "41:40",
		["138"] = "41:17",
		["139"] = "42:17",
		["140"] = "42:39",
		["141"] = "42:39",
		["142"] = "42:39",
		["144"] = "42:39",
		["146"] = "42:39",
		["148"] = "42:17",
		["151"] = "45:9",
		["152"] = "29:5",
		["153"] = "48:5",
		["154"] = "49:16",
		["155"] = "49:16",
		["156"] = "49:16",
		["158"] = "49:16",
		["160"] = "49:16",
		["162"] = "49:9",
		["163"] = "48:5",
		["164"] = "52:5",
		["165"] = "53:16",
		["166"] = "53:16",
		["167"] = "53:16",
		["169"] = "53:16",
		["171"] = "53:16",
		["173"] = "53:9",
		["174"] = "52:5",
		["175"] = "6:14",
		["176"] = "5:2",
		["177"] = "5:2",
		["178"] = "5:19",
		["179"] = "5:2",
		["181"] = "5:2",
		["182"] = "6:14",
		["184"] = "6:14",
	}
)
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100383", nil, getfenv()) },
	sl_modifier_bless_100383
)
____exports.sl_modifier_bless_100383 = sl_modifier_bless_100383
return ____exports