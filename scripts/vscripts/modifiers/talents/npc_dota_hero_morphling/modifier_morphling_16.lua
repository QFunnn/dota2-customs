--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_morphling_16=class({})

function modifier_morphling_16:IsHidden() return true end
function modifier_morphling_16:IsPurgable() return false end
function modifier_morphling_16:IsPurgeException() return false end
function modifier_morphling_16:RemoveOnDeath() return false end

function modifier_morphling_16:OnCreated()
	self.bonus = 100
	self.amp = 0
	self:StartIntervalThink(FrameTime())
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_morphling_16:OnRefresh()
	self.bonus = 100
	self.amp = 0
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_morphling_16:OnIntervalThink()
	self.amp = self:GetCaster():GetMaxMana() / self.bonus
end

function modifier_morphling_16:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_morphling_16:GetModifierSpellAmplify_Percentage()
	return self.amp
end