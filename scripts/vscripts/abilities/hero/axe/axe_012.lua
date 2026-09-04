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
local AXE_012_INTRINSIC_MODIFIER = "modifier_axe_012_passive"
____exports.axe_012 = __TS__Class()
local axe_012 = ____exports.axe_012
axe_012.name = "axe_012"
__TS__ClassExtends(axe_012, BaseHeroAbility)
function axe_012.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN }
end
function axe_012.prototype.GetIntrinsicModifierName(self)
	return AXE_012_INTRINSIC_MODIFIER
end
axe_012 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_012)
____exports.axe_012 = axe_012
____exports.modifier_axe_012_passive = __TS__Class()
local modifier_axe_012_passive = ____exports.modifier_axe_012_passive
modifier_axe_012_passive.name = "modifier_axe_012_passive"
__TS__ClassExtends(modifier_axe_012_passive, BaseHeroModifier)
function modifier_axe_012_passive.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_012_passive.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_axe_012_passive.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	if ability:GetLevel() <= 0 or not ability:IsCooldownReady() then
		return
	end
	local chancePct = math.max(0, ability:GetSpecialValue("axe_012", "trigger_chance_pct"))
	if not RollPercentage(chancePct) then
		return
	end
	local restorePct = math.max(0, ability:GetSpecialValue("axe_012", "heal_max_health_and_shield_pct"))
	local healthRestore = math.max(0, parent:GetMaxHealth()) * (restorePct / 100)
	if healthRestore > 0 then
		parent:CustomHeal(healthRestore, { ability = ability, source = "spell" })
	end
	local ____math_max_2 = math.max
	local ____opt_0 = parent.GetTotalEnergyShield
	local maxShield = ____math_max_2(
		0,
		____opt_0 and ____opt_0(parent) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	local shieldRestore = maxShield * (restorePct / 100)
	if shieldRestore > 0 and parent.AddCurrentEnergyShield then
		parent:AddCurrentEnergyShield(shieldRestore)
	end
	local duration = math.max(0.1, ability:GetSpecialValue("axe_012", "vulnerable_duration"))
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.VULNERABLE, { duration = duration, stack = 1 })
	ability:StartCooldown(math.max(0, ability:GetCooldown(math.max(0, ability:GetLevel() - 1))))
end
modifier_axe_012_passive = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_012_passive)
____exports.modifier_axe_012_passive = modifier_axe_012_passive
return ____exports