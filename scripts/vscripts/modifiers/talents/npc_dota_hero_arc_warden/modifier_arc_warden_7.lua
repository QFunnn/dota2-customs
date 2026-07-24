--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_7=class({})

function modifier_arc_warden_7:IsHidden() return true end
function modifier_arc_warden_7:IsPurgable() return false end
function modifier_arc_warden_7:IsPurgeException() return false end
function modifier_arc_warden_7:RemoveOnDeath() return false end

function modifier_arc_warden_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("roshan_throw_enemy", "roshan_roar_retribution_custom", false, true)
    local roshan_roar_retribution_custom = self:GetParent():FindAbilityByName("roshan_roar_retribution_custom")
    if roshan_roar_retribution_custom then
        roshan_roar_retribution_custom:SetLevel(1)
        roshan_roar_retribution_custom:SetHidden(false)
    end
end

function modifier_arc_warden_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end