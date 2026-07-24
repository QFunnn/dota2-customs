--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_14=class({})

function modifier_tinker_14:IsHidden() return true end
function modifier_tinker_14:IsPurgable() return false end
function modifier_tinker_14:IsPurgeException() return false end
function modifier_tinker_14:RemoveOnDeath() return false end

function modifier_tinker_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local tinker_warp_grenade_custom = self:GetCaster():FindAbilityByName("tinker_warp_grenade_custom")
    if tinker_warp_grenade_custom then
        tinker_warp_grenade_custom:SetHidden(false)
        tinker_warp_grenade_custom:SetLevel(1)
    end
end

function modifier_tinker_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end