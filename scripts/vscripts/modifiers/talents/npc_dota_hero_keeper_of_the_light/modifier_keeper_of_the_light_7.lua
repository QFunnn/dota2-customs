--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_7=class({})

function modifier_keeper_of_the_light_7:IsHidden() return true end
function modifier_keeper_of_the_light_7:IsPurgable() return false end
function modifier_keeper_of_the_light_7:IsPurgeException() return false end
function modifier_keeper_of_the_light_7:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_7:OnCreated()
	if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_keeper_of_the_light_8") then return end
    local keeper_of_the_light_illuminate_end_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_illuminate_end_custom")
    if keeper_of_the_light_illuminate_end_custom then
        keeper_of_the_light_illuminate_end_custom:OnSpellStart()
    end
	self:SetStackCount(1)
    local keeper_of_the_light_obscure = self:GetCaster():FindAbilityByName("keeper_of_the_light_obscure")
    if keeper_of_the_light_obscure then
        keeper_of_the_light_obscure:SetLevel(self:GetStackCount())
    end
    self:GetCaster():SwapAbilities("keeper_of_the_light_illuminate_custom", "keeper_of_the_light_obscure", false, true)
    local keeper_of_the_light_illuminate_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_illuminate_custom")
    if keeper_of_the_light_illuminate_custom then
        keeper_of_the_light_illuminate_custom:SetHidden(true)
        keeper_of_the_light_illuminate_custom:SetActivated(false)
    end
end

function modifier_keeper_of_the_light_7:OnRefresh()
	if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_keeper_of_the_light_8") then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local keeper_of_the_light_obscure = self:GetCaster():FindAbilityByName("keeper_of_the_light_obscure")
    if keeper_of_the_light_obscure then
        keeper_of_the_light_obscure:SetLevel(self:GetStackCount())
    end
end