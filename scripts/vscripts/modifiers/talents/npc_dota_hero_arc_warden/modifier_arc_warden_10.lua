--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_10=class({})

function modifier_arc_warden_10:IsHidden() return true end
function modifier_arc_warden_10:IsPurgable() return false end
function modifier_arc_warden_10:IsPurgeException() return false end
function modifier_arc_warden_10:RemoveOnDeath() return false end

function modifier_arc_warden_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local roshan_roshpit_custom = self:GetCaster():FindAbilityByName("roshan_roshpit_custom")
    if roshan_roshpit_custom then
        roshan_roshpit_custom:SetLevel(1)
        roshan_roshpit_custom:SetHidden(false)
    end
end

function modifier_arc_warden_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end