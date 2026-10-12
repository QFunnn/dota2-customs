--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10161.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10161.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["15"] = "8:1",
		["16"] = "9:14",
		["17"] = "8:1",
		["18"] = "9:38",
		["19"] = "10:5",
		["20"] = "11:9",
		["21"] = "10:5",
		["22"] = "14:5",
		["23"] = "15:9",
		["24"] = "14:5",
		["25"] = "18:5",
		["26"] = "19:9",
		["27"] = "18:5",
		["28"] = "22:5",
		["29"] = "23:16",
		["30"] = "23:16",
		["31"] = "23:16",
		["33"] = "23:9",
		["34"] = "22:5",
		["35"] = "26:5",
		["36"] = "27:16",
		["37"] = "27:16",
		["38"] = "27:16",
		["40"] = "27:9",
		["41"] = "26:5",
		["42"] = "30:5",
		["43"] = "31:9",
		["44"] = "30:5",
		["45"] = "9:14",
		["46"] = "8:2",
		["47"] = "8:2",
		["48"] = "8:19",
		["49"] = "8:2",
		["51"] = "8:2",
		["52"] = "9:14",
		["54"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data_debuff = ____sl_modifier_simple.sl_modifier_transmitter_data_debuff
--- 10161 层数显示
____exports.sl_modifier_bless_10161 = __TS__Class()
local sl_modifier_bless_10161 = ____exports.sl_modifier_bless_10161
sl_modifier_bless_10161.name = "sl_modifier_bless_10161"
__TS__ClassExtends(sl_modifier_bless_10161, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10161.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10161.prototype.GetTexture(self)
	return "buff/bless/10161"
end
function sl_modifier_bless_10161.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end
function sl_modifier_bless_10161.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____table__params_armor_0 = self._params
	if ____table__params_armor_0 ~= nil then
		____table__params_armor_0 = ____table__params_armor_0.armor
	end
	return ____table__params_armor_0 * self:GetStackCount()
end
function sl_modifier_bless_10161.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____table__params_magic_resist_2 = self._params
	if ____table__params_magic_resist_2 ~= nil then
		____table__params_magic_resist_2 = ____table__params_magic_resist_2.magic_resist
	end
	return ____table__params_magic_resist_2 * self:GetStackCount()
end
function sl_modifier_bless_10161.prototype.GetEffectName(self)
	return BLESS_PARTICLES.bless_10161_debuff
end
sl_modifier_bless_10161 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10161", nil, getfenv()) },
	sl_modifier_bless_10161
)
____exports.sl_modifier_bless_10161 = sl_modifier_bless_10161
return ____exports