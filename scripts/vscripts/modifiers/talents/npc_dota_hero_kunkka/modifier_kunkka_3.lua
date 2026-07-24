--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kunkka_3=class({})

function modifier_kunkka_3:IsHidden() return true end
function modifier_kunkka_3:IsPurgable() return false end
function modifier_kunkka_3:IsPurgeException() return false end
function modifier_kunkka_3:RemoveOnDeath() return false end

function modifier_kunkka_3:OnCreated()
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_kunkka_x_marks_the_spot_custom_buff")
	local kunkka_x_marks_the_spot_custom = self:GetParent():FindAbilityByName("kunkka_x_marks_the_spot_custom")
	if kunkka_x_marks_the_spot_custom then
		kunkka_x_marks_the_spot_custom:SetHidden(true)
		kunkka_x_marks_the_spot_custom:SetActivated(false)
	end

	self:SetStackCount(1)
end

function modifier_kunkka_3:OnRefresh()
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_kunkka_x_marks_the_spot_custom_buff")
	local kunkka_x_marks_the_spot_custom = self:GetParent():FindAbilityByName("kunkka_x_marks_the_spot_custom")
	if kunkka_x_marks_the_spot_custom then
		kunkka_x_marks_the_spot_custom:SetHidden(true)
		kunkka_x_marks_the_spot_custom:SetActivated(false)
	end
	self:SetStackCount(self:GetStackCount() + 1)
end