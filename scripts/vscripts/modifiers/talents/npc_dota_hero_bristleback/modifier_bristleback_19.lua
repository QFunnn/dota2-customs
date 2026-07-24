--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bristleback_19=class({})

function modifier_bristleback_19:IsHidden() return true end
function modifier_bristleback_19:IsPurgable() return false end
function modifier_bristleback_19:IsPurgeException() return false end
function modifier_bristleback_19:RemoveOnDeath() return false end

function modifier_bristleback_19:OnCreated()
	self.bonus={10,20,30}
	self.bonus2={3,6,9}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_bristleback_19:OnRefresh()
	self.bonus={10,20,30}
	self.bonus2={3,6,9}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_bristleback_19:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_bristleback_19:GetModifierPercentageManacostStacking(params)
	return self.bonus[self:GetStackCount()]
end

function modifier_bristleback_19:GetModifierSpellAmplify_Percentage()
	return self.bonus2[self:GetStackCount()]
end