--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10081_debuff.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10081_debuff.lua",
	{
		["13"] = "1:1",
		["14"] = "1:10",
		["15"] = "2:1",
		["16"] = "2:10",
		["19"] = "8:1",
		["20"] = "9:14",
		["21"] = "8:1",
		["22"] = "9:45",
		["23"] = "12:5",
		["24"] = "13:9",
		["25"] = "12:5",
		["26"] = "16:5",
		["27"] = "17:9",
		["28"] = "16:5",
		["29"] = "20:5",
		["30"] = "21:9",
		["31"] = "20:5",
		["32"] = "24:5",
		["33"] = "25:9",
		["34"] = "24:5",
		["35"] = "28:5",
		["36"] = "29:9",
		["37"] = "28:5",
		["38"] = "32:5",
		["39"] = "33:9",
		["40"] = "32:5",
		["41"] = "37:5",
		["42"] = "38:9",
		["43"] = "37:5",
		["44"] = "41:5",
		["45"] = "42:17",
		["47"] = "42:9",
		["48"] = "41:5",
		["49"] = "45:5",
		["50"] = "46:9",
		["51"] = "45:5",
		["52"] = "49:5",
		["53"] = "50:14",
		["56"] = "51:9",
		["57"] = "52:28",
		["58"] = "52:37",
		["59"] = "52:37",
		["60"] = "52:37",
		["62"] = "52:37",
		["64"] = "52:37",
		["66"] = "52:9",
		["67"] = "9:53",
		["68"] = "54:9",
		["69"] = "49:5",
		["70"] = "57:5",
		["71"] = "58:14",
		["74"] = "59:28",
		["75"] = "59:37",
		["76"] = "59:37",
		["77"] = "59:37",
		["79"] = "59:37",
		["81"] = "59:37",
		["83"] = "59:9",
		["84"] = "9:53",
		["85"] = "61:9",
		["86"] = "57:5",
		["87"] = "64:5",
		["88"] = "65:9",
		["89"] = "64:5",
		["90"] = "68:5",
		["91"] = "69:9",
		["92"] = "68:5",
		["93"] = "9:14",
		["94"] = "8:2",
		["95"] = "8:2",
		["96"] = "8:19",
		["97"] = "8:2",
		["99"] = "8:2",
		["100"] = "9:14",
		["102"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_damage_output_debuff = ____sl_modifier_simple.sl_modifier_damage_output_debuff
--- 福佑10081 对其他玩家的减伤debuff
-- 伤害输出 -dmg_reduce_pct%（负值）
____exports.sl_modifier_bless_10081_debuff = __TS__Class()
local sl_modifier_bless_10081_debuff = ____exports.sl_modifier_bless_10081_debuff
sl_modifier_bless_10081_debuff.name = "sl_modifier_bless_10081_debuff"
__TS__ClassExtends(sl_modifier_bless_10081_debuff, sl_modifier_damage_output_debuff)
function sl_modifier_bless_10081_debuff.prototype.IsPurgable(self)
	return false
end
function sl_modifier_bless_10081_debuff.prototype.IsPermanent(self)
	return true
end
function sl_modifier_bless_10081_debuff.prototype.RemoveOnDeath(self)
	return false
end
function sl_modifier_bless_10081_debuff.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_bless_10081_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10081_debuff.prototype.GetTexture(self)
	return "buff/bless/10081"
end
function sl_modifier_bless_10081_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10081_debuff.prototype.DeclareFunctions(self)
	local ____array_0 = __TS__SparseArrayNew(unpack(sl_modifier_damage_output_debuff.prototype.DeclareFunctions(self)))
	__TS__SparseArrayPush(____array_0, MODIFIER_PROPERTY_TOOLTIP)
	return { __TS__SparseArraySpread(____array_0) }
end
function sl_modifier_bless_10081_debuff.prototype.OnTooltip(self)
	return self._reduce_pct
end
function sl_modifier_bless_10081_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	local ____math_abs_4 = math.abs
	local ____params_value_1 = params
	if ____params_value_1 ~= nil then
		____params_value_1 = ____params_value_1.value
	end
	local ____params_value_1_3 = ____params_value_1
	if ____params_value_1_3 == nil then
		____params_value_1_3 = 0
	end
	self._reduce_pct = ____math_abs_4(____params_value_1_3)
	sl_modifier_damage_output_debuff.prototype.OnCreated(self, params)
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10081_debuff.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local ____math_abs_8 = math.abs
	local ____params_value_5 = params
	if ____params_value_5 ~= nil then
		____params_value_5 = ____params_value_5.value
	end
	local ____params_value_5_7 = ____params_value_5
	if ____params_value_5_7 == nil then
		____params_value_5_7 = 0
	end
	self._reduce_pct = ____math_abs_8(____params_value_5_7)
	sl_modifier_damage_output_debuff.prototype.OnRefresh(self, params)
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10081_debuff.prototype.HandleCustomTransmitterData(self, data)
	self._reduce_pct = data.value
end
function sl_modifier_bless_10081_debuff.prototype.AddCustomTransmitterData(self)
	return { value = self._reduce_pct }
end
sl_modifier_bless_10081_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10081_debuff", nil, getfenv()) },
	sl_modifier_bless_10081_debuff
)
____exports.sl_modifier_bless_10081_debuff = sl_modifier_bless_10081_debuff
return ____exports