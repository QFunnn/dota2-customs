--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10160.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10160.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:45",
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
		["32"] = "20:9",
		["33"] = "19:5",
		["34"] = "6:14",
		["35"] = "5:2",
		["36"] = "5:2",
		["37"] = "5:19",
		["38"] = "5:2",
		["40"] = "5:2",
		["41"] = "6:14",
		["43"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data_debuff = ____sl_modifier_simple.sl_modifier_transmitter_data_debuff
____exports.sl_modifier_bless_10160_debuff = __TS__Class()
local sl_modifier_bless_10160_debuff = ____exports.sl_modifier_bless_10160_debuff
sl_modifier_bless_10160_debuff.name = "sl_modifier_bless_10160_debuff"
__TS__ClassExtends(sl_modifier_bless_10160_debuff, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10160_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10160_debuff.prototype.GetTexture(self)
	return "buff/bless/10160"
end
function sl_modifier_bless_10160_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end
function sl_modifier_bless_10160_debuff.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____table__params_armor_0 = self._params
	if ____table__params_armor_0 ~= nil then
		____table__params_armor_0 = ____table__params_armor_0.armor
	end
	return ____table__params_armor_0
end
sl_modifier_bless_10160_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10160", nil, getfenv()) },
	sl_modifier_bless_10160_debuff
)
____exports.sl_modifier_bless_10160_debuff = sl_modifier_bless_10160_debuff
return ____exports