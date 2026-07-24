--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kunkka_18=class({})

function modifier_kunkka_18:IsHidden() return true end
function modifier_kunkka_18:IsPurgable() return false end
function modifier_kunkka_18:IsPurgeException() return false end
function modifier_kunkka_18:RemoveOnDeath() return false end

function modifier_kunkka_18:OnCreated()
	self.bonus = {3,6,9}
    self.spell_amp = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_kunkka_18:OnRefresh()
	self.bonus = {3,6,9}
    self.spell_amp = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_kunkka_18:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_kunkka_18:GetModifierSpellAmplify_Percentage()
    return self.spell_amp[self:GetStackCount()]
end

function modifier_kunkka_18:GetModifierPhysicalArmorBonus()
	return self.bonus[self:GetStackCount()]
end