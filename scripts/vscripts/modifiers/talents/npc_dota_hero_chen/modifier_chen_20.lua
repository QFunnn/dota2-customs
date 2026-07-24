--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_20=class({})

function modifier_chen_20:IsHidden() return true end
function modifier_chen_20:IsPurgable() return false end
function modifier_chen_20:IsPurgeException() return false end
function modifier_chen_20:RemoveOnDeath() return false end

function modifier_chen_20:OnCreated()
    self.bonus = {-3,-6,-9}
    self.vision = {600,900,1200}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_chen_20:OnRefresh()
    self.bonus = {-3,-6,-9}
    self.vision = {600,900,1200}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chen_20:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.vision[self:GetStackCount()], FrameTime(), false)
end

function modifier_chen_20:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_chen_20:GetModifierIncomingDamage_Percentage()
    return self.bonus[self:GetStackCount()]
end