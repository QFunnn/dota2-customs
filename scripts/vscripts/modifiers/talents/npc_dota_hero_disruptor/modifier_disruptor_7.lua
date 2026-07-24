--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_disruptor_7=class({})

function modifier_disruptor_7:IsHidden() return true end
function modifier_disruptor_7:IsPurgable() return false end
function modifier_disruptor_7:IsPurgeException() return false end
function modifier_disruptor_7:RemoveOnDeath() return false end

function modifier_disruptor_7:OnCreated()
	self.bonus={45}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_disruptor_7:OnRefresh()
	self.bonus={45}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_disruptor_7:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_disruptor_7:GetModifierSpellAmplify_Percentage()
	return self.bonus[self:GetStackCount()]
end