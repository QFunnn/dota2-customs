--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_riki_4=class({})

function modifier_riki_4:IsHidden() return true end
function modifier_riki_4:IsPurgable() return false end
function modifier_riki_4:IsPurgeException() return false end
function modifier_riki_4:RemoveOnDeath() return false end

function modifier_riki_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local riki_backstab_custom = self:GetParent():FindAbilityByName("riki_backstab_custom")
    if riki_backstab_custom then
        riki_backstab_custom:SetHidden(true)
    end
end

function modifier_riki_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local riki_backstab_custom = self:GetParent():FindAbilityByName("riki_backstab_custom")
    if riki_backstab_custom then
        riki_backstab_custom:SetHidden(true)
    end
end