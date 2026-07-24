--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_6=class({})

function modifier_arc_warden_6:IsHidden() return true end
function modifier_arc_warden_6:IsPurgable() return false end
function modifier_arc_warden_6:IsPurgeException() return false end
function modifier_arc_warden_6:RemoveOnDeath() return false end

function modifier_arc_warden_6:OnCreated()
    self.bonus = {-6,-12,-18}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_arc_warden_6:OnRefresh()
    self.bonus = {-6,-12,-18}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_arc_warden_6:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_arc_warden_6:GetModifierIncomingDamage_Percentage()
    if self:GetParent():GetHealthPercent() < 20 then
        return self.bonus[self:GetStackCount()]
    end
end