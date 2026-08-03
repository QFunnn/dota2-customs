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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强，每点智力或敏捷提升{batk_per_int_agi}基础攻击力<br>
-- 自身召唤的树精额外获得{hp_pct}%生命值加成，对建筑造成的伤害降低{building_damage_penalty_pct}%<br>
-- 施放传送术引导时免疫负面效果
____exports.sl_modifier_rune_furion_full = __TS__Class()
local sl_modifier_rune_furion_full = ____exports.sl_modifier_rune_furion_full
sl_modifier_rune_furion_full.name = "sl_modifier_rune_furion_full"
__TS__ClassExtends(sl_modifier_rune_furion_full, sl_modifier_rune_base)
function sl_modifier_rune_furion_full.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
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
	GlobalAttrManager:Get(parent:GetPlayerOwnerID())
		:SetSummonAmp(tostring(self), "npc_dota_furion_treant", { hp_bonus_pct = hp_pct })
	LocalEvents:Register(tostring(self), "ability_executed", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or ability:GetAbilityName() ~= "furion_teleportation" then
			return
		end
		parent:AddSLModifier(____exports.sl_modifier_rune_furion_full_immune, { caster = parent, no_error = true })
	end, self, parent:GetEntityIndex())
	LocalEvents:Register(tostring(self), "ability_end_channel", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or ability:GetAbilityName() ~= "furion_teleportation" then
			return
		end
		parent:RemoveSLModifierByType(____exports.sl_modifier_rune_furion_full_immune, parent)
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_furion_full.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		GlobalAttrManager:Get(parent:GetPlayerOwnerID()):RemoveSummonAmp(tostring(self), "npc_dota_furion_treant")
		LocalEvents:Remove("ability_executed", self, parent:GetEntityIndex())
		LocalEvents:Remove("ability_end_channel", self, parent:GetEntityIndex())
		parent:RemoveSLModifierByType(____exports.sl_modifier_rune_furion_full_immune, parent)
	end
end
sl_modifier_rune_furion_full = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_furion_full") },
	sl_modifier_rune_furion_full
)
____exports.sl_modifier_rune_furion_full = sl_modifier_rune_furion_full
--- 传送术引导期间的负面效果免疫（隐藏辅助 buff）
____exports.sl_modifier_rune_furion_full_immune = __TS__Class()
local sl_modifier_rune_furion_full_immune = ____exports.sl_modifier_rune_furion_full_immune
sl_modifier_rune_furion_full_immune.name = "sl_modifier_rune_furion_full_immune"
__TS__ClassExtends(sl_modifier_rune_furion_full_immune, SLModifierBase)
function sl_modifier_rune_furion_full_immune.prototype.IsHidden(self)
	return true
end
function sl_modifier_rune_furion_full_immune.prototype.CheckState(self)
	return { [MODIFIER_STATE_DEBUFF_IMMUNE] = true }
end
sl_modifier_rune_furion_full_immune = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_furion_full") },
	sl_modifier_rune_furion_full_immune
)
____exports.sl_modifier_rune_furion_full_immune = sl_modifier_rune_furion_full_immune
return ____exports