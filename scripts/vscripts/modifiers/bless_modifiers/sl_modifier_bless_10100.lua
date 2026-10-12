--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10100.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10100.lua",
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
		["25"] = "15:9",
		["26"] = "14:5",
		["27"] = "20:5",
		["28"] = "21:14",
		["31"] = "22:14",
		["32"] = "22:14",
		["33"] = "22:14",
		["35"] = "22:14",
		["38"] = "23:9",
		["39"] = "20:5",
		["40"] = "26:5",
		["41"] = "27:14",
		["44"] = "28:38",
		["45"] = "28:17",
		["46"] = "28:27",
		["47"] = "29:15",
		["48"] = "30:13",
		["51"] = "31:13",
		["54"] = "32:14",
		["57"] = "33:33",
		["58"] = "33:17",
		["59"] = "33:22",
		["60"] = "34:13",
		["63"] = "35:9",
		["64"] = "26:5",
		["65"] = "5:14",
		["66"] = "4:2",
		["67"] = "4:2",
		["68"] = "4:19",
		["69"] = "4:2",
		["71"] = "4:2",
		["72"] = "5:14",
		["74"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10100 = __TS__Class()
local sl_modifier_bless_10100 = ____exports.sl_modifier_bless_10100
sl_modifier_bless_10100.name = "sl_modifier_bless_10100"
__TS__ClassExtends(sl_modifier_bless_10100, SLModifierBase)
function sl_modifier_bless_10100.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10100.prototype.OnCreated(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10100.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10100.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____params_hp_pct_0 = params
	if ____params_hp_pct_0 ~= nil then
		____params_hp_pct_0 = ____params_hp_pct_0.hp_pct
	end
	if not ____params_hp_pct_0 then
		return
	end
	self._params = params
end
function sl_modifier_bless_10100.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_2 = event
	local attacker = ____event_2.attacker
	local target = ____event_2.target
	local parent = self:GetParent()
	if attacker ~= parent then
		return
	end
	if target:GetTeam() == attacker:GetTeam() then
		return
	end
	if not self._params then
		return
	end
	local ____self__params_3 = self._params
	local amp = ____self__params_3.amp
	local hp_pct = ____self__params_3.hp_pct
	if target:GetHealthPercent() < hp_pct then
		return
	end
	return amp
end
sl_modifier_bless_10100 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10100", nil, getfenv()) },
	sl_modifier_bless_10100
)
____exports.sl_modifier_bless_10100 = sl_modifier_bless_10100
return ____exports