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
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点敏捷提升{batk_per_agi}基础攻击力，每点敏捷或力量提升{hp_per_agi_str}生命值<br>
-- 变身状态下（人狼合一），超出基准值的移动速度按比例转化为攻击速度和前摇伤害（不改变移动速度上限）
____exports.sl_modifier_rune_lycan_body = __TS__Class()
local sl_modifier_rune_lycan_body = ____exports.sl_modifier_rune_lycan_body
sl_modifier_rune_lycan_body.name = "sl_modifier_rune_lycan_body"
__TS__ClassExtends(sl_modifier_rune_lycan_body, sl_modifier_rune_base)
function sl_modifier_rune_lycan_body.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end
function sl_modifier_rune_lycan_body.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_lycan_body.prototype.GetModifierHealthBonus(self)
	local agi_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_agi_str")
		end
	)
	local str_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_agi_str")
		end
	)
	return agi_hp + str_hp
end
function sl_modifier_rune_lycan_body.prototype._GetShapeshiftAttackSpeedBonus(self)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return 0
	end
	if not parent:HasModifier("modifier_lycan_shapeshift") then
		return 0
	end
	local move_speed_per_as = self:_GetRuneSpecialValue("move_speed_per_as")
	if move_speed_per_as <= 0 then
		return 0
	end
	local move_speed_baseline = self:_GetRuneSpecialValue("move_speed_baseline")
	local atk_speed_cap = self:_GetRuneSpecialValue("atk_speed_cap")
	local move_speed = parent:GetMoveSpeedModifier(parent:GetBaseMoveSpeed(), false)
	local excess = math.max(0, move_speed - move_speed_baseline)
	local as_from_ms = math.floor(excess / move_speed_per_as)
	return math.min(as_from_ms, atk_speed_cap)
end
function sl_modifier_rune_lycan_body.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return self:_GetShapeshiftAttackSpeedBonus()
end
function sl_modifier_rune_lycan_body.prototype.GetModifierPreAttack_BonusDamage(self)
	return self:_GetShapeshiftAttackSpeedBonus()
end
sl_modifier_rune_lycan_body = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_lycan_body") },
	sl_modifier_rune_lycan_body
)
____exports.sl_modifier_rune_lycan_body = sl_modifier_rune_lycan_body
return ____exports