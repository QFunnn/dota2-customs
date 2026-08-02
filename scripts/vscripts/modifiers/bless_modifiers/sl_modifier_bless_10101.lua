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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10101") },
	sl_modifier_bless_10101
)
____exports.sl_modifier_bless_10101 = sl_modifier_bless_10101
return ____exports