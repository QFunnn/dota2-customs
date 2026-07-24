--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_11=class({})

function modifier_chen_11:IsHidden() return true end
function modifier_chen_11:IsPurgable() return false end
function modifier_chen_11:IsPurgeException() return false end
function modifier_chen_11:RemoveOnDeath() return false end

function modifier_chen_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local chen_creep_manta_style = self:GetCaster():FindAbilityByName("chen_creep_manta_style")
    if chen_creep_manta_style then
        chen_creep_manta_style:SetLevel(self:GetStackCount())
        chen_creep_manta_style:SetHidden(false)
    end
end

function modifier_chen_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chen_creep_manta_style = self:GetCaster():FindAbilityByName("chen_creep_manta_style")
    if chen_creep_manta_style then
        chen_creep_manta_style:SetLevel(self:GetStackCount())
        chen_creep_manta_style:SetHidden(false)
    end
end