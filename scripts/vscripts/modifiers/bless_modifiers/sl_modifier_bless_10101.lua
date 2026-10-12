--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10101.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10101.lua",
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
		["23"] = "12:9",
		["24"] = "10:5",
		["25"] = "15:5",
		["26"] = "16:9",
		["27"] = "15:5",
		["28"] = "19:5",
		["29"] = "20:9",
		["30"] = "19:5",
		["31"] = "25:5",
		["32"] = "26:14",
		["35"] = "27:14",
		["36"] = "27:14",
		["37"] = "27:14",
		["39"] = "27:14",
		["42"] = "28:9",
		["43"] = "29:9",
		["44"] = "25:5",
		["45"] = "32:5",
		["46"] = "33:9",
		["47"] = "32:5",
		["48"] = "36:5",
		["49"] = "37:9",
		["50"] = "36:5",
		["51"] = "40:5",
		["52"] = "41:9",
		["53"] = "40:5",
		["54"] = "46:5",
		["55"] = "47:14",
		["58"] = "48:34",
		["59"] = "48:17",
		["60"] = "48:22",
		["61"] = "48:26",
		["62"] = "49:15",
		["63"] = "50:13",
		["64"] = "51:13",
		["65"] = "51:36",
		["66"] = "51:86",
		["67"] = "51:27",
		["69"] = "53:9",
		["70"] = "46:5",
		["71"] = "5:14",
		["72"] = "4:2",
		["73"] = "4:2",
		["74"] = "4:19",
		["75"] = "4:2",
		["77"] = "4:2",
		["78"] = "5:14",
		["80"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10101 = __TS__Class()
local sl_modifier_bless_10101 = ____exports.sl_modifier_bless_10101
sl_modifier_bless_10101.name = "sl_modifier_bless_10101"
__TS__ClassExtends(sl_modifier_bless_10101, SLModifierBase)
function sl_modifier_bless_10101.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10101.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10101.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10101.prototype.GetTexture(self)
	return "buff/bless/10101"
end
function sl_modifier_bless_10101.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____params_hp_0 = params
	if ____params_hp_0 ~= nil then
		____params_hp_0 = ____params_hp_0.hp
	end
	if not ____params_hp_0 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10101.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10101.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10101.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10101.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not self._params then
		return
	end
	local ____self__params_2 = self._params
	local amp = ____self__params_2.amp
	local hp = ____self__params_2.hp
	local max = ____self__params_2.max
	local health = self:GetParent():GetMaxHealth()
	if health ~= self._health then
		self._times = math.min(math.floor(self:GetParent():GetMaxHealth() / hp), max)
	end
	return self._times * amp
end
sl_modifier_bless_10101 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10101", nil, getfenv()) },
	sl_modifier_bless_10101
)
____exports.sl_modifier_bless_10101 = sl_modifier_bless_10101
return ____exports