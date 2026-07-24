--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_13=class({})

function modifier_oracle_13:IsHidden() return true end
function modifier_oracle_13:IsPurgable() return false end
function modifier_oracle_13:IsPurgeException() return false end
function modifier_oracle_13:RemoveOnDeath() return false end

function modifier_oracle_13:OnCreated()
	self.bonus={6,12,18}
	if not IsServer() then return end
	self:SetStackCount(1)
	local oracle_purifying_flames_custom = self:GetCaster():FindAbilityByName("oracle_purifying_flames_custom")
	if oracle_purifying_flames_custom then
		oracle_purifying_flames_custom:SetHidden(true)
	end
end

function modifier_oracle_13:OnRefresh()
	self.bonus={6,12,18}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_oracle_13:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MAGICAL_LIFESTEAL,
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL
	}
end

function modifier_oracle_13:GetModifierProperty_PhysicalLifesteal()
    return self.bonus[self:GetStackCount()]
end

function modifier_oracle_13:GetModifierProperty_MagicalLifesteal()
    return self.bonus[self:GetStackCount()]
end