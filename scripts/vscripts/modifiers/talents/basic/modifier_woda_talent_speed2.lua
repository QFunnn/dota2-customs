--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_speed2=class({})

function modifier_woda_talent_speed2:IsHidden() return true end
function modifier_woda_talent_speed2:IsPurgable() return false end
function modifier_woda_talent_speed2:IsPurgeException() return false end
function modifier_woda_talent_speed2:RemoveOnDeath() return false end

function modifier_woda_talent_speed2:OnCreated()
	self.bonus={7,14,21}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_speed2:OnRefresh()
	self.bonus={7,14,21}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_speed2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_woda_talent_speed2:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus[self:GetStackCount()]
end