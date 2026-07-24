--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_10=class({})

function modifier_sniper_10:IsHidden() return true end
function modifier_sniper_10:IsPurgable() return false end
function modifier_sniper_10:IsPurgeException() return false end
function modifier_sniper_10:RemoveOnDeath() return false end

function modifier_sniper_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("sniper_shrapnel_custom", "sniper_smoke_grenade", false, true)
    local sniper_smoke_grenade = self:GetCaster():FindAbilityByName("sniper_smoke_grenade")
    if sniper_smoke_grenade then
        sniper_smoke_grenade:SetLevel(self:GetStackCount())
        sniper_smoke_grenade:SetHidden(false)
    end
end

function modifier_sniper_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local sniper_smoke_grenade = self:GetCaster():FindAbilityByName("sniper_smoke_grenade")
    if sniper_smoke_grenade then
        sniper_smoke_grenade:SetLevel(self:GetStackCount())
        sniper_smoke_grenade:SetHidden(false)
    end
end