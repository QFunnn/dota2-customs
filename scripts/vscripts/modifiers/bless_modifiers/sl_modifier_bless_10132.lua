--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10132.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10132.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:38",
		["19"] = "6:46",
		["20"] = "23:5",
		["21"] = "5:1",
		["22"] = "7:5",
		["23"] = "8:9",
		["24"] = "7:5",
		["25"] = "11:5",
		["26"] = "12:9",
		["27"] = "11:5",
		["28"] = "15:5",
		["29"] = "16:16",
		["30"] = "16:16",
		["31"] = "16:16",
		["33"] = "16:9",
		["34"] = "15:5",
		["35"] = "19:5",
		["36"] = "20:9",
		["37"] = "19:5",
		["38"] = "24:5",
		["39"] = "25:9",
		["40"] = "26:9",
		["41"] = "30:9",
		["42"] = "24:5",
		["43"] = "6:14",
		["44"] = "5:2",
		["45"] = "5:2",
		["46"] = "5:19",
		["47"] = "5:2",
		["49"] = "5:2",
		["50"] = "6:14",
		["52"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10132 = __TS__Class()
local sl_modifier_bless_10132 = ____exports.sl_modifier_bless_10132
sl_modifier_bless_10132.name = "sl_modifier_bless_10132"
__TS__ClassExtends(sl_modifier_bless_10132, sl_modifier_transmitter_data)
function sl_modifier_bless_10132.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._bonus_damage = 0
end
function sl_modifier_bless_10132.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10132.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
end
function sl_modifier_bless_10132.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____table__params_bonus_damage_0 = self._params
	if ____table__params_bonus_damage_0 ~= nil then
		____table__params_bonus_damage_0 = ____table__params_bonus_damage_0.bonus_damage
	end
	return ____table__params_bonus_damage_0
end
function sl_modifier_bless_10132.prototype.GetTexture(self)
	return "buff/bless/10132"
end
function sl_modifier_bless_10132.prototype.Modify10135BonusDamage(self, value)
	self._bonus_damage = self._bonus_damage + value
	self:_ApplyParams({ bonus_damage = self._bonus_damage, update_data = 1 })
	self:SetStackCount(math.floor(self._bonus_damage))
end
sl_modifier_bless_10132 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10132", nil, getfenv()) },
	sl_modifier_bless_10132
)
____exports.sl_modifier_bless_10132 = sl_modifier_bless_10132
return ____exports