--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_razor_1=class({})

function modifier_razor_1:IsHidden() return true end
function modifier_razor_1:IsPurgable() return false end
function modifier_razor_1:IsPurgeException() return false end
function modifier_razor_1:RemoveOnDeath() return false end

function modifier_razor_1:OnCreated()
    self.bonus = {20,30,40}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
    local razor_static_link_custom = self:GetParent():FindAbilityByName("razor_static_link_custom")
    if razor_static_link_custom then
        razor_static_link_custom:SetActivated(false)
        razor_static_link_custom:SetHidden(true)
    end
end

function modifier_razor_1:OnRefresh()
    self.bonus = {20,30,40}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
end

function modifier_razor_1:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_razor_1:GetModifierPreAttack_BonusDamage()
    return self.bonus[self:GetStackCount()]
end

function modifier_razor_1:GetModifierAttackRangeBonus()
    return -325
end