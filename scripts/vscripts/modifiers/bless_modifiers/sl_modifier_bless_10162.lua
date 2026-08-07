--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10162") },
	sl_modifier_bless_10162
)
____exports.sl_modifier_bless_10162 = sl_modifier_bless_10162
return ____exports