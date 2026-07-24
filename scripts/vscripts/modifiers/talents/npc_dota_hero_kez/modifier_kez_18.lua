--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kez_18=class({})

function modifier_kez_18:IsHidden() return true end
function modifier_kez_18:IsPurgable() return false end
function modifier_kez_18:IsPurgeException() return false end
function modifier_kez_18:RemoveOnDeath() return false end

function modifier_kez_18:OnCreated()
    self.bonus = {8,16}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_kez_18:OnRefresh()
    self.bonus = {8,16}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_kez_18:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_kez_18:GetModifierSpellAmplify_Percentage()
    return self.bonus[self:GetStackCount()]
end