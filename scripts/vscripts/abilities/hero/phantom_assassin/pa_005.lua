--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local PA_005_STACK_DECAY_INTERVAL = 1
--- 符印「高阶洞察」：额外洞察层数上限。
local PA_005_INSIGHT_MAX_STACK_BONUS_KEY = "pa_005_insight_max_stack_bonus"
--- 符印「弱点洞悉」：每层洞察额外提供的全域伤害增幅。
local PA_005_INSIGHT_OUTGOING_DAMAGE_PCT_PER_STACK_KEY = "pa_005_insight_outgoing_damage_pct_per_stack"
____exports.pa_005 = __TS__Class()
local pa_005 = ____exports.pa_005
pa_005.name = "pa_005"
__TS__ClassExtends(pa_005, BaseHeroAbility)
function pa_005.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN }
end
function pa_005.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pa_005_insight.name
end
function pa_005.prototype.GetAgilityPerStack(self)
	return self:GetSpecialValue("pa_005", "ability_value")
end
function pa_005.prototype.GetMaxStack(self)
	local caster = self:GetCaster()
	local ____math_max_4 = math.max
	local ____math_floor_3 = math.floor
	local ____tonumber_2 = tonumber
	local ____opt_0 = caster.GetCustomValue
	local stackBonus = ____math_max_4(
		0,
		____math_floor_3(____tonumber_2(____opt_0 and ____opt_0(caster, PA_005_INSIGHT_MAX_STACK_BONUS_KEY) or 0) or 0)
	)
	return math.max(1, math.floor(self:GetSpecialValue("pa_005", "max_stack")) + stackBonus)
end
function pa_005.prototype.GetOutgoingDamagePctPerStack(self)
	local caster = self:GetCaster()
	local ____math_max_8 = math.max
	local ____tonumber_7 = tonumber
	local ____opt_5 = caster.GetCustomValue
	return ____math_max_8(
		0,
		____tonumber_7(____opt_5 and ____opt_5(caster, PA_005_INSIGHT_OUTGOING_DAMAGE_PCT_PER_STACK_KEY) or 0) or 0
	)
end
pa_005 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_005)
____exports.pa_005 = pa_005
____exports.modifier_pa_005_insight = __TS__Class()
local modifier_pa_005_insight = ____exports.modifier_pa_005_insight
modifier_pa_005_insight.name = "modifier_pa_005_insight"
__TS__ClassExtends(modifier_pa_005_insight, BaseHeroModifier)
function modifier_pa_005_insight.GetLocalizationCN(self)
	return { name = "洞察", description = "攻击会叠加敏捷，每秒流逝 1 层。" }
end
function modifier_pa_005_insight.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_pa_005_insight.prototype.GetModifierConfig(self)
	return {
		isHidden = self:GetStackCount() <= 0,
		isDebuff = false,
		isPurgable = false,
		isPurgeException = false,
	}
end
function modifier_pa_005_insight.prototype.IsPermanent(self)
	return true
end
function modifier_pa_005_insight.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:StartIntervalThink(-1)
end
function modifier_pa_005_insight.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local previousStack = self:GetStackCount()
	local nextStack = math.min(self:GetStackCount() + 1, ability:GetMaxStack())
	self:SetStackCount(nextStack)
	self:RefreshAttributes()
	if previousStack <= 0 and nextStack > 0 then
		self:StartIntervalThink(PA_005_STACK_DECAY_INTERVAL)
	end
end
function modifier_pa_005_insight.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStack = math.max(self:GetStackCount() - 1, 0)
	self:SetStackCount(nextStack)
	self:RefreshAttributes()
	if nextStack <= 0 then
		self:StartIntervalThink(-1)
	end
end
function modifier_pa_005_insight.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local stacks = self:GetStackCount()
	return {
		bonus_agility = stacks * ability:GetAgilityPerStack(),
		outgoing_damage_pct = stacks * ability:GetOutgoingDamagePctPerStack(),
	}
end
function modifier_pa_005_insight.prototype.GetTexture(self)
	return "phantom_assassin_immaterial"
end
modifier_pa_005_insight = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_005_insight)
____exports.modifier_pa_005_insight = modifier_pa_005_insight
return ____exports