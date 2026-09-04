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
local AXE_002_PASSIVE_MODIFIER_NAME = "modifier_axe_002_passive"
local AXE_002_TOTAL_HEALTH_ATTR_KEY = "total_health"
local AXE_002_HEALTH_POLL_INTERVAL = 0.5
local AXE_002_SHIELD_MULTIPLIER_PCT_KEY = "axe_002_shield_multiplier_pct"
--- 斧王技能 002（被动）
-- 被动效果：增加自身最大生命值 5% 的攻击力。
-- 每 0.5 秒轮询一次最大生命，若发生变化则实时刷新属性。
____exports.axe_002 = __TS__Class()
local axe_002 = ____exports.axe_002
axe_002.name = "axe_002"
__TS__ClassExtends(axe_002, BaseHeroAbility)
function axe_002.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function axe_002.prototype.GetIntrinsicModifierName(self)
	return AXE_002_PASSIVE_MODIFIER_NAME
end
axe_002 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_002)
____exports.axe_002 = axe_002
____exports.modifier_axe_002_passive = __TS__Class()
local modifier_axe_002_passive = ____exports.modifier_axe_002_passive
modifier_axe_002_passive.name = "modifier_axe_002_passive"
__TS__ClassExtends(modifier_axe_002_passive, BaseHeroModifier)
function modifier_axe_002_passive.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.lastMaxHealth = -1
	self.lastShieldMode = false
	self.bonusAttackDamage = 0
	self.bonusEnergyShield = 0
end
function modifier_axe_002_passive.GetLocalizationCN(self)
	return { name = "重击", description = "攻击力提升自身最大生命值的5%% 。" }
end
function modifier_axe_002_passive.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_002_passive.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:UpdateBonusFromMaxHealth(true)
	self:StartIntervalThink(AXE_002_HEALTH_POLL_INTERVAL)
end
function modifier_axe_002_passive.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValid(nil, self:GetParent()) then
		return
	end
	self:UpdateBonusFromMaxHealth(false)
end
function modifier_axe_002_passive.prototype.GetAttributeBonus(self)
	return { bonus_attack_damage = self.bonusAttackDamage, base_energy_shield = self.bonusEnergyShield }
end
function modifier_axe_002_passive.prototype.UpdateBonusFromMaxHealth(self, forceRefresh)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local maxHealthFromAttr = MyGameAttribute:GetAttribute(parent, AXE_002_TOTAL_HEALTH_ATTR_KEY) or 0
	local currentMaxHealth = math.max(0, maxHealthFromAttr or parent:GetMaxHealth())
	local ratio = self:GetSpecialValue("axe_002", "buff_attack_from_health_pct") / 100
	local ____math_max_3 = math.max
	local ____tonumber_2 = tonumber
	local ____opt_0 = parent.GetCustomValue
	local shieldMultiplierPct =
		____math_max_3(0, ____tonumber_2(____opt_0 and ____opt_0(parent, AXE_002_SHIELD_MULTIPLIER_PCT_KEY) or 0) or 0)
	local shieldMode = shieldMultiplierPct > 0
	if not forceRefresh and currentMaxHealth == self.lastMaxHealth and shieldMode == self.lastShieldMode then
		return
	end
	self.lastMaxHealth = currentMaxHealth
	self.lastShieldMode = shieldMode
	local baseBonus = math.floor(currentMaxHealth * ratio)
	if shieldMode then
		self.bonusAttackDamage = 0
		self.bonusEnergyShield = math.floor(baseBonus * shieldMultiplierPct / 100)
	else
		self.bonusAttackDamage = baseBonus
		self.bonusEnergyShield = 0
	end
	local ____self_SetStackCount_5 = self.SetStackCount
	local ____shieldMode_4
	if shieldMode then
		____shieldMode_4 = self.bonusEnergyShield
	else
		____shieldMode_4 = self.bonusAttackDamage
	end
	____self_SetStackCount_5(self, ____shieldMode_4)
	self:RefreshAttributes()
end
modifier_axe_002_passive = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_002_passive)
____exports.modifier_axe_002_passive = modifier_axe_002_passive
return ____exports