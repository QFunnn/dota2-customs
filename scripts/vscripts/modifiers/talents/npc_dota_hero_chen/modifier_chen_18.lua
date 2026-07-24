--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_18=class({})

function modifier_chen_18:IsHidden() return true end
function modifier_chen_18:IsPurgable() return false end
function modifier_chen_18:IsPurgeException() return false end
function modifier_chen_18:RemoveOnDeath() return false end

function modifier_chen_18:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local chen_creep_petrify = self:GetCaster():FindAbilityByName("chen_creep_petrify")
    if chen_creep_petrify then
        chen_creep_petrify:SetLevel(self:GetStackCount())
        chen_creep_petrify:SetHidden(false)
        self:GetCaster():SwapAbilities("chen_creep_counterspell", "chen_creep_petrify", false, true)
    end
end

function modifier_chen_18:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chen_creep_petrify = self:GetCaster():FindAbilityByName("chen_creep_petrify")
    if chen_creep_petrify then
        chen_creep_petrify:SetLevel(self:GetStackCount())
        chen_creep_petrify:SetHidden(false)
    end
end