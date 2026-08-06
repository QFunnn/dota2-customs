--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_21 = class({})

function modifier_medusa_21:IsHidden()
	return true
end
function modifier_medusa_21:IsPurgable()
	return false
end
function modifier_medusa_21:IsPurgeException()
	return false
end
function modifier_medusa_21:RemoveOnDeath()
	return false
end

function modifier_medusa_21:OnCreated()
	self.bonus = { 10 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_medusa_21:OnRefresh()
	self.bonus = { 10 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_21:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
	}
end

function modifier_medusa_21:GetModifierExtraManaPercentage()
	return self.bonus[self:GetStackCount()]
end