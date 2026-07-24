--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_techies_21=class({})

function modifier_techies_21:IsHidden() return true end
function modifier_techies_21:IsPurgable() return false end
function modifier_techies_21:IsPurgeException() return false end
function modifier_techies_21:RemoveOnDeath() return false end

function modifier_techies_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local techies_minefield_sign_custom = self:GetCaster():FindAbilityByName("techies_minefield_sign_custom")
    if techies_minefield_sign_custom then
        techies_minefield_sign_custom:SetHidden(false)
        techies_minefield_sign_custom:SetLevel(1)
    end
end

function modifier_techies_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end