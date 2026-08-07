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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10168 = __TS__Class()
local sl_modifier_bless_10168 = ____exports.sl_modifier_bless_10168
sl_modifier_bless_10168.name = "sl_modifier_bless_10168"
__TS__ClassExtends(sl_modifier_bless_10168, SLModifierBase)
function sl_modifier_bless_10168.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10168.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._params = params
end
function sl_modifier_bless_10168.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local ____temp_2 = not params
	if not ____temp_2 then
		local ____params_update_data_0 = params
		if ____params_update_data_0 ~= nil then
			____params_update_data_0 = ____params_update_data_0.update_data
		end
		____temp_2 = ____params_update_data_0 ~= 1
	end
	if ____temp_2 then
		return
	end
	self._params = params
end
function sl_modifier_bless_10168.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	if not self._params then
		return
	end
	local parent = self:GetParent()
	local ____event_3 = event
	local attacker = ____event_3.attacker
	local target = ____event_3.target
	if parent ~= attacker then
		return
	end
	local target_hp = target:GetHealth()
	local parent_hp = parent:GetHealth()
	if parent_hp >= target_hp then
		return
	end
	local diff_pct = (target_hp - parent_hp) / parent_hp * 100
	if diff_pct < self._params.pct_threshold then
		return
	end
	local mul_times = math.floor(diff_pct / self._params.pct_threshold)
	local out_pct = math.min(self._params.pct_bonus * mul_times, self._params.pct_bonus_max)
	return out_pct
end
sl_modifier_bless_10168 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10168") },
	sl_modifier_bless_10168
)
____exports.sl_modifier_bless_10168 = sl_modifier_bless_10168
return ____exports