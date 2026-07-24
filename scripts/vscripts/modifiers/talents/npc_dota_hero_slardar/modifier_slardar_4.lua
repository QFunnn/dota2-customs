--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_slardar_4=class({})

function modifier_slardar_4:IsHidden() return true end
function modifier_slardar_4:IsPurgable() return false end
function modifier_slardar_4:IsPurgeException() return false end
function modifier_slardar_4:RemoveOnDeath() return false end

function modifier_slardar_4:OnCreated()
	self.bonus = {24,18,12}
	self.armor = 0
	self:StartIntervalThink(FrameTime())
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_slardar_4:OnRefresh()
	self.bonus = {24,18,12}
	self.armor = 0
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_slardar_4:OnIntervalThink()
	self.armor = self:GetCaster():GetStrength() / self.bonus[self:GetStackCount()]
end

function modifier_slardar_4:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_slardar_4:GetModifierPhysicalArmorBonus()
	return self.armor
end