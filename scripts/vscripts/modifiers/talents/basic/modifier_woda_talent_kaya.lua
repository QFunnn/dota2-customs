--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_kaya=class({})

function modifier_woda_talent_kaya:IsHidden() return true end
function modifier_woda_talent_kaya:IsPurgable() return false end
function modifier_woda_talent_kaya:IsPurgeException() return false end
function modifier_woda_talent_kaya:RemoveOnDeath() return false end

function modifier_woda_talent_kaya:OnCreated()
	self.bonus={1}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_kaya:OnRefresh()
	self.bonus={1}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_kaya:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_woda_talent_kaya:GetModifierSpellAmplify_Percentage()
	local count = self:GetParent():GetIntellect(false) / 6
	count = math.min(count, 50)
	return self.bonus[self:GetStackCount()] * count
end