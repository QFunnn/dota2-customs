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
local AXE_007_INTRINSIC_MODIFIER = "modifier_axe_007_berserkers_blood"
local AXE_007_POLL_INTERVAL = 0.2
--- 符印：每损失 1% 生命，增加的暴击伤害百分比（默认 0，装配符印后通常为 1）
local AXE_007_RUNE_CRIT_DAMAGE_PER_LOST_HP_PCT_KEY = "axe_007_rune_crit_damage_per_lost_hp_pct"
____exports.axe_007 = __TS__Class()
local axe_007 = ____exports.axe_007
axe_007.name = "axe_007"
__TS__ClassExtends(axe_007, BaseHeroAbility)
function axe_007.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function axe_007.prototype.GetIntrinsicModifierName(self)
	return AXE_007_INTRINSIC_MODIFIER
end
axe_007 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_007)
____exports.axe_007 = axe_007
____exports.modifier_axe_007_berserkers_blood = __TS__Class()
local modifier_axe_007_berserkers_blood = ____exports.modifier_axe_007_berserkers_blood
modifier_axe_007_berserkers_blood.name = "modifier_axe_007_berserkers_blood"
__TS__ClassExtends(modifier_axe_007_berserkers_blood, BaseHeroModifier)
function modifier_axe_007_berserkers_blood.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.bonusAttackSpeed = 0
	self.bonusHealthRegenPct = 0
	self.bonusCritDamagePct = 0
	self.lastHealthPct = -1
	self.lastCritDamagePerLostHpPct = -1
end
function modifier_axe_007_berserkers_blood.GetLocalizationCN(self)
	return { name = "狂战士之血", description = "当前生命越低，攻速与生命恢复越高。" }
end
function modifier_axe_007_berserkers_blood.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_007_berserkers_blood.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:UpdateBonusByHealthPct(true)
	self:StartIntervalThink(AXE_007_POLL_INTERVAL)
end
function modifier_axe_007_berserkers_blood.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValid(nil, self:GetParent()) then
		return
	end
	self:UpdateBonusByHealthPct(false)
end
function modifier_axe_007_berserkers_blood.prototype.GetAttributeBonus(self)
	return {
		attack_speed = self.bonusAttackSpeed,
		regen_amp_pct = self.bonusHealthRegenPct,
		crit_damage_pct = self.bonusCritDamagePct,
	}
end
function modifier_axe_007_berserkers_blood.prototype.UpdateBonusByHealthPct(self, forceRefresh)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local maxHealth = math.max(1, parent:GetMaxHealth())
	local currentHealth = math.max(0, parent:GetHealth())
	local healthPct = math.max(0, math.min(100, currentHealth / maxHealth * 100))
	local ____tonumber_2 = tonumber
	local ____opt_0 = parent.GetCustomValue
	local critDamagePerLostHpPct = ____tonumber_2(
		____opt_0 and ____opt_0(parent, AXE_007_RUNE_CRIT_DAMAGE_PER_LOST_HP_PCT_KEY) or 0
	) or 0
	local maxBonusAttackSpeed = math.max(0, self:GetSpecialValue("axe_007", "max_bonus_attack_speed"))
	local maxRecoveryAmpPct = math.max(0, self:GetSpecialValue("axe_007", "max_recovery_amp_pct"))
	if
		not forceRefresh
		and math.abs(healthPct - self.lastHealthPct) < 0.01
		and math.abs(critDamagePerLostHpPct - self.lastCritDamagePerLostHpPct) < 0.01
	then
		return
	end
	self.lastHealthPct = healthPct
	self.lastCritDamagePerLostHpPct = critDamagePerLostHpPct
	local missingHealthRatio = (100 - healthPct) / 100
	local missingHealthPct = 100 - healthPct
	self.bonusAttackSpeed = maxBonusAttackSpeed * missingHealthRatio
	self.bonusHealthRegenPct = maxRecoveryAmpPct * missingHealthRatio
	self.bonusCritDamagePct = missingHealthPct * critDamagePerLostHpPct
	self:SetStackCount(math.floor(self.bonusAttackSpeed))
	self:RefreshAttributes()
end
modifier_axe_007_berserkers_blood = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_007_berserkers_blood)
____exports.modifier_axe_007_berserkers_blood = modifier_axe_007_berserkers_blood
return ____exports