--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_faceless_void_6 = class({})

function modifier_faceless_void_6:IsHidden()
	return true
end
function modifier_faceless_void_6:IsPurgable()
	return false
end
function modifier_faceless_void_6:IsPurgeException()
	return false
end
function modifier_faceless_void_6:RemoveOnDeath()
	return false
end

function modifier_faceless_void_6:OnCreated()
	self.bonus = { 4, 8, 12 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_faceless_void_6:OnRefresh()
	self.bonus = { 4, 8, 12 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_faceless_void_6:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end

function modifier_faceless_void_6:GetModifierPercentageCooldown()
	return self.bonus[self:GetStackCount()]
end