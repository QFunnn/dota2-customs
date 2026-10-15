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
		["25"] = "16:16",
		["26"] = "16:40",
		["27"] = "16:40",
		["28"] = "16:40",
		["30"] = "16:40",
		["32"] = "16:40",
		["34"] = "16:9",
		["35"] = "14:5",
		["36"] = "19:5",
		["37"] = "20:14",
		["40"] = "21:15",
		["41"] = "22:26",
		["42"] = "22:17",
		["43"] = "23:13",
		["46"] = "25:15",
		["47"] = "26:51",
		["48"] = "26:51",
		["49"] = "26:51",
		["51"] = "26:51",
		["53"] = "26:51",
		["55"] = "26:15",
		["56"] = "27:15",
		["57"] = "28:9",
		["58"] = "19:5",
		["59"] = "31:5",
		["60"] = "32:9",
		["61"] = "31:5",
		["62"] = "5:14",
		["63"] = "4:2",
		["64"] = "4:2",
		["65"] = "4:19",
		["66"] = "4:2",
		["68"] = "4:2",
		["69"] = "5:14",
		["71"] = "5:14",
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
	local ____temp_3 = self:GetStackCount()
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	local ____table__params_pct_0_2 = ____table__params_pct_0
	if ____table__params_pct_0_2 == nil then
		____table__params_pct_0_2 = 0
	end
	return ____temp_3 * ____table__params_pct_0_2
end
function sl_modifier_bless_10167.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ____event_4 = event
	local unit = ____event_4.unit
	if unit ~= parent then
		return
	end
	local current_stack = self:GetStackCount()
	local ____table__params_lose_pct_5 = self._params
	if ____table__params_lose_pct_5 ~= nil then
		____table__params_lose_pct_5 = ____table__params_lose_pct_5.lose_pct
	end
	local ____table__params_lose_pct_5_7 = ____table__params_lose_pct_5
	if ____table__params_lose_pct_5_7 == nil then
		____table__params_lose_pct_5_7 = 0
	end
	local lose_stack_float = current_stack * ____table__params_lose_pct_5_7 * 0.01
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