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
____exports.sl_modifier_bless_10166 = __TS__Class()
local sl_modifier_bless_10166 = ____exports.sl_modifier_bless_10166
sl_modifier_bless_10166.name = "sl_modifier_bless_10166"
__TS__ClassExtends(sl_modifier_bless_10166, sl_modifier_transmitter_data)
function sl_modifier_bless_10166.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._pct = 0
end
function sl_modifier_bless_10166.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10166.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10166.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
function sl_modifier_bless_10166.prototype.GetTexture(self)
	return "buff/bless/10166"
end
function sl_modifier_bless_10166.prototype.Modify10166BonusDamage(self, pct)
	self._pct = self._pct + pct
	self:_ApplyParams({ pct = self._pct, update_data = 1 })
	self:SetStackCount(math.floor(self._pct))
end
sl_modifier_bless_10166 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10166") },
	sl_modifier_bless_10166
)
____exports.sl_modifier_bless_10166 = sl_modifier_bless_10166
return ____exports