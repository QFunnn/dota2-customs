--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10071.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10071.lua",
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
		["19"] = "7:14",
		["22"] = "8:9",
		["23"] = "6:5",
		["24"] = "11:5",
		["25"] = "12:14",
		["28"] = "13:14",
		["29"] = "13:14",
		["30"] = "13:14",
		["32"] = "13:13",
		["34"] = "13:33",
		["35"] = "13:33",
		["36"] = "13:33",
		["38"] = "13:33",
		["43"] = "14:9",
		["44"] = "11:5",
		["45"] = "18:5",
		["46"] = "19:14",
		["49"] = "20:9",
		["50"] = "18:5",
		["51"] = "23:5",
		["52"] = "24:9",
		["53"] = "23:5",
		["54"] = "27:5",
		["55"] = "28:14",
		["58"] = "29:38",
		["59"] = "29:17",
		["60"] = "29:27",
		["61"] = "30:15",
		["62"] = "31:13",
		["65"] = "32:14",
		["68"] = "33:13",
		["71"] = "34:15",
		["72"] = "35:13",
		["75"] = "36:9",
		["76"] = "27:5",
		["77"] = "5:14",
		["78"] = "4:2",
		["79"] = "4:2",
		["80"] = "4:19",
		["81"] = "4:2",
		["83"] = "4:2",
		["84"] = "5:14",
		["86"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10071 = __TS__Class()
local sl_modifier_bless_10071 = ____exports.sl_modifier_bless_10071
sl_modifier_bless_10071.name = "sl_modifier_bless_10071"
__TS__ClassExtends(sl_modifier_bless_10071, SLModifierBase)
function sl_modifier_bless_10071.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_bless_10071.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local ____params_hp_pct_0 = params
	if ____params_hp_pct_0 ~= nil then
		____params_hp_pct_0 = ____params_hp_pct_0.hp_pct
	end
	local ____temp_4 = not ____params_hp_pct_0
	if not ____temp_4 then
		local ____params_dmg_pct_2 = params
		if ____params_dmg_pct_2 ~= nil then
			____params_dmg_pct_2 = ____params_dmg_pct_2.dmg_pct
		end
		____temp_4 = not ____params_dmg_pct_2
	end
	if ____temp_4 then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_bless_10071.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	self._params = params
end
function sl_modifier_bless_10071.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10071.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_5 = event
	local attacker = ____event_5.attacker
	local target = ____event_5.target
	local parent = self:GetParent()
	if attacker ~= parent then
		return
	end
	if not IsValidAlive(target) then
		return
	end
	if attacker == target then
		return
	end
	local hp_pct = target:GetHealthPercent()
	if hp_pct > self._params.hp_pct then
		return
	end
	return self._params.dmg_pct
end
sl_modifier_bless_10071 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10071", nil, getfenv()) },
	sl_modifier_bless_10071
)
____exports.sl_modifier_bless_10071 = sl_modifier_bless_10071
return ____exports