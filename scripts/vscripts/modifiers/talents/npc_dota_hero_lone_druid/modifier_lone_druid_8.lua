--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lone_druid_8=class({})

function modifier_lone_druid_8:IsHidden() return false end
function modifier_lone_druid_8:IsPurgable() return false end
function modifier_lone_druid_8:IsPurgeException() return false end
function modifier_lone_druid_8:RemoveOnDeath() return false end

function modifier_lone_druid_8:OnCreated()
	self.bonus = {40,50,60}
	if not IsServer() then return end
	self:SetStackCount(1)
	self.bonus2 = {5,10,15}
	----------- Удаляем Spirit link
	local lone_druid_spirit_link_custom = self:GetParent():FindAbilityByName("lone_druid_spirit_link_custom")
	if lone_druid_spirit_link_custom then
		lone_druid_spirit_link_custom:SetLevel(0)
		lone_druid_spirit_link_custom:SetActivated(false)
		lone_druid_spirit_link_custom:SetHidden(true)
		self:GetParent():RemoveModifierByName("modifier_lone_druid_spirit_link_custom")
		self:GetParent():RemoveModifierByName("modifier_lone_druid_spirit_link_custom_buff")
	end
end

function modifier_lone_druid_8:OnRefresh()
	self.bonus = {40,50,60}
	if not IsServer() then return end
	self.bonus2 = {5,10,15}
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_lone_druid_8:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL
	}
end

function modifier_lone_druid_8:GetModifierMoveSpeedBonus_Constant()
	if self.bonus == nil and self:GetStackCount() == 0 then return end
	return self.bonus[self:GetStackCount()]
end

function modifier_lone_druid_8:GetModifierProperty_PhysicalLifesteal(params)
    return self.bonus2[self:GetStackCount()]
end

function modifier_lone_druid_8:GetTexture() 
    return "lone_druid_8" 
end