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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10071 = __TS__Class()
local sl_modifier_bless_10071 = ____exports.sl_modifier_bless_10071
sl_modifier_bless_10071.name = "sl_modifier_bless_10071"
__TS__ClassExtends(sl_modifier_bless_10071, SLModifierBase)
function sl_modifier_bless_10071.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_bless_10071.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local ____params_hp_pct_0 = params
	if ____params_hp_pct_0 ~= nil then
		____params_hp_pct_0 = ____params_hp_pct_0.hp_pct
	end
	local ____temp_4 = not ____params_hp_pct_0
	if not ____temp_4 then
		local ____params_dmg_pct_2 = params
		if ____params_dmg_pct_2 ~= nil then
			____params_dmg_pct_2 = ____params_dmg_pct_2.dmg_pct
		end
		____temp_4 = not ____params_dmg_pct_2
	end
	if ____temp_4 then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_bless_10071.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	self._params = params
end
function sl_modifier_bless_10071.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10071.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_5 = event
	local attacker = ____event_5.attacker
	local target = ____event_5.target
	local parent = self:GetParent()
	if attacker ~= parent then
		return
	end
	if not IsValidAlive(target) then
		return
	end
	if attacker == target then
		return
	end
	local hp_pct = target:GetHealthPercent()
	if hp_pct > self._params.hp_pct then
		return
	end
	return self._params.dmg_pct
end
sl_modifier_bless_10071 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10071") },
	sl_modifier_bless_10071
)
____exports.sl_modifier_bless_10071 = sl_modifier_bless_10071
return ____exports