--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_5 = class({})

function modifier_tinker_5:IsHidden()
	return true
end
function modifier_tinker_5:IsPurgable()
	return false
end
function modifier_tinker_5:IsPurgeException()
	return false
end
function modifier_tinker_5:RemoveOnDeath()
	return false
end

function modifier_tinker_5:OnCreated()
	self.bonus = { 6, 12, 18 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_tinker_5:OnRefresh()
	self.bonus = { 6, 12, 18 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tinker_5:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_LIFESTEAL,
	}
end

function modifier_tinker_5:GetModifierProperty_MagicalLifesteal(params)
	return self.bonus[self:GetStackCount()]
end