--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_alchemist_consumable_scepter_nerf = class({})

modifier_alchemist_consumable_scepter_nerf.stats_nerf = -5
modifier_alchemist_consumable_scepter_nerf.health_nerf = -75
modifier_alchemist_consumable_scepter_nerf.mana_nerf = -75

function modifier_alchemist_consumable_scepter_nerf:IsHidden()
	return true
end
function modifier_alchemist_consumable_scepter_nerf:IsPurgable()
	return false
end
function modifier_alchemist_consumable_scepter_nerf:DestroyOnExpire()
	return false
end
function modifier_alchemist_consumable_scepter_nerf:RemoveOnDeath()
	return false
end

function modifier_alchemist_consumable_scepter_nerf:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, -- GetModifierBonusStats_Strength
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS, -- GetModifierBonusStats_Agility
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, -- GetModifierBonusStats_Intellect
		MODIFIER_PROPERTY_HEALTH_BONUS, -- GetModifierHealthBonus
		MODIFIER_PROPERTY_MANA_BONUS, -- GetModifierManaBonus
	}
end

function modifier_alchemist_consumable_scepter_nerf:GetModifierBonusStats_Strength()
	return self.stats_nerf
end
function modifier_alchemist_consumable_scepter_nerf:GetModifierBonusStats_Agility()
	return self.stats_nerf
end
function modifier_alchemist_consumable_scepter_nerf:GetModifierBonusStats_Intellect()
	return self.stats_nerf
end
function modifier_alchemist_consumable_scepter_nerf:GetModifierHealthBonus()
	return self.health_nerf
end
function modifier_alchemist_consumable_scepter_nerf:GetModifierManaBonus()
	return self.mana_nerf
end