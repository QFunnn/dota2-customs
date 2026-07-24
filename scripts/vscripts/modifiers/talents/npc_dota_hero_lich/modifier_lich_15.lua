--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lich_15=class({})

function modifier_lich_15:IsHidden() return true end
function modifier_lich_15:IsPurgable() return false end
function modifier_lich_15:IsPurgeException() return false end
function modifier_lich_15:RemoveOnDeath() return false end

function modifier_lich_15:OnCreated()
    self.bonus={150,300}
    self.bonus2={3,6}
    self.bonus3={5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_lich_15:OnRefresh()
    self.bonus={150,300}
    self.bonus2={3,6}
    self.bonus3={5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_lich_15:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_lich_15:GetModifierManaBonus()
	return self.bonus[self:GetStackCount()]
end

function modifier_lich_15:GetModifierConstantManaRegen()
	return self.bonus2[self:GetStackCount()]
end

function modifier_lich_15:GetModifierMagicalResistanceBonus()
	return self.bonus3[self:GetStackCount()]
end