--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_crystal_maiden_17=class({})

function modifier_crystal_maiden_17:IsHidden() return true end
function modifier_crystal_maiden_17:IsPurgable() return false end
function modifier_crystal_maiden_17:IsPurgeException() return false end
function modifier_crystal_maiden_17:RemoveOnDeath() return false end

function modifier_crystal_maiden_17:OnCreated()
    self.bonus = {15,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_crystal_maiden_17:OnRefresh()
    self.bonus = {15,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_crystal_maiden_17:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    }
end

function modifier_crystal_maiden_17:GetModifierConstantHealthRegen()
    return self:GetCaster():GetManaRegen() / 100 * self.bonus[self:GetStackCount()]
end