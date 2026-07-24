--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_crystal_maiden_7=class({})

function modifier_crystal_maiden_7:IsHidden() return true end
function modifier_crystal_maiden_7:IsPurgable() return false end
function modifier_crystal_maiden_7:IsPurgeException() return false end
function modifier_crystal_maiden_7:RemoveOnDeath() return false end

function modifier_crystal_maiden_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ability = self:GetParent():FindAbilityByName("crystal_maiden_freezing_field_custom")
	if ability then
		ability:EndCooldown()
	end
	local crystal_maiden_arcane_aura_custom = self:GetCaster():FindAbilityByName("crystal_maiden_arcane_aura_custom")
    if crystal_maiden_arcane_aura_custom then
        crystal_maiden_arcane_aura_custom:SetHidden(true)
    end
    local modifier_crystal_maiden_arcane_aura_custom_talent_shield = self:GetParent():FindModifierByName("modifier_crystal_maiden_arcane_aura_custom_talent_shield")
    if modifier_crystal_maiden_arcane_aura_custom_talent_shield then
        modifier_crystal_maiden_arcane_aura_custom_talent_shield:Destroy()
    end
end

function modifier_crystal_maiden_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local crystal_maiden_arcane_aura_custom = self:GetCaster():FindAbilityByName("crystal_maiden_arcane_aura_custom")
    if crystal_maiden_arcane_aura_custom then
        crystal_maiden_arcane_aura_custom:SetHidden(true)
    end
    local modifier_crystal_maiden_arcane_aura_custom_talent_shield = self:GetParent():FindModifierByName("modifier_crystal_maiden_arcane_aura_custom_talent_shield")
    if modifier_crystal_maiden_arcane_aura_custom_talent_shield then
        modifier_crystal_maiden_arcane_aura_custom_talent_shield:Destroy()
    end
end