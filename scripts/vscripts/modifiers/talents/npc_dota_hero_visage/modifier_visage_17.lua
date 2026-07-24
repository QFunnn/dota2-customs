--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_17=class({})

function modifier_visage_17:IsHidden() return true end
function modifier_visage_17:IsPurgable() return false end
function modifier_visage_17:IsPurgeException() return false end
function modifier_visage_17:RemoveOnDeath() return false end

function modifier_visage_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_visage_10 = self:GetCaster():FindModifierByName("modifier_visage_10")
    if modifier_visage_10 then
        modifier_visage_10:CheckStoneHearts()
    end
end

function modifier_visage_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end