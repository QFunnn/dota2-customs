--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10100") },
	sl_modifier_bless_10100
)
____exports.sl_modifier_bless_10100 = sl_modifier_bless_10100
return ____exports