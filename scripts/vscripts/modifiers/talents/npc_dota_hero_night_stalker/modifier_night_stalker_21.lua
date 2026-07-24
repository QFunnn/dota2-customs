--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_night_stalker_21=class({})

function modifier_night_stalker_21:IsHidden() return true end
function modifier_night_stalker_21:IsPurgable() return false end
function modifier_night_stalker_21:IsPurgeException() return false end
function modifier_night_stalker_21:RemoveOnDeath() return false end

function modifier_night_stalker_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():RemoveModifierByName("modifier_night_stalker_crippling_fear_custom")
    local night_stalker_crippling_fear_custom = self:GetCaster():FindAbilityByName("night_stalker_crippling_fear_custom")
    if night_stalker_crippling_fear_custom then
        night_stalker_crippling_fear_custom:StartPassive()
    end
end

function modifier_night_stalker_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end