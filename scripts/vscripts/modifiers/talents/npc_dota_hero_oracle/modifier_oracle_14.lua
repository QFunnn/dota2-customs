--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_14=class({})

function modifier_oracle_14:IsHidden() return true end
function modifier_oracle_14:IsPurgable() return false end
function modifier_oracle_14:IsPurgeException() return false end
function modifier_oracle_14:RemoveOnDeath() return false end

function modifier_oracle_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local oracle_diviners_deck = self:GetParent():FindAbilityByName("oracle_diviners_deck")
    if oracle_diviners_deck then
        oracle_diviners_deck:SetHidden(false)
        oracle_diviners_deck:SetLevel(1)
    end
end

function modifier_oracle_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_oracle_14:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_oracle_14:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "oracle_diviners_deck" and data.ability_special_value == "enabled" then
        return 1
    end
end

function modifier_oracle_14:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "oracle_diviners_deck" and data.ability_special_value == "enabled" then
        return 1
    end
end