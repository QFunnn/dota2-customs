--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_8=class({})

function modifier_keeper_of_the_light_8:IsHidden() return true end
function modifier_keeper_of_the_light_8:IsPurgable() return false end
function modifier_keeper_of_the_light_8:IsPurgeException() return false end
function modifier_keeper_of_the_light_8:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_8:OnCreated()
	if not IsServer() then return end

    local keeper_of_the_light_illuminate_end_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_illuminate_end_custom")
    if keeper_of_the_light_illuminate_end_custom then
        keeper_of_the_light_illuminate_end_custom:OnSpellStart()
    end

	self:SetStackCount(1)

    local main_ability_name = "keeper_of_the_light_illuminate_custom"
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_7") then
        main_ability_name = "keeper_of_the_light_obscure"
    end

    local keeper_of_the_light_light_illusion = self:GetCaster():FindAbilityByName("keeper_of_the_light_light_illusion")
    if keeper_of_the_light_light_illusion then
        keeper_of_the_light_light_illusion:SetLevel(self:GetStackCount())
    end

    self:GetCaster():SwapAbilities(main_ability_name, "keeper_of_the_light_light_illusion", false, true)

    local keeper_of_the_light_illuminate_custom = self:GetCaster():FindAbilityByName(main_ability_name)
    if keeper_of_the_light_illuminate_custom then
        keeper_of_the_light_illuminate_custom:SetHidden(true)
        keeper_of_the_light_illuminate_custom:SetActivated(false)
    end
end

function modifier_keeper_of_the_light_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local keeper_of_the_light_light_illusion = self:GetCaster():FindAbilityByName("keeper_of_the_light_light_illusion")
    if keeper_of_the_light_light_illusion then
        keeper_of_the_light_light_illusion:SetLevel(self:GetStackCount())
    end
end