--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_warlock_4=class({})

function modifier_warlock_4:IsHidden() return true end
function modifier_warlock_4:IsPurgable() return false end
function modifier_warlock_4:IsPurgeException() return false end
function modifier_warlock_4:RemoveOnDeath() return false end

function modifier_warlock_4:OnCreated()
    self.bonus = {10,20,30}
    self.bonus2={2,4,6}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_warlock_4:OnRefresh()
    self.bonus = {10,20,30}
    self.bonus2={2,4,6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_warlock_4:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_warlock_4:GetModifierBaseDamageOutgoing_Percentage()
    return self.bonus[self:GetStackCount()]
end

function modifier_warlock_4:GetModifierPhysicalArmorBonus()
    return self.bonus2[self:GetStackCount()]
end