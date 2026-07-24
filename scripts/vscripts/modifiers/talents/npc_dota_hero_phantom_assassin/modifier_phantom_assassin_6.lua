--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phantom_assassin_6=class({})

function modifier_phantom_assassin_6:IsHidden() return true end
function modifier_phantom_assassin_6:IsPurgable() return false end
function modifier_phantom_assassin_6:IsPurgeException() return false end
function modifier_phantom_assassin_6:RemoveOnDeath() return false end

function modifier_phantom_assassin_6:OnCreated()
	if not IsServer() then return end
	self.bonus={8,16}
	self:SetStackCount(1)
	local phantom_assassin_immaterial = self:GetParent():FindAbilityByName("phantom_assassin_immaterial")
	if phantom_assassin_immaterial then
		phantom_assassin_immaterial:SetHidden(true)
		phantom_assassin_immaterial:SetLevel(0)
	end
    self:GetParent():CalculateStatBonus(true)
    self:StartIntervalThink(1)
end

function modifier_phantom_assassin_6:OnIntervalThink()
    if not IsServer() then return end
    local phantom_assassin_immaterial = self:GetParent():FindAbilityByName("phantom_assassin_immaterial")
	if phantom_assassin_immaterial then
		phantom_assassin_immaterial:SetHidden(true)
		phantom_assassin_immaterial:SetLevel(0)
	end
    local modifier_phantom_assassin_immaterial = self:GetParent():FindModifierByName("modifier_phantom_assassin_immaterial")
    if modifier_phantom_assassin_immaterial then
        modifier_phantom_assassin_immaterial:Destroy()
    end
end

function modifier_phantom_assassin_6:OnRefresh()	
	if not IsServer() then return end
	self.bonus={8,16}
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_phantom_assassin_6:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_phantom_assassin_6:GetModifierBonusStats_Strength()
	return self.bonus[self:GetStackCount()]
end