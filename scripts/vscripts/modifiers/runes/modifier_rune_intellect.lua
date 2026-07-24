--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_intellect = class({})

local VALUES = {5, 10, 15}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_intellect:IsHidden() return true end
function modifier_rune_intellect:IsPurgable() return false end
function modifier_rune_intellect:IsPurgeException() return false end
function modifier_rune_intellect:RemoveOnDeath() return false end

function modifier_rune_intellect:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.1)
end

function modifier_rune_intellect:OnIntervalThink()
	if not IsServer() then return end
	self.Intellect = 0
	self.Intellect = self:GetParent():GetIntellect(false) / 100 * GetValue(self)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_rune_intellect:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_rune_intellect:GetModifierBonusStats_Intellect()
	return self.Intellect
end