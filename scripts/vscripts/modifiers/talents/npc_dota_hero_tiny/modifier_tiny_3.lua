--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tiny_3=class({})

function modifier_tiny_3:IsHidden() return true end
function modifier_tiny_3:IsPurgable() return false end
function modifier_tiny_3:IsPurgeException() return false end
function modifier_tiny_3:RemoveOnDeath() return false end

function modifier_tiny_3:OnCreated()
    self.bonus = {2,4,6}
    self.bonus2 = {4,8,12}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_tiny_3:OnRefresh()
    self.bonus = {2,4,6}
    self.bonus2 = {4,8,12}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tiny_3:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_tiny_3:GetModifierIncomingDamage_Percentage()
    return self.bonus[self:GetStackCount()]
end

function modifier_tiny_3:GetModifierTotalDamageOutgoing_Percentage()
    return self.bonus2[self:GetStackCount()]
end