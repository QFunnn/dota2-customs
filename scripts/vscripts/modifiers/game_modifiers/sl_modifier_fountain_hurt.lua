--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_fountain_hurt.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_fountain_hurt.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "6:14",
		["16"] = "4:1",
		["17"] = "6:40",
		["19"] = "6:48",
		["20"] = "8:5",
		["21"] = "4:1",
		["22"] = "10:5",
		["23"] = "11:9",
		["24"] = "10:5",
		["25"] = "14:5",
		["26"] = "15:9",
		["27"] = "14:5",
		["28"] = "18:5",
		["29"] = "19:9",
		["30"] = "18:5",
		["31"] = "22:5",
		["32"] = "23:9",
		["33"] = "22:5",
		["34"] = "26:5",
		["35"] = "27:9",
		["36"] = "26:5",
		["37"] = "30:5",
		["38"] = "31:9",
		["39"] = "30:5",
		["40"] = "34:5",
		["41"] = "35:9",
		["42"] = "34:5",
		["43"] = "38:5",
		["44"] = "39:9",
		["45"] = "38:5",
		["46"] = "6:14",
		["47"] = "4:2",
		["48"] = "4:2",
		["49"] = "4:19",
		["50"] = "4:2",
		["52"] = "4:2",
		["53"] = "6:14",
		["55"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
____exports.sl_modifier_fountain_hurt = __TS__Class()
local sl_modifier_fountain_hurt = ____exports.sl_modifier_fountain_hurt
sl_modifier_fountain_hurt.name = "sl_modifier_fountain_hurt"
__TS__ClassExtends(sl_modifier_fountain_hurt, SLModifierBase_Debuff)
function sl_modifier_fountain_hurt.prototype.____constructor(self, ...)
	SLModifierBase_Debuff.prototype.____constructor(self, ...)
	self._pct_per_stack = 5
end
function sl_modifier_fountain_hurt.prototype.IsHidden(self)
	return false
end
function sl_modifier_fountain_hurt.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_fountain_hurt.prototype.IsPurgable(self)
	return false
end
function sl_modifier_fountain_hurt.prototype.IsPermanent(self)
	return false
end
function sl_modifier_fountain_hurt.prototype.OnCreated(self, params)
	self:ForceRefresh()
end
function sl_modifier_fountain_hurt.prototype.OnRefresh(self, params)
	self:IncrementStackCount()
end
function sl_modifier_fountain_hurt.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_fountain_hurt.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self:GetStackCount() * self._pct_per_stack
end
sl_modifier_fountain_hurt = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_fountain_hurt", nil, getfenv()) },
	sl_modifier_fountain_hurt
)
____exports.sl_modifier_fountain_hurt = sl_modifier_fountain_hurt
return ____exports