--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_spirit_breaker_1 = class({})

function modifier_spirit_breaker_1:IsHidden()
	return true
end
function modifier_spirit_breaker_1:IsPurgable()
	return false
end
function modifier_spirit_breaker_1:IsPurgeException()
	return false
end
function modifier_spirit_breaker_1:RemoveOnDeath()
	return false
end

function modifier_spirit_breaker_1:OnCreated()
	self.bonus = { 3, 6 }
	self.bonus2 = { 2, 4 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_spirit_breaker_1:OnRefresh()
	self.bonus = { 3, 6 }
	self.bonus2 = { 2, 4 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_spirit_breaker_1:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_spirit_breaker_1:GetModifierConstantHealthRegen()
	return self.bonus[self:GetStackCount()]
end

function modifier_spirit_breaker_1:GetModifierPhysicalArmorBonus()
	return self.bonus2[self:GetStackCount()]
end