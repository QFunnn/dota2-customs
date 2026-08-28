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
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点力量提升{hp_per_str}生命值，每点力量或敏捷提升{batk_per_str_agi}基础攻击力<br>
-- 变身期间：超出基准的实时移速转化为攻速和攻击力，并可突破移速上限。
-- Ignore 与转化数值均在双端直接计算，无需 Transmitter。
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
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}
end
function sl_modifier_rune_lycan_body.prototype.GetModifierBaseAttack_BonusDamage(self)
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
function sl_modifier_rune_lycan_body.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_lycan_body.prototype._IsShapeshiftActive(self)
	local parent = self:GetParent()
	return IsValid(parent) and parent:HasModifier("modifier_lycan_shapeshift")
end
function sl_modifier_rune_lycan_body.prototype.GetModifierIgnoreMovespeedLimit(self)
	return self:_IsShapeshiftActive() and 1 or 0
end
function sl_modifier_rune_lycan_body.prototype._GetShapeshiftAttackSpeedBonus(self)
	local parent = self:GetParent()
	if not IsValid(parent) or not self:_IsShapeshiftActive() then
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