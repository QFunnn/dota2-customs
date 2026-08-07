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
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 10200 - 福佑持有者身上的buff
-- 对恩人造成额外伤害，受到恩人额外伤害
____exports.sl_modifier_bless_10200 = __TS__Class()
local sl_modifier_bless_10200 = ____exports.sl_modifier_bless_10200
sl_modifier_bless_10200.name = "sl_modifier_bless_10200"
__TS__ClassExtends(sl_modifier_bless_10200, sl_modifier_transmitter_data)
function sl_modifier_bless_10200.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10200.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_bless_10200.prototype.SetBenefactor(self, hero)
	self._benefactor = hero
end
function sl_modifier_bless_10200.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsValid(self._benefactor) then
		return nil
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	local parent = self:GetParent()
	if attacker == parent and target == self._benefactor then
		local ____table__params_sh_pct_1 = self._params
		if ____table__params_sh_pct_1 ~= nil then
			____table__params_sh_pct_1 = ____table__params_sh_pct_1.sh_pct
		end
		return ____table__params_sh_pct_1
	end
end
function sl_modifier_bless_10200.prototype.GetModifierIncomingDamage_Percentage(self, event)
	if not IsValid(self._benefactor) then
		return nil
	end
	local ____event_3 = event
	local attacker = ____event_3.attacker
	local target = ____event_3.target
	local parent = self:GetParent()
	if parent == target and attacker == self._benefactor then
		local ____table__params_cs_pct_4 = self._params
		if ____table__params_cs_pct_4 ~= nil then
			____table__params_cs_pct_4 = ____table__params_cs_pct_4.cs_pct
		end
		return ____table__params_cs_pct_4
	end
end
sl_modifier_bless_10200 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10200") },
	sl_modifier_bless_10200
)
____exports.sl_modifier_bless_10200 = sl_modifier_bless_10200
return ____exports