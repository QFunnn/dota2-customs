--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rubick_7=class({})

function modifier_rubick_7:IsHidden() return true end
function modifier_rubick_7:IsPurgable() return false end
function modifier_rubick_7:IsPurgeException() return false end
function modifier_rubick_7:RemoveOnDeath() return false end

function modifier_rubick_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_rubick_spell_steal_custom = self:GetParent():FindModifierByName("modifier_rubick_spell_steal_custom")
    if modifier_rubick_spell_steal_custom then
        modifier_rubick_spell_steal_custom:Destroy()
    end
    local modifier_rubick_spell_steal_custom_scepter = self:GetParent():FindModifierByName("modifier_rubick_spell_steal_custom_scepter")
    if modifier_rubick_spell_steal_custom_scepter then
        modifier_rubick_spell_steal_custom_scepter:Destroy()
    end
    self:GetCaster():SwapAbilities("rubick_spell_steal_custom", "rubick_flash_bolt_custom", false, true)
    local rubick_flash_bolt_custom = self:GetCaster():FindAbilityByName("rubick_flash_bolt_custom")
    if rubick_flash_bolt_custom then
        rubick_flash_bolt_custom:SetLevel(1)
    end
    local rubick_empty1 = self:GetParent():FindAbilityByName("rubick_empty1_custom")
    if rubick_empty1 then
        rubick_empty1:SetHidden(true)
    end
    local rubick_empty2 = self:GetParent():FindAbilityByName("rubick_empty2_custom")
    if rubick_empty2 then
        rubick_empty2:SetHidden(true)
    end
end

function modifier_rubick_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end