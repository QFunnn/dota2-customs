--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dazzle_21=class({})

function modifier_dazzle_21:IsHidden() return true end
function modifier_dazzle_21:IsPurgable() return false end
function modifier_dazzle_21:IsPurgeException() return false end
function modifier_dazzle_21:RemoveOnDeath() return false end

function modifier_dazzle_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("dazzle_nothl_projection", "dazzle_bad_juju_custom", false, true)
    local dazzle_nothl_projection = self:GetCaster():FindAbilityByName("dazzle_nothl_projection")
    if dazzle_nothl_projection then
        dazzle_nothl_projection:SetHidden(true)
    end
    local dazzle_bad_juju_custom = self:GetCaster():FindAbilityByName("dazzle_bad_juju_custom")
    if dazzle_bad_juju_custom then
        dazzle_bad_juju_custom:SetHidden(false)
        dazzle_bad_juju_custom:SetLevel(1)
    end
end

function modifier_dazzle_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end