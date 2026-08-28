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
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
local ABILITY_FLAMING_FISTS = "warlock_golem_flaming_fists"
local ABILITY_PERMANENT_IMMOLATION = "warlock_golem_permanent_immolation"
--- 烈焰之拳被动 modifier：改 damage KV 后需 ForceRefresh 才会吃到新值
local MODIFIER_FLAMING_FISTS = "modifier_warlock_golem_flaming_fists"
--- 每点智力提升{amp_per_int}%技能增强，每点智力或力量提升{hp_per_int_str}生命值<br>
-- 地狱火继承术士{golem_hp_inherit_pct}%生命值（AbilityAmp 加算 golem_hp）；
-- 烈焰之拳 / 永久献祭各自 + 最大生命值×{dmg_hp_pct}% 伤害（先计入英雄技能增强后覆写技能 KV，每秒重算）
____exports.sl_modifier_rune_warlock_golem = __TS__Class()
local sl_modifier_rune_warlock_golem = ____exports.sl_modifier_rune_warlock_golem
sl_modifier_rune_warlock_golem.name = "sl_modifier_rune_warlock_golem"
__TS__ClassExtends(sl_modifier_rune_warlock_golem, sl_modifier_rune_base)
function sl_modifier_rune_warlock_golem.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._record_hp = -1
end
function sl_modifier_rune_warlock_golem.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function sl_modifier_rune_warlock_golem.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_warlock_golem.prototype.GetModifierHealthBonus(self)
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
function sl_modifier_rune_warlock_golem.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("golem_hp_inherit_pct")
end
function sl_modifier_rune_warlock_golem.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("dmg_hp_pct")
end
function sl_modifier_rune_warlock_golem.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local golem_hp_inherit_pct = self:_GetRuneSpecialValue("golem_hp_inherit_pct")
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValid(parent) then
			return nil
		end
		local hp = parent:GetMaxHealth()
		if hp == self._record_hp then
			return 1
		end
		self._record_hp = hp
		local bonus = hp * golem_hp_inherit_pct / 100
		SLModules.AbilityAmp:SetAbilityAmpBySource(
			parent:GetPlayerOwnerID(),
			{
				warlock_rain_of_chaos = {
					golem_hp = { b = { all_level_values = bonus } },
					golem_hp_scepter = { b = { all_level_values = bonus } },
				},
			},
			tostring(self)
		)
		return 1
	end)
	LocalEvents:Register(tostring(self), "unit_spawn", function(____, event)
		local unit = event.unit
		if not IsValid(unit) or unit:IsHero() then
			return
		end
		if not IsValid(parent) or unit:GetOwner() ~= parent then
			return
		end
		if not __TS__ArrayIncludes(WARLOCK_GOLEM_UNIT_NAMES, unit:GetUnitName()) then
			return
		end
		unit:AddSLModifier(____exports.sl_modifier_rune_warlock_golem_ability, {
			caster = parent,
			modifierTable = { dmg_hp_pct = self:_GetRuneSpecialValue("dmg_hp_pct") },
		})
	end, self)
end
function sl_modifier_rune_warlock_golem.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	LocalEvents:Remove("unit_spawn", self)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	SLModules.AbilityAmp:RemoveAbilityAmpBySource(parent:GetPlayerOwnerID(), tostring(self))
end
sl_modifier_rune_warlock_golem = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_golem") },
	sl_modifier_rune_warlock_golem
)
____exports.sl_modifier_rune_warlock_golem = sl_modifier_rune_warlock_golem
--- 地狱火技能 KV 覆写：每秒按主人技能增强重算额外伤害，写入烈焰之拳 damage / 永久献祭 aura_damage
____exports.sl_modifier_rune_warlock_golem_ability = __TS__Class()
local sl_modifier_rune_warlock_golem_ability = ____exports.sl_modifier_rune_warlock_golem_ability
sl_modifier_rune_warlock_golem_ability.name = "sl_modifier_rune_warlock_golem_ability"
__TS__ClassExtends(sl_modifier_rune_warlock_golem_ability, SLModifierBase)
function sl_modifier_rune_warlock_golem_ability.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._dmg_hp_pct = 0
	self._bonus_damage = 0
