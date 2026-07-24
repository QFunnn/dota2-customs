--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ursa_15=class({})

function modifier_ursa_15:IsHidden() return true end
function modifier_ursa_15:IsPurgable() return false end
function modifier_ursa_15:IsPurgeException() return false end
function modifier_ursa_15:RemoveOnDeath() return false end

function modifier_ursa_15:OnCreated()
    self.bonus = {10,20,30}
    self.bonus2 = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
    local ursa_fury_swipes_custom = self:GetCaster():FindAbilityByName("ursa_fury_swipes_custom")
    if ursa_fury_swipes_custom then
        ursa_fury_swipes_custom:SetHidden(true)
        ursa_fury_swipes_custom:SetLevel(0)
        local modifier_ursa_fury_swipes_custom = self:GetParent():FindModifierByName("modifier_ursa_fury_swipes_custom")
        if modifier_ursa_fury_swipes_custom then
            modifier_ursa_fury_swipes_custom:Destroy()
        end 
    end
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_ursa_15:OnRefresh()
    self.bonus = {10,20,30}
    self.bonus2 = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local ursa_fury_swipes_custom = self:GetCaster():FindAbilityByName("ursa_fury_swipes_custom")
    if ursa_fury_swipes_custom then
        ursa_fury_swipes_custom:SetHidden(true)
        ursa_fury_swipes_custom:SetLevel(0)
        local modifier_ursa_fury_swipes_custom = self:GetParent():FindModifierByName("modifier_ursa_fury_swipes_custom")
        if modifier_ursa_fury_swipes_custom then
            modifier_ursa_fury_swipes_custom:Destroy()
        end 
    end
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_ursa_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_ursa_15:GetModifierBonusStats_Intellect()
    return self.bonus[self:GetStackCount()]
end

function modifier_ursa_15:GetModifierAttackSpeedBonus_Constant()
    return self.bonus2[self:GetStackCount()]
end