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
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 影魂唤儡（necromastery）灵魂层数上限的兜底值（未取到技能特殊值时使用）
local NEVERMORE_DEFAULT_MAX_SOULS = 20
--- 每点力量提升{hp_per_str}生命值，每点敏捷提升{batk_per_agi}基础攻击力，每点智力提升{amp_per_int}%技能增强<br>
-- 每层灵魂额外提升{jnzq}%技能增强<br>
-- 灵魂满层时施放安魂咒，消耗{soul}层灵魂，恐惧安魂咒中心周围的敌人{fear}秒
____exports.sl_modifier_rune_nevermore = __TS__Class()
local sl_modifier_rune_nevermore = ____exports.sl_modifier_rune_nevermore
sl_modifier_rune_nevermore.name = "sl_modifier_rune_nevermore"
__TS__ClassExtends(sl_modifier_rune_nevermore, sl_modifier_rune_base)
function sl_modifier_rune_nevermore.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function sl_modifier_rune_nevermore.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_nevermore.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_nevermore.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local int_amp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
	local parent = self:GetParent()
	local soul_amp = 0
	if IsValid(parent) then
		local necromastery = parent:FindModifierByName("modifier_nevermore_necromastery")
		if IsValid(necromastery) then
			soul_amp = necromastery:GetStackCount() * self:_GetRuneSpecialValue("jnzq")
		end
	end
	return int_amp + soul_amp
end
function sl_modifier_rune_nevermore.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	LocalEvents:Register(tostring(self), "ability_fully_cast", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or ability:GetAbilityName() ~= "nevermore_requiem" then
			return
		end
		self:_OnRequiem(parent, ability)
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_nevermore.prototype._OnRequiem(self, parent, ability)
	local necro_modifier = parent:FindModifierByName("modifier_nevermore_necromastery")
	if not IsValid(necro_modifier) then
		return
	end
	local necromastery = parent:FindAbilityByName("nevermore_necromastery")
	local ____IsValid_result_0
	if IsValid(necromastery) then
		____IsValid_result_0 = necromastery:GetSpecialValueFor("necromastery_max_souls")
	else
		____IsValid_result_0 = NEVERMORE_DEFAULT_MAX_SOULS
	end
	local max_souls = ____IsValid_result_0
	local stack = necro_modifier:GetStackCount()
	if stack < max_souls then
		return
	end
	local soul = self:_GetRuneSpecialValue("soul")
	if soul <= 0 then
		return
	end
	necro_modifier:SetStackCount(math.max(0, stack - soul))
	local fear = self:_GetRuneSpecialValue("fear")
	if fear <= 0 then
		return
	end
	local center = parent:GetAbsOrigin()
	local requiem_radius = ability:GetSpecialValueFor("requiem_radius")
	local enemies = FindUnitsInRadius(
		parent:GetTeam(),
		center,
		nil,
		requiem_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		enemy:AddSLModifier(
			____exports.sl_modifier_rune_nevermore_fear,
			{ caster = parent, ability = ability, duration = fear, no_error = true }
		)
	end
end
function sl_modifier_rune_nevermore.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		LocalEvents:Remove("ability_fully_cast", self, parent:GetEntityIndex())
	end
end
sl_modifier_rune_nevermore = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_nevermore") },
	sl_modifier_rune_nevermore
)
____exports.sl_modifier_rune_nevermore = sl_modifier_rune_nevermore
--- 安魂咒满魂特效：恐惧（隐藏辅助 buff）
____exports.sl_modifier_rune_nevermore_fear = __TS__Class()
local sl_modifier_rune_nevermore_fear = ____exports.sl_modifier_rune_nevermore_fear
sl_modifier_rune_nevermore_fear.name = "sl_modifier_rune_nevermore_fear"
__TS__ClassExtends(sl_modifier_rune_nevermore_fear, SLModifierBase_Debuff)
function sl_modifier_rune_nevermore_fear.prototype.IsHidden(self)
	return true
end
function sl_modifier_rune_nevermore_fear.prototype.CheckState(self)
	return { [MODIFIER_STATE_FEARED] = true }
end
sl_modifier_rune_nevermore_fear = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_nevermore") },
	sl_modifier_rune_nevermore_fear
)
____exports.sl_modifier_rune_nevermore_fear = sl_modifier_rune_nevermore_fear
return ____exports