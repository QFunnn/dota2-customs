--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_riki_3=class({})

function modifier_riki_3:IsHidden() return true end
function modifier_riki_3:IsPurgable() return false end
function modifier_riki_3:IsPurgeException() return false end
function modifier_riki_3:RemoveOnDeath() return false end

function modifier_riki_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local riki_tricks_of_the_trade_custom = self:GetParent():FindAbilityByName("riki_tricks_of_the_trade_custom")
    if riki_tricks_of_the_trade_custom then
        riki_tricks_of_the_trade_custom:SetHidden(true)
        riki_tricks_of_the_trade_custom:SetActivated(false)
    end
    local riki_frontstab_custom = self:GetParent():FindAbilityByName("riki_frontstab_custom")
    if riki_frontstab_custom then
        riki_frontstab_custom:SetHidden(false)
        riki_frontstab_custom:SetLevel(self:GetStackCount())
    end
end

function modifier_riki_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local riki_frontstab_custom = self:GetParent():FindAbilityByName("riki_frontstab_custom")
    if riki_frontstab_custom then
        riki_frontstab_custom:SetHidden(false)
        riki_frontstab_custom:SetLevel(self:GetStackCount())
    end
end