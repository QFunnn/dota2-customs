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
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 力量转生命；力量或敏捷转基础攻击力。
-- 专属：召狼直接产生的狼继承狼人攻击速度/攻击力/生命值比例。
____exports.sl_modifier_rune_lycan_wolf = __TS__Class()
local sl_modifier_rune_lycan_wolf = ____exports.sl_modifier_rune_lycan_wolf
sl_modifier_rune_lycan_wolf.name = "sl_modifier_rune_lycan_wolf"
__TS__ClassExtends(sl_modifier_rune_lycan_wolf, sl_modifier_rune_base)
function sl_modifier_rune_lycan_wolf.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE }
end
function sl_modifier_rune_lycan_wolf.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_lycan_wolf.prototype.GetModifierBaseAttack_BonusDamage(self)
	local str_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_str_agi")
		end
	)
	local agi_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_str_agi")
		end
	)
	return str_atk + agi_atk
end
function sl_modifier_rune_lycan_wolf.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	LocalEvents:Register(tostring(self), "unit_spawn", function(____, event)
		local unit = event.unit
		if not IsValid(unit) or unit:IsHero() then
			return
		end
		local parent = self:GetParent()
		if not IsValid(parent) or unit:GetOwner() ~= parent then
			return
		end
		if not __TS__StringIncludes(unit:GetUnitName(), "npc_dota_lycan_wolf") then
			return
		end
		unit:AddSLModifier(____exports.sl_modifier_rune_lycan_wolf_summon, {
			caster = parent,
			modifierTable = {
				wolf_gs_pct = self:_GetRuneSpecialValue("wolf_gs_pct"),
				wolf_atk_pct = self:_GetRuneSpecialValue("wolf_atk_pct"),
				wolf_hp_pct = self:_GetRuneSpecialValue("wolf_hp_pct"),
			},
		})
	end, self)
end
function sl_modifier_rune_lycan_wolf.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	LocalEvents:Remove("unit_spawn", self)
end
sl_modifier_rune_lycan_wolf = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_lycan_wolf") },
	sl_modifier_rune_lycan_wolf
)
____exports.sl_modifier_rune_lycan_wolf = sl_modifier_rune_lycan_wolf
____exports.sl_modifier_rune_lycan_wolf_summon = __TS__Class()
local sl_modifier_rune_lycan_wolf_summon = ____exports.sl_modifier_rune_lycan_wolf_summon
sl_modifier_rune_lycan_wolf_summon.name = "sl_modifier_rune_lycan_wolf_summon"
__TS__ClassExtends(sl_modifier_rune_lycan_wolf_summon, SLModifierBase)
function sl_modifier_rune_lycan_wolf_summon.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._gs = 0
	self._atk_pct = 0
	self._hp_pct = 0
end
function sl_modifier_rune_lycan_wolf_summon.prototype.IsHidden(self)
	return true
end
function sl_modifier_rune_lycan_wolf_summon.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____params_wolf_gs_pct_0 = params.wolf_gs_pct
	if ____params_wolf_gs_pct_0 == nil then
		____params_wolf_gs_pct_0 = 0
	end
	self._gs = ____params_wolf_gs_pct_0
	local ____params_wolf_atk_pct_1 = params.wolf_atk_pct
	if ____params_wolf_atk_pct_1 == nil then
		____params_wolf_atk_pct_1 = 0
	end
	self._atk_pct = ____params_wolf_atk_pct_1
	local ____params_wolf_hp_pct_2 = params.wolf_hp_pct
	if ____params_wolf_hp_pct_2 == nil then
		____params_wolf_hp_pct_2 = 0
	end
	self._hp_pct = ____params_wolf_hp_pct_2
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function sl_modifier_rune_lycan_wolf_summon.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
	}
end
function sl_modifier_rune_lycan_wolf_summon.prototype.GetModifierAttackSpeedBonus_Constant(self)
	local caster = self:GetCaster()
	if not IsValid(caster) or not caster:IsHero() then
		return 0
	end
	return caster:GetAttackSpeed(true) * 100 * (self._gs / 100)
end
function sl_modifier_rune_lycan_wolf_summon.prototype.GetModifierBaseDamageOutgoing_Percentage(self)
	return self._atk_pct
end
function sl_modifier_rune_lycan_wolf_summon.prototype.GetModifierExtraHealthPercentage(self)
	return self._hp_pct
end
function sl_modifier_rune_lycan_wolf_summon.prototype.AddCustomTransmitterData(self)
	return { wolf_gs_pct = self._gs, wolf_atk_pct = self._atk_pct, wolf_hp_pct = self._hp_pct }
end
function sl_modifier_rune_lycan_wolf_summon.prototype.HandleCustomTransmitterData(self, data)
	local ____data_wolf_gs_pct_3 = data
	if ____data_wolf_gs_pct_3 ~= nil then
		____data_wolf_gs_pct_3 = ____data_wolf_gs_pct_3.wolf_gs_pct
	end
	local ____data_wolf_gs_pct_3_5 = ____data_wolf_gs_pct_3
	if ____data_wolf_gs_pct_3_5 == nil then
		____data_wolf_gs_pct_3_5 = 0
	end
	self._gs = ____data_wolf_gs_pct_3_5
	local ____data_wolf_atk_pct_6 = data
	if ____data_wolf_atk_pct_6 ~= nil then
		____data_wolf_atk_pct_6 = ____data_wolf_atk_pct_6.wolf_atk_pct
	end
	local ____data_wolf_atk_pct_6_8 = ____data_wolf_atk_pct_6
	if ____data_wolf_atk_pct_6_8 == nil then
		____data_wolf_atk_pct_6_8 = 0
	end
	self._atk_pct = ____data_wolf_atk_pct_6_8
	local ____data_wolf_hp_pct_9 = data
	if ____data_wolf_hp_pct_9 ~= nil then
		____data_wolf_hp_pct_9 = ____data_wolf_hp_pct_9.wolf_hp_pct
	end
	local ____data_wolf_hp_pct_9_11 = ____data_wolf_hp_pct_9
	if ____data_wolf_hp_pct_9_11 == nil then
		____data_wolf_hp_pct_9_11 = 0
	end
	self._hp_pct = ____data_wolf_hp_pct_9_11
end
sl_modifier_rune_lycan_wolf_summon = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_lycan_wolf") },
	sl_modifier_rune_lycan_wolf_summon
)
____exports.sl_modifier_rune_lycan_wolf_summon = sl_modifier_rune_lycan_wolf_summon
return ____exports