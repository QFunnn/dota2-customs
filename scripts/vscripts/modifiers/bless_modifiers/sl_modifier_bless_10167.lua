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
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10167 = __TS__Class()
local sl_modifier_bless_10167 = ____exports.sl_modifier_bless_10167
sl_modifier_bless_10167.name = "sl_modifier_bless_10167"
__TS__ClassExtends(sl_modifier_bless_10167, sl_modifier_transmitter_data)
function sl_modifier_bless_10167.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10167.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE, MODIFIER_EVENT_ON_DEATH }
end
function sl_modifier_bless_10167.prototype.GetModifierExtraHealthPercentage(self)
	local ____temp_2 = self:GetStackCount()
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____temp_2 * ____table__params_pct_0
end
function sl_modifier_bless_10167.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ____event_3 = event
	local unit = ____event_3.unit
	if unit ~= parent then
		return
	end
	local current_stack = self:GetStackCount()
	local ____table__params_lose_pct_4 = self._params
	if ____table__params_lose_pct_4 ~= nil then
		____table__params_lose_pct_4 = ____table__params_lose_pct_4.lose_pct
	end
	local lose_stack_float = current_stack * ____table__params_lose_pct_4 * 0.01
	local lose_stack = math.ceil(lose_stack_float)
	self:SetStackCount(math.max(0, current_stack - lose_stack))
end
function sl_modifier_bless_10167.prototype.GetTexture(self)
	return "buff/bless/10167"
end
sl_modifier_bless_10167 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10167") },
	sl_modifier_bless_10167
)
____exports.sl_modifier_bless_10167 = sl_modifier_bless_10167
return ____exports