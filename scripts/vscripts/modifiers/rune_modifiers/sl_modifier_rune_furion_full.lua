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
local sl_modifier_debuff_immune = ____sl_modifier_simple.sl_modifier_debuff_immune
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强，每点智力或敏捷提升{batk_per_int_agi}基础攻击力<br>
-- 召唤树人直接产生的小树人继承先知{hp_pct}%生命值（SetSummonAmp）；传送施法期间减益免疫<br>
-- 自然之怒附带自身攻击力×{atk_pct}%魔法伤害（享受跳跃增伤/击杀放大）；对建筑伤害降低{building_damage_penalty_pct}%
____exports.sl_modifier_rune_furion_full = __TS__Class()
local sl_modifier_rune_furion_full = ____exports.sl_modifier_rune_furion_full
sl_modifier_rune_furion_full.name = "sl_modifier_rune_furion_full"
__TS__ClassExtends(sl_modifier_rune_furion_full, sl_modifier_rune_base)
function sl_modifier_rune_furion_full.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._record_hp = -1
	self._wrath_jump_index = 0
end
function sl_modifier_rune_furion_full.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function sl_modifier_rune_furion_full.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_furion_full.prototype.GetModifierBaseAttack_BonusDamage(self)
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
function sl_modifier_rune_furion_full.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____event_target_2 = event
	if ____event_target_2 ~= nil then
		____event_target_2 = ____event_target_2.target
	end
	local ____event_target_IsBuilding_result_0 = ____event_target_2
	if ____event_target_IsBuilding_result_0 ~= nil then
		____event_target_IsBuilding_result_0 = ____event_target_IsBuilding_result_0:IsBuilding()
	end
	if ____event_target_IsBuilding_result_0 then
		return -self:_GetRuneSpecialValue("building_damage_penalty_pct")
	end
	return 0
end
function sl_modifier_rune_furion_full.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("atk_pct")
end
function sl_modifier_rune_furion_full.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("hp_pct")
end
function sl_modifier_rune_furion_full.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local hp_pct = self:_GetRuneSpecialValue("hp_pct")
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValid(parent) then
			return nil
		end
		local hp = parent:GetMaxHealth()
		if hp == self._record_hp then
			return 1
		end
		self._record_hp = hp
		local amp = { hp_bonus = hp * hp_pct / 100 }
		local attr_manager = GlobalAttrManager:Get(parent:GetPlayerOwnerID())
		for ____, unit_name in ipairs(FURION_SMALL_TREANT_UNIT_NAMES) do
			attr_manager:SetSummonAmp(tostring(self), unit_name, amp)
		end
		return 1
	end)
	LocalEvents:Register(tostring(self), "modifier_added_parent", function(____, event)
		local ____event_4 = event
		local unit = ____event_4.unit
		local added_buff = ____event_4.added_buff
		if unit ~= parent or not IsValid(added_buff) then
			return
		end
		if added_buff:GetName() ~= "modifier_teleporting" then
			return
		end
		local ability = added_buff:GetAbility()
		if not IsValid(ability) or ability:GetAbilityName() ~= "furion_teleportation" then
			return
		end
		parent:RemoveSLModifierByType(____exports.sl_modifier_rune_furion_full_immune, parent)
		parent:AddSLModifier(
			____exports.sl_modifier_rune_furion_full_immune,
			{ caster = parent, no_error = true, modifierTable = { update_data = 1 } }
		)
		Timers:CreateTimer(0.03, function()
			if not IsValid(self) or not IsValid(parent) then
				return nil
			end
			if not IsValid(added_buff) then
				parent:RemoveSLModifierByType(____exports.sl_modifier_rune_furion_full_immune, parent)
				return nil
			end
			return 0.03
		end)
	end, self, parent:GetEntityIndex())
	LocalEvents:Register(tostring(self), "ability_fully_cast", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or ability:GetAbilityName() ~= "furion_wrath_of_nature" then
			return
		end
		self._wrath_jump_index = 0
	end, self, parent:GetEntityIndex())
	LocalEvents:Register(tostring(self), "apply_damage", function(____, event)
		local ____event_5 = event
		local attacker = ____event_5.attacker
		local inflictor = ____event_5.inflictor
		local unit = ____event_5.unit
		if attacker ~= parent or not IsValid(inflictor) or not IsValidAlive(unit) then
			return
		end
		if inflictor:GetAbilityName() ~= "furion_wrath_of_nature" then
			return
		end
		if unit:IsBuilding() then
			return
		end
		local atk_pct = self:_GetRuneSpecialValue("atk_pct")
		local damage_percent_add = inflictor:GetSpecialValueFor("damage_percent_add")
		local jump_mult = 1 + self._wrath_jump_index * damage_percent_add / 100
		self._wrath_jump_index = self._wrath_jump_index + 1
		local damage = parent:GetAverageTrueAttackDamage(nil) * atk_pct * 0.01 * jump_mult
		if damage > 0 then
			ApplyDamage({ attacker = parent, victim = unit, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
		end
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_furion_full.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		GlobalAttrManager:Get(parent:GetPlayerOwnerID()):RemoveAllSummonAmpBySource(tostring(self))
		LocalEvents:Remove("modifier_added_parent", self, parent:GetEntityIndex())
		LocalEvents:Remove("ability_fully_cast", self, parent:GetEntityIndex())
		LocalEvents:Remove("apply_damage", self, parent:GetEntityIndex())
		parent:RemoveSLModifierByType(____exports.sl_modifier_rune_furion_full_immune, parent)
	end
end
sl_modifier_rune_furion_full = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_furion_full") },
	sl_modifier_rune_furion_full
)
____exports.sl_modifier_rune_furion_full = sl_modifier_rune_furion_full
--- 传送引导期间减益免疫（绑定 modifier_teleporting，通用特效）
____exports.sl_modifier_rune_furion_full_immune = __TS__Class()
local sl_modifier_rune_furion_full_immune = ____exports.sl_modifier_rune_furion_full_immune
sl_modifier_rune_furion_full_immune.name = "sl_modifier_rune_furion_full_immune"
__TS__ClassExtends(sl_modifier_rune_furion_full_immune, sl_modifier_debuff_immune)
function sl_modifier_rune_furion_full_immune.prototype.IsHidden(self)
	return true
end
sl_modifier_rune_furion_full_immune = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_furion_full") },
	sl_modifier_rune_furion_full_immune
)
____exports.sl_modifier_rune_furion_full_immune = sl_modifier_rune_furion_full_immune
return ____exports