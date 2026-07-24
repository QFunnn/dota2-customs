--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_15=class({})

function modifier_medusa_15:IsHidden() return true end
function modifier_medusa_15:IsPurgable() return false end
function modifier_medusa_15:IsPurgeException() return false end
function modifier_medusa_15:RemoveOnDeath() return false end

function modifier_medusa_15:OnCreated()
    self.bonus = {8,16}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_medusa_15:OnRefresh()
    self.bonus = {8,16}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
    }
end

function modifier_medusa_15:GetModifierProcAttack_Feedback( params )
    if not IsServer() then return end
    if params.target == nil then return end
    if self:GetParent().split_shot_attack then return end
    self:GetParent():GiveMana(self.bonus[self:GetStackCount()])
end