--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_status_effect.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_status_effect.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:40",
		["18"] = "9:5",
		["19"] = "10:9",
		["20"] = "9:5",
		["21"] = "13:5",
		["22"] = "14:14",
		["25"] = "15:15",
		["26"] = "16:9",
		["27"] = "17:9",
		["28"] = "18:26",
		["30"] = "18:26",
		["32"] = "18:9",
		["33"] = "19:9",
		["34"] = "13:5",
		["35"] = "22:5",
		["36"] = "23:9",
		["37"] = "24:9",
		["38"] = "22:5",
		["39"] = "27:5",
		["40"] = "28:9",
		["41"] = "27:5",
		["42"] = "34:5",
		["43"] = "35:9",
		["44"] = "34:5",
		["45"] = "38:5",
		["46"] = "39:9",
		["47"] = "38:5",
		["48"] = "42:5",
		["49"] = "43:14",
		["52"] = "44:9",
		["53"] = "45:9",
		["54"] = "42:5",
		["55"] = "5:14",
		["56"] = "4:2",
		["57"] = "4:2",
		["58"] = "4:19",
		["59"] = "4:2",
		["61"] = "4:2",
		["62"] = "5:14",
		["64"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_status_effect = __TS__Class()
local sl_modifier_status_effect = ____exports.sl_modifier_status_effect
sl_modifier_status_effect.name = "sl_modifier_status_effect"
__TS__ClassExtends(sl_modifier_status_effect, SLModifierBase)
function sl_modifier_status_effect.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_status_effect.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local id = tonumber(params.unique_id)
	self._unique_id = id
	self._status_effect_name = SParticleManager._id_status_effect_map[id]
	local ____params_priority_0 = params.priority
	if ____params_priority_0 == nil then
		____params_priority_0 = MODIFIER_PRIORITY_NORMAL
	end
	self._priority = ____params_priority_0
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_status_effect.prototype.HandleCustomTransmitterData(self, data)
	self._status_effect_name = data._status_effect_name
	self._priority = data._priority
end
function sl_modifier_status_effect.prototype.AddCustomTransmitterData(self)
	return { _status_effect_name = self._status_effect_name, _priority = self._priority }
end
function sl_modifier_status_effect.prototype.GetPriority(self)
	return self._priority
end
function sl_modifier_status_effect.prototype.GetStatusEffectName(self)
	return self._status_effect_name
end
function sl_modifier_status_effect.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	UniqueIndexGenerate:DestroyIndex(self._unique_id, 1000000)
	SParticleManager._id_status_effect_map[self._unique_id] = nil
end
sl_modifier_status_effect = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_status_effect", nil, getfenv()) },
	sl_modifier_status_effect
)
____exports.sl_modifier_status_effect = sl_modifier_status_effect
return ____exports