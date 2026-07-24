--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phantom_assassin_4=class({})

function modifier_phantom_assassin_4:IsHidden() return true end
function modifier_phantom_assassin_4:IsPurgable() return false end
function modifier_phantom_assassin_4:IsPurgeException() return false end
function modifier_phantom_assassin_4:RemoveOnDeath() return false end

function modifier_phantom_assassin_4:OnCreated()
	if not IsServer() then return end
	self.bonus={8,16}
	self:SetStackCount(1)
	local phantom_assassin_blur_custom = self:GetParent():FindAbilityByName("phantom_assassin_blur_custom")
	if phantom_assassin_blur_custom then
		phantom_assassin_blur_custom:SetHidden(true)
		phantom_assassin_blur_custom:SetLevel(0)
	end
    self:GetParent():CalculateStatBonus(true)
end

function modifier_phantom_assassin_4:OnRefresh()
	if not IsServer() then return end
	self.bonus={8,16}
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_phantom_assassin_4:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_phantom_assassin_4:GetModifierBonusStats_Strength()
	return self.bonus[self:GetStackCount()]
end