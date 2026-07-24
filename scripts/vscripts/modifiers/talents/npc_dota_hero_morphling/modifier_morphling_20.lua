--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_morphling_20=class({})

function modifier_morphling_20:IsHidden() return true end
function modifier_morphling_20:IsPurgable() return false end
function modifier_morphling_20:IsPurgeException() return false end
function modifier_morphling_20:RemoveOnDeath() return false end

function modifier_morphling_20:OnCreated()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_morphling_20:OnRefresh()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_morphling_20:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_morphling_20:GetModifierSpellAmplify_Percentage()
	return self.bonus[self:GetStackCount()]
end