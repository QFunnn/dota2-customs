--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

outcomming_heal_amplify = class(base_game_perk)

function outcomming_heal_amplify:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function outcomming_heal_amplify:GetModifierHealAmplify_PercentageSource()
	return self.heal_amp
end
function outcomming_heal_amplify:GetModifierLifestealRegenAmplify_Percentage()
	return self.heal_amp
end
function outcomming_heal_amplify:GetModifierSpellLifestealRegenAmplify_Percentage()
	return self.heal_amp
end
function outcomming_heal_amplify:GetModifierHPRegenAmplify_Percentage()
	return self.heal_amp
end