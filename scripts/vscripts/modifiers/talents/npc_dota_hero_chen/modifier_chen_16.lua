--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_16=class({})

function modifier_chen_16:IsHidden() return true end
function modifier_chen_16:IsPurgable() return false end
function modifier_chen_16:IsPurgeException() return false end
function modifier_chen_16:RemoveOnDeath() return false end

function modifier_chen_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local chen_creep_purge = self:GetCaster():FindAbilityByName("chen_creep_purge")
    if chen_creep_purge then
        chen_creep_purge:SetLevel(self:GetStackCount())
        chen_creep_purge:SetHidden(false)
        self:GetCaster():SwapAbilities("chen_creep_blink", "chen_creep_purge", false, true)
    end
end

function modifier_chen_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chen_creep_purge = self:GetCaster():FindAbilityByName("chen_creep_purge")
    if chen_creep_purge then
        chen_creep_purge:SetLevel(self:GetStackCount())
        chen_creep_purge:SetHidden(false)
    end
end