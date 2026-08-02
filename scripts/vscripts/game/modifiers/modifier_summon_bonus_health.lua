--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_summon_bonus_health = modifier_summon_bonus_health or class({})

function modifier_summon_bonus_health:IsHidden()
	return true
end
function modifier_summon_bonus_health:RemoveOnDeath()
	return false
end
function modifier_summon_bonus_health:IsPurgable()
	return false
end
function modifier_summon_bonus_health:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_summon_bonus_health:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS, -- GetModifierExtraHealthBonus
	}
end

function modifier_summon_bonus_health:GetModifierExtraHealthBonus()
	return self:GetStackCount()
end