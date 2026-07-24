--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lone_druid_21=class({})

function modifier_lone_druid_21:IsHidden() return true end
function modifier_lone_druid_21:IsPurgable() return false end
function modifier_lone_druid_21:IsPurgeException() return false end
function modifier_lone_druid_21:RemoveOnDeath() return false end

function modifier_lone_druid_21:OnCreated()
	self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_lone_druid_21:OnRefresh()
	self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_lone_druid_21:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE 
	}
end

function modifier_lone_druid_21:GetModifierPercentageCooldown()
	if self.bonus == nil and self:GetStackCount() == 0 then return end
	return self.bonus[self:GetStackCount()]
end