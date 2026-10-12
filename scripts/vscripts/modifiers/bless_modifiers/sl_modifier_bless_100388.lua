--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_100388.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_100388.lua",
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
		["25"] = "16:9",
		["26"] = "15:5",
		["27"] = "19:5",
		["28"] = "20:16",
		["29"] = "20:16",
		["30"] = "20:16",
		["32"] = "20:16",
		["34"] = "20:16",
		["36"] = "20:9",
		["37"] = "19:5",
		["38"] = "23:5",
		["39"] = "24:16",
		["40"] = "24:16",
		["41"] = "24:16",
		["43"] = "24:16",
		["45"] = "24:16",
		["47"] = "24:9",
		["48"] = "23:5",
		["49"] = "27:5",
		["50"] = "29:18",
		["51"] = "29:18",
		["52"] = "29:18",
		["54"] = "29:18",
		["56"] = "29:18",
		["58"] = "30:17",
		["59"] = "30:17",
		["60"] = "30:17",
		["62"] = "30:17",
		["64"] = "30:17",
		["66"] = "28:9",
		["67"] = "27:5",
		["68"] = "34:5",
		["69"] = "35:9",
		["70"] = "35:29",
		["72"] = "35:29",
		["74"] = "35:9",
		["75"] = "36:9",
		["76"] = "36:28",
		["78"] = "36:28",
		["80"] = "36:9",
		["81"] = "37:9",
		["82"] = "38:9",
		["83"] = "39:10",
		["84"] = "34:5",
		["85"] = "6:14",
		["86"] = "5:2",
		["87"] = "5:2",
		["88"] = "5:19",
		["89"] = "5:2",
		["91"] = "5:2",
		["92"] = "6:14",
		["94"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_100388 = __TS__Class()
local sl_modifier_bless_100388 = ____exports.sl_modifier_bless_100388
sl_modifier_bless_100388.name = "sl_modifier_bless_100388"
__TS__ClassExtends(sl_modifier_bless_100388, sl_modifier_transmitter_data)
function sl_modifier_bless_100388.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_100388.prototype.GetTexture(self)
	return "buff/bless/100388"
end
function sl_modifier_bless_100388.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_HEALTH_BONUS }
end
function sl_modifier_bless_100388.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____table__params_atk_0 = self._params
	if ____table__params_atk_0 ~= nil then
		____table__params_atk_0 = ____table__params_atk_0.atk
	end
	local ____table__params_atk_0_2 = ____table__params_atk_0
	if ____table__params_atk_0_2 == nil then
		____table__params_atk_0_2 = 0
	end
	return ____table__params_atk_0_2
end
function sl_modifier_bless_100388.prototype.GetModifierHealthBonus(self)
	local ____table__params_hp_3 = self._params
	if ____table__params_hp_3 ~= nil then
		____table__params_hp_3 = ____table__params_hp_3.hp
	end
	local ____table__params_hp_3_5 = ____table__params_hp_3
	if ____table__params_hp_3_5 == nil then
		____table__params_hp_3_5 = 0
	end
	return ____table__params_hp_3_5
end
function sl_modifier_bless_100388.prototype.GetBonusStats(self)
	local ____table__params_atk_6 = self._params
	if ____table__params_atk_6 ~= nil then
		____table__params_atk_6 = ____table__params_atk_6.atk
	end
	local ____table__params_atk_6_8 = ____table__params_atk_6
	if ____table__params_atk_6_8 == nil then
		____table__params_atk_6_8 = 0
	end
	local ____table__params_hp_9 = self._params
	if ____table__params_hp_9 ~= nil then
		____table__params_hp_9 = ____table__params_hp_9.hp
	end
	local ____table__params_hp_9_11 = ____table__params_hp_9
	if ____table__params_hp_9_11 == nil then
		____table__params_hp_9_11 = 0
	end
	return { atk = ____table__params_atk_6_8, hp = ____table__params_hp_9_11 }
end
function sl_modifier_bless_100388.prototype.AddBonusStats(self, atk, hp)
	local ____self__params_13 = self._params
	local ____self__params_atk_12 = self._params.atk
	if ____self__params_atk_12 == nil then
		____self__params_atk_12 = 0
	end
	____self__params_13.atk = ____self__params_atk_12 + atk
	local ____self__params_15 = self._params
	local ____self__params_hp_14 = self._params.hp
	if ____self__params_hp_14 == nil then
		____self__params_hp_14 = 0
	end
	____self__params_15.hp = ____self__params_hp_14 + hp
	self:IncrementStackCount()
	self:_ApplyParams(self._params)
	self:GetParent():CalculateStatBonus(true)
end
sl_modifier_bless_100388 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100388", nil, getfenv()) },
	sl_modifier_bless_100388
)
____exports.sl_modifier_bless_100388 = sl_modifier_bless_100388
return ____exports