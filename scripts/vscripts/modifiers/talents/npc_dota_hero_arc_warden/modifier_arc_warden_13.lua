--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_13=class({})

function modifier_arc_warden_13:IsHidden() return true end
function modifier_arc_warden_13:IsPurgable() return false end
function modifier_arc_warden_13:IsPurgeException() return false end
function modifier_arc_warden_13:RemoveOnDeath() return false end

function modifier_arc_warden_13:OnCreated()
	self.bonus = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_arc_warden_13:OnRefresh()
	self.bonus = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_arc_warden_13:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE 
	}
end

function modifier_arc_warden_13:GetModifierPercentageCooldown(params)
	if params.ability and params.ability:IsItem() then
		return self.bonus[self:GetStackCount()]
	end
end