end
function sl_modifier_rune_warlock_golem_ability.prototype.IsHidden(self)
	return true
end
function sl_modifier_rune_warlock_golem_ability.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL, MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE }
end
function sl_modifier_rune_warlock_golem_ability.prototype.OnCreated(self, params)
	local ____params_dmg_hp_pct_0 = params.dmg_hp_pct
	if ____params_dmg_hp_pct_0 == nil then
		____params_dmg_hp_pct_0 = 0
	end
	self._dmg_hp_pct = ____params_dmg_hp_pct_0
	self:SetHasCustomTransmitterData(true)
	if not IsServer() then
		return
	end
	self:_RecalcBonusDamage()
	self:StartIntervalThink(1)
end
function sl_modifier_rune_warlock_golem_ability.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:_RecalcBonusDamage()
end
function sl_modifier_rune_warlock_golem_ability.prototype._RecalcBonusDamage(self)
	local golem = self:GetParent()
	if not IsValidAlive(golem) then
		return
	end
	local caster = self:GetCaster()
	local ____IsValid_result_1
	if IsValid(caster) then
		____IsValid_result_1 = caster:GetSpellAmplification(false)
	else
		____IsValid_result_1 = 0
	end
	local spell_amp = ____IsValid_result_1
	local next_bonus = golem:GetMaxHealth() * (self._dmg_hp_pct / 100) * (1 + spell_amp)
	if next_bonus == self._bonus_damage then
		return
	end
	self._bonus_damage = next_bonus
	self:SendBuffRefreshToClients()
	local ____golem_FindModifierByName_result_ForceRefresh_result_2 = golem:FindModifierByName(MODIFIER_FLAMING_FISTS)
	if ____golem_FindModifierByName_result_ForceRefresh_result_2 ~= nil then
		____golem_FindModifierByName_result_ForceRefresh_result_2 =
			____golem_FindModifierByName_result_ForceRefresh_result_2:ForceRefresh()
	end
end
function sl_modifier_rune_warlock_golem_ability.prototype.GetModifierOverrideAbilitySpecial(self, event)
	local ability_name = event.ability:GetAbilityName()
	local key = event.ability_special_value
	if ability_name == ABILITY_PERMANENT_IMMOLATION and key == "aura_damage" then
		return 1
	end
	if ability_name == ABILITY_FLAMING_FISTS and key == "damage" then
		return 1
	end
	return 0
end
function sl_modifier_rune_warlock_golem_ability.prototype.GetModifierOverrideAbilitySpecialValue(self, event)
	local ability = event.ability
	local original = ability:GetLevelSpecialValueNoOverride(event.ability_special_value, event.ability_special_level)
	local ability_name = ability:GetAbilityName()
	if ability_name == ABILITY_PERMANENT_IMMOLATION and event.ability_special_value == "aura_damage" then
		return original + self._bonus_damage
	end
	if ability_name == ABILITY_FLAMING_FISTS and event.ability_special_value == "damage" then
		return original + self._bonus_damage
	end
	return original
end
function sl_modifier_rune_warlock_golem_ability.prototype.HandleCustomTransmitterData(self, data)
	self._bonus_damage = data.bonus_damage
	self._dmg_hp_pct = data.dmg_hp_pct
end
function sl_modifier_rune_warlock_golem_ability.prototype.AddCustomTransmitterData(self)
	return { bonus_damage = self._bonus_damage, dmg_hp_pct = self._dmg_hp_pct }
end
sl_modifier_rune_warlock_golem_ability = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_golem") },
	sl_modifier_rune_warlock_golem_ability
)
____exports.sl_modifier_rune_warlock_golem_ability = sl_modifier_rune_warlock_golem_ability
return ____exports