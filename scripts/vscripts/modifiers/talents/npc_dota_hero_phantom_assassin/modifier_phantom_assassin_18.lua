--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phantom_assassin_18=class({})

function modifier_phantom_assassin_18:IsHidden() return true end
function modifier_phantom_assassin_18:IsPurgable() return false end
function modifier_phantom_assassin_18:IsPurgeException() return false end
function modifier_phantom_assassin_18:RemoveOnDeath() return false end

function modifier_phantom_assassin_18:OnCreated()
	self.bonus = {100,200}
	self.bonus2={0,0}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_phantom_assassin_18:OnRefresh()
	self.bonus = {100,200}
	self.bonus2={0,0}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_phantom_assassin_18:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_phantom_assassin_18:GetModifierCastRangeBonusStacking()
	return self.bonus[self:GetStackCount()]
end

function modifier_phantom_assassin_18:GetModifierBonusStats_Agility()
	return self.bonus2[self:GetStackCount()]
end