--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_strength = class({})

local VALUES = {5, 10, 15}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_strength:IsHidden() return true end
function modifier_rune_strength:IsPurgable() return false end
function modifier_rune_strength:IsPurgeException() return false end
function modifier_rune_strength:RemoveOnDeath() return false end

function modifier_rune_strength:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.1)
end

function modifier_rune_strength:OnIntervalThink()
	if not IsServer() then return end
	self.Strength = 0
	self.Strength = self:GetParent():GetStrength() / 100 * GetValue(self)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_rune_strength:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_rune_strength:GetModifierBonusStats_Strength()
	return self.Strength
end