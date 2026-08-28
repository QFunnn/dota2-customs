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
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
--- 福佑10078 护盾+移速效果
-- 施放终极技能时获得护盾和固定移速加成，持续一段时间
____exports.sl_modifier_bless_10078 = __TS__Class()
local sl_modifier_bless_10078 = ____exports.sl_modifier_bless_10078
sl_modifier_bless_10078.name = "sl_modifier_bless_10078"
__TS__ClassExtends(sl_modifier_bless_10078, sl_modifier_shield_all)
function sl_modifier_bless_10078.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10078.prototype.GetTexture(self)
	return "buff/bless/10078"
end
function sl_modifier_bless_10078.prototype.DeclareFunctions(self)
	local ____array_0 = __TS__SparseArrayNew(unpack(sl_modifier_shield_all.prototype.DeclareFunctions(self)))
	__TS__SparseArrayPush(____array_0, MODIFIER_PROPERTY_TOOLTIP)
	return { __TS__SparseArraySpread(____array_0) }
end
function sl_modifier_bless_10078.prototype.OnTooltip(self)
	return self._params_10078.movespeed
end
function sl_modifier_bless_10078.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	sl_modifier_shield_all.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self._params_10078 = params
end
function sl_modifier_bless_10078.prototype._ApplyParam(self, params)
	self:_SetParentAttr("ys", params.movespeed)
	sl_modifier_shield_all.prototype._ApplyParam(self, params)
end
function sl_modifier_bless_10078.prototype.AddCustomTransmitterData(self)
	return __TS__ObjectAssign({}, sl_modifier_shield_all.prototype.AddCustomTransmitterData(self), self._params_10078)
end
function sl_modifier_bless_10078.prototype.HandleCustomTransmitterData(self, data)
	self._params_10078 = data
	sl_modifier_shield_all.prototype.HandleCustomTransmitterData(self, data)
end
function sl_modifier_bless_10078.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
end
sl_modifier_bless_10078 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10078") },
	sl_modifier_bless_10078
)
____exports.sl_modifier_bless_10078 = sl_modifier_bless_10078
return ____exports