--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_4=class({})

function modifier_phoenix_4:IsHidden() return true end
function modifier_phoenix_4:IsPurgable() return false end
function modifier_phoenix_4:IsPurgeException() return false end
function modifier_phoenix_4:RemoveOnDeath() return false end

function modifier_phoenix_4:OnCreated()
    self.bonus = {30,60}
    self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_phoenix_4:OnRefresh()
    self.bonus = {30,60}
    self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_phoenix_4:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_phoenix_4:GetModifierSpellAmplify_Percentage()
    return self.bonus2[self:GetStackCount()]
end

function modifier_phoenix_4:GetModifierPercentageManacostStacking(params)
	return self.bonus[self:GetStackCount()]
end