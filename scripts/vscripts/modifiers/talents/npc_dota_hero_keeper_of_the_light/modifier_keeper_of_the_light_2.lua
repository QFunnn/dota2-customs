--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_2=class({})

function modifier_keeper_of_the_light_2:IsHidden() return true end
function modifier_keeper_of_the_light_2:IsPurgable() return false end
function modifier_keeper_of_the_light_2:IsPurgeException() return false end
function modifier_keeper_of_the_light_2:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local keeper_of_the_light_radiant_bind = self:GetCaster():FindAbilityByName("keeper_of_the_light_radiant_bind")
    local keeper_of_the_light_dark_form = self:GetCaster():FindAbilityByName("keeper_of_the_light_dark_form")
    if keeper_of_the_light_dark_form then
        keeper_of_the_light_dark_form:SetLevel(self:GetStackCount())
        if keeper_of_the_light_radiant_bind then
            local level_bind = self:GetStackCount()
            if self:GetParent():HasModifier("modifier_keeper_of_the_light_16") then
                level_bind = level_bind + 1
            end
            keeper_of_the_light_radiant_bind:SetLevel(level_bind)
        end
    end
    self:GetCaster():SwapAbilities("keeper_of_the_light_spirit_form_custom", "keeper_of_the_light_dark_form", false, true)
    local keeper_of_the_light_spirit_form_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_spirit_form_custom")
    if keeper_of_the_light_spirit_form_custom then
        keeper_of_the_light_spirit_form_custom:SetHidden(true)
        keeper_of_the_light_spirit_form_custom:SetActivated(false)
    end
    self:GetCaster():RemoveModifierByName("modifier_keeper_of_the_light_spirit_form_custom")
end

function modifier_keeper_of_the_light_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local keeper_of_the_light_radiant_bind = self:GetCaster():FindAbilityByName("keeper_of_the_light_radiant_bind")
    local keeper_of_the_light_dark_form = self:GetCaster():FindAbilityByName("keeper_of_the_light_dark_form")
    if keeper_of_the_light_dark_form then
        keeper_of_the_light_dark_form:SetLevel(self:GetStackCount())
        if keeper_of_the_light_radiant_bind then
            local level_bind = self:GetStackCount()
            if self:GetParent():HasModifier("modifier_keeper_of_the_light_16") then
                level_bind = level_bind + 1
            end
            keeper_of_the_light_radiant_bind:SetLevel(level_bind)
        end
    end
end