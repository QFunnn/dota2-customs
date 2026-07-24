--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_3=class({})

function modifier_sniper_3:IsHidden() return true end
function modifier_sniper_3:IsPurgable() return false end
function modifier_sniper_3:IsPurgeException() return false end
function modifier_sniper_3:RemoveOnDeath() return false end

function modifier_sniper_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("sniper_assassinate_custom", "sniper_molotov_grenade", false, true)
    local sniper_molotov_grenade = self:GetCaster():FindAbilityByName("sniper_molotov_grenade")
    if sniper_molotov_grenade then
        sniper_molotov_grenade:SetLevel(self:GetStackCount())
        sniper_molotov_grenade:SetHidden(false)
    end
end

function modifier_sniper_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local sniper_molotov_grenade = self:GetCaster():FindAbilityByName("sniper_molotov_grenade")
    if sniper_molotov_grenade then
        sniper_molotov_grenade:SetLevel(self:GetStackCount())
        sniper_molotov_grenade:SetHidden(false)
    end
end