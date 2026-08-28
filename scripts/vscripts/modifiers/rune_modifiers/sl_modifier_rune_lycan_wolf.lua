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
-- 召狼直接产生的狼继承狼人{wolf_atk_pct}%攻击速度和攻击力、{wolf_hp_pct}%生命值（SetSummonAmp，同蛇影）
____exports.sl_modifier_rune_lycan_wolf = __TS__Class()
local sl_modifier_rune_lycan_wolf = ____exports.sl_modifier_rune_lycan_wolf
sl_modifier_rune_lycan_wolf.name = "sl_modifier_rune_lycan_wolf"
__TS__ClassExtends(sl_modifier_rune_lycan_wolf, sl_modifier_rune_base)
function sl_modifier_rune_lycan_wolf.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._record_as = -1
	self._record_atk = -1
	self._record_hp = -1
end
function sl_modifier_rune_lycan_wolf.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
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
function sl_modifier_rune_lycan_wolf.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("wolf_atk_pct")
end
function sl_modifier_rune_lycan_wolf.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("wolf_hp_pct")
end
function sl_modifier_rune_lycan_wolf.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local wolf_atk_pct = self:_GetRuneSpecialValue("wolf_atk_pct")
	local wolf_hp_pct = self:_GetRuneSpecialValue("wolf_hp_pct")
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValid(parent) then
			return nil
		end
		local as_display = parent:GetAttackSpeed(true) * 100
		local atk = parent:GetAverageTrueAttackDamage(nil)
		local hp = parent:GetMaxHealth()
		if as_display == self._record_as and atk == self._record_atk and hp == self._record_hp then
			return 1
		end
		self._record_as = as_display
		self._record_atk = atk
		self._record_hp = hp
		local amp = {
			as_bonus = as_display * (wolf_atk_pct / 100),
			atk_bonus = atk * (wolf_atk_pct / 100),
			hp_bonus = hp * (wolf_hp_pct / 100),
		}
		local attr_manager = GlobalAttrManager:Get(parent:GetPlayerOwnerID())
		for ____, unit_name in ipairs(LYCAN_WOLF_UNIT_NAMES) do
			attr_manager:SetSummonAmp(tostring(self), unit_name, amp)
		end
		return 1
	end)
end
function sl_modifier_rune_lycan_wolf.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	GlobalAttrManager:Get(parent:GetPlayerOwnerID()):RemoveAllSummonAmpBySource(tostring(self))
end
sl_modifier_rune_lycan_wolf = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_lycan_wolf") },
	sl_modifier_rune_lycan_wolf
)
____exports.sl_modifier_rune_lycan_wolf = sl_modifier_rune_lycan_wolf
return ____exports