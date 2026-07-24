--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ancient_apparition_12=class({})

function modifier_ancient_apparition_12:IsHidden() return true end
function modifier_ancient_apparition_12:IsPurgable() return false end
function modifier_ancient_apparition_12:IsPurgeException() return false end
function modifier_ancient_apparition_12:RemoveOnDeath() return false end

function modifier_ancient_apparition_12:OnCreated()
	self.bonusrange={60,120}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_ancient_apparition_12:OnRefresh()
	self.bonusrange={60,120}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_ancient_apparition_12:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
	}
end

function modifier_ancient_apparition_12:GetModifierAttackRangeBonus()
	return self.bonusrange[self:GetStackCount()]
end