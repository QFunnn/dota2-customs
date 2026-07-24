--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_9=class({})

function modifier_chen_9:IsHidden() return true end
function modifier_chen_9:IsPurgable() return false end
function modifier_chen_9:IsPurgeException() return false end
function modifier_chen_9:RemoveOnDeath() return false end

function modifier_chen_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local chen_creep_blink = self:GetCaster():FindAbilityByName("chen_creep_blink")
    if chen_creep_blink then
        chen_creep_blink:SetLevel(self:GetStackCount())
        chen_creep_blink:SetHidden(false)
    end
end

function modifier_chen_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chen_creep_blink = self:GetCaster():FindAbilityByName("chen_creep_blink")
    if chen_creep_blink then
        chen_creep_blink:SetLevel(self:GetStackCount())
        chen_creep_blink:SetHidden(false)
    end
end