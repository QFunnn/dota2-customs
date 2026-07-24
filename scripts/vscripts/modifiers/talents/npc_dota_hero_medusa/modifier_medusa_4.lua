--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_4=class({})

function modifier_medusa_4:IsHidden() return true end
function modifier_medusa_4:IsPurgable() return false end
function modifier_medusa_4:IsPurgeException() return false end
function modifier_medusa_4:RemoveOnDeath() return false end

function modifier_medusa_4:OnCreated()
    self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
    local medusa_mana_shield = self:GetCaster():FindAbilityByName("medusa_mana_shield")
    if medusa_mana_shield then
        medusa_mana_shield:SetHidden(true)
        medusa_mana_shield:SetLevel(0)
        self:GetParent():RemoveModifierByName("modifier_medusa_mana_shield")
        medusa_mana_shield:Destroy()
        self:GetParent():RemoveModifierByName("modifier_medusa_mana_shield")
    end
end

function modifier_medusa_4:OnRefresh()
    self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_4:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
    }
end

function modifier_medusa_4:GetModifierBaseAttack_BonusDamage()
    return self.bonus[self:GetStackCount()]
end