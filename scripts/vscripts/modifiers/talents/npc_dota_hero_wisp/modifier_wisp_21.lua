--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wisp_21=class({})

function modifier_wisp_21:IsHidden() return true end
function modifier_wisp_21:IsPurgable() return false end
function modifier_wisp_21:IsPurgeException() return false end
function modifier_wisp_21:RemoveOnDeath() return false end

function modifier_wisp_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local wisp_spirits_custom = self:GetCaster():FindAbilityByName("wisp_spirits_custom")
    local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
    if modifier_wisp_spirits_custom then
        modifier_wisp_spirits_custom:Destroy()
    end
    if self:GetCaster():HasModifier("modifier_wisp_1") then return end
    if self:GetCaster():HasModifier("modifier_wisp_10") then return end
    if wisp_spirits_custom and wisp_spirits_custom:GetLevel() > 0 then
        self:GetCaster():AddNewModifier(self:GetCaster(), wisp_spirits_custom, "modifier_wisp_spirits_custom", {})
    end
end

function modifier_wisp_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end