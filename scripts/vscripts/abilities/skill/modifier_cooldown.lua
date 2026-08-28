--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_cooldown = class({})

function modifier_cooldown:IsHidden()
	return true
end

function modifier_cooldown:IsPurgable()
	return false
end

function modifier_cooldown:RemoveOnDeath()
	return false
end

function modifier_cooldown:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_cooldown:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
	return funcs
end

function modifier_cooldown:GetModifierPercentageCooldown()
	return 0.5 * self:GetStackCount()
end