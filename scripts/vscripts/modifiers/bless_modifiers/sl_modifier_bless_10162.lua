--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10162.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10162.lua",
	{
		["10"] = "2:1",
		["11"] = "2:10",
		["12"] = "4:1",
		["13"] = "4:10",
		["15"] = "9:1",
		["16"] = "10:14",
		["17"] = "9:1",
		["18"] = "10:38",
		["19"] = "11:5",
		["20"] = "12:9",
		["21"] = "11:5",
		["22"] = "15:5",
		["23"] = "16:9",
		["24"] = "15:5",
		["25"] = "19:5",
		["26"] = "20:9",
		["27"] = "19:5",
		["28"] = "23:5",
		["29"] = "10:46",
		["30"] = "25:9",
		["31"] = "26:9",
		["32"] = "23:5",
		["33"] = "29:5",
		["34"] = "30:14",
		["37"] = "31:15",
		["38"] = "32:15",
		["39"] = "33:14",
		["42"] = "34:14",
		["45"] = "35:9",
		["46"] = "36:13",
		["47"] = "37:13",
		["48"] = "38:13",
		["49"] = "39:13",
		["50"] = "35:33",
		["51"] = "29:5",
		["52"] = "43:5",
		["53"] = "44:15",
		["54"] = "45:16",
		["55"] = "45:64",
		["56"] = "45:64",
		["57"] = "45:64",
		["59"] = "45:64",
		["61"] = "45:64",
		["63"] = "45:9",
		["64"] = "43:5",
		["65"] = "49:5",
		["66"] = "50:9",
		["67"] = "49:5",
		["68"] = "10:14",
		["69"] = "9:2",
		["70"] = "9:2",
		["71"] = "9:19",
		["72"] = "9:2",
		["74"] = "9:2",
		["75"] = "10:14",
		["77"] = "10:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data_debuff = ____sl_modifier_simple.sl_modifier_transmitter_data_debuff
--- 10162
____exports.sl_modifier_bless_10162 = __TS__Class()
local sl_modifier_bless_10162 = ____exports.sl_modifier_bless_10162
sl_modifier_bless_10162.name = "sl_modifier_bless_10162"
__TS__ClassExtends(sl_modifier_bless_10162, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10162.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10162.prototype.GetTexture(self)
	return "buff/bless/10162"
end
function sl_modifier_bless_10162.prototype.GetEffectName(self)
	return BLESS_PARTICLES.bless_10162_debuff
end
function sl_modifier_bless_10162.prototype.OnCreated(self, params)
	sl_modifier_transmitter_data_debuff.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(false)
	self:StartIntervalThink(1)
end
function sl_modifier_bless_10162.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValidAlive(parent) then
		return
	end
	if not self._bless then
		return
	end
	self._bless:ApplyDamage({
		attacker = caster,
		damage = self:_GetDamage(),
		damage_type = DAMAGE_TYPE_PHYSICAL,
		victim = parent,
	})
end
function sl_modifier_bless_10162.prototype._GetDamage(self)
	local caster = self:GetCaster()
	local ____temp_3 = caster:GetAverageTrueAttackDamage(nil)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	local ____table__params_pct_0_2 = ____table__params_pct_0
	if ____table__params_pct_0_2 == nil then
		____table__params_pct_0_2 = 0
	end
	return ____temp_3 * ____table__params_pct_0_2 * self:GetStackCount() * 0.01
end
function sl_modifier_bless_10162.prototype.SetSourceBless(self, bless)
	self._bless = bless
end
sl_modifier_bless_10162 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10162", nil, getfenv()) },
	sl_modifier_bless_10162
)
____exports.sl_modifier_bless_10162 = sl_modifier_bless_10162
return ____exports