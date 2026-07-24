--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_luna_10=class({})

function modifier_luna_10:IsHidden() return true end
function modifier_luna_10:IsPurgable() return false end
function modifier_luna_10:IsPurgeException() return false end
function modifier_luna_10:RemoveOnDeath() return false end

function modifier_luna_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local luna_lunar_field = self:GetCaster():FindAbilityByName("luna_lunar_field")
    if luna_lunar_field then
        luna_lunar_field:SetLevel(1)
        luna_lunar_field:SetHidden(false)
    end
end

function modifier_luna_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local luna_lunar_field = self:GetCaster():FindAbilityByName("luna_lunar_field")
    if luna_lunar_field then
        luna_lunar_field:SetLevel(2)
        luna_lunar_field:SetHidden(false)
    end
end