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
--- 幻影刺客技能 002 - 念动刃舞（被动）
-- 每点总智力提供若干点攻击速度（默认1:1，可由 KV as_per_intelligence 调整）。
____exports.pa_002 = __TS__Class()
local pa_002 = ____exports.pa_002
pa_002.name = "pa_002"
__TS__ClassExtends(pa_002, BaseHeroAbility)
function pa_002.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function pa_002.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pa_002_psychic_blade_dance.name
end
function pa_002.prototype.GetAttackSpeedPerIntelligence(self)
	return self:GetSpecialValue("pa_002", "as_per_intelligence")
end
pa_002 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_002)
____exports.pa_002 = pa_002
____exports.modifier_pa_002_psychic_blade_dance = __TS__Class()
local modifier_pa_002_psychic_blade_dance = ____exports.modifier_pa_002_psychic_blade_dance
modifier_pa_002_psychic_blade_dance.name = "modifier_pa_002_psychic_blade_dance"
__TS__ClassExtends(modifier_pa_002_psychic_blade_dance, BaseHeroModifier)
function modifier_pa_002_psychic_blade_dance.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.lastTotalIntelligence = 0
end
function modifier_pa_002_psychic_blade_dance.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_pa_002_psychic_blade_dance.prototype.IsPermanent(self)
	return true
end
function modifier_pa_002_psychic_blade_dance.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.lastTotalIntelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	self:StartIntervalThink(2)
	self:RefreshAttributes()
end
function modifier_pa_002_psychic_blade_dance.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local cur = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	if cur ~= self.lastTotalIntelligence then
		self.lastTotalIntelligence = cur
		self:RefreshAttributes()
	end
end
function modifier_pa_002_psychic_blade_dance.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self.lastTotalIntelligence = MyGameAttribute:GetAttribute(self:GetParent(), "total_intelligence") or 0
	self:RefreshAttributes()
end
function modifier_pa_002_psychic_blade_dance.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not parent:IsHero() then
		return {}
	end
	local totalInt = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	local per = ability:GetAttackSpeedPerIntelligence()
	return { attack_speed = totalInt * per }
end
function modifier_pa_002_psychic_blade_dance.prototype.GetTexture(self)
	return "phantom_assassin_phantom_strike"
end
modifier_pa_002_psychic_blade_dance =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_002_psychic_blade_dance)
____exports.modifier_pa_002_psychic_blade_dance = modifier_pa_002_psychic_blade_dance
return ____exports