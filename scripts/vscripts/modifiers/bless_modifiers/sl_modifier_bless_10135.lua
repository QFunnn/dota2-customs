--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
____exports.sl_modifier_bless_10135 = __TS__Class()
local sl_modifier_bless_10135 = ____exports.sl_modifier_bless_10135
sl_modifier_bless_10135.name = "sl_modifier_bless_10135"
__TS__ClassExtends(sl_modifier_bless_10135, sl_modifier_transmitter_data)
function sl_modifier_bless_10135.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10135.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10135.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____table__params_atk_0 = self._params
	if ____table__params_atk_0 ~= nil then
		____table__params_atk_0 = ____table__params_atk_0.atk
	end
	return ____table__params_atk_0
end
function sl_modifier_bless_10135.prototype.GetTexture(self)
	return "buff/bless/10135"
end
sl_modifier_bless_10135 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10135") },
	sl_modifier_bless_10135
)
____exports.sl_modifier_bless_10135 = sl_modifier_bless_10135
____exports.sl_modifier_bless_10135_debuff = __TS__Class()
local sl_modifier_bless_10135_debuff = ____exports.sl_modifier_bless_10135_debuff
sl_modifier_bless_10135_debuff.name = "sl_modifier_bless_10135_debuff"
__TS__ClassExtends(sl_modifier_bless_10135_debuff, SLModifierBase_Debuff)
function sl_modifier_bless_10135_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10135_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10135_debuff.prototype.CheckState(self)
	return { [MODIFIER_STATE_TETHERED] = true }
end
function sl_modifier_bless_10135_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_LIMIT }
end
function sl_modifier_bless_10135_debuff.prototype.GetTexture(self)
	return "buff/bless/10135"
end
function sl_modifier_bless_10135_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self._half_width = 50
	self._center = caster:GetAbsOrigin()
	self._range = params.range
	self._max_speed = 550
	self._min_speed = 0.1
	self._max_min = self._max_speed - self._min_speed
end
function sl_modifier_bless_10135_debuff.prototype.GetModifierMoveSpeed_Limit(self)
	if not IsServer() then
		return nil
	end
	local parent = self:GetParent()
	local parent_pos = parent:GetAbsOrigin()
	local direction = parent_pos:__sub(self._center)
	local dir = SLVector:Normalized2D(direction)
	local distance = direction:Length2D()
	local wall_radius = self._range - distance
	local parent_angle = VectorToAngles(dir).y
	local unit_angle = parent:GetAnglesAsVector().y
	local wall_angle = math.abs(AngleDiff(parent_angle, unit_angle))
	local limit = 0
	if wall_angle <= 90 then
		if wall_radius < 0 then
			limit = self._min_speed
		else
			limit = wall_radius / self._half_width * self._max_min + self._min_speed
		end
	else
		local threshold = 10
		if distance > self._range + threshold then
			local safe_distance = self._range - 5
			local fixed_pos = self._center:__add(dir:__mul(safe_distance))
			FindClearSpaceForUnit(parent, fixed_pos, false)
		end
	end
	return limit
end
sl_modifier_bless_10135_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10135") },
	sl_modifier_bless_10135_debuff
)
____exports.sl_modifier_bless_10135_debuff = sl_modifier_bless_10135_debuff
return ____exports