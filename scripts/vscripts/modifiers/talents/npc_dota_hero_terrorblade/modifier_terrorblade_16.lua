--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_16=class({})

function modifier_terrorblade_16:IsHidden() return true end
function modifier_terrorblade_16:IsPurgable() return false end
function modifier_terrorblade_16:IsPurgeException() return false end
function modifier_terrorblade_16:RemoveOnDeath() return false end

function modifier_terrorblade_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local terrorblade_demon_hunter = self:GetParent():FindAbilityByName("terrorblade_demon_hunter")
    if terrorblade_demon_hunter then
        terrorblade_demon_hunter:SetHidden(false)
        terrorblade_demon_hunter:SetLevel(1)
    end
    self:StartIntervalThink(5)
end

function modifier_terrorblade_16:OnIntervalThink()
    if not IsServer() then return end
    local terrorblade_demon_hunter = self:GetParent():FindAbilityByName("terrorblade_demon_hunter")
    if terrorblade_demon_hunter then
        terrorblade_demon_hunter:SetHidden(false)
        terrorblade_demon_hunter:SetLevel(1)
    end
end

function modifier_terrorblade_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end