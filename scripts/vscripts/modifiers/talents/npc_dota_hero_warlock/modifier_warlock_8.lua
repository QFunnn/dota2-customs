--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_warlock_8=class({})

function modifier_warlock_8:IsHidden() return true end
function modifier_warlock_8:IsPurgable() return false end
function modifier_warlock_8:IsPurgeException() return false end
function modifier_warlock_8:RemoveOnDeath() return false end

function modifier_warlock_8:OnCreated()
    self.bonus2={1}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("warlock_fatal_bonds_custom", "warlock_self_immolation_custom", false, true)
    local warlock_fatal_bonds_custom = self:GetCaster():FindAbilityByName("warlock_fatal_bonds_custom")
    if warlock_fatal_bonds_custom then
        warlock_fatal_bonds_custom:SetHidden(true)
        warlock_fatal_bonds_custom:SetLevel(0)
        warlock_fatal_bonds_custom:SetActivated(false)
    end
    local warlock_shadow_word_custom = self:GetCaster():FindAbilityByName("warlock_shadow_word_custom")
    if warlock_shadow_word_custom then
        warlock_shadow_word_custom:SetHidden(true)
        warlock_shadow_word_custom:SetLevel(0)
        warlock_shadow_word_custom:SetActivated(false)
    end
    local warlock_upheaval_custom = self:GetCaster():FindAbilityByName("warlock_upheaval_custom")
    if warlock_upheaval_custom then
        warlock_upheaval_custom:SetHidden(true)
        warlock_upheaval_custom:SetLevel(0)
        warlock_upheaval_custom:SetActivated(false)
    end
    local warlock_self_immolation_custom = self:GetCaster():FindAbilityByName("warlock_self_immolation_custom")
    if warlock_self_immolation_custom then
        Timers:CreateTimer(FrameTime(), function()
            warlock_self_immolation_custom:SetLevel(self:GetStackCount())
        end)
        warlock_self_immolation_custom:SetHidden(false)
    end
    self.attack_range = -(self:GetCaster():Script_GetAttackRange() - 225)
    self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
end
function modifier_warlock_8:OnRefresh()
    self.bonus2={1}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end
function modifier_warlock_8:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
    }
end

function modifier_warlock_8:GetModifierBaseAttackTimeConstant()
    return 1.6
end

function modifier_warlock_8:GetAttackSound()
    return "Hero_WarlockGolem.Attack"
end

function modifier_warlock_8:GetModifierAttackRangeBonus()
    return self.attack_range
end

function modifier_warlock_8:GetModifierHealthRegenPercentage()
    return self.bonus2[self:GetStackCount()]
end