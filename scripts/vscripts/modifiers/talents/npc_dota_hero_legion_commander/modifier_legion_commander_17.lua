--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_legion_commander_17=class({})

function modifier_legion_commander_17:IsHidden() return true end
function modifier_legion_commander_17:IsPurgable() return false end
function modifier_legion_commander_17:IsPurgeException() return false end
function modifier_legion_commander_17:RemoveOnDeath() return false end

function modifier_legion_commander_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:SetHasCustomTransmitterData(true)
	self:StartIntervalThink(FrameTime())
end

function modifier_legion_commander_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_legion_commander_17:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_legion_commander_17:OnIntervalThink()
	if not IsServer() then return end
	local intellect = self:GetCaster():GetIntellect(false) / 10
	local bonus = {25,50}
	local add_hp_int = intellect * bonus[self:GetStackCount()]
	self.health = add_hp_int
	self:SendBuffRefreshToClients()
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_legion_commander_17:GetModifierHealthBonus()
	return self.health
end