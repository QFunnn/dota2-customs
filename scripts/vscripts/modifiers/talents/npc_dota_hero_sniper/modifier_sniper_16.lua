--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_16=class({})

function modifier_sniper_16:IsHidden() return true end
function modifier_sniper_16:IsPurgable() return false end
function modifier_sniper_16:IsPurgeException() return false end
function modifier_sniper_16:RemoveOnDeath() return false end

function modifier_sniper_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("sniper_take_aim_custom", "sniper_concussive_grenade_custom", false, true)
    local sniper_concussive_grenade_custom = self:GetCaster():FindAbilityByName("sniper_concussive_grenade_custom")
    if sniper_concussive_grenade_custom then
        sniper_concussive_grenade_custom:SetLevel(self:GetStackCount())
        sniper_concussive_grenade_custom:SetHidden(false)
    end
end

function modifier_sniper_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local sniper_concussive_grenade_custom = self:GetCaster():FindAbilityByName("sniper_concussive_grenade_custom")
    if sniper_concussive_grenade_custom then
        sniper_concussive_grenade_custom:SetLevel(self:GetStackCount())
        sniper_concussive_grenade_custom:SetHidden(false)
    end
end