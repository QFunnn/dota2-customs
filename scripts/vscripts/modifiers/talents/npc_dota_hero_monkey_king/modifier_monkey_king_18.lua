--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_monkey_king_18=class({})

function modifier_monkey_king_18:IsHidden() return true end
function modifier_monkey_king_18:IsPurgable() return false end
function modifier_monkey_king_18:IsPurgeException() return false end
function modifier_monkey_king_18:RemoveOnDeath() return false end

function modifier_monkey_king_18:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():RemoveModifierByName("modifier_monkey_king_jingu_mastery_custom_buff")
    self:GetCaster():SwapAbilities("monkey_king_jingu_mastery_custom", "monkey_king_jingu_magic_custom", false, true)
    local monkey_king_jingu_magic_custom = self:GetCaster():FindAbilityByName("monkey_king_jingu_magic_custom")
    if monkey_king_jingu_magic_custom then
        monkey_king_jingu_magic_custom:SetLevel(self:GetStackCount())
    end
end

function modifier_monkey_king_18:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local monkey_king_jingu_magic_custom = self:GetCaster():FindAbilityByName("monkey_king_jingu_magic_custom")
    if monkey_king_jingu_magic_custom then
        monkey_king_jingu_magic_custom:SetLevel(self:GetStackCount())
    end
end