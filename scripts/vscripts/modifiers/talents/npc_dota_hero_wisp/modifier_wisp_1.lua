--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wisp_1=class({})

function modifier_wisp_1:IsHidden() return true end
function modifier_wisp_1:IsPurgable() return false end
function modifier_wisp_1:IsPurgeException() return false end
function modifier_wisp_1:RemoveOnDeath() return false end

function modifier_wisp_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
    if modifier_wisp_spirits_custom then
        modifier_wisp_spirits_custom:Destroy()
    end
    local wisp_spirits_custom = self:GetCaster():FindAbilityByName("wisp_spirits_custom")
    if wisp_spirits_custom then
        wisp_spirits_custom:SetHidden(true)
        wisp_spirits_custom:SetActivated(false)
    end
end

function modifier_wisp_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end