--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lone_druid_10=class({})

function modifier_lone_druid_10:IsHidden() return false end
function modifier_lone_druid_10:IsPurgable() return false end
function modifier_lone_druid_10:IsPurgeException() return false end
function modifier_lone_druid_10:RemoveOnDeath() return false end

function modifier_lone_druid_10:OnCreated()
	self.bonus1 = {2,4,6}
	self.bonus2 = {200,300,400}
	self.bonus3 = {6,9,12}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)

	local lone_druid_true_form_custom = self:GetParent():FindAbilityByName("lone_druid_true_form_custom")
	if lone_druid_true_form_custom then
		lone_druid_true_form_custom:SetLevel(0)
		lone_druid_true_form_custom:SetActivated(false)
		lone_druid_true_form_custom:SetHidden(true)
		self:GetParent():RemoveModifierByName("modifier_lone_druid_true_form_custom")
		self:GetParent():RemoveModifierByName("modifier_lone_druid_true_form_custom_cast")
	end
end

function modifier_lone_druid_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_lone_druid_10:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_lone_druid_10:GetModifierHealthBonus()
	if self.bonus2 == nil and self:GetStackCount() == 0 then return end
	return self.bonus2[self:GetStackCount()]
end

function modifier_lone_druid_10:GetModifierMagicalResistanceBonus()
	if self.bonus3 == nil and self:GetStackCount() == 0 then return end
	return self.bonus3[self:GetStackCount()]
end

function modifier_lone_druid_10:GetModifierPhysicalArmorBonus()
	if self.bonus1 == nil and self:GetStackCount() == 0 then return end
	return self.bonus1[self:GetStackCount()]
end

function modifier_lone_druid_10:GetTexture() return "lone_druid_10" end