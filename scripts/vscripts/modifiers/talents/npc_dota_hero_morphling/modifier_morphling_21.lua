--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_morphling_21=class({})

function modifier_morphling_21:IsHidden() return true end
function modifier_morphling_21:IsPurgable() return false end
function modifier_morphling_21:IsPurgeException() return false end
function modifier_morphling_21:RemoveOnDeath() return false end

function modifier_morphling_21:OnCreated()
	self.bonus = 2
	self.health = 0
	self.bonus2={50}
	self:StartIntervalThink(FrameTime())
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_morphling_21:OnRefresh()
	self.bonus = 2
	self.health = 0
	self.bonus2={50}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_morphling_21:OnIntervalThink()
	self.health = self:GetCaster():GetMaxMana() / self.bonus
	if not IsServer() then return end
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_morphling_21:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_morphling_21:GetModifierHealthBonus()
	return self.health
end

function modifier_morphling_21:GetModifierMoveSpeedBonus_Constant()
	return self.bonus2[self:GetStackCount()]
end