--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_huskar_8=class({})

function modifier_huskar_8:IsHidden() return true end
function modifier_huskar_8:IsPurgable() return false end
function modifier_huskar_8:IsPurgeException() return false end
function modifier_huskar_8:RemoveOnDeath() return false end

function modifier_huskar_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local huskar_berserkers_blood_custom = self:GetParent():FindAbilityByName("huskar_berserkers_blood_custom")
    if huskar_berserkers_blood_custom then
        huskar_berserkers_blood_custom:SetLevel(0)
    end
    local modifier_huskar_berserkers_blood_custom = self:GetParent():FindModifierByName("modifier_huskar_berserkers_blood_custom")
    if modifier_huskar_berserkers_blood_custom then
        modifier_huskar_berserkers_blood_custom:Destroy()
    end
    local huskar_berserkers_blood_reverse_custom = self:GetParent():FindAbilityByName("huskar_berserkers_blood_reverse_custom")
    if huskar_berserkers_blood_reverse_custom then
        huskar_berserkers_blood_reverse_custom:SetLevel(self:GetStackCount())
    end
    self:GetParent():SwapAbilities("huskar_berserkers_blood_custom", "huskar_berserkers_blood_reverse_custom", false, true)
end

function modifier_huskar_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local huskar_berserkers_blood_reverse_custom = self:GetParent():FindAbilityByName("huskar_berserkers_blood_reverse_custom")
    if huskar_berserkers_blood_reverse_custom then
        huskar_berserkers_blood_reverse_custom:SetLevel(self:GetStackCount())
    end
end