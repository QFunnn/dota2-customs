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
local sl_modifier_transmitter_data_debuff = ____sl_modifier_simple.sl_modifier_transmitter_data_debuff
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10178_cd = __TS__Class()
local sl_modifier_bless_10178_cd = ____exports.sl_modifier_bless_10178_cd
sl_modifier_bless_10178_cd.name = "sl_modifier_bless_10178_cd"
__TS__ClassExtends(sl_modifier_bless_10178_cd, SLModifierBase)
function sl_modifier_bless_10178_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10178_cd.prototype.GetTexture(self)
	return "buff/bless/10178"
end
sl_modifier_bless_10178_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178") },
	sl_modifier_bless_10178_cd
)
____exports.sl_modifier_bless_10178_cd = sl_modifier_bless_10178_cd
____exports.sl_modifier_bless_10178a_cd = __TS__Class()
local sl_modifier_bless_10178a_cd = ____exports.sl_modifier_bless_10178a_cd
sl_modifier_bless_10178a_cd.name = "sl_modifier_bless_10178a_cd"
__TS__ClassExtends(sl_modifier_bless_10178a_cd, SLModifierBase)
function sl_modifier_bless_10178a_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10178a_cd.prototype.GetTexture(self)
	return "buff/bless/10178"
end
sl_modifier_bless_10178a_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178") },
	sl_modifier_bless_10178a_cd
)
____exports.sl_modifier_bless_10178a_cd = sl_modifier_bless_10178a_cd
____exports.sl_modifier_bless_10178_smoke_debuff = __TS__Class()
local sl_modifier_bless_10178_smoke_debuff = ____exports.sl_modifier_bless_10178_smoke_debuff
sl_modifier_bless_10178_smoke_debuff.name = "sl_modifier_bless_10178_smoke_debuff"
__TS__ClassExtends(sl_modifier_bless_10178_smoke_debuff, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10178_smoke_debuff.prototype.CheckState(self)
	return { [MODIFIER_STATE_BLIND] = true }
end
function sl_modifier_bless_10178_smoke_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10178_smoke_debuff.prototype.GetTexture(self)
	return "buff/bless/10178"
end
function sl_modifier_bless_10178_smoke_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function sl_modifier_bless_10178_smoke_debuff.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
sl_modifier_bless_10178_smoke_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178") },
	sl_modifier_bless_10178_smoke_debuff
)
____exports.sl_modifier_bless_10178_smoke_debuff = sl_modifier_bless_10178_smoke_debuff
____exports.sl_modifier_bless_10178a_smoke_debuff = __TS__Class()
local sl_modifier_bless_10178a_smoke_debuff = ____exports.sl_modifier_bless_10178a_smoke_debuff
sl_modifier_bless_10178a_smoke_debuff.name = "sl_modifier_bless_10178a_smoke_debuff"
__TS__ClassExtends(sl_modifier_bless_10178a_smoke_debuff, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10178a_smoke_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10178a_smoke_debuff.prototype.GetTexture(self)
	return "buff/bless/10178"
end
function sl_modifier_bless_10178a_smoke_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function sl_modifier_bless_10178a_smoke_debuff.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_pct_2 = self._params
	if ____table__params_pct_2 ~= nil then
		____table__params_pct_2 = ____table__params_pct_2.pct
	end
	return ____table__params_pct_2
end
sl_modifier_bless_10178a_smoke_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178") },
	sl_modifier_bless_10178a_smoke_debuff
)
____exports.sl_modifier_bless_10178a_smoke_debuff = sl_modifier_bless_10178a_smoke_debuff
____exports.sl_modifier_bless_10178a_smoke_buff = __TS__Class()
local sl_modifier_bless_10178a_smoke_buff = ____exports.sl_modifier_bless_10178a_smoke_buff
sl_modifier_bless_10178a_smoke_buff.name = "sl_modifier_bless_10178a_smoke_buff"
__TS__ClassExtends(sl_modifier_bless_10178a_smoke_buff, SLModifierBase)
function sl_modifier_bless_10178a_smoke_buff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10178a_smoke_buff.prototype.GetTexture(self)
	return "buff/bless/10178"
end
function sl_modifier_bless_10178a_smoke_buff.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
sl_modifier_bless_10178a_smoke_buff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178") },
	sl_modifier_bless_10178a_smoke_buff
)
____exports.sl_modifier_bless_10178a_smoke_buff = sl_modifier_bless_10178a_smoke_buff
return ____exports