--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spectre_19=class({})

function modifier_spectre_19:IsHidden() return true end
function modifier_spectre_19:IsPurgable() return false end
function modifier_spectre_19:IsPurgeException() return false end
function modifier_spectre_19:RemoveOnDeath() return false end

function modifier_spectre_19:OnCreated()
	if not IsServer() then return end
	self.bonus={300,600,900}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
	local spectre_haunt_custom = self:GetParent():FindAbilityByName("spectre_haunt_custom")
	if spectre_haunt_custom then
		spectre_haunt_custom:SetHidden(true)
	end
end

function modifier_spectre_19:OnRefresh()
	if not IsServer() then return end
	self.bonus={300,600,900}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_spectre_19:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_spectre_19:GetModifierManaBonus()
	return self.bonus[self:GetStackCount()]
end