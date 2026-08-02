--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_status_effect") },
	sl_modifier_status_effect
)
____exports.sl_modifier_status_effect = sl_modifier_status_effect
return ____exports