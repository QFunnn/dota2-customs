--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_bounty_hunter.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_bounty_hunter.lua",
	{
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:10",
		["16"] = "7:1",
		["17"] = "8:14",
		["18"] = "7:1",
		["19"] = "8:45",
		["20"] = "9:5",
		["21"] = "10:9",
		["22"] = "9:5",
		["23"] = "18:5",
		["24"] = "19:9",
		["25"] = "19:16",
		["26"] = "21:13",
		["27"] = "22:13",
		["28"] = "19:16",
		["29"] = "18:5",
		["30"] = "26:5",
		["31"] = "27:9",
		["32"] = "27:16",
		["33"] = "29:13",
		["34"] = "30:13",
		["35"] = "27:16",
		["36"] = "26:5",
		["37"] = "34:5",
		["38"] = "35:9",
		["39"] = "35:16",
		["40"] = "37:13",
		["41"] = "38:13",
		["42"] = "35:16",
		["43"] = "34:5",
		["44"] = "42:5",
		["45"] = "8:53",
		["46"] = "44:14",
		["49"] = "45:15",
		["50"] = "46:9",
		["51"] = "47:15",
		["52"] = "48:15",
		["53"] = "49:9",
		["54"] = "50:13",
		["55"] = "51:13",
		["56"] = "72:13",
		["57"] = "49:9",
		["58"] = "74:9",
		["59"] = "42:5",
		["60"] = "79:5",
		["61"] = "80:9",
		["62"] = "79:5",
		["63"] = "83:5",
		["64"] = "8:53",
		["65"] = "85:32",
		["66"] = "85:32",
		["67"] = "85:32",
		["69"] = "85:9",
		["70"] = "83:5",
		["71"] = "88:5",
		["72"] = "89:9",
		["73"] = "89:16",
		["74"] = "8:53",
		["75"] = "89:16",
		["76"] = "89:16",
		["77"] = "88:5",
		["78"] = "8:14",
		["79"] = "7:2",
		["80"] = "7:2",
		["81"] = "7:19",
		["82"] = "7:2",
		["84"] = "7:2",
		["85"] = "8:14",
		["87"] = "8:14",
	}
)
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
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_bounty_hunter", nil, getfenv()) },
	sl_modifier_rune_bounty_hunter
)
____exports.sl_modifier_rune_bounty_hunter = sl_modifier_rune_bounty_hunter
return ____exports