--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10135.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10135.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "4:1",
		["15"] = "4:26",
		["16"] = "6:1",
		["17"] = "7:14",
		["18"] = "6:1",
		["19"] = "7:38",
		["20"] = "8:5",
		["21"] = "9:9",
		["22"] = "8:5",
		["23"] = "12:5",
		["24"] = "13:9",
		["25"] = "12:5",
		["26"] = "16:5",
		["27"] = "17:16",
		["28"] = "17:16",
		["29"] = "17:16",
		["31"] = "17:9",
		["32"] = "16:5",
		["33"] = "20:5",
		["34"] = "21:9",
		["35"] = "20:5",
		["36"] = "7:14",
		["37"] = "6:2",
		["38"] = "6:2",
		["39"] = "6:19",
		["40"] = "6:2",
		["42"] = "6:2",
		["43"] = "7:14",
		["45"] = "7:14",
		["46"] = "29:1",
		["47"] = "30:14",
		["48"] = "29:1",
		["49"] = "30:45",
		["50"] = "31:5",
		["51"] = "32:9",
		["52"] = "31:5",
		["53"] = "35:5",
		["54"] = "36:9",
		["55"] = "35:5",
		["56"] = "39:5",
		["57"] = "40:9",
		["58"] = "39:5",
		["59"] = "45:5",
		["60"] = "46:9",
		["61"] = "45:5",
		["62"] = "49:5",
		["63"] = "50:9",
		["64"] = "49:5",
		["65"] = "60:5",
		["66"] = "61:14",
		["69"] = "62:15",
		["70"] = "63:9",
		["71"] = "64:9",
		["72"] = "65:9",
		["73"] = "66:9",
		["74"] = "67:9",
		["75"] = "68:9",
		["76"] = "60:5",
		["77"] = "71:5",
		["78"] = "72:14",
		["79"] = "72:26",
		["81"] = "73:15",
		["82"] = "74:15",
		["83"] = "75:15",
		["84"] = "76:15",
		["85"] = "77:15",
		["86"] = "78:15",
		["87"] = "86:15",
		["88"] = "87:15",
		["89"] = "88:15",
		["90"] = "91:13",
		["91"] = "92:13",
		["92"] = "94:17",
		["93"] = "96:17",
		["95"] = "99:17",
		["98"] = "106:19",
		["99"] = "107:17",
		["100"] = "109:23",
		["101"] = "110:23",
		["102"] = "111:17",
		["105"] = "115:9",
		["106"] = "71:5",
		["107"] = "30:14",
		["108"] = "29:2",
		["109"] = "29:2",
		["110"] = "29:19",
		["111"] = "29:2",
		["113"] = "29:2",
		["114"] = "30:14",
		["116"] = "30:14",
	}
)
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10135", nil, getfenv()) },
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10135", nil, getfenv()) },
	sl_modifier_bless_10135_debuff
)
____exports.sl_modifier_bless_10135_debuff = sl_modifier_bless_10135_debuff
return ____exports