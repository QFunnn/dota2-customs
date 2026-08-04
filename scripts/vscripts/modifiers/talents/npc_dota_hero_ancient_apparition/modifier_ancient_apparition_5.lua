--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_ancient_apparition_5 = class({})

function modifier_ancient_apparition_5:IsHidden()
	return true
end
function modifier_ancient_apparition_5:IsPurgable()
	return false
end
function modifier_ancient_apparition_5:IsPurgeException()
	return false
end
function modifier_ancient_apparition_5:RemoveOnDeath()
	return false
end

function modifier_ancient_apparition_5:OnCreated()
	self.bonus = { 4, 8, 12 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_ancient_apparition_5:OnRefresh()
	self.bonus = { 4, 8, 12 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_ancient_apparition_5:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_ancient_apparition_5:GetModifierPhysicalArmorBonus()
	return self.bonus[self:GetStackCount()]
end