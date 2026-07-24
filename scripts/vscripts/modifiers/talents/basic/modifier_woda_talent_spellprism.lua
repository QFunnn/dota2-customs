--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_spellprism=class({})

function modifier_woda_talent_spellprism:IsHidden() return true end
function modifier_woda_talent_spellprism:IsPurgable() return false end
function modifier_woda_talent_spellprism:IsPurgeException() return false end
function modifier_woda_talent_spellprism:RemoveOnDeath() return false end

function modifier_woda_talent_spellprism:OnCreated()
	self.bonus={7,14,21}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_spellprism:OnRefresh()
	self.bonus={7,14,21}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_spellprism:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
	}
end

function modifier_woda_talent_spellprism:GetModifierPercentageCooldown()
	return self.bonus[self:GetStackCount()]
end