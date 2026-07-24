--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_winter_wyvern_11=class({})

function modifier_winter_wyvern_11:IsHidden() return true end
function modifier_winter_wyvern_11:IsPurgable() return false end
function modifier_winter_wyvern_11:IsPurgeException() return false end
function modifier_winter_wyvern_11:RemoveOnDeath() return false end

function modifier_winter_wyvern_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local winter_wyvern_force_staff = self:GetParent():FindAbilityByName("winter_wyvern_force_staff")
    if winter_wyvern_force_staff then
        winter_wyvern_force_staff:SetLevel(1)
        winter_wyvern_force_staff:SetHidden(false)
    end
end

function modifier_winter_wyvern_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end