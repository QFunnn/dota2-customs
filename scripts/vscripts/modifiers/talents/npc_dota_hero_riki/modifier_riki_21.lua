--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_riki_21=class({})

function modifier_riki_21:IsHidden() return true end
function modifier_riki_21:IsPurgable() return false end
function modifier_riki_21:IsPurgeException() return false end
function modifier_riki_21:RemoveOnDeath() return false end

function modifier_riki_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_riki_permanent_invisibility_custom = self:GetCaster():FindModifierByName("modifier_riki_permanent_invisibility_custom")
    if modifier_riki_permanent_invisibility_custom then
        modifier_riki_permanent_invisibility_custom:UpdateTalent()
    end
end

function modifier_riki_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local modifier_riki_permanent_invisibility_custom = self:GetCaster():FindModifierByName("modifier_riki_permanent_invisibility_custom")
    if modifier_riki_permanent_invisibility_custom then
        modifier_riki_permanent_invisibility_custom:UpdateTalent()
    end
end