--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_2=class({})

function modifier_oracle_2:IsHidden() return true end
function modifier_oracle_2:IsPurgable() return false end
function modifier_oracle_2:IsPurgeException() return false end
function modifier_oracle_2:RemoveOnDeath() return false end

function modifier_oracle_2:OnCreated()
	self.hp_regen = 0
	self:SetStackCount(1)
	self:StartIntervalThink(FrameTime())
end

function modifier_oracle_2:OnRefresh()
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_oracle_2:OnIntervalThink()
	self.hp_regen = self:GetCaster():GetStrength() * 0.2
	if not IsServer() then return end
end

function modifier_oracle_2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_oracle_2:GetModifierConstantHealthRegen()
	return self.hp_regen
end