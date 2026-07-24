--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_skeleton_king_5=class({})

function modifier_skeleton_king_5:IsHidden() return true end
function modifier_skeleton_king_5:IsPurgable() return false end
function modifier_skeleton_king_5:IsPurgeException() return false end
function modifier_skeleton_king_5:RemoveOnDeath() return false end

function modifier_skeleton_king_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetCaster():SwapAbilities("skeleton_king_reincarnation_custom", "skeleton_king_reincarnation_blink", false, true)
    local skeleton_king_reincarnation_blink = self:GetParent():FindAbilityByName("skeleton_king_reincarnation_blink")
    if skeleton_king_reincarnation_blink then
        skeleton_king_reincarnation_blink:SetLevel(self:GetStackCount())
    end
    local skeleton_king_reincarnation_custom = self:GetParent():FindAbilityByName("skeleton_king_reincarnation_custom")
    if skeleton_king_reincarnation_custom then
        skeleton_king_reincarnation_custom:SetActivated(false)
        skeleton_king_reincarnation_custom:SetHidden(true)
    end
end

function modifier_skeleton_king_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local skeleton_king_reincarnation_blink = self:GetParent():FindAbilityByName("skeleton_king_reincarnation_blink")
    if skeleton_king_reincarnation_blink then
        skeleton_king_reincarnation_blink:SetLevel(self:GetStackCount())
    end
end