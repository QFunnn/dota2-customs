--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_19=class({})

function modifier_chen_19:IsHidden() return true end
function modifier_chen_19:IsPurgable() return false end
function modifier_chen_19:IsPurgeException() return false end
function modifier_chen_19:RemoveOnDeath() return false end

function modifier_chen_19:OnCreated()
    self.bonus = {150,300}
    self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_chen_19:OnRefresh()
    self.bonus = {150,300}
    self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chen_19:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    }
end

function modifier_chen_19:GetModifierAttackRangeBonus()
    return self.bonus[self:GetStackCount()]
end

function modifier_chen_19:GetModifierConstantHealthRegen()
    return self.bonus2[self:GetStackCount()]
end

function modifier_chen_19:GetModifierConstantManaRegen()
    return self.bonus2[self:GetStackCount()]
end