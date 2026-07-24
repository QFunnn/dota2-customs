--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_drow_ranger_20=class({})

function modifier_drow_ranger_20:IsHidden() return true end
function modifier_drow_ranger_20:IsPurgable() return false end
function modifier_drow_ranger_20:IsPurgeException() return false end
function modifier_drow_ranger_20:RemoveOnDeath() return false end

function modifier_drow_ranger_20:OnCreated()
    self.bonus = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_drow_ranger_20:OnRefresh()
    self.bonus = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_drow_ranger_20:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_drow_ranger_20:GetModifierTotalDamageOutgoing_Percentage(params)    
    if IsClient() then return 0 end
    local target = params.target
    if target:GetAbsOrigin().z < self:GetParent():GetAbsOrigin().z or self:GetParent():HasModifier("modifier_drow_ranger_glacier_hilltop") then
        return self.bonus[self:GetStackCount()]
    end
end