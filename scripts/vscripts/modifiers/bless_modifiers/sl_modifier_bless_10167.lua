--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10167.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10167.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:38",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "14:5",
		["25"] = "15:16",
		["26"] = "15:39",
		["27"] = "15:39",
		["28"] = "15:39",
		["30"] = "15:9",
		["31"] = "14:5",
		["32"] = "18:5",
		["33"] = "19:14",
		["36"] = "20:15",
		["37"] = "21:26",
		["38"] = "21:17",
		["39"] = "22:13",
		["42"] = "24:15",
		["43"] = "25:50",
		["44"] = "25:50",
		["45"] = "25:50",
		["47"] = "25:15",
		["48"] = "26:15",
		["49"] = "27:9",
		["50"] = "18:5",
		["51"] = "30:5",
		["52"] = "31:9",
		["53"] = "30:5",
		["54"] = "5:14",
		["55"] = "4:2",
		["56"] = "4:2",
		["57"] = "4:19",
		["58"] = "4:2",
		["60"] = "4:2",
		["61"] = "5:14",
		["63"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10167 = __TS__Class()
local sl_modifier_bless_10167 = ____exports.sl_modifier_bless_10167
sl_modifier_bless_10167.name = "sl_modifier_bless_10167"
__TS__ClassExtends(sl_modifier_bless_10167, sl_modifier_transmitter_data)
function sl_modifier_bless_10167.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10167.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE, MODIFIER_EVENT_ON_DEATH }
end
function sl_modifier_bless_10167.prototype.GetModifierExtraHealthPercentage(self)
	local ____temp_2 = self:GetStackCount()
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____temp_2 * ____table__params_pct_0
end
function sl_modifier_bless_10167.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ____event_3 = event
	local unit = ____event_3.unit
	if unit ~= parent then
		return
	end
	local current_stack = self:GetStackCount()
	local ____table__params_lose_pct_4 = self._params
	if ____table__params_lose_pct_4 ~= nil then
		____table__params_lose_pct_4 = ____table__params_lose_pct_4.lose_pct
	end
	local lose_stack_float = current_stack * ____table__params_lose_pct_4 * 0.01
	local lose_stack = math.ceil(lose_stack_float)
	self:SetStackCount(math.max(0, current_stack - lose_stack))
end
function sl_modifier_bless_10167.prototype.GetTexture(self)
	return "buff/bless/10167"
end
sl_modifier_bless_10167 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10167", nil, getfenv()) },
	sl_modifier_bless_10167
)
____exports.sl_modifier_bless_10167 = sl_modifier_bless_10167
return ____exports