--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/random_event_modifiers/sl_modifier_rnd_event_1022.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/random_event_modifiers/sl_modifier_rnd_event_1022.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["15"] = "8:1",
		["16"] = "9:14",
		["17"] = "8:1",
		["18"] = "9:41",
		["19"] = "13:5",
		["20"] = "14:9",
		["21"] = "13:5",
		["22"] = "17:5",
		["23"] = "18:9",
		["24"] = "17:5",
		["25"] = "21:5",
		["26"] = "22:9",
		["27"] = "21:5",
		["28"] = "25:5",
		["29"] = "26:9",
		["30"] = "25:5",
		["31"] = "29:5",
		["32"] = "30:14",
		["35"] = "9:49",
		["36"] = "32:9",
		["37"] = "29:5",
		["38"] = "35:5",
		["39"] = "36:14",
		["42"] = "9:49",
		["43"] = "38:9",
		["44"] = "35:5",
		["45"] = "41:5",
		["46"] = "42:14",
		["49"] = "43:15",
		["50"] = "44:15",
		["51"] = "45:13",
		["52"] = "46:13",
		["55"] = "49:9",
		["56"] = "50:13",
		["57"] = "51:13",
		["58"] = "49:26",
		["59"] = "41:5",
		["60"] = "55:5",
		["61"] = "56:22",
		["63"] = "56:22",
		["65"] = "56:15",
		["66"] = "57:21",
		["68"] = "57:21",
		["70"] = "57:15",
		["71"] = "58:13",
		["72"] = "59:13",
		["75"] = "62:9",
		["76"] = "63:9",
		["77"] = "55:5",
		["78"] = "11:37",
		["79"] = "9:14",
		["80"] = "8:2",
		["81"] = "8:2",
		["82"] = "8:19",
		["83"] = "8:2",
		["85"] = "8:2",
		["86"] = "9:14",
		["88"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
--- 袍泽：单实例全护盾（叠层时累加剩余值后刷新），在 time 秒内线性衰减
____exports.sl_modifier_rnd_event_1022 = __TS__Class()
local sl_modifier_rnd_event_1022 = ____exports.sl_modifier_rnd_event_1022
sl_modifier_rnd_event_1022.name = "sl_modifier_rnd_event_1022"
__TS__ClassExtends(sl_modifier_rnd_event_1022, sl_modifier_shield_all)
function sl_modifier_rnd_event_1022.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1022.prototype.GetTexture(self)
	return "buff/rnd_event_1022"
end
function sl_modifier_rnd_event_1022.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_rnd_event_1022.prototype.IsPermanent(self)
	return false
end
function sl_modifier_rnd_event_1022.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	sl_modifier_shield_all.prototype.OnCreated(self, params)
	self:_StartDecay(params)
end
function sl_modifier_rnd_event_1022.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	sl_modifier_shield_all.prototype.OnRefresh(self, params)
	self:_StartDecay(params)
end
function sl_modifier_rnd_event_1022.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local current = self:GetCurrentShieldAmount()
	local next = current - self._decay_per_tick
	if next <= 0 then
		self:Destroy()
		return
	end
	self:_ApplyParam({
		shield_amount_max = self:GetMaxShieldAmount(),
		shield_amount = next,
	})
end
function sl_modifier_rnd_event_1022.prototype._StartDecay(self, params)
	local ____params_time_0 = params.time
	if ____params_time_0 == nil then
		____params_time_0 = self:GetDuration()
	end
	local time = ____params_time_0
	local ____params_shield_amount_max_1 = params.shield_amount_max
	if ____params_shield_amount_max_1 == nil then
		____params_shield_amount_max_1 = 0
	end
	local max = ____params_shield_amount_max_1
	if time <= 0 or max <= 0 then
		self:Destroy()
		return
	end
	self._decay_per_tick = max / time * ____exports.sl_modifier_rnd_event_1022._TICK
	self:StartIntervalThink(____exports.sl_modifier_rnd_event_1022._TICK)
end
sl_modifier_rnd_event_1022._TICK = 0.1
sl_modifier_rnd_event_1022 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1022", nil, getfenv()) },
	sl_modifier_rnd_event_1022
)
____exports.sl_modifier_rnd_event_1022 = sl_modifier_rnd_event_1022
return ____exports