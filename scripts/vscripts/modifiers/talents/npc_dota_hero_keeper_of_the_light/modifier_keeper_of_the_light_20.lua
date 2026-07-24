--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_20=class({})

function modifier_keeper_of_the_light_20:IsHidden() return true end
function modifier_keeper_of_the_light_20:IsPurgable() return false end
function modifier_keeper_of_the_light_20:IsPurgeException() return false end
function modifier_keeper_of_the_light_20:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_20:OnCreated()
    self.bonus = 10
	if not IsServer() then return end
	self:SetStackCount(1)
    local keeper_of_the_light_spirit_form_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_spirit_form_custom")
    if keeper_of_the_light_spirit_form_custom then
        self:GetParent():RemoveModifierByName("modifier_keeper_of_the_light_spirit_form_custom")
        self:GetParent():AddNewModifier(self:GetParent(), keeper_of_the_light_spirit_form_custom, "modifier_keeper_of_the_light_spirit_form_custom", {})
    end
end

function modifier_keeper_of_the_light_20:OnRefresh()
    self.bonus = 10
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_keeper_of_the_light_20:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_keeper_of_the_light_20:GetModifierMoveSpeedBonus_Percentage()
    return self.bonus
end