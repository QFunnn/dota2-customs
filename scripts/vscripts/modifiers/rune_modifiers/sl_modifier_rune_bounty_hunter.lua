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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点力量提升{hp_per_str}生命值，每点敏捷提升{batk_per_agi}基础攻击力，每点智力提升{amp_per_int}%技能增强<br>忍术窃取金钱+{gold_bonus_pct}%，追踪术金钱奖励+{gold_bonus_pct}%
____exports.sl_modifier_rune_bounty_hunter = __TS__Class()
local sl_modifier_rune_bounty_hunter = ____exports.sl_modifier_rune_bounty_hunter
sl_modifier_rune_bounty_hunter.name = "sl_modifier_rune_bounty_hunter"
__TS__ClassExtends(sl_modifier_rune_bounty_hunter, sl_modifier_rune_base)
function sl_modifier_rune_bounty_hunter.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function sl_modifier_rune_bounty_hunter.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_bounty_hunter.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_bounty_hunter.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_bounty_hunter.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local gold_bonus_pct = self:_GetRuneSpecialValue("gold_bonus_pct")
	self._gold_bonus_pct = gold_bonus_pct
	local parent = self:GetParent()
	local player_owner_id = parent:GetPlayerOwnerID()
	SLModules.AbilityAmp:SetAbilityAmpBySource(
		player_owner_id,
		{
			bounty_hunter_jinada = { gold_steal = { a = { all_level_values = gold_bonus_pct } } },
			bounty_hunter_track = {
				bonus_gold_self = { a = { all_level_values = gold_bonus_pct } },
				bonus_gold = { a = { all_level_values = gold_bonus_pct } },
			},
		},
		tostring(self)
	)
	self:SendBuffRefreshToClients()
end
function sl_modifier_rune_bounty_hunter.prototype.OnTooltip(self)
	return self._gold_bonus_pct
end
function sl_modifier_rune_bounty_hunter.prototype.HandleCustomTransmitterData(self, data)
	sl_modifier_rune_base.prototype.HandleCustomTransmitterData(self, data)
	local ____data_gold_bonus_pct_0 = data
	if ____data_gold_bonus_pct_0 ~= nil then
		____data_gold_bonus_pct_0 = ____data_gold_bonus_pct_0.gold_bonus_pct
	end
	self._gold_bonus_pct = ____data_gold_bonus_pct_0
end
function sl_modifier_rune_bounty_hunter.prototype.AddCustomTransmitterData(self)
	return __TS__ObjectAssign(
		{},
		sl_modifier_rune_base.prototype.AddCustomTransmitterData(self),
		{ gold_bonus_pct = self._gold_bonus_pct }
	)
end
sl_modifier_rune_bounty_hunter = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_bounty_hunter") },
	sl_modifier_rune_bounty_hunter
)
____exports.sl_modifier_rune_bounty_hunter = sl_modifier_rune_bounty_hunter
return ____exports