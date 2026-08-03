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
--- 每点智力提升{amp_per_int}%技能增强，每点智力或力量提升{hp_per_int_str}生命值<br>
-- 死亡守卫（治疗/伤害）数值固定为自身{heal_dmg_hp}%最大生命值
____exports.sl_modifier_rune_warlock_shadow_word = __TS__Class()
local sl_modifier_rune_warlock_shadow_word = ____exports.sl_modifier_rune_warlock_shadow_word
sl_modifier_rune_warlock_shadow_word.name = "sl_modifier_rune_warlock_shadow_word"
__TS__ClassExtends(sl_modifier_rune_warlock_shadow_word, sl_modifier_rune_base)
function sl_modifier_rune_warlock_shadow_word.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_HEALTH_BONUS }
end
function sl_modifier_rune_warlock_shadow_word.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_warlock_shadow_word.prototype.GetModifierHealthBonus(self)
	local int_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_int_str")
		end
	)
	local str_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_int_str")
		end
	)
	return int_hp + str_hp
end
function sl_modifier_rune_warlock_shadow_word.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
	self:OnIntervalThink()
end
function sl_modifier_rune_warlock_shadow_word.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local heal_dmg_hp = self:_GetRuneSpecialValue("heal_dmg_hp")
	local base_override = math.floor(parent:GetMaxHealth() * heal_dmg_hp / 100)
	if base_override == self._last_base_override then
		return
	end
	self._last_base_override = base_override
	SLModules.AbilityAmp:SetAbilityAmpBySource(
		parent:GetPlayerOwnerID(),
		{ warlock_shadow_word = { damage = { c = { all_level_values = base_override } } } },
		tostring(self)
	)
end
function sl_modifier_rune_warlock_shadow_word.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		SLModules.AbilityAmp:RemoveAbilityAmpBySource(parent:GetPlayerOwnerID(), tostring(self))
	end
end
sl_modifier_rune_warlock_shadow_word = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_shadow_word") },
	sl_modifier_rune_warlock_shadow_word
)
____exports.sl_modifier_rune_warlock_shadow_word = sl_modifier_rune_warlock_shadow_word
return ____exports