--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_juggernaut_9=class({})

function modifier_juggernaut_9:IsHidden() return true end
function modifier_juggernaut_9:IsPurgable() return false end
function modifier_juggernaut_9:IsPurgeException() return false end
function modifier_juggernaut_9:RemoveOnDeath() return false end

function modifier_juggernaut_9:OnCreated()
	self.bonus = {10,40}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_juggernaut_9:OnRefresh()
	self.bonus = {10,40}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_juggernaut_9:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_juggernaut_9:GetModifierMoveSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end

function modifier_juggernaut_9:CheckState()
	return
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true
	}
end