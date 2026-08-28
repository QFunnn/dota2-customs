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
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_fountain_hurt") },
	sl_modifier_fountain_hurt
)
____exports.sl_modifier_fountain_hurt = sl_modifier_fountain_hurt
return ____exports