--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10178.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10178.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "3:1",
		["15"] = "3:10",
		["16"] = "5:1",
		["17"] = "6:14",
		["18"] = "5:1",
		["19"] = "6:41",
		["20"] = "7:5",
		["21"] = "8:9",
		["22"] = "7:5",
		["23"] = "11:5",
		["24"] = "12:9",
		["25"] = "11:5",
		["26"] = "6:14",
		["27"] = "5:2",
		["28"] = "5:2",
		["29"] = "5:19",
		["30"] = "5:2",
		["32"] = "5:2",
		["33"] = "6:14",
		["35"] = "6:14",
		["36"] = "16:1",
		["37"] = "17:14",
		["38"] = "16:1",
		["39"] = "17:42",
		["40"] = "18:5",
		["41"] = "19:9",
		["42"] = "18:5",
		["43"] = "22:5",
		["44"] = "23:9",
		["45"] = "22:5",
		["46"] = "17:14",
		["47"] = "16:2",
		["48"] = "16:2",
		["49"] = "16:19",
		["50"] = "16:2",
		["52"] = "16:2",
		["53"] = "17:14",
		["55"] = "17:14",
		["56"] = "27:1",
		["57"] = "28:14",
		["58"] = "27:1",
		["59"] = "28:51",
		["60"] = "29:5",
		["61"] = "30:9",
		["62"] = "29:5",
		["63"] = "35:5",
		["64"] = "36:9",
		["65"] = "35:5",
		["66"] = "39:5",
		["67"] = "40:9",
		["68"] = "39:5",
		["69"] = "43:5",
		["70"] = "44:9",
		["71"] = "43:5",
		["72"] = "47:5",
		["73"] = "48:16",
		["74"] = "48:16",
		["75"] = "48:16",
		["77"] = "48:9",
		["78"] = "47:5",
		["79"] = "28:14",
		["80"] = "27:2",
		["81"] = "27:2",
		["82"] = "27:19",
		["83"] = "27:2",
		["85"] = "27:2",
		["86"] = "28:14",
		["88"] = "28:14",
		["89"] = "52:1",
		["90"] = "53:14",
		["91"] = "52:1",
		["92"] = "53:52",
		["93"] = "54:5",
		["94"] = "55:9",
		["95"] = "54:5",
		["96"] = "58:5",
		["97"] = "59:9",
		["98"] = "58:5",
		["99"] = "62:5",
		["100"] = "63:9",
		["101"] = "62:5",
		["102"] = "66:5",
		["103"] = "67:16",
		["104"] = "67:16",
		["105"] = "67:16",
		["107"] = "67:9",
		["108"] = "66:5",
		["109"] = "53:14",
		["110"] = "52:2",
		["111"] = "52:2",
		["112"] = "52:19",
		["113"] = "52:2",
		["115"] = "52:2",
		["116"] = "53:14",
		["118"] = "53:14",
		["119"] = "75:1",
		["120"] = "76:14",
		["121"] = "75:1",
		["122"] = "76:50",
		["123"] = "77:5",
		["124"] = "78:9",
		["125"] = "77:5",
		["126"] = "81:5",
		["127"] = "82:9",
		["128"] = "81:5",
		["129"] = "85:5",
		["130"] = "86:9",
		["131"] = "85:5",
		["132"] = "76:14",
		["133"] = "75:2",
		["134"] = "75:2",
		["135"] = "75:19",
		["136"] = "75:2",
		["138"] = "75:2",
		["139"] = "76:14",
		["141"] = "76:14",
	}
)
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178", nil, getfenv()) },
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178", nil, getfenv()) },
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178", nil, getfenv()) },
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178", nil, getfenv()) },
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10178", nil, getfenv()) },
	sl_modifier_bless_10178a_smoke_buff
)
____exports.sl_modifier_bless_10178a_smoke_buff = sl_modifier_bless_10178a_smoke_buff
return ____exports