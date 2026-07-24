--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_agility = class({})

local VALUES = {5, 10, 15}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_agility:IsHidden() return true end
function modifier_rune_agility:IsPurgable() return false end
function modifier_rune_agility:IsPurgeException() return false end
function modifier_rune_agility:RemoveOnDeath() return false end

function modifier_rune_agility:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.1)
end

function modifier_rune_agility:OnIntervalThink()
	if not IsServer() then return end
	self.Agility = 0
	self.Agility = self:GetParent():GetAgility() / 100 * GetValue(self)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_rune_agility:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_rune_agility:GetModifierBonusStats_Agility()
	return self.Agility
end