--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_6=class({})

function modifier_keeper_of_the_light_6:IsHidden() return true end
function modifier_keeper_of_the_light_6:IsPurgable() return false end
function modifier_keeper_of_the_light_6:IsPurgeException() return false end
function modifier_keeper_of_the_light_6:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_6:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local keeper_of_the_light_blinding_dark = self:GetCaster():FindAbilityByName("keeper_of_the_light_blinding_dark")
    if keeper_of_the_light_blinding_dark then
        keeper_of_the_light_blinding_dark:SetLevel(self:GetStackCount())
    end
    self:GetCaster():SwapAbilities("keeper_of_the_light_blinding_light_custom", "keeper_of_the_light_blinding_dark", false, true)
    local keeper_of_the_light_blinding_light_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_blinding_light_custom")
    if keeper_of_the_light_blinding_light_custom then
        keeper_of_the_light_blinding_light_custom:SetHidden(true)
        keeper_of_the_light_blinding_light_custom:SetActivated(false)
    end
end

function modifier_keeper_of_the_light_6:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local keeper_of_the_light_blinding_dark = self:GetCaster():FindAbilityByName("keeper_of_the_light_blinding_dark")
    if keeper_of_the_light_blinding_dark then
        keeper_of_the_light_blinding_dark:SetLevel(self:GetStackCount())
    end
end