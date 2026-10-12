--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10168.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10168.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:38",
		["18"] = "7:5",
		["19"] = "8:9",
		["20"] = "7:5",
		["21"] = "13:5",
		["22"] = "14:14",
		["25"] = "15:9",
		["26"] = "13:5",
		["27"] = "18:5",
		["28"] = "19:14",
		["31"] = "20:13",
		["33"] = "20:24",
		["34"] = "20:24",
		["35"] = "20:24",
		["37"] = "20:24",
		["42"] = "21:9",
		["43"] = "18:5",
		["44"] = "24:5",
		["45"] = "25:14",
		["48"] = "26:14",
		["51"] = "27:15",
		["52"] = "28:38",
		["53"] = "28:17",
		["54"] = "28:27",
		["55"] = "29:13",
		["58"] = "30:15",
		["59"] = "31:15",
		["60"] = "32:13",
		["63"] = "33:15",
		["64"] = "34:13",
		["67"] = "35:15",
		["68"] = "36:15",
		["69"] = "38:9",
		["70"] = "24:5",
		["71"] = "6:14",
		["72"] = "5:2",
		["73"] = "5:2",
		["74"] = "5:19",
		["75"] = "5:2",
		["77"] = "5:2",
		["78"] = "6:14",
		["80"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10168 = __TS__Class()
local sl_modifier_bless_10168 = ____exports.sl_modifier_bless_10168
sl_modifier_bless_10168.name = "sl_modifier_bless_10168"
__TS__ClassExtends(sl_modifier_bless_10168, SLModifierBase)
function sl_modifier_bless_10168.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10168.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._params = params
end
function sl_modifier_bless_10168.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local ____temp_2 = not params
	if not ____temp_2 then
		local ____params_update_data_0 = params
		if ____params_update_data_0 ~= nil then
			____params_update_data_0 = ____params_update_data_0.update_data
		end
		____temp_2 = ____params_update_data_0 ~= 1
	end
	if ____temp_2 then
		return
	end
	self._params = params
end
function sl_modifier_bless_10168.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	if not self._params then
		return
	end
	local parent = self:GetParent()
	local ____event_3 = event
	local attacker = ____event_3.attacker
	local target = ____event_3.target
	if parent ~= attacker then
		return
	end
	local target_hp = target:GetHealth()
	local parent_hp = parent:GetHealth()
	if parent_hp >= target_hp then
		return
	end
	local diff_pct = (target_hp - parent_hp) / parent_hp * 100
	if diff_pct < self._params.pct_threshold then
		return
	end
	local mul_times = math.floor(diff_pct / self._params.pct_threshold)
	local out_pct = math.min(self._params.pct_bonus * mul_times, self._params.pct_bonus_max)
	return out_pct
end
sl_modifier_bless_10168 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10168", nil, getfenv()) },
	sl_modifier_bless_10168
)
____exports.sl_modifier_bless_10168 = sl_modifier_bless_10168
return ____exports