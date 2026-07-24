--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_attackspeed1=class({})

function modifier_woda_talent_attackspeed1:IsHidden() return true end
function modifier_woda_talent_attackspeed1:IsPurgable() return false end
function modifier_woda_talent_attackspeed1:IsPurgeException() return false end
function modifier_woda_talent_attackspeed1:RemoveOnDeath() return false end

function modifier_woda_talent_attackspeed1:OnCreated()
	self.bonus={15,30,45}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_attackspeed1:OnRefresh()
	self.bonus={15,30,45}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_attackspeed1:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_woda_talent_attackspeed1:GetModifierAttackSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end