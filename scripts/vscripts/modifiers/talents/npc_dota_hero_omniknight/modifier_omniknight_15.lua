--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_omniknight_15=class({})

function modifier_omniknight_15:IsHidden() return true end
function modifier_omniknight_15:IsPurgable() return false end
function modifier_omniknight_15:IsPurgeException() return false end
function modifier_omniknight_15:RemoveOnDeath() return false end

function modifier_omniknight_15:OnCreated()
	self.bonus={3,6}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_omniknight_15:OnRefresh()
	self.bonus={3,6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_omniknight_15:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
end

function modifier_omniknight_15:GetModifierConstantHealthRegen()
	return self.bonus[self:GetStackCount()]
end

function modifier_omniknight_15:GetModifierConstantManaRegen()
	return self.bonus[self:GetStackCount()]
end