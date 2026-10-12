--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_lina.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_lina.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["17"] = "9:1",
		["18"] = "10:14",
		["19"] = "9:1",
		["20"] = "10:36",
		["21"] = "11:5",
		["22"] = "12:9",
		["23"] = "11:5",
		["24"] = "20:5",
		["25"] = "21:9",
		["26"] = "21:16",
		["27"] = "23:13",
		["28"] = "24:13",
		["29"] = "21:16",
		["30"] = "20:5",
		["31"] = "28:5",
		["32"] = "29:15",
		["33"] = "29:25",
		["34"] = "31:13",
		["35"] = "32:13",
		["36"] = "29:25",
		["37"] = "34:15",
		["38"] = "34:25",
		["39"] = "36:13",
		["40"] = "37:13",
		["41"] = "34:25",
		["42"] = "39:9",
		["43"] = "28:5",
		["44"] = "42:5",
		["45"] = "43:9",
		["46"] = "42:5",
		["47"] = "46:5",
		["48"] = "47:14",
		["51"] = "48:38",
		["52"] = "48:17",
		["53"] = "48:27",
		["54"] = "49:15",
		["55"] = "50:13",
		["58"] = "51:14",
		["61"] = "52:13",
		["64"] = "53:15",
		["65"] = "54:13",
		["68"] = "55:15",
		["69"] = "56:9",
		["70"] = "57:13",
		["71"] = "58:13",
		["72"] = "59:13",
		["73"] = "60:13",
		["74"] = "61:13",
		["75"] = "56:21",
		["76"] = "46:5",
		["77"] = "10:14",
		["78"] = "9:2",
		["79"] = "9:2",
		["80"] = "9:19",
		["81"] = "9:2",
		["83"] = "9:2",
		["84"] = "10:14",
		["86"] = "10:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 战斗法师（火球术）
-- 每点智力提升{amp_per_int}%技能增强，每点智力或敏捷提升{batk_per_int_agi}基础攻击力<br>
-- 普通攻击额外造成{magic_damage}×等级点魔法伤害，该伤害享受技能增强加成（对建筑无效）
____exports.sl_modifier_rune_lina = __TS__Class()
local sl_modifier_rune_lina = ____exports.sl_modifier_rune_lina
sl_modifier_rune_lina.name = "sl_modifier_rune_lina"
__TS__ClassExtends(sl_modifier_rune_lina, sl_modifier_rune_base)
function sl_modifier_rune_lina.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function sl_modifier_rune_lina.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_lina.prototype.GetModifierBaseAttack_BonusDamage(self)
	local int_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_int_agi")
		end
	)
	local agi_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_int_agi")
		end
	)
	return int_atk + agi_atk
end
function sl_modifier_rune_lina.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("magic_damage")
end
function sl_modifier_rune_lina.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	local parent = self:GetParent()
	if attacker ~= parent then
		return
	end
	if not IsValidAlive(attacker) or not IsValidAlive(target) then
		return
	end
	if target:IsBuilding() then
		return
	end
	local magic_damage = self:_GetRuneSpecialValue("magic_damage")
	if magic_damage <= 0 then
		return
	end
	local damage = magic_damage * attacker:GetLevel()
	ApplyDamage({
		attacker = attacker,
		victim = target,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_FORCE_SPELL_AMPLIFICATION,
	})
end
sl_modifier_rune_lina = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_lina", nil, getfenv()) },
	sl_modifier_rune_lina
)
____exports.sl_modifier_rune_lina = sl_modifier_rune_lina
return ____exports