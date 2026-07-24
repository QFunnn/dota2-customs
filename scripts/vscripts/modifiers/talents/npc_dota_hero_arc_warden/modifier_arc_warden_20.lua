--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_20=class({})

function modifier_arc_warden_20:IsHidden() return true end
function modifier_arc_warden_20:IsPurgable() return false end
function modifier_arc_warden_20:IsPurgeException() return false end
function modifier_arc_warden_20:RemoveOnDeath() return false end

function modifier_arc_warden_20:OnCreated()
    self.bonus = {0,14}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_arc_warden_20:OnRefresh()
    self.bonus = {0,14}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_arc_warden_20:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_EVASION_CONSTANT
    }
end

function modifier_arc_warden_20:GetModifierEvasion_Constant()
    return self.bonus[self:GetStackCount()]
end