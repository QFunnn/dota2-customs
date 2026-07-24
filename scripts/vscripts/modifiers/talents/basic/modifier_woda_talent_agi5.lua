--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_agi5=class({})

function modifier_woda_talent_agi5:IsHidden() return true end
function modifier_woda_talent_agi5:IsPurgable() return false end
function modifier_woda_talent_agi5:IsPurgeException() return false end
function modifier_woda_talent_agi5:RemoveOnDeath() return false end

function modifier_woda_talent_agi5:OnCreated()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_woda_talent_agi5:OnRefresh()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_agi5:OnIntervalThink()
	if not IsServer() then return end
	self.Agility = 0
	self.Agility = self:GetParent():GetAgility() / 100 * self.bonus[self:GetStackCount()]
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_agi5:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_woda_talent_agi5:GetModifierBonusStats_Agility()
	return self.Agility
end