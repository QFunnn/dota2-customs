--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_15=class({})

function modifier_chen_15:IsHidden() return true end
function modifier_chen_15:IsPurgable() return false end
function modifier_chen_15:IsPurgeException() return false end
function modifier_chen_15:RemoveOnDeath() return false end

function modifier_chen_15:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():SetModel("models/creeps/lane_creeps/creep_radiant_ranged/radiant_ranged.vmdl")
    self:GetParent():SetOriginalModel("models/creeps/lane_creeps/creep_radiant_ranged/radiant_ranged.vmdl")
    self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
    local chen_creep_shockwave = self:GetCaster():FindAbilityByName("chen_creep_shockwave")
    if chen_creep_shockwave then
        chen_creep_shockwave:SetLevel(self:GetStackCount())
        chen_creep_shockwave:SetHidden(false)
        self:GetCaster():SwapAbilities("chen_creep_mana_break", "chen_creep_shockwave", false, true)
    end
    local chen_creep_visual_ranged = self:GetParent():FindAbilityByName("chen_creep_visual_ranged")
    if chen_creep_visual_ranged then
        chen_creep_visual_ranged:SetLevel(1)
        chen_creep_visual_ranged:SetHidden(false)
    end
end

function modifier_chen_15:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chen_creep_shockwave = self:GetCaster():FindAbilityByName("chen_creep_shockwave")
    if chen_creep_shockwave then
        chen_creep_shockwave:SetLevel(self:GetStackCount())
        chen_creep_shockwave:SetHidden(false)
    end
end

function modifier_chen_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    }
end

function modifier_chen_15:GetModifierAttackRangeBonus()
    return 450
end