--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_omniknight_16 = class({})

function modifier_omniknight_16:IsHidden()
	return true
end
function modifier_omniknight_16:IsPurgable()
	return false
end
function modifier_omniknight_16:IsPurgeException()
	return false
end
function modifier_omniknight_16:RemoveOnDeath()
	return false
end

function modifier_omniknight_16:OnCreated()
	self.bonus = 10
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_omniknight_16:OnRefresh()
	self.bonus = 10
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_omniknight_16:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_omniknight_16:GetModifierStatusResistanceStacking()
	return self.bonus
end