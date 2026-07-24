--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_18=class({})

function modifier_medusa_18:IsHidden() return true end
function modifier_medusa_18:IsPurgable() return false end
function modifier_medusa_18:IsPurgeException() return false end
function modifier_medusa_18:RemoveOnDeath() return false end

function modifier_medusa_18:OnCreated()
    self.bonus = {50,100,150}
    self.bonus2={50,100,150}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_medusa_18:OnRefresh()
    self.bonus = {50,100,150}
    self.bonus2={50,100,150}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_18:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
	}
end

function modifier_medusa_18:GetModifierAttackRangeBonus()
    return self.bonus[self:GetStackCount()]
end

function modifier_medusa_18:GetModifierCastRangeBonusStacking()
    return self.bonus2[self:GetStackCount()]
end