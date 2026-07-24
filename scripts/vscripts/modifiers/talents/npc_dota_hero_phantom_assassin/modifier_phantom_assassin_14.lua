--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phantom_assassin_14=class({})

function modifier_phantom_assassin_14:IsHidden() return true end
function modifier_phantom_assassin_14:IsPurgable() return false end
function modifier_phantom_assassin_14:IsPurgeException() return false end
function modifier_phantom_assassin_14:RemoveOnDeath() return false end

function modifier_phantom_assassin_14:OnCreated()
	if not IsServer() then return end
	self.bonus = 0
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_phantom_assassin_14:OnRefresh()
	if not IsServer() then return end
	self.bonus = 0
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_phantom_assassin_14:OnIntervalThink()
	if not IsServer() then return end
	local evasion = (self:GetCaster():GetEvasion() * 100)
	self.bonus = (evasion / 2) * 1
end

function modifier_phantom_assassin_14:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_phantom_assassin_14:GetModifierBonusStats_Agility()
	return self.bonus
end