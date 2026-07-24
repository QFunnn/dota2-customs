--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_earthshaker_16=class({})

function modifier_earthshaker_16:IsHidden() return true end
function modifier_earthshaker_16:IsPurgable() return false end
function modifier_earthshaker_16:IsPurgeException() return false end
function modifier_earthshaker_16:RemoveOnDeath() return false end

function modifier_earthshaker_16:OnCreated()
	self.bonus={0.5,1}
	self.bonus2={6,12}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_earthshaker_16:OnRefresh()
	self.bonus={0.5,1}
	self.bonus2={6,12}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_earthshaker_16:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_earthshaker_16:GetModifierTotalPercentageManaRegen()
	return self.bonus[self:GetStackCount()]
end

function modifier_earthshaker_16:GetModifierSpellAmplify_Percentage()
	return self.bonus2[self:GetStackCount()]
end