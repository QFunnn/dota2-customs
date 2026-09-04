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
____exports.pa_012 = __TS__Class()
local pa_012 = ____exports.pa_012
pa_012.name = "pa_012"
__TS__ClassExtends(pa_012, BaseHeroAbility)
function pa_012.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function pa_012.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pa_012_assassination.name
end
function pa_012.prototype.GetAgilityPerAttackBonus(self)
	return math.max(1, self:GetSpecialValue("pa_012", "agility_per_attack_bonus"))
end
function pa_012.prototype.GetBaseAttackBonusPerStep(self)
	return math.max(0, self:GetSpecialValue("pa_012", "base_attack_bonus_per_step"))
end
pa_012 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_012)
____exports.pa_012 = pa_012
____exports.modifier_pa_012_assassination = __TS__Class()
local modifier_pa_012_assassination = ____exports.modifier_pa_012_assassination
modifier_pa_012_assassination.name = "modifier_pa_012_assassination"
__TS__ClassExtends(modifier_pa_012_assassination, BaseHeroModifier)
function modifier_pa_012_assassination.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.cachedBaseAttackDamage = 0
end
function modifier_pa_012_assassination.GetLocalizationCN(self)
	return { name = "刺杀术", description = "根据敏捷提升基础攻击力。" }
end
function modifier_pa_012_assassination.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_pa_012_assassination.prototype.IsPermanent(self)
	return true
end
function modifier_pa_012_assassination.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateBaseAttackDamage(true)
	self.unregisterAgilityChanged = MyGameAttribute:RegisterAttributeChangeHandler("total_agility", function(____, unit)
		if unit == self:GetParent() then
			self:RecalculateBaseAttackDamage(false)
		end
	end)
end
function modifier_pa_012_assassination.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RecalculateBaseAttackDamage(true)
end
function modifier_pa_012_assassination.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.unregisterAgilityChanged then
		self:unregisterAgilityChanged()
		self.unregisterAgilityChanged = nil
	end
end
function modifier_pa_012_assassination.prototype.GetAttributeBonus(self)
	return { base_attack_damage = self.cachedBaseAttackDamage }
end
function modifier_pa_012_assassination.prototype.RecalculateBaseAttackDamage(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability or not IsValid(nil, ability) then
		return
	end
	local agility = math.max(0, MyGameAttribute:GetAttribute(parent, "total_agility") or 0)
	local agilityPerAttackBonus = ability:GetAgilityPerAttackBonus()
	local baseAttackBonusPerStep = ability:GetBaseAttackBonusPerStep()
	local baseAttackDamage = math.floor(agility / agilityPerAttackBonus) * baseAttackBonusPerStep
	if not forceRefresh and baseAttackDamage == self.cachedBaseAttackDamage then
		return
	end
	self.cachedBaseAttackDamage = baseAttackDamage
	self:SetStackCount(baseAttackDamage)
	self:RefreshAttributes()
end
modifier_pa_012_assassination = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_012_assassination)
____exports.modifier_pa_012_assassination = modifier_pa_012_assassination
return ____exports