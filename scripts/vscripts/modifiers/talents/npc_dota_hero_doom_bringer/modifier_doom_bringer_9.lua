--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_doom_bringer_9=class({})

function modifier_doom_bringer_9:IsHidden() return true end
function modifier_doom_bringer_9:IsPurgable() return false end
function modifier_doom_bringer_9:IsPurgeException() return false end
function modifier_doom_bringer_9:RemoveOnDeath() return false end

function modifier_doom_bringer_9:OnCreated()
	self.bonus = {20,40}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_doom_bringer_9:OnRefresh()
	self.bonus = {20,40}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_doom_bringer_9:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_doom_bringer_9:GetModifierAttackSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end