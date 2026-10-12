--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10177.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10177.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:38",
		["20"] = "8:46",
		["21"] = "26:5",
		["22"] = "7:1",
		["23"] = "9:5",
		["24"] = "10:9",
		["25"] = "9:5",
		["26"] = "13:5",
		["27"] = "14:9",
		["28"] = "13:5",
		["29"] = "18:5",
		["30"] = "19:9",
		["31"] = "18:5",
		["32"] = "22:5",
		["33"] = "23:9",
		["34"] = "22:5",
		["35"] = "27:5",
		["36"] = "28:14",
		["39"] = "29:9",
		["40"] = "30:16",
		["41"] = "30:16",
		["42"] = "30:16",
		["44"] = "30:9",
		["45"] = "27:5",
		["46"] = "33:5",
		["47"] = "34:14",
		["50"] = "35:26",
		["51"] = "35:17",
		["52"] = "36:13",
		["55"] = "37:14",
		["58"] = "39:9",
		["59"] = "33:5",
		["60"] = "42:5",
		["61"] = "43:9",
		["62"] = "42:5",
		["63"] = "48:5",
		["64"] = "49:14",
		["67"] = "50:9",
		["68"] = "48:5",
		["69"] = "8:14",
		["70"] = "7:2",
		["71"] = "7:2",
		["72"] = "7:19",
		["73"] = "7:2",
		["75"] = "7:2",
		["76"] = "8:14",
		["78"] = "8:14",
		["79"] = "58:1",
		["80"] = "59:14",
		["81"] = "58:1",
		["82"] = "59:41",
		["83"] = "60:5",
		["84"] = "61:9",
		["85"] = "60:5",
		["86"] = "64:5",
		["87"] = "65:9",
		["88"] = "64:5",
		["89"] = "59:14",
		["90"] = "58:2",
		["91"] = "58:2",
		["92"] = "58:19",
		["93"] = "58:2",
		["95"] = "58:2",
		["96"] = "59:14",
		["98"] = "59:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 10177
____exports.sl_modifier_bless_10177 = __TS__Class()
local sl_modifier_bless_10177 = ____exports.sl_modifier_bless_10177
sl_modifier_bless_10177.name = "sl_modifier_bless_10177"
__TS__ClassExtends(sl_modifier_bless_10177, SLModifierBase)
function sl_modifier_bless_10177.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._is_triggered = false
end
function sl_modifier_bless_10177.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10177.prototype.GetTexture(self)
	return "buff/bless/10177"
end
function sl_modifier_bless_10177.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10177.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_REINCARNATION, MODIFIER_EVENT_ON_RESPAWN }
end
function sl_modifier_bless_10177.prototype.ReincarnateTime(self)
	if not IsServer() then
		return
	end
	self._is_triggered = true
	local ____table__params_delay_0 = self._params
	if ____table__params_delay_0 ~= nil then
		____table__params_delay_0 = ____table__params_delay_0.delay
	end
	return ____table__params_delay_0
end
function sl_modifier_bless_10177.prototype.OnRespawn(self, event)
	if not IsServer() then
		return
	end
	local ____event_2 = event
	local unit = ____event_2.unit
	if unit ~= self:GetParent() then
		return
	end
	if not self._is_triggered then
		return
	end
	self:Destroy()
end
function sl_modifier_bless_10177.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_HIGH
end
function sl_modifier_bless_10177.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._params = params
end
sl_modifier_bless_10177 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10177", nil, getfenv()) },
	sl_modifier_bless_10177
)
____exports.sl_modifier_bless_10177 = sl_modifier_bless_10177
____exports.sl_modifier_bless_10177_cd = __TS__Class()
local sl_modifier_bless_10177_cd = ____exports.sl_modifier_bless_10177_cd
sl_modifier_bless_10177_cd.name = "sl_modifier_bless_10177_cd"
__TS__ClassExtends(sl_modifier_bless_10177_cd, SLModifierBase)
function sl_modifier_bless_10177_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10177_cd.prototype.GetTexture(self)
	return "buff/bless/10177"
end
sl_modifier_bless_10177_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10177", nil, getfenv()) },
	sl_modifier_bless_10177_cd
)
____exports.sl_modifier_bless_10177_cd = sl_modifier_bless_10177_cd
return ____exports