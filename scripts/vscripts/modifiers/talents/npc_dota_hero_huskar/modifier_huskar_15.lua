--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_huskar_15=class({})

function modifier_huskar_15:IsHidden() return true end
function modifier_huskar_15:IsPurgable() return false end
function modifier_huskar_15:IsPurgeException() return false end
function modifier_huskar_15:RemoveOnDeath() return false end

function modifier_huskar_15:OnCreated()
    self.bonus = {0,6}
	if not IsServer() then return end
	self:SetStackCount(1)
    local huskar_blood_magic_custom = self:GetCaster():FindAbilityByName("huskar_blood_magic_custom")
    if huskar_blood_magic_custom then
        self:GetCaster():RemoveAbility("huskar_blood_magic_custom")
    end
    local huskar_blood_magic = self:GetCaster():FindAbilityByName("huskar_blood_magic")
    if huskar_blood_magic then
        self:GetCaster():RemoveAbility("huskar_blood_magic")
    end
    local modifier_huskar_blood_magic = self:GetCaster():FindModifierByName("modifier_huskar_blood_magic")
    if modifier_huskar_blood_magic then
        modifier_huskar_blood_magic:Destroy()
    end
    local modifier_huskar_blood_magic_custom = self:GetCaster():FindModifierByName("modifier_huskar_blood_magic_custom")
    if modifier_huskar_blood_magic_custom then
        modifier_huskar_blood_magic_custom:Destroy()
    end
    self:GetParent():SetMana(self:GetParent():GetMaxMana())
end

function modifier_huskar_15:OnRefresh()
    self.bonus = {0,6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_huskar_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
end

function modifier_huskar_15:GetModifierConstantManaRegen()
    return self.bonus[self:GetStackCount()]
end