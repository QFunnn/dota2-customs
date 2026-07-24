--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rubick_2=class({})

function modifier_rubick_2:IsHidden() return true end
function modifier_rubick_2:IsPurgable() return false end
function modifier_rubick_2:IsPurgeException() return false end
function modifier_rubick_2:RemoveOnDeath() return false end

function modifier_rubick_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local rubick_spell_steal_custom = self:GetCaster():FindAbilityByName("rubick_spell_steal_custom")
    if rubick_spell_steal_custom then
        rubick_spell_steal_custom:SetHidden(true)
    end
    local rubick_fade_lightning_custom = self:GetCaster():FindAbilityByName("rubick_fade_lightning_custom")
    if rubick_fade_lightning_custom then
        rubick_fade_lightning_custom:SetLevel(self:GetStackCount())
        rubick_fade_lightning_custom:SetHidden(false)
    end
    local modifier_rubick_spell_steal_custom = self:GetParent():FindModifierByName("modifier_rubick_spell_steal_custom")
    if modifier_rubick_spell_steal_custom then
        modifier_rubick_spell_steal_custom:Destroy()
    end
    local modifier_rubick_spell_steal_custom_scepter = self:GetParent():FindModifierByName("modifier_rubick_spell_steal_custom_scepter")
    if modifier_rubick_spell_steal_custom_scepter then
        modifier_rubick_spell_steal_custom_scepter:Destroy()
    end
    local rubick_empty1 = self:GetParent():FindAbilityByName("rubick_empty1_custom")
    if rubick_empty1 then
        rubick_empty1:SetHidden(true)
    end
    local rubick_empty2 = self:GetParent():FindAbilityByName("rubick_empty2_custom")
    if rubick_empty2 then
        rubick_empty2:SetHidden(true)
    end
    self:GetCaster():SwapAbilities("rubick_empty1_custom", "rubick_fade_lightning_custom", false, true)
end

function modifier_rubick_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local rubick_fade_lightning_custom = self:GetCaster():FindAbilityByName("rubick_fade_lightning_custom")
    if rubick_fade_lightning_custom then
        rubick_fade_lightning_custom:SetLevel(self:GetStackCount())
    end
end