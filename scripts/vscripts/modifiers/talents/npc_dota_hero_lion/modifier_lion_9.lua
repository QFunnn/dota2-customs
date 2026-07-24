--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lion_9=class({})

function modifier_lion_9:IsHidden() return true end
function modifier_lion_9:IsPurgable() return false end
function modifier_lion_9:IsPurgeException() return false end
function modifier_lion_9:RemoveOnDeath() return false end

function modifier_lion_9:OnCreated()
    self.damage = {10,20,30}
    self.speed = {2.5,5,7.5}
	if not IsServer() then return end
    --self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	self:SetStackCount(1)
    local lion_mana_drain_custom = self:GetParent():FindAbilityByName("lion_mana_drain_custom")
    if lion_mana_drain_custom then
        lion_mana_drain_custom:SetHidden(true)
        lion_mana_drain_custom:SetActivated(false)
    end
    local lion_finger_of_death_custom = self:GetParent():FindAbilityByName("lion_finger_of_death_custom")
    if lion_finger_of_death_custom and lion_finger_of_death_custom:GetLevel() > 0 then
        if lion_finger_of_death_custom:GetAltCastState() then
            lion_finger_of_death_custom:ToggleAltCast()
            lion_finger_of_death_custom:SetAltCastState(false)
        end
        self:GetParent():AddNewModifier(self:GetParent(), lion_finger_of_death_custom, "modifier_lion_finger_punch", {})
    end
    self:GetParent():AddNewModifier(self:GetParent(), lion_finger_of_death_custom, "modifier_lion_finger_of_death_custom_zapret", {})
    self:StartIntervalThink(0.2)
    self:OnIntervalThink()
end

function modifier_lion_9:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():HasModifier("modifier_lion_finger_punch") then
        local lion_finger_of_death_custom = self:GetParent():FindAbilityByName("lion_finger_of_death_custom")
        if lion_finger_of_death_custom and lion_finger_of_death_custom:GetLevel() > 0 then
            self:GetParent():AddNewModifier(self:GetParent(), lion_finger_of_death_custom, "modifier_lion_finger_punch", {})
        end
    end
end

function modifier_lion_9:OnRefresh()
    self.damage = {10,20,30}
    self.speed = {2.5,5,7.5}
	if not IsServer() then return end
    --self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	self:SetStackCount(self:GetStackCount() + 1)
    local lion_mana_drain_custom = self:GetParent():FindAbilityByName("lion_mana_drain_custom")
    if lion_mana_drain_custom then
        lion_mana_drain_custom:SetHidden(true)
        lion_mana_drain_custom:SetActivated(false)
    end
end

function modifier_lion_9:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_lion_9:GetModifierMoveSpeedBonus_Percentage()
    return self.speed[self:GetStackCount()]
end

function modifier_lion_9:GetModifierPreAttack_BonusDamage()
    return self.damage[self:GetStackCount()]
end