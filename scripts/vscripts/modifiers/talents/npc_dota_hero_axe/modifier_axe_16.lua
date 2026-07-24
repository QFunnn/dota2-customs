--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_16=class({})

function modifier_axe_16:IsHidden() return true end
function modifier_axe_16:IsPurgable() return false end
function modifier_axe_16:IsPurgeException() return false end
function modifier_axe_16:RemoveOnDeath() return false end

function modifier_axe_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local axe_counter_helix_custom = self:GetCaster():FindAbilityByName("axe_counter_helix_custom")
    if axe_counter_helix_custom then
        axe_counter_helix_custom:SetHidden(true)
        axe_counter_helix_custom:SetLevel(0)
    end
    local modifier_axe_counter_helix_custom = self:GetCaster():FindModifierByName("modifier_axe_counter_helix_custom")
    if modifier_axe_counter_helix_custom then
        modifier_axe_counter_helix_custom:Destroy()
    end
end

function modifier_axe_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_axe_16:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_axe_16:GetModifierPhysicalArmorBonus()
    local bonus = {3,6,9}
    return bonus[self:GetStackCount()]
end

function modifier_axe_16:GetModifierSpellAmplify_Percentage()
    local bonus = {0,0,0}
    return bonus[self:GetStackCount()]
end