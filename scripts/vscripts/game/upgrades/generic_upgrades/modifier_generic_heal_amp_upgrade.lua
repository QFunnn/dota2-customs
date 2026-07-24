--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_heal_amp_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_heal_amp_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("heal_amp")
end

function modifier_generic_heal_amp_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_heal_amp_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_heal_amp_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE, -- GetModifierHealAmplify_PercentageSource
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET, -- GetModifierHealAmplify_PercentageTarget
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE, -- GetModifierHPRegenAmplify_Percentage
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE, -- GetModifierLifestealRegenAmplify_Percentage
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE, -- GetModifierSpellLifestealRegenAmplify_Percentage
	}
end


function modifier_generic_heal_amp_upgrade:GetModifierHealAmplify_PercentageSource()
	return self.bonus or 0
end


function modifier_generic_heal_amp_upgrade:GetModifierHealAmplify_PercentageTarget()
	return self.bonus or 0
end


function modifier_generic_heal_amp_upgrade:GetModifierHPRegenAmplify_Percentage()
	return self.bonus or 0
end


function modifier_generic_heal_amp_upgrade:GetModifierLifestealRegenAmplify_Percentage()
	return self.bonus or 0
end


function modifier_generic_heal_amp_upgrade:GetModifierSpellLifestealRegenAmplify_Percentage()
	return self.bonus or 0
end