--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_16=class({})

function modifier_keeper_of_the_light_16:IsHidden() return true end
function modifier_keeper_of_the_light_16:IsPurgable() return false end
function modifier_keeper_of_the_light_16:IsPurgeException() return false end
function modifier_keeper_of_the_light_16:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_16:OnCreated()
    self.bonus = {0,5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
    local keeper_of_the_light_radiant_bind = self:GetCaster():FindAbilityByName("keeper_of_the_light_radiant_bind")
    if keeper_of_the_light_radiant_bind then
        keeper_of_the_light_radiant_bind:SetLevel(keeper_of_the_light_radiant_bind:GetLevel() + 1)
        keeper_of_the_light_radiant_bind:SetHidden(false)
        keeper_of_the_light_radiant_bind:SetActivated(true)
    end
end

function modifier_keeper_of_the_light_16:OnRefresh()
    self.bonus = {0,5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_keeper_of_the_light_16:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_keeper_of_the_light_16:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "keeper_of_the_light_radiant_bind" and data.ability_special_value == "magic_resistance" then
        return 1
    end
end

function modifier_keeper_of_the_light_16:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "keeper_of_the_light_radiant_bind" and data.ability_special_value == "magic_resistance" then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + self.bonus[self:GetStackCount()]
    end
end