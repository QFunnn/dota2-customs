--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_3=class({})
function modifier_keeper_of_the_light_3:IsHidden() return true end
function modifier_keeper_of_the_light_3:IsPurgable() return false end
function modifier_keeper_of_the_light_3:IsPurgeException() return false end
function modifier_keeper_of_the_light_3:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local keeper_of_the_light_dark_magic = self:GetCaster():FindAbilityByName("keeper_of_the_light_dark_magic")
    if keeper_of_the_light_dark_magic then
        keeper_of_the_light_dark_magic:SetLevel(self:GetStackCount())
    end
    self:GetCaster():SwapAbilities("keeper_of_the_light_chakra_magic_custom", "keeper_of_the_light_dark_magic", false, true)
    local keeper_of_the_light_chakra_magic_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_chakra_magic_custom")
    if keeper_of_the_light_chakra_magic_custom then
        keeper_of_the_light_chakra_magic_custom:SetHidden(true)
        keeper_of_the_light_chakra_magic_custom:SetActivated(false)
    end
end

function modifier_keeper_of_the_light_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local keeper_of_the_light_dark_magic = self:GetCaster():FindAbilityByName("keeper_of_the_light_dark_magic")
    if keeper_of_the_light_dark_magic then
        keeper_of_the_light_dark_magic:SetLevel(self:GetStackCount())
    end
end