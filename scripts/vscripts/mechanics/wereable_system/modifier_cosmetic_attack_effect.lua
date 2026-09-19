--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


modifier_cosmetic_attack_effect = class({})

function modifier_cosmetic_attack_effect:IsHidden()
	return true
end

function modifier_cosmetic_attack_effect:IsPurgable()
	return false
end

function modifier_cosmetic_attack_effect:RemoveOnDeath()
	return false
end

function modifier_cosmetic_attack_effect:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_cosmetic_attack_effect:OnCreated(params)
	params = params or {}
	self.projectileName = params.projectile_name or ""
end

function modifier_cosmetic_attack_effect:OnRefresh(params)
	params = params or {}
	self.projectileName = params.projectile_name or self.projectileName or ""
end

function modifier_cosmetic_attack_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
end

function modifier_cosmetic_attack_effect:GetModifierProjectileName()
	return self.projectileName
end