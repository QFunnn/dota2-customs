--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dragon_knight_20=class({})

function modifier_dragon_knight_20:IsHidden() return true end
function modifier_dragon_knight_20:IsPurgable() return false end
function modifier_dragon_knight_20:IsPurgeException() return false end
function modifier_dragon_knight_20:RemoveOnDeath() return false end

modifier_dragon_knight_20.damage_incoming_reduce = {-4,-8,-12}

function modifier_dragon_knight_20:OnCreated()
	self.bonus={4,8,12}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_dragon_knight_20:OnRefresh()
	self.bonus={4,8,12}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_dragon_knight_20:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_dragon_knight_20:GetModifierIncomingDamage_Percentage( params )
	if params.attacker:IsRangedAttacker() and params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self.damage_incoming_reduce[self:GetStackCount()]
	end
end

function modifier_dragon_knight_20:GetModifierBonusStats_Intellect()
	return self.bonus[self:GetStackCount()]
end