--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nevermore_5=class({})

function modifier_nevermore_5:IsHidden() return true end
function modifier_nevermore_5:IsPurgable() return false end
function modifier_nevermore_5:IsPurgeException() return false end
function modifier_nevermore_5:RemoveOnDeath() return false end

function modifier_nevermore_5:OnCreated()
	self.bonus = {-40,-35,-30}
	if not IsServer() then return end
	self:SetStackCount(1)
	if self:GetParent():HasAbility("nevermore_dark_lord_custom") then
		self:GetParent():RemoveModifierByName("modifier_nevermore_dark_lord_custom_aura")
		self:GetParent():RemoveAbility("nevermore_dark_lord_custom")
		self:GetParent():RemoveModifierByName("modifier_nevermore_dark_lord_custom_aura")
	end
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_nevermore_5:OnRefresh()
	self.bonus = {-40,-35,-30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_nevermore_5:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_nevermore_5:GetModifierSpellAmplify_Percentage()
	return self.bonus[self:GetStackCount()]
end