--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tiny_7=class({})

function modifier_tiny_7:IsHidden() return true end
function modifier_tiny_7:IsPurgable() return false end
function modifier_tiny_7:IsPurgeException() return false end
function modifier_tiny_7:RemoveOnDeath() return false end

function modifier_tiny_7:OnCreated()
	self.bonus={15}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
    local tiny_tree_channel_custom = self:GetCaster():FindAbilityByName("tiny_tree_channel_custom")
    if tiny_tree_channel_custom then
        tiny_tree_channel_custom:SetHidden(false)
        tiny_tree_channel_custom:SetLevel(1)
    end
end

function modifier_tiny_7:OnRefresh()
	self.bonus={15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_tiny_7:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_tiny_7:GetModifierBonusStats_Strength()
	return self.bonus[self:GetStackCount()]
end