--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lich_21=class({})

function modifier_lich_21:IsHidden() return true end
function modifier_lich_21:IsPurgable() return false end
function modifier_lich_21:IsPurgeException() return false end
function modifier_lich_21:RemoveOnDeath() return false end

function modifier_lich_21:OnCreated()
	self.bonus = 80
    self.bonus2 = -45
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_lich_21:OnRefresh()
	self.bonus = 80
    self.bonus2 = -45
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_lich_21:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
	}
end

function modifier_lich_21:GetModifierSpellAmplify_Percentage()
	return self.bonus
end

function modifier_lich_21:GetModifierPercentageManacostStacking(params)
	return self.bonus2
end