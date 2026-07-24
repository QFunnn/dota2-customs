--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_doom_bringer_11=class({})

function modifier_doom_bringer_11:IsHidden() return true end
function modifier_doom_bringer_11:IsPurgable() return false end
function modifier_doom_bringer_11:IsPurgeException() return false end
function modifier_doom_bringer_11:RemoveOnDeath() return false end

function modifier_doom_bringer_11:OnCreated()
	self.bonus2 = {4,8}
	self.bonus = {20,40}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_doom_bringer_11:OnRefresh()
	self.bonus2 = {4,8}
	self.bonus = {20,40}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_doom_bringer_11:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	}
end

function modifier_doom_bringer_11:GetModifierPercentageManacostStacking(params)
	return self.bonus[self:GetStackCount()]
end

function modifier_doom_bringer_11:GetModifierTotalDamageOutgoing_Percentage()
	return self.bonus2[self:GetStackCount()]
